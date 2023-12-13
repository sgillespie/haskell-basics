{-# LANGUAGE OverloadedStrings #-}

module Data.Columnate (columnate) where

import Control.Exception (throw)
import Data.Columnate.Types
import Data.List (transpose)
import Data.Text (Text ())
import Data.Text qualified as Text
import Prelude hiding (Word)

-- | Takes a blob of text and aligns it in tabular format
columnate :: Text -> ColumnateResults
columnate t =
  ColumnateResults
    { crData = res,
      crStats = stats'
    }
  where
    cols = columns t
    res = unColumns . map alignColumn $ cols
    stats' =
      ColumnateStats
        { csCols = length cols,
          csRows = maximum . map length $ cols,
          csWords = sum (map length cols)
        }

-- | Turn a blob of text into rows of words, that is, a list of list of words
rows :: Text -> [Row]
rows t = map (fillRow $ rowSize rows') rows'
  where
    rows' = rowsFromText $ (map Text.words . Text.lines) t

-- | Turn a blob of text into columns of words; that is, a list of list of words
columns :: Text -> [Column]
columns = transpose . rows

-- | Make a list of words all the same length, by padding the right with white space
alignColumn :: Column -> Column
alignColumn words' = map (padWord width) words'
  where
    width = columnSize words' + 1

-- | Turn columns of words into a text blob
unColumns :: [Column] -> Text
unColumns = Text.unlines . filterBlankLines . map Text.unwords . transpose . colsToText
  where
    filterBlankLines = filter $ (/= "") . Text.strip

-- | Get the maximum length of words
columnSize :: Column -> Int
columnSize = maximum . map (Text.length . unWord)

-- | Get the maximum length of rows
rowSize :: [Row] -> Int
rowSize = maximum . map length

-- | Pad a word to the right with whitespace
padWord :: Int -> Word -> Word
padWord size (Word word)
  | Text.length word == size = Word word
  | Text.length word < size = Word $ word <> Text.replicate (size - Text.length word) " "
  | otherwise = throw $ UnexpectedWordLength size (Text.length word)

-- | Pad a row to the right with empty words
fillRow :: Int -> Row -> Row
fillRow size words'
  | length words' == size = words'
  | length words' < size = words' ++ replicate (size - length words') (Word "")
  | otherwise = throw $ UnexpectedRowLength size (length words')

rowsFromText :: [[Text]] -> [Row]
rowsFromText = map (map Word)

colsToText :: [Column] -> [[Text]]
colsToText = map (map unWord)
