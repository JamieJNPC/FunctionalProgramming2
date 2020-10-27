module Main where

import Lib

main :: IO ()
main = putStrLn (show (parallel_map (*5) [1,2,3]))
