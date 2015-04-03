Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Apr 2015 00:28:27 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27025272AbbDCWZAkrhEx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Apr 2015 00:25:00 +0200
Date:   Fri, 3 Apr 2015 23:25:00 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: [PATCH 17/48] MIPS: bitops.h: Avoid inline asm for constant FLS
In-Reply-To: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
Message-ID: <alpine.LFD.2.11.1504030303140.21028@eddie.linux-mips.org>
References: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46734
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

GCC is smart enough to substitute the final result for FLS calculations 
as implemented in the fallback C code we have in `__fls' and `fls' 
applied to constant values.  The presence of inline asm defeats the 
compiler though, forcing it to emit extraneous CLZ/DCLZ calculation for 
processors that support these instructions.

Use `__builtin_constant_p' then to avoid inline asm altogether for 
constants.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
Ralf,

 Even my good old trusty 4.1.2 can do it...

  Maciej

linux-mips-const-fls.diff
Index: linux/arch/mips/include/asm/bitops.h
===================================================================
--- linux.orig/arch/mips/include/asm/bitops.h	2015-04-02 20:18:51.384515000 +0100
+++ linux/arch/mips/include/asm/bitops.h	2015-04-02 20:27:54.273191000 +0100
@@ -481,7 +481,7 @@ static inline unsigned long __fls(unsign
 {
 	int num;
 
-	if (BITS_PER_LONG == 32 &&
+	if (BITS_PER_LONG == 32 && !__builtin_constant_p(word) &&
 	    __builtin_constant_p(cpu_has_clo_clz) && cpu_has_clo_clz) {
 		__asm__(
 		"	.set	push					\n"
@@ -494,7 +494,7 @@ static inline unsigned long __fls(unsign
 		return 31 - num;
 	}
 
-	if (BITS_PER_LONG == 64 &&
+	if (BITS_PER_LONG == 64 && !__builtin_constant_p(word) &&
 	    __builtin_constant_p(cpu_has_mips64) && cpu_has_mips64) {
 		__asm__(
 		"	.set	push					\n"
@@ -559,7 +559,8 @@ static inline int fls(int x)
 {
 	int r;
 
-	if (__builtin_constant_p(cpu_has_clo_clz) && cpu_has_clo_clz) {
+	if (!__builtin_constant_p(x) &&
+	    __builtin_constant_p(cpu_has_clo_clz) && cpu_has_clo_clz) {
 		__asm__(
 		"	.set	push					\n"
 		"	.set	"MIPS_ISA_LEVEL"			\n"
