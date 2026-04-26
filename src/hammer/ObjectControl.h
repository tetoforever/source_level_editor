//========= Copyright Valve Corporation, All rights reserved. ============//
//
// Purpose: 
//
// $NoKeywords: $
//=============================================================================//

#ifndef OBJCONTROLDIALOG_H
#define OBJCONTROLDIALOG_H
#pragma once

#include "afxcmn.h"
#include "afxwin.h"
#include "HammerBar.h"

class CObjectControl : public CHammerBar
{
public:
	CObjectControl() : CHammerBar() { bInitialized = FALSE; }
	BOOL Create(CWnd *pParentWnd);

	virtual ~CObjectControl();

	void UpdateManifestList( void );

// Dialog Data
	enum { IDD = IDD_OBJ_CONTROL };

private:
	BOOL				bInitialized;

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support

	DECLARE_MESSAGE_MAP()
public:
	//{{AFX_MSG(CObjectControl)
	afx_msg void OnDestroy();
	afx_msg void OnSize(UINT nType, int cx, int cy);
	//}}AFX_MSG
};


#endif // OBJCONTROLDIALOG_H

