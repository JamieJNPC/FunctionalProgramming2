module Lib
    (
      f1,
      while,
      read10,
      f2
    ) where

-- Q2 Prints hello to terminal
-- Q3 Prints Hi there and terminates because a & b are never actually "done"

f1 :: [IO a] -> IO a
f1 (x:xs) = if length xs == 0 then x else x >> (f1 xs)

while :: IO Bool -> IO ()
while a = a >>= \x -> if x then while a else return ()

f2 :: [IO a] -> IO [a]
f2 (x:xs) = x >>= (\a -> f2 xs >>= (\b -> return (a:b)))
f2 [] = return []

read10 :: IO String
read10 = f2 $ take 10 actions
          where actions = getChar : actions