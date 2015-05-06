module Utilities.Vec2 where

import Utilities.Float as Float
import Math.Vector2 exposing (..)

format : Vec2 -> String 
format v = "(" ++ (Float.format (getX v)) ++ ", " ++ (Float.format (getY v)) ++ ")"