VERSION 5.00
Begin VB.Form frmMain 
   BackColor       =   &H80000005&
   Caption         =   "��ǩ"
   ClientHeight    =   2955
   ClientLeft      =   6090
   ClientTop       =   3375
   ClientWidth     =   4005
   Icon            =   "frmMain.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   ScaleHeight     =   2955
   ScaleWidth      =   4005
   Begin VB.CommandButton btnDev 
      Caption         =   "��Ļ"
      BeginProperty Font 
         Name            =   "΢���ź�"
         Size            =   9
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   360
      Left            =   1440
      TabIndex        =   2
      Top             =   4380
      Width           =   990
   End
   Begin VB.Label lblVersion 
      Alignment       =   2  'Center
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Label1"
      BeginProperty Font 
         Name            =   "΢���ź�"
         Size            =   9
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   225
      Left            =   1680
      TabIndex        =   3
      Top             =   4920
      Width           =   510
   End
   Begin VB.Label lblNumber 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "ѧ��"
      BeginProperty Font 
         Name            =   "΢���ź�"
         Size            =   21.75
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   795
      Left            =   30
      TabIndex        =   1
      Top             =   1560
      Width           =   3915
   End
   Begin VB.Label lblName 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "����"
      BeginProperty Font 
         Name            =   "΢���ź�"
         Size            =   32.25
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   975
      Left            =   60
      TabIndex        =   0
      Top             =   360
      Width           =   3915
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Sub ShowWindow()
    Dim JSON As New cJSON
    '�ö�����
    Call APIs.SetWindowPos( _
        hWnd:=Me.hWnd, _
        hWndInsertAfter:=APIs.HWND_TOPMOST, _
        X:=0, Y:=0, cx:=0, cy:=0, _
        wFlags:=(APIs.SWP_NOMOVE Or APIs.SWP_NOSIZE) _
    )
    '���ô���λ��
    Me.Height = 3075
    Me.Width = 4125
    Me.Left = frmFloat.Left - frmFloat.Width - 2000
    Me.Top = frmFloat.Top - frmFloat.Height
    '��ȡ���ѧ��
    With New WinHttpRequest
        .Open Method:="GET", _
              Url:="http://" + Config.Config!Host + "/api/student/random", _
              Async:=True
        .Send
        .WaitForResponse
        Dim Student As Dictionary
        Set Student = JSON.parse(.ResponseText)
        lblName = Student("name")
        lblNumber = Student("number")
    End With
    Me.Show
End Sub

Private Sub btnDev_Click()
    frmDev.Show
End Sub

Private Sub Form_Load()
    Dim JSON As New cJSON
    '���ذ汾��
    With New WinHttpRequest
        .Open Method:="GET", _
              Url:="http://" + Config.Config!Host + "/api/version", _
              Async:=True
        .Send
        .WaitForResponse
        lblVersion = JSON.parse(.ResponseText)("version")
    End With
End Sub

'FOLDED: Private Sub Form_Click ()
'FOLDED: Private Sub lblName_Click ()
'FOLDED: Private Sub lblNumber_Click ()











'\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
'  --- All folded content will be temporary put under this lines ---
'/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
'CODEFOLD STORAGE:
Private Sub Form_Click()
    Me.Hide
End Sub
Private Sub lblName_Click()
    Me.Hide
End Sub

Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)
    Cancel = 1
    Me.Hide
End Sub

Private Sub lblNumber_Click()
    Me.Hide
End Sub
'CODEFOLD STORAGE END:
'\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
'--- If you're Subclassing: Move the CODEFOLD STORAGE up as needed ---
'/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\


