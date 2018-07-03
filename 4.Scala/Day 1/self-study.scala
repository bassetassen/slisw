class Game {
	val board = new Board()
	val playerX = "X"
	val playerO = "O"
	var currentPlayer = playerX
	

	def start() {
		println("New game started")
		board.status()
		turn()
	}

	def turn() {
		println("Player " + currentPlayer + " turn..")
		val ln = readLine()
		if(board.setMarker(ln.toInt, currentPlayer) == true) {
			if(board.isWinner(currentPlayer)) {
				println("Player " + currentPlayer + " has won! Congratz")
				board.status()
				return
			}

			if(currentPlayer == playerX) {
				currentPlayer = playerO
			}
			else {
				currentPlayer = playerX
			}
		}

		board.status()

		if(board.movePossible()) {
			turn()
		}
		else {
			println("Stupid players, it's a draw")
		}
	}
}

class Board {
	var cells = List(".", ".", ".", ".", ".", ".", ".", ".", ".")
	var winnerPossibilities = List(
		List(0,1,2),
		List(3,4,5),
		List(6,7,8),
		List(0,3,6),
		List(1,4,7),
		List(2,5,8),
		List(0,4,8),
		List(2,4,6))

	def setMarker(cell : Int, mark : String) : Boolean = {
		var success = false
		if(cell >= 0 && cell <= 8) {
			if(cells(cell) != ".") {
				println("Moron")
			}
			else {
				cells = cells.updated(cell, mark)
				success = true
			}
		}
		else {
			println("Number from 0 to 8")
		}

		return success
	}

	def status() {
		var counter = 1;
		
		for(i <- 0 until cells.length) {
			print(" ")

			if(counter % 3 == 0) {
				println(cells(i))
			}
			else {
				print(cells(i))
			}
			
			counter = counter + 1
		}
	}

	def movePossible() : Boolean = return cells.contains(".")
	def isWinner(player : String) : Boolean = {
		for(i <- 0 until winnerPossibilities.length) {
			if(cells(winnerPossibilities(i)(0)) == player && cells(winnerPossibilities(i)(0)) == cells(winnerPossibilities(i)(1)) && cells(winnerPossibilities(i)(1)) == cells(winnerPossibilities(i)(2))) {
				return true
			}
		}
		
		return false
	}
}

var game = new Game()
game.start()