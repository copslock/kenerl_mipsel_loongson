Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Dec 2004 17:26:10 +0000 (GMT)
Received: from coderock.org ([IPv6:::ffff:193.77.147.115]:65500 "EHLO
	trashy.coderock.org") by linux-mips.org with ESMTP
	id <S8225262AbULYRZH>; Sat, 25 Dec 2004 17:25:07 +0000
Received: by trashy.coderock.org (Postfix, from userid 780)
	id D68B01F127; Sat, 25 Dec 2004 18:24:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by trashy.coderock.org (Postfix) with ESMTP id D71DA1F124;
	Sat, 25 Dec 2004 18:24:50 +0100 (CET)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by trashy.coderock.org (Postfix) with ESMTP id 3330D1ED41;
	Sat, 25 Dec 2004 18:24:46 +0100 (CET)
Subject: [patch 3/9] delete unused file
To: ralf@linux-mips.org
Cc: linux-mips@linux-mips.org, domen@coderock.org
From: domen@coderock.org
Date: Sat, 25 Dec 2004 18:24:56 +0100
Message-Id: <20041225172446.3330D1ED41@trashy.coderock.org>
Return-Path: <domen@coderock.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6756
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: domen@coderock.org
Precedence: bulk
X-list: linux-mips


Remove nowhere referenced file. (egrep "filename\." didn't find anything)

Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj/include/asm-mips/gfx.h |   55 ----------------------------------------------
 1 files changed, 55 deletions(-)

diff -L include/asm-mips/gfx.h -puN include/asm-mips/gfx.h~remove_file-include_asm_mips_gfx.h /dev/null
--- kj/include/asm-mips/gfx.h
+++ /dev/null	2004-12-24 01:21:08.000000000 +0100
@@ -1,55 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * This is the user-visible SGI GFX interface.
- *
- * This must be used verbatim into the GNU libc.  It does not include
- * any kernel-only bits on it.
- *
- * miguel@nuclecu.unam.mx
- */
-#ifndef _ASM_GFX_H
-#define _ASM_GFX_H
-
-/* The iocls, yes, they do not make sense, but such is life */
-#define GFX_BASE             100
-#define GFX_GETNUM_BOARDS    (GFX_BASE + 1)
-#define GFX_GETBOARD_INFO    (GFX_BASE + 2)
-#define GFX_ATTACH_BOARD     (GFX_BASE + 3)
-#define GFX_DETACH_BOARD     (GFX_BASE + 4)
-#define GFX_IS_MANAGED       (GFX_BASE + 5)
-
-#define GFX_MAPALL           (GFX_BASE + 10)
-#define GFX_LABEL            (GFX_BASE + 11)
-
-#define GFX_INFO_NAME_SIZE  16
-#define GFX_INFO_LABEL_SIZE 16
-
-struct gfx_info {
-	char name  [GFX_INFO_NAME_SIZE];  /* board name */
-	char label [GFX_INFO_LABEL_SIZE]; /* label name */
-	unsigned short int xpmax, ypmax;  /* screen resolution */
-	unsigned int lenght;	          /* size of a complete gfx_info for this board */
-};
-
-struct gfx_getboardinfo_args {
-	unsigned int board;     /* board number.  starting from zero */
-	void *buf;              /* pointer to gfx_info */
-	unsigned int len;       /* buffer size of buf */
-};
-
-struct gfx_attach_board_args {
-	unsigned int board;	/* board number, starting from zero */
-	void        *vaddr;	/* address where the board registers should be mapped */
-};
-
-#ifdef __KERNEL__
-/* umap.c */
-extern void remove_mapping (struct vm_area_struct *vma, struct task_struct *, unsigned long, unsigned long);
-extern void *vmalloc_uncached (unsigned long size);
-extern int vmap_page_range (struct vm_area_struct *vma, unsigned long from, unsigned long size, unsigned long vaddr);
-#endif
-
-#endif /* _ASM_GFX_H */
_
