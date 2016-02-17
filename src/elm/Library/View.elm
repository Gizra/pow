module Library.View where

import Html                      exposing (a, div, h2, li, text, ul, Html)
import Html.Attributes           exposing (class, href)
import Html.Events               exposing (onClick)

-- Components

import Item.Model     as Item    exposing (Item)
import Library.Model  as Library exposing (initialModel, Model)
import Library.Update            exposing (Action)


view : Signal.Address Action -> Model -> Html
view address model =
  div
    [ class "library"]
    [ h2 [] [ text "Library" ]
    , viewItems address model.items
    ]

viewItems : Signal.Address Action -> List Item -> Html
viewItems address items =
  let
    linkItem item =
      a
        [ href "javascript:void(0);"
        , onClick address (Library.Update.SelectItem item)
        ]
        [ text item.label ]

    viewItem item =
      li [] [ linkItem item ]
  in
    ul
      [ class "items" ]
      ( List.map viewItem items )
