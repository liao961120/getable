// Main function
window.addEventListener("load", function () {
    updateTables();
})


// Update document
function updateTables() {
    // Create tables from JSON
    document.querySelectorAll('div[id^="data-from-web"].data-from-web-json')
        .forEach(elem => {
            createFromJSON(elem.getAttribute("id"), elem.getAttribute("data-url"));
    });
    
    // Create tables from csv
    document.querySelectorAll('div[id^="data-from-web"].data-from-web-csv')
        .forEach(elem => {
            createFromCSV(elem.getAttribute("id"), elem.getAttribute("data-url"));
    });
    
    // Create tables from Gsheet
    document.querySelectorAll('div[id^="data-from-web"].data-from-web-gsheet')
        .forEach(elem => {
            createFromGsheet(elem.getAttribute("id"), elem.getAttribute("data-url"));
    });
}


// Create table from self-hosted csv files
function createFromCSV(dom_id, url) {
    // Use PapaParse
    var csv_data = Papa.parse(url, {
        download: true,
        header: true,
        // Callback function
        complete: function(results) {
            var div = document.getElementById(dom_id)
            div.innerHTML = '';
            div.appendChild(buildHtmlTable(results.data));
        }
    });
}


// Create table from self-hosted json files
function createFromJSON(dom_id, url) {
    // HTTP request
    axios({
        method: 'get',
        url: url
    }).then(resp => {
        return resp.data;
    }).then(data => {
        var div = document.getElementById(dom_id)
        div.innerHTML = '';
        div.appendChild(buildHtmlTable(data));
    })
}

// Create table from by Gsheet
function createFromGsheet(dom_id, url) {
    createFromCSV(dom_id, `https://cors-anywhere.herokuapp.com/${url}`);
}


// Builds the HTML Table out of myList json data from Ivy restful service.
function buildHtmlTable(arr) {
    var table = _table_.cloneNode(false),
        columns = addAllColumnHeaders(arr, table);
    for (var i = 0, maxi = arr.length; i < maxi; ++i) {
        var tr = _tr_.cloneNode(false);
        for (var j = 0, maxj = columns.length; j < maxj; ++j) {
            var td = _td_.cloneNode(false);
            cellValue = arr[i][columns[j]];
            td.appendChild(document.createTextNode(arr[i][columns[j]] || ''));
            tr.appendChild(td);
        }
        table.appendChild(tr);
    }
    return table;
}

// Adds a header row to the table and returns the set of columns.
// Need to do union of keys from all records as some records may not contain
// all records
function addAllColumnHeaders(arr, table) {
    var columnSet = [],
        tr = _tr_.cloneNode(false);
    for (var i = 0, l = arr.length; i < l; i++) {
        for (var key in arr[i]) {
            if (arr[i].hasOwnProperty(key) && columnSet.indexOf(key) === -1) {
                columnSet.push(key);
                var th = _th_.cloneNode(false);
                th.appendChild(document.createTextNode(key));
                tr.appendChild(th);
            }
        }
    }
    table.appendChild(tr);
    return columnSet;
}


// Table element to use in function
var _table_ = document.createElement('table'),
    _tr_ = document.createElement('tr'),
    _th_ = document.createElement('th'),
    _td_ = document.createElement('td');




/*///////// Olde version (ajax) ////////////

function createFromGsheet(dom_id, url) {
    // Send ajax request
    axios({
        methods: 'get',
        url: `https://cors-anywhere.herokuapp.com/${url}`
    })
        .then(resp => {
            // Parse gsheet tsv
            var df = resp.data.split('\r\n').map(x => x.split('\t'));
            var json = [];
            for (var i = 1; i < df.length; i++) {
                var row = {};
                for (var j = 0; j < df[0].length; j++) {
                    var colname = df[0][j];
                    row[colname] = df[i][j];
                }
                json.push(row);
            }
            return json
        }).then(data => {
            var div = document.getElementById(dom_id)
            div.innerHTML = '';
            div.appendChild(buildHtmlTable(data));
        });
}

*/