(: Csapatok rendezese konferencia es gyozelmi szam szerint, alagyujtve a csapattagok neveivel es mezsszamaival:)
xquery version "3.1";

import schema default element namespace "" at "data/schema08.xsd";


declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";

declare option output:method "xml";
declare option output:indent "yes";

let $nhlteams := json-doc("data/teams.json")?teams?*
return validate {
    document {
        <teams xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
            {
                for $team in $nhlteams
                order by $team?conference?name, $team?teamStats[1]?*?splits[1]?*?stat[1]?wins
                    return
                    <team id="{$team?id}" >
                        <teamName>{$team?name}</teamName>
                        <teamStats>
                            <wins>{$team?teamStats[1]?*?splits[1]?*?stat[1]?wins}</wins>
                            <losses>{$team?teamStats[1]?*?splits[1]?*?stat[1]?losses}</losses>
                            <pts>{$team?teamStats[1]?*?splits[1]?*?stat[1]?pts}</pts>
                        </teamStats>
                        <players>
                        {
                        for $roster in  $team?roster?roster?*
                        return
                            <player jerseyNumber="{$roster?jerseyNumber}">{$roster?person?fullName}</player>
                         }
                        </players>
                    </team>
            }
        </teams>
    }
    }