Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Apr 2016 15:07:02 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:43219 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27027257AbcDUNGad4gSj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 21 Apr 2016 15:06:30 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email with ESMTPS id AB9F3E9CAC4FF;
        Thu, 21 Apr 2016 14:06:18 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Thu, 21 Apr 2016 14:06:24 +0100
Received: from localhost (10.100.200.79) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Thu, 21 Apr
 2016 14:06:23 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        "Maciej W. Rozycki" <macro@imgtec.com>,
        <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 04/11] MIPS: math-emu: Emulate MIPSr6 sel.fmt instruction
Date:   Thu, 21 Apr 2016 14:04:48 +0100
Message-ID: <1461243895-30371-5-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1461243895-30371-1-git-send-email-paul.burton@imgtec.com>
References: <1461243895-30371-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.79]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53159
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Add support for emulating the MIPSr6 sel.fmt instruction, which was
previously missing from the FPU emulation code. This instruction selects
its result from 2 possible source registers, based upon bit 0 of the
destination register, and is valid only for S (single) & D (double) data
types.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/math-emu/cp1emu.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index 99977c3..85dd174 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -1675,7 +1675,7 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			union ieee754sp(*b) (union ieee754sp, union ieee754sp);
 			union ieee754sp(*u) (union ieee754sp);
 		} handler;
-		union ieee754sp fs, ft;
+		union ieee754sp fd, fs, ft;
 
 		switch (MIPSInst_FUNC(ir)) {
 			/* binary ops */
@@ -1946,6 +1946,17 @@ copcsr:
 			rfmt = w_fmt;
 			goto copcsr;
 
+		case fsel_op:
+			if (!cpu_has_mips_r6)
+				return SIGILL;
+
+			SPFROMREG(fd, MIPSInst_FD(ir));
+			if (fd.bits & 0x1)
+				SPFROMREG(rv.s, MIPSInst_FT(ir));
+			else
+				SPFROMREG(rv.s, MIPSInst_FS(ir));
+			break;
+
 		case fcvtl_op:
 			if (!cpu_has_mips_3_4_5_64_r2_r6)
 				return SIGILL;
@@ -1994,7 +2005,7 @@ copcsr:
 	}
 
 	case d_fmt: {
-		union ieee754dp fs, ft;
+		union ieee754dp fd, fs, ft;
 		union {
 			union ieee754dp(*b) (union ieee754dp, union ieee754dp);
 			union ieee754dp(*u) (union ieee754dp);
@@ -2244,6 +2255,17 @@ dcopuop:
 			rfmt = w_fmt;
 			goto copcsr;
 
+		case fsel_op:
+			if (!cpu_has_mips_r6)
+				return SIGILL;
+
+			DPFROMREG(fd, MIPSInst_FD(ir));
+			if (fd.bits & 0x1)
+				DPFROMREG(rv.d, MIPSInst_FT(ir));
+			else
+				DPFROMREG(rv.d, MIPSInst_FS(ir));
+			break;
+
 		case fcvtl_op:
 			if (!cpu_has_mips_3_4_5_64_r2_r6)
 				return SIGILL;
-- 
2.8.0
