module Solution exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)



--- MODEL ---


type alias Model =
    { inputText : String
    , todos : List Todo
    , nextId : Int
    }


type alias Todo =
    { text : String
    , id : Int
    , completed : Bool
    }


initialModel : Model
initialModel =
    { inputText = ""
    , todos = []
    , nextId = 1
    }



--- UPDATE ---


type Msg
    = TextUpdated String
    | TodoAdded
    | TodoDeleted Int
    | CompleteToggled Int


update : Msg -> Model -> Model
update msg model =
    case msg of
        TextUpdated string ->
            { model | inputText = string }

        TodoAdded ->
            { model
                | inputText = ""
                , todos = createTodo model.inputText model.nextId :: model.todos
                , nextId = model.nextId + 1
            }

        TodoDeleted deletedTodoId ->
            { model
                | todos =
                    List.filter
                        (\todo -> todo.id /= deletedTodoId)
                        model.todos
            }

        CompleteToggled completedTodoId ->
            { model
                | todos =
                    List.map
                        (\todo ->
                            if todo.id == completedTodoId then
                                { todo | completed = not todo.completed }

                            else
                                todo
                        )
                        model.todos
            }


createTodo : String -> Int -> Todo
createTodo string id =
    { text = string
    , id = id
    , completed = False
    }



--- VIEW ---


view : Model -> Html Msg
view model =
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
                    , onInput TextUpdated
                    , value model.inputText
                    ]
                    []
                , button
                    [ class "add-todo"
                    , onClick TodoAdded
                    ]
                    [ text "Add" ]
                ]
            ]
        , section [ class "main" ]
            [ ul [ class "todo-list" ]
                (List.map viewTodo model.todos)
            ]
        ]


viewTodo : Todo -> Html Msg
viewTodo todo =
    li [ classList [ ( "completed", todo.completed ) ] ]
        [ div [ class "view" ]
            [ input [ class "toggle", type_ "checkbox", checked todo.completed, onClick (CompleteToggled todo.id) ] []
            , label [] [ text todo.text ]
            , button [ class "destroy", onClick (TodoDeleted todo.id) ] []
            ]
        ]



--- INIT ---


main =
    Browser.sandbox
        { init = initialModel
        , view = view
        , update = update
        }



-- Ekstraoppgave: Legg til følgende etter section [ class "main" ], og implementer funksjonene
{--
footer [ class "footer" ]
    [ span [ class "todo-count" ]
        [ strong [] [ text "x" ]
        , text " items left"
        ]
    , ul [ class "filters" ]
        [ li []
            [ a [ class "selected" ] [ text "All" ]
            ]
        , li []
            [ a [] [ text "Active" ]
            ]
        , li []
            [ a [] [ text "Completed" ]
            ]
        ]
    , button [ class "clear-completed" ] [ text "Clear completed (x)" ]
    ]
--}
-- (a [][ text "Active"] er egentlig en lenke, men man kan behandle dem som buttons med onClick)
