{-# LANGUAGE OverloadedStrings #-}

import Data.Aeson
import Data.Text as T
import Data.Text.IO as TIO
import System.Environment
import System.Exit

data Nick = Nick
    { nick :: Text
    , alias_of :: Text
    } deriving Show

instance ToJSON Nick where
    toJSON (Nick name alias) = object [ "nick" .= name, "alias_of" .= alias ]

parseLog :: Text -> [Nick]
parseLog _ = []

main :: IO ()
main = do
    args <- getArgs
    file_data <- TIO.readFile (args !! 0)
    return $ parseLog file_data

    exitWith ExitSuccess
