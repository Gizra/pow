module Timeline.Utils where

import Dict exposing (Dict, empty)
import Item.Model as Item exposing (Item)


-- Get the selected items, and return a Dict of selected items.
-- getSelectedItems : Dict (Int, Item) -> Dict (Int, Item)
getSelectedItems items =
  let
    filterItems (index, item) =
      item.selected == True
  in
    Dict.toList items
      |> List.filter filterItems
      |> Dict.fromList
