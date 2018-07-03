import scala.io._
import scala.actors._
import Actor._
import scala.collection.mutable.ListBuffer

object PageLoader {
	def getContent(url : String) = 
	try {
      Source.fromURL(url).mkString
    } catch {
      case e: Exception => Unit
      ""
    }

	def getPageSizeAndLinks(url : String):(Int, List[String]) = {
		val content = getContent(url)
		val contentLength = content.length
		val links = "(?i)<a.+?href=\"(http.+?)\".*?>(.+?)</a>".r.findAllIn(content).matchData.toList.map(_.group(1))

		(contentLength, links)
	}
}

var urls = List(
	"http://www.cnn.com/",
	"http://www.amazon.com/",
	"http://www.varingen.no/",
	"http://www.aftenposten.no/")

def timeMethod(method: () => Unit) = {
	val start = System.nanoTime
	method()
	val end = System.nanoTime

	println("Method took " + (end - start)/1000000000.0 + " seconds.")
}

def getPageSizeSequentially() = {
	for(url <- urls) {
		val (size:Int, links:List[String]) = PageLoader.getPageSizeAndLinks(url)
		var linkSizes = new ListBuffer[Int]()
		for(link <- links) {
			val linkSize = PageLoader.getContent(link).length
			//println(link + " : " + linkSize)
			linkSizes += linkSize
		}

		//println(linkSizes)

		val totalSize = linkSizes.foldLeft(size)((sum, value) => sum + value)
		println("Size for " + url + ": " + size + ", number of links: " + links.length + ". TotalSize: " + totalSize)
	}
}

def getPageSizeConcurrently() = {
	val caller = self

	for(url <- urls) {
		actor {
			var linkActor = self

			var linkSizes = new ListBuffer[Int]()
			val (size, links:List[String]) = PageLoader.getPageSizeAndLinks(url)
			for(link <- links) {
				actor { linkActor ! PageLoader.getContent(link) }
			}

			for(i <- 1 to links.size) {
				receive {
					case (content:String) => linkSizes += content.length
				}
			}

			val totalSize = linkSizes.foldLeft(size)((sum, value) => sum + value)
			caller ! (url, size, links, totalSize)
		}
	}

	for(i <- 1 to urls.size) {
		receive {
			case (url, size, links:List[String], totalSize) =>
				println("Size for url " + url + ": " + size + ", number of links: " + links.length + ". TotalSize: " + totalSize)
		}
	}
}

println("Sequential run:")
timeMethod { getPageSizeSequentially }

println("Concurrent run")
timeMethod { getPageSizeConcurrently }