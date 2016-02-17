module Timeline.Update where

import Dict exposing (insert)
import Drag exposing (..)


import Item.Model as Item exposing (Item)
import Timeline.Model exposing (initialModel, Model)

type Action
  = AddItem Item
  | ToggleItemSelection Int Item Bool
  | Track (Maybe ( Int, Drag.Action ))

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

    ToggleItemSelection index item val ->
      -- Dict.insert replaces the existing record.
      let
        item' = { item | selected = val }
        items' = Dict.insert index item' model.items
      in
        { model | items = items' }

    Track (Just ( i, Lift )) ->
      model

    Track (Just ( i, MoveBy ( dx, dy ) )) ->
      model

    Track (Just ( i, Release )) ->
      model

    Track _ ->
      model


moveBy ( dx, dy ) ( x, y ) =
    ( x + toFloat dx, 0 )
