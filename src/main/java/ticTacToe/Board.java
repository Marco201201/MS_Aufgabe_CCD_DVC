package main.java.ticTacToe;

import java.util.Arrays;
import java.util.InputMismatchException;

public class Board {
    private String[] fields;
    // TicTacToe game consists of 9 fields
    final int FIELDSCOUNT = 9;
    // There are 8 victory possibilities
    final int VICTORYPOSSIBILITIESCOUNT = 8;

    /**
     * onstructor of the Board class
     * Sets the default values for the fields
     */
    public Board() {
        fields = new String[FIELDSCOUNT];
        for (int field = 0; field < FIELDSCOUNT; field++) {
            this.fields[field] = String.valueOf(field + 1);
        }
    }

    /**
     * Prints the Board
     */
    public void printBoard() {
        String frame = "|---|---|---|";
        String dividingLine = "|-----------|";

        System.out.println(frame);
        System.out.println("| " + fields[0] + " | " + fields[1] + " | " + fields[2] + " |");
        System.out.println(dividingLine);
        System.out.println("| " + fields[3] + " | " + fields[4] + " | " + fields[5] + " |");
        System.out.println(dividingLine);
        System.out.println("| " + fields[6] + " | " + fields[7] + " | " + fields[8] + " |");
        System.out.println(frame);
    }


    /**
     * Sets the value in the selected field if it does not already contain a value
     * @param field  Target field
     * @param symbol Symbol of the player
     * @throws Exception Field must not be set yet
     */
    public void setFIELD(int field, Player.Symbol symbol) throws Exception {
        // Check if the field is already set
        if (fields[field - 1].equals(String.valueOf(field ))) {
            fields[field - 1] = symbol.toString();
        } else {
            throw new Exception("Das Feld ist bereits gesetzt!");
        }
    }

    /**
     * Checks if the game is won by a player
     * @param symbol Symbol of the player
     * @return Whether the game is won
     */
    public boolean isGameWon(Player.Symbol symbol) {
        // Loop through all victory possibilities
        for (int victoryPossibilitie = 0; victoryPossibilitie < VICTORYPOSSIBILITIESCOUNT; victoryPossibilitie++) {
            String line = null;
            switch (victoryPossibilitie) {
                case 0:
                    // First row
                    line = fields[0] + fields[1] + fields[2];
                    break;
                case 1:
                    // Second row
                    line = fields[3] + fields[4] + fields[5];
                    break;
                case 2:
                    // Third row
                    line = fields[6] + fields[7] + fields[8];
                    break;
                case 3:
                    // First column
                    line = fields[0] + fields[3] + fields[6];
                    break;
                case 4:
                    // Second column
                    line = fields[1] + fields[4] + fields[7];
                    break;
                case 5:
                    // Third column
                    line = fields[2] + fields[5] + fields[8];
                    break;
                case 6:
                    // Diagonal top left to bottom right
                    line = fields[0] + fields[4] + fields[8];
                    break;
                case 7:
                    // Diagonal bottom left to top right
                    line = fields[2] + fields[4] + fields[6];
                    break;
            }
            // check if the line match 3 Symbols
            if (line.equals(symbol.toString() + symbol.toString() + symbol.toString())) {
                return true;
            }
        }
        return false;
    }

    /**
     * Checks if all moves have been played
     * @return Whether the game is finished
     */
    public boolean isGameFinished() {
        //Loop through the fields
        for (int field = 0; field < FIELDSCOUNT; field++) {
            // As soon as a number is present, at least one more move can be made
            if (Arrays.asList(fields).contains(
                    String.valueOf(field + 1))) {
                return false;
            } else if (field == 8) {
                return true;
            }
        }
        return false;
    }


}
