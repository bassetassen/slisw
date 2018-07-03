class Person(firstName:String) {
	println("Outer constructor")
	def this(firstName:String,lastName:String) {
		this(firstName)
		println("Inner constructor")
	}

	def talk() = println("talk is cheap")
}

var bob = new Person("Bob")
var bobTate = new Person("Bob", "Tate")