// Fold left to calculate total size of list of string
val list = List("frodo", "samwise", "pippin")
var total = list.foldLeft(0)((sum, value) => sum + value.size)

println(list)
println("Total characters: " + total)


// Replace curse words
trait Censor {
	def clean(toClean:String) : String = {
		val curseWords = Map("Shoot" -> "Pucky", "Darn" -> "Beans")
		var censored = curseWords.foldLeft(toClean)((text, curse) => text.replaceAll(curse._1, curse._2))
		return censored
	}
}

class Prettify extends Censor

val p = new Prettify
val cleaned = p.clean("Shoot! Darn, that hurts")
println(cleaned)

// Load curse words from file
// one pair on each line, curse word and replacment word separated by ;

trait CensorFromFile {
	def clean(toClean:String) : String = {
		val curseWords = scala.io.Source.fromFile("cursewords.txt")
			.getLines
			.map(line => line.split(";"))
			.map(words => words(0) -> words(1)) toMap
		
		var censored = curseWords.foldLeft(toClean)((text, curse) => text.replaceAll(curse._1, curse._2))
		return censored
	}
}

class PrettifyFromFile extends CensorFromFile
val pf = new PrettifyFromFile
val censored = pf.clean("Shoot! Darn, that hurts. Damn.")
println(censored)