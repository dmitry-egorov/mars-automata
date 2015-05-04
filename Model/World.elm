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

updateWorld : Time -> World -> World
updateWorld dt world = {world | rover <- updateRover world.rover world.resources dt}
