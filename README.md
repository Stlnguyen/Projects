# Projects

  DASH - Infinite Runner Video Game

Authors - Stephen Nguyen and Steven Liu

Implemented using OpenGL libraries and C++. Heavy emphasis on keeping code neat using object-oriented methodology. Run by launching Project2 application.

Created our own game engine first, with everything including gravity, animation, collision, etc. Then changed into an infinite runner. Challenges related to infinite runner type video games included solving fps drops by only rendering images on screen, getting animations to show certain behaviors, and random terrain generation.



  Connect 4 AI - Artificial Intelligence that wins versus any average player.

Authors - Stephen Nguyen and Nathan Suh

Coded using Java. Requires Linux machine. Runnable through terminal with command "java Main -p1 minimax_stephenn_nathans". Compile using "javac minimax_stephenn_nathans.java" if needed.

Uses minimax algorithm combined with alpha-beta pruning to speed up decision tree searching, allowing for greater depths to be searched.

Note that the AI is not perfect. Perfect AI play would be a guaranteed win if the AI goes first.



  NBA 2010 Statistics - Data Analysis Application

Author - Stephen Nguyen

Note: Not actually workable through github because the CSV files from the 2010 NBA season is ~22GB and is required since my program parses through CSV as needed. I've uploaded the code, a picture including all functionalities, and 1 CSV file (1 play) however, to show general ideology.

Coded using Java. Converts CSV file data given from the NBA 2010 season into an animated play field. Animation alone is helpful for visualization and data anaylsis and is achieved through parsing through the positions of all players during each time period. One CSV file covers 1 play, which means either the ball went out of bounds or was scored. Therefore, each match could have 500+ CSV files and there are 82 total matches.

Additional features include being able to select a player and view information about the player such as, jersey number, name, picture, etc. When you select a player there will also be a graph shown that shows that player's proximity to the ball throughout the play. In addition, the selected player will become red, which will show on the bar chart, that shows the total distance traveled during the play. There is also a slider which allows you to manually traverse through the play or you can let the play animate through real time.
