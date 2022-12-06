(: Csapatok sorbarendezese begyujtott pont alapjan :)
xquery version "3.1";

declare namespace map = "http://www.w3.org/2005/xpath-functions/map";
declare namespace array = "http://www.w3.org/2005/xpath-functions/array";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";

declare option output:method "json";
declare option output:media-type "application/json";

let $nhlteams := json-doc("data/teams.json")?teams?*
return 
array {

    for $team in $nhlteams
    let $pts := $team?teamStats[1]?*?splits[1]?*?stat[1]?pts
    order by $pts descending, $team?name
    return
        map{
            "pts": $pts,
            "name": $team?name
        }

}

