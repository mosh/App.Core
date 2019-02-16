namespace iOSApp.Core;

uses
  Foundation,
  UIKit;

type

  // Interface used to indicate View can receive
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
      end
      else
      begin
        visibleController := visibleController;
      end;

      if (visibleController is IServiceEventReceiver) then
      begin
        receiver := visibleController as IServiceEventReceiver;
      end;
      exit receiver;
    end;


  public

    method initWithAppDelegate(appDelegate: not nullable IUIApplicationDelegate): InstanceType;
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