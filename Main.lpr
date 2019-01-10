{
  Copyright 2019 Valter Buccinà.

  "Demo Sprite Castle Game Engine" is free software; see the file LICENSE,
  included in this distribution, for details about the copyright.
  https://github.com/valterb/spritesheet-utility/blob/master/LICENSE

  See the README.md file for details on using the software.
  https://github.com/valterb/spritesheet-utility/blob/master/README.md

  "Demo Sprite Castle Game Engine" is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

  ----------------------------------------------------------------------------
}

program Main;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, lazcontrols, unitmain, castle_components
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.

