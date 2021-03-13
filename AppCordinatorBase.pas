namespace iOSApp.Core;

uses
  Foundation,
  UIKit;

type


  AppCordinatorBase = public class
  private

    _navController : UINavigationController;
    _window: UIWindow;

  protected

    _appDelegate: not nullable IUIApplicationDelegate;


    method FindUIViewController:UIViewController;
    begin
      var rootController := _appDelegate.window.rootViewController;
      var foundController:UIViewController;

      if(assigned(rootController))then
      begin
        var visibleController:NSObject := nil;

        var someController := rootController;

        if(assigned(rootController.presentedViewController))then
        begin
          someController := rootController.presentedViewController;
        end;

        if(someController is UINavigationController)then
        begin
          visibleController := UINavigationController(someController).viewControllers.lastObject;
        end
        else if (someController is UITabBarController)then
        begin
          visibleController := UITabBarController(someController).selectedViewController;
        end
        else
        begin
          visibleController := someController;
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
      var rootViewController := _appDelegate.window.rootViewController;
      var receiver:IServiceEventReceiver := nil;

      if(not assigned(rootViewController))then
      begin
        exit nil;
      end;

      if(rootViewController is IServiceEventReceiver)then
      begin
        exit rootViewController as IServiceEventReceiver;
      end;

      var visibleController:NSObject := nil;

      if(not assigned(rootViewController.presentedViewController))then
      begin
        visibleController := rootViewController;
      end
      else
      begin
        visibleController := rootViewController.presentedViewController;
      end;

      if(visibleController is UINavigationController)then
      begin
        visibleController := UINavigationController(visibleController).topViewController;
      end
      else if (visibleController is UITabBarController)then
      begin
        visibleController := UITabBarController(visibleController).selectedViewController;
      end;

      if (visibleController is IServiceEventReceiver) then
      begin
        receiver := visibleController as IServiceEventReceiver;
      end;

      if(not assigned(receiver))then
      begin
        if(rootViewController is UINavigationController)then
        begin
          visibleController := UINavigationController(rootViewController).topViewController;
        end
        else if (rootViewController is UITabBarController)then
        begin
          visibleController := UITabBarController(rootViewController).selectedViewController;
        end;

        if (visibleController is IServiceEventReceiver) then
        begin
          receiver := visibleController as IServiceEventReceiver;
        end;

      end;

      exit receiver;
    end;


  public

    constructor WithAppDelegate(appDelegate: not nullable IUIApplicationDelegate);
    begin
      inherited constructor;
      _appDelegate := appDelegate;
    end;

    constructor WithNavigationController(navigationController:UINavigationController) Window(window:UIWindow) AppDelegate(appDelegate: not nullable IUIApplicationDelegate);
    begin

      _navController := navigationController;
      _window := window;

      constructor WithAppDelegate(appDelegate);

    end;


  end;

end.