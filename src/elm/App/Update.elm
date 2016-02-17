module App.Update where

import Effects exposing (Effects)
import Task exposing (succeed)

-- Components
import App.Model as App exposing (initialModel, Model)
import Library.Update  exposing (Action)
import Timeline.Update exposing (Action)

init : (Model, Effects Action)
init =
  ( App.initialModel
  , Effects.none
  )

type Action
  = ChildLibraryAction Library.Update.Action
  | ChildTimelineAction Timeline.Update.Action

  -- NoOp actions
  | NoOp


update : Action -> Model -> (Model, Effects Action)
update action model =
  case action of
    ChildLibraryAction act ->
      let
        childModel = Library.Update.update act model.library

        effects' =
          case act of
            Library.Update.SelectItem item ->
              (Task.succeed (ChildTimelineAction <| Timeline.Update.AddItem item) |> Effects.task)
      in
        ( { model | library = childModel }
        , effects'
        )

    ChildTimelineAction act ->
      let
        childModel = Timeline.Update.update act model.timeline
      in
        ( { model | timeline = childModel }
        , Effects.none
        )

    -- NoOp actions
    _ ->
      ( model, Effects.none )
