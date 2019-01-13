namespace iOSApp.Core;

uses
  Foundation,
  iOSApp.Core.Storage,
  Moshine.Foundation;

type

  ServiceBase = public class
  private
  protected
    property workerQueue:NSOperationQueue;

    method clearOutstandingWork;
    begin
      if(assigned(workerQueue))then
      begin
        NSLog('%@','clearing outstanding work');
        workerQueue.cancelAllOperations;
      end;
      NSLog('%@','cleared outstanding work');
    end;

    constructor;
    begin
      workerQueue := new NSOperationQueue();

    end;


  public

    property Storage:StorageBase read;

    constructor withStorage(someStorage:StorageBase);
    begin
      workerQueue := new NSOperationQueue();
      self.Storage := someStorage;
    end;

    property InProgress:Boolean read
      begin
        exit (NSOperationQueue.mainQueue.operationCount>0);
      end;

    method offline:Boolean;
    begin
      NSLog('%@','calling reachability');
      try
        var obj := Reachability.reachabilityForInternetConnection;
        var status := obj.currentReachabilityStatus;
        case status of
          NetworkStatus.NotReachable: exit true;
          NetworkStatus.ReachableViaWiFi: exit false;
          NetworkStatus.ReachableViaWWAN: exit false;
        end;
      except
        on E:Exception do
        begin
          NSLog('Reachability Failed with exception %@', E.Message);
          exit true;
        end;
      end;
    end;

  end;

end.