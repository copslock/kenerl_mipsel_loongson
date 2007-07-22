Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Jul 2007 05:04:58 +0100 (BST)
Received: from mo30.po.2iij.NET ([210.128.50.53]:10556 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20021909AbXGVEE4 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 22 Jul 2007 05:04:56 +0100
Received: by mo.po.2iij.net (mo30) id l6M43d3Q004427; Sun, 22 Jul 2007 13:03:39 +0900 (JST)
Received: from localhost.localdomain (231.26.30.125.dy.iij4u.or.jp [125.30.26.231])
	by mbox.po.2iij.net (po-mbox303) id l6M43b4F006130
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 22 Jul 2007 13:03:37 +0900
Date:	Sun, 22 Jul 2007 13:03:37 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] remove unused arch/mips/jazz/io.c
Message-Id: <20070722130337.122e2fbd.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15847
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips


Remove unused arch/mips/jazz/io.c

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X generic/Documentation/dontdiff generic-orig/arch/mips/jazz/io.c generic/arch/mips/jazz/io.c
--- generic-orig/arch/mips/jazz/io.c	2007-07-21 21:55:08.017089750 +0900
+++ generic/arch/mips/jazz/io.c	1970-01-01 09:00:00.000000000 +0900
@@ -1,135 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Low level I/O functions for Jazz family machines.
- *
- * Copyright (C) 1997 by Ralf Baechle.
- */
-#include <linux/string.h>
-#include <linux/spinlock.h>
-#include <asm/addrspace.h>
-#include <asm/system.h>
-#include <asm/jazz.h>
-
-/*
- * Map an 16mb segment of the EISA address space to 0xe3000000;
- */
-static inline void map_eisa_address(unsigned long address)
-{
-  /* XXX */
-  /* We've got an wired entry in the TLB.  We just need to modify it.
-     fast and clean.  But since we want to get rid of wired entries
-     things are a little bit more complicated ... */
-}
-
-static unsigned char jazz_readb(unsigned long addr)
-{
-	unsigned char res;
-
-	map_eisa_address(addr);
-	addr &= 0xffffff;
-	res = *(volatile unsigned char *) (JAZZ_EISA_BASE + addr);
-
-	return res;
-}
-
-static unsigned short jazz_readw(unsigned long addr)
-{
-	unsigned short res;
-
-	map_eisa_address(addr);
-	addr &= 0xffffff;
-	res = *(volatile unsigned char *) (JAZZ_EISA_BASE + addr);
-
-	return res;
-}
-
-static unsigned int jazz_readl(unsigned long addr)
-{
-	unsigned int res;
-
-	map_eisa_address(addr);
-	addr &= 0xffffff;
-	res = *(volatile unsigned char *) (JAZZ_EISA_BASE + addr);
-
-	return res;
-}
-
-static void jazz_writeb(unsigned char val, unsigned long addr)
-{
-	map_eisa_address(addr);
-	addr &= 0xffffff;
-	*(volatile unsigned char *) (JAZZ_EISA_BASE + addr) = val;
-}
-
-static void jazz_writew(unsigned short val, unsigned long addr)
-{
-	map_eisa_address(addr);
-	addr &= 0xffffff;
-	*(volatile unsigned char *) (JAZZ_EISA_BASE + addr) = val;
-}
-
-static void jazz_writel(unsigned int val, unsigned long addr)
-{
-	map_eisa_address(addr);
-	addr &= 0xffffff;
-	*(volatile unsigned char *) (JAZZ_EISA_BASE + addr) = val;
-}
-
-static void jazz_memset_io(unsigned long addr, int val, unsigned long len)
-{
-	unsigned long waddr;
-
-	waddr = JAZZ_EISA_BASE | (addr & 0xffffff);
-	while(len) {
-		unsigned long fraglen;
-
-		fraglen = (~addr + 1) & 0xffffff;
-		fraglen = (fraglen < len) ? fraglen : len;
-		map_eisa_address(addr);
-		memset((char *)waddr, val, fraglen);
-		addr += fraglen;
-		waddr = waddr + fraglen - 0x1000000;
-		len -= fraglen;
-	}
-}
-
-static void jazz_memcpy_fromio(unsigned long to, unsigned long from, unsigned long len)
-{
-	unsigned long waddr;
-
-	waddr = JAZZ_EISA_BASE | (from & 0xffffff);
-	while(len) {
-		unsigned long fraglen;
-
-		fraglen = (~from + 1) & 0xffffff;
-		fraglen = (fraglen < len) ? fraglen : len;
-		map_eisa_address(from);
-		memcpy((void *)to, (void *)waddr, fraglen);
-		to += fraglen;
-		from += fraglen;
-		waddr = waddr + fraglen - 0x1000000;
-		len -= fraglen;
-	}
-}
-
-static void jazz_memcpy_toio(unsigned long to, unsigned long from, unsigned long len)
-{
-	unsigned long waddr;
-
-	waddr = JAZZ_EISA_BASE | (to & 0xffffff);
-	while(len) {
-		unsigned long fraglen;
-
-		fraglen = (~to + 1) & 0xffffff;
-		fraglen = (fraglen < len) ? fraglen : len;
-		map_eisa_address(to);
-		memcpy((char *)to + JAZZ_EISA_BASE, (void *)from, fraglen);
-		to += fraglen;
-		from += fraglen;
-		waddr = waddr + fraglen - 0x1000000;
-		len -= fraglen;
-	}
-}
