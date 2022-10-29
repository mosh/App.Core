namespace iOSApp.Core;

uses
  Foundation,
  iOSApp.Core.Storage,
  Moshine.Foundation;

type

  ServiceBase<S> = public abstract class where S is StorageBase;

  private
    _storage:S;

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
      workerQueue := new NSOperationQueue;

    end;


  public

    constructor withStorage(someStorage:S);
    begin
      workerQueue := new NSOperationQueue();
      self._storage := someStorage;

      Storage.launch;
    end;

    method Storage:StorageBase;
    begin
      exit _storage;
    end;

    property InProgress:Boolean read
      begin
        exit (NSOperationQueue.mainQueue.operationCount>0);
      end;

    method offset:Integer;
    begin
      var localTimeZone := NSTimeZone.localTimeZone;
      var offsetInMinutes := (localTimeZone.secondsFromGMT/60);

      if(localTimeZone.isDaylightSavingTime)then
      begin
        offsetInMinutes := offsetInMinutes - Integer((localTimeZone.daylightSavingTimeOffset/60));
      end;
      exit offsetInMinutes;
    end;


    method offline:Boolean;
    begin
      NSLog('%@','Checking Network Status...');
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