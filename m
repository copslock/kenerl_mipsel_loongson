Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 May 2010 08:02:30 +0200 (CEST)
Received: from mail-qy0-f185.google.com ([209.85.221.185]:60136 "EHLO
        mail-qy0-f185.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491180Ab0EGGCV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 May 2010 08:02:21 +0200
Received: by qyk15 with SMTP id 15so1273726qyk.6
        for <multiple recipients>; Thu, 06 May 2010 23:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:to:subject
         :message-id:from:date;
        bh=4yUHrJ8qt1aOug5UzP86hp3fQAQtNvj8K2lKNih/IxI=;
        b=EZFUKDVx6xbqJBGhlWfgGQwQ3iNLNVG8CwLJjIQlAjYzSaxI6ho3rMj4UXqsS4HNaM
         2E0JSpqj+7Z9G10bCpIhgaEf2PEg6ykjW3g8AfThcAoUY8udB2wFqZUPqMzdJ1KCmxVt
         CAvm6iTvE/Dl2aJBKtjyd+u+ffzosMGm59QJg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:subject:message-id:from:date;
        b=nkbvKOTn4R9aq2zgOIZXFcgp+0mSOHfvSbz1IUrqBcgxmHvJkS9KJ94G6ikOiU+tEm
         HtuwPW0UUD30DNvJV+4mGnbyp6/rtMV+xaFq+ifLVjsL0ao93IZaVQ6YL1iO8My81g7P
         hVXPEH5vVQNu1kai86aLtIci9sZ1EIs29GeGQ=
Received: by 10.224.27.1 with SMTP id g1mr4773496qac.212.1273212133385;
        Thu, 06 May 2010 23:02:13 -0700 (PDT)
Received: from localhost ([207.47.250.203])
        by mx.google.com with ESMTPS id 21sm1112829qyk.13.2010.05.06.23.02.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 06 May 2010 23:02:12 -0700 (PDT)
Received: from shane by localhost with local (Exim 4.69)
        (envelope-from <shane@localhost>)
        id 1OAGdV-0000MT-J5; Fri, 07 May 2010 00:02:09 -0600
To:     anemo@mba.ocn.ne.jp, kevink@paralogos.com,
        linux-mips@linux-mips.org, ralf@linux-mips.org,
        sshtylyov@mvista.com
Subject: [PATCH] MIPS: Coding style cleanups of access of FCSR rounding mode bits
Message-Id: <E1OAGdV-0000MT-J5@localhost>
From:   Shane McDonald <mcdonald.shane@gmail.com>
Date:   Fri, 07 May 2010 00:02:09 -0600
Return-Path: <mcdonald.shane@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26641
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mcdonald.shane@gmail.com
Precedence: bulk
X-list: linux-mips

This patch replaces references to the magic number 0x3 with
constants and macros indicating the real purpose of those bits.
They are the rounding mode bits of the FCSR register.

Signed-off-by: Shane McDonald <mcdonald.shane@gmail.com>
---
NOTE: This patch depends on the patch
"MIPS FPU emulator: allow Cause bits of FCSR to be writeable by ctc1"
having already been applied.

 arch/mips/math-emu/cp1emu.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index f2338d1..47842b7 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -354,7 +354,8 @@ static int cop1Emulate(struct pt_regs *xcp, struct mips_fpu_struct *ctx)
 
 			if (MIPSInst_RD(ir) == FPCREG_CSR) {
 				value = ctx->fcr31;
-				value = (value & ~0x3) | mips_rm[value & 0x3];
+				value = (value & ~FPU_CSR_RM) |
+					mips_rm[modeindex(value)];
 #ifdef CSRTRACE
 				printk("%p gpr[%d]<-csr=%08x\n",
 					(void *) (xcp->cp0_epc),
@@ -907,7 +908,7 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			ieee754sp fs;
 
 			SPFROMREG(fs, MIPSInst_FS(ir));
-			ieee754_csr.rm = ieee_rm[MIPSInst_FUNC(ir) & 0x3];
+			ieee754_csr.rm = ieee_rm[modeindex(MIPSInst_FUNC(ir))];
 			rv.w = ieee754sp_tint(fs);
 			ieee754_csr.rm = oldrm;
 			rfmt = w_fmt;
@@ -933,7 +934,7 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			ieee754sp fs;
 
 			SPFROMREG(fs, MIPSInst_FS(ir));
-			ieee754_csr.rm = ieee_rm[MIPSInst_FUNC(ir) & 0x3];
+			ieee754_csr.rm = ieee_rm[modeindex(MIPSInst_FUNC(ir))];
 			rv.l = ieee754sp_tlong(fs);
 			ieee754_csr.rm = oldrm;
 			rfmt = l_fmt;
@@ -1081,7 +1082,7 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			ieee754dp fs;
 
 			DPFROMREG(fs, MIPSInst_FS(ir));
-			ieee754_csr.rm = ieee_rm[MIPSInst_FUNC(ir) & 0x3];
+			ieee754_csr.rm = ieee_rm[modeindex(MIPSInst_FUNC(ir))];
 			rv.w = ieee754dp_tint(fs);
 			ieee754_csr.rm = oldrm;
 			rfmt = w_fmt;
@@ -1107,7 +1108,7 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			ieee754dp fs;
 
 			DPFROMREG(fs, MIPSInst_FS(ir));
-			ieee754_csr.rm = ieee_rm[MIPSInst_FUNC(ir) & 0x3];
+			ieee754_csr.rm = ieee_rm[modeindex(MIPSInst_FUNC(ir))];
 			rv.l = ieee754dp_tlong(fs);
 			ieee754_csr.rm = oldrm;
 			rfmt = l_fmt;
-- 
1.5.6.5
