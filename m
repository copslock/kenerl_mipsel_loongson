Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Aug 2008 23:07:46 +0100 (BST)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.134]:9959 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S28575158AbYH1WHo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 28 Aug 2008 23:07:44 +0100
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id B06E1320B87;
	Thu, 28 Aug 2008 22:07:54 +0000 (UTC)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [173.8.135.205])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Thu, 28 Aug 2008 22:07:54 +0000 (UTC)
Received: from silver64.hq2.avtrex.com ([192.168.7.14]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 28 Aug 2008 15:07:37 -0700
Message-ID: <48B721A9.4070201@avtrex.com>
Date:	Thu, 28 Aug 2008 15:07:37 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Cc:	linux-kernel@vger.kernel.org
Subject: [Patch 4/6] MIPS: Watch exception handling for HARDWARE_WATCHPOINTS.
References: <48B71ADD.601@avtrex.com>
In-Reply-To: <48B71ADD.601@avtrex.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Aug 2008 22:07:37.0729 (UTC) FILETIME=[7B4F9710:01C9095A]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20383
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips


Here we hook up the watch exception handler so that it sends SIGTRAP
when the hardware watch registers are triggered.

Signed-off-by: David Daney <ddaney@avtrex.com>
---
 arch/mips/kernel/genex.S |    4 ++++
 arch/mips/kernel/traps.c |   14 +++++++++-----
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
index c6ada98..15a9bde 100644
--- a/arch/mips/kernel/genex.S
+++ b/arch/mips/kernel/genex.S
@@ -416,7 +416,11 @@ NESTED(nmi_handler, PT_SIZE, sp)
 	BUILD_HANDLER tr tr sti silent			/* #13 */
 	BUILD_HANDLER fpe fpe fpe silent		/* #15 */
 	BUILD_HANDLER mdmx mdmx sti silent		/* #22 */
+#ifdef 	CONFIG_HARDWARE_WATCHPOINTS
+	BUILD_HANDLER watch watch sti silent		/* #23 */
+#else
 	BUILD_HANDLER watch watch sti verbose		/* #23 */
+#endif
 	BUILD_HANDLER mcheck mcheck cli verbose		/* #24 */
 	BUILD_HANDLER mt mt sti silent			/* #25 */
 	BUILD_HANDLER dsp dsp sti silent		/* #26 */
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 6bee290..5fbf591 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -42,6 +42,7 @@
 #include <asm/tlbdebug.h>
 #include <asm/traps.h>
 #include <asm/uaccess.h>
+#include <asm/watch.h>
 #include <asm/mmu_context.h>
 #include <asm/types.h>
 #include <asm/stacktrace.h>
@@ -908,12 +909,15 @@ asmlinkage void do_mdmx(struct pt_regs *regs)
 asmlinkage void do_watch(struct pt_regs *regs)
 {
 	/*
-	 * We use the watch exception where available to detect stack
-	 * overflows.
+	 * If the current thread has the watch registers loaded, save
+	 * their values and send SIGTRAP.  Otherwise another thread
+	 * left the registers set, clear them and continue.
 	 */
-	dump_tlb_all();
-	show_regs(regs);
-	panic("Caught WATCH exception - probably caused by stack overflow.");
+	if (test_tsk_thread_flag(current, TIF_LOAD_WATCH)) {
+		mips_read_watch_registers();
+		force_sig(SIGTRAP, current);
+	} else
+		mips_clear_watch_registers();
 }
 
 asmlinkage void do_mcheck(struct pt_regs *regs)
-- 
1.5.5.1
