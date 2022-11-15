xquery version "3.1";
let $valami := fn:json-doc("teams")
return document {
    <html>
        <head>
            <title>{$valami?copyright}</title>
            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css"/>
        </head>
        <body>
            <table class="table table-bordered table-hover caption-top">
                <caption>Teams</caption>
                <thead>
                    <tr>
                        <th>Name</th>
                        <th>Team Name</th>
                        <th>Location</th>
                        <th>First Year of Play</th>
                        <th>Short Name</th>
                    </tr>
                </thead>
                <tbody>
                    {
                        for $x in $valami?teams?*
                            return 
                            <tr>
                                <td>{$x?name}</td>
                                <td>{$x?teamName}</td>
                                <td>{$x?locationName}</td>
                                <td>{$x?firstYearOfPlay}</td>
                                <td>{$x?shortName}</td>
                            </tr>
                    }
                </tbody>
            </table>
        </body>
    </html>
}