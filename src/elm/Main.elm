
import App.Model as App exposing (Model)
import App.Update exposing (init, update)
import App.View exposing (view)

import Timeline.Update exposing (Action)

import Drag exposing (trackMany)
import Effects exposing (Never)

import StartApp
import Task

hover =
    Signal.mailbox Nothing

app =
  StartApp.start
    { init = init
    , update = update
    , view = view
    , inputs = [ Signal.map (App.Update.ChildTimelineAction <<Timeline.Update.Track) (trackMany Nothing hover.signal) ]
    }


main =
  app.html


port tasks : Signal (Task.Task Never ())
port tasks =
  app.tasks
