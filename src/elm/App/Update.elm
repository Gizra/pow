module App.Update where

import App.Model as App exposing (initialModel, Model)

import Config.Update exposing (init, Action)
import Company.Model as Company exposing (Model)
import Effects exposing (Effects)
import Json.Encode as JE exposing (string, Value)
import Json.Encode as JE exposing (string, Value)
import String exposing (isEmpty)
import Storage exposing (removeItem, setItem)
import Task exposing (succeed)

-- Components

import Library.Update  exposing (Action)
import Timeline.Update exposing (Action)

type alias Model = App.Model


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
        (childModel, childEffects) = Library.Update.update act model.library
      in
        ( {model | library = childModel }
        , Effects.map ChildLibraryAction childEffects
        )

    ChildTimelineAction act ->
      let
        (childModel, childEffects) = Timeline.Update.update act model.timeline
      in
        ( {model | timeline = childModel }
        , Effects.map ChildTimelineAction childEffects
        )

    -- NoOp actions
    _ ->
      ( model, Effects.none )

-- EFFECTS

sendInputToStorage : String -> Effects Action
sendInputToStorage val =
  Storage.setItem "access_token" (JE.string val)
    |> Task.toResult
    |> Task.map NoOpSetAccessToken
    |> Effects.task

-- Task to remove the access token from localStorage.
removeStorageItem : Effects Action
removeStorageItem =
  Storage.removeItem "access_token"
    |> Task.toMaybe
    |> Task.map NoOpLogout
    |> Effects.task
