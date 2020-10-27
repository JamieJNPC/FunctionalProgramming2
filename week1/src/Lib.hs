
module Lib
    ( parallel_map
    ) where

import Control.Parallel

parallel_map :: (a -> b) -> [a] -> [b]
parallel_map f (x:x2:xs) = (par (x2) [f x]) ++ [f x2] ++ parallel_map f xs
parallel_map f (x:x2:_) = (par (x2) [f x]) ++ [f x2]
parallel_map f (x:_) = [f x]
parallel_map _ [] = []
