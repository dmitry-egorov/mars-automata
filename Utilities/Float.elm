module Utilities.Float where

format : Float -> String 
format f = toString ((toFloat (truncate (f * 100))) / 100)