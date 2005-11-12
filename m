Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Nov 2005 19:50:22 +0000 (GMT)
Received: from xproxy.gmail.com ([66.249.82.204]:38859 "EHLO xproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133877AbVKLTuC (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 12 Nov 2005 19:50:02 +0000
Received: by xproxy.gmail.com with SMTP id h30so1028952wxd
        for <linux-mips@linux-mips.org>; Sat, 12 Nov 2005 11:51:43 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=iguOMrw9MFXLQrwwqbo6njnS4MN2EGLDZIbRRogNlRnA0VOV+vNxU/EEogFX2mx+ql3DnC1zj9n/BFXHWu6uF+D2nbgkNjpd/T9C0m3BxTL9SebZUFu3paxXcO7CNckSxiSkucwA+klbo7pAcAQfuFnYWeRY/Www3N89OJ2fr9w=
Received: by 10.65.155.17 with SMTP id h17mr3943669qbo;
        Sat, 12 Nov 2005 11:51:43 -0800 (PST)
Received: from gmail.com ( [217.10.38.130])
        by mx.gmail.com with ESMTP id e14sm729083qba.2005.11.12.11.51.40;
        Sat, 12 Nov 2005 11:51:43 -0800 (PST)
Received: by gmail.com (nbSMTP-1.00) for uid 1000
	(using TLSv1/SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
	adobriyan@gmail.com; Sat, 12 Nov 2005 23:05:25 +0300 (MSK)
Date:	Sat, 12 Nov 2005 23:05:21 +0300
From:	Alexey Dobriyan <adobriyan@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>, Andrew Morton <akpm@osdl.org>
Cc:	Domen Puncer <domen@coderock.org>, linux-mips@linux-mips.org
Subject: [PATCH] Remove include/asm-mips/gfx.h
Message-ID: <20051112200521.GD19876@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Return-Path: <adobriyan@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9472
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: adobriyan@gmail.com
Precedence: bulk
X-list: linux-mips

From: Domen Puncer <domen@coderock.org>

Remove nowhere referenced file ("grep 'gfx\.' -r ." didn't find anything).

Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

Index: linux-kj/include/asm-mips/gfx.h
===================================================================
--- linux-kj.orig/include/asm-mips/gfx.h	2005-11-12 15:37:57.000000000 +0300
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
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
