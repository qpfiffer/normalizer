{-# LANGUAGE OverloadedStrings #-}

import Control.Applicative
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
    _ <- AP.take 20
    _ <- AP.string "--"
    _ <- AP.take 1
    alias <- AP.takeTill (\x -> x == ' ')
    _ <- AP.string " is now known as "
    nick <- AP.takeTill AP.isEndOfLine
    return $ Nick { nick = alias, alias_of = nick }

parseNicks :: Parser Nicks
parseNicks = many $ parseLog <* endOfLine

main :: IO ()
main = do
    args <- getArgs
    TIO.readFile (args !! 0) >>= print . parseOnly parseNicks

    exitWith ExitSuccess
