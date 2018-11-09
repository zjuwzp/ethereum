App = {
  web3Provider: null,
  contracts: {},

  init: function() {
    // Load pets.
    $.getJSON('../pets.json', function(data) {
      var petsRow = $('#petsRow');
      var petTemplate = $('#petTemplate');
	  
	  //把一个个pet对象赋值到模板对应的标签上去
      for (i = 0; i < data.length; i ++) {
        petTemplate.find('.panel-title').text(data[i].name);
        petTemplate.find('img').attr('src', data[i].picture);
        petTemplate.find('.pet-breed').text(data[i].breed);
        petTemplate.find('.pet-age').text(data[i].age);
        petTemplate.find('.pet-location').text(data[i].location);
        petTemplate.find('.btn-adopt').attr('data-id', data[i].id);

        petsRow.append(petTemplate.html());
      }
    });

    return App.initWeb3();
  },

  initWeb3: function() {			//初始化web3
	//web3初始化过程参考：https://github.com/ethereum/web3.js
	
    if (typeof web3 !== 'undefined') {
      App.web3Provider = web3.currentProvider;
    } else {
      App.web3Provider = new Web3.prviders.HttpProvider("http://127.0.0.1:7545");
    }
    web3 = new Web3(App.web3Provider);

    return App.initContract();
  },

  initContract: function() {		//初始化合约
    $.getJSON('Adoption.json', function(data) {   //为何可直接加载Adoption.json文件呢，这是因为./build/contracts目录亿配置到服务器的环境中
      var AdoptionArtifact = data;

      App.contracts.Adoption = TruffleContract(AdoptionArtifact);
      App.contracts.Adoption.setProvider(App.web3Provider);

      return App.markAdopted();
    });

    return App.bindEvents();
  },

  bindEvents: function() {			//绑定事件
    $(document).on('click', '.btn-adopt', App.handleAdopt);		//btn-adopt是index.html,当这个按钮被点击时调用App的handleAdopt方法
  },

  markAdopted: function(adopters, account) {		//标记当前的宠物是否被领养
    
    var apotionInstance;
    App.contracts.Adoption.deployed().then(function(instance) {
      apotionInstance = instance;
      return apotionInstance.getAdopters.call();
    }).then(function(adopters) {
      
      for(i =0; i< adopters.length; i++) {
        console.log(adopters[i]);
        if(adopters[i] !== '0x0000000000000000000000000000000000000000') {
          $('.panel-pet').eq(i).find('button').text('Success').attr('disabled', true);
        }
      }
    }).catch(function(err) {
      console.log(err.message);
    })
  },

  handleAdopt: function(event) {
    event.preventDefault();
    var apotionInstance;
    var petId = parseInt($(event.target).data('id'));

    web3.eth.getAccounts(function(error, accounts){
      var account = accounts[0];

      App.contracts.Adoption.deployed().then(function(instance){
        apotionInstance = instance;

        return apotionInstance.adopt(petId, {from: account});
      }).then(function(result) {
        return App.markAdopted();
      } ).catch(function(err) {
        console.log(err.message);
      });
    });
  }
};

$(function() {
  $(window).load(function() {		//当window被加载时，会调用App.init
    App.init();
  });
});
