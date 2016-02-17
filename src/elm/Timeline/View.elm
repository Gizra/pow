module Timeline.View where

import Graphics.Input
import Text exposing (fromString)
import Graphics.Element exposing (color, layers, leftAligned, sizeOf)
import Graphics.Collage exposing (collage, outlined, rect, solid, toForm, filled, move)
import Color exposing (blue, black, orange, yellow)

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
    ]

viewItems : Signal.Address Action -> List Item -> Html
viewItems address items =
  if List.isEmpty items
    then
      div [] [ text "No items selected yet..." ]
    else
      let
        viewItem item =
          li
            []
            [ span [] [ text item.label ]
            , span [] [ text <| "Start time: " ++ (toString item.position.startTime) ]
            , span [] [ text <| ", End time: " ++ (toString item.position.endTime) ]
            ]
      in
        ul
          [ class "items" ]
          ( List.map viewItem items )

viewBar : Html
viewBar =
  let
    forms =
      [ rect 750 40
        |> filled blue
        |> move (0,0)
      ]
  in
    div
      []
      [ fromElement (collage 750 40 forms) ]
