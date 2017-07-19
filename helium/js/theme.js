(function() {
    var root_element = document.getElementById('yc-root');
    root_element.addEventListener('click', function(e) {
        var target = e.target;
        if (target.tagName === 'NAV' && target.classList.contains('user')) {
            target.classList.toggle('active');
        }
        else if (target.tagName === 'A' &&
                 target.classList.contains('show-main-menu')) {
            root_element.classList.toggle('show-main-menu');
        }
    });
})();
