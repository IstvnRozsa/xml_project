(: America/New_York idozonaban levo csapatok listazasa, varossal es arena nevvel :)
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
    let $timezone := $team?venue?timeZone?id
    where contains($timezone, "America/New_York")
    return
        map{
            "timezone": $timezone,
            "location name": $team?locationName,
            "venue":$team?venue?name,
            "team name": $team?name
        }

}