module Utilities.List (minimumBy) where

import List exposing (..)

minimumBy : List a -> (a -> comparable) -> Maybe a
minimumBy list selector = 
  let minBy x y = let p = (x, selector x) in if (snd p) < (snd y) then p else y 
  in case list of
      x :: xs -> Just (fst <| foldl minBy (x, selector x) xs)
      _ -> Nothing 