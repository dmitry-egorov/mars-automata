module ViewModel.ViewModel (Viewport, render) where

import List exposing (..)
import Color exposing (..)
import Graphics.Element exposing (..)
import Graphics.Collage exposing (..)
import Math.Vector2 exposing (..)
import Debug

import Model.Resource exposing (..)
import Model.Rover exposing (..)
import Model.World exposing (..)
import Utilities exposing (..)
import Utilities.List exposing (..)

type alias Viewport =
  {
    dimensions: Dimensions2
  }

render : Dimensions2 -> Viewport -> World -> Element
render screenDimensions viewport world =
  container screenDimensions.width screenDimensions.height middle <|
  collage viewport.dimensions.width viewport.dimensions.height <| 
  concat
  [
    renderBackground viewport.dimensions,
    renderResources world.resources viewport,
    renderRover world.rover viewport
  ]


renderBackground : Dimensions2 -> List Form
renderBackground {width, height} =
  let (w, h) = (toFloat width, toFloat height)
  in
  [
    rect w h |> filled orange,
    circle (h / 2) |> filled darkOrange |> move (w/4, -h/2)
  ]

renderRover : Rover -> Viewport -> List Form
renderRover rover viewport = 
  let transform2 form = 
    form 
    |> rotate (rotationOf rover.direction)
    |> move (transpose rover.position viewport)
  in map transform2
  [
    rect 10 20 |> filled black,
    segment (0, 0) (0, 15) |> traced (solid black)
  ]
     

renderResources : List Resource -> Viewport -> List Form
renderResources resources viewport = 
  let renderResource resource =
      square 20
      |> filled yellow
      |> move (transpose resource.position viewport) 
  in map renderResource resources


rotationOf : Vec2 -> Float
rotationOf orientation = angle (vec2 0 1) orientation

transpose : Vec2 -> Viewport -> (Float, Float)
transpose position {dimensions} = toTuple (Math.Vector2.scale (toFloat dimensions.height / 2 / 10) position)
