-- David Lettier (C) 2016. http://www.lettier.com/

import System.Environment
import System.Process
import System.IO.Temp
import System.Exit
import Data.List

import Gifcurry (gif)

main :: IO ()
main = do
  args <- getArgs
  if length args < 8
    then do
      prntheader
      putStrLn "\nUsage: $ gifcurry input_file output_file start_sec duration width quality top_text bottom_text"
      putStrLn "Example: $ gifcurry ./in.mp4 ./out.gif 3 10 600 80 'Top' 'Bottom'"
      exitWith (ExitFailure 1)
    else do
      prntheader
      result <- gif $ take 8 args
      return ()

prntheader = do
  putStrLn " _____ _  __                           "
  putStrLn "|  __ (_)/ _|                          "
  putStrLn "| |  \\/_| |_ ___ _   _ _ __ _ __ _   _ "
  putStrLn "| | __| |  _/ __| | | | '__| '__| | | |"
  putStrLn "| |_\\ \\ | || (__| |_| | |  | |  | |_| |"
  putStrLn " \\____/_|_| \\___|\\__,_|_|  |_|   \\__, |"
  putStrLn "                                  __/ |"
  putStrLn "                                 |___/ "
  putStrLn "\nGifcurry (C) 2016 David Lettier. http://www.lettier.com/"
