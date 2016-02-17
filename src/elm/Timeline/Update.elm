module Timeline.Update where

import Timeline.Model exposing (initialModel, Model)

type Action
  = SelectItem

update : Action -> Model -> Model
update action model =
  case action of
    SelectItem ->
      model
