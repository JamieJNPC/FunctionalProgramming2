module Main where

import Lib

main :: IO ()
main = read10 >>= \a -> putStrLn a

-- Q2 Prints hello to terminal
-- Q3 Prints Hi there and terminates because a & b are never actually "done"