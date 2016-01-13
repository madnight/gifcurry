-- David Lettier (C) 2016. http://www.lettier.com/

import System.Environment
import System.Directory
import System.Process
import System.Info
import Data.Char
import Data.List
import Control.Concurrent
import Graphics.UI.Gtk
import Graphics.UI.Gtk.Builder

import Paths_Gifcurry
import Gifcurry (gif)

main = do
  initGUI

  builder <- build_builder

  window                  <- load_window builder "gifcurry_window"
  start_time_entry        <- load_entry builder "start_time_text_entry"
  duration_entry          <- load_entry builder "duration_text_entry"
  width_entry             <- load_entry builder "width_text_entry"
  quality_entry           <- load_entry builder "quality_text_entry"
  top_text_entry          <- load_entry builder "top_text_text_entry"
  bottom_text_entry       <- load_entry builder "bottom_text_text_entry"
  output_file_name_entry  <- load_entry builder "output_file_name_text_entry"
  status_entry            <- load_entry builder "status_text_entry"
  input_file_button       <- load_fc_button builder "input_file_button"
  output_file_path_button <- load_fc_button builder "output_file_path_button"
  create_button           <- load_button builder "create_button"
  open_button             <- load_button builder "open_button"
  giphy_button            <- load_button builder "giphy_link_button"
  imgur_button            <- load_button builder "imgur_link_button"

  -- Bug in Glade does not allow setting the link button label.
  buttonSetLabel giphy_button "Giphy"
  buttonSetLabel imgur_button "Imgur"

  entrySetText start_time_entry "0"
  entrySetText duration_entry "10"
  entrySetText quality_entry "100"
  entrySetText width_entry "500"

  create_button `on` buttonActivated $ do
    input_file_text <- fileChooserGetFilename input_file_button
    input_file_path_name <- case input_file_text of
      Nothing -> return ""
      Just file_path_name -> return file_path_name

    start_time <- entryGetText start_time_entry
    duration <- entryGetText duration_entry

    width <- entryGetText width_entry
    quality <- entryGetText quality_entry

    top_text <- entryGetText top_text_entry
    bottom_text <- entryGetText bottom_text_entry

    (output_gif_file_name, output_file_path_name) <- assemble_output_file_path_name output_file_path_button output_file_name_entry

    if ((length input_file_path_name) > 0 && (length output_file_path_name) > 5 && (length output_gif_file_name) > 4)
      then do
        forkIO $ do
          entrySetText status_entry "One GIF coming up!"
          result <- gif [
            input_file_path_name,
            output_file_path_name,
            start_time,
            duration,
            width,
            quality,
            top_text,
            bottom_text ]
          if result == 1
            then entrySetText status_entry "Did not work. Check your settings."
            else entrySetText status_entry "Ready."
          forkIO $ do
            open_gif output_file_path_name
            return ()
          return ()
        return ()
      else entrySetText status_entry "File paths are wrong. Check your settings."

    return ()

  open_button `on` buttonActivated $ do
    (_, output_file_path_name) <- assemble_output_file_path_name output_file_path_button output_file_name_entry

    fileExists <- doesFileExist output_file_path_name
    if fileExists
      then do
        forkIO $ do
          open_gif output_file_path_name
          return ()
        return ()
      else entrySetText status_entry "GIF does not exist. Check your settings."

    return ()

  on window objectDestroy mainQuit
  widgetShowAll window
  mainGUI

load_window b = builderGetObject b castToWindow

load_entry b = builderGetObject b castToEntry

load_fc_button b = builderGetObject b castToFileChooserButton

load_button b = builderGetObject b castToButton

build_builder = do
  builder <- builderNew
  glade_file <- getDataFileName "data/gui.glade"
  builderAddFromFile builder glade_file

  return builder

assemble_output_file_path_name output_file_path_button output_file_name_entry = do
  output_file_path_text <- fileChooserGetFilename output_file_path_button
  output_file_path <- case output_file_path_text of
    Nothing -> return ""
    Just dir -> return dir

  output_file_name <- entryGetText output_file_name_entry
  let output_gif_file_name = output_file_name ++ ".gif"
  let output_file_path_name = output_file_path ++ "/" ++ output_gif_file_name

  return (output_gif_file_name, output_file_path_name)

open_gif output_file_path_name = spawnCommand $ command ++ output_file_path_name
  where command = if "linux" `isInfixOf` (fmap toLower System.Info.os) then "xdg-open " else "open "
