module Model.Rover (Rover, updateRover) where

import List exposing (..)
import Time exposing (..)
import Math.Vector2 exposing (..)
import Model.Resource exposing (..)
import Utilities.List exposing (..)

type alias Rover =
  {
    position: Vec2,
    direction: Vec2,
    speed: Float
  }

roverSpeed = 2


updateRover : Rover -> List Resource -> Time -> Rover
updateRover rover resources dt = applyVelocity (findTarget rover resources) dt

findTarget : Rover -> List Resource -> Rover
findTarget rover resources =
  let closestResource = findClosest rover resources
  in case closestResource of
    Just resource -> 
    { 
      rover | 
        direction <- direction resource.position rover.position,
        speed     <- roverSpeed
    }
    _ -> rover

applyVelocity : Rover -> Time -> Rover
applyVelocity rover dt =
  let newPosition = (scale (rover.speed * (inSeconds dt)) rover.direction)
  in {rover | position <- add rover.position newPosition}

findClosest : Rover -> List Resource -> Maybe Resource
findClosest rover resources = 
  let distance resource = distanceSquared resource.position rover.position
  in minimumBy resources distance