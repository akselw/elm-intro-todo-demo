module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)



--- MODEL ---


type alias Model =
    {}


initialModel : Model
initialModel =
    {}



--- UPDATE ---


type Msg
    = NoMessage


update : Msg -> Model -> Model
update msg model =
    model



--- VIEW ---


view : Model -> Html Msg
view model =
    h1 [] [ text "Hallo der 👋" ]



--- INIT ---


main =
    Browser.sandbox
        { init = initialModel
        , view = view
        , update = update
        }



{--
section [ class "todoapp" ]
        [ header [ class "header" ]
            [ h1 [] [ text "todos" ]
            , div [ class "new-todo-row" ]
                [ input
                    [ class "new-todo"
                    , placeholder "What needs to be done?"
                    , autofocus True
                    , autocomplete False
                    , name "newTodo"
                    ]
                    []
                , button [ class "add-todo" ]
                    [ text "Add" ]
                ]
            ]
        , section [ class "main" ]
            [ ul [ class "todo-list" ]
                [ li [ classList [ ( "completed", False ) ] ]
                    [ div [ class "view" ]
                        [ input [ class "toggle", type_ "checkbox", checked False ] []
                        , label [] [ text "Text" ]
                        , button [ class "destroy" ] []
                        ]
                    ]
                ]
            ]
        ]
--}
