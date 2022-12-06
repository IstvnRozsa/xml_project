(: Top 3 legtobbet vesztett csapat :)
xquery version "3.1";
import schema default element namespace "" at "data/schema09.xsd";


declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";

declare option output:method "xml";
declare option output:indent "yes";

let $nhlteams := json-doc("data/teams.json")?teams?*
return validate {
    document {
        <teams xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xsi:noNamespaceSchemaLocation="data/schema09.xsd">
            {
                let $sortByLossDesc:= 
                for $team in $nhlteams
                order by $team?teamStats[1]?*?splits[1]?*?stat[1]?losses descending
                return
                $team
                
                for $team in $sortByLossDesc[position() lt 4]
                return
                    <team id="{$team?id}">
                        <teamName>{$team?name}</teamName>
                        <teamLosses>{$team?teamStats[1]?*?splits[1]?*?stat[1]?losses}</teamLosses>
                    </team>
            }
        </teams>
    }

}