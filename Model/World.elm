module Model.World (World, updateWorld) where

import Time exposing (..)
import Math.Vector2 exposing (..)

import Model.Resource exposing (..)
import Model.Rover exposing (..)

type alias World =
  {
    rover: Rover,
    resources: List Resource
  }

updateWorld : World -> Time -> World
updateWorld world dt = {world | rover <- updateRover world.rover world.resources dt}
