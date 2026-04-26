//========= Copyright Valve Corporation, All rights reserved. ============//
// ObjectControl.cpp : implementation file
//

#include "stdafx.h"
#include "hammer.h"
#include "ObjectControl.h"
#include "MapDoc.h"
#include "Manifest.h"
#include "MapInstance.h"
#include "ControlBarIDs.h"
#include "p4lib/ip4.h"

//-----------------------------------------------------------------------------
// Purpose: this function will create the hammber bar window
// Input  : pParentWnd - 
// Output : Returns TRUE on success, FALSE on failure.
//-----------------------------------------------------------------------------
BOOL CObjectControl::Create(CWnd *pParentWnd)
{
	// Reverting this manifest bar change - it often won't appear ever again if it's not docked.
	if (!CHammerBar::Create(pParentWnd, IDD_OBJ_CONTROL, CBRS_RIGHT | CBRS_SIZE_DYNAMIC, IDCB_OBJ_CONTROL, "Object Properties"))
	{
		return FALSE;
	}

	bInitialized = TRUE;

	return TRUE;
}

//-----------------------------------------------------------------------------
// Purpose: default destructor
//-----------------------------------------------------------------------------
CObjectControl::~CObjectControl()
{
}


//-----------------------------------------------------------------------------
// Purpose: data exchange function for assigning variables to controls
//-----------------------------------------------------------------------------
void CObjectControl::DoDataExchange(CDataExchange* pDX)
{
	__super::DoDataExchange(pDX);
}

BEGIN_MESSAGE_MAP(CObjectControl, CHammerBar)
	ON_WM_CTLCOLOR()
	ON_WM_DESTROY()
	ON_WM_SIZE()
END_MESSAGE_MAP()


//-----------------------------------------------------------------------------
// Purpose: 
//-----------------------------------------------------------------------------
void CObjectControl::OnDestroy()
{
	__super::OnDestroy();
}

//-----------------------------------------------------------------------------
// Purpose: 
// Input  : nType - 
//			cx - 
//			cy - 
//-----------------------------------------------------------------------------
void CObjectControl::OnSize(UINT nType, int cx, int cy)
{
	// TODO: make larger / resizable when floating
	//if (IsFloating())
	//{
	//	CWnd *pwnd = GetDlgItem(IDC_GROUPS);
	//	if (pwnd && IsWindow(pwnd->GetSafeHwnd()))
	//	{
	//		pwnd->MoveWindow(2, 10, cx - 2, cy - 2, TRUE);
	//	}
	//}

	CHammerBar::OnSize(nType, cx, cy);
}
