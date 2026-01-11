//========= Copyright Valve Corporation, All rights reserved. ============//
//
// Purpose: 
//
//=============================================================================

#include "stdafx.h"
#include "hammer.h"
#include "ApplyTextureDlg.h"

#pragma warning(disable:4244)

// memdbgon must be the last include file in a .cpp file!!!
#include <tier0/memdbgon.h>

static LPCTSTR pszIni = "Apply Texture";

CApplyTextureDlg::CApplyTextureDlg(CWnd* pParent): CDialog(CApplyTextureDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CApplyTextureDlg)
	m_bDontAskAgain = FALSE;
	//}}AFX_DATA_INIT

	CWinApp *App = AfxGetApp();
}

void CApplyTextureDlg::SaveToIni()
{
	CWinApp *App = AfxGetApp();
	App->WriteProfileInt(pszIni, "DontAskAgain", m_bDontAskAgain);
}

BOOL CApplyTextureDlg::OnInitDialog()
{
	//GetDlgItem( IDC_PASTE_SPECIAL_PREFIX_TEXT )->EnableWindow( bEnable );
	
	return CDialog::OnInitDialog();
}

void CApplyTextureDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CApplyTextureDlg)

	DDX_Check(pDX, IDC_APPLYTEXTURE_DONTASK, m_bDontAskAgain);
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CApplyTextureDlg, CDialog)
	//{{AFX_MSG_MAP(CApplyTextureDlg)
	//ON_BN_CLICKED(IDC_GETOFFSETX, OnGetoffsetx)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

