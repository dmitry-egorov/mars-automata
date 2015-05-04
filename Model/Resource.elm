module Model.Resource (Resource) where

import Time exposing (..)
import Math.Vector2 exposing (..)

type alias Resource =
  {
    position: Vec2
  }