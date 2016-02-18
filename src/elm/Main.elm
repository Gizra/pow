
import App.Model as App exposing (Model)
import App.Update exposing (init, update, dragActions)
import App.View exposing (view)

import Timeline.Update exposing (Action)

import Drag exposing (trackMany)
import Effects exposing (Never)

import StartApp
import Task


app =
  StartApp.start
    { init = init
    , update = update
    , view = view
    , inputs = 
        [ dragActions
        ]
    }


main =
  app.html


port tasks : Signal (Task.Task Never ())
port tasks =
  app.tasks
