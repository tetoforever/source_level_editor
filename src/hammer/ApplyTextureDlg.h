//========= Copyright Valve Corporation, All rights reserved. ============//
//
// Purpose: 
//
//=============================================================================

#include "BoundBox.h"

class CApplyTextureDlg : public CDialog
{
// Construction
public:
	CApplyTextureDlg(CWnd* pParent);
	void SaveToIni();

// Dialog Data
	//{{AFX_DATA(CApplyTextureDlg)
	enum { IDD = IDD_APPLYTEXTURE };
	BOOL	m_bDontAskAgain;
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CApplyTextureDlg)
	protected:
	virtual BOOL OnInitDialog();
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	// Generated message map functions
	//{{AFX_MSG(CApplyTextureDlg)

	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};