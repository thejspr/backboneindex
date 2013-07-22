//
//  Github Extension (WIP)
//  ~~strike-through~~   ->  <del>strike-through</del>
//

(function(){
    var github = function(converter) {
        return [
            {
              // github links
              type    : 'lang',
              regex   : '\\[\\[([^\\]]+)\\]\\]',
              replace : function(string, match ,y) {
                  return '<a href="' + match + '">' + match + '</a>';
              }
            }
        ];
    };

    // Client-side export
    if (typeof window !== 'undefined' && window.Showdown && window.Showdown.extensions) { window.Showdown.extensions.github = github; }
    // Server-side export
    if (typeof module !== 'undefined') module.exports = github;
}());
