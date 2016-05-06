app.controller("BoardsController", ["$scope", "$http", function($scope, $http) {
  $scope.getBoards = function () {
    $http.get("http://localhost:3000/api/boards").success(function(response) {
      $scope.boards = response.boards;
    });
  }
}]);
