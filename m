Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jul 2007 15:07:58 +0100 (BST)
Received: from mo32.po.2iij.NET ([210.128.50.17]:63240 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20021552AbXGQOHw (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 17 Jul 2007 15:07:52 +0100
Received: by mo.po.2iij.net (mo32) id l6HE7mTo080703; Tue, 17 Jul 2007 23:07:48 +0900 (JST)
Received: from localhost.localdomain (231.26.30.125.dy.iij4u.or.jp [125.30.26.231])
	by mbox.po.2iij.net (po-mbox301) id l6HE7jlZ008907
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 17 Jul 2007 23:07:45 +0900
Date:	Tue, 17 Jul 2007 23:07:44 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] remove unused gfx.h
Message-Id: <20070717230744.39ff8a17.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15794
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips


Remove unused gfx.h

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/gfx.h mips/include/asm-mips/gfx.h
--- mips-orig/include/asm-mips/gfx.h	2007-07-17 17:05:12.412909250 +0900
+++ mips/include/asm-mips/gfx.h	1970-01-01 09:00:00.000000000 +0900
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
