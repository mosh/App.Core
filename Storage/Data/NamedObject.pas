namespace iOSApp.Core.Storage.Data;

uses
  Foundation;

type

  NamedObject = public class(DataObject)
  private
  protected
  public
  public
    property Name:NSString;

    class method primaryKey: NSString; override;
    begin
      exit 'Name';
    end;
  end;

end.