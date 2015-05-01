/* Kevin Dittmar and Anthony Ratliff
 * 6 May 2014
 * reviews.js handles the JavaScript for reviews and
 * recommendations.  It analyzes the user's preferences
 * to give more accurate recommendations.
 */
var user_index = 0;
var critic_index = 0;
var original_score;
var new_value;

/* Initialize the reviews area by hiding
 * all of the reviews and showing the first
 * reviews from users and critics.  Also sets
 * the original score to the aggregate score
 * calculated by the Perl scripts.
 */
function initialize(){
    $(".user_review").hide();
    $(".critic_review").hide();
    $("#user0").show();
    $("#critic0").show();
    $(".preference").click(function() {
        calculateRecommendation();
    });
    original_score = parseFloat($("#aggregate_score").text());
    generateRecommendation();
}

/* Hide the current user review and fade into
 * the next one.
 */
function nextUserReview(){
    $("#user"+user_index).hide();
    user_index++;
    if (user_index >= $(".user_review").length){
        user_index = 0;
    }
    $("#user"+user_index).fadeIn(500);
    console.log(user_index);
}

/* Hide the current user review and fade into
 * the previous one.
 */
function lastUserReview(){
    $("#user"+user_index).hide();
    user_index--;
    if (user_index < 0){
        user_index = $(".user_review").length - 1;
    }
    $("#user"+user_index).fadeIn(500);
    console.log(user_index);
}

/* Hide the current critic review and fade into
 * the next one.
 */
function nextCriticReview(){
    $("#critic"+critic_index).hide();
    critic_index++;
    if (critic_index >= $(".critic_review").length){
        critic_index = 0;
    }
    $("#critic"+critic_index).fadeIn(500);
}

/* Hide the current critic review and fade into
 * the previous one.
 */
function lastCriticReview(){
    $("#critic"+critic_index).hide();
    critic_index--;
    if (critic_index < 0){
        critic_index = $(".critic_review").length - 1;
    }
    $("#critic"+critic_index).fadeIn(500);
}

/* Generate a recommendation based on the weighted
 * version of the score generated from data scraped
 * by the Perl scripts.
 */
function generateRecommendation(){
    $(".recommendation").hide();
    //aggregate score is a hidden value used to determine what should be displayed
    var tempValue = parseFloat($("#aggregate_score").text());
    if(tempValue > 90){
        $("#highlyRecommended").toggle();
    }
    else if(tempValue > 75){
        $("#recommended").toggle();
    }
    else if(tempValue > 50){
        $("#mildlyRecommended").toggle();
    }
    else if(tempValue > 25){
        $("#notReallyRecommended").toggle();
    }
    else if(tempValue > 0){
        $("#notRecommended").toggle();
    }
    else{
        $("#noRecommendation").toggle();
    }
}

/* Add weight to the recommendation based on the preferences
 * checked by the user.
 */
function calculateRecommendation(){
    /*Split function information:
     *http://www.w3schools.com/jsref/jsref_split.asp
     */
    var genres = $("#genres").text();
    /*Testing for undefined variable information from:
     *http://stackoverflow.com/questions/7578917/test-if-a-variable-is-defined-in-javascript
     */ 
    if(genres.indexOf("3rd Person Shooter") > -1){
        genres = genres.replace("3rd Person Shooter", "3rd-Person-Shooter");
    }
    if(typeof genres != undefined){
        genres = genres.split(" ");
        var value = 1;
        $(".preference:checked").each(function () {
    	    if($.inArray($(this).val(), genres) > -1) {
    		    value += .075;
    	    }	
        });
        /* Get the first time in the playtime table, then split the text on :
         * to seperate the hours and the minutes
         */
        var tabletime = $(".time").first().text().split(":");
   	    var finaltime = parseFloat(tabletime[0]) + parseFloat(tabletime[1])/60.0;
        /* Check to see if the longgame checkbox is checked, 
         * and the game length is greater than 30 hours
         */
        if($('.preference[value="longgame"]').prop('checked')&& 
           finaltime > 30){
            value += .075;	
        }
        //Check to see if shortgame is checked and game length is less than 5 hours
        else if($('.preference[value="shortgame"]').prop('checked') && 
                finaltime < 5) {
            value += .075;
        }
        new_value = original_score * value;
        $("#aggregate_score").html(new_value);
        generateRecommendation();	
    }
}
