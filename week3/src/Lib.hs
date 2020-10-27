module Lib
    (
    ) where

import Control.Monad
import Control.Applicative

data List a = Nil | Cons a (List a)

--instance Functor (State s) where
--   fmap = liftM

--instance Applicative (State s) where
--    pure a = State (\s -> (a,s))
    
--instance Monad (State s) where
--   m >>= k = State (\s -> let (a,s') = runState m s in runState (k a) s')

instance Functor List where
    fmap f Nil = Nil
    fmap f (Cons a b) = Cons (f a) (fmap f b)

instance Applicative List where
    pure x = Cons x Nil

instance Monad List where
    Nil >>= k = Nil
    Cons x xs >>= k = k x
    return x = Cons x Nil

--Q1 ii
-- Left identity is satisfied since return a = Cons(a Nil) and Cons(a Nil) >>= f = f Cons(a Nil)
-- Right identity is satisfied since m >>= return = return m and return m = Cons(m Nil) = m
-- Associativity is satisfied since (Cons(a Nil) >>= f) >>= g && (Cons(a Nil) >>= f) >>= g
--                                  f a >>= g                    Cons(a Nil) >>= g f
--                                  g f a                        g f a


data Pair a b = P a b

instance Functor (Pair x) where
    fmap f (P a b) = P (a) (f b)

--Q2 i
-- Identity is satisfied since fmap id (P a b) = P a b
-- Composition is satisfied since fmap ((*3) . (+2)) (P a b) = P a ((*3) . (+2) b) and
--                                fmap (*3) . fmap (+2) (P a b) = fmap (*3) (P a ((+2) b) = P a ((*3) (+2) b)

--Q2 ii