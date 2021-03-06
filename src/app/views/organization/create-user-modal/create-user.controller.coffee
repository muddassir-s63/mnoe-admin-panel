@App.controller 'CreateUserController', ($filter, $stateParams, $uibModalInstance, toastr, MnoeUsers, MnoErrorsHandler, USER_ROLES, organization) ->
  'ngInject'
  vm = this
  vm.errorHandler = MnoErrorsHandler

  vm.USER_ROLES = USER_ROLES

  vm.onSubmit = () ->
    vm.isLoading = true
    MnoeUsers.addUser(organization, vm.user).then(
      (success) ->
        toastr.success('mnoe_admin_panel.dashboard.organization.create_user.toastr_success', {extraData: {username: "#{vm.user.name} #{vm.user.surname}"}})
        # Close the modal returning the item to the parent window
        $uibModalInstance.close(success.data.user)
      (error) ->
        toastr.error('mnoe_admin_panel.dashboard.organization.create_user.toastr_error', {extraData: {username: "#{vm.user.name} #{vm.user.surname}"}})
        MnoErrorsHandler.processServerError(error, vm.form.user)
    ).finally(-> vm.isLoading = false)

  vm.onCancel = () ->
    $uibModalInstance.dismiss('cancel')

  return
