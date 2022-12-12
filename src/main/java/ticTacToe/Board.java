package main.java.ticTacToe;

import java.util.Arrays;

public class Board {
    private final String[] fields;
    // TicTacToe game consists of 9 fields
    final int FIELDSCOUNT = 9;
    // There are 8 victory possibilities
    final int VICTORYPOSSIBILITIESCOUNT = 8;

    /**
     * Constructor of the Board class
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
        for (int victoryPossibility = 0; victoryPossibility < VICTORYPOSSIBILITIESCOUNT; victoryPossibility++) {
            String line = switch (victoryPossibility) {
                // First row
                case 0 -> fields[0] + fields[1] + fields[2];
                // Second row
                case 1 -> fields[3] + fields[4] + fields[5];
                // Third row
                case 2 -> fields[6] + fields[7] + fields[8];
                // First column
                case 3 -> fields[0] + fields[3] + fields[6];
                // Second column
                case 4 -> fields[1] + fields[4] + fields[7];
                // Third column
                case 5 -> fields[2] + fields[5] + fields[8];
                // Diagonal top left to bottom right
                case 6 -> fields[0] + fields[4] + fields[8];
                // Diagonal bottom left to top right
                case 7 -> fields[2] + fields[4] + fields[6];
                default -> null;
            };
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
