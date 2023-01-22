import { ajax } from "jquery"

$(window).on('load', () => {
  $('#search').autocomplete({
    delay: 500,
    source:  $('#search-data').data('suggestions'),
    change: function(e, ui) {
      ajax({
        url: "/suggestions-create",
        type: "get",
        data: { text: e.target.value },
        success: function(data) {
          $('#search-data').attr('data-suggestions', JSON.stringify(data));
          $('#search-form').submit()
        },
        error: function(data) {}
      })
    }
  })
})
