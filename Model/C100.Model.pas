unit C100.Model;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  ACBrUtil;

type

  TDM_C100 = class(TDataModule)
    Tbl_C100: TFDMemTable;
    Tbl_C170: TFDMemTable;
    Tbl_Cfo: TFDMemTable;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function AtualizarRegistro(Const Linha: String): String;
    procedure AtualizarRegistroC170(Const Linha, IdC100: String);
  end;

  IC100Model = interface
    ['{FC85E906-3574-4FD5-8EB6-5F77777B95F6}']
    function DM: TDM_C100;
  end;

  TC100Model = class(TInterfacedObject, IC100Model)
  private
    FDM: TDM_C100;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: IC100Model;

    function DM: TDM_C100;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}


{ TC100Model }
constructor TC100Model.Create;
begin
  FDM := TDM_C100.Create(nil);
end;

destructor TC100Model.Destroy;
begin
  FDM.Free;
  inherited;
end;

function TC100Model.DM: TDM_C100;
begin
  result := FDM;
end;

class function TC100Model.New: IC100Model;
begin
  result := Self.Create;
end;

{ TDM_C100 }

function TDM_C100.AtualizarRegistro(const Linha: String): String;
Var
  Campos: TSplitResult;
  I: Integer;
  s: String;
  G: TGUID;
begin
  //
  CreateGUID(G);
  Campos := Split('|', Linha);
  Tbl_C100.Append;
  Tbl_C100.FieldByName('ID').AsString := G.ToString;
  for I := 1 to High(Campos) - 1 do
  begin
    s := Campos[I];
    if Tbl_C100.Fields[I].DataType = ftDate then
      s := Copy(s, 1, 2) + '/' + Copy(s, 3, 2) + '/' + Copy(s, 5, 10);

    Tbl_C100.Fields[I].Text := s;
  end;
  Tbl_C100.Post;
  result := Tbl_C100.FieldByName('ID').AsString;
end;

procedure TDM_C100.AtualizarRegistroC170(const Linha, IdC100: String);

Var
  Campos: TSplitResult;
  I: Integer;
  s: String;
  G: TGUID;
begin
  //
  CreateGUID(G);
  Campos := Split('|', Linha);
  Tbl_C170.Append;
  Tbl_C170.FieldByName('ID').AsString := G.ToString;
  Tbl_C170.FieldByName('ID_C100').AsString := IdC100;

  for I := 1 to High(Campos) - 1 do
  begin
    s := Campos[I];
    Tbl_C170.Fields[I + 1].Text := s;
  end;

  IF Tbl_Cfo.Locate('CFOP', Tbl_C170.FieldByName('CFOP').AsInteger, []) then
    Tbl_Cfo.Edit
  Else
  begin
    Tbl_Cfo.Append;
    Tbl_Cfo.FieldByName('CFOP').AsInteger := Tbl_C170.FieldByName('CFOP').AsInteger;
  end;
  Tbl_Cfo.FieldByName('VL_BC_PIS').AsCurrency := Tbl_Cfo.FieldByName('VL_BC_PIS').AsCurrency + Tbl_C170.FieldByName('VL_BC_PIS').AsCurrency;
  Tbl_Cfo.FieldByName('VL_ITEM').AsCurrency := Tbl_Cfo.FieldByName('VL_ITEM').AsCurrency + Tbl_C170.FieldByName('VL_ITEM').AsCurrency;
  Tbl_Cfo.Post;
  Tbl_C170.Post;
end;

procedure TDM_C100.DataModuleCreate(Sender: TObject);
begin

  Tbl_C100.FieldDefs.Add('ID', ftString, 44); // 0
  Tbl_C100.FieldDefs.Add('REG', ftString, 4); // 1
  Tbl_C100.FieldDefs.Add('IND_OPER', ftString, 1); // 2
  Tbl_C100.FieldDefs.Add('IND_EMIT', ftString, 1); // 3
  Tbl_C100.FieldDefs.Add('COD_PART', ftString, 10); // 4
  Tbl_C100.FieldDefs.Add('COD_MOD', ftString, 2); // 5
  Tbl_C100.FieldDefs.Add('COD_SIT', ftString, 2); // 6
  Tbl_C100.FieldDefs.Add('SER', ftString, 3); // 7
  Tbl_C100.FieldDefs.Add('NUM_DOC', ftString, 10); // 8
  Tbl_C100.FieldDefs.Add('CHV_NFE', ftString, 44); // 9
  Tbl_C100.FieldDefs.Add('DT_DOC', ftDate); // 10
  Tbl_C100.FieldDefs.Add('DT_E_S', ftDate); // 11
  Tbl_C100.FieldDefs.Add('VL_DOC', ftCurrency); // 12
  Tbl_C100.FieldDefs.Add('IND_PGTO', ftString, 1); // 13
  Tbl_C100.FieldDefs.Add('VL_DESC', ftCurrency); // 14
  Tbl_C100.FieldDefs.Add('VL_ABAT_NT', ftCurrency); // 15
  Tbl_C100.FieldDefs.Add('VL_MERC', ftCurrency); // 16
  Tbl_C100.FieldDefs.Add('IND_FRT', ftCurrency); // 17
  Tbl_C100.FieldDefs.Add('VL_FRT', ftCurrency); // 18
  Tbl_C100.FieldDefs.Add('VL_SEG', ftCurrency); // 19
  Tbl_C100.FieldDefs.Add('VL_OUT_DA', ftCurrency); // 20
  Tbl_C100.FieldDefs.Add('VL_BC_ICMS', ftCurrency); // 21
  Tbl_C100.FieldDefs.Add('VL_ICMS', ftCurrency); // 22
  Tbl_C100.FieldDefs.Add('VL_BC_ICMS_ST', ftCurrency); // 23
  Tbl_C100.FieldDefs.Add('VL_ICMS_ST', ftCurrency); // 24
  Tbl_C100.FieldDefs.Add('VL_IPI', ftCurrency); // 25
  Tbl_C100.FieldDefs.Add('VL_PIS', ftCurrency); // 26
  Tbl_C100.FieldDefs.Add('VL_COFINS', ftCurrency); // 27
  Tbl_C100.FieldDefs.Add('VL_PIS_ST', ftCurrency); // 28
  Tbl_C100.FieldDefs.Add('VL_COFINS_ST', ftCurrency); // 29
  Tbl_C100.CreateDataSet;

  Tbl_C170.FieldDefs.Add('ID', ftString, 44); // 0
  Tbl_C170.FieldDefs.Add('ID_C100', ftString, 44); // 0

  Tbl_C170.FieldDefs.Add('REG', ftString, 4); // 1
  Tbl_C170.FieldDefs.Add('NUM_ITEM', ftInteger); // 2
  Tbl_C170.FieldDefs.Add('COD_ITEM', ftString, 60); // 3
  Tbl_C170.FieldDefs.Add('DESCR_COMPL', ftString, 60); // 4
  Tbl_C170.FieldDefs.Add('QTD', ftCurrency); // 5
  Tbl_C170.FieldDefs.Add('UNID', ftString, 3); // 6
  Tbl_C170.FieldDefs.Add('VL_ITEM', ftCurrency); // 7
  Tbl_C170.FieldDefs.Add('VL_DESC', ftCurrency); // 8
  Tbl_C170.FieldDefs.Add('IND_MOV', ftString, 1); // 9
  Tbl_C170.FieldDefs.Add('CST_ICMS', ftString, 3); // 10
  Tbl_C170.FieldDefs.Add('CFOP', ftInteger); // 11
  Tbl_C170.FieldDefs.Add('COD_NAT', ftString, 44); // 12
  Tbl_C170.FieldDefs.Add('VL_BC_ICMS', ftCurrency); // 13
  Tbl_C170.FieldDefs.Add('ALIQ_ICMS', ftCurrency); // 14
  Tbl_C170.FieldDefs.Add('VL_ICMS', ftCurrency); // 15
  Tbl_C170.FieldDefs.Add('VL_BC_ICMS_ST', ftCurrency); // 16
  Tbl_C170.FieldDefs.Add('ALIQ_ST', ftCurrency); // 17
  Tbl_C170.FieldDefs.Add('VL_ICMS_ST', ftCurrency); // 18
  Tbl_C170.FieldDefs.Add('IND_APUR', ftString, 1); // 19
  Tbl_C170.FieldDefs.Add('CST_IPI', ftString, 3); // 20
  Tbl_C170.FieldDefs.Add('COD_ENQ', ftString, 10); // 21
  Tbl_C170.FieldDefs.Add('VL_BC_IPI', ftCurrency); // 22
  Tbl_C170.FieldDefs.Add('ALIQ_IPI', ftCurrency); // 23
  Tbl_C170.FieldDefs.Add('VL_IPI', ftCurrency); // 24
  Tbl_C170.FieldDefs.Add('CST_PIS', ftString, 3); // 25
  Tbl_C170.FieldDefs.Add('VL_BC_PIS', ftCurrency); // 26
  Tbl_C170.FieldDefs.Add('ALIQ_PIS', ftCurrency); // 27
  Tbl_C170.FieldDefs.Add('QUANT_BC_PIS', ftCurrency); // 28
  Tbl_C170.FieldDefs.Add('ALIQ_PIS_QUANT', ftCurrency); // 29
  Tbl_C170.FieldDefs.Add('VL_PIS', ftCurrency); // 30
  Tbl_C170.FieldDefs.Add('CST_COFINS', ftString, 3); // 31
  Tbl_C170.FieldDefs.Add('VL_BC_COFINS', ftCurrency); // 32
  Tbl_C170.FieldDefs.Add('ALIQ_COFINS', ftCurrency); // 33
  Tbl_C170.FieldDefs.Add('QUANT_BC_COFINS', ftCurrency); // 34
  Tbl_C170.FieldDefs.Add('ALIQ_COFINS_QUANT', ftCurrency); // 35
  Tbl_C170.FieldDefs.Add('VL_COFINS', ftCurrency); // 36
  Tbl_C170.FieldDefs.Add('COD_CTA', ftString, 44); // 37' +
  Tbl_C170.CreateDataSet;

  Tbl_Cfo.FieldDefs.Add('CFOP', ftInteger);
  Tbl_Cfo.FieldDefs.Add('VL_BC_PIS', ftCurrency);
  Tbl_Cfo.FieldDefs.Add('VL_ITEM', ftCurrency);
  Tbl_Cfo.CreateDataSet;

end;

end.
