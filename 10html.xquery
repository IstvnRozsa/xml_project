(: Csapatok listázása, azon belül csapattagok listázása, pozició és mezszám alapján csökkenő sorrendben :)
xquery version "3.1";

declare namespace map = "http://www.w3.org/2005/xpath-functions/map";
declare namespace array = "http://www.w3.org/2005/xpath-functions/array";
declare namespace op = "http://www.w3.org/2002/08/xquery-operators";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";

declare option output:method "html";
declare option output:html-version "5.0";
declare option output:indent "yes";



let $nhlteams := json-doc("teams.json")
return document {
    <html>
        <head>
            <title>NHL Teams</title>
            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"/>
        </head>
        <body>
            <section class="container">
                <h1>NHL csapatok 2021-es adatai</h1>
                <p>{$nhlteams?copyright}</p>
            </section>
            
             {
              for $team in $nhlteams?teams?*
              return
             <section class="container">
                  <h2>{$team?name}</h2>
                  <ul class="list-group">
                    <li class="list-group-item">Város: {$team?locationName}</li>
                    <li class="list-group-item">Divizió: {$team?division?name}</li>
                    <li class="list-group-item">Csapat létszám: {count($team?roster?roster?*)}</li>
                    <li class="list-group-item"><a href="{$team?officialSiteUrl}" target="_blank">Hivatalos oldal</a></li>
                  </ul>
                   <div class="container">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th scope="col">#</th>
                                        <th scope="col">Mezszám</th>
                                        <th scope="col">Játékos</th>
                                        <th scope="col">Pozició 1</th>
                                        <th scope="col">Pozició 2</th>
                                    </tr>
                                </thead>
                                <tbody>
                                {
                                for $roster in  $team?roster?roster?*
                                order by $roster?position?type, $roster?jerseyNumber
                                count $i
                                return
                                            <tr>
                                                <th scope="row">{$i}</th>
                                                <td>{$roster?jerseyNumber}</td>
                                                <td>{$roster?person?fullName}</td>
                                                <td>{$roster?position?type}</td>
                                                <td>{$roster?position?name}</td>
                                            </tr>
                                 }
                                </tbody>
                            </table>
                        </div>
             </section>
            }
            <section class="container">
            <p>Developed by Rozsa Istvan 2022</p>
            </section>
        </body>
    </html>
}
