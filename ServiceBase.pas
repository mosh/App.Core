namespace iOSApp.Core;

uses
  Foundation, iOSApp.Core.Storage;

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


  end;

end.