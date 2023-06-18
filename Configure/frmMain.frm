VERSION 5.00
Begin VB.Form frmMain 
   BackColor       =   &H80000005&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "��ǩ���ù���"
   ClientHeight    =   8715
   ClientLeft      =   45
   ClientTop       =   390
   ClientWidth     =   7695
   BeginProperty Font 
      Name            =   "΢���ź�"
      Size            =   10.5
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   8715
   ScaleWidth      =   7695
   StartUpPosition =   3  '����ȱʡ
   Begin VB.ComboBox cbRandomMode 
      Height          =   405
      ItemData        =   "frmMain.frx":0000
      Left            =   4560
      List            =   "frmMain.frx":000A
      Style           =   2  'Dropdown List
      TabIndex        =   21
      Top             =   8100
      Width           =   1455
   End
   Begin VB.Frame Frame2 
      BackColor       =   &H80000005&
      Caption         =   "��������"
      Height          =   1875
      Left            =   6120
      TabIndex        =   17
      Top             =   6060
      Width           =   1455
      Begin VB.CommandButton cmdRepEdit 
         Caption         =   "�༭"
         Height          =   360
         Left            =   120
         TabIndex        =   20
         Top             =   1380
         Width           =   990
      End
      Begin VB.CommandButton cmdRepMinus 
         Caption         =   "-"
         Height          =   360
         Left            =   120
         TabIndex        =   19
         Top             =   840
         Width           =   990
      End
      Begin VB.CommandButton cmdRepAdd 
         Caption         =   "+"
         Height          =   360
         Left            =   120
         TabIndex        =   18
         Top             =   360
         Width           =   990
      End
   End
   Begin VB.Frame Frame1 
      BackColor       =   &H80000005&
      Caption         =   "��������"
      Height          =   1875
      Left            =   6120
      TabIndex        =   13
      Top             =   3780
      Width           =   1455
      Begin VB.CommandButton cmdBaoDiAdd 
         Caption         =   "+"
         Height          =   360
         Left            =   120
         TabIndex        =   16
         Top             =   360
         Width           =   990
      End
      Begin VB.CommandButton cmdBaoDiMinus 
         Caption         =   "-"
         Height          =   360
         Left            =   120
         TabIndex        =   15
         Top             =   840
         Width           =   990
      End
      Begin VB.CommandButton cmdBaoDiEdit 
         Caption         =   "�༭"
         Height          =   360
         Left            =   120
         TabIndex        =   14
         Top             =   1380
         Width           =   990
      End
   End
   Begin VB.Frame frmStudents 
      BackColor       =   &H80000005&
      Caption         =   "ѧ���б�"
      Height          =   3315
      Left            =   6120
      TabIndex        =   9
      Top             =   120
      Width           =   1455
      Begin VB.CommandButton cmdStudentEdit 
         Caption         =   "�༭"
         Height          =   360
         Left            =   120
         TabIndex        =   12
         Top             =   1440
         Width           =   990
      End
      Begin VB.CommandButton cmdStudentsMinus 
         Caption         =   "-"
         Height          =   360
         Left            =   120
         TabIndex        =   11
         Top             =   900
         Width           =   990
      End
      Begin VB.CommandButton cmdStudentsAdd 
         Caption         =   "+"
         Height          =   360
         Left            =   120
         TabIndex        =   10
         Top             =   360
         Width           =   990
      End
   End
   Begin VB.CommandButton cmdGo 
      Caption         =   "Go!"
      Height          =   540
      Left            =   6120
      TabIndex        =   8
      Top             =   8040
      Width           =   1410
   End
   Begin VB.TextBox txtAPICooldown 
      Height          =   405
      Left            =   1680
      TabIndex        =   6
      Top             =   8160
      Width           =   855
   End
   Begin VB.ListBox lstReplacements 
      Height          =   1770
      Left            =   120
      TabIndex        =   4
      Top             =   6180
      Width           =   5895
   End
   Begin VB.ListBox lstBaoDi 
      Height          =   1770
      Left            =   120
      TabIndex        =   2
      Top             =   3900
      Width           =   5895
   End
   Begin VB.ListBox lstStudent 
      Height          =   3195
      Left            =   120
      TabIndex        =   0
      Top             =   240
      Width           =   5895
   End
   Begin VB.Label Label4 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "����    �����ģʽ"
      Height          =   285
      Left            =   2640
      TabIndex        =   7
      Top             =   8160
      Width           =   1710
   End
   Begin VB.Label Label3 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "��ά��ʩ����ȴ"
      Height          =   285
      Left            =   120
      TabIndex        =   5
      Top             =   8160
      Width           =   1470
   End
   Begin VB.Label Label2 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "��������"
      Height          =   285
      Left            =   120
      TabIndex        =   3
      Top             =   5760
      Width           =   840
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "��������"
      Height          =   285
      Left            =   120
      TabIndex        =   1
      Top             =   3480
      Width           =   840
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim Config As Dictionary
Dim FS As New FileSystemObject
Dim JSON As New cJSON
Dim UTF8Encoding As New mscorlib.UTF8Encoding


Sub LoadStudentList()
    lstStudent.Clear
    Dim EachStudent As Collection
    Dim idx%
    For Each EachStudent In Config("chouqian")("students")
        lstStudent.AddItem EachStudent(1) + " " + EachStudent(2), idx
        idx = idx + 1
    Next
End Sub

Sub LoadBaoDi()
    lstBaoDi.Clear
    Dim EachBaoDi As Dictionary
    Dim idx%
    For Each EachBaoDi In Config("chouqian")("special_config")("baodi")
        lstBaoDi.AddItem EachBaoDi("number") + "�� " + Str(EachBaoDi("baodi_count")) + "��", idx
        idx = idx + 1
    Next
End Sub

Sub LoadReplacements()
    lstReplacements.Clear
    Dim EachRep As Dictionary
    Dim idx%
    For Each EachRep In Config("chouqian")("special_config")("replacements")
        lstReplacements.AddItem EachRep("number") + "�ţ����� " + EachRep("value_to") + "��" + Str(EachRep("rate")) + "%", idx
        idx = idx + 1
    Next
End Sub

Sub LoadMisc()
    txtAPICooldown = CStr(Config("chouqian")("api_cooldown"))
    Select Case Config("chouqian")("random_mode")
        Case "math": cbRandomMode.ListIndex = 0
        Case "crypto": cbRandomMode.ListIndex = 1
    End Select
End Sub

Private Sub cmdBaoDiAdd_Click()
    With lstBaoDi
        If .ListIndex <> -1 Then
            Dim StudentToAdd As New Dictionary
            StudentToAdd.Add "number", InputBox("ѧ��")
            StudentToAdd.Add "baodi_count", CInt(InputBox("���״���"))
            Config("chouqian")("special_config")("baodi").Add Item:=StudentToAdd, After:=.ListIndex + 1
            LoadBaoDi
        End If
    End With
End Sub

Private Sub cmdBaoDiEdit_Click()
    With lstBaoDi
        If .ListIndex <> -1 Then
            Dim StudentToAdd As New Dictionary
            StudentToAdd.Add "number", InputBox("ѧ��")
            StudentToAdd.Add "baodi_count", CInt(InputBox("���״���"))
            Config("chouqian")("special_config")("baodi").Add Item:=StudentToAdd, After:=.ListIndex + 1
            Config("chouqian")("special_config")("baodi").Remove .ListIndex + 1
            LoadBaoDi
        End If
    End With
End Sub

Private Sub cmdBaoDiMinus_Click()
    With lstStudent
        If .ListIndex <> -1 Then
            Config("chouqian")("special_config")("baodi").Remove .ListIndex + 1
            LoadBaoDi
        End If
    End With
End Sub

Private Sub cmdRepAdd_Click()
    With lstReplacements
        If .ListIndex <> -1 Then
            Dim StudentToAdd As New Dictionary
            StudentToAdd.Add "number", InputBox("ѧ��")
            StudentToAdd.Add "key", "name"
            StudentToAdd.Add "value_to", InputBox("����")
            StudentToAdd.Add "rate", CInt(InputBox("���ʣ��ٷ�֮���٣�"))
            Config("chouqian")("special_config")("replacements").Add Item:=StudentToAdd, After:=.ListIndex + 1
            LoadReplacements
        End If
    End With
End Sub

Private Sub cmdRepEdit_Click()
    With lstReplacements
        If .ListIndex <> -1 Then
            Dim StudentToAdd As New Dictionary
            StudentToAdd.Add "number", InputBox("ѧ��")
            StudentToAdd.Add "key", "name"
            StudentToAdd.Add "value_to", InputBox("����")
            StudentToAdd.Add "rate", CInt(InputBox("���ʣ��ٷ�֮���٣�"))
            Config("chouqian")("special_config")("replacements").Add Item:=StudentToAdd, After:=.ListIndex + 1
            Config("chouqian")("special_config")("replacements").Remove .ListIndex + 1
            LoadReplacements
        End If
    End With
End Sub

Private Sub cmdRepMinus_Click()
    With lstReplacements
        If .ListIndex <> -1 Then
            Config("chouqian")("special_config")("replacements").Remove .ListIndex + 1
            LoadReplacements
        End If
    End With
End Sub

Private Sub cmdStudentEdit_Click()
    With lstStudent
        If .ListIndex <> -1 Then
            Dim StudentToAdd As New Collection
            StudentToAdd.Add InputBox("ѧ��")
            StudentToAdd.Add InputBox("����")
            Config("chouqian")("students").Add Item:=StudentToAdd, After:=.ListIndex + 1
            Config("chouqian")("students").Remove .ListIndex + 1
            LoadStudentList
        End If
    End With
End Sub

Private Sub cmdStudentsAdd_Click()
    With lstStudent
        If .ListIndex <> -1 Then
            Dim StudentToAdd As New Collection
            StudentToAdd.Add InputBox("ѧ��")
            StudentToAdd.Add InputBox("����")
            Config("chouqian")("students").Add Item:=StudentToAdd, After:=.ListIndex + 1
            LoadStudentList
        End If
    End With
End Sub

Private Sub cmdStudentsMinus_Click()
    With lstStudent
        If .ListIndex <> -1 Then
            Config("chouqian")("students").Remove .ListIndex + 1
            LoadStudentList
        End If
    End With
End Sub

Private Sub Form_Load()
    'Dim BackendJsonPath As String: BackendJsonPath = "C:\Users\yidaozhan\Desktop\ChouQian3\Backend\chouqian_backend.json"
    Dim BackendJsonPath As String: BackendJsonPath = App.Path + "\Backend\chouqian_backend.json"
    Dim ConfigContent() As Byte
    Open BackendJsonPath For Binary Access Read As #1
        ReDim ConfigContent(LOF(1) - 1)
        Get #1, , ConfigContent
    Close #1
    Set Config = JSON.Parse(UTF8Encoding.GetString(ConfigContent))
    LoadStudentList
    LoadBaoDi
    LoadReplacements
    LoadMisc
End Sub

Private Sub cmdGo_Click()
    'Dim BackendJsonPath As String: BackendJsonPath = "C:\Users\yidaozhan\Desktop\ChouQian3\Backend\chouqian_backend.json"
    Dim BackendJsonPath As String: BackendJsonPath = App.Path + "\Backend\chouqian_backend.json"
    Dim ConfigContent() As Byte
    Config("chouqian")("api_cooldown") = CInt(txtAPICooldown.Text)
    Config("chouqian")("random_mode") = cbRandomMode.Text
    ConfigContent = UTF8Encoding.GetBytes_4(JSON.ToString(Config))
    Open BackendJsonPath For Output Lock Write As #1
        '����ļ�����
        Print #1, vbNullString
    Close #1
    Open BackendJsonPath For Binary Lock Write As #1
        Put #1, , ConfigContent
    Close #1
    '���¼�������
    On Error Resume Next
    Dim Host As String: Host = JSON.Parse(FS.OpenTextFile(App.Path + "\config.json", ForReading).ReadAll)!Host
    With New WinHttpRequest
        .Open Method:="GET", Url:="http://" + Host + "/api/reconfigure", Async:=True
        .Send
        .WaitForResponse
    End With
End Sub

