Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Feb 2008 19:03:38 +0000 (GMT)
Received: from vms042pub.verizon.net ([206.46.252.42]:8130 "EHLO
	vms042pub.verizon.net") by ftp.linux-mips.org with ESMTP
	id S28576300AbYBHTDa (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 8 Feb 2008 19:03:30 +0000
Received: from wf-rch.minyard.local ([71.123.203.124])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0JVX00LZGOXHMWS4@vms042.mailsrvcs.net> for
 linux-mips@linux-mips.org; Fri, 08 Feb 2008 13:03:18 -0600 (CST)
Received: from i2 (i2.minyard.local [192.168.27.126])
	by wf-rch.minyard.local (Postfix) with ESMTP id CD2181F7E7	for
 <linux-mips@linux-mips.org>; Fri, 08 Feb 2008 13:03:16 -0600 (CST)
Date:	Fri, 08 Feb 2008 13:03:16 -0600
From:	Corey Minyard <minyard@acm.org>
Subject: [PATCH] MIPS: use thread flag to choose math emulator register mode
To:	linux-mips@linux-mips.org
Reply-to: minyard@acm.org
Message-id: <20080208190316.GA27730@minyard.local>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <minyard@acm.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18207
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: minyard@acm.org
Precedence: bulk
X-list: linux-mips

From: Corey Minyard <cminyard@mvista.com>

If a processor does not have floating point support, then the
cp0_status FR bit will always be set to 0 according to the MIPS
documents.  So using that to tell if the userland is in 32 or 64 bit
register mode on a 64-bit processor is kind of pointless.

Instead, use the thread flag that are designed for this purpose.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---

Index: linux-2.6.24/arch/mips/math-emu/cp1emu.c
===================================================================
--- linux-2.6.24.orig/arch/mips/math-emu/cp1emu.c
+++ linux-2.6.24/arch/mips/math-emu/cp1emu.c
@@ -178,18 +178,21 @@ static int isBranchInstr(mips_instructio
 #define FR_BIT 0
 #endif
 
+#define FR_64_BIT_SUPPORT (!test_thread_flag(TIF_32BIT_REGS))
+#define FR_32_BIT_REG_MASK (~(FR_64_BIT_SUPPORT == 0))
+
 #define SIFROMREG(si, x) ((si) = \
-			(xcp->cp0_status & FR_BIT) || !(x & 1) ? \
+			(FR_64_BIT_SUPPORT) || !(x & 1) ? \
 			(int)ctx->fpr[x] : \
 			(int)(ctx->fpr[x & ~1] >> 32 ))
-#define SITOREG(si, x)	(ctx->fpr[x & ~((xcp->cp0_status & FR_BIT) == 0)] = \
-			(xcp->cp0_status & FR_BIT) || !(x & 1) ? \
+#define SITOREG(si, x)	(ctx->fpr[x & FR_32_BIT_REG_MASK] = \
+			FR_64_BIT_SUPPORT || !(x & 1) ? \
 			ctx->fpr[x & ~1] >> 32 << 32 | (u32)(si) : \
 			ctx->fpr[x & ~1] << 32 >> 32 | (u64)(si) << 32)
 
 #define DIFROMREG(di, x) ((di) = \
-			ctx->fpr[x & ~((xcp->cp0_status & FR_BIT) == 0)])
-#define DITOREG(di, x)	(ctx->fpr[x & ~((xcp->cp0_status & FR_BIT) == 0)] \
+			ctx->fpr[x & FR_32_BIT_REG_MASK])
+#define DITOREG(di, x)	(ctx->fpr[x & FR_32_BIT_REG_MASK] \
 			= (di))
 
 #define SPFROMREG(sp, x) SIFROMREG((sp).bits, x)
