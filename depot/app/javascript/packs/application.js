// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
import "@fortawesome/fontawesome-free/js/all"
import "bootstrap"
import "./src/application.scss"
import "select2/dist/css/select2.css"
window.$ = window.jQuery = window.jquery = jQuery;


require( 'jszip' );
require( 'datatables.net-bs4' );
require( 'datatables.net-buttons-bs4' );
require( 'datatables.net-buttons/js/buttons.html5.js' );
require( 'datatables.net-fixedcolumns-bs4' );
require( 'datatables.net-select-bs4' );
require('select2');

$(document).ready(function() {
    setTimeout(function(){
        $("#flash_notice").add("#flash_error").fadeTo(2000, 0).animate({ height: "0px" }, 500)
    },4000);

    $('.navbar-nav li').click(function() {
        $('.navbar-nav li').removeClass('active');
        $(this).addClass('active');
    });

    $("#notice").fadeTo(2000, 500).slideUp(500, function(){
        $("#notice").slideUp(500);
    });

    $("#alert").fadeTo(2000, 500).slideUp(500, function(){
        $("#alert").slideUp(500);
    });

});



