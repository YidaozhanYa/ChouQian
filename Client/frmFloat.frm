VERSION 5.00
Begin VB.Form frmFloat 
   BorderStyle     =   0  'None
   Caption         =   "��ǩ������"
   ClientHeight    =   1590
   ClientLeft      =   1020
   ClientTop       =   1410
   ClientWidth     =   1005
   LinkTopic       =   "Form2"
   ScaleHeight     =   1590
   ScaleWidth      =   1005
   ShowInTaskbar   =   0   'False
   Begin VB.Image Image1 
      Height          =   1470
      Left            =   30
      Picture         =   "frmFloat.frx":0000
      Stretch         =   -1  'True
      Top             =   0
      Width           =   885
   End
End
Attribute VB_Name = "frmFloat"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

'�����ö����ڵ� API

Private IsDragging As Boolean
Private DragStartX!, DragStartY!, DragStartTop!, DragStartLeft!

Private Sub Form_Load()
    Dim FSO As New FileSystemObject
    
    '���ڳ�ʼ��
    
    '�ö�����
    Call APIs.SetWindowPos( _
        hWnd:=Me.hWnd, _
        hWndInsertAfter:=APIs.HWND_TOPMOST, _
        X:=0, Y:=0, cx:=0, cy:=0, _
        wFlags:=(APIs.SWP_NOMOVE Or APIs.SWP_NOSIZE) _
    )
    
    'HiDPI �������
    Me.Height = Image1.Height
    Me.Width = Image1.Width
    
    '�ƶ�λ��
    Me.Top = Screen.Height - Me.Height - 4000
    Me.Left = Screen.Width - Me.Width - 800
    
    '͸��
    Me.BackColor = vbCyan
    Call APIs.SetWindowLong( _
        Me.hWnd, _
        APIs.GWL_EXSTYLE, _
        APIs.GetWindowLong(Me.hWnd, APIs.GWL_EXSTYLE) Or APIs.WS_EX_LAYERED _
    )
    Call APIs.SetLayeredWindowAttributes(Me.hWnd, vbCyan, 0&, APIs.LWA_COLORKEY)
    
    '�޸� bug ��õİ취���ǽ������ bug ����
    
    If App.LogMode <> 0 Then
        If App.PrevInstance Then
            MsgBox "��ֹ�࿪��", vbCritical
            End
        End If
    End If
    
    
    '���
    
    If Not FSO.FileExists(App.Path & "\Backend\ChouQianBackend.exe") Then
        MsgBox "�����𻵣���˳���ʧ��", vbCritical
        End
    Else
        '�������
        With New WshShell
            .Run """" & App.Path & "\Backend\ChouQianBackend.exe"" """ & App.Path & "\Frontend""", WshHide
        End With
    End If
    
    '�����ļ�
    
    Config.Config = Config.LoadConfig
End Sub

Private Sub Image1_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
    If Button = 2 Then
        '�˳�����
        With New WshShell
            .Run "taskkill /f /im ChouQianBackend.exe", WshHide
        End With
        End
    ElseIf Button = 1 And Not IsDragging Then
        IsDragging = True
        DragStartX = X
        DragStartY = Y
        DragStartTop = Me.Top
        DragStartLeft = Me.Left
    End If
End Sub

Private Sub Image1_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    If IsDragging Then
        Me.Top = Me.Top + Y - DragStartY
        Me.Left = Me.Left + X - DragStartX
    End If
End Sub

Private Sub Image1_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
    IsDragging = False
    Dim DraggingDelta#
    DraggingDelta = Sqr((Me.Left - DragStartLeft) ^ 2 + (Me.Top - DragStartTop) ^ 2)
    If DraggingDelta < 100 Then frmMain.ShowWindow
End Sub
