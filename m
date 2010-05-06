Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 May 2010 07:45:29 +0200 (CEST)
Received: from mail-qy0-f172.google.com ([209.85.221.172]:65365 "EHLO
        mail-qy0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491889Ab0EFFpV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 May 2010 07:45:21 +0200
Received: by qyk2 with SMTP id 2so8996977qyk.20
        for <multiple recipients>; Wed, 05 May 2010 22:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:to:subject
         :message-id:from:date;
        bh=d/qfyxPFJrNIOyrMe1AYnthUaHC3k3FDB4DTBlw8p7g=;
        b=sEm87r9dQaB9pzD4NB3pUcL8u3Giw5wDFbJB4s2kk0q4+sUDIWKWNcDLII7lzKPEWR
         Luc9ZkQYnaaN5yM3KOboomsug7EZlLuMMsWpQEbPsBJdkKqE66ME080wh28Ym9DEvRHG
         KBmkLJejhApUbJK94ZSeWax10NQxxr450V5rI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:subject:message-id:from:date;
        b=Bo3JYZZ/ggi9zT+mGnUvvUJsfw+WCR2p847gRFkZEge9GcBkaIGZWJNe+oB1p3sJSV
         n0oagfPQjFqDi8zAygWRq8CKMA9NmrRChRPgaRvngBq9xfheKCaOdRj40bNOJULZ1esV
         SV8BeA7GukoWRCGz+F8zgW69RcLy1XBcqQTvE=
Received: by 10.224.79.92 with SMTP id o28mr6405409qak.2.1273124714872;
        Wed, 05 May 2010 22:45:14 -0700 (PDT)
Received: from localhost ([207.47.250.203])
        by mx.google.com with ESMTPS id 22sm400517qyk.10.2010.05.05.22.45.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 05 May 2010 22:45:14 -0700 (PDT)
Received: from shane by localhost with local (Exim 4.69)
        (envelope-from <shane@localhost>)
        id 1O9ttX-0002M5-Ku; Wed, 05 May 2010 23:45:11 -0600
To:     anemo@mba.ocn.ne.jp, kevink@paralogos.com,
        linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: [PATCH v2] MIPS FPU emulator: allow Cause bits of FCSR to be writeable by ctc1
Message-Id: <E1O9ttX-0002M5-Ku@localhost>
From:   Shane McDonald <mcdonald.shane@gmail.com>
Date:   Wed, 05 May 2010 23:45:11 -0600
Return-Path: <mcdonald.shane@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26615
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
v2: Replaced an ugly magic number with a constant for the reserved
bits of the FPU CSR.

 arch/mips/include/asm/mipsregs.h |    6 ++++++
 arch/mips/math-emu/cp1emu.c      |    9 +++++----
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 49382d5..1b17a21 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -135,6 +135,12 @@
 #define FPU_CSR_COND7   0x80000000      /* $fcc7 */
 
 /*
+ * Bits 18 - 20 of the FPU Status Register will be read as 0,
+ * and should be written as zero.
+*/
+#define FPU_CSR_RSVD	0x001c0000
+
+/*
  * X the exception cause indicator
  * E the exception enable
  * S the sticky/flag bit
diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index 8f2f8e9..ebecec6 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -384,10 +384,11 @@ static int cop1Emulate(struct pt_regs *xcp, struct mips_fpu_struct *ctx)
 					(void *) (xcp->cp0_epc),
 					MIPSInst_RT(ir), value);
 #endif
-				value &= (FPU_CSR_FLUSH | FPU_CSR_ALL_E | FPU_CSR_ALL_S | 0x03);
-				ctx->fcr31 &= ~(FPU_CSR_FLUSH | FPU_CSR_ALL_E | FPU_CSR_ALL_S | 0x03);
-				/* convert to ieee library modes */
-				ctx->fcr31 |= (value & ~0x3) | ieee_rm[value & 0x3];
+
+				/* Don't write reserved bits,
+				   and convert to ieee library modes */
+				ctx->fcr31 = (value & ~(FPU_CSR_RSVD | 0x3)) |
+						ieee_rm[value & 0x3];
 			}
 			if ((ctx->fcr31 >> 5) & ctx->fcr31 & FPU_CSR_ALL_E) {
 				return SIGFPE;
-- 
1.6.2.4
