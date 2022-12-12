package main.java.ticTacToe;

/**
 * The Players class contains all the data related to the players.
 */
public class Player {
    /**
     * Player symbol (ticTacToe have X's and O's)
     */
    public enum Symbol {
        X,
        O
    }

    /**
     * Player variables
     */
    private String name;
    private boolean onTheMove;
    private Symbol symbol;
    private boolean victory;

    /**
     * Constructor of the Player class
     * @param name Name of the Player
     * @param onTheMove Determines whether the player starts
     * @param symbol Player symbol
     */
    public Player (String name, boolean onTheMove, Symbol symbol){
        this.name=name;
        this.onTheMove=onTheMove;
        this.symbol=symbol;
    }
    //Getters and Setters
    public boolean isOnTheMove() {
        return onTheMove;
    }
    public void setOnTheMove(boolean onTheMove) {
        this.onTheMove = onTheMove;
    }

    public Symbol getSymbol() {
        return symbol;
    }

    public void setSymbol(Symbol symbol) {
        this.symbol = symbol;
    }

    public String getName() {
        return name;
    }

    public boolean isVictory() {
        return victory;
    }

    public void setVictory(boolean victory) {
        this.victory = victory;
    }

    @Override
    public String toString() {
        return "Player{" +
                "name='" + name + '\'' +
                ", onTheMove=" + onTheMove +
                ", symbol=" + symbol +
                '}';
    }
}
