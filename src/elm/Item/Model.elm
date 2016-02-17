module Item.Model where


type alias Position =
  { startX : Float
  , startY : Float
  , startTime : Float

  , endX : Maybe Float
  , endY : Maybe Float
  , endTime : Maybe Float
  }

initialPosition : Position
initialPosition =
  { startX = 0
  , startY = 0
  , startTime = 0

  , endX = Nothing
  , endY = Nothing
  , endTime = Nothing
  }


type AnimationSettings = NoAnimation | Repeat Int | RepeatAll

type Bundle
  = Audio
  | Animated AnimationSettings
  | Image
  | Text String

type alias Item =
  { label : String
  , bundle : Bundle
  , position : Position
  }

initialItems : List Item
initialItems =
  [ Item "(1) image" Image initialPosition
  , Item "(2) animated" (Animated RepeatAll) initialPosition
  ]
