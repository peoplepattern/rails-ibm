// used for controlling when to show/hide the detailed person profile. Also controls the innerworkings/dynamic update of said modal.
/*window.people = {}; //id-mapped list of people we have full profiles for
$(function(){ // jquery on ready
  $(document).on('show.person', function(e){ //show.person events must contain 'personID' fields
    if (window.people[e.personID] != undefined){  // if person is in window.people, then don't get him from db
      // show the modal for this person
      showPerson(e.personID);
    } else {                                      // else get him from db
      //$.get();
    }
  });

  // assumes id is in window.people;
  function showPerson(id) {
  }
}); */

(function(){
  angular.module('personModal', [])
    .controller('PersonModalController', PersonModalController)
    .filter('bigPic', bigPic);

  ///////////////////////
  // controllers
  ///////////////////////

  PersonModalController.$inject = ['$scope'];

  function PersonModalController($scope){
    var vm = this;
    vm.person = {};
    vm.posts = [{content: "blah"},{content: "blah2"}];
    vm.interests = [{title: "sports"},{title: "stuff"}];
    activate();

    function activate(){
      colorInterests();
      angular.element(document).on('show.person', function(e){ //show.person events must contain 'person' field with necessary sub-data
        $scope.$applyAsync(function(){
          vm.person = e.person;
          if (e.posts != undefined) {
            vm.posts = posts;
          }
          if (e.interests != undefined) {
            vm.interests = interests;
            colorInterests();
          }
        });
        angular.element('#personModal').modal('show');
      });
    }

    function colorInterests(){
      var golden_ratio_conjugate = 0.618033988749895;
      for ( var i=0; i<vm.interests.length; i++) {
         var h = Math.random();
         h += golden_ratio_conjugate;
         h = h % 1;
         vm.interests[i].color = 'rgb('+hsvToRgb(h*360, 25, 80).join(',')+');';
      }
    }
  };


  /////////////////////
  // filters
  /////////////////////

  bigPic.$inject = [];

  function bigPic(){
    return function(val){
      return val ? val.replace(/_normal\.(jpg|jpeg)$/, "_200x200.$1") : '';
    };
  };

  // boostrap the angular application which controls the modal
//  angular.bootstrap(angular.element('#personModal'), ['personModal']);
})();
