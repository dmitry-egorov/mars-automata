module ViewModel.GUIViewModel where

import Graphics.Element exposing (..)
import Model.World exposing (..)
import Utilities.Float as Float
import Utilities.Vec2 as Vec2

renderGui : World -> Element
renderGui w = 
  let 
      
      rp = Vec2.format w.rover.position
      rd = Vec2.format w.rover.direction
      s  = Float.format w.rover.speed
  in flow down
  [
    show ("Pos: " ++ rp),
    show ("Dir: " ++ rd),
    show ("S: " ++ s)
  ]

