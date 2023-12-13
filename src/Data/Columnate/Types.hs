module Data.Columnate.Types
  ( Word (..),
    Column (),
    Row (),
    Error (..),
    ColumnateResults (..),
    ColumnateStats (..),
  ) where

import Control.Exception (Exception (..))
import Data.Text (Text ())
import Prelude hiding (Word ())

type Column = [Word]
type Row = [Word]

newtype Word = Word {unWord :: Text}
  deriving (Eq, Show)

data Error
  = UnexpectedWordLength Int Int
  | UnexpectedRowLength Int Int
  | ImpossibleError
  deriving (Eq, Show)

instance Exception Error

data ColumnateResults = ColumnateResults
  { crData :: Text,
    crStats :: ColumnateStats
  }
  deriving (Eq, Show)

data ColumnateStats = ColumnateStats
  { csCols :: Int,
    csRows :: Int,
    csWords :: Int
  }
  deriving (Eq, Show)
