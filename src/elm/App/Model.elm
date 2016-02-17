module App.Model where

-- Components

import Library.Model  as Library  exposing (initialModel, Model)
import Timeline.Model as Timeline exposing (initialModel, Model)


type alias Model =
  { library : Library.Model
  , timeline : Timeline.Model
  }

initialModel : Model
initialModel =
  { library = Library.initialModel
  , timeline = Timeline.initialModel
  }
