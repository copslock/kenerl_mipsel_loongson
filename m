Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jun 2017 01:16:38 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:49174 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994787AbdFOXQas6-Gr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jun 2017 01:16:30 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 64E18D66DEA3A;
        Fri, 16 Jun 2017 00:16:20 +0100 (IST)
Received: from [10.20.78.209] (10.20.78.209) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Fri, 16 Jun 2017
 00:16:23 +0100
Date:   Fri, 16 Jun 2017 00:16:15 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>, <linux-mips@linux-mips.org>
Subject: [PATCH v2 09/10] MIPS: math-emu: For MFHC1/MTHC1 also return SIGILL
 right away
In-Reply-To: <alpine.DEB.2.00.1706150032240.23046@tp.orcam.me.uk>
Message-ID: <alpine.DEB.2.00.1706150159470.23046@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1706150032240.23046@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.209]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58492
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
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

Update commit 1ac944007bed ("MIPS: math-emu: Add mfhc1 & mthc1 
support.") and like done throughout `cop1Emulate' for other cases also 
for the MFHC1 and MTHC1 instructions return SIGILL right away rather 
than jumping to a single `return' statement.

Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>
---
Unchanged from v1.

linux-mips-cp1emu-sigill.diff
Index: linux-sfr-test/arch/mips/math-emu/cp1emu.c
===================================================================
--- linux-sfr-test.orig/arch/mips/math-emu/cp1emu.c	2017-06-05 05:11:05.344496000 +0100
+++ linux-sfr-test/arch/mips/math-emu/cp1emu.c	2017-06-05 05:22:21.552958000 +0100
@@ -1142,7 +1142,7 @@ static int cop1Emulate(struct pt_regs *x
 
 		case mfhc_op:
 			if (!cpu_has_mips_r2_r6)
-				goto sigill;
+				return SIGILL;
 
 			/* copregister rd -> gpr[rt] */
 			if (MIPSInst_RT(ir) != 0) {
@@ -1153,7 +1153,7 @@ static int cop1Emulate(struct pt_regs *x
 
 		case mthc_op:
 			if (!cpu_has_mips_r2_r6)
-				goto sigill;
+				return SIGILL;
 
 			/* copregister rd <- gpr[rt] */
 			SITOHREG(xcp->regs[MIPSInst_RT(ir)], MIPSInst_RD(ir));
@@ -1376,7 +1376,6 @@ static int cop1Emulate(struct pt_regs *x
 				xcp->regs[MIPSInst_RS(ir)];
 		break;
 	default:
-sigill:
 		return SIGILL;
 	}
 
