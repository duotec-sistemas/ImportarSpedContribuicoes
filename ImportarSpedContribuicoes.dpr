program ImportarSpedContribuicoes;

uses
  Vcl.Forms,
  Principal.View in 'Principal.View.pas' {Form1},
  C100.Model in 'Model\C100.Model.pas' {DM_C100: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
