(: Metropolitan divizioban szereplo csapatok szama :)
xquery version "3.1";

declare namespace map = "http://www.w3.org/2005/xpath-functions/map";
declare namespace array = "http://www.w3.org/2005/xpath-functions/array";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";

declare option output:method "json";
declare option output:media-type "application/json";

let $nhlteams := json-doc("teams.json")?teams

return count(fn:distinct-values(
    array {
        for $i in 1 to array:size($nhlteams)
        where contains(array:get($nhlteams, $i)?division?name, "Metropolitan")
        return array:get($nhlteams, $i)?id
    }
))