module Library.View where

import Html                      exposing (div, h2, li, text, ul, Html)
import Html.Attributes           exposing (class)

-- Components

import Item.Model     as Item    exposing (Item)
import Library.Model  as Library exposing (initialModel, Model)
import Library.Update            exposing (Action)


view : Signal.Address Action -> Model -> Html
view address model =
  div
    [ class "library"]
    [ h2 [] [ text "Library" ]
    , ul [ class "items" ] (List.map viewItem model.items)
    ]

viewItem : Item -> Html
viewItem item =
  li [] [ text item.label ]
