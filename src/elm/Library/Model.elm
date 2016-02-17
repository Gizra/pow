module Library.Model where

import Item.Model as Item exposing (Item)

type alias Model =
  { item : List Item
  }

initialModel : Model
initialModel =
  { item = []
  }
