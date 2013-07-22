//
// Github Extension (WIP)
// ~~strike-through~~  -> <del>strike-through</del>
//
(function(){
  var github = function(converter) {
    return [
      {
       // github links
       type  : 'lang',
       regex  : '\\[\\[([^\\]]+)\\]\\]',
       replace : function(string, match ,y) {
         return '<a href="' + match + '">' + match + '</a>';
       }
      }
    ];
  };

  if (Showdown && Showdown.extensions) { Showdown.extensions.github = github; }
}());
