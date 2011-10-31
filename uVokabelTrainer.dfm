object VokabelTrainer: TVokabelTrainer
  Left = 276
  Top = 185
  Width = 480
  Height = 449
  Caption = 'Tobias'#39' Vokabeltrainer'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object LeftPanel: TPanel
    Left = 0
    Top = 0
    Width = 291
    Height = 336
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object VokListView: TListView
      Left = 0
      Top = 0
      Width = 291
      Height = 336
      Align = alClient
      Columns = <
        item
          AutoSize = True
          Caption = 'Deutsch'
        end
        item
          AutoSize = True
          Caption = 'Englisch'
        end>
      ColumnClick = False
      GridLines = True
      HideSelection = False
      ReadOnly = True
      RowSelect = True
      TabOrder = 0
      ViewStyle = vsReport
      OnSelectItem = VokListViewSelectItem
    end
  end
  object RightPanel: TPanel
    Left = 291
    Top = 0
    Width = 181
    Height = 336
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 1
    object PageControl: TPageControl
      Left = 0
      Top = 0
      Width = 181
      Height = 336
      ActivePage = AddTabSheet
      Align = alClient
      MultiLine = True
      TabOrder = 0
      OnChange = PageControlChange
      object AddTabSheet: TTabSheet
        Caption = 'Hinzuf'#252'gen'
        object AddDeutschEdit: TLabeledEdit
          Left = 8
          Top = 29
          Width = 153
          Height = 21
          EditLabel.Width = 49
          EditLabel.Height = 16
          EditLabel.Caption = 'Deutsch'
          EditLabel.Font.Charset = DEFAULT_CHARSET
          EditLabel.Font.Color = clWindowText
          EditLabel.Font.Height = -13
          EditLabel.Font.Name = 'MS Sans Serif'
          EditLabel.Font.Style = []
          EditLabel.ParentFont = False
          TabOrder = 0
        end
        object AddEnglischEdit: TLabeledEdit
          Left = 8
          Top = 77
          Width = 153
          Height = 21
          EditLabel.Width = 51
          EditLabel.Height = 16
          EditLabel.Caption = 'Englisch'
          EditLabel.Font.Charset = DEFAULT_CHARSET
          EditLabel.Font.Color = clWindowText
          EditLabel.Font.Height = -13
          EditLabel.Font.Name = 'MS Sans Serif'
          EditLabel.Font.Style = []
          EditLabel.ParentFont = False
          TabOrder = 1
        end
        object VokAddButton: TButton
          Left = 8
          Top = 113
          Width = 153
          Height = 25
          Caption = 'Hinzuf'#252'gen'
          TabOrder = 2
          TabStop = False
          OnClick = VokAddButtonClick
        end
      end
      object EditierenTabSheet: TTabSheet
        Caption = 'Editieren'
        ImageIndex = 1
        object EditierenDeEdit: TLabeledEdit
          Left = 8
          Top = 29
          Width = 153
          Height = 21
          EditLabel.Width = 49
          EditLabel.Height = 16
          EditLabel.Caption = 'Deutsch'
          EditLabel.Font.Charset = DEFAULT_CHARSET
          EditLabel.Font.Color = clWindowText
          EditLabel.Font.Height = -13
          EditLabel.Font.Name = 'MS Sans Serif'
          EditLabel.Font.Style = []
          EditLabel.ParentFont = False
          TabOrder = 0
        end
        object EditierenEnEdit: TLabeledEdit
          Left = 8
          Top = 77
          Width = 153
          Height = 21
          EditLabel.Width = 51
          EditLabel.Height = 16
          EditLabel.Caption = 'Englisch'
          EditLabel.Font.Charset = DEFAULT_CHARSET
          EditLabel.Font.Color = clWindowText
          EditLabel.Font.Height = -13
          EditLabel.Font.Name = 'MS Sans Serif'
          EditLabel.Font.Style = []
          EditLabel.ParentFont = False
          TabOrder = 1
        end
        object VokEditierenButton: TButton
          Left = 8
          Top = 113
          Width = 153
          Height = 25
          Caption = 'Editieren'
          TabOrder = 2
          TabStop = False
          OnClick = VokEditierenButtonClick
        end
      end
      object LoeschenTabSheet: TTabSheet
        Caption = 'L'#246'schen'
        ImageIndex = 2
        object LoeschenDeEdit: TLabeledEdit
          Left = 8
          Top = 29
          Width = 153
          Height = 21
          EditLabel.Width = 49
          EditLabel.Height = 16
          EditLabel.Caption = 'Deutsch'
          EditLabel.Font.Charset = DEFAULT_CHARSET
          EditLabel.Font.Color = clWindowText
          EditLabel.Font.Height = -13
          EditLabel.Font.Name = 'MS Sans Serif'
          EditLabel.Font.Style = []
          EditLabel.ParentFont = False
          ReadOnly = True
          TabOrder = 0
        end
        object LoeschenEnEdit: TLabeledEdit
          Left = 8
          Top = 77
          Width = 153
          Height = 21
          EditLabel.Width = 51
          EditLabel.Height = 16
          EditLabel.Caption = 'Englisch'
          EditLabel.Font.Charset = DEFAULT_CHARSET
          EditLabel.Font.Color = clWindowText
          EditLabel.Font.Height = -13
          EditLabel.Font.Name = 'MS Sans Serif'
          EditLabel.Font.Style = []
          EditLabel.ParentFont = False
          ReadOnly = True
          TabOrder = 1
        end
        object VokLoeschenButton: TButton
          Left = 8
          Top = 113
          Width = 153
          Height = 25
          Caption = 'L'#246'schen'
          TabOrder = 2
          TabStop = False
          OnClick = VokLoeschenButtonClick
        end
      end
      object SuchenTabSheet: TTabSheet
        Caption = 'Suchen'
        ImageIndex = 3
        object LifeSucheGroupBox: TGroupBox
          Left = 0
          Top = 8
          Width = 172
          Height = 193
          Caption = 'Bin'#228're Life Suche:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          object LifeSucheEdit: TEdit
            Left = 8
            Top = 22
            Width = 153
            Height = 24
            TabOrder = 0
            OnChange = LifeSucheEditChange
          end
          object SuchspracheRadioGroup: TRadioGroup
            Left = 8
            Top = 56
            Width = 153
            Height = 57
            Caption = 'Suchsprache:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ItemIndex = 0
            Items.Strings = (
              'Deutsch'
              'Englisch')
            ParentFont = False
            TabOrder = 1
            OnClick = SuchspracheRadioGroupClick
          end
          object UebereinstimmungsartRadioGroup: TRadioGroup
            Left = 8
            Top = 120
            Width = 153
            Height = 57
            Caption = #220'bereinstimmungsart:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ItemIndex = 1
            Items.Strings = (
              'Vollst'#228'ndig'
              'Teilweise')
            ParentFont = False
            TabOrder = 2
            OnClick = UebereinstimmungsartRadioGroupClick
          end
        end
      end
      object SortierenTabSheet: TTabSheet
        Caption = 'Sortier-Vgl.'
        ImageIndex = 4
        object VergleicheCaptionLabel: TLabel
          Left = 16
          Top = 192
          Width = 56
          Height = 13
          Caption = 'Vergleiche: '
        end
        object VergleicheLabel: TLabel
          Left = 155
          Top = 192
          Width = 6
          Height = 13
          Alignment = taRightJustify
          Caption = '?'
        end
        object VertauschungenCaptionLabel: TLabel
          Left = 16
          Top = 208
          Width = 84
          Height = 13
          Caption = 'Vertauschungen: '
        end
        object VertauschungenLabel: TLabel
          Left = 155
          Top = 209
          Width = 6
          Height = 13
          Alignment = taRightJustify
          Caption = '?'
        end
        object ZeitCaptionLabel: TLabel
          Left = 16
          Top = 224
          Width = 72
          Height = 13
          Caption = 'Ben'#246'tigte Zeit: '
        end
        object ZeitLabel: TLabel
          Left = 127
          Top = 224
          Width = 34
          Height = 13
          Alignment = taRightJustify
          Caption = '? msec'
        end
        object SortLabel: TLabel
          Left = 16
          Top = 160
          Width = 100
          Height = 13
          Caption = 'Quick/Bubblesort'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object EintraegeCaptionLabel: TLabel
          Left = 16
          Top = 176
          Width = 45
          Height = 13
          Caption = 'Eintr'#228'ge: '
        end
        object EintraegeLabel: TLabel
          Left = 155
          Top = 176
          Width = 6
          Height = 13
          Alignment = taRightJustify
          Caption = '?'
        end
        object QuicksortButton: TButton
          Left = 8
          Top = 16
          Width = 153
          Height = 25
          Caption = 'Quicksort'
          TabOrder = 0
          OnClick = QuicksortButtonClick
        end
        object BubblesortButton: TButton
          Left = 8
          Top = 56
          Width = 153
          Height = 25
          Caption = 'Bubblesort'
          TabOrder = 1
          OnClick = BubblesortButtonClick
        end
        object SortierVergleichRadioGroup: TRadioGroup
          Left = 8
          Top = 88
          Width = 161
          Height = 57
          Caption = 'Sortierung nach:'
          ItemIndex = 0
          Items.Strings = (
            'Deutsch'
            'Englisch')
          TabOrder = 2
        end
      end
      object TrainerTabSheet: TTabSheet
        Caption = 'Trainer'
        ImageIndex = 5
        object TrainerDeLabel: TLabel
          Left = 8
          Top = 72
          Width = 49
          Height = 16
          Caption = 'Deutsch'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object TrainerEnLabel: TLabel
          Left = 8
          Top = 115
          Width = 51
          Height = 16
          Caption = 'Englisch'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object TrainerDeMaskEdit: TMaskEdit
          Left = 8
          Top = 90
          Width = 153
          Height = 21
          TabOrder = 2
        end
        object HilfeRadioGroup: TRadioGroup
          Left = 8
          Top = 216
          Width = 73
          Height = 49
          Caption = 'Hilfestellung:'
          ItemIndex = 0
          Items.Strings = (
            'An'
            'Aus')
          TabOrder = 3
        end
        object TrainerEnMaskEdit: TMaskEdit
          Left = 8
          Top = 133
          Width = 153
          Height = 21
          TabOrder = 4
        end
        object TrainerArtRadioGroup: TRadioGroup
          Left = 8
          Top = 16
          Width = 161
          Height = 49
          Caption = #220'berpr'#252'fungsart:'
          ItemIndex = 0
          Items.Strings = (
            'DE -> EN'
            'EN -> DE')
          TabOrder = 5
        end
        object CaseRadioGroup: TRadioGroup
          Left = 85
          Top = 216
          Width = 85
          Height = 49
          Hint = 'Gro'#223'-/Kleinschreibung beachten?'
          Caption = 'Case-sensitive:'
          ItemIndex = 0
          Items.Strings = (
            'Ja'
            'Nein')
          ParentShowHint = False
          ShowHint = True
          TabOrder = 6
        end
        object TippButton: TButton
          Left = 8
          Top = 162
          Width = 57
          Height = 25
          Caption = 'Tipp'
          TabOrder = 7
          OnClick = TippButtonClick
        end
        object VokUeberpruefenButton: TButton
          Left = 64
          Top = 162
          Width = 97
          Height = 25
          Caption = #220'berpr'#252'fen'
          TabOrder = 0
          TabStop = False
          OnClick = VokUeberpruefenButtonClick
        end
        object VokNextButton: TButton
          Left = 8
          Top = 186
          Width = 153
          Height = 25
          Caption = 'Neue Vokabel'
          TabOrder = 1
          TabStop = False
          OnClick = VokNextButtonClick
        end
      end
    end
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 376
    Width = 472
    Height = 19
    Panels = <
      item
        Text = ' Vokabelanzahl: 0'
        Width = 230
      end
      item
        Text = ' Maximal 25 Vokabeln anzeigen'
        Width = 50
      end>
  end
  object ButtomPanel: TPanel
    Left = 0
    Top = 336
    Width = 472
    Height = 40
    Align = alBottom
    TabOrder = 3
    object VokabelanzeigePanel: TPanel
      Left = 290
      Top = 1
      Width = 181
      Height = 38
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      object VokabelanzeigeLabel: TLabel
        Left = 8
        Top = 6
        Width = 57
        Height = 29
        AutoSize = False
        Caption = 'Vokabel- anzeige:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        WordWrap = True
      end
      object AnzElementeTrackBar: TTrackBar
        Left = 58
        Top = 6
        Width = 120
        Height = 25
        Max = 101
        Min = 1
        PageSize = 5
        Frequency = 10
        Position = 25
        TabOrder = 0
        TabStop = False
        OnChange = AnzElementeTrackBarChange
      end
    end
    object SortierungRadioGroup: TRadioGroup
      Left = 1
      Top = 1
      Width = 289
      Height = 38
      Align = alClient
      Caption = 'Sortierung nach:'
      Columns = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ItemIndex = 0
      Items.Strings = (
        'Deutsch'
        'Englisch')
      ParentFont = False
      TabOrder = 1
      OnClick = SortierungRadioGroupClick
    end
  end
  object MainMenu: TMainMenu
    Left = 16
    Top = 32
    object DateiMenu: TMenuItem
      Caption = '&Datei'
      object VokSpeichernMenu: TMenuItem
        Caption = 'Vokabel &speichern...'
        OnClick = VokSpeichernMenuClick
      end
      object VokLadenMenu: TMenuItem
        Caption = 'Vokabeln &laden...'
        OnClick = VokLadenMenuClick
      end
      object Line1Menu: TMenuItem
        Caption = '-'
      end
      object VerlassenMenu: TMenuItem
        Caption = '&Verlassen'
        OnClick = VerlassenMenuClick
      end
    end
  end
  object OpenDialog: TOpenDialog
    Left = 48
    Top = 32
  end
  object SaveDialog: TSaveDialog
    Left = 80
    Top = 32
  end
end
