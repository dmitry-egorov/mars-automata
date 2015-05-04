module Utilities where

import Math.Vector2 exposing (..)

type alias Dimensions2 = {width: Int, height: Int}

toDimensions2 : (Int, Int) -> Dimensions2
toDimensions2 p = { width = fst p, height = snd p }

angle : Vec2 -> Vec2 -> Float
angle v1 v2 = (atan2 (getY v2) (getX v2)) - (atan2 (getY v1) (getX v1))