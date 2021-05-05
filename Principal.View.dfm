object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Nome do Arquivo'
  ClientHeight = 473
  ClientWidth = 821
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 57
    Width = 821
    Height = 416
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'TabSheet1'
      ExplicitHeight = 364
      object DBGrid1: TDBGrid
        Left = 0
        Top = 0
        Width = 813
        Height = 388
        Align = alClient
        DataSource = DtSrc_C100
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnTitleClick = DBGrid1TitleClick
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'TabSheet2'
      ImageIndex = 1
      ExplicitHeight = 364
      object DBGrid2: TDBGrid
        Left = 0
        Top = 0
        Width = 813
        Height = 388
        Align = alClient
        DataSource = DtSrc_C170
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnTitleClick = DBGrid2TitleClick
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'TabSheet3'
      ImageIndex = 2
      ExplicitLeft = 8
      object DBGrid3: TDBGrid
        Left = 0
        Top = 0
        Width = 813
        Height = 388
        Align = alClient
        DataSource = DtSrc_Cfo
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnTitleClick = DBGrid3TitleClick
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 821
    Height = 57
    Align = alTop
    TabOrder = 1
    object Label1: TLabel
      Left = 16
      Top = 8
      Width = 82
      Height = 13
      Caption = 'Nome do Arquivo'
    end
    object Edt_NomeArquivo: TJvFilenameEdit
      Left = 16
      Top = 27
      Width = 409
      Height = 21
      TabOrder = 0
      Text = 
        'Z:\C\temp\Macro\contribuicoes\ESCRITURACAO-01426365000145-202103' +
        '01-20210331'
    end
    object Button1: TButton
      Left = 431
      Top = 26
      Width = 75
      Height = 25
      Caption = 'Processar'
      TabOrder = 1
      OnClick = Button1Click
    end
  end
  object DtSrc_C100: TDataSource
    DataSet = DM_C100.Tbl_C100
    Left = 576
    Top = 16
  end
  object DtSrc_C170: TDataSource
    DataSet = DM_C100.Tbl_C100
    Left = 656
    Top = 16
  end
  object DtSrc_Cfo: TDataSource
    DataSet = DM_C100.Tbl_Cfo
    Left = 728
    Top = 16
  end
end
