(function() {
    var root_element = document.getElementById('yc-root');
    var show_menu = function(e) {
        if (e.type === 'keydown') {
            if (e.keyCode !== 13) {
                return;
            }
        }
        var target = e.target;
        if (target.tagName === 'NAV' && target.classList.contains('user')) {
            target.classList.toggle('active');
            root_element.classList.toggle('show-user-menu');
        }
        else if (target.tagName === 'A' &&
                 target.classList.contains('show-main-menu')) {
            root_element.classList.toggle('show-main-menu');
        }
        else if (target.id === 'veil') {
            if (root_element.classList.contains('show-main-menu')) {
                root_element.classList.remove('show-main-menu');
            }
            if (root_element.classList.contains('show-user-menu')) {
                root_element.classList.remove('show-user-menu');
                var user_menu = root_element.querySelector('nav.user');
                if (user_menu) {
                    user_menu.classList.remove('active');
                }
            }
        }
    };
    root_element.addEventListener('click', show_menu);
    root_element.addEventListener('keydown', show_menu);
})();
