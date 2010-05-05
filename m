Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 May 2010 06:02:33 +0200 (CEST)
Received: from mail-iw0-f177.google.com ([209.85.223.177]:56335 "EHLO
        mail-iw0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491047Ab0EEEC1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 May 2010 06:02:27 +0200
Received: by iwn7 with SMTP id 7so5636791iwn.24
        for <multiple recipients>; Tue, 04 May 2010 21:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:to:subject
         :message-id:from:date;
        bh=/HktCbY8dS3hwuiuuFyaSgj9T2ZbceAXK6QENjaVjaM=;
        b=EZgDyId6QiuCkIlgzJTMkmh6A1Y7WX4xLO7BAgXEMPt1ZDGX6Lgorh/obG1JhOG/2M
         ogapWvHpObSKO+For0F2Rd94nB4ummjZLeXNZK1aUMXv6r8/TeeSGETkccMO0Qfh+Tes
         814WOHrqolisuRf7JmJL1QjROfTi2Uzp7q7Ms=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:subject:message-id:from:date;
        b=fmENg3NU8ZBOwRdJlRd5d7O/d65RlofMF97H4mEacg+b0jUjK5xAiMDmU0QDSZ3JSw
         He2ECEY48Aecoo6QwstZO5cU864tLRy6F/98HbtcY40a2e6alAs507OyJCw7OAPNXeHo
         6GKteJqXbZ8fQRVfTZrbpNcZTFkl2PHFyXNDo=
Received: by 10.231.166.8 with SMTP id k8mr1497435iby.93.1273032141416;
        Tue, 04 May 2010 21:02:21 -0700 (PDT)
Received: from localhost ([207.47.250.203])
        by mx.google.com with ESMTPS id 21sm5846176iwn.15.2010.05.04.21.02.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 04 May 2010 21:02:20 -0700 (PDT)
Received: from shane by localhost with local (Exim 4.69)
        (envelope-from <shane@localhost>)
        id 1O9VoP-0001Zl-Qw; Tue, 04 May 2010 22:02:17 -0600
To:     kevink@paralogos.com, linux-mips@linux-mips.org,
        ralf@linux-mips.org
Subject: [MIPS] FPU emulator: allow Cause bits of FCSR to be writeable by ctc1
Message-Id: <E1O9VoP-0001Zl-Qw@localhost>
From:   Shane McDonald <mcdonald.shane@gmail.com>
Date:   Tue, 04 May 2010 22:02:17 -0600
Return-Path: <mcdonald.shane@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26590
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
 arch/mips/math-emu/cp1emu.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index 8f2f8e9..c756fd9 100644
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
+				ctx->fcr31 = (value & ~0x1c0003) |
+						ieee_rm[value & 0x3];
 			}
 			if ((ctx->fcr31 >> 5) & ctx->fcr31 & FPU_CSR_ALL_E) {
 				return SIGFPE;
-- 
1.6.2.4
