Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Apr 2003 13:30:03 +0100 (BST)
Received: from pasmtp.tele.dk ([IPv6:::ffff:193.162.159.95]:62735 "EHLO
	pasmtp.tele.dk") by linux-mips.org with ESMTP id <S8225073AbTDAMaB>;
	Tue, 1 Apr 2003 13:30:01 +0100
Received: from ekner.info (0x83a4a968.virnxx10.adsl-dhcp.tele.dk [131.164.169.104])
	by pasmtp.tele.dk (Postfix) with ESMTP id 79481B525
	for <linux-mips@linux-mips.org>; Tue,  1 Apr 2003 14:29:59 +0200 (CEST)
Message-ID: <3E898800.450410D3@ekner.info>
Date: Tue, 01 Apr 2003 14:37:20 +0200
From: Hartvig Ekner <hartvig@ekner.info>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-19.7.x i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux MIPS mailing list <linux-mips@linux-mips.org>
Subject: Patch to make c-mips32.c compile when HW coherency is used
Content-Type: multipart/mixed;
 boundary="------------C0EFCCF38DBD9B15F6A87F17"
Return-Path: <hartvig@ekner.info>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1887
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hartvig@ekner.info
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------C0EFCCF38DBD9B15F6A87F17
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

The patch totally removes the dma_cache functions and the function pointers when the kernel is
compiled for HW coherency. Previously it didn't compile at all since the function pointers are non-
existant in this case.

The same problem exists in all the other c-*.c files in arch/mips/mm, so maybe there is something
which I don't understand?

/Hartvig



--------------C0EFCCF38DBD9B15F6A87F17
Content-Type: text/plain; charset=us-ascii;
 name="noncoh_patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="noncoh_patch"

Index: c-mips32.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/mm/c-mips32.c,v
retrieving revision 1.3.2.17
diff -u -r1.3.2.17 c-mips32.c
--- c-mips32.c	31 Mar 2003 23:29:06 -0000	1.3.2.17
+++ c-mips32.c	1 Apr 2003 12:17:14 -0000
@@ -293,6 +293,9 @@
 /*
  * Writeback and invalidate the primary cache dcache before DMA.
  */
+
+#ifdef	CONFIG_NONCOHERENT_IO
+
 static void
 mips32_dma_cache_wback_inv_pc(unsigned long addr, unsigned long size)
 {
@@ -379,9 +382,12 @@
 static void
 mips32_dma_cache_wback(unsigned long addr, unsigned long size)
 {
-	panic("mips32_dma_cache called - should not happen.");
+	panic("mips32_dma_cache_wback called - should not happen.");
 }
 
+#endif
+
+
 /*
  * While we're protected against bad userland addresses we don't care
  * very much about what happens in that case.  Usually a segmentation
@@ -596,9 +602,11 @@
 
 	_flush_icache_page = mips32_flush_icache_page;
 
+#ifdef	CONFIG_NONCOHERENT_IO
 	_dma_cache_wback_inv = mips32_dma_cache_wback_inv_pc;
 	_dma_cache_wback = mips32_dma_cache_wback;
 	_dma_cache_inv = mips32_dma_cache_inv_pc;
+#endif
 }
 
 static void __init setup_scache_funcs(void)
@@ -613,9 +621,11 @@
 
 	_flush_icache_page = mips32_flush_icache_page_s;
 
+#ifdef	CONFIG_NONCOHERENT_IO
 	_dma_cache_wback_inv = mips32_dma_cache_wback_inv_sc;
 	_dma_cache_wback = mips32_dma_cache_wback;
 	_dma_cache_inv = mips32_dma_cache_inv_sc;
+#endif
 }
 
 typedef int (*probe_func_t)(unsigned long);

--------------C0EFCCF38DBD9B15F6A87F17--
