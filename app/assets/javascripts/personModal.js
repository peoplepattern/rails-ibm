// used for controlling when to show/hide the detailed person profile. Also controls the innerworkings/dynamic update of said modal.
(function(){
  angular.module('personModal', ['ngSanitize'])
    .controller('PersonModalController', PersonModalController)
    .controller('SmallSummaryController', SmallSummaryController)
    .controller('PopulationController', PopulationController)
    .filter('bigPic', bigPic)
    .filter('taxonomy', taxonomy)
    .filter('links', links);

  ///////////////////////
  // controllers
  ///////////////////////

  PersonModalController.$inject = ['$scope', '$http'];

  function PersonModalController($scope, $http){
    var vm = this;
    vm.person = {};
    vm.posts = [{content: "blah"},{content: "blah2"}];
    vm.interests = [{title: "sports"},{title: "stuff"}];
    activate();

    function activate(){
      color('interests');
      angular.element(document).on('show.person', function(e){ //show.person events must contain 'person' field with necessary sub-data
        $scope.$applyAsync(function(){
          vm.person = e.person;
          if (e.posts != undefined) {
            vm.posts = posts;
          } else {
            $http.get('posts?id='+e.person.tid)
              .success(function(data){
                vm.posts = data.posts;
                vm.keywords = data.top_keywords;
                sentimentColor('keywords');
                vm.entities = data.top_entities;
                sentimentColor('entities');
                setTimeout(function(){angular.element('abbr.timeago').timeago();}, 500);
              });
          }
          if (e.interests != undefined) {
            vm.interests = interests;
            color('interests');
          }
        });
        angular.element('#personModal').modal('show');
      });
    }

    function color(name){
      var golden_ratio_conjugate = 0.618033988749895;
      for ( var i=0; i<vm[name].length; i++) {
         var h = Math.random();
         h += golden_ratio_conjugate;
         h = h % 1;
         vm[name][i].color = 'rgb('+hsvToRgb(h*360, 25, 80).join(',')+');';
      }
    }
    
    function sentimentColor(name){
      for(var i=0; i<vm[name].length; i++){
        if(vm[name][i].sentiment == 'positive')
          vm[name][i].color = '#87DDAB';
        else if (vm.keywords[i].sentiment == 'neutral')
          vm[name][i].color = '#ccc';
        else
          vm[name][i].color = '#D48A8A';
      }
    }
  };

  SmallSummaryController.$inject = ['$scope'];

  function SmallSummaryController($scope){
    var vm = this;
    vm.person = {};
    activate();

    function activate(){
      angular.element(document).on('show.person.small', function(e){ //show.person events must contain 'person' field with necessary sub-data
        $scope.$applyAsync(function(){
          vm.person = e.person;
        });
      });
      angular.element(document).on('show.person', function(){
        $scope.$applyAsync(function(){
          vm.person = {};
        });
      });
    }
  };

  PopulationController.$inject = ['$scope', '$http'];

  function PopulationController($scope, $http){
    var vm = this;
    vm.show = false;
    vm.getSet = getSet;
    vm.clicked = clicked;

    function activate(){
      $http.get('population')
        .success(function(data){
          vm.keywords = data.top_keywords;
          vm.entities = data.top_entities;
        });
    }

    function getSet(){
      var ids = [], nodes = window.activeState.nodes();
      for(var i=0; i< nodes.length; i++){
        ids.push(nodes[i].id);
      }
      $http.post('population', {ids: ids})
        .success(function(data){
          vm.keywords = data.top_keywords;
          vm.entities = data.top_entities;
        });
    }

    function clicked() {
      vm.show ? vm.show = false : vm.show = true;
      if (vm.show == false) {
        vm.keywords = [];
        vm.entities = [];
      } else {
        if (window.activeState.nodes().length == 0)
          activate();
        else
          getSet();
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

  taxonomy.$inject = [];

  function taxonomy(){
    return function(val){
      return val ? val.split('/').pop() : '';
    };
  };

  links.$inject = ['$sce'];

  function links($sce){
    return function(val){
      return val ? $sce.trustAsHtml(val.replace(/((www\.|http:\/\/)([a-z0-9.\/\&\?=\-:]*\b))/gi, "<a href='http://$3' target='_blank'>$1</a>")) : '';
    }
  }

  // boostrap the angular application which controls the modal
//  angular.bootstrap(angular.element('#personModal'), ['personModal']);
})();
