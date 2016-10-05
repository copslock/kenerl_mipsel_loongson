Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Oct 2016 19:23:35 +0200 (CEST)
Received: from mailapp02.imgtec.com ([217.156.133.132]:27385 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992236AbcJERVqFqAVu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Oct 2016 19:21:46 +0200
Received: from HHMAIL03.hh.imgtec.org (unknown [10.44.0.21])
        by Forcepoint Email with ESMTPS id 87817922C2DC8;
        Wed,  5 Oct 2016 18:21:38 +0100 (IST)
Received: from HHMAIL01.hh.imgtec.org (10.100.10.19) by HHMAIL03.hh.imgtec.org
 (10.44.0.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Wed, 5 Oct 2016
 18:21:39 +0100
Received: from localhost (10.100.200.82) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Wed, 5 Oct
 2016 18:21:39 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH v3 11/18] MIPS: Print CM error reports upon bus errors
Date:   Wed, 5 Oct 2016 18:18:17 +0100
Message-ID: <20161005171824.18014-12-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20161005171824.18014-1-paul.burton@imgtec.com>
References: <20161005171824.18014-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.82]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55337
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

If a bus error occurs on a system with a MIPS Coherence Manager (CM)
then the CM may hold useful diagnostic information. Printing this out
has so far been left up to boards, with the requirement that they
register a board_be_handler function & call mips_cm_error_decode() from
there.

In order to avoid boards other than Malta needing to duplicate this
code, call mips_cm_error_decode() automatically if the board registers
no board_be_handler, and remove the Malta implementation of that.

This patch results in no functional change, but removes a further piece
of platform-specific code.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

Changes in v3: None
Changes in v2: None

 arch/mips/kernel/traps.c          |  3 +++
 arch/mips/mti-malta/malta-int.c   | 15 ---------------
 arch/mips/mti-malta/malta-setup.c |  6 ------
 3 files changed, 3 insertions(+), 21 deletions(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 0c0270c..1f5fdee 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -49,6 +49,7 @@
 #include <asm/fpu.h>
 #include <asm/fpu_emulator.h>
 #include <asm/idle.h>
+#include <asm/mips-cm.h>
 #include <asm/mips-r2-to-r6-emul.h>
 #include <asm/mipsregs.h>
 #include <asm/mipsmtregs.h>
@@ -445,6 +446,8 @@ asmlinkage void do_be(struct pt_regs *regs)
 
 	if (board_be_handler)
 		action = board_be_handler(regs, fixup != NULL);
+	else
+		mips_cm_error_report();
 
 	switch (action) {
 	case MIPS_BE_DISCARD:
diff --git a/arch/mips/mti-malta/malta-int.c b/arch/mips/mti-malta/malta-int.c
index 9f83224..cb675ec 100644
--- a/arch/mips/mti-malta/malta-int.c
+++ b/arch/mips/mti-malta/malta-int.c
@@ -290,18 +290,3 @@ void __init arch_init_irq(void)
 
 	setup_irq(corehi_irq, &corehi_irqaction);
 }
-
-void malta_be_init(void)
-{
-	/* Could change CM error mask register. */
-}
-
-int malta_be_handler(struct pt_regs *regs, int is_fixup)
-{
-	/* This duplicates the handling in do_be which seems wrong */
-	int retval = is_fixup ? MIPS_BE_FIXUP : MIPS_BE_FATAL;
-
-	mips_cm_error_report();
-
-	return retval;
-}
diff --git a/arch/mips/mti-malta/malta-setup.c b/arch/mips/mti-malta/malta-setup.c
index f1b60748..a01d5de 100644
--- a/arch/mips/mti-malta/malta-setup.c
+++ b/arch/mips/mti-malta/malta-setup.c
@@ -42,9 +42,6 @@
 #define ROCIT_CONFIG_GEN0		0x1f403000
 #define  ROCIT_CONFIG_GEN0_PCI_IOCU	BIT(7)
 
-extern void malta_be_init(void);
-extern int malta_be_handler(struct pt_regs *regs, int is_fixup);
-
 static struct resource standard_io_resources[] = {
 	{
 		.name = "dma1",
@@ -301,7 +298,4 @@ void __init plat_mem_setup(void)
 #if defined(CONFIG_VT) && defined(CONFIG_VGA_CONSOLE)
 	screen_info_setup();
 #endif
-
-	board_be_init = malta_be_init;
-	board_be_handler = malta_be_handler;
 }
-- 
2.10.0
