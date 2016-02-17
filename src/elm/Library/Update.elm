module Library.Update where

import Library.Model exposing (initialModel, Model)

type Action
  = AddItem

update : Action -> Model -> Model
update action model =
  case action of
    AddItem ->
      model
