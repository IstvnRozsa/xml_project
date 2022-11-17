(: Idozonankenti csapatok szama :)
xquery version "3.1";

import schema default element namespace "" at "schema06.xsd";

declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";

declare option output:method "xml";
declare option output:indent "yes";

let $nhlteams := json-doc("teams.json")?teams?*
return validate {
    document {
        <document xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                    xsi:noNamespaceSchemaLocation="schema06.xsd">
            {
                for $team in $nhlteams
                    let $timezone := $team?venue?timeZone?id
                    group by $timezone
                    return
                    <tzcount name="{$timezone}">{count($team)}</tzcount>
            }
        </document>
    }
}
