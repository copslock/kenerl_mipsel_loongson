Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 May 2010 07:27:14 +0200 (CEST)
Received: from mail-qy0-f185.google.com ([209.85.221.185]:36875 "EHLO
        mail-qy0-f185.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491796Ab0EGF1I (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 May 2010 07:27:08 +0200
Received: by qyk15 with SMTP id 15so1237405qyk.6
        for <multiple recipients>; Thu, 06 May 2010 22:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:to:subject
         :message-id:from:date;
        bh=3eXmyP0SgS1K6rVvuYozbjW+eftctR1O3ihIpcXaPHQ=;
        b=HbtZb7ffbE9NWd2vcRBZVcn/DzmWgobAChHHr+YO/CeBUIltZXynISrhZDxkAWXgod
         rYIM/pkEQ2qxqGC4xguncmoCVxf9FZG5rlybVMyp2sPsXRAXuooX8vnYQoQLVEEMoGPA
         aGOdekjlU01AG/qg75f9V8Ba2ITedV7W9WQGk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:subject:message-id:from:date;
        b=o8b29hnkZzlT2F7JfkWGtWExK6M7v9bicgvHb2bdzTS4ZPyYHa9mlpu6U4nv+7NFwm
         jR5cOuxBuH0y1mWqry0Z5VEHLCgK46MbddJrDkwDU9bS5HtNYwT2yhPFYFD9XbIFtLPz
         GANIJs/C1b9LonFW2DDUw7w2ast1/a7FlqOrM=
Received: by 10.224.24.203 with SMTP id w11mr9104472qab.296.1273210021455;
        Thu, 06 May 2010 22:27:01 -0700 (PDT)
Received: from localhost ([207.47.250.203])
        by mx.google.com with ESMTPS id 22sm1106418qyk.6.2010.05.06.22.26.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 06 May 2010 22:27:00 -0700 (PDT)
Received: from shane by localhost with local (Exim 4.69)
        (envelope-from <shane@localhost>)
        id 1OAG5R-0003hc-AY; Thu, 06 May 2010 23:26:57 -0600
To:     anemo@mba.ocn.ne.jp, kevink@paralogos.com,
        linux-mips@linux-mips.org, ralf@linux-mips.org,
        sshtylyov@mvista.com
Subject: [PATCH v3] MIPS FPU emulator: allow Cause bits of FCSR to be writeable by ctc1
Message-Id: <E1OAG5R-0003hc-AY@localhost>
From:   Shane McDonald <mcdonald.shane@gmail.com>
Date:   Thu, 06 May 2010 23:26:57 -0600
Return-Path: <mcdonald.shane@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26640
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mcdonald.shane@gmail.com
Precedence: bulk
X-list: linux-mips

In the FPU emulator code of the MIPS, the Cause bits of the FCSR
register are not currently writeable by the ctc1 instruction.
In odd corner cases, this can cause problems.  For example,
a case existed where a divide-by-zero exception was generated
by the FPU, and the signal handler attempted to restore the FPU
registers to their state before the exception occurred.  In this
particular setup, writing the old value to the FCSR register
would cause another divide-by-zero exception to occur immediately.
The solution is to change the ctc1 instruction emulator code to
allow the Cause bits of the FCSR register to be writeable.
This is the behaviour of the hardware that the code is emulating.

This problem was found by Shane McDonald, but the credit for the
fix goes to Kevin Kissell.  In Kevin's words:

I submit that the bug is indeed in that ctc_op:  case of the emulator.  The
Cause bits (17:12) are supposed to be writable by that instruction, but the
CTC1 emulation won't let them be updated by the instruction.  I think that
actually if you just completely removed lines 387-388 [...]
things would work a good deal better.  At least, it would be a more accurate
emulation of the architecturally defined FPU.  If I wanted to be really,
really pedantic (which I sometimes do), I'd also protect the reserved bits
that aren't necessarily writable.

Signed-off-by: Shane McDonald <mcdonald.shane@gmail.com>
---
v3: More coding style cleanups, and removed the 0x3 constant, replacing
it with FPU_CSR_RM and modeindex().

v2: Replaced an ugly magic number with a constant for the reserved
bits of the FPU CSR.

 arch/mips/include/asm/mipsregs.h |    9 ++++++++-
 arch/mips/math-emu/cp1emu.c      |   15 +++++++++++----
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 49382d5..c6e3c93 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -135,6 +135,12 @@
 #define FPU_CSR_COND7   0x80000000      /* $fcc7 */
 
 /*
+ * Bits 18 - 20 of the FPU Status Register will be read as 0,
+ * and should be written as zero.
+ */
+#define FPU_CSR_RSVD	0x001c0000
+
+/*
  * X the exception cause indicator
  * E the exception enable
  * S the sticky/flag bit
@@ -161,7 +167,8 @@
 #define FPU_CSR_UDF_S   0x00000008
 #define FPU_CSR_INE_S   0x00000004
 
-/* rounding mode */
+/* Bits 0 and 1 of FPU Status Register specify the rounding mode */
+#define FPU_CSR_RM	0x00000003
 #define FPU_CSR_RN      0x0     /* nearest */
 #define FPU_CSR_RZ      0x1     /* towards zero */
 #define FPU_CSR_RU      0x2     /* towards +Infinity */
diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index 8f2f8e9..f2338d1 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -78,6 +78,9 @@ DEFINE_PER_CPU(struct mips_fpu_emulator_stats, fpuemustats);
 #define FPCREG_RID	0	/* $0  = revision id */
 #define FPCREG_CSR	31	/* $31 = csr */
 
+/* Determine rounding mode from the RM bits of the FCSR */
+#define modeindex(v) ((v) & FPU_CSR_RM)
+
 /* Convert Mips rounding mode (0..3) to IEEE library modes. */
 static const unsigned char ieee_rm[4] = {
 	[FPU_CSR_RN] = IEEE754_RN,
@@ -384,10 +387,14 @@ static int cop1Emulate(struct pt_regs *xcp, struct mips_fpu_struct *ctx)
 					(void *) (xcp->cp0_epc),
 					MIPSInst_RT(ir), value);
 #endif
-				value &= (FPU_CSR_FLUSH | FPU_CSR_ALL_E | FPU_CSR_ALL_S | 0x03);
-				ctx->fcr31 &= ~(FPU_CSR_FLUSH | FPU_CSR_ALL_E | FPU_CSR_ALL_S | 0x03);
-				/* convert to ieee library modes */
-				ctx->fcr31 |= (value & ~0x3) | ieee_rm[value & 0x3];
+
+				/*
+				 * Don't write reserved bits,
+				 * and convert to ieee library modes
+				 */
+				ctx->fcr31 = (value &
+						~(FPU_CSR_RSVD | FPU_CSR_RM)) |
+						ieee_rm[modeindex(value)];
 			}
 			if ((ctx->fcr31 >> 5) & ctx->fcr31 & FPU_CSR_ALL_E) {
 				return SIGFPE;
-- 
1.6.2.4
