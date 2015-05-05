// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require ./jquery.timeago.js
//= require ./angular.min
//= require ./angular-sanitize.min
//= require_tree .

//=require linkurious/sigma.require.js
//=require linkurious/plugins/sigma.parsers.gexf.min.js
//=require linkurious/plugins/sigma.parsers.json.min.js
//=require linkurious/plugins/sigma.plugins.locate.min.js
//=require linkurious/plugins/sigma.plugins.animate.min.js
//=require linkurious/plugins/sigma.plugins.activeState.min.js
//=require linkurious/plugins/sigma.plugins.neighborhoods.min.js
//=require linkurious/plugins/sigma.layout.forceAtlas2.min.js
//=require linkurious/plugins/sigma.renderers.linkurious/settings.js
//=require linkurious/plugins/sigma.renderers.linkurious/canvas/sigma.canvas.labels.def.js
//=require linkurious/plugins/sigma.renderers.linkurious/canvas/sigma.canvas.hovers.def.js
//=require linkurious/plugins/sigma.renderers.linkurious/canvas/sigma.canvas.nodes.def.js
//=require linkurious/plugins/sigma.renderers.linkurious/canvas/sigma.canvas.nodes.cross.js
//=require linkurious/plugins/sigma.renderers.linkurious/canvas/sigma.canvas.nodes.diamond.js
//=require linkurious/plugins/sigma.renderers.linkurious/canvas/sigma.canvas.nodes.equilateral.js
//=require linkurious/plugins/sigma.renderers.linkurious/canvas/sigma.canvas.nodes.square.js
//=require linkurious/plugins/sigma.renderers.linkurious/canvas/sigma.canvas.nodes.star.js
//=require linkurious/plugins/sigma.renderers.linkurious/canvas/sigma.canvas.edges.def.js
//=require linkurious/plugins/sigma.renderers.linkurious/canvas/sigma.canvas.edges.curve.js
//=require linkurious/plugins/sigma.renderers.linkurious/canvas/sigma.canvas.edges.arrow.js
//=require linkurious/plugins/sigma.renderers.linkurious/canvas/sigma.canvas.edges.curvedArrow.js

function hsvToRgb(h, s, v) {
  var r, g, b;
  var i;
  var f, p, q, t;

  // Make sure our arguments stay in-range
  h = Math.max(0, Math.min(360, h));
  s = Math.max(0, Math.min(100, s));
  v = Math.max(0, Math.min(100, v));

  // We accept saturation and value arguments from 0 to 100 because that's
  // how Photoshop represents those values. Internally, however, the
  // saturation and value are calculated from a range of 0 to 1. We make
  // That conversion here.
  s /= 100;
  v /= 100;

  if(s == 0) {
  // Achromatic (grey)
  r = g = b = v;
  return [Math.round(r * 255), Math.round(g * 255), Math.round(b * 255)];
  }

  h /= 60; // sector 0 to 5
  i = Math.floor(h);
  f = h - i; // factorial part of h
  p = v * (1 - s);
  q = v * (1 - s * f);
  t = v * (1 - s * (1 - f));

  switch(i) {
  case 0:
  r = v;
  g = t;
  b = p;
  break;

  case 1:
  r = q;
  g = v;
  b = p;
  break;

  case 2:
  r = p;
  g = v;
  b = t;
  break;

  case 3:
  r = p;
  g = q;
  b = v;
  break;

  case 4:
  r = t;
  g = p;
  b = v;
  break;

  default: // case 5:
  r = v;
  g = p;
  b = q;
  }

  return [Math.round(r * 255), Math.round(g * 255), Math.round(b * 255)];
}
