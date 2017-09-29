Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Sep 2017 17:27:00 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:16969 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992364AbdI2P0wXzfsi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 Sep 2017 17:26:52 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id AF35B27A6023;
        Fri, 29 Sep 2017 16:26:41 +0100 (IST)
Received: from [10.20.78.110] (10.20.78.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.361.1; Fri, 29 Sep 2017
 16:26:44 +0100
Date:   Fri, 29 Sep 2017 16:26:31 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>
CC:     <linux-mips@linux-mips.org>
Subject: [PATCH] MIPS: Use SLL by 0 for 32-bit truncation in
 `__read_64bit_c0_split'
Message-ID: <alpine.DEB.2.00.1709291502060.12020@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.110]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60199
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

Optimize `__read_64bit_c0_split' and reduce the instruction count by 1, 
observing that a DSLL/DSRA pair by 32, is equivalent to SLL by 0, which 
architecturally truncates the value requested to 32 bits on 64-bit MIPS 
hardware regardless of whether the input operand is or is not a properly 
sign-extended 32-bit value.

Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>
---
 Tested by compilation only to verify syntax correctnes as I do not know 
if this execution path is actually used by any configuration (suggestions 
welcome).  I believe it to be technically correct though, being 
sufficiently straightforward to verify by proofreading, and an obvious 
improvement.

 Therefore, please apply.

 NB if this turns out indeed used, then we might have to do something 
about DMFC0 hazard avoidance for the sake of MIPS III support, and also
choose to use an MFC0/MFHC0 instruction pair instead on MIPS64r5+.

  Maciej

---
 arch/mips/include/asm/mipsregs.h |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

linux-mips-read-64bit-c0-split-sll.diff
Index: linux-sfr-test/arch/mips/include/asm/mipsregs.h
===================================================================
--- linux-sfr-test.orig/arch/mips/include/asm/mipsregs.h	2017-07-08 15:32:02.000000000 +0100
+++ linux-sfr-test/arch/mips/include/asm/mipsregs.h	2017-09-29 01:02:01.390974000 +0100
@@ -1344,19 +1344,17 @@ do {									\
 	if (sel == 0)							\
 		__asm__ __volatile__(					\
 			".set\tmips64\n\t"				\
-			"dmfc0\t%M0, " #source "\n\t"			\
-			"dsll\t%L0, %M0, 32\n\t"			\
-			"dsra\t%M0, %M0, 32\n\t"			\
-			"dsra\t%L0, %L0, 32\n\t"			\
+			"dmfc0\t%L0, " #source "\n\t"			\
+			"dsra\t%M0, %L0, 32\n\t"			\
+			"sll\t%L0, %L0, 0\n\t"				\
 			".set\tmips0"					\
 			: "=r" (__val));				\
 	else								\
 		__asm__ __volatile__(					\
 			".set\tmips64\n\t"				\
-			"dmfc0\t%M0, " #source ", " #sel "\n\t"		\
-			"dsll\t%L0, %M0, 32\n\t"			\
-			"dsra\t%M0, %M0, 32\n\t"			\
-			"dsra\t%L0, %L0, 32\n\t"			\
+			"dmfc0\t%L0, " #source ", " #sel "\n\t"		\
+			"dsra\t%M0, %L0, 32\n\t"			\
+			"sll\t%L0, %L0, 0\n\t"				\
 			".set\tmips0"					\
 			: "=r" (__val));				\
 	local_irq_restore(__flags);					\
