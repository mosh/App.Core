namespace iOSApp.Core;

uses
  Foundation,
  Moshine.Foundation,
  UIkit;

type

  UIViewControllerExtensions = public extension class (UIViewController)
  public

    method displayAlertForException(e:NSException);
    begin
      var title := 'Application error.';
      var message := 'Sorry an unknown error occurred.';

      if(e is HttpStatusCodeException)then
      begin
        var httpError := HttpStatusCodeException(e);

        var stringError := $'Error {httpError.StatusCode}';

        if(httpError.StatusCode=500)then
        begin
          stringError := 'Internal server error';
        end;

        message := NSString.stringWithFormat('%@ when calling %@',stringError,httpError.Url);
      end
      else if (e is NoNetworkConnectionException)then
      begin
        message := 'The action could not be performed, there is no internet connection.';
      end;

      var alert := UIAlertController.alertControllerWithTitle(title) message(message) preferredStyle(UIAlertControllerStyle.ActionSheet);

      var okAction := UIAlertAction.actionWithTitle('Ok') style(UIAlertActionStyle.Default) handler(method (alertAction:UIAlertAction) begin

      end);

      alert.addAction(okAction);

        // Support presentation in iPad
      alert.popoverPresentationController:sourceView := self.view;
      alert.popoverPresentationController:sourceRect := CGRectMake(self.view.bounds.size.width / 2.0, self.view.bounds.size.height / 2.0, 1.0, 1.0);

      self.presentViewController(alert) animated(true) completion(nil);

    end;
  end;

end.