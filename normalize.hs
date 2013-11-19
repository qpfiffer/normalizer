{-# LANGUAGE OverloadedStrings #-}

import Data.Text as T
import Data.Text.IO as TIO
import System.Environment
import System.Exit

data Nick = Nick
    { nick :: Text
    , alias_of :: Text
    }

--parseLog :: Text -> 

main :: IO ()
main = do
    args <- getArgs
    file_data <- TIO.readFile (args !! 0)
    --parseLog file_data

    exitWith ExitSuccess
