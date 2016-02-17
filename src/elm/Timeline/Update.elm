module Timeline.Update where

import Item.Model as Item exposing (Item)
import Timeline.Model exposing (initialModel, Model)

type Action
  = AddItem Item
  | SelectItem Item
  | UnselectItems

update : Action -> Model -> Model
update action model =
  case action of
    -- @todo: Convert to Dict.
    AddItem item ->
      let
        items' = item :: model.items
      in
        { model | items = items' }

    SelectItem item ->
      model

    UnselectItems ->
      model
