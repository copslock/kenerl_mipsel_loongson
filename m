Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 07 Oct 2007 00:52:19 +0100 (BST)
Received: from mail.gmx.net ([213.165.64.20]:19414 "HELO mail.gmx.net")
	by ftp.linux-mips.org with SMTP id S20028963AbXJFXwL (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 7 Oct 2007 00:52:11 +0100
Received: (qmail invoked by alias); 06 Oct 2007 23:51:05 -0000
Received: from p548B08F8.dip0.t-ipconnect.de (EHLO [192.168.120.22]) [84.139.8.248]
  by mail.gmx.net (mp032) with SMTP; 07 Oct 2007 01:51:05 +0200
X-Authenticated: #16080105
X-Provags-ID: V01U2FsdGVkX18YId5DHHkYrWQ/lnvNwUANaUV/REfwHzHFIZhiih
	hYZv7DXNsBAiOz
Message-ID: <47081F68.2030907@gmx.de>
Date:	Sun, 07 Oct 2007 01:51:04 +0200
From:	Johannes Dickgreber <tanzy@gmx.de>
User-Agent: Thunderbird 1.5.0.12 (X11/20060911)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: [PATCH] On a SGI Octane not all ARCS Memory if freed for kernel use
X-Enigmail-Version: 0.95.2
Content-Type: multipart/mixed;
 boundary="------------040404070406020901070209"
X-Y-GMX-Trusted: 0
Return-Path: <tanzy@gmx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16878
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tanzy@gmx.de
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------040404070406020901070209
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi

Only tested on a SGI Octane, i dont know if it works on
JAZZ SNI_RM or SGI O2.

It frees only 60KB.

There is an ARCMemoryRegisterDump in the attached file.

Signed-off-by: Johannes Dickgreber tanzy@gmx.de
---
On a SGI Octane not all ARCS Memory is freed for kernel use


--- linux-2.6.22.6/arch/mips/arc/memory.c	2007-07-09 01:32:17 +0200
+++ linux-octane-2/arch/mips/arc/memory.c	2007-10-06 22:04:07 +0200
@@ -70,11 +70,11 @@ static inline int memtype_classify_arcs 
 	case arcs_free:
 		return BOOT_MEM_RAM;
 	case arcs_atmp:
+	case arcs_prog:
 		return BOOT_MEM_ROM_DATA;
 	case arcs_eblock:
 	case arcs_rvpage:
 	case arcs_bmem:
-	case arcs_prog:
 	case arcs_aperm:
 		return BOOT_MEM_RESERVED;
 	default:
@@ -90,11 +90,11 @@ static inline int memtype_classify_arc (
 	case arc_fcontig:
 		return BOOT_MEM_RAM;
 	case arc_atmp:
+	case arc_prog:
 		return BOOT_MEM_ROM_DATA;
 	case arc_eblock:
 	case arc_rvpage:
 	case arc_bmem:
-	case arc_prog:
 	case arc_aperm:
 		return BOOT_MEM_RESERVED;
 	default:

--------------040404070406020901070209
Content-Type: text/plain;
 name="ARC_MEMORY.msg"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="ARC_MEMORY.msg"

T2N0ICA1IDEzOjU3OjMxIHJhY2VyIExpbnV4IHZlcnNpb24gMi42LjIyLW9jdGFuZS0yIChy
b290QHJhY2VyKSAoZ2NjIHZlcnNpb24gNC4xLjEgKEdlbnRvbyA0LjEuMS1yMyBwMS4xMCkp
ICMxMSBGcmkgT2N0IDUgMTM6NTQ6NTIgQ0VTVCAyMDA3Ck9jdCAgNSAxMzo1NzozMSByYWNl
ciBBUkNIOiBTR0ktSVAzMApPY3QgIDUgMTM6NTc6MzEgcmFjZXIgUFJPTUxJQjogQVJDIGZp
cm13YXJlIFZlcnNpb24gNjQgUmV2aXNpb24gMApPY3QgIDUgMTM6NTc6MzEgcmFjZXIgQVJD
UyBNRU1PUlkgREVTQ1JJUFRPUiBkdW1wOgpPY3QgIDUgMTM6NTc6MzEgcmFjZXIgWzAsYTgw
MDAwMDAyMGYzMmM5MF06IGJhc2U8MDAwMDAwMDA+IHBhZ2VzPDAwMDAwMDAxPiB0eXBlPEV4
Y2VwdGlvbiBCbG9jaz4KT2N0ICA1IDEzOjU3OjMxIHJhY2VyIFsxLGE4MDAwMDAwMjBmMzJk
MTBdOiBiYXNlPDAwMDAwMDAxPiBwYWdlczwwMDAwMDAwMT4gdHlwZTxBUkNTIFJvbXZlYyBQ
YWdlPgpPY3QgIDUgMTM6NTc6MzEgcmFjZXIgWzIsYTgwMDAwMDAyMGYzMmNkMF06IGJhc2U8
MDAwMDAwMDI+IHBhZ2VzPDAwMDAwMDAyPiB0eXBlPEFSQ1MgUGVybWFuZW50IFN0b3JhZ2Ug
QXJlYT4KT2N0ICA1IDEzOjU3OjMxIHJhY2VyIFszLGE4MDAwMDAwMjBmMzJhMTBdOiBiYXNl
PDAwMDIwMDA0PiBwYWdlczwwMDAwMGVmYz4gdHlwZTxHZW5lcmljIEZyZWUgUkFNPgpPY3Qg
IDUgMTM6NTc6MzEgcmFjZXIgWzQsYTgwMDAwMDAyMGYzNGExMF06IGJhc2U8MDAwMjBmMDA+
IHBhZ2VzPDAwMDAwMTAwPiB0eXBlPEFSQ1MgVGVtcCBTdG9yYWdlIEFyZWE+Ck9jdCAgNSAx
Mzo1NzozMSByYWNlciBbNSxhODAwMDAwMDIwZjM0OWQwXTogYmFzZTwwMDAyMTAwMD4gcGFn
ZXM8MDAwM2VmZjA+IHR5cGU8R2VuZXJpYyBGcmVlIFJBTT4KT2N0ICA1IDEzOjU3OjMxIHJh
Y2VyIFs2LGE4MDAwMDAwMjBmMzRiZDBdOiBiYXNlPDAwMDVmZmYwPiBwYWdlczwwMDAwMDAw
Zj4gdHlwZTxTdGFuZGFsb25lIFByb2dyYW0gUGFnZXM+Ck9jdCAgNSAxMzo1NzozMSByYWNl
ciBbNyxhODAwMDAwMDIwZjM0YjkwXTogYmFzZTwwMDA1ZmZmZj4gcGFnZXM8MDAwMDAwMDE+
IHR5cGU8R2VuZXJpYyBGcmVlIFJBTT4KT2N0ICA1IDEzOjU3OjMxIHJhY2VyIENQVSByZXZp
c2lvbiBpczogMDAwMDBlMjMKT2N0ICA1IDEzOjU3OjMxIHJhY2VyIEZQVSByZXZpc2lvbiBp
czogMDAwMDA5MDAKT2N0ICA1IDEzOjU3OjMxIHJhY2VyIFNpbGljb24gR3JhcGhpY3MgT2N0
YW5lIChJUDMwKSBzdXBwb3J0OiAoYykgMjAwNC0yMDA3IFN0YW5pc2xhdyBTa293cm9uZWsu
Ck9jdCAgNSAxMzo1NzozMSByYWNlciBEZXRlY3RlZCAxMDI0IE1CIG9mIHBoeXNpY2FsIG1l
bW9yeS4KT2N0ICA1IDEzOjU3OjMxIHJhY2VyIERldGVybWluZWQgcGh5c2ljYWwgUkFNIG1h
cDoKT2N0ICA1IDEzOjU3OjMxIHJhY2VyIG1lbW9yeTogMDAwMDAwMDAwMDAwNDAwMCBAIDAw
MDAwMDAwMDAwMDAwMDAgKHJlc2VydmVkKQpPY3QgIDUgMTM6NTc6MzEgcmFjZXIgbWVtb3J5
OiAwMDAwMDAwMDAwZWZjMDAwIEAgMDAwMDAwMDAyMDAwNDAwMCAodXNhYmxlKQpPY3QgIDUg
MTM6NTc6MzEgcmFjZXIgbWVtb3J5OiAwMDAwMDAwMDAwMTAwMDAwIEAgMDAwMDAwMDAyMGYw
MDAwMCAoUk9NIGRhdGEpCk9jdCAgNSAxMzo1NzozMSByYWNlciBtZW1vcnk6IDAwMDAwMDAw
M2VmZjAwMDAgQCAwMDAwMDAwMDIxMDAwMDAwICh1c2FibGUpCk9jdCAgNSAxMzo1NzozMSBy
YWNlciBtZW1vcnk6IDAwMDAwMDAwMDAwMGYwMDAgQCAwMDAwMDAwMDVmZmYwMDAwIChyZXNl
cnZlZCkKT2N0ICA1IDEzOjU3OjMxIHJhY2VyIG1lbW9yeTogMDAwMDAwMDAwMDAwMTAwMCBA
IDAwMDAwMDAwNWZmZmYwMDAgKHVzYWJsZSkKT2N0ICA1IDEzOjU3OjMxIHJhY2VyIFdhc3Rp
bmcgNzM0MDI1NiBieXRlcyBmb3IgdHJhY2tpbmcgMTMxMDc2IHVudXNlZCBwYWdlcwpPY3Qg
IDUgMTM6NTc6MzEgcmFjZXIgT24gbm9kZSAwIHRvdGFscGFnZXM6IDM5MzIxNgpPY3QgIDUg
MTM6NTc6MzEgcmFjZXIgRE1BIHpvbmU6IDUzNzYgcGFnZXMgdXNlZCBmb3IgbWVtbWFwCk9j
dCAgNSAxMzo1NzozMSByYWNlciBETUEgem9uZTogMCBwYWdlcyByZXNlcnZlZApPY3QgIDUg
MTM6NTc6MzEgcmFjZXIgRE1BIHpvbmU6IDM4Nzg0MCBwYWdlcywgTElGTyBiYXRjaDozMQpP
Y3QgIDUgMTM6NTc6MzEgcmFjZXIgTm9ybWFsIHpvbmU6IDAgcGFnZXMgdXNlZCBmb3IgbWVt
bWFwCk9jdCAgNSAxMzo1NzozMSByYWNlciBCdWlsdCAxIHpvbmVsaXN0cy4gIFRvdGFsIHBh
Z2VzOiAzODc4NDAK
--------------040404070406020901070209--
