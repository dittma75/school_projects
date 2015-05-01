/* sunrise.js - draw some suns
 *
 * D Provine, 11 March 2014
 * Modified by Kevin Dittmar, 25 March 2014
 */

"use strict";

/* Stores sunrise/sunset info from the JSON file.
 */
var suninfo;
/*Global variables for the canvas and context that are needed
 *in all functions.
 */
var canvas;
var context;

// saveReturn parses the JSON data and stores it in suninfo.
function saveReturn(data)
{
    suninfo = JSON.parse(data);
}

/* initialize sets up the canvas and context.
 */
function initialize()
{
    canvas = document.getElementById('sungraph');
    context = canvas.getContext('2d');
}

/* getDateParams retrieves the date parameters from the JQuery
 * datepicker to pass off to the Perl CGI.
 */
function getDateParams()
{
    //DatePicker getDate from: http://api.jqueryui.com/datepicker/
    var currentDate = $( "#datepicker" ).datepicker( "getDate" );
    return currentDate;
}

/* makes a gradient background for the
 * sungraph canvas.
 * Gradient info from:
 * http://www.html5canvastutorials.com/tutorials/html5-canvas-linear-gradients/
 */
function drawBackground()
{
    context.rect(0, 0, canvas.width, canvas.height);
    // add linear gradient
    var grd = context.createLinearGradient(
                canvas.width,	
                0,
                canvas.width,
                canvas.height);
    // dark purple -nighttime sky
    grd.addColorStop(.8, '#140014');
    // light orange -sunrises are lighter
    grd.addColorStop(.725, '#A62E00');
    // light blue -midday sky
    grd.addColorStop(.6, '#7EC6EF');
    // light blue -midday sky
    grd.addColorStop(.35, '#7EC6EF');     
    // vivid orange -sunsets are more brilliant
    grd.addColorStop(.175, '#E62E00');        
    // dark purple -nighttime sky
    grd.addColorStop(.125, '#140014');
    context.fillStyle = grd;
    context.fill();
}

/* drawGrid makes gridlines on the x-axis (each day of sun info) and
 * the y-axis (time in increments of 1 hour).
 */
function drawGrid()
{
    /* line drawing information from:
     * http://www.html5canvastutorials.com/tutorials/html5-canvas-lines/
     * line color information from:
     * http://www.html5canvastutorials.com/tutorials/html5-canvas-line-color/
     */
    for (var x = 0; x < canvas.width ; x += 10)
    {
        context.beginPath();
        context.moveTo(x, 0);
        context.lineTo(x, canvas.height);
        if (x == canvas.width/2)
        {
            context.strokeStyle = '#D0D0D0';
        }
        else
        {
            context.strokeStyle = '#606060';
        }
        context.stroke();
        context.closePath();
    }
    for (var y = 0; y < canvas.height; y+=15)
    {
        context.beginPath();
        context.moveTo(0, y);
        context.lineTo(canvas.width, y);
        context.strokeStyle = '#606060';
        context.stroke();
        context.closePath();
    }
}

/* drawSuns plots circles in yellow for the sunrise points
 * and orange for the sunset points to make the
 * lines of the graph.
 */
function drawSuns()
{
    var x;	//x coordinate
    var y;	//y coordinate
    var date = getDateParams();
    /* Javascript date object info:
     * http://www.w3schools.com/jsref/jsref_obj_date.asp
     */
    ajaxFetch("./sunrise_json.cgi?year=" + date.getFullYear().toString() +
                "&month=" + (date.getMonth() + 1 ).toString()+
                "&day=" + date.getDate().toString(),
                saveReturn);
    // "suninfo" now an array full of info

    // arc takes centerX, centerY, radius, (those obvious)
    //           startangle, endangle, (for drawing arcs)
    //           counterclockwise (true or false)

    for (var i = 0; i < suninfo.SunInfo.length; i++)
    {
        // sunrise
        x = i * 10;
        y = 360 - (suninfo.SunInfo[i].rise/4);
        context.beginPath();
        context.arc(x, y, 3, 0, Math.PI * 2, true);
        context.closePath();
        context.strokeStyle = "#FFFF44";
        context.fillStyle = "#FFFF44";
        context.stroke();
        context.fill();
        console.log("sunrise: x = " + x + " y = " + y);

        // sunset
        y = 360 - (suninfo.SunInfo[i].set/4);
        context.beginPath();
        context.arc(x, y, 3, 0, Math.PI * 2, true);
        context.closePath();
        context.strokeStyle = "#FFCC00";
        context.fillStyle = "#FFCC00";
        context.stroke();
        context.fill();
        console.log("sunset: x = " + x + "  y = " + y);
    }

    /* Clears the context path to prevent artifacts from appearing
     * when repainting the canvas.
     */
    context.beginPath();
    context.closePath();
}

/* Clears the canvas in the case of redrawing.
 * Browser independent method of clearing from:
 * http://stackoverflow.com/questions/2142535/how-to-clear-the-canvas-for-redrawing
*/
function clearGraph()
{
    context.clearRect(0, 0, canvas.width, canvas.height);
}

/* drawGraph draws a graph of sunrise/sunset information.
 */
function drawGraph()
{
    initialize();
    clearGraph();
    drawBackground();
    drawGrid();
    drawSuns();
}

