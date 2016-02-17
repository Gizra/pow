module Timeline.Model where

import Dict exposing (Dict, empty)
import Item.Model as Item exposing (Item)

type alias Model =
  { counter : Int
  , items : Dict Int Item
  }

initialModel : Model
initialModel =
  { counter = 0
  , items = Dict.empty
  }
