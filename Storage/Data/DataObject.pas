namespace iOSApp.Core.Storage.Data;

uses
  Realm.*,
  Foundation;

type

  DataObject = public class(RLMObject)
  public
    property Modified:Boolean;
    property Deleted:Boolean;
  end;


end.