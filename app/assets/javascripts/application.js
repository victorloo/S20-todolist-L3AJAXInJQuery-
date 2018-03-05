// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require turbolinks
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require_tree .

// 在 Rails 框架裡實作 jQuery ajax 的版本，
// 我們會需要新增一個套件：jquery_ujs

// jquery_ujs 整合了 jQuery 函式庫與 Rails 內建的方法，
// 其中一個很重要的功能是將 Rails server 的驗證機制內建在 jQuery ajax 方法之中，
// 讓我們可以直接使用 jQuery ajax 方法向 Rails Server 發送非同步請求，不需要另外設定驗證機制。