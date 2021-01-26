namespace iOSApp.Core.Storage;

uses
{$IF ISLAND}
  RTL,
{$ENDIF}
  Realm.*;

type

  StorageBase = public class
  private
  protected
  public
    const newItemStartPoint:Integer = -10;

    method launch(migration: RLMMigration; oldSchemaVersion: uint64_t); virtual;
    begin
    end;

    method launch;
    begin

      var config := RLMRealmConfiguration.defaultConfiguration();

      config.schemaVersion := schemaVersion;

      config.migrationBlock := (migration, oldSchemaVersion) -> begin
        launch(migration, oldSchemaVersion);
      end;

      RLMRealmConfiguration.setDefaultConfiguration(config);

    end;

    method schemaVersion:uint64_t;virtual;
    begin
      exit 1;
    end;

  end;

end.