(:Az elmult 30 evben alapitott csapatok listaja, kor alapjan novekvo sorrendben:)
xquery version "3.1";

declare namespace array = "http://www.w3.org/2005/xpath-functions/array";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";

declare option output:method "json";
declare option output:media-type "application/json";

declare function local:getResult($fileName as xs:string?, $currentYear as xs:integer?){
    let $nhlTeams := json-doc($fileName)?teams?*
    return
    array{
    for $team in $nhlTeams
    let $age := $currentYear - xs:int($team?firstYearOfPlay)
    where $age < 30
    order by $age descending
    return
    map{
        "name" : $team?name,
        "age": $age,
        "first year of play" : $team?firstYearOfPlay
        }
      }
};

let $file := "data/teams.json"
let $year := 2022
let $result := local:getResult($file, $year)
return $result