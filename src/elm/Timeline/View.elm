module Timeline.View where

import Dict exposing (map)
import Graphics.Input
import Text exposing (fromString)
import Graphics.Element exposing (color, layers, leftAligned, sizeOf)
import Graphics.Collage exposing (collage, outlined, rect, solid, toForm, filled, move, moveX, ngon, rotate)
import Color exposing (blue, black, orange, yellow, red)

import Html                        exposing (div, h2, fromElement, li, span, text, ul, Html)
import Html.Attributes             exposing (class, style)



-- Components
import Item.Model      as Item     exposing (Item)
import Timeline.Model  as Timeline exposing (initialModel, Model)
import Timeline.Update             exposing (Action)


view : Signal.Address Action -> Model -> Html
view address model =
  div
    [ class "timeline"]
    [ h2 [] [ text "Timeline" ]
    , viewBar
    , viewItems address model.items
    , div [] [text <| toString (Dict.values model.items)]
    ]

viewItems : Signal.Address Action -> Dict.Dict Int Item -> Html
viewItems address items =
  if Dict.isEmpty items
    then
      div [] [ text "No items selected yet..." ]
    else
      let
        viewItem _ item =
          li
            []
            [ span [] [ text item.label ]
            , span [] [ text <| "Start time: " ++ (toString item.position.startTime) ]
            , span [] [ text <| ", End time: " ++ (toString item.position.endTime) ]
            ]

      in
        ul
          [ class "items" ]
          -- ( Dict.values items |> List.map viewItem )
          []


-- Get all the bar forms
getForms : List Graphics.Collage.Form
getForms =
  let
    hand index =
      rect 2 20
        |> filled black
        |> move (index * 80, -10)

    hands direction =
      let
        index =
          if direction == True then [0..4] else [-4..0]
      in
      List.map hand index

    bar =
      rect 800 40
        |> filled blue

    startTime =
      ngon 3 15
        |> filled yellow
        |> move (0, 15)
        |> rotate (degrees 30)
  in
    bar :: startTime :: (hands True) ++ (hands False)


viewBar : Html
viewBar =
  div
    []
    [ fromElement (collage 800 40 getForms) ]
