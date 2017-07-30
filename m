Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 30 Jul 2017 22:28:28 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:38754 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993905AbdG3U2PSOPh1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 30 Jul 2017 22:28:15 +0200
Date:   Sun, 30 Jul 2017 21:28:15 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org, stable@vger.kernel.org
Subject: [PATCH v2] MIPS: DEC: Fix an int-handler.S CPU_DADDI_WORKAROUNDS
 regression
Message-ID: <alpine.LFD.2.20.1707302037360.32408@eddie.linux-mips.org>
User-Agent: Alpine 2.20 (LFD 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59306
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

Fix a commit 3021773c7c3e ("MIPS: DEC: Avoid la pseudo-instruction in 
delay slots") regression and remove assembly errors:

arch/mips/dec/int-handler.S: Assembler messages:
arch/mips/dec/int-handler.S:162: Error: Macro used $at after ".set noat"
arch/mips/dec/int-handler.S:163: Error: Macro used $at after ".set noat"
arch/mips/dec/int-handler.S:229: Error: Macro used $at after ".set noat"
arch/mips/dec/int-handler.S:230: Error: Macro used $at after ".set noat"

triggering with with the CPU_DADDI_WORKAROUNDS option set and the DADDIU 
instruction.  This is because with that option in place the instruction 
becomes a macro, which expands to an LI/DADDU (or actually ADDIU/DADDU) 
sequence that uses $at as a temporary register.

With CPU_DADDI_WORKAROUNDS we only support `-msym32' compilation though, 
and this is already enforced in arch/mips/Makefile, so choose the 32-bit 
expansion variant for the supported configurations and then replace the 
64-bit variant with #error just in case.

Cc: stable@vger.kernel.org # 4.8+
Fixes: 3021773c7c3e ("MIPS: DEC: Avoid la pseudo-instruction in delay slots")
Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
 arch/mips/dec/int-handler.S |   34 ++++++----------------------------
 1 file changed, 6 insertions(+), 28 deletions(-)

linux-mips-dec-int-handler-la.diff
Index: linux-sfr-4maxp64/arch/mips/dec/int-handler.S
===================================================================
--- linux-sfr-4maxp64.orig/arch/mips/dec/int-handler.S
+++ linux-sfr-4maxp64/arch/mips/dec/int-handler.S
@@ -147,23 +147,12 @@
 		 * Find irq with highest priority
 		 */
 		# open coded PTR_LA t1, cpu_mask_nr_tbl
-#if (_MIPS_SZPTR == 32)
+#if defined(CONFIG_32BIT) || defined(KBUILD_64BIT_SYM32)
 		# open coded la t1, cpu_mask_nr_tbl
 		lui	t1, %hi(cpu_mask_nr_tbl)
 		addiu	t1, %lo(cpu_mask_nr_tbl)
-
-#endif
-#if (_MIPS_SZPTR == 64)
-		# open coded dla t1, cpu_mask_nr_tbl
-		.set	push
-		.set	noat
-		lui	t1, %highest(cpu_mask_nr_tbl)
-		lui	AT, %hi(cpu_mask_nr_tbl)
-		daddiu	t1, t1, %higher(cpu_mask_nr_tbl)
-		daddiu	AT, AT, %lo(cpu_mask_nr_tbl)
-		dsll	t1, 32
-		daddu	t1, t1, AT
-		.set	pop
+#else
+#error GCC `-msym32' option required for 64-bit DECstation builds
 #endif
 1:		lw	t2,(t1)
 		nop
@@ -214,23 +203,12 @@
 		 * Find irq with highest priority
 		 */
 		# open coded PTR_LA t1,asic_mask_nr_tbl
-#if (_MIPS_SZPTR == 32)
+#if defined(CONFIG_32BIT) || defined(KBUILD_64BIT_SYM32)
 		# open coded la t1, asic_mask_nr_tbl
 		lui	t1, %hi(asic_mask_nr_tbl)
 		addiu	t1, %lo(asic_mask_nr_tbl)
-
-#endif
-#if (_MIPS_SZPTR == 64)
-		# open coded dla t1, asic_mask_nr_tbl
-		.set	push
-		.set	noat
-		lui	t1, %highest(asic_mask_nr_tbl)
-		lui	AT, %hi(asic_mask_nr_tbl)
-		daddiu	t1, t1, %higher(asic_mask_nr_tbl)
-		daddiu	AT, AT, %lo(asic_mask_nr_tbl)
-		dsll	t1, 32
-		daddu	t1, t1, AT
-		.set	pop
+#else
+#error GCC `-msym32' option required for 64-bit DECstation builds
 #endif
 2:		lw	t2,(t1)
 		nop
