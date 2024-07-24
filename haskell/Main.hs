module Main where

import Control.Concurrent (getNumCapabilities)
import Data.ByteString.Char8 qualified as B
import Data.Foldable (fold)
import System.Environment (getArgs)
import UnliftIO.Async (pooledMapConcurrentlyN)

data ACGT = ACGT { _a :: {-# UNPACK #-}!Word
                 , _c :: {-# UNPACK #-}!Word
                 , _g :: {-# UNPACK #-}!Word
                 , _t :: {-# UNPACK #-}!Word
                 }

instance Show ACGT where
  show (ACGT !a !c !g !t) = show a <> "," <> show c <> "," <> show g <> "," <> show t

instance Semigroup ACGT where
  (ACGT !ax !cx !gx !tx) <> (ACGT !ay !cy !gy !ty) = ACGT (ax + ay) (cx + cy) (gx + gy) (tx + ty)

instance Monoid ACGT where
  mempty = ACGT 0 0 0 0

fromChar :: Char -> ACGT
fromChar = \case
  'A' -> ACGT 1 0 0 0
  'C' -> ACGT 0 1 0 0
  'G' -> ACGT 0 0 1 0
  'T' -> ACGT 0 0 0 1
  _ -> ACGT 0 0 0 0

fromFile :: FilePath -> IO ACGT
fromFile f = B.foldl' (\acgt x -> acgt <> fromChar x) mempty <$> B.readFile f

fromDirInt :: FilePath -> Int -> IO ACGT
fromDirInt d n = fromFile $! d <> "/" <> show n <> ".acgt"

readAll :: FilePath -> IO ACGT
readAll d = do
  c <- getNumCapabilities
  xs <- pooledMapConcurrentlyN c (fromDirInt d) [0..19_999::Int]
  pure $! fold xs

main :: IO ()
main = print =<< traverse readAll =<< getArgs
