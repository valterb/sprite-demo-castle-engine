unit unitmain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, SpinEx, Forms, Controls, Graphics, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls, math, CastleControl, CastleGLImages,
  CastleVectors, CastleTimeUtils, CastleUIControls, CastleFilesUtils,
  CastleKeysMouse, CastleRectangles, CastleUtils, CastleControls, CastleColors;

const
  C_AnimIdleUp = 1;
  C_AnimIdleUpRight = 2;
  C_AnimIdleRight = 3;
  C_AnimIdleDownRight = 4;
  C_AnimIdleDown = 5;
  C_AnimIdleDownLeft = 6;
  C_AnimIdleLeft = 7;
  C_AnimIdleUpLeft = 8;

  C_AnimWalkUp = 9;
  C_AnimWalkUpRight = 10;
  C_AnimWalkRight = 11;
  C_AnimWalkDownRight = 12;
  C_AnimWalkDown = 13;
  C_AnimWalkDownLeft = 14;
  C_AnimWalkLeft = 15;
  C_AnimWalkUpLeft = 16;

  C_AnimRunUp = 17;
  C_AnimRunUpRight = 18;
  C_AnimRunRight = 19;
  C_AnimRunDownRight = 20;
  C_AnimRunDown = 21;
  C_AnimRunDownLeft = 22;
  C_AnimRunLeft = 23;
  C_AnimRunUpLeft = 24;

type

  TPlayer = class
  public
    IdleDown, IdleDownLeft, IdleDownRight, IdleLeft,
    IdleRight, IdleUp, IdleUpLeft, IdleUpRight,
    WalkLeft, WalkRight, WalkUp, WalkUpLeft,
    WalkUpRight, WalkDown, WalkDownRight, WalkDownLeft,
    RunLeft, RunRight, RunUp, RunUpLeft,
    RunUpRight, RunDown, RunDownRight, RunDownLeft: TSprite;
    AnimIdleDown, AnimIdleDownLeft, AnimIdleDownRight, AnimIdleLeft,
    AnimIdleRight, AnimIdleUp, AnimIdleUpLeft, AnimIdleUpRight,
    AnimWalkLeft, AnimWalkRight, AnimWalkUp, AnimWalkUpLeft,
    AnimWalkUpRight, AnimWalkDown, AnimWalkDownRight, AnimWalkDownLeft,
    AnimRunUp, AnimRunUpRight, AnimRunRight, AnimRunDownRight,
    AnimRunDown, AnimRunDownLeft, AnimRunLeft, AnimRunUpLeft: Integer;
    constructor Create;
    destructor Destroy; override;

   public
     CurrentAnimationID: Integer;
     function CurrentAnimation: TSprite;
  end;

  { TMainForm }

  TMainForm = class(TForm)
    BtnCenterSprite: TButton;
    BtnGoniometer: TButton;
    BtnRoad: TButton;
    BtnOptimizeRoad: TButton;
    BtnDefaultValue: TButton;
    CastleControl1: TCastleControl;
    DOWNLEFTMax: TFloatSpinEditEx;
    DOWNLEFTMin: TFloatSpinEditEx;
    DOWNMax: TFloatSpinEditEx;
    DOWNMin: TFloatSpinEditEx;
    DOWNRIGHTMax: TFloatSpinEditEx;
    DOWNRIGHTMin: TFloatSpinEditEx;
    GBSettings: TGroupBox;
    Label1: TLabel;
    Label10: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    Label16: TLabel;
    Label18: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    LblSpeed: TLabel;
    LEFTMax: TFloatSpinEditEx;
    LEFTMin: TFloatSpinEditEx;
    Panel1: TPanel;
    Panel2: TPanel;
    RIGHTMax: TFloatSpinEditEx;
    RIGHTMin: TFloatSpinEditEx;
    RunSpeed: TFloatSpinEditEx;
    UPLEFTMax: TFloatSpinEditEx;
    UPLEFTMin: TFloatSpinEditEx;
    UPMax: TFloatSpinEditEx;
    UPMin: TFloatSpinEditEx;
    UPRIGHTMax: TFloatSpinEditEx;
    UPRIGHTMin: TFloatSpinEditEx;
    WalkSpeed: TFloatSpinEditEx;
    procedure BtnGoniometerClick(Sender: TObject);
    procedure BtnOptimizeRoadClick(Sender: TObject);
    procedure BtnRoadClick(Sender: TObject);
    procedure BtnCenterSpriteClick(Sender: TObject);
    procedure BtnDefaultValueClick(Sender: TObject);
    procedure CastleControl1DblClick(Sender: TObject);
    procedure CastleControl1Press(Sender: TObject;
      const Event: TInputPressRelease);
    procedure CastleControl1Render(Sender: TObject);
    procedure CastleControl1Update(Sender: TObject);
    procedure DOWNLEFTMaxChange(Sender: TObject);
    procedure DOWNLEFTMinChange(Sender: TObject);
    procedure DOWNMaxChange(Sender: TObject);
    procedure DOWNMinChange(Sender: TObject);
    procedure DOWNRIGHTMaxChange(Sender: TObject);
    procedure DOWNRIGHTMinChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LEFTMaxChange(Sender: TObject);
    procedure LEFTMinChange(Sender: TObject);
    procedure RIGHTMaxChange(Sender: TObject);
    procedure RIGHTMinChange(Sender: TObject);
    procedure UPLEFTMaxChange(Sender: TObject);
    procedure UPLEFTMinChange(Sender: TObject);
    procedure UPMaxChange(Sender: TObject);
    procedure UPMinChange(Sender: TObject);
    procedure UPRIGHTMaxChange(Sender: TObject);
    procedure UPRIGHTMinChange(Sender: TObject);

  private
    Bg: TGLImage;
    MouseX, MouseY, Scale: Single;
    IsSpriteMove, IsRun, RunStartTimer, Goniometer: Boolean;
    PreviousSprite : TSprite;
    Factor, Dist, InternalRunTime: Float;
    procedure DefaultValues;
    procedure WalkToIdle;
    procedure WalkToRun;
    procedure RunToWalk;
  public

  end;

var
  MainForm: TMainForm;
  Player: TPlayer;

implementation

{$R *.lfm}

{ TMainForm }

procedure TMainForm.FormCreate(Sender: TObject);
begin
  FreeAndNil(Player);
  Player := TPlayer.Create;
  Player.CurrentAnimationID := C_AnimIdleDown;
end;

procedure TMainForm.BtnGoniometerClick(Sender: TObject);
begin
  FreeAndNil(Bg);
  Bg := TGLImage.Create('Goniometer.jpg');
  Goniometer := True;
  Player.CurrentAnimationID := C_AnimIdleDown;
  player.CurrentAnimation.Position := Vector2(CastleControl1.Width div 2, CastleControl1.Height div 2);
  Player.CurrentAnimation.Play;
  MainForm.Caption := 'Demo Sprite Castle Game Engine   Degrees: 0';
  WalkSpeed.Caption := '95';
  RunSpeed.Caption := '220';
  DefaultValues;
end;

procedure TMainForm.BtnRoadClick(Sender: TObject);
begin
  FreeAndNil(Bg);
  Bg := TGLImage.Create('Road.jpg');
  Goniometer := False;
  Player.CurrentAnimationID := C_AnimIdleDown;
  player.CurrentAnimation.Position := Vector2(470, 30);
  Player.CurrentAnimation.Play;
  MainForm.Caption := 'Demo Sprite Castle Game Engine   Degrees: 0';
  WalkSpeed.Caption := '180';
  RunSpeed.Caption := '400';
  DefaultValues;
end;

procedure TMainForm.CastleControl1Press(Sender: TObject;
  const Event: TInputPressRelease);
var
  PlayerX, PlayerY,
  DiffXX, DiffYY,
  ArcTanXY, Degrees: Single;
begin
  if (Event.IsMouseButton(mbLeft)) then
  begin
    Factor := StrToFloat(WalkSpeed.Text);
    PreviousSprite := Player.CurrentAnimation;
    Player.CurrentAnimation.Stop;
    MouseX := Event.Position.X;
    MouseY := Event.Position.y;
    PlayerX := Player.CurrentAnimation.X;
    PlayerY := Player.CurrentAnimation.Y;
    { Using mouse click coordinates and Player position I apply the
      arctangent formula and I convert the value obtained in degrees.
      This way I get the requested direction }
    if (PlayerY < MouseY) then
    begin
      DiffYY := (MouseY - PlayerY);
      if (PlayerX < MouseX) then
      begin
        DiffXX := (MouseX - PlayerX);
        ArcTanXY := Math.arctan2(DiffXX, DiffYY);
        Degrees := Math.radtodeg(ArcTanXY);
      end
        else
        begin
          DiffXX := (PlayerX - MouseX);
          ArcTanXY := Math.arctan2(DiffXX, DiffYY);
          Degrees := 360 - Math.radtodeg(ArcTanXY);
        end;
    end
    else if PlayerY > MouseY then
    begin
      DiffYY := (PlayerY - MouseY);
      if (PlayerX < MouseX) then
      begin
        DiffXX := (MouseX - PlayerX);
        ArcTanXY := Math.arctan2(DiffXX, DiffYY);
        Degrees := 180 - Math.radtodeg(ArcTanXY);
      end
        else
        begin
          DiffXX := (PlayerX - MouseX);
          ArcTanXY := Math.arctan2(DiffXX, DiffYY);
          Degrees := 180 + Math.radtodeg(ArcTanXY);
        end;
    end;
    { For each range there is an animation.
      Ranges can and must be changed according to the environment in which Player moves.
      e.g. a top view would not require changes unlike a front view.
      In the demo Road there is a demonstration. Try to move Player with the default
      values and then with the optimized ones (these are not definitive and can be
      improved but give the idea. }
    if ((Degrees > StrToFloat(UPMin.Text)) or (Degrees <= StrToFloat(UPMax.Text))) then
      Player.CurrentAnimationID := C_AnimWalkUp
    else if ((Degrees > StrToFloat(UPRIGHTMin.Text)) and (Degrees <= StrToFloat(UPRIGHTMax.Text))) then
      Player.CurrentAnimationID := C_AnimWalkUpRight
    else if ((Degrees > StrToFloat(RIGHTMin.Text)) and (Degrees <= StrToFloat(RIGHTMax.Text))) then
      Player.CurrentAnimationID := C_AnimWalkRight
    else if ((Degrees > StrToFloat(DOWNRIGHTMin.Text)) and (Degrees <= StrToFloat(DOWNRIGHTMax.Text))) then
      Player.CurrentAnimationID := C_AnimWalkDownRight
    else if ((Degrees > StrToFloat(DOWNMin.Text)) and (Degrees <= StrToFloat(DOWNMax.Text))) then
      Player.CurrentAnimationID := C_AnimWalkDown
    else if ((Degrees > StrToFloat(DOWNLEFTMin.Text)) and (Degrees <= StrToFloat(DOWNLEFTMax.Text))) then
      Player.CurrentAnimationID := C_AnimWalkDownLeft
    else if ((Degrees > StrToFloat(LEFTMin.Text)) and (Degrees <= StrToFloat(LEFTMax.Text))) then
      Player.CurrentAnimationID := C_AnimWalkLeft
    else if ((Degrees > StrToFloat(UPLEFTMin.Text)) and (Degrees <= StrToFloat(UPLEFTMax.Text))) then
      Player.CurrentAnimationID := C_AnimWalkUpLeft;
    MainForm.Caption := 'Demo Sprite Castle Game Engine   Degrees: ' + FloatToStr(Degrees);
    Player.CurrentAnimation.X := PreviousSprite.X;
    Player.CurrentAnimation.Y := PreviousSprite.Y;
    Player.CurrentAnimation.Play;
    IsSpriteMove := True;
  end;
end;

procedure TMainForm.CastleControl1DblClick(Sender: TObject);
begin
  RunStartTimer := True;
end;

procedure TMainForm.CastleControl1Render(Sender: TObject);
var
  ScreenRect: TFloatRectangle;
  EndSource, EndDest: Float;
  FPSColor: TCastleColor;
begin
  if (Assigned(Player) and Assigned(Bg)) then
  begin
    Bg.Draw(0, 0);
    { in Goniometer demo the scale is fixed }
    if Goniometer then
      Scale := 0.4
    else
    { in Road Demo Player size varies according to the "distance" from the observation point }
    begin
      EndSource := CastleControl1.Height div 2;
      EndDest := 0.005;
      Scale := MapRange(Player.CurrentAnimation.y, 0, EndSource, 1.0, EndDest);
;   end;
    { Dividing for two I "move" Player hotspot in the center }
    ScreenRect := FloatRectangle(Player.CurrentAnimation.X - (player.CurrentAnimation.FrameWidth * Scale) / 2,
                                 Player.CurrentAnimation.Y,
                                 Player.CurrentAnimation.FrameWidth * Scale,
                                 Player.CurrentAnimation.FrameHeight * Scale);
    Player.CurrentAnimation.Draw(ScreenRect);
    if Goniometer then FPSColor := Red else FPSColor := Yellow;
    UIFont.Print(10, 10, FPSColor, 'FPS: ' + CastleControl1.Container.Fps.ToString);
  end;
end;

procedure TMainForm.CastleControl1Update(Sender: TObject);
var
  SecondsPassed: TFloatTime;
  DiffX, DiffY, StopLimit: Single;
  SpX, SpY : Float;
begin
  SecondsPassed := CastleControl1.Fps.SecondsPassed;
  { Run animation is divided into three actions, walk - run - walk.
    To achieve this I had to use a workaround but it can certainly be improved.
    To get the brief initial walk, I postpone the run execution of a time equal
    to InternalRunTime. Then I start run animation. Finally I anticipate the
    run end and I play the short final walk. }
  if RunStartTimer then
  begin
    InternalRunTime += CastleControl1.Fps.SecondsPassed;
    if InternalRunTime >= 0.2 then
    begin
      PreviousSprite:=player.CurrentAnimation;
      Player.CurrentAnimation.Stop;
      WalkToRun;
      Player.CurrentAnimation.X := PreviousSprite.X;
      Player.CurrentAnimation.Y := PreviousSprite.Y;
      Factor := StrToFloat(RunSpeed.Text);
      IsRun := True;
      Player.CurrentAnimation.Play;
      InternalRunTime := 0;
      RunStartTimer := False;
    end;
  end;
  { Player is walking or running }
  if (IsSpriteMove) then
  begin
    DiffX := Abs(Player.CurrentAnimation.X - MouseX);
    DiffY := Abs(Player.CurrentAnimation.Y - MouseY);
    { If the direction is left or right there is no need to reduce the speed }
    if (((Player.CurrentAnimationID = C_AnimWalkRight) or (Player.CurrentAnimationID = C_AnimWalkLeft)) or
        (((Player.CurrentAnimationID = C_AnimRunRight) or (Player.CurrentAnimationID = C_AnimRunLeft)))) then
      Dist := 1
        else
          { 400 is an arbitrary value that changes according to the resolution of the game.
            I got it starting from the maximum value of Player walk in Y (300px) and
            looking for the best value. }
          Dist := 1 - (Player.CurrentAnimation.Y / 400);
    if (DiffX > DiffY) then
    begin
      if Goniometer then
        SpX := Factor
          else
            SpX := (((Player.CurrentAnimation.FrameWidth * Scale) * (Factor)) / Player.CurrentAnimation.FrameWidth)  * dist;
      { Without this proportion Player would first walk in one direction and
        then change it to reach the target }
      SpY := (SpX * DiffY / DiffX)
    end
    else
    begin
      if Goniometer then
        SpY := Factor
          else
            SpY := (((Player.CurrentAnimation.FrameHeight * Scale) * Factor) /  Player.CurrentAnimation.FrameHeight) * dist;
      { Proportion as above }
      SpX := SpY * DiffX / DiffY;
    end;
    { Move the Player to the values defined above }
    if Player.CurrentAnimation.X < MouseX then
      Player.CurrentAnimation.X := Player.CurrentAnimation.X + SecondsPassed * SpX
       else
         Player.CurrentAnimation.X := Player.CurrentAnimation.X - SecondsPassed * SpX;
    if Player.CurrentAnimation.Y < MouseY then
       Player.CurrentAnimation.Y := Player.CurrentAnimation.Y + SecondsPassed * SpY
       else
         Player.CurrentAnimation.Y := Player.CurrentAnimation.Y - SecondsPassed * SpY;
    { If Player is running, I anticipate the end to enter the short walk }
    if IsRun then StopLimit := (80 * scale)
      else
        { Since I get x or y through a proportion the target values will not be
          accurate. It is necessary to create a range for the stop }
        StopLimit := 5.0;
    if ((Player.CurrentAnimation.X >= (MouseX - StopLimit)) and (Player.CurrentAnimation.X <= (MouseX + StopLimit))  and
       (Player.CurrentAnimation.Y >= (MouseY - StopLimit)) and (Player.CurrentAnimation.Y <= (MouseY + StopLimit))) then
    begin
      PreviousSprite:=player.CurrentAnimation;
      Player.CurrentAnimation.Stop;
      if IsRun then
      begin
        RunToWalk;
        IsRun := False;
        Factor := StrToFloat(WalkSpeed.Text);
      end
        else
        begin
          WalkToIdle;
          IsSpriteMove := False;
        end;
      Player.CurrentAnimation.X := PreviousSprite.X;
      Player.CurrentAnimation.Y := PreviousSprite.Y;
      Player.CurrentAnimation.Play;
    end;
  end;
  Player.CurrentAnimation.Update(SecondsPassed);
end;

procedure TMainForm.WalkToIdle;
begin
  case Player.CurrentAnimationID of
    C_AnimWalkUp: Player.CurrentAnimationID := C_AnimIdleUp;
    C_AnimWalkUpRight: Player.CurrentAnimationID := C_AnimIdleUpRight;
    C_AnimWalkRight: Player.CurrentAnimationID := C_AnimIdleRight;
    C_AnimWalkDownRight: Player.CurrentAnimationID := C_AnimIdleDownRight;
    C_AnimWalkDown: Player.CurrentAnimationID := C_AnimIdleDown;
    C_AnimWalkDownLeft: Player.CurrentAnimationID := C_AnimIdleDownLeft;
    C_AnimWalkLeft: Player.CurrentAnimationID := C_AnimIdleLeft;
    C_AnimWalkUpLeft: Player.CurrentAnimationID := C_AnimIdleUpLeft;
  end;
end;

procedure TMainForm.WalkToRun;
begin
  case Player.CurrentAnimationID of
    C_AnimWalkUp: Player.CurrentAnimationID := C_AnimRunUp;
    C_AnimWalkUpRight: Player.CurrentAnimationID := C_AnimRunUpRight;
    C_AnimWalkRight: Player.CurrentAnimationID := C_AnimRunRight;
    C_AnimWalkDownRight: Player.CurrentAnimationID := C_AnimRunDownRight;
    C_AnimWalkDown: Player.CurrentAnimationID := C_AnimRunDown;
    C_AnimWalkDownLeft: Player.CurrentAnimationID := C_AnimRunDownLeft;
    C_AnimWalkLeft: Player.CurrentAnimationID := C_AnimRunLeft;
    C_AnimWalkUpLeft: Player.CurrentAnimationID := C_AnimRunUpLeft;
  end;
end;

procedure TMainForm.RunToWalk;
begin
  case Player.CurrentAnimationID of
    C_AnimRunUp: Player.CurrentAnimationID := C_AnimWalkUp;
    C_AnimRunUpRight: Player.CurrentAnimationID := C_AnimWalkUpRight;
    C_AnimRunRight: Player.CurrentAnimationID := C_AnimWalkRight;
    C_AnimRunDownRight: Player.CurrentAnimationID := C_AnimWalkDownRight;
    C_AnimRunDown: Player.CurrentAnimationID := C_AnimWalkDown;
    C_AnimRunDownLeft: Player.CurrentAnimationID := C_AnimWalkDownLeft;
    C_AnimRunLeft: Player.CurrentAnimationID := C_AnimWalkLeft;
    C_AnimRunUpLeft: Player.CurrentAnimationID := C_AnimWalkUpLeft;
  end;
end;

procedure TMainForm.BtnCenterSpriteClick(Sender: TObject);
begin
  if Goniometer then
  begin
    MainForm.Caption := 'Demo Sprite Castle Game Engine   Degrees: 0';
    Player.CurrentAnimation.Stop;
    Player.CurrentAnimationID := C_AnimIdleDown;
    player.CurrentAnimation.Position := Vector2(300, 300);
    Player.CurrentAnimation.Play;
  end;
end;

procedure TMainForm.DefaultValues;
begin
  UPMin.Text := FloatToStr(337.5); UPMax.Text := FloatToStr(22.5);
  UPRIGHTMin.Text := FloatToStr(22.5); UPRIGHTMax.Text := FloatToStr(67.5);
  RIGHTMin.Text := FloatToStr(67.5); RIGHTMax.Text := FloatToStr(112.5);
  DOWNRIGHTMin.Text := FloatToStr(112.5); DOWNRIGHTMax.Text := FloatToStr(157.5);
  DOWNMin.Text := FloatToStr(157.5); DOWNMax.Text := FloatToStr(202.5);
  DOWNLEFTMin.Text := FloatToStr(202.5); DOWNLEFTMax.Text := FloatToStr(247.5);
  LEFTMin.Text := FloatToStr(247.5); LEFTMax.Text := FloatToStr(292.5);
  UPLEFTMin.Text := FloatToStr(292.5); UPLEFTMax.Text := FloatToStr(337.5);
  if Goniometer then
  begin
    WalkSpeed.Caption := '95';
    RunSpeed.Caption := '220';
  end
    else
    begin
      WalkSpeed.Caption := '180';
      RunSpeed.Caption := '400';
    end;
  MainForm.Caption := 'Demo Sprite Castle Game Engine   Degrees: 0';
end;

procedure TMainForm.BtnOptimizeRoadClick(Sender: TObject);
begin
  UPMin.Text := FloatToStr(317.5); UPMax.Text := FloatToStr(42.5);
  UPRIGHTMin.Text := FloatToStr(42.5); UPRIGHTMax.Text := FloatToStr(77.5);
  RIGHTMin.Text := FloatToStr(77.5); RIGHTMax.Text := FloatToStr(102.5);
  DOWNRIGHTMin.Text := FloatToStr(102.5); DOWNRIGHTMax.Text := FloatToStr(137.5);
  DOWNMin.Text := FloatToStr(137.5); DOWNMax.Text := FloatToStr(222.5);
  DOWNLEFTMin.Text := FloatToStr(222.5); DOWNLEFTMax.Text := FloatToStr(257.5);
  LEFTMin.Text := FloatToStr(257.5); LEFTMax.Text := FloatToStr(282.5);
  UPLEFTMin.Text := FloatToStr(282.5); UPLEFTMax.Text := FloatToStr(317.5);
end;

procedure TMainForm.BtnDefaultValueClick(Sender: TObject);
begin
  DefaultValues;
end;

procedure TMainForm.LEFTMaxChange(Sender: TObject);
begin
  UPLeftMin.Text := LEFTMax.Text;
end;

procedure TMainForm.LEFTMinChange(Sender: TObject);
begin
  DOWNLEFTMax.Text := LEFTMin.Text;
end;

procedure TMainForm.RIGHTMaxChange(Sender: TObject);
begin
  DOWNRIGHTMin.Text := RIGHTMax.Text;
end;

procedure TMainForm.RIGHTMinChange(Sender: TObject);
begin
  UPRIGHTMax.Text := RIGHTMin.Text;
end;

procedure TMainForm.UPLEFTMaxChange(Sender: TObject);
begin
  UPMin.Text := UPLEFTMax.Text;
end;

procedure TMainForm.UPLEFTMinChange(Sender: TObject);
begin
  LEFTMax.Text := UPLeftMin.Text;
end;

procedure TMainForm.UPMaxChange(Sender: TObject);
begin
  UPRIGHTMin.Text := UPMax.Text;
end;

procedure TMainForm.UPMinChange(Sender: TObject);
begin
  UPLEFTMax.Text := UPMin.Text;
end;

procedure TMainForm.UPRIGHTMaxChange(Sender: TObject);
begin
  RIGHTMin.Text := UPRIGHTMax.Text;
end;

procedure TMainForm.UPRIGHTMinChange(Sender: TObject);
begin
  UPMax.Text := UPRIGHTMin.Text;
end;


procedure TMainForm.DOWNLEFTMaxChange(Sender: TObject);
begin
  LEFTMin.Text := DOWNLEFTMax.Text;
end;

procedure TMainForm.DOWNLEFTMinChange(Sender: TObject);
begin
  DOWNMax.Text := DOWNLEFTMin.Text;
end;

procedure TMainForm.DOWNMaxChange(Sender: TObject);
begin
  DOWNLEFTMin.Text := DOWNMax.Text;
end;

procedure TMainForm.DOWNMinChange(Sender: TObject);
begin
  DOWNRIGHTMax.Text := DOWNMin.Text;
end;

procedure TMainForm.DOWNRIGHTMaxChange(Sender: TObject);
begin
  DOWNMin.Text := DOWNRIGHTMax.Text;
end;

procedure TMainForm.DOWNRIGHTMinChange(Sender: TObject);
begin
  RIGHTMax.Text := DOWNRIGHTMin.Text;
end;

function TPlayer.CurrentAnimation: TSprite;
begin
  case CurrentAnimationID of
    C_AnimIdleUp: Result := IdleUp;
    C_AnimIdleUpRight: Result := IdleUpRight;
    C_AnimIdleRight: Result := IdleRight;
    C_AnimIdleDownRight: Result := IdleDownRight;
    C_AnimIdleDown: Result := IdleDown;
    C_AnimIdleDownLeft: Result := IdleDownLeft;
    C_AnimIdleLeft: Result := IdleLeft;
    C_AnimIdleUpLeft: Result := IdleUpLeft;

    C_AnimWalkUp: Result := WalkUp;
    C_AnimWalkUpRight: Result := WalkUpRight;
    C_AnimWalkRight: Result := WalkRight;
    C_AnimWalkDownRight: Result := WalkDownRight;
    C_AnimWalkDown: Result := WalkDown;
    C_AnimWalkDownLeft: Result := WalkDownLeft;
    C_AnimWalkLeft: Result := WalkLeft;
    C_AnimWalkUpLeft: Result := WalkUpLeft;

    C_AnimRunUp: Result := RunUp;
    C_AnimRunUpRight: Result := RunUpRight;
    C_AnimRunRight: Result := RunRight;
    C_AnimRunDownRight: Result := RunDownRight;
    C_AnimRunDown: Result := RunDown;
    C_AnimRunDownLeft: Result := RunDownLeft;
    C_AnimRunLeft: Result := RunLeft;
    C_AnimRunUpLeft: Result := RunUpLeft;
  end;
end;

destructor TPlayer.Destroy;
begin
  FreeAndNil(IdleDown);
  FreeAndNil(IdleDownLeft);
  FreeAndNil(IdleDownRight);
  FreeAndNil(IdleLeft);
  FreeAndNil(IdleRight);
  FreeAndNil(IdleUp);
  FreeAndNil(IdleUpLeft);
  FreeAndNil(IdleUpRight);
  FreeAndNil(WalkDown);
  FreeAndNil(WalkDownLeft);
  FreeAndNil(WalkDownRight);
  FreeAndNil(WalkLeft);
  FreeAndNil(WalkRight);
  FreeAndNil(WalkUp);
  FreeAndNil(WalkUpLeft);
  FreeAndNil(WalkUpRight);
  FreeAndNil(RunDown);
  FreeAndNil(RunDownLeft);
  FreeAndNil(RunDownRight);
  FreeAndNil(RunLeft);
  FreeAndNil(RunRight);
  FreeAndNil(RunUp);
  FreeAndNil(RunUpLeft);
  FreeAndNil(RunUpRight);
  inherited;
end;

{ There are several ways to load animations.
  See https://sourceforge.net/p/castle-engine/discussion/general/thread/572c0aa544/ }
constructor TPlayer.Create;
begin
  inherited;
  IdleDown := TSprite.CreateFrameSize(ApplicationData('sprite/idledown.png'), 20, 5, 131, 327, True, True, False);
  IdleDown.FramesPerSecond := 14;
  AnimIdleDown := IdleDown.AddAnimation([0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19]);

  IdleDownLeft := TSprite.CreateFrameSize(ApplicationData('sprite/idledownleft.png'), 20, 5, 122, 333, True, True, False);
  IdleDownLeft.FramesPerSecond := 20;
  AnimIdleDownLeft := IdleDownLeft.AddAnimation([0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19]);

  IdleDownRight := TSprite.CreateFrameSize(ApplicationData('sprite/idledownright.png'), 20, 5, 106, 330, True, True, False);
  IdleDownRight.FramesPerSecond := 20;
  AnimIdleDownRight := IdleDownRight.AddAnimation([0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19]);

  IdleLeft := TSprite.CreateFrameSize(ApplicationData('sprite/idleleft.png'), 20, 5, 89, 334, True, True, False);
  IdleLeft.FramesPerSecond := 20;
  AnimIdleLeft := IdleLeft.AddAnimation([0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19]);

  IdleRight := TSprite.CreateFrameSize(ApplicationData('sprite/idleRight.png'), 20, 5, 86, 327, True, True, False);
  IdleRight.FramesPerSecond := 20;
  AnimIdleRight := IdleRight.AddAnimation([0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19]);

  IdleUp := TSprite.CreateFrameSize(ApplicationData('sprite/idleup.png'), 20, 5, 128, 324, True, True, False);
  IdleUp.FramesPerSecond := 20;
  AnimIdleUp := IdleUp.AddAnimation([0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19]);

  IdleUpLeft := TSprite.CreateFrameSize(ApplicationData('sprite/idleupleft.png'), 20, 5, 110, 329, True, True, False);
  IdleUpLeft.FramesPerSecond := 20;
  AnimIdleUpLeft := IdleUpLeft.AddAnimation([0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19]);

  IdleUpRight := TSprite.CreateFrameSize(ApplicationData('sprite/idleupright.png'), 20, 5, 119, 324, True, True, False);
  IdleUpRight.FramesPerSecond := 20;
  AnimIdleUpRight := IdleUpRight.AddAnimation([0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19]);

  WalkDown := TSprite.CreateFrameSize(ApplicationData('sprite/walkdown.png'), 30, 10, 122, 334, True, True, False);
  WalkDown.FramesPerSecond := 30;
  AnimWalkDown := WalkDown.AddAnimation([0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29]);

  WalkDownLeft := TSprite.CreateFrameSize(ApplicationData('sprite/walkdownleft.png'), 30, 10, 162, 330, True, True, False);
  WalkDownLeft.FramesPerSecond := 30;
  AnimWalkDownLeft := WalkDownLeft.AddAnimation([0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29]);

  WalkDownRight := TSprite.CreateFrameSize(ApplicationData('sprite/walkdownright.png'), 30, 10, 154, 330, True, True, False);
  WalkDownRight.FramesPerSecond := 30;
  AnimWalkDownRight := WalkDownRight.AddAnimation([0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29]);

  {
  WalkLeft := TSprite.CreateFrameSize(ApplicationData('sprite/walkleft.png'), 30, 10, 194, 327, True, True, False);
  WalkLeft.FramesPerSecond := 30;
  AnimWalkLeft := WalkLeft.AddAnimation([0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29]);
  }

  WalkLeft := TSprite.CreateFrameSize(ApplicationData('sprite/walkleft60.png'), 60, 10, 198, 327, True, True, False);
  WalkLeft.FramesPerSecond := 60;
  AnimWalkLeft := WalkLeft.AddAnimation([0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,
                                           30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59]);

  {
  WalkRight := TSprite.CreateFrameSize(ApplicationData('sprite/walkright.png'), 30, 10, 193, 327, True, True, False);
  WalkRight.FramesPerSecond := 30;
  AnimWalkRight := WalkRight.AddAnimation([0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29]);
  }

  WalkRight := TSprite.CreateFrameSize(ApplicationData('sprite/walkright60.png'), 60, 10, 195, 327, True, True, False);
  WalkRight.FramesPerSecond := 60;
  AnimWalkRight := WalkRight.AddAnimation([0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,
                                           30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59]);

  WalkUp := TSprite.CreateFrameSize(ApplicationData('sprite/walkup.png'), 30, 10, 120, 329, True, True, False);
  WalkUp.FramesPerSecond := 30;
  AnimWalkUp := WalkUp.AddAnimation([0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29]);

  WalkUpLeft := TSprite.CreateFrameSize(ApplicationData('sprite/walkupleft.png'), 30, 10, 153, 329, True, True, False);
  WalkUpLeft.FramesPerSecond := 30;
  AnimWalkUpLeft := WalkUpLeft.AddAnimation([0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29]);

  WalkUpRight := TSprite.CreateFrameSize(ApplicationData('sprite/walkupright.png'), 30, 10, 160, 329, True, True, False);
  WalkUpRight.FramesPerSecond := 30;
  AnimWalkUpRight := WalkUpRight.AddAnimation([0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29]);

  RunDown := TSprite.CreateFrameSize(ApplicationData('sprite/rundown.png'), 30, 10, 131, 327, True, True, False);
  RunDown.FramesPerSecond := 30;
  AnimRunDown := RunDown.AddAnimation([0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29]);

  RunDownLeft := TSprite.CreateFrameSize(ApplicationData('sprite/rundownleft.png'), 30, 10, 201, 324, True, True, False);
  RunDownLeft.FramesPerSecond := 30;
  AnimRunDownLeft := RunDownLeft.AddAnimation([0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29]);

  RunDownRight := TSprite.CreateFrameSize(ApplicationData('sprite/rundownright.png'), 30, 10, 202, 326, True, True, False);
  RunDownRight.FramesPerSecond := 30;
  AnimRunDownRight := RunDownRight.AddAnimation([0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29]);

  RunLeft := TSprite.CreateFrameSize(ApplicationData('sprite/runleft.png'), 30, 10, 251, 318, True, True, False);
  RunLeft.FramesPerSecond := 30;
  AnimRunLeft := RunLeft.AddAnimation([0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29]);

  RunRight := TSprite.CreateFrameSize(ApplicationData('sprite/runright.png'), 30, 10, 242, 319, True, True, False);
  RunRight.FramesPerSecond := 30;
  AnimRunRight := RunRight.AddAnimation([0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29]);

  RunUp := TSprite.CreateFrameSize(ApplicationData('sprite/runup.png'), 30, 10, 132, 331, True, True, False);
  RunUp.FramesPerSecond := 30;
  AnimRunUp := RunUp.AddAnimation([0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29]);

  RunUpLeft := TSprite.CreateFrameSize(ApplicationData('sprite/runupleft.png'), 30, 10, 212, 325, True, True, False);
  RunUpLeft.FramesPerSecond := 30;
  AnimRunUpLeft := RunUpLeft.AddAnimation([0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29]);

  RunUpRight := TSprite.CreateFrameSize(ApplicationData('sprite/runupright.png'), 30, 10, 213, 323, True, True, False);
  RunUpRight.FramesPerSecond := 30;
  AnimRunUpRight := RunUpRight.AddAnimation([0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29]);

end;

end.

