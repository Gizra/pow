module Timeline.Update where

import Item.Model as Item exposing (Item)
import Timeline.Model exposing (initialModel, Model)

type Action
  = AddItem Item

update : Action -> Model -> Model
update action model =
  case action of
    -- @todo: Convert to Dict.
    AddItem item ->
      let
        items' = item :: model.items
      in
        { model | items = items' }
