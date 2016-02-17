module Timeline.Model where

import Item.Model as Item exposing (Item)

type alias Model =
  { items : List Item
  , selectedItems : Maybe (List Item)
  }

initialModel : Model
initialModel =
  { items = []
  , selectedItems = Nothing
  }
