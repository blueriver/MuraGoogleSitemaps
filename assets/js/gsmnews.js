Mura(function() {



  Vue.component('criteria-add', {
		template: '#criteria-add',
    props: ['item','index'],
		methods: {
      addCriteria: function() {
        this.$parent.addCriteria();
      },
      removeCriteria: function(index) {
        this.$parent.removeCriteria(index);
      }
		}
	});

  Vue.component('criteria-box', {
		template: '#criteria-box',
    props: ['criteria'],
		methods: {
      addCriteria: function() {
        this.$parent.addCriteria();
      },
      removeCriteria: function(index) {
        this.$parent.removeCriteria(index);
      }
		}
	});

  GSMNews = new Vue({
    el: '#container-gsmnews',
    data: {
      criteriaformat: {},
      criteria: [],
      criteriajson: ""
    },
    mounted: function() {
      this.criteriaformat = {'paramrelationship':'and','paramfield':'','paramcondition':'EQ','paramcriteria':''};
      if($("#criteriajson").val() == "") {
        this.criteria.push(JSON.parse(JSON.stringify(this.criteriaformat)));
      }
      else {
        this.criteria = JSON.parse($("#criteriajson").val());
      }
    },
    destroyed: function() {
      console.log('main destroyed');
    },
    methods: {
      addCriteria: function() {
        this.criteria.push(JSON.parse(JSON.stringify(this.criteriaformat)));
      },
      removeCriteria: function(index) {
        this.criteria.splice(index,1);
      },
      saveJSON: function() {
        this.criteriajson = JSON.stringify(this.criteria);
        $("#criteriajson").val(this.criteriajson);
        $("#newsform").submit();
      }
    }
  });

});
