Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 Nov 2014 23:09:46 +0100 (CET)
Received: from relay1.mentorg.com ([192.94.38.131]:54535 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013682AbaKOWJoc7IZP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 15 Nov 2014 23:09:44 +0100
Received: from nat-ies.mentorg.com ([192.94.31.2] helo=SVR-IES-FEM-01.mgc.mentorg.com)
        by relay1.mentorg.com with esmtp 
        id 1XplXD-00045X-L2 from Maciej_Rozycki@mentor.com ; Sat, 15 Nov 2014 14:09:36 -0800
Received: from localhost (137.202.0.76) by SVR-IES-FEM-01.mgc.mentorg.com
 (137.202.0.104) with Microsoft SMTP Server (TLS) id 14.3.181.6; Sat, 15 Nov
 2014 22:09:34 +0000
Date:   Sat, 15 Nov 2014 22:09:31 +0000
From:   "Maciej W. Rozycki" <macro@codesourcery.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>
Subject: [PATCH 6/7] MIPS: Apply `.insn' to fixup labels throughout
In-Reply-To: <alpine.DEB.1.10.1411140122420.2881@tp.orcam.me.uk>
Message-ID: <alpine.DEB.1.10.1411152139430.2881@tp.orcam.me.uk>
References: <alpine.DEB.1.10.1411140122420.2881@tp.orcam.me.uk>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-Path: <Maciej_Rozycki@mentor.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44189
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@codesourcery.com
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

Fix the issue with the ISA bit being lost in fixups that jump to labels 
placed just before a section switch.  Such a switch leads to the ISA bit 
being lost, because GAS concludes there is no code that follows and 
therefore the label refers to data.  Use the `.insn' pseudo-op to 
convince the tool this is not the case.

This lack of label annotation leads to microMIPS compilation errors 
like:

mips-linux-gnu-ld: arch/mips/built-in.o: .fixup+0x3b8: Unsupported jump between ISA modes; consider recompiling with interlinking enabled.
mips-linux-gnu-ld: final link failed: Bad value

Signed-off-by: Maciej W. Rozycki <macro@codesourcery.com>
---
Hi,

 I see someone has just fixed this issue in one place, so I had to 
regenerate the change I originally made against 3.17, but I really fail 
to see why not to fix it throughout at once.

 Please apply,

  Maciej

linux-umips-fixup-insn.diff
Index: linux-3.18-rc4-malta/arch/mips/include/asm/futex.h
===================================================================
--- linux-3.18-rc4-malta.orig/arch/mips/include/asm/futex.h	2014-11-15 05:56:06.000000000 +0000
+++ linux-3.18-rc4-malta/arch/mips/include/asm/futex.h	2014-11-15 00:26:50.261902695 +0000
@@ -33,6 +33,7 @@
 		"	beqzl	$1, 1b				\n"	\
 		__WEAK_LLSC_MB						\
 		"3:						\n"	\
+		"	.insn					\n"	\
 		"	.set	pop				\n"	\
 		"	.set	mips0				\n"	\
 		"	.section .fixup,\"ax\"			\n"	\
@@ -61,6 +62,7 @@
 		"	beqz	$1, 1b				\n"	\
 		__WEAK_LLSC_MB						\
 		"3:						\n"	\
+		"	.insn					\n"	\
 		"	.set	pop				\n"	\
 		"	.set	mips0				\n"	\
 		"	.section .fixup,\"ax\"			\n"	\
@@ -162,6 +164,7 @@ futex_atomic_cmpxchg_inatomic(u32 *uval,
 		"	beqzl	$1, 1b					\n"
 		__WEAK_LLSC_MB
 		"3:							\n"
+		"	.insn						\n"
 		"	.set	pop					\n"
 		"	.section .fixup,\"ax\"				\n"
 		"4:	li	%0, %6					\n"
@@ -190,6 +193,7 @@ futex_atomic_cmpxchg_inatomic(u32 *uval,
 		"	beqz	$1, 1b					\n"
 		__WEAK_LLSC_MB
 		"3:							\n"
+		"	.insn						\n"
 		"	.set	pop					\n"
 		"	.section .fixup,\"ax\"				\n"
 		"4:	li	%0, %6					\n"
Index: linux-3.18-rc4-malta/arch/mips/include/asm/paccess.h
===================================================================
--- linux-3.18-rc4-malta.orig/arch/mips/include/asm/paccess.h	2013-05-23 16:08:04.000000000 +0100
+++ linux-3.18-rc4-malta/arch/mips/include/asm/paccess.h	2014-11-15 05:56:52.451903033 +0000
@@ -56,6 +56,7 @@ struct __large_pstruct { unsigned long b
 	"1:\t" insn "\t%1,%2\n\t"					\
 	"move\t%0,$0\n"							\
 	"2:\n\t"							\
+	".insn\n\t"							\
 	".section\t.fixup,\"ax\"\n"					\
 	"3:\tli\t%0,%3\n\t"						\
 	"move\t%1,$0\n\t"						\
@@ -94,6 +95,7 @@ extern void __get_dbe_unknown(void);
 	"1:\t" insn "\t%1,%2\n\t"					\
 	"move\t%0,$0\n"							\
 	"2:\n\t"							\
+	".insn\n\t"							\
 	".section\t.fixup,\"ax\"\n"					\
 	"3:\tli\t%0,%3\n\t"						\
 	"j\t2b\n\t"							\
Index: linux-3.18-rc4-malta/arch/mips/kernel/syscall.c
===================================================================
--- linux-3.18-rc4-malta.orig/arch/mips/kernel/syscall.c	2014-11-14 03:29:49.000000000 +0000
+++ linux-3.18-rc4-malta/arch/mips/kernel/syscall.c	2014-11-15 05:56:52.451903033 +0000
@@ -117,6 +117,7 @@ static inline int mips_atomic_set(unsign
 		"2:	sc	%[tmp], (%[addr])			\n"
 		"	beqzl	%[tmp], 1b				\n"
 		"3:							\n"
+		"	.insn						\n"
 		"	.section .fixup,\"ax\"				\n"
 		"4:	li	%[err], %[efault]			\n"
 		"	j	3b					\n"
@@ -142,6 +143,7 @@ static inline int mips_atomic_set(unsign
 		"2:	sc	%[tmp], (%[addr])			\n"
 		"	bnez	%[tmp], 4f				\n"
 		"3:							\n"
+		"	.insn						\n"
 		"	.subsection 2					\n"
 		"4:	b	1b					\n"
 		"	.previous					\n"
