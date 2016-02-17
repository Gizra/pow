module Library.Update where

import Item.Model as Item exposing (Item)
import Library.Model      exposing (initialModel, Model)

type Action
  = SelectItem Item

update : Action -> Model -> Model
update action model =
  case action of
    SelectItem item ->
      -- Nothing changes in the model, we simply use it here in order to
      -- propograte the action.
      model
