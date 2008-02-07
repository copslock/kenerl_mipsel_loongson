Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Feb 2008 12:43:01 +0000 (GMT)
Received: from mail1.pearl-online.net ([62.159.194.147]:44573 "EHLO
	mail1.pearl-online.net") by ftp.linux-mips.org with ESMTP
	id S20024640AbYBGMmw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 7 Feb 2008 12:42:52 +0000
Received: from SNaIlmail.Peter (85.233.39.216.static.cablesurf.de [85.233.39.216])
	by mail1.pearl-online.net (Postfix) with ESMTP id E9FE0B186;
	Thu,  7 Feb 2008 13:42:55 +0100 (CET)
Received: from Indigo2.Peter (Indigo2.Peter [192.168.1.28])
	by SNaIlmail.Peter (8.12.6/8.12.6/Sendmail/Linux 2.0.32) with ESMTP id m1621vZM000748;
	Wed, 6 Feb 2008 03:01:58 +0100
Received: from Indigo2.Peter (localhost [127.0.0.1])
	by Indigo2.Peter (8.12.6/8.12.6/Sendmail/Linux 2.6.14-rc2-ip28) with ESMTP id m17CfTb5000410;
	Thu, 7 Feb 2008 13:41:29 +0100
Received: from localhost (pf@localhost)
	by Indigo2.Peter (8.12.6/8.12.6/Submit) with ESMTP id m17CfTQw000407;
	Thu, 7 Feb 2008 13:41:29 +0100
X-Authentication-Warning: Indigo2.Peter: pf owned process doing -bs
Date:	Thu, 7 Feb 2008 13:41:29 +0100 (CET)
From:	peter fuerst <post@pfrst.de>
X-X-Sender: pf@Indigo2.Peter
Reply-To: post@pfrst.de
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: [PATCH] [MIPS]: fix CAC_ADDR/UNCAC_ADDR
In-Reply-To: <Pine.LNX.4.64.0801222042100.5722@fbirervta.pbzchgretzou.qr>
Message-ID: <Pine.LNX.4.58.0802071337440.402@Indigo2.Peter>
References: <54038cd4f87a03884e4f59f8f3697889dfb63c54.1201030614.git.jengelh@computergmbh.de>
 <Pine.LNX.4.64.0801222042100.5722@fbirervta.pbzchgretzou.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <post@pfrst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18187
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: post@pfrst.de
Precedence: bulk
X-list: linux-mips



With commit db38501511a7513ec4f0ae9922d847c135cf3c78 PAGE_OFFSET was
redefined as CAC_BASE+PHYS_OFFSET, but [UN]CAC_ADDR - which are used
in dma_alloc_coherent() and dma_free_coherent() respectively, and in
drivers/video/au1100fb.c - were not adjusted accordingly.

with kind regards


Signed-off-by: peter fuerst <post@pfrst.de>


--- a/linux-2.6.24/include/asm-mips/page.h	Fri Jan 25 12:23:51 2008
+++ b/linux-2.6.24/include/asm-mips/page.h	Wed Feb  6 23:26:31 2008
@@ -184,8 +184,8 @@
 #define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | VM_EXEC | \
 				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)

-#define UNCAC_ADDR(addr)	((addr) - PAGE_OFFSET + UNCAC_BASE)
-#define CAC_ADDR(addr)		((addr) - UNCAC_BASE + PAGE_OFFSET)
+#define UNCAC_ADDR(addr)	((addr) - PAGE_OFFSET + PHYS_OFFSET + UNCAC_BASE)
+#define CAC_ADDR(addr)		((addr) - UNCAC_BASE + PAGE_OFFSET - PHYS_OFFSET)

 #include <asm-generic/memory_model.h>
 #include <asm-generic/page.h>
