module Timeline.View where

import Html                        exposing (div, h2, li, span, text, ul, Html)
import Html.Attributes             exposing (class)

-- Components
import Item.Model      as Item     exposing (Item)
import Timeline.Model  as Timeline exposing (initialModel, Model)
import Timeline.Update             exposing (Action)


view : Signal.Address Action -> Model -> Html
view address model =
  div
    [ class "timeline"]
    [ h2 [] [ text "Timeline" ]
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

viewBar =
  div [] []
