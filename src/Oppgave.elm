module Oppgave exposing (main)

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


createTodo : String -> Int -> Todo
createTodo string id =
    { text = string
    , id = id
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
    li [ classList [ ( "completed", False ) ] ]
        [ div [ class "view" ]
            [ input [ class "toggle", type_ "checkbox", checked False ] []
            , label [] [ text todo.text ]
            , button [ class "destroy" ] []
            ]
        ]



{--
Oppgave 1: Slett todo
1. Legg til en Msg som heter TodoDeleted, som tar en Int som argument (akkurat som TextUpdated tar en String som argument).
   Int'en skal v??re id'en til todoen som blir slettet.
2. Kompiler koden og les feilmeldingen
3. Legg til TodoDeleted i update. I f??rste omgang kan du returnere modellen uten ?? gj??re noen endringer. S??rg for at koden kompilerer her.
   Hint: Pass p?? at alle casene er like mye indentert, og formatter koden med formatteringsknappen i Ellie
4. Legg til onClick med en message som argument i button med klassen "destroy". Se at meldingen blir sendt, ved ?? 
   trykke p?? DEBUG i menyen ??verst til h??yre.
   Hint: Du kommer til ?? m??tte bruke parenteser rundt argumentet til onClick
5. Implementer fjerning av todoen i update.
   Hint: Du m?? bruke List.filter og en anonym funksjon.
   Eksempel: Dette er koden for ?? filtrere bort 1-tall fra en liste med tall: List.filter (\number -> number /= 1) [1,2,3,1]

Oppgave 2: Marker todo som fullf??rt
1. Legg til et felt completed som har typen Bool i type aliaset Todo.
2. Kompiler koden, og les feilmeldingen (les hele feilmeldingen, inkludert siste linje)
3. Legg til et felt for completed i createTodo. Sett det til ?? v??re True (vi endrer dette senere)
4. Erstatt de to stedene hvor det st??r False i viewTodo med feltet completed til todo. Test at view-koden fungerer ved
   ?? legge til en todo i appen (ikke i koden) og se at den er fullf??rt med en gang man legger til todoen.
5. Endre til at completed er False i createTodo
6. Legg til en Msg som heter CompleteToggled som ogs?? tar en Int som argument
7. Legg til CompleteToggled i update. Ogs?? her kan du f??rst returnere bare modellen uendret, og sjekke at det kompilerer.
8. Legg til en onClick p?? input'en som har class "toggle". Sjekk at det blir sendt en message i DEBUG n??r checkboxen blir trykket p??.
9. Implementer ?? sette completed p?? todoen i update.
   Hint: Du m?? bruke List.map og en anonym funksjon.
   Tips: Start med ?? toggle alle todoene i f??rste omgang, og sjekk at det fungerer. Pr??v s?? ?? endre koden til at kun
   den todoen som har blitt togglet blir endret.
   Hint2: Husk at den anonyme funksjonen alltid m?? returnere en todo, men at den ikke n??dvendigvis beh??ver ?? endre hver gang.
   Hint3: Syntaksen for if else i Elm er s??nn her:
   if a == 1 then
       "a var visst 1"
   else
       "a var noe annet enn 1, jeg gjetter 7"

--}
--- INIT ---


main =
    Browser.sandbox
        { init = initialModel
        , view = view
        , update = update
        }
