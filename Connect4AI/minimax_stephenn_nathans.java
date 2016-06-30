
import java.util.ArrayList;
import java.util.Random;

/// Base class for all AI players.
/**
 * AIModule is the base class for all AI players.  To create a new AI class,
 * simply extend AIModule and override the getNextMove method.
 * 
 * getNextMove will be invoked by a thread that will run for a specified period
 * of time before having the terminate flag set by the GameController.  Once the
 * terminate flag is set, the getNextMove function will be given a short amount
 * of time to exit.  If it does not, a Exception will be invoked.
 * 
 * @author Leonid Shamis
 * @see RandomAI, StupidAI, MonteCarloAI
 */
public class minimax_stephenn_nathans extends AIModule
{
        /// Random number generator to play random games.
        private final Random r = new Random(System.currentTimeMillis());
		/// Used as a helper when picking random moves.
		private int[] moves;
	    private int bestBranch;  //or bestBranch
	    private boolean first;
		private int theDepth = 4;
        
        public void getNextMove(final GameStateModule game)
	{
		// Set up the legal moves buffer.  We use only one buffer repeatedly to
		// avoid needless memory allocations.
		moves = new int[game.getWidth()];

		// Default to choosing the middle column (should be fixed after a few rounds)
		bestBranch = 3;

		// Cache our index.
		final int ourPlayer = game.getActivePlayer();

			
		if (game.getCoins()%2 == 0)
		{
        	minimax(game, 4, true);  
        	first = true;
		}
       	if (game.getCoins()%2 == 1)
       	{
       		minimax(game, 4, false);
       		first = false;
       	}
       	if (game.getCoins() == 0)
       		bestBranch = 3;
        
        chosenMove = bestBranch;    
	
	    
	}
	
	
	public int minimax(final GameStateModule state, int depth, boolean maxPlayer){
		int bestValue = 0;
        int newDepth = 0;
	    if (depth == 0)
	        return evalFunc(state, depth, maxPlayer);
	    
	    if (maxPlayer){  //MAX player
	    	 bestValue = -Integer.MAX_VALUE;
         for (int i = 0; i<7;i++){
              if (state.canMakeMove(i)) {
            	 state.makeMove(i);
                 newDepth = depth-1;
            	 int v = minimax(state, newDepth, false);
            	 state.unMakeMove();
            	 if (v >= bestValue && theDepth == depth)
                    bestBranch = i;   //bestBranch is global, or public.
            	 bestValue = Math.max(bestValue, v);
              }
         	}
         return bestValue;
	    }
	    
	     else {   //MIN player
	         bestValue = Integer.MAX_VALUE;
         for (int i =0; i<7;i++){
             	 if (state.canMakeMove(i)){
            		 state.makeMove(i);
                         newDepth = depth-1;
            		 int v = minimax(state, newDepth, true);
            		 state.unMakeMove();
            	 	if (v <= bestValue && theDepth == depth)
                		 bestBranch = i; 
            		 bestValue = Math.min(bestValue, v);
             	 }
         	}
         return bestValue;
	     }
	     
	 }

	public int evalFunc(final GameStateModule state, int depth, boolean maxPlayer){
		int score = 0;
		int[][] board = new int[7][6];
		

		int currentPlayer = 1;
		int opponent = 2;
		for (int row = 0; row < 6; row++){
			for (int column = 0; column < 7; column++){
			board[column][row] = state.getAt(column, row);
			}
		}


	
	
		
		//Read the board
		score += findThreeInRows(board,1);
		score += findThreeInColumns(board,1);
		score += findThreeInDiagonals(board,1);
		score += centerValuation(board,1);
		score += findFourInDiagonals(board,1);
		score += findFourInRows(board,1);
		

		
		if (state.isGameOver()){
		//	if (state.getWinner()==1)
		//	 	score += 5000;
			if (state.getWinner()==2 && first)
				score -= 10000;
		    if (state.getWinner()==1 && !first)
		    	score += 10000;
		}
		
		

		/*
		System.out.println("---------");
		printBoard(board);
		System.out.println(score);
		System.out.println("---------");
*/
		return score;
	}
	
	public int findThreeInRows(int [][] board,int player){
		int value = 0;
		int counter = 1;
		int opponentCounter = 1;
		for (int row = 0; row < 6; row++){
			for (int column = 0; column < 5; column++){
				//Find if we have an open three in a row in each row
				if (board[column][row] == 1){
					if (board[column+1][row] == 1){
						if (board[column+2][row] == 1){
							if (column<4){
								if(board[column+3][row] == 0)
								{
									value += 40*counter;
									counter += 3;
								}
							}
							if (column>0){
								if (board[column-1][row] == 0)
								{
									value += 40*counter;
									counter += 3;
								}
							}
								
						}
					}
				}
				
				//Find if opponent has three in a row in each row
				if (board[column][row] == 2){
					if (board[column+1][row] == 2){
						if (board[column+2][row] == 2){
							if (column<4){
								if(board[column+3][row] == 0)
								{
									value -= 1525*opponentCounter;
									opponentCounter++;
									opponentCounter++;
									opponentCounter++;
								}
							}
							if (column>0){
								if (board[column-1][row] == 0)
								{
									value -= 1525*opponentCounter;
									opponentCounter++;
									opponentCounter++;
									opponentCounter++;
									
								}
							}
						}
					}
				}
					
			}
		}
		return value;
	}
	
	public int findThreeInDiagonals(int [][] board, int player){
		int value = 0;
		int counter = 1;
		int opponentCounter = 1;
		for (int row = 0; row < 6; row++){
			for (int column = 0; column < 7; column++){
				//						X			X
				//					X					X
				//Check the case X           and 			X
				//               --------->         --------->
				//For our player
				//First case
				if (board[column][row]==1 && column<5 && row<4){
					if (board[column+1][row+1]==1){
						if (board[column+2][row+2]==1){
							if (column<4 && row<3){
								if(board[column+3][row+3] == 0)
								{
									value += 40*counter;
									counter += 3;
								}
							}
							if (column>0 && row >0){
								if (board[column-1][row-1] == 0)
								{
									value += 40*counter;
									counter += 3;
								}
							}
						}
					}
				}
				//Second case
				if (board[column][row]==1 && column<5 && row>1){
					if (board[column+1][row-1]==1){
						if (board[column+2][row-2]==1){
							if (column<4 && row>2){
								if(board[column+3][row-3] == 0)
								{
									value += 40*counter;
									counter += 3;
								}
							}
							if (column>0 && row<5){
								if (board[column-1][row+1] == 0)
								{
									value += 40*counter;
									counter += 3;
								}
							}
						}
					}
				}
				
				//For opponent
				//First case
				if (board[column][row]==2 && column<5 && row<4){
					if (board[column+1][row+1]==2){
						if (board[column+2][row+2]==2){
							if (column<4 && row<3){
								if(board[column+3][row+3] == 0)
								{
									value -= 525*opponentCounter;
									opponentCounter++;
									opponentCounter++;
									opponentCounter++;
								}
							}
							if (column>0 && row >0){
								if (board[column-1][row-1] == 0)
								{
									value -= 525*opponentCounter;
									opponentCounter++;
									opponentCounter++;
									opponentCounter++;
								}
							}
						}
					}
				}
				//Second case
				if (board[column][row]==2 && column<5 && row>1){
					if (board[column+1][row-1]==2){
						if (board[column+2][row-2]==2){
							if (column<4 && row>2){
								if(board[column+3][row-3] == 0)
								{
									value -= 525*opponentCounter;
									opponentCounter++;
									opponentCounter++;
									opponentCounter++;
								}
							}
							if (column>0 && row<5){
								if (board[column-1][row+1] == 0)
								{
									value -= 525*opponentCounter;
									opponentCounter++;
									opponentCounter++;
									opponentCounter++;
								}
							}
						}
					}
				}
			}
		}
		return value;
	}
	
	public int findThreeInColumns(int [][] board,int player){
		int value = 0;
		int counter = 1;
		int opponentCounter = 1;
		for (int row = 0; row < 4; row++){
			for (int column = 0; column < 7; column++){
				//Find if we have a three in a row in each column
				if (board[column][row] == 1){
					if (board[column][row+1] == 1){
						if (board[column][row+2] == 1){
							if (row<3){
								if (board[column][row+3] == 0)
								{
									value += 40*counter;
									counter += 3;
								}
							}
							if (row>0){
								if (board[column][row-1] == 0)
								{
									value += 40*counter;
									counter += 3;
								}
							}
						}
					}
				}
				
				//Find if opponent has three in a row in each row
				if (board[column][row] == 2){
					if (board[column][row+1] == 2){
						if (board[column][row+2] == 2){
							if (row<3){
								if (board[column][row+3] == 0)
								{
									value -= 525*opponentCounter;
									opponentCounter++;
									opponentCounter++;
									opponentCounter++;
								}
							}
							if (row>0){
								if (board[column][row-1] == 0)
								{
									value -= 525*opponentCounter;
									opponentCounter++;
									opponentCounter++;
									opponentCounter++;
								}
							}
						}
					}
				}
					
			}
		}
		return value;
	}
	

	
	public int findFourInDiagonals(int [][] board, int player){
		int value = 0;
		int counter = 1;
		int opponentCounter = 1;
		for (int row = 0; row < 6; row++){
			for (int column = 0; column < 7; column++){
				//		
				//						X			X
				//					  O				  X
				//					X					O
				//Check the case  X           and 		  X
				//               --------->         --------->
				//For our player
				//First case
				if (board[column][row]==1 && column<4 && row<3){
					if (board[column+1][row+1]==1){
						if (board[column+2][row+2]==0){
								if(board[column+3][row+3] == 1)
								{
									value += 40*counter;
									counter++;
								}
						}
					}
					if (board[column+1][row+1]==0) {
						if (board[column+2][row+2]==1){
								if(board[column+3][row+3] == 1)
								{
									value += 40*counter;
									counter++;
								}
						}
					}
				}
				//Second case
				if (board[column][row]==1 && column<4 && row>2){
					if (board[column+1][row-1]==1){
						if (board[column+2][row-2]==0){
							if(board[column+3][row-3] == 1)
							{
								value += 40*counter;
								counter++;
							}
						}
					}
					if (board[column+1][row-1]==0){
						if (board[column+2][row-2]==1){
							if(board[column+3][row-3] == 1)
							{
								value += 40*counter;
								counter++;
							}
						}
					}
				}
				
				//For opponent
				//First case
				if (board[column][row]==2 && column<4 && row<3){
					if (board[column+1][row+1]==2){
						if (board[column+2][row+2]==0){
								if(board[column+3][row+3] == 2)
								{
									value -= 1525*opponentCounter;
									opponentCounter++;
									opponentCounter++;
									opponentCounter++;
									opponentCounter++;
								}
						}
					}
					if (board[column+1][row+1]==0) {
						if (board[column+2][row+2]==2){
								if(board[column+3][row+3] == 2)
								{
									value -= 1525*opponentCounter;
									opponentCounter++;
									opponentCounter++;
									opponentCounter++;
									opponentCounter++;
								}
						}
					}
				}
				//Second case
				if (board[column][row]==2 && column<4 && row>2){
					if (board[column+1][row-1]==2){
						if (board[column+2][row-2]==0){
							if(board[column+3][row-3] == 2)
							{
									value -= 1525*opponentCounter;
									opponentCounter++;
									opponentCounter++;
									opponentCounter++;
									opponentCounter++;
								}
						}
					}
					if (board[column+1][row-1]==0){
						if (board[column+2][row-2]==2){
							if(board[column+3][row-3] == 2)
							{
									value -= 1525*opponentCounter;
									opponentCounter++;
									opponentCounter++;
									opponentCounter++;
									opponentCounter++;
								}
						}
					}
				}
			}
		}
		return value;
	}
	
	  public int findFourInRows(int [][] board,int player){
		int value = 0;
		int counter = 1;
		int opponentCounter = 1;
		for (int row = 0; row < 6; row++){
			for (int column = 0; column < 4; column++){
				//Find if we have an open three in a row in each row
				if (board[column][row] == 1){
					if (board[column+1][row] == 1){
						if (board[column+2][row] == 0){
							if(board[column+3][row] == 1)
							{
								if (row>0){
									if (board[column+2][row-1] !=0)
										value += 40*counter;
								}
								counter += 3;
							}
						}
								
					}
					if (board[column+1][row] == 0){
						if (board[column+2][row] == 1){
							if(board[column+3][row] == 1)
							{
								if (row>0){
									if (board[column+2][row-1] !=0)
										value += 40*counter;
								}
								counter += 3;
							}
						}
								
					}
					
				}
				
				
				//Find if opponent has three in a row in each row
				if (board[column][row] == 2){
					if (board[column+1][row] == 2){
						if (board[column+2][row] == 0){
							if(board[column+3][row] == 2)
							{
									value -= 1525*opponentCounter;
									opponentCounter++;
									opponentCounter++;
									opponentCounter++;
									opponentCounter++;
								}
						}
								
					}
					if (board[column+1][row] == 0){
						if (board[column+2][row] == 2){
							if(board[column+3][row] == 2)
							{
									value -= 1525*opponentCounter;
									opponentCounter++;
									opponentCounter++;
									opponentCounter++;
									opponentCounter++;
								}
						}
								
					}
					
				}
				if (row>0){
				if (board[column][row] == 0 && board[column][row-1]!=0){
					if (board[column+1][row] == 2){
						if (board[column+2][row] == 2){
							if(board[column+3][row] == 2)
							{
									value -= 11525*opponentCounter;
									opponentCounter++;
									opponentCounter++;
									opponentCounter++;
									opponentCounter++;
							}
						}
					}
				}
				}
					
			}
		}
		return value;
	}
	
	
	public int centerValuation(int [][]board, int player){
		int value = 0;
		for (int row = 0; row < 6; row++){
			for (int column = 0; column < 7; column++){
				//Check the center 6 (3x2 rectangle)
				if (board[column][row] == 1 && row<4 && row>1 && column>1 && column<5)
					value += 20;
				//Check the ring around the center
				if (board[column][row] == 1 && ((row==1 && column<6 && column>0) || (row==4 && column<6 && column>0) || (column == 1 && row<4 && row>1) || (column == 5 && row<4 && row>1)))
					value += 10;
					
				if (board[column][row] == 2 && row<4 && row>1 && column>1 && column<5)
					value -= 20;
				//Check the ring around the center
				if (board[column][row] == 2 && ((row==1 && column<6 && column>0) || (row==4 && column<6 && column>0) || (column == 1 && row<4 && row>1) || (column == 5 && row<4 && row>1)))
					value -=10;
			}
		}
		return value;
	}
	
	
	public void printBoard(int[][] board){
		for (int row = 5; row >=0; row--){
			for (int column = 0; column < 7; column++){
				System.out.print(board[column][row]);
			}
			System.out.println("");
		}
		System.out.println("");
	}
}
	
	
	
	
	
	

        
     
     
     
