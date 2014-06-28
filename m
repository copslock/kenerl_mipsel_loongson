Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Jun 2014 01:26:22 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:50512 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6859955AbaF1X0Up5cRJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 29 Jun 2014 01:26:20 +0200
Date:   Sun, 29 Jun 2014 00:26:20 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: [PATCH] MIPS: asm/bitops.h: Guard CLZ with `.set mips32'
Message-ID: <alpine.LFD.2.11.1406242209440.23403@eddie.linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40912
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

This fixes:

{standard input}: Assembler messages:
{standard input}:145: Error: opcode not supported on this processor: vr5000 (mips4) `clz $2,$2'
{standard input}:920: Error: opcode not supported on this processor: vr5000 (mips4) `clz $7,$9'
{standard input}:1797: Error: opcode not supported on this processor: vr5000 (mips4) `clz $7,$7'
{standard input}:1851: Error: opcode not supported on this processor: vr5000 (mips4) `clz $7,$7'
{standard input}:2831: Error: opcode not supported on this processor: vr5000 (mips4) `clz $7,$7'
{standard input}:4209: Error: opcode not supported on this processor: vr5000 (mips4) `clz $7,$7'
{standard input}:4329: Error: opcode not supported on this processor: vr5000 (mips4) `clz $2,$2'
make[2]: *** [arch/mips/mm/tlbex.o] Error 1

which triggered due to a regression causing the file to be built with 
`-march=r5000' rather than `-march=sb1', fixed separately.  Nevertheless 
the error should not happen, the other uses of CLZ are appropriately 
guarded.  This change copies the arrangement from one of those other 
places.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
linux-mips-clz.patch
Index: linux-20140623-swarm64/arch/mips/include/asm/bitops.h
===================================================================
--- linux-20140623-swarm64.orig/arch/mips/include/asm/bitops.h
+++ linux-20140623-swarm64/arch/mips/include/asm/bitops.h
@@ -559,7 +559,13 @@ static inline int fls(int x)
 	int r;
 
 	if (__builtin_constant_p(cpu_has_clo_clz) && cpu_has_clo_clz) {
-		__asm__("clz %0, %1" : "=r" (x) : "r" (x));
+		__asm__(
+		"	.set	push					\n"
+		"	.set	mips32					\n"
+		"	clz	%0, %1					\n"
+		"	.set	pop					\n"
+		: "=r" (x)
+		: "r" (x));
 
 		return 32 - x;
 	}
