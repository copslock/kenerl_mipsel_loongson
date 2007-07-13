Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jul 2007 15:01:40 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:25074 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20023629AbXGMOBi (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 13 Jul 2007 15:01:38 +0100
Received: from localhost (p3184-ipad31funabasi.chiba.ocn.ne.jp [221.189.127.184])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id F2EDBB5CC; Fri, 13 Jul 2007 23:01:33 +0900 (JST)
Date:	Fri, 13 Jul 2007 23:02:29 +0900 (JST)
Message-Id: <20070713.230229.93204964.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] math-emu minor cleanup
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15768
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Declaring emulpc and contpc as "unsigned long" can get rid of some
casts.  This also get rid of some sparse warnings.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/math-emu/cp1emu.c |   19 +++++++++----------
 1 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index d7f05b0..17419e1 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -205,7 +205,7 @@ static int isBranchInstr(mips_instruction * i)
 static int cop1Emulate(struct pt_regs *xcp, struct mips_fpu_struct *ctx)
 {
 	mips_instruction ir;
-	void * emulpc, *contpc;
+	unsigned long emulpc, contpc;
 	unsigned int cond;
 
 	if (get_user(ir, (mips_instruction __user *) xcp->cp0_epc)) {
@@ -230,7 +230,7 @@ static int cop1Emulate(struct pt_regs *xcp, struct mips_fpu_struct *ctx)
 		 * Linux MIPS branch emulator operates on context, updating the
 		 * cp0_epc.
 		 */
-		emulpc = (void *) (xcp->cp0_epc + 4);	/* Snapshot emulation target */
+		emulpc = xcp->cp0_epc + 4;	/* Snapshot emulation target */
 
 		if (__compute_return_epc(xcp)) {
 #ifdef CP1DBG
@@ -244,12 +244,12 @@ static int cop1Emulate(struct pt_regs *xcp, struct mips_fpu_struct *ctx)
 			return SIGBUS;
 		}
 		/* __compute_return_epc() will have updated cp0_epc */
-		contpc = (void *)  xcp->cp0_epc;
+		contpc = xcp->cp0_epc;
 		/* In order not to confuse ptrace() et al, tweak context */
-		xcp->cp0_epc = (unsigned long) emulpc - 4;
+		xcp->cp0_epc = emulpc - 4;
 	} else {
-		emulpc = (void *)  xcp->cp0_epc;
-		contpc = (void *) (xcp->cp0_epc + 4);
+		emulpc = xcp->cp0_epc;
+		contpc = xcp->cp0_epc + 4;
 	}
 
       emul:
@@ -427,8 +427,7 @@ static int cop1Emulate(struct pt_regs *xcp, struct mips_fpu_struct *ctx)
 				 * instruction
 				 */
 				xcp->cp0_epc += 4;
-				contpc = (void *)
-					(xcp->cp0_epc +
+				contpc = (xcp->cp0_epc +
 					(MIPSInst_SIMM(ir) << 2));
 
 				if (get_user(ir,
@@ -462,7 +461,7 @@ static int cop1Emulate(struct pt_regs *xcp, struct mips_fpu_struct *ctx)
 				 * Single step the non-cp1
 				 * instruction in the dslot
 				 */
-				return mips_dsemul(xcp, ir, (unsigned long) contpc);
+				return mips_dsemul(xcp, ir, contpc);
 			}
 			else {
 				/* branch not taken */
@@ -521,7 +520,7 @@ static int cop1Emulate(struct pt_regs *xcp, struct mips_fpu_struct *ctx)
 	}
 
 	/* we did it !! */
-	xcp->cp0_epc = (unsigned long) contpc;
+	xcp->cp0_epc = contpc;
 	xcp->cp0_cause &= ~CAUSEF_BD;
 
 	return 0;
