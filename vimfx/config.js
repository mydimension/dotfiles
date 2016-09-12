let map = (shortcuts, command, custom=false) => {
    vimfx.set(`${custom ? 'custom.' : ''}mode.normal.${command}`, shortcuts)
}

map('',  'scroll_half_page_down');
map('d', 'tab_close');

vimfx.on('locationChange', ({vim, location}) => {
    if (location.hostname.match(/^(?:www\.)?amazon\.com/)) {
        vim.browser.loadURI(location.toString().replace(/:\/\/(?:www\.)?amazon\.com/, '://smile.amazon.com'));
    }
});
