module Main where

import Graphics.Element exposing (..)
import Math.Vector2 exposing (..)
import Window
import Signal exposing (..)
import Time exposing (..)
import Random

import Utilities exposing (..)
import Model.World exposing (..)
import Model.Resource exposing (..)
import Model.Rover exposing (..)
import ViewModel.WorldViewModel exposing (..)
import ViewModel.GUIViewModel exposing (..)
import Debug

viewport = Viewport { width = 1024, height = 768 }

initialSeed = Random.initialSeed 31415

initialWorld : World
initialWorld =
  {
    rover =
    {
      position  = vec2 0 0,
      direction = vec2 0 1,
      speed  = 0
    },
    resources = generateResources 10 initialSeed 
  }

framerate = 30
dt = 1000 / framerate

worldSignal = foldp (\_ w -> updateWorld w dt) initialWorld (fps framerate)

render : Dimensions2 -> World -> Element
render screenDimensions world = 
  layers
  [
    renderGui world,
    renderWorld screenDimensions viewport world
  ]

main = render
  <~ (toDimensions2 <~ Window.dimensions)
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

