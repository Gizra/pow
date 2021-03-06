module App.View where

import App.Model as App exposing (initialModel, Model)
import App.Update exposing (init, Action)


import Html exposing (a, div, h2, i, li, node, span, text, ul, button, Html)
import Html.Attributes exposing (class, classList, id, href, style, target, attribute)
import Html.Events exposing (onClick)

-- Components

import Library.View  exposing (view)
import Timeline.View exposing (view)



view : Signal.Address Action -> Model -> Html
view address model =
  div
    []
    [ viewLibrary address model
    , viewTimeline address model
    ]

viewLibrary : Signal.Address Action -> Model -> Html
viewLibrary address model =
  let
    childAddress =
      Signal.forwardTo address App.Update.ChildLibraryAction
  in
    div [] [ Library.View.view childAddress model.library ]

viewTimeline : Signal.Address Action -> Model -> Html
viewTimeline address model =
  let
    childAddress =
      Signal.forwardTo address App.Update.ChildTimelineAction
  in
    div [] [ Timeline.View.view childAddress model.timeline ]
