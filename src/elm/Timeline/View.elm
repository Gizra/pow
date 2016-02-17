module Library.View where

import Html exposing (div, h2, text, Html)
import Html.Attributes exposing (class)

-- Components

import Timeline.Model as Library exposing (initialModel, Model)
import Timeline.Update exposing (Action)


view : Signal.Address Action -> Model -> Html
view address model =
  div
    [ class "timeline"]
    [ text "Timeline"
    ]
