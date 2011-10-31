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

unit uVokabel;

interface

type
  TVokabel = class(TObject)
  constructor create(Deutsch,Englisch:String);

  private
  zEnglisch: String;
  zDeutsch: String;

  public
  function getEnglisch:String; virtual;
  function getDeutsch:String; virtual;
  procedure editVokabel(Deutsch,Englisch: String); virtual;

end;

implementation

constructor TVokabel.create(Deutsch,Englisch:String);
begin
inherited create;
zDeutsch:=Deutsch;
zEnglisch:=Englisch;
end;

function TVokabel.getEnglisch:String;
begin
getEnglisch:=zEnglisch;
end;

function TVokabel.getDeutsch:String;
begin
getDeutsch:=zDeutsch;
end;

procedure TVokabel.editVokabel(Deutsch,Englisch: String);
begin
zDeutsch:=Deutsch;
zEnglisch:=Englisch;
end;


end.


