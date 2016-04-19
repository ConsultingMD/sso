##
# Impersonate JS
# impersonate.js.coffee
#
# JS Scripts for impersonation widget
window.Grnds.Sso.Impersonate =
  initImpersonation: ->
    $('form select.impersonation').change ->
      $form = $(this).closest('form')
      $form.prop('action', $(this).val()).submit()
