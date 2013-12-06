{-# LANGUAGE OverloadedStrings #-}

import Data.Aeson
import Data.Attoparsec.Text as AP
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

type Nicks = [Nick]

parseLog :: Parser Nick
parseLog = do
    garbage <- AP.take 19
    return $ Nick { nick = garbage, alias_of = "" }

main :: IO ()
main = do
    args <- getArgs
    file_data <- TIO.readFile (args !! 0)
    print $ parseOnly parseLog file_data

    exitWith ExitSuccess
