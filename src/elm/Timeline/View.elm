module Timeline.View where

import Html                        exposing (div, h2, li, text, ul, Html)
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
    , ul [ class "items" ] (List.map viewItem model.items)
    ]

viewItem : Item -> Html
viewItem item =
  li [] [ text item.label ]
