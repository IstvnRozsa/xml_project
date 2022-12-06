(: Idozonankenti csapatok szama :)
xquery version "3.1";

import schema default element namespace "" at "data/schema06.xsd";

declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";

declare option output:method "xml";
declare option output:indent "yes";

let $nhlteams := json-doc("data/teams.json")?teams?*
return validate {
    document {
        <document xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                    xsi:noNamespaceSchemaLocation="data/schema06.xsd">
            {
                for $team in $nhlteams
                    let $timezone := $team?venue?timeZone?id
                    group by $timezone
                    return
                    <tzCount name="{$timezone}">{count($team)}</tzCount>
            }
        </document>
    }
}