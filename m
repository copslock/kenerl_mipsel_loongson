Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Nov 2009 20:34:13 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:2949 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493937AbZKBTeG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 2 Nov 2009 20:34:06 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,5,4,7535)
	id <B4aef341f0000>; Mon, 02 Nov 2009 11:33:51 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 2 Nov 2009 11:33:52 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 2 Nov 2009 11:33:52 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id nA2JXlaR029372;
	Mon, 2 Nov 2009 11:33:48 -0800
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id nA2JXkcX029370;
	Mon, 2 Nov 2009 11:33:46 -0800
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Emulate 64-bit FPU on 64-bit CPUs.
Date:	Mon,  2 Nov 2009 11:33:46 -0800
Message-Id: <1257190426-29346-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
X-OriginalArrivalTime: 02 Nov 2009 19:33:52.0620 (UTC) FILETIME=[68C1EAC0:01CA5BF3]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24618
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Running a 64-bit kernel on a 64-bit CPU without an FPU would cause the
emulator to run in 32-bit mode.  The c0_Status.FR bit is wired to zero
on systems without an FPU, so using that bit to decide how the
emulator behaves doesn't allow for proper emulation on 64-bit FPU-less
processors.

Instead, we need to select the emulator mode based on the user-space
ABI.  Since the thread flag TIF_32BIT_REGS is used to set
c0_Status.FR, we can just use it to decide if the emulator should be
in 32-bit or 64-bit mode.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/math-emu/cp1emu.c |   41 +++++++++++++++++++++--------------------
 1 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index 890f779..454b539 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -163,33 +163,34 @@ static int isBranchInstr(mips_instruction * i)
 
 /*
  * In the Linux kernel, we support selection of FPR format on the
- * basis of the Status.FR bit.  This does imply that, if a full 32
- * FPRs are desired, there needs to be a flip-flop that can be written
- * to one at that bit position.  In any case, O32 MIPS ABI uses
- * only the even FPRs (Status.FR = 0).
+ * basis of the Status.FR bit.  If an FPU is not present, the FR bit
+ * is hardwired to zero, which would imply a 32-bit FPU even for
+ * 64-bit CPUs.  For 64-bit kernels with no FPU we use TIF_32BIT_REGS
+ * as a proxy for the FR bit so that a 64-bit FPU is emulated.  In any
+ * case, for a 32-bit kernel which uses the O32 MIPS ABI, only the
+ * even FPRs are used (Status.FR = 0).
  */
-
-#define CP0_STATUS_FR_SUPPORT
-
-#ifdef CP0_STATUS_FR_SUPPORT
-#define FR_BIT ST0_FR
+static inline int cop1_64bit(struct pt_regs *xcp)
+{
+	if (cpu_has_fpu)
+		return xcp->cp0_status & ST0_FR;
+#ifdef CONFIG_64BIT
+	return !test_thread_flag(TIF_32BIT_REGS);
 #else
-#define FR_BIT 0
+	return 0;
 #endif
+}
+
+#define SIFROMREG(si, x) ((si) = cop1_64bit(xcp) || !(x & 1) ? \
+			(int)ctx->fpr[x] : (int)(ctx->fpr[x & ~1] >> 32))
 
-#define SIFROMREG(si, x) ((si) = \
-			(xcp->cp0_status & FR_BIT) || !(x & 1) ? \
-			(int)ctx->fpr[x] : \
-			(int)(ctx->fpr[x & ~1] >> 32 ))
-#define SITOREG(si, x)	(ctx->fpr[x & ~((xcp->cp0_status & FR_BIT) == 0)] = \
-			(xcp->cp0_status & FR_BIT) || !(x & 1) ? \
+#define SITOREG(si, x)	(ctx->fpr[x & ~(cop1_64bit(xcp) == 0)] = \
+			cop1_64bit(xcp) || !(x & 1) ? \
 			ctx->fpr[x & ~1] >> 32 << 32 | (u32)(si) : \
 			ctx->fpr[x & ~1] << 32 >> 32 | (u64)(si) << 32)
 
-#define DIFROMREG(di, x) ((di) = \
-			ctx->fpr[x & ~((xcp->cp0_status & FR_BIT) == 0)])
-#define DITOREG(di, x)	(ctx->fpr[x & ~((xcp->cp0_status & FR_BIT) == 0)] \
-			= (di))
+#define DIFROMREG(di, x) ((di) = ctx->fpr[x & ~(cop1_64bit(xcp) == 0)])
+#define DITOREG(di, x)	(ctx->fpr[x & ~(cop1_64bit(xcp) == 0)] = (di))
 
 #define SPFROMREG(sp, x) SIFROMREG((sp).bits, x)
 #define SPTOREG(sp, x)	SITOREG((sp).bits, x)
-- 
1.6.0.6
