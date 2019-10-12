/* global $ */
$(document).on('turbolinks:load', function() { 
	/*新規登録ボタン*/
	$('.sign_in').click(function(){
	    $('.modal_wrapper_new').addClass('active');
	});
	
	$('.close_modal_new').click(function() {
	    $('.modal_wrapper_new').removeClass('active');
	});
	
	$('.back_to_window ').click(function(){
		$('.modal_wrapper_new').removeClass('active');
	});
	
	/*ログインボタン*/
	$('.log_in').click(function(){
	    $('.modal_wrapper_session').addClass('active');
	});
	
	$('.close_modal_session').click(function(){
	    $('.modal_wrapper_session').removeClass('active');
	});
	
	$('.back_to_window').click(function(){
		$('.modal_wrapper_session').removeClass('active');
	});
});