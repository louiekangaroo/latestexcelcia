var user = angular.module('myUser', []); 

user.controller('myUserCtrl',  ['$scope', '$http', function ($scope, $http) 
{
    var loadUser = function() {
    	$http({method: 'GET', url: 'controllers/usermgmt.php'})
 		.success(function(data) {
        	$scope.users = data;
    	});
    }

    function PopupCenter(url, title, w, h) {
	    // Fixes dual-screen position                         Most browsers      Firefox
	    var dualScreenLeft = window.screenLeft != undefined ? window.screenLeft : screen.left;
	    var dualScreenTop = window.screenTop != undefined ? window.screenTop : screen.top;

	    var width = window.innerWidth ? window.innerWidth : document.documentElement.clientWidth ? document.documentElement.clientWidth : screen.width;
	    var height = window.innerHeight ? window.innerHeight : document.documentElement.clientHeight ? document.documentElement.clientHeight : screen.height;

	    var left = ((width / 2) - (w / 2)) + dualScreenLeft;
	    var top = ((height / 2) - (h / 2)) + dualScreenTop;
	    var newWindow = window.open(url, title, 'scrollbars=yes, width=' + w + ', height=' + h + ', top=' + top + ', left=' + left + ',toolbar=no,menubar=no');

	    // Puts focus on the newWindow
	    if (window.focus) {
	        newWindow.focus();
	    }
	}

    $(".btnNew").click(function() {
    	PopupCenter("addnewusermanagement.php", "Add New User", "900", "600");
    });

    loadUser();

}]);