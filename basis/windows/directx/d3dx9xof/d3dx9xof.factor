USING: alien.syntax classes.struct windows.com windows.com.syntax
windows.directx windows.kernel32 windows.ole32 windows.types ;
IN: windows.directx.d3dx9xof

LIBRARY: d3dx9

TYPEDEF: DWORD D3DXF_FILEFORMAT

CONSTANT: D3DXF_FILEFORMAT_BINARY          0
CONSTANT: D3DXF_FILEFORMAT_TEXT            1
CONSTANT: D3DXF_FILEFORMAT_COMPRESSED      2

TYPEDEF: DWORD D3DXF_FILESAVEOPTIONS

CONSTANT: D3DXF_FILESAVE_TOFILE     0
CONSTANT: D3DXF_FILESAVE_TOWFILE    1

TYPEDEF: DWORD D3DXF_FILELOADOPTIONS

CONSTANT: D3DXF_FILELOAD_FROMFILE     0
CONSTANT: D3DXF_FILELOAD_FROMWFILE    1
CONSTANT: D3DXF_FILELOAD_FROMRESOURCE 2
CONSTANT: D3DXF_FILELOAD_FROMMEMORY   3

STRUCT: D3DXF_FILELOADRESOURCE
    { hModule HMODULE }
    { lpName  LPCSTR  }
    { lpType  LPCSTR  } ;

STRUCT: D3DXF_FILELOADMEMORY
    { lpMemory LPCVOID }
    { dSize    SIZE_T  } ;

C-TYPE: ID3DXFile
C-TYPE: ID3DXFileSaveObject
C-TYPE: ID3DXFileSaveData
C-TYPE: ID3DXFileEnumObject
C-TYPE: ID3DXFileData

TYPEDEF: ID3DXFile* LPD3DXFILE
TYPEDEF: ID3DXFile** LPLPD3DXFILE
TYPEDEF: ID3DXFileEnumObject* LPD3DXFILEENUMOBJECT
TYPEDEF: ID3DXFileEnumObject** LPLPD3DXFILEENUMOBJECT
TYPEDEF: ID3DXFileSaveObject* LPD3DXFILESAVEOBJECT
TYPEDEF: ID3DXFileSaveObject** LPLPD3DXFILESAVEOBJECT
TYPEDEF: ID3DXFileData* LPD3DXFILEDATA
TYPEDEF: ID3DXFileData** LPLPD3DXFILEDATA
TYPEDEF: ID3DXFileSaveData* LPD3DXFILESAVEDATA
TYPEDEF: ID3DXFileSaveData** LPLPD3DXFILESAVEDATA

COM-INTERFACE: ID3DXFile IUnknown {cef08cf9-7b4f-4429-9624-2a690a933201}
    HRESULT CreateEnumObject ( LPCVOID x, D3DXF_FILELOADOPTIONS y,
        ID3DXFileEnumObject** z )
    HRESULT CreateSaveObject ( LPCVOID x, D3DXF_FILESAVEOPTIONS y,
        D3DXF_FILEFORMAT z, ID3DXFileSaveObject** w )
    HRESULT RegisterTemplates ( LPCVOID x, SIZE_T y )
    HRESULT RegisterEnumTemplates ( ID3DXFileEnumObject* x ) ;

COM-INTERFACE: ID3DXFileSaveObject IUnknown {cef08cfa-7b4f-4429-9624-2a690a933201}
    HRESULT GetFile ( ID3DXFile** x )
    HRESULT AddDataObject ( REFGUID x, LPCSTR y, GUID* z,
        SIZE_T w, LPCVOID a, ID3DXFileSaveData** b )
    HRESULT Save ( ) ;

COM-INTERFACE: ID3DXFileSaveData IUnknown {cef08cfb-7b4f-4429-9624-2a690a933201}
    HRESULT GetSave ( ID3DXFileSaveObject** x )
    HRESULT GetName ( LPSTR x, SIZE_T* y )
    HRESULT GetId ( LPGUID x )
    HRESULT GetType ( GUID* x )
    HRESULT AddDataObject ( REFGUID x, LPCSTR y, GUID* z,
        SIZE_T w, LPCVOID a, ID3DXFileSaveData** b )
    HRESULT AddDataReference ( LPCSTR x, GUID* y ) ;

COM-INTERFACE: ID3DXFileEnumObject IUnknown {cef08cfc-7b4f-4429-9624-2a690a933201}
    HRESULT GetFile ( ID3DXFile** x )
    HRESULT GetChildren ( SIZE_T* x )
    HRESULT GetChild ( SIZE_T x, ID3DXFileData** y )
    HRESULT GetDataObjectById ( REFGUID x, ID3DXFileData** y )
    HRESULT GetDataObjectByName ( LPCSTR x, ID3DXFileData** y ) ;

COM-INTERFACE: ID3DXFileData IUnknown {cef08cfd-7b4f-4429-9624-2a690a933201}
    HRESULT GetEnum ( ID3DXFileEnumObject** x )
    HRESULT GetName ( LPSTR x, SIZE_T* y )
    HRESULT GetId ( LPGUID x )
    HRESULT Lock ( SIZE_T* x, LPCVOID* y )
    HRESULT Unlock ( )
    HRESULT GetType ( GUID* x )
    BOOL IsReference ( )
    HRESULT GetChildren ( SIZE_T* x )
    HRESULT GetChild ( SIZE_T x, ID3DXFileData** y ) ;

FUNCTION: HRESULT D3DXFileCreate ( ID3DXFile** lplpDirectXFile ) ;

CONSTANT: D3DXFERR_BADOBJECT              0x88760384
CONSTANT: D3DXFERR_BADVALUE               0x88760385
CONSTANT: D3DXFERR_BADTYPE                0x88760386
CONSTANT: D3DXFERR_NOTFOUND               0x88760387
CONSTANT: D3DXFERR_NOTDONEYET             0x88760388
CONSTANT: D3DXFERR_FILENOTFOUND           0x88760389
CONSTANT: D3DXFERR_RESOURCENOTFOUND       0x8876038A
CONSTANT: D3DXFERR_BADRESOURCE            0x8876038B
CONSTANT: D3DXFERR_BADFILETYPE            0x8876038C
CONSTANT: D3DXFERR_BADFILEVERSION         0x8876038D
CONSTANT: D3DXFERR_BADFILEFLOATSIZE       0x8876038E
CONSTANT: D3DXFERR_BADFILE                0x8876038F
CONSTANT: D3DXFERR_PARSEERROR             0x88760390
CONSTANT: D3DXFERR_BADARRAYSIZE           0x88760391
CONSTANT: D3DXFERR_BADDATAREFERENCE       0x88760392
CONSTANT: D3DXFERR_NOMOREOBJECTS          0x88760393
CONSTANT: D3DXFERR_NOMOREDATA             0x88760394
CONSTANT: D3DXFERR_BADCACHEFILE           0x88760395
