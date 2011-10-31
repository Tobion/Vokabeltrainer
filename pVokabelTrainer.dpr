program pVokabelTrainer;

uses
  Forms,
  uVokabelTrainer in 'uVokabelTrainer.pas' {VokabelTrainer},
  uVerwalteVokabeln in 'uVerwalteVokabeln.pas',
  uVokabel in 'uVokabel.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Vokabeltrainer';
  Application.CreateForm(TVokabelTrainer, VokabelTrainer);
  Application.Run;
end.
