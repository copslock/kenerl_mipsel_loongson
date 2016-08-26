Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Aug 2016 17:42:24 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:1288 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992541AbcHZPkpx40MI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Aug 2016 17:40:45 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 053E4B571DD2A;
        Fri, 26 Aug 2016 16:40:24 +0100 (IST)
Received: from localhost (10.100.200.141) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 26 Aug
 2016 16:40:27 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        "Maciej W. Rozycki" <macro@imgtec.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 10/26] MIPS: Print CM error reports upon bus errors
Date:   Fri, 26 Aug 2016 16:37:09 +0100
Message-ID: <20160826153725.11629-11-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160826153725.11629-1-paul.burton@imgtec.com>
References: <20160826153725.11629-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.141]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54794
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

 arch/mips/kernel/traps.c          |  3 +++
 arch/mips/mti-malta/malta-int.c   | 15 ---------------
 arch/mips/mti-malta/malta-setup.c |  6 ------
 3 files changed, 3 insertions(+), 21 deletions(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 3de85be..e2c571d 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -48,6 +48,7 @@
 #include <asm/fpu.h>
 #include <asm/fpu_emulator.h>
 #include <asm/idle.h>
+#include <asm/mips-cm.h>
 #include <asm/mips-r2-to-r6-emul.h>
 #include <asm/mipsregs.h>
 #include <asm/mipsmtregs.h>
@@ -444,6 +445,8 @@ asmlinkage void do_be(struct pt_regs *regs)
 
 	if (board_be_handler)
 		action = board_be_handler(regs, fixup != NULL);
+	else
+		mips_cm_error_report();
 
 	switch (action) {
 	case MIPS_BE_DISCARD:
diff --git a/arch/mips/mti-malta/malta-int.c b/arch/mips/mti-malta/malta-int.c
index c6a6c7a..548130d 100644
--- a/arch/mips/mti-malta/malta-int.c
+++ b/arch/mips/mti-malta/malta-int.c
@@ -376,18 +376,3 @@ void __init arch_init_irq(void)
 	setup_irq(i8259_irq, &i8259irq);
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
index d7d151f..2f25930 100644
--- a/arch/mips/mti-malta/malta-setup.c
+++ b/arch/mips/mti-malta/malta-setup.c
@@ -39,9 +39,6 @@
 #include <linux/console.h>
 #endif
 
-extern void malta_be_init(void);
-extern int malta_be_handler(struct pt_regs *regs, int is_fixup);
-
 static struct resource standard_io_resources[] = {
 	{
 		.name = "dma1",
@@ -295,7 +292,4 @@ void __init plat_mem_setup(void)
 #if defined(CONFIG_VT) && defined(CONFIG_VGA_CONSOLE)
 	screen_info_setup();
 #endif
-
-	board_be_init = malta_be_init;
-	board_be_handler = malta_be_handler;
 }
-- 
2.9.3
