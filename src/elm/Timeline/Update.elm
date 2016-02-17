module Timeline.Update where

import Dict exposing (insert)

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
        items' = Dict.insert model.counter item model.items
      in
        { model
        | items = items'
        , counter = model.counter + 1
        }

    SelectItem item ->
      model

    UnselectItems ->
      model
