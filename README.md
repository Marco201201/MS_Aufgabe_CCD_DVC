# MS_Aufgabe_CCD_DVC

Ich habe ein Java TicTacToe nach den Prinzipien von Clean Code erstellt. 

Zuerst wollte ich mich eigentlich mit einem alten Bash Skript beschäftigten. Hier wurde der Code aber nicht wirklich "clean" aufgrund
dessen, dass es keine Rückgabewerte bei bash Funktionen gibt. Man kann dies mit globalen Variablen umgehen oder man packt die Ausgabe einer Funktion in eine Variable, aber dann kann man in einer Funktion nur eine Ausgabe haben. 
Insgesamt sind die Funktionen dadurch sehr speziell und nicht gut wieder verwendbar. Ich habe mich daher dazu entschieden ein Java TicTacToe zu machen, bei welchem ich nicht auf solche Sachen stoße. 



# Warum handelt es sich bei dem Java Tic Tac Toe um Clean Code?








Sachen zum Bash Skript:

Ich habe mich dazu entschieden ein altes Bash Skript aus meinem Bachelor zu überarbeiten und die Prinzipien von Code Clean anzuwenden. 

Hierbei habe ich die folgenden Schritte durchgeführt um einen sauberen Code zu erhalten.

| Was?        | Warum?           | 
| ------------- |:-------------:| 
| Verwendung von nur einer Sprache im Code/Kommentaren (Englisch) | Bruch der Sprachen kann zu verständnis Problemen führen und erschwert das Lesen des Codes  | 
|   Definierung von Funktionen mit dem Keyword "function"   | Funktionen können in Bash-Skripten zwar auch ohne definiert werden, mit dem Keyword sind diese aber schneller als solche erkennbar |      |  
| Boolean Werte werden mit true/false angeben und nicht mit 1 und 0  | 1 und 0 könnten auch für andere Dinge stehen |  
| Erstellung einer allgemeinen Beschreibung, was das Skript überhaupt macht |  Man muss sich nicht mehr den ganzen Code durchlesen, um das zu erkennen | 
| Verwendung von sprechenden Variablen- und Funktionsnamen | Verbesserung des Verständnis des Codes, leichtere Wartbarkeit |  
| Aufteilung von Funktionen, damit diese nur noch eine Aufgabe haben | Verbesserung des Verständnis des Codes, leichtere Wartbarkeit|
| Kommentierung von komplizierteren Funktionen, wie Regex | Verbesserung des Verständnis des Codes, leichtere Wartbarkeit |


