namespace iOSApp.Core;

uses
  Foundation;

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

    method get_InProgress:Boolean;
    begin
      exit (NSOperationQueue.mainQueue.operationCount>0);
    end;


  public

    property InProgress:Boolean read get_InProgress;


  end;

end.