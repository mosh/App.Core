namespace iOSApp.Core;

uses
  Foundation,
  UIKit;

type

  IServiceEventReceiver = public interface
    method OnError(e:Exception); optional;
  end;

  AppCordinatorBase = public class
  private

  protected

    _appDelegate: not nullable IUIApplicationDelegate;


    method FindUIViewController:UIViewController;
    begin
      var rootController := _appDelegate.window.rootViewController;
      var foundController:UIViewController;

      if(assigned(rootController))then
      begin
        var visibleController:NSObject := nil;

        if(not assigned(rootController.presentedViewController))then
        begin
          visibleController := rootController;
        end
        else
        begin
          if(rootController.presentedViewController is UINavigationController)then
          begin
            visibleController := UINavigationController(rootController.presentedViewController).viewControllers.lastObject;
          end
          else if (rootController.presentedViewController is UITabBarController)then
          begin
            visibleController := UITabBarController(rootController.presentedViewController).selectedViewController;
          end
          else
          begin
            visibleController := rootController.presentedViewController;
          end;
        end;

        if((assigned(visibleController)) and (visibleController is UIViewController))then
        begin
          foundController := visibleController as UIViewController;
        end;

      end;

      exit foundController;

    end;

    method FindReceiver:IServiceEventReceiver;
    begin
      var rootController := _appDelegate.window.rootViewController;
      var receiver:IServiceEventReceiver := nil;

      if(assigned(rootController))then
      begin
        var visibleController:NSObject := nil;

        if(not assigned(rootController.presentedViewController))then
        begin
          visibleController := rootController;
        end
        else
        begin
          if(rootController.presentedViewController is UINavigationController)then
          begin
            visibleController := UINavigationController(rootController.presentedViewController).viewControllers.lastObject;
          end
          else if (rootController.presentedViewController is UITabBarController)then
          begin
            visibleController := UITabBarController(rootController.presentedViewController).selectedViewController;
          end
          else
          begin
            visibleController := rootController.presentedViewController;
          end;
        end;

        if (visibleController is IServiceEventReceiver) then
        begin
          receiver := visibleController as IServiceEventReceiver;
        end;
      end;
      exit receiver;
    end;


  public

    method initWithAppDelegate(appDelegate: not nullable IUIApplicationDelegate): instancetype;
    begin
      self := inherited init;
      if assigned(self) then
      begin
        _appDelegate := appDelegate;

      end;
      result := self;
    end;

  end;

end.