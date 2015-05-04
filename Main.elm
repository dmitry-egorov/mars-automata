module Main where


import Math.Vector2 exposing (..)
import Window
import Signal exposing (..)
import Time exposing (..)
import Random

import Utilities exposing (..)
import Model.World exposing (..)
import Model.Resource exposing (..)
import Model.Rover exposing (..)
import ViewModel.ViewModel exposing (..)

viewWorld = Viewport { width = 1024, height = 768 }

initialSeed = Random.initialSeed 31415

initialWorld : World
initialWorld =
  {
    rover =
    {
      position  = vec2 0 0,
      direction = normalize <| vec2 -0.5 0.5,
      speed  = 0
    },
    resources = generateResources 10 initialSeed 
  }

worldSignal = foldp updateWorld initialWorld (fps 30)

main = render
  <~ (toDimensions2 <~ Window.dimensions)
  ~ constant viewWorld
  ~ worldSignal


generateResources : Int -> Random.Seed -> List Resource
generateResources count seed = 
  let fg = Random.float -10 10
      f s1 = 
        let (x, s2) = Random.generate fg s1
            (y, s3) = Random.generate fg s2
        in ({position = vec2 x y}, s3)
      
      gen = Random.customGenerator f
  in fst (Random.generate (Random.list count gen) seed)

