unit Principal.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, JvExMask,
  JvToolEdit,
  ACBrUtil, C100.Model, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls,
  Vcl.ExtCtrls, FireDAC.Comp.Client;

type
  TForm1 = class(TForm)
    PageControl1: TPageControl;
    Panel1: TPanel;
    Label1: TLabel;
    Edt_NomeArquivo: TJvFilenameEdit;
    Button1: TButton;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    DBGrid1: TDBGrid;
    DtSrc_C100: TDataSource;
    DtSrc_C170: TDataSource;
    DBGrid2: TDBGrid;
    TabSheet3: TTabSheet;
    DtSrc_Cfo: TDataSource;
    DBGrid3: TDBGrid;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DBGrid3TitleClick(Column: TColumn);
    procedure DBGrid2TitleClick(Column: TColumn);
    procedure DBGrid1TitleClick(Column: TColumn);
  private
    { Private declarations }

    C100: IC100Model;
    function ObterTípoRegistro(const linha: String): String;
    procedure CarregarArquivo(Const NomeArquivo: String);

  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
begin
  CarregarArquivo(Edt_NomeArquivo.Text);
end;

procedure TForm1.CarregarArquivo(const NomeArquivo: String);
Var
  ST: TStringList;
  I: Integer;
  linha, id : string;
begin
  if FileExists(NomeArquivo) then
  begin
    ST := TStringList.Create;
    ST.LoadFromFile(NomeArquivo);
    Try
      for I := 0 to ST.Count - 1 do
      begin
        Application.ProcessMessages;
        linha := ST.Strings[I];
        if ObterTípoRegistro(linha) = 'C100' then
         id := C100.DM.AtualizarRegistro(linha)
        else if ObterTípoRegistro(linha) = 'C170' then
          C100.DM.AtualizarRegistroC170(linha, id);
      end;
    Finally
      ST.Free;
    End;
  end;
End;

procedure TForm1.DBGrid1TitleClick(Column: TColumn);
begin
  TFDMemTable(DtSrc_C100.DataSet).IndexFieldNames := Column.FieldName;

end;

procedure TForm1.DBGrid2TitleClick(Column: TColumn);
begin
  TFDMemTable(DtSrc_C170.DataSet).IndexFieldNames := Column.FieldName;

end;

procedure TForm1.DBGrid3TitleClick(Column: TColumn);
begin
  TFDMemTable(DtSrc_Cfo.DataSet).IndexFieldNames := Column.FieldName;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  C100 := TC100Model.New;
  DtSrc_C100.DataSet := C100.DM.Tbl_C100;
  DtSrc_C170.DataSet := C100.DM.Tbl_C170;
  DtSrc_CFO.DataSet := C100.DM.Tbl_CFO;


end;

function TForm1.ObterTípoRegistro(const linha: String): String;
Var
  Campos: TSplitResult;
begin
  Campos := Split('|', linha);
  result := Campos[1];
end;

initialization

ReportMemoryLeaksOnShutdown := DebugHook <> 0;

end.
