module Lib
    ( example,
      tell
    ) where

import Control.Monad
import Control.Applicative

example :: Writer Int
example = do
  tell "entry 1"
  tell "entry 2"
  return (1 + 1)

newtype Writer a = Writer ([String], a)
instance Functor Writer where
  fmap f (Writer ([], x)) = Writer ([], f x)
  fmap f (Writer (log, x)) = Writer (log, f x)

instance Applicative Writer where
  pure x = Writer ([], x)

instance Monad Writer where
  Writer (log1, x) >>= k =
    let Writer (log2, y) = k x
    in Writer (log1 ++ log2, y)
  return x = Writer ([], x)

tell entry = Writer ([entry], ())

--Q2
-- making the log work with any type will require rewriting the bind function since it relies
-- on appending two lists together to maintain the log