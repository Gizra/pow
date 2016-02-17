module Library.Model where

import Item.Model as Item exposing (Item, initialItems)

type alias Model =
  { items : List Item
  }


initialModel : Model
initialModel =
  { items = initialItems
  }
