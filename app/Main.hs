{-# LANGUAGE OverloadedStrings #-}

module Main where

import Data.Columnate (columnate)
import Data.Columnate.Types
import Data.Text qualified as Text
import Data.Text.IO qualified as Text

main :: IO ()
main = do
  input <- Text.getContents

  let res = columnate input

  Text.putStrLn $ "Stats: " <> Text.pack (show $ crStats res)
  Text.putStrLn ""
  Text.putStrLn (crData res)
