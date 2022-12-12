package main.java.ticTacToe;

import java.util.InputMismatchException;
import java.util.Scanner;

/**
 * Main Class of the TicTacToe Game
 * Contains the gameplay
 */
public class TicTacToe {
    public static void main(String[] args) {

        System.out.println("Willkommen zu Tic Tac Toe!");
        Board ticTacToeBoard = new Board();

        Player playerOne = new Player(
                getUserInputAsString("Bitte geben Sie den Namen für den Spieler ein, " +
                        "welcher die O's verwenden soll."),
                false,
                Player.Symbol.O
        );
        Player playerTwo = new Player(
                getUserInputAsString("Bitte geben Sie den Namen für den Spieler ein, " +
                        "welcher die X's verwenden soll."),
                true,
                Player.Symbol.X
        );

        // Endless loop until the game is finished
        while (!ticTacToeBoard.isGameFinished()) {
            ticTacToeBoard.printBoard();
            if (playerOne.isOnTheMove()) {
                gameMove(ticTacToeBoard, playerOne);
                gameMoveEvaluation(ticTacToeBoard, playerOne, playerTwo);

            } else {
                gameMove(ticTacToeBoard, playerTwo);
                gameMoveEvaluation(ticTacToeBoard, playerTwo, playerOne);
            }
            // Check if we have a victory
            if (playerOne.isVictory() || playerTwo.isVictory()) {
                gameEnd(playerOne, playerTwo);
                break;
            }
        }
        // Check if we have a draw
        if (!(playerOne.isVictory() || playerTwo.isVictory())) {
            gameEnd(playerOne, playerTwo);

        }

    }

    /** Function tries to make a game move
     * @param ticTacToeBoard Playing field on which the action is performed
     * @param player Player who makes the move
     */
    public static void gameMove(Board ticTacToeBoard, Player player) {
        try {
            ticTacToeBoard.setFIELD(
                    getUserInputAsInt(player.getName() + " geben Sie bitte ein Feld an!"),
                    player.getSymbol()
            );
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }

    /**
     * Function evaluates the game move
     * @param ticTacToeBoard Playing field on which the action is performed
     * @param player Player who makes the move
     * @param playerTwo Other Player
     */
    public static void gameMoveEvaluation(Board ticTacToeBoard, Player player, Player playerTwo) {
        if (ticTacToeBoard.isGameWon(player.getSymbol())) {
            player.setVictory(true);
        }
        player.setOnTheMove(false);
        playerTwo.setOnTheMove(true);
    }

    /**
     * Reading the user input as a string with a question
     * @param question Question asked to the user
     * @return User input
     */
    public static String getUserInputAsString(String question) {
        Scanner scanner = new Scanner(System.in);
        String userInput;
        try {
            System.out.println(question);
            userInput = scanner.next();
        } catch (Exception e) {
            System.out.println("Eingabefehler, versuchen Sie es noch einmal.");
            return getUserInputAsString(question);
        }
        return userInput;

    }
    /**
     * Reading the user input as a integer with a question
     * @param question Question asked to the user
     * @return User input
     */
    public static int getUserInputAsInt(String question) {
        Scanner scanner = new Scanner(System.in);
        int userInput;
        try {
            System.out.println(question);
            userInput = scanner.nextInt();
           // TicTacToe game consists of 9 fields
            if (!(userInput > 0 && userInput <= 9)) {
                System.out.println(
                        "Eingabefehler; Geben Sie eine Zahl im Bereich von 1 bis 9 ein:");
                return getUserInputAsInt(question);
            }
        } catch (InputMismatchException e) {
            System.out.println("Eingabefehler, versuchen Sie es noch einmal.");
            return getUserInputAsInt(question);
        }
        return userInput;

    }

    /**
     * Generates the output when the game is over. Win or draw
     * @param playerOne PlayerOne
     * @param playerTwo PlayerTwo
     */
    public static void gameEnd(Player playerOne, Player playerTwo) {
        System.out.println("Das Spiel ist zu Ende.");
        if (playerOne.isVictory()) {
            System.out.println(playerOne.getName() + " hat gewonnen.");
            System.out.println(playerTwo.getName() + " hat verloren.");
        } else if (playerTwo.isVictory()) {
            System.out.println(playerTwo.getName() + " hat gewonnen.");
            System.out.println(playerOne.getName() + " hat verloren.");
        } else {
            System.out.println("Unentschieden zwischen " + playerOne.getName() + " und " + playerTwo.getName());
        }

    }

}
