Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jan 2016 06:21:29 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:20440 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008530AbcAVFUxMM0Rz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Jan 2016 06:20:53 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id B9A1F30CBB615;
        Fri, 22 Jan 2016 05:20:46 +0000 (GMT)
Received: from [10.100.200.15] (10.100.200.15) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.235.1; Fri, 22 Jan 2016
 05:20:47 +0000
Date:   Fri, 22 Jan 2016 05:21:13 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Aurelien Jarno <aurelien@aurel32.net>, <linux-mips@linux-mips.org>
Subject: [PATCH 5/7] MIPS: math-emu: dsemul: Correct description of the
 emulation frame
In-Reply-To: <alpine.DEB.2.00.1601220227590.5958@tp.orcam.me.uk>
Message-ID: <alpine.DEB.2.00.1601220254370.5958@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1601220227590.5958@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.100.200.15]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51296
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

Remove irrelevant content from the description of the emulation frame in 
`mips_dsemul', referring to bare-metal configurations.  Update the text,
reflecting the change made with commit ba3049ed4086 ("MIPS: Switch FPU 
emulator trap to BREAK instruction."), where we switched from using an 
address error exception on an unaligned access to the use of a BREAK 514 
instruction causing a breakpoint exception instead.

Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>
---
linux-mips-dsemul-comment.diff
Index: linux-sfr-sead/arch/mips/math-emu/dsemul.c
===================================================================
--- linux-sfr-sead.orig/arch/mips/math-emu/dsemul.c	2016-01-22 01:10:10.476810000 +0000
+++ linux-sfr-sead/arch/mips/math-emu/dsemul.c	2016-01-22 01:10:44.420413000 +0000
@@ -78,13 +78,8 @@ int mips_dsemul(struct pt_regs *regs, mi
 	 * Algorithmics used a system call instruction, and
 	 * borrowed that vector.  MIPS/Linux version is a bit
 	 * more heavyweight in the interests of portability and
-	 * multiprocessor support.  For Linux we generate a
-	 * an unaligned access and force an address error exception.
-	 *
-	 * For embedded systems (stand-alone) we prefer to use a
-	 * non-existing CP1 instruction. This prevents us from emulating
-	 * branches, but gives us a cleaner interface to the exception
-	 * handler (single entry point).
+	 * multiprocessor support.  For Linux we use a BREAK 514
+	 * instruction causing a breakpoint exception.
 	 */
 	break_math = BREAK_MATH(get_isa16_mode(regs->cp0_epc));
 
