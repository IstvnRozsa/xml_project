(:40 nel nagyobb jatekoskerettel rendelkezo csapatok listaja:)
xquery version "3.1";

declare namespace array = "http://www.w3.org/2005/xpath-functions/array";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";

declare option output:method "json";
declare option output:media-type "application/json";

declare function local:getResult($fileName as xs:string?, $limit as xs:integer?){
    let $nhlteams := json-doc($fileName)?teams?*
    return
    array{
    for $team in $nhlteams
    let $nop := count($team?roster?roster?*)
    where $nop > $limit
    return
    map{
        "name" : $team?name,
        "number of players": $nop
        }
      }
};

let $file := "teams.json"
let $limit := 40
let $result := local:getResult($file, $limit)
return $result