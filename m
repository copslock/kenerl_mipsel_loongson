Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Feb 2010 23:37:35 +0100 (CET)
Received: from sj-iport-3.cisco.com ([171.71.176.72]:48790 "EHLO
        sj-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1492334Ab0BVWh3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 22 Feb 2010 23:37:29 +0100
Authentication-Results: sj-iport-3.cisco.com; dkim=neutral (message not signed) header.i=none
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvsEAFKWgkurR7H+/2dsb2JhbACbAXOkWJglhGsEgxU
X-IronPort-AV: E=Sophos;i="4.49,521,1262563200"; 
   d="scan'208";a="213672066"
Received: from sj-core-2.cisco.com ([171.71.177.254])
  by sj-iport-3.cisco.com with ESMTP; 22 Feb 2010 22:37:21 +0000
Received: from dvomlehn-lnx2.corp.sa.net ([64.101.20.155])
        by sj-core-2.cisco.com (8.13.8/8.14.3) with ESMTP id o1MMbLoT020398;
        Mon, 22 Feb 2010 22:37:21 GMT
Date:   Mon, 22 Feb 2010 14:37:21 -0800
From:   David VomLehn <dvomlehn@cisco.com>
To:     to@dvomlehn-lnx2.corp.sa.net,
        "linux-mips@linux-mips.org"@cisco.com, linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: Eliminate duplicate opcode definition macros
Message-ID: <20100222223721.GA27005@dvomlehn-lnx2.corp.sa.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25989
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

Change to different macros for assembler macros since the old names in
powertv_setup.c were co-opted for use in asm/asm.h. This broken the
build for the powertv platform. This patch introduces new macros based on
the new macros in asm.h to take the place of the old macro values.

Signed-off-by: David VomLehn <dvomlehn@cisco.com>
---
 arch/mips/powertv/powertv_setup.c |   99 ++++++++++++++++++-------------------
 1 files changed, 48 insertions(+), 51 deletions(-)

diff --git a/arch/mips/powertv/powertv_setup.c b/arch/mips/powertv/powertv_setup.c
index 698b1ea..9bac903 100644
--- a/arch/mips/powertv/powertv_setup.c
+++ b/arch/mips/powertv/powertv_setup.c
@@ -32,35 +32,32 @@
 #include <asm/mips-boards/generic.h>
 #include <asm/mips-boards/prom.h>
 #include <asm/dma.h>
+#include <asm/asm.h>
 #include <linux/time.h>
 #include <asm/traps.h>
 #include <asm/asm-offsets.h>
 #include "reset.h"
+#include <asm/asm.h>
 
 #define VAL(n)		STR(n)
 
 /*
  * Macros for loading addresses and storing registers:
- * PTR_LA	Load the address into a register
- * LONG_S	Store the full width of the given register.
- * LONG_L	Load the full width of the given register
- * PTR_ADDIU	Add a constant value to a register used as a pointer
+ * LONG_L_	Stringified version of LONG_L for use in asm() statement
+ * LONG_S_	Stringified version of LONG_S for use in asm() statement
+ * PTR_LA_	Stringified version of PTR_LA for use in asm() statement
  * REG_SIZE	Number of 8-bit bytes in a full width register
  */
+#define LONG_L_		VAL(LONG_L) " "
+#define LONG_S_		VAL(LONG_S) " "
+#define PTR_LA_		VAL(PTR_LA) " "
+
 #ifdef CONFIG_64BIT
 #warning TODO: 64-bit code needs to be verified
-#define PTR_LA		"dla	"
-#define LONG_S		"sd	"
-#define LONG_L		"ld	"
-#define PTR_ADDIU	"daddiu	"
 #define REG_SIZE	"8"		/* In bytes */
 #endif
 
 #ifdef CONFIG_32BIT
-#define PTR_LA		"la	"
-#define LONG_S		"sw	"
-#define LONG_L		"lw	"
-#define PTR_ADDIU	"addiu	"
 #define REG_SIZE	"4"		/* In bytes */
 #endif
 
@@ -113,9 +110,9 @@ static int panic_handler(struct notifier_block *notifier_block,
 		 * structure. */
 		__asm__ __volatile__ (
 			".set	noat\n"
-			LONG_S		"$at, %[at]\n"
-			LONG_S		"$2, %[v0]\n"
-			LONG_S		"$3, %[v1]\n"
+			LONG_S_		"$at, %[at]\n"
+			LONG_S_		"$2, %[v0]\n"
+			LONG_S_		"$3, %[v1]\n"
 		:
 			[at] "=m" (at),
 			[v0] "=m" (v0),
@@ -129,54 +126,54 @@ static int panic_handler(struct notifier_block *notifier_block,
 			"move		$at, %[pt_regs]\n"
 
 			/* Argument registers */
-			LONG_S		"$4, " VAL(PT_R4) "($at)\n"
-			LONG_S		"$5, " VAL(PT_R5) "($at)\n"
-			LONG_S		"$6, " VAL(PT_R6) "($at)\n"
-			LONG_S		"$7, " VAL(PT_R7) "($at)\n"
+			LONG_S_		"$4, " VAL(PT_R4) "($at)\n"
+			LONG_S_		"$5, " VAL(PT_R5) "($at)\n"
+			LONG_S_		"$6, " VAL(PT_R6) "($at)\n"
+			LONG_S_		"$7, " VAL(PT_R7) "($at)\n"
 
 			/* Temporary regs */
-			LONG_S		"$8, " VAL(PT_R8) "($at)\n"
-			LONG_S		"$9, " VAL(PT_R9) "($at)\n"
-			LONG_S		"$10, " VAL(PT_R10) "($at)\n"
-			LONG_S		"$11, " VAL(PT_R11) "($at)\n"
-			LONG_S		"$12, " VAL(PT_R12) "($at)\n"
-			LONG_S		"$13, " VAL(PT_R13) "($at)\n"
-			LONG_S		"$14, " VAL(PT_R14) "($at)\n"
-			LONG_S		"$15, " VAL(PT_R15) "($at)\n"
+			LONG_S_		"$8, " VAL(PT_R8) "($at)\n"
+			LONG_S_		"$9, " VAL(PT_R9) "($at)\n"
+			LONG_S_		"$10, " VAL(PT_R10) "($at)\n"
+			LONG_S_		"$11, " VAL(PT_R11) "($at)\n"
+			LONG_S_		"$12, " VAL(PT_R12) "($at)\n"
+			LONG_S_		"$13, " VAL(PT_R13) "($at)\n"
+			LONG_S_		"$14, " VAL(PT_R14) "($at)\n"
+			LONG_S_		"$15, " VAL(PT_R15) "($at)\n"
 
 			/* "Saved" registers */
-			LONG_S		"$16, " VAL(PT_R16) "($at)\n"
-			LONG_S		"$17, " VAL(PT_R17) "($at)\n"
-			LONG_S		"$18, " VAL(PT_R18) "($at)\n"
-			LONG_S		"$19, " VAL(PT_R19) "($at)\n"
-			LONG_S		"$20, " VAL(PT_R20) "($at)\n"
-			LONG_S		"$21, " VAL(PT_R21) "($at)\n"
-			LONG_S		"$22, " VAL(PT_R22) "($at)\n"
-			LONG_S		"$23, " VAL(PT_R23) "($at)\n"
+			LONG_S_		"$16, " VAL(PT_R16) "($at)\n"
+			LONG_S_		"$17, " VAL(PT_R17) "($at)\n"
+			LONG_S_		"$18, " VAL(PT_R18) "($at)\n"
+			LONG_S_		"$19, " VAL(PT_R19) "($at)\n"
+			LONG_S_		"$20, " VAL(PT_R20) "($at)\n"
+			LONG_S_		"$21, " VAL(PT_R21) "($at)\n"
+			LONG_S_		"$22, " VAL(PT_R22) "($at)\n"
+			LONG_S_		"$23, " VAL(PT_R23) "($at)\n"
 
 			/* Add'l temp regs */
-			LONG_S		"$24, " VAL(PT_R24) "($at)\n"
-			LONG_S		"$25, " VAL(PT_R25) "($at)\n"
+			LONG_S_		"$24, " VAL(PT_R24) "($at)\n"
+			LONG_S_		"$25, " VAL(PT_R25) "($at)\n"
 
 			/* Kernel temp regs */
-			LONG_S		"$26, " VAL(PT_R26) "($at)\n"
-			LONG_S		"$27, " VAL(PT_R27) "($at)\n"
+			LONG_S_		"$26, " VAL(PT_R26) "($at)\n"
+			LONG_S_		"$27, " VAL(PT_R27) "($at)\n"
 
 			/* Global pointer, stack pointer, frame pointer and
 			 * return address */
-			LONG_S		"$gp, " VAL(PT_R28) "($at)\n"
-			LONG_S		"$sp, " VAL(PT_R29) "($at)\n"
-			LONG_S		"$fp, " VAL(PT_R30) "($at)\n"
-			LONG_S		"$ra, " VAL(PT_R31) "($at)\n"
+			LONG_S_		"$gp, " VAL(PT_R28) "($at)\n"
+			LONG_S_		"$sp, " VAL(PT_R29) "($at)\n"
+			LONG_S_		"$fp, " VAL(PT_R30) "($at)\n"
+			LONG_S_		"$ra, " VAL(PT_R31) "($at)\n"
 
 			/* Now we can get the $at and v0 registers back and
 			 * store them */
-			LONG_L		"$8, %[at]\n"
-			LONG_S		"$8, " VAL(PT_R1) "($at)\n"
-			LONG_L		"$8, %[v0]\n"
-			LONG_S		"$8, " VAL(PT_R2) "($at)\n"
-			LONG_L		"$8, %[v1]\n"
-			LONG_S		"$8, " VAL(PT_R3) "($at)\n"
+			LONG_L_		"$8, %[at]\n"
+			LONG_S_		"$8, " VAL(PT_R1) "($at)\n"
+			LONG_L_		"$8, %[v0]\n"
+			LONG_S_		"$8, " VAL(PT_R2) "($at)\n"
+			LONG_L_		"$8, %[v1]\n"
+			LONG_S_		"$8, " VAL(PT_R3) "($at)\n"
 		:
 		:
 			[at] "m" (at),
@@ -191,8 +188,8 @@ static int panic_handler(struct notifier_block *notifier_block,
 		__asm__ __volatile__ (
 			".set	noat\n"
 		"1:\n"
-			PTR_LA		"$at, 1b\n"
-			LONG_S		"$at, %[cp0_epc]\n"
+			PTR_LA_		"$at, 1b\n"
+			LONG_S_		"$at, %[cp0_epc]\n"
 		:
 			[cp0_epc] "=m" (my_regs.cp0_epc)
 		:
