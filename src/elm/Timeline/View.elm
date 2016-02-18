module Timeline.View where

import Dict exposing (map)
import Graphics.Input
import Text exposing (fromString)
import Graphics.Element exposing (color, layers, leftAligned, sizeOf)
import Graphics.Collage exposing (collage, outlined, rect, solid, toForm, filled, move, moveX, ngon, rotate)
import Graphics.Input exposing (hoverable)
import Color exposing (blue, black, orange, yellow, red)

import Html                        exposing (a, div, h2, fromElement, li, span, text, ul, Html)
import Html.Attributes             exposing (class, href, style)
import Html.Events                 exposing (onClick)




-- Components
import Item.Model      as Item     exposing (Item)
import Timeline.Model  as Timeline exposing (initialModel, Model)
import Timeline.Update             exposing (Action, startTimeHover, startTimeActions)


view : Signal.Address Action -> Model -> Html
view address model =
  div
    [ class "timeline"]
    [ h2 [] [ text "Timeline" ]
    , viewBar model.startTimePicker
    , viewItems address model.items
    ]



viewItems : Signal.Address Action -> Dict.Dict Int Item -> Html
viewItems address items =
  if Dict.isEmpty items
    then
      div [] [ text "No items selected yet..." ]
    else
      let
        viewItem (id, item) =
          li
            []
            [ linkItem address (id, item)
            , span [] [ text <| " Start time: " ++ (toString item.position.startTime) ]
            , span [] [ text <| ", End time: " ++ (toString item.position.endTime) ]
            , span [] [ text <| ", Selected: " ++ (toString item.selected) ]
            ]

      in
        ul
          [ class "items" ]
          ( Dict.toList items |> List.map viewItem )

linkItem : Signal.Address Action -> (Int, Item) -> Html
linkItem address (id, item) =
  a
    [ href "javascript:void(0);"
    , onClick address (Timeline.Update.ToggleItemSelection id item (not item.selected))
    ]
    [ text <| (toString id) ++ ") " ++ item.label ]


-- Get all the bar forms
getForms : Float -> List Graphics.Collage.Form
getForms startTimePicker =
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
        |> move (startTimePicker, 15)
        |> rotate (degrees 30)

    -- We need to make it hoverable, but that requires an element. But,
    -- we really do want it to be a form. So, we use `collage` to turn it
    -- into an element, and then `toForm` to turn it back into a form.
    -- the 800 40 needs to match the 800 40 in the `collage` call in
    -- `viewBar` below to get the scale right, so I guess those
    -- numbers should probably be broken out as constants and re-used.
    startTimeHoverable =
      collage 800 40 [startTime]
        |> hoverable (Signal.message startTimeHover.address)
        |> toForm

  in
    -- It looks like startTimeHoverable has to be last in the list,
    -- otherwise the dragging doesn't work.
    [bar] ++ (hands True) ++ (hands False) ++ [startTimeHoverable]


viewBar : Float -> Html
viewBar startTimePicker =
  div
    []
    [ fromElement (collage 800 40 (getForms startTimePicker))
    , div [] [ text <| toString startTimePicker ]
    ]
