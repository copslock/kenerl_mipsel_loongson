Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Jan 2016 10:09:51 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:61406 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008725AbcA3JJtPsPLN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 30 Jan 2016 10:09:49 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id 086563100CB9F;
        Sat, 30 Jan 2016 09:09:42 +0000 (GMT)
Received: from [10.100.200.149] (10.100.200.149) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.235.1; Sat, 30 Jan 2016
 09:09:42 +0000
Date:   Sat, 30 Jan 2016 09:09:43 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>
Subject: [PATCH] MIPS: math-emu: dsemul: Remove an unused bit in ADDIUPC
 emulation
Message-ID: <alpine.DEB.2.00.1601300820430.5958@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.100.200.149]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51548
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

Avoid a reader's confusion, as the calculation is correct either way.

Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>
---
linux-umips-dsemul-addiupc-nit.diff
Index: linux-sfr-test/arch/mips/math-emu/dsemul.c
===================================================================
--- linux-sfr-test.orig/arch/mips/math-emu/dsemul.c	2016-01-29 14:11:03.000000000 +0000
+++ linux-sfr-test/arch/mips/math-emu/dsemul.c	2016-01-29 14:13:53.613960000 +0000
@@ -60,7 +60,7 @@ int mips_dsemul(struct pt_regs *regs, mi
 			unsigned int rs;
 			s32 v;
 
-			rs = (((insn.mm_a_format.rs + 0x1e) & 0xf) + 2);
+			rs = (((insn.mm_a_format.rs + 0xe) & 0xf) + 2);
 			v = regs->cp0_epc & ~3;
 			v += insn.mm_a_format.simmediate << 2;
 			regs->regs[rs] = (long)v;
