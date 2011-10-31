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

unit uVerwalteVokabeln;

interface

uses
  SysUtils, Classes, ComCtrls, uVokabel;

type
  TVerwalteVokabeln = class(TObject)
  private
  public
    Vergleiche, Vertauschungen: Integer;
    function VokAdd(VokDE, VokEN: String; VokListe: TList): Boolean; virtual;
    function SucheVokDEBinaer(SuchVok: String; VollstaendigeUebereinstimmung: Boolean; VokListe: TList): Integer; virtual;
    function SucheVokENBinaer(SuchVok: String; VollstaendigeUebereinstimmung: Boolean; VokListe: TList): Integer; virtual;
    procedure SpeichereVokabeln(FileName: String; VokListe: TList); virtual;
    procedure LadeVokabeln(FileName: String; VokListe: TList); virtual;
    procedure QuickSortDE(VokListe: TList; l,r: Integer); virtual;
    procedure QuickSortEN(VokListe: TList; l,r: Integer); virtual;
    procedure BubbleSortDE(VokListe: TList); virtual;
    procedure BubbleSortEN(VokListe: TList); virtual;
  end;

implementation

function TVerwalteVokabeln.VokAdd(VokDE, VokEN: String; VokListe: TList): Boolean;
var Vokabel: TVokabel;
    i: Integer;
begin
for i:=0 to VokListe.Count-1 do
  begin
  if (VokDE=TVokabel(VokListe.Items[i]).GetDeutsch) and (VokEN=TVokabel(VokListe.Items[i]).GetEnglisch) then
    begin
    Result:=false;
    Exit;
    end;
  end;
Vokabel:=TVokabel.Create(VokDE,VokEN);
VokListe.Add(Vokabel);
Result:=true;
end;

function TVerwalteVokabeln.SucheVokDEBinaer(SuchVok: String; VollstaendigeUebereinstimmung: Boolean; VokListe: TList): Integer;
var uS, oS, mW, len: Integer;
    GetVok: String;
begin
Result := -1;
if (SuchVok = '') then Exit;
uS := 0;
oS := VokListe.Count-1;
len:= Length(SuchVok);
while (uS <= oS) do
  begin
  mW := (uS+oS) div 2;
  if VollstaendigeUebereinstimmung then
    GetVok := TVokabel(VokListe.Items[mW]).GetDeutsch
    else GetVok := Copy(TVokabel(VokListe.Items[mW]).GetDeutsch,0,len);
  if (GetVok = SuchVok) then
    begin
    Result := mW;
    Exit;
    end
    else if (SuchVok < GetVok) then
      oS := mW-1
      else
        uS := mW+1;
  end;
end;

function TVerwalteVokabeln.SucheVokENBinaer(SuchVok: String; VollstaendigeUebereinstimmung: Boolean; VokListe: TList): Integer;
var uS, oS, mW, len: Integer;
    GetVok: String;
begin
Result := -1;
if (SuchVok = '') then Exit;
uS := 0;
oS := VokListe.Count-1;
len:= Length(SuchVok);
while (uS <= oS) do
  begin
  mW := (uS+oS) div 2;
  if VollstaendigeUebereinstimmung then
    GetVok := TVokabel(VokListe.Items[mW]).GetEnglisch
    else GetVok := Copy(TVokabel(VokListe.Items[mW]).GetEnglisch,0,len);
  if (GetVok = SuchVok) then
    begin
    Result := mW;
    Exit;
    end
    else if (SuchVok < GetVok) then
      oS := mW-1
      else
        uS := mW+1;
  end;
end;

procedure TVerwalteVokabeln.SpeichereVokabeln(FileName: String; VokListe: TList);
var FileStream: TFileStream;
    VokabelString: String;
    Laenge, i: Integer;
begin
FileStream := TFileStream.Create(FileName, fmCreate);
try
i := VokListe.Count-1;
FileStream.Write (i, SizeOf(i));
for i := 0 to VokListe.Count-1 do
  begin
  VokabelString := TVokabel(VokListe.Items[i]).GetEnglisch;
  Laenge := Length(VokabelString);
  FileStream.Write(Laenge, SizeOf (Laenge));
  FileStream.Write(VokabelString[1], Laenge);
  VokabelString := TVokabel(VokListe.Items[i]).GetDeutsch;
  Laenge := Length(VokabelString);
  FileStream.Write(Laenge, SizeOf (Laenge));
  FileStream.Write(VokabelString[1], Laenge);
  end;
finally
FileStream.Free;
end;
end;

procedure TVerwalteVokabeln.LadeVokabeln(FileName: String; VokListe: TList);
var FileStream: TFileStream;
    i, Anzahl, Laenge: Integer;
    EnglischString, DeutschString: String;
    Vokabel: TVokabel;
begin
VokListe.Clear;
FileStream := TFileStream.Create(FileName, fmOpenRead);
try
FileStream.Read(Anzahl, SizeOf(Anzahl));
VokListe.Capacity := Anzahl+1;
for i := 0 to Anzahl do
  begin
  FileStream.Read(Laenge, SizeOf(Laenge));
  SetLength (EnglischString, Laenge);
  FileStream.Read(EnglischString[1], Laenge);
  FileStream.Read(Laenge, SizeOf(Laenge));
  SetLength(DeutschString, Laenge);
  FileStream.Read(DeutschString[1], Laenge);
  Vokabel:=TVokabel.Create(DeutschString,EnglischString);
  VokListe.Add(Vokabel);
  end;
finally
FileStream.Free;
end;
end;

procedure TVerwalteVokabeln.QuickSortDE(VokListe: TList; l,r: Integer);
var i, j, k: Integer;
    pivot: String;
begin
Inc(Vergleiche);
if (l<r) then
  begin
  i:=l;
  j:=r;
  k:=(l+r) div 2;
  pivot:=TVokabel(VokListe.Items[k]).GetDeutsch;
  repeat
    while TVokabel(VokListe.Items[i]).GetDeutsch < pivot do
      begin
      Inc(i);
      Inc(Vergleiche);
      end;
    while pivot < TVokabel(VokListe.Items[j]).GetDeutsch do
      begin
      Dec(j);
      Inc(Vergleiche);
      end;
    Inc(Vergleiche);
    if i<=j then
      begin
      VokListe.Exchange(i,j);
      Inc(i);
      Dec(j);
      Inc(Vertauschungen);
      end;
  until i>=j;
  QuickSortDE(VokListe, l,j);
  QuickSortDE(Vokliste, i,r);
  end;
end;

procedure TVerwalteVokabeln.QuickSortEN(VokListe: TList; l,r: Integer);
var i, j, k: Integer;
    pivot: String;
begin
Inc(Vergleiche);
if (l<r) then
  begin
  i:=l;
  j:=r;
  k:=(l+r) div 2;
  pivot:=TVokabel(VokListe.Items[k]).GetEnglisch;
  repeat
    while TVokabel(VokListe.Items[i]).GetEnglisch < pivot do
      begin
      Inc(i);
      Inc(Vergleiche);
      end;
    while pivot < TVokabel(VokListe.Items[j]).GetEnglisch do
      begin
      Dec(j);
      Inc(Vergleiche);
      end;
    Inc(Vergleiche);
    if i<=j then
      begin
      VokListe.Exchange(i,j);
      Inc(i);
      Dec(j);
      Inc(Vertauschungen);
      end;
  until i>=j;
  QuickSortEN(VokListe, l,j);
  QuickSortEN(Vokliste, i,r);
  end;
end;

procedure TVerwalteVokabeln.BubbleSortDE(VokListe: TList);
var i, k, max: Integer;
begin
for i:=VokListe.Count-1 downto 1 do
  begin
  max:=0;
  for k:=0 to i do
    if TVokabel(VokListe.Items[k]).GetDeutsch > TVokabel(VokListe.Items[max]).GetDeutsch then
      begin
      max:=k;
      Inc(Vergleiche);
      end;
  VokListe.Exchange(max,i);
  Inc(Vertauschungen);
  end;
end;

procedure TVerwalteVokabeln.BubbleSortEN(VokListe: TList);
var i, k, max: Integer;
begin
for i:=VokListe.Count-1 downto 1 do
  begin
  max:=0;
  for k:=0 to i do
    if TVokabel(VokListe.Items[k]).GetEnglisch > TVokabel(VokListe.Items[max]).GetEnglisch then
      begin
      max:=k;
      Inc(Vergleiche);
      end;
  VokListe.Exchange(max,i);
  Inc(Vertauschungen);
  end;
end;

end.
 