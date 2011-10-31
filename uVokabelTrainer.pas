{*******************************************************}
{                                                       }
{                Tobias' Vokabeltrainer                 }
{                                                       }
{ Vokabeltrainer De-En/En-De mit über 200000 Einträgen! }
{  Copyright © 2005 Tobias Schultze aka Tubo            }
{  E-Mail: webmaster@tubo-world.de                      }
{  Website: http://www.tubo-world.de                    }
{                                                       }
{  Grundkurs Informatik Jahrgang 12 Herr Willemeit      }
{  Projekt zu den Themen:                               }
{   - Listenstruktur/Feldstruktur (TList)               }
{   - Geeignete Klasse (TVokabel)                       }
{   - Vom sequenziellen Suchen zum binären Suchen       }
{   - Laufzeituntersuchungen Bubblesort <-> Quicksort   }
{   - Laden und Speichern von Strings mit TFileStream   }
{   - Implementieren einer Vokabelliste von www.dict.cc }
{   - TListView / TListBox zu langsam bei der Anzeige   }
{     von so vielen Vokabeln -> nur teilweise anzeigen  }
{                                                       }
{*******************************************************}

unit uVokabelTrainer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ComCtrls, StdCtrls, ExtCtrls, Mask,
  uVerwalteVokabeln, uVokabel;

type
  TVokabelTrainer = class(TForm)
    LeftPanel: TPanel;
    VokListView: TListView;
    ButtomPanel: TPanel;
    SortierungRadioGroup: TRadioGroup;
    VokabelanzeigePanel: TPanel;
    VokabelanzeigeLabel: TLabel;
    AnzElementeTrackBar: TTrackBar;
    RightPanel: TPanel;
    PageControl: TPageControl;
    AddTabSheet: TTabSheet;
    EditierenTabSheet: TTabSheet;
    LoeschenTabSheet: TTabSheet;
    SuchenTabSheet: TTabSheet;
    SortierenTabSheet: TTabSheet;
    TrainerTabSheet: TTabSheet;
    MainMenu: TMainMenu;
    DateiMenu: TMenuItem;
    VokSpeichernMenu: TMenuItem;
    VokLadenMenu: TMenuItem;
    Line1Menu: TMenuItem;
    VerlassenMenu: TMenuItem;
    AddDeutschEdit: TLabeledEdit;
    AddEnglischEdit: TLabeledEdit;
    VokAddButton: TButton;
    EditierenDeEdit: TLabeledEdit;
    EditierenEnEdit: TLabeledEdit;
    VokEditierenButton: TButton;
    LoeschenDeEdit: TLabeledEdit;
    LoeschenEnEdit: TLabeledEdit;
    VokLoeschenButton: TButton;
    LifeSucheGroupBox: TGroupBox;
    LifeSucheEdit: TEdit;
    SuchspracheRadioGroup: TRadioGroup;
    UebereinstimmungsartRadioGroup: TRadioGroup;
    QuicksortButton: TButton;
    BubblesortButton: TButton;
    SortierVergleichRadioGroup: TRadioGroup;
    SortLabel: TLabel;
    EintraegeCaptionLabel: TLabel;
    EintraegeLabel: TLabel;
    VergleicheCaptionLabel: TLabel;
    VergleicheLabel: TLabel;
    VertauschungenCaptionLabel: TLabel;
    VertauschungenLabel: TLabel;
    ZeitCaptionLabel: TLabel;
    ZeitLabel: TLabel;
    TrainerDeLabel: TLabel;
    TrainerDeMaskEdit: TMaskEdit;
    TrainerEnLabel: TLabel;
    TrainerEnMaskEdit: TMaskEdit;
    VokUeberpruefenButton: TButton;
    VokNextButton: TButton;
    TrainerArtRadioGroup: TRadioGroup;
    HilfeRadioGroup: TRadioGroup;
    CaseRadioGroup: TRadioGroup;
    StatusBar: TStatusBar;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    TippButton: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure SortierungRadioGroupClick(Sender: TObject);
    procedure AnzElementeTrackBarChange(Sender: TObject);
    procedure VokAddButtonClick(Sender: TObject);
    procedure VokEditierenButtonClick(Sender: TObject);
    procedure VokLoeschenButtonClick(Sender: TObject);
    procedure LifeSucheEditChange(Sender: TObject);
    procedure SuchspracheRadioGroupClick(Sender: TObject);
    procedure UebereinstimmungsartRadioGroupClick(Sender: TObject);
    procedure QuicksortButtonClick(Sender: TObject);
    procedure BubblesortButtonClick(Sender: TObject);
    procedure TippButtonClick(Sender: TObject);
    procedure VokUeberpruefenButtonClick(Sender: TObject);
    procedure VokNextButtonClick(Sender: TObject);
    procedure VokSpeichernMenuClick(Sender: TObject);
    procedure VokLadenMenuClick(Sender: TObject);
    procedure VerlassenMenuClick(Sender: TObject);
    procedure VokListViewSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure PageControlChange(Sender: TObject);
  private
    { Private-Deklarationen }
    VerwalteVokabeln: TVerwalteVokabeln;
    VokabelListe: TList;
    AufdeckList: TStringList;
    Time: Cardinal;
    AnzElemente, AktVok, IndexFirstVokShown: Integer;
    procedure VokabelnSortieren;
    procedure VokabelnAnzeigen(Index: Integer = 0);
    function GetMask(const Str: String; const AufdeckStellen: TStringList = nil): String;
  public
    { Public-Deklarationen }
  end;

var VokabelTrainer: TVokabelTrainer;

implementation

{$R *.dfm}

procedure TVokabelTrainer.FormCreate(Sender: TObject);
begin
VokabelListe:=TList.Create;
AufdeckList:=TStringList.Create;
VerwalteVokabeln:=TVerwalteVokabeln.Create;
AnzElemente:=25;
AktVok:=0;
IndexFirstVokShown:=0;
OpenDialog.InitialDir:=ExtractFilePath(Application.ExeName);
SaveDialog.InitialDir:=ExtractFilePath(Application.ExeName);
OpenDialog.Filter:='Vokabeldateien (*.dat)|*.dat';
SaveDialog.Filter:='Vokabeldateien (*.dat)|*.dat';
end;

procedure TVokabelTrainer.FormResize(Sender: TObject);
begin
StatusBar.Panels[0].Width := (Self.Width div 2)
end;

procedure TVokabelTrainer.SortierungRadioGroupClick(Sender: TObject);
begin
Screen.Cursor:=crHourglass;
VokabelnSortieren;
if (PageControl.TabIndex = 3) then
  SuchspracheRadioGroup.ItemIndex := SortierungRadioGroup.ItemIndex
  else
    VokabelnAnzeigen;
Screen.Cursor:=crDefault;
end;

procedure TVokabelTrainer.VokabelnSortieren;
begin
if (SortierungRadioGroup.ItemIndex = 0) then
  VerwalteVokabeln.QuickSortDE(VokabelListe,0,VokabelListe.Count-1)
  else
    VerwalteVokabeln.QuickSortEN(VokabelListe,0,VokabelListe.Count-1);
end;

procedure TVokabelTrainer.AnzElementeTrackBarChange(Sender: TObject);
begin
AnzElemente:=AnzElementeTrackBar.Position;
StatusBar.Panels[1].Text:=' Maximal '+IntToStr(AnzElemente)+' Vokabeln anzeigen';
if (VokListView.ItemIndex > -1) then VokabelnAnzeigen(IndexFirstVokShown+VokListView.ItemIndex)
  else VokabelnAnzeigen(IndexFirstVokShown);
end;

procedure TVokabelTrainer.VokabelnAnzeigen(Index: Integer = 0);
var uG, oG, i: Integer;
    ListItem: TListItem;
begin
VokListView.Show;
VokListView.ClearSelection;
if (Index < 0) then Exit;
VokListView.Clear;
uG:=(Index-(AnzElemente div 2));
oG:=(Index+(AnzElemente div 2));
if (AnzElemente > VokabelListe.Count) then
  begin
  uG := 0;
  oG := VokabelListe.Count-1;
  end
  else
    begin
    if (uG < 0) then
      begin
      uG := 0;
      oG := (oG+((AnzElemente div 2)-Index));
      end;
    if (oG > VokabelListe.Count-1) then
      begin
      oG := VokabelListe.Count-1;
      uG := (uG+((AnzElemente div 2)-Index));
      end;
    end;
IndexFirstVokShown := uG;
VokListView.Items.BeginUpdate;
try
  for i:=uG to oG do
    begin
    ListItem:=VokListView.Items.Add;
    ListItem.Caption:=TVokabel(VokabelListe.Items[i]).GetDeutsch;
    ListItem.SubItems.Add(TVokabel(VokabelListe.Items[i]).GetEnglisch);
    if (i = Index) then ListItem.Selected:=true;
    end;
finally
  VokListView.Items.EndUpdate;
end;
VokListView.Scroll(0,(VokListView.Font.Size+2)*VokListView.ItemIndex);
end;

procedure TVokabelTrainer.VokAddButtonClick(Sender: TObject);
begin
AddDeutschEdit.Text:=Trim(AddDeutschEdit.Text);
AddEnglischEdit.Text:=Trim(AddEnglischEdit.Text);
if (AddDeutschEdit.Text='') or (AddEnglischEdit.Text='') then
  Showmessage('Bitte erst eine Vokabel eingeben!')
  else if not VerwalteVokabeln.VokAdd(AddDeutschEdit.Text,AddEnglischEdit.Text,VokabelListe) then
    Showmessage('Vokabel existiert bereits!')
      else
        begin
        AddDeutschEdit.Clear;
        AddEnglischEdit.Clear;
        Screen.Cursor:=crHourglass;
        VokabelnSortieren;
        VokabelnAnzeigen;
        Screen.Cursor:=crDefault;
        end;
StatusBar.Panels[0].Text:=' Vokabelanzahl: '+IntToStr(VokabelListe.Count);
AddDeutschEdit.SetFocus;
end;

procedure TVokabelTrainer.VokEditierenButtonClick(Sender: TObject);
begin
if (VokListView.ItemIndex > -1) then
  begin
  EditierenDeEdit.Text:=Trim(EditierenDeEdit.Text);
  EditierenEnEdit.Text:=Trim(EditierenEnEdit.Text);
  if (EditierenDeEdit.Text='') or (EditierenEnEdit.Text='') then
    begin
    Showmessage('Bitte eine Vokabel eingeben!');
    Exit;
    end;
  TVokabel(VokabelListe.Items[IndexFirstVokShown+VokListView.ItemIndex]).editVokabel(EditierenDeEdit.Text,EditierenEnEdit.Text);
  Screen.Cursor:=crHourglass;
  VokabelnSortieren;
  VokabelnAnzeigen;
  Screen.Cursor:=crDefault;
  end
  else Showmessage('Bitte erst eine Vokabel auswählen, die editiert werden soll!');
end;

procedure TVokabelTrainer.VokLoeschenButtonClick(Sender: TObject);
begin
if (VokListView.ItemIndex > -1) then
  begin
  TVokabel(VokabelListe.Items[IndexFirstVokShown+VokListView.ItemIndex]).Free;
  VokabelListe.Delete(IndexFirstVokShown+VokListView.ItemIndex);
  VokListView.Items.Item[VokListView.ItemIndex].Delete;
  LoeschenDeEdit.Clear;
  LoeschenEnEdit.Clear;
  StatusBar.Panels[0].Text:=' Vokabelanzahl: '+IntToStr(VokabelListe.Count);
  end
  else Showmessage('Bitte erst eine Vokabel auswählen, die gelöscht werden soll!');
end;

procedure TVokabelTrainer.LifeSucheEditChange(Sender: TObject);
var Vollstaendig: Boolean;
begin
LifeSucheEdit.Text:=TrimLeft(LifeSucheEdit.Text);
if (UebereinstimmungsartRadioGroup.ItemIndex=0) then Vollstaendig:=true
  else Vollstaendig:=false;
if (SuchspracheRadioGroup.ItemIndex = 0) then VokabelnAnzeigen(VerwalteVokabeln.SucheVokDEBinaer(LifeSucheEdit.Text, Vollstaendig, VokabelListe))
  else VokabelnAnzeigen(VerwalteVokabeln.SucheVokENBinaer(LifeSucheEdit.Text, Vollstaendig, VokabelListe));
end;

procedure TVokabelTrainer.QuicksortButtonClick(Sender: TObject);
begin
Screen.Cursor:=crHourglass;
VerwalteVokabeln.Vergleiche:=0;
VerwalteVokabeln.Vertauschungen:=0;
Time:=GetTickCount;
if (SortierVergleichRadioGroup.ItemIndex = 0) then
  begin
  VerwalteVokabeln.QuickSortDE(VokabelListe,0,VokabelListe.Count-1);
  SortLabel.Caption:='Quicksort (DE)';
  end
  else
    begin
    VerwalteVokabeln.QuickSortEN(VokabelListe,0,VokabelListe.Count-1);
    SortLabel.Caption:='Quicksort (EN)';
    end;
Screen.Cursor:=crDefault;
EintraegeLabel.Caption:=Format('%d',[VokabelListe.Count]);
VergleicheLabel.Caption:=Format('%d',[VerwalteVokabeln.Vergleiche]);
VertauschungenLabel.Caption:=Format('%d',[VerwalteVokabeln.Vertauschungen]);
ZeitLabel.Caption:=Format('%d msec',[GetTickCount-Time]);
VokabelnAnzeigen;
end;

procedure TVokabelTrainer.BubblesortButtonClick(Sender: TObject);
begin
Screen.Cursor:=crHourglass;
VerwalteVokabeln.Vergleiche:=0;
VerwalteVokabeln.Vertauschungen:=0;
Time:=GetTickCount;
if (SortierVergleichRadioGroup.ItemIndex = 0) then
  begin
  VerwalteVokabeln.BubbleSortDE(VokabelListe);
  SortLabel.Caption:='Bubblesort (DE)';
  end
  else
    begin
    VerwalteVokabeln.BubbleSortEN(VokabelListe);
    SortLabel.Caption:='Bubblesort (EN)';
    end;
Screen.Cursor:=crDefault;
EintraegeLabel.Caption:=Format('%d',[VokabelListe.Count]);
VergleicheLabel.Caption:=Format('%d',[VerwalteVokabeln.Vergleiche]);
VertauschungenLabel.Caption:=Format('%d',[VerwalteVokabeln.Vertauschungen]);
ZeitLabel.Caption:=Format('%d msec',[GetTickCount-Time]);
VokabelnAnzeigen;
end;

procedure TVokabelTrainer.TippButtonClick(Sender: TObject);
var VokStr: String;
    i: Integer;
begin
Randomize;
if TrainerDeMaskEdit.ReadOnly then // DE -> EN
  begin
  VokStr:=TVokabel(VokabelListe.Items[AktVok]).GetEnglisch;
  if (TrainerEnMaskEdit.Text<>VokStr) then
    begin
    i:=Random(Length(VokStr))+1;
    while (VokStr[i]=TrainerEnMaskEdit.Text[i]) do
      i:=Random(Length(VokStr))+1;
    AufdeckList.Add(IntToStr(i));
    TrainerEnMaskEdit.Clear;
    TrainerEnMaskEdit.EditMask:=GetMask(VokStr,AufdeckList);
    end;
  end
  else
    begin // EN -> DE
    VokStr:=TVokabel(VokabelListe.Items[AktVok]).GetDeutsch;
    if (TrainerDeMaskEdit.Text<>VokStr) then
      begin
      i:=Random(Length(VokStr))+1;
      while (VokStr[i]=TrainerDeMaskEdit.Text[i]) do
        i:=Random(Length(VokStr))+1;
      AufdeckList.Add(IntToStr(i));
      TrainerDeMaskEdit.Clear;
      TrainerDeMaskEdit.EditMask:=GetMask(VokStr,AufdeckList);
      end;
    end;
end;

procedure TVokabelTrainer.VokUeberpruefenButtonClick(Sender: TObject);
var VokDE1, VokDE2, VokEN1, VokEN2: String;
begin
VokUeberpruefenButton.Enabled := false;
TippButton.Enabled := false;
VokDE1:=TVokabel(VokabelListe.Items[AktVok]).GetDeutsch;
VokDE2:=TrainerDeMaskEdit.Text;
VokEN1:=TVokabel(VokabelListe.Items[AktVok]).GetEnglisch;
VokEN2:=TrainerEnMaskEdit.Text;
if CaseRadioGroup.ItemIndex = 1 then // nicht case-sensitive
  begin
  VokDE1:=AnsiLowerCase(VokDE1);
  VokDE2:=AnsiLowerCase(VokDE2);
  VokEN1:=AnsiLowerCase(VokEN1);
  VokEN2:=AnsiLowerCase(VokEN2);
  end;
if TrainerDeMaskEdit.ReadOnly then // DE -> EN
  begin
  if (VokEN1 = VokEN2) then
    begin
    Application.MessageBox('Gratulation, richtig!','Vokabeltrainer DE -> EN', MB_OK + MB_ICONINFORMATION);
    VokabelnAnzeigen(AktVok);
    ButtomPanel.Show;
    end
    else if Application.MessageBox('Leider falsch! Noch einmal probieren?','Vokabeltrainer DE -> EN', MB_YESNO + MB_ICONERROR) = IdNo then
      begin
      VokabelnAnzeigen(AktVok);
      ButtomPanel.Show;
      end
      else
        begin
        VokUeberpruefenButton.Enabled := true;
        if (TrainerEnMaskEdit.EditMask<>'') then TippButton.Enabled := true;
        TrainerEnMaskEdit.SetFocus;
        end;
  end
  else
    begin // EN -> DE
    if (VokDE1 = VokDE2) then
      begin
      Application.MessageBox('Gratulation, richtig!','Vokabeltrainer EN -> DE', MB_OK + MB_ICONINFORMATION);
      VokabelnAnzeigen(AktVok);
      ButtomPanel.Show;
      end
      else if Application.MessageBox('Leider falsch! Noch einmal probieren?','Vokabeltrainer EN -> DE', MB_YESNO + MB_ICONERROR) = IdNo then
        begin
        VokabelnAnzeigen(AktVok);
        ButtomPanel.Show;
        end
        else
          begin
          VokUeberpruefenButton.Enabled := true;
          if (TrainerDeMaskEdit.EditMask<>'') then TippButton.Enabled := true;
          TrainerDeMaskEdit.SetFocus;
          end;
    end;
end;

procedure TVokabelTrainer.VokNextButtonClick(Sender: TObject);
var VokStr: String;
begin
ButtomPanel.Hide;
VokListView.Hide;
TrainerDeMaskEdit.EditMask := '';
TrainerEnMaskEdit.EditMask := '';
TrainerDeMaskEdit.Clear;
TrainerEnMaskEdit.Clear;
TrainerDeMaskEdit.ReadOnly:=true;
TrainerEnMaskEdit.ReadOnly:=true;
VokUeberpruefenButton.Enabled:=false;
TippButton.Enabled:=false;
AufdeckList.Clear;
if (VokabelListe.Count > 0) then
  begin
  VokUeberpruefenButton.Enabled:=true;
  Randomize;
  AktVok := Random(VokabelListe.Count);
  if (TrainerArtRadioGroup.ItemIndex = 0) then // DE -> EN
    begin
    TrainerEnMaskEdit.ReadOnly:=false;
    TrainerEnMaskEdit.SetFocus;
    TrainerDeMaskEdit.Text:=TVokabel(VokabelListe.Items[AktVok]).GetDeutsch;
    VokStr:=TVokabel(VokabelListe.Items[AktVok]).GetEnglisch;
    if (HilfeRadioGroup.ItemIndex = 0) then // Hilfe an
      begin
      TrainerEnMaskEdit.EditMask := GetMask(VokStr);
      TippButton.Enabled:=true;
      end;
    end
    else // EN -> DE
      begin
      TrainerDeMaskEdit.ReadOnly:=false;
      TrainerDeMaskEdit.SetFocus;
      TrainerEnMaskEdit.Text:=TVokabel(VokabelListe.Items[AktVok]).GetEnglisch;
      VokStr:=TVokabel(VokabelListe.Items[AktVok]).GetDeutsch;
      if (HilfeRadioGroup.ItemIndex = 0) then // Hilfe an
        begin
        TrainerDeMaskEdit.EditMask := GetMask(VokStr);
        TippButton.Enabled:=true;
        end;
      end;
  end
  else Showmessage('Keine Vokabeln verfügbar!');
end;

function TVokabelTrainer.GetMask(const Str: String; const AufdeckStellen: TStringList = nil): String;
var i: Integer;
    Klammer: Char;
    Mask: String;
begin
Klammer:=' '; // Sonderzeichen und Eingeklammertes werden angezeigt
Mask:='';
for i:=1 to Length(Str) do
  begin
  if Assigned(AufdeckStellen) then
    begin
    if ((Str[i] in ['a'..'z','A'..'Z','ü','Ü','ö','Ö','ä','Ä','ß']) and (Klammer=' ') and (AufdeckStellen.IndexOf(IntToStr(i))=-1)) then
      Mask := Mask + 'l'
      else if ((Str[i] in ['0'..'9']) and (Klammer=' ') and (AufdeckStellen.IndexOf(IntToStr(i))=-1)) then
        Mask := Mask + '9'
        else
          begin
          if (Klammer=' ') then
            begin
            if (Str[i]='{') then Klammer:='}'
              else if (Str[i]='(') then Klammer:=')'
                else if (Str[i]='[') then Klammer:=']';
            end
            else if (Klammer = Str[i]) then Klammer:=' ';
          Mask := Mask + '\' + Str[i];
          end;
    end
    else
      begin
      if ((Str[i] in ['a'..'z','A'..'Z','ü','Ü','ö','Ö','ä','Ä','ß']) and (Klammer=' ')) then
        Mask := Mask + 'l'
        else if ((Str[i] in ['0'..'9']) and (Klammer=' ')) then
          Mask := Mask + '9'
          else
            begin
            if (Klammer=' ') then
              begin
              if (Str[i]='{') then Klammer:='}'
                else if (Str[i]='(') then Klammer:=')'
                  else if (Str[i]='[') then Klammer:=']';
              end
              else if (Klammer = Str[i]) then Klammer:=' ';
            Mask := Mask + '\' + Str[i];
            end;
      end;
  end;
Result := Mask;
end;

procedure TVokabelTrainer.SuchspracheRadioGroupClick(Sender: TObject);
begin
SortierungRadioGroup.ItemIndex := SuchspracheRadioGroup.ItemIndex;
LifeSucheEditChange(Sender);
LifeSucheEdit.SetFocus;
end;

procedure TVokabelTrainer.UebereinstimmungsartRadioGroupClick(
  Sender: TObject);
begin
LifeSucheEditChange(Sender);
LifeSucheEdit.SetFocus;
end;

procedure TVokabelTrainer.VokSpeichernMenuClick(Sender: TObject);
begin
if SaveDialog.Execute then
  begin
  if FileExists(SaveDialog.FileName) then
    if Application.MessageBox('Datei überschreiben?','Bestätigung', MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2) = IdNO then
      Exit;
  Screen.Cursor:=crHourglass;
  VerwalteVokabeln.SpeichereVokabeln(SaveDialog.FileName, VokabelListe);
  Screen.Cursor:=crDefault;
  end;
end;

procedure TVokabelTrainer.VokLadenMenuClick(Sender: TObject);
begin
if OpenDialog.Execute then
  begin
  Screen.Cursor:=crHourglass;
  VerwalteVokabeln.LadeVokabeln(OpenDialog.FileName, VokabelListe);
  VokabelnSortieren;
  VokabelnAnzeigen;
  StatusBar.Panels[0].Text:=' Vokabelanzahl: '+IntToStr(VokabelListe.Count);
  Screen.Cursor:=crDefault;
  end;
end;

procedure TVokabelTrainer.VerlassenMenuClick(Sender: TObject);
begin
Self.Close;
end;

procedure TVokabelTrainer.VokListViewSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
var DeVok, EnVok: String;
begin
if (Selected and ((PageControl.TabIndex = 1) or (PageControl.TabIndex = 2))) then
  begin
  DeVok:=TVokabel(VokabelListe.Items[IndexFirstVokShown+VokListView.ItemIndex]).GetDeutsch;
  EnVok:=TVokabel(VokabelListe.Items[IndexFirstVokShown+VokListView.ItemIndex]).GetEnglisch;
  EditierenDeEdit.Text:=DeVok;
  EditierenEnEdit.Text:=EnVok;
  LoeschenDeEdit.Text:=DeVok;
  LoeschenEnEdit.Text:=EnVok;
  end;
end;

procedure TVokabelTrainer.PageControlChange(Sender: TObject);
begin
if (PageControl.TabIndex = 0) or (PageControl.TabIndex = 4) then
  begin
  ButtomPanel.Show;
  VokListView.Show;
  end
  else if (PageControl.TabIndex = 1) then
    begin
    ButtomPanel.Show;
    VokListView.Show;
    EditierenDeEdit.Clear;
    EditierenEnEdit.Clear;
    if (VokListView.ItemIndex>-1) then
      begin
      EditierenDeEdit.Text:=TVokabel(VokabelListe.Items[IndexFirstVokShown+VokListView.ItemIndex]).GetDeutsch;
      EditierenEnEdit.Text:=TVokabel(VokabelListe.Items[IndexFirstVokShown+VokListView.ItemIndex]).GetEnglisch;
      end
      else Showmessage('Bitte eine Vokabel auswählen, die editiert werden soll!');
    end
    else if (PageControl.TabIndex = 2) then
      begin
      ButtomPanel.Show;
      VokListView.Show;
      LoeschenDeEdit.Clear;
      LoeschenEnEdit.Clear;
      if (VokListView.ItemIndex>-1) then
        begin
        LoeschenDeEdit.Text:=TVokabel(VokabelListe.Items[IndexFirstVokShown+VokListView.ItemIndex]).GetDeutsch;
        LoeschenEnEdit.Text:=TVokabel(VokabelListe.Items[IndexFirstVokShown+VokListView.ItemIndex]).GetEnglisch;
        end
        else Showmessage('Bitte eine Vokabel auswählen, die gelöscht werden soll!');
      end
      else if (PageControl.TabIndex = 3) then
        begin
        ButtomPanel.Show;
        VokListView.Show;
        SuchspracheRadioGroupClick(Sender);
        end
        else
          begin
          VokNextButton.Click;
          end;
end;

end.


