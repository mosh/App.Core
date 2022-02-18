namespace App.Core;

uses
  Realm;

type

  RLMObjectExtensions = public extension class(RLMObject)
  private
  protected
  public

    class method All<T>:sequence of T; where T is unconstrained;
    begin
      exit allObjectsInRealm(RLMRealm.defaultRealm).Cast<T>;
    end;

    class method All:RLMResults;
    begin
      exit allObjectsInRealm(RLMRealm.defaultRealm);

    end;

  end;

end.