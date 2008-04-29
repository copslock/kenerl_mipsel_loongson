Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Apr 2008 02:37:42 +0100 (BST)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.144]:11458 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S20206122AbYD2Bhj (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 29 Apr 2008 02:37:39 +0100
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id 20519319FCB;
	Tue, 29 Apr 2008 01:41:38 +0000 (UTC)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [67.116.42.147])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Tue, 29 Apr 2008 01:41:37 +0000 (UTC)
Received: from dl2.hq2.avtrex.com ([192.168.7.26]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 28 Apr 2008 18:37:31 -0700
Message-ID: <48167BDB.4080501@avtrex.com>
Date:	Mon, 28 Apr 2008 18:37:31 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 2.0.0.12 (X11/20080226)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Cc:	Linux kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/6] Watch exception handling for HARDWARE_WATCHPOINTS.
References: <48167832.3090103@avtrex.com>
In-Reply-To: <48167832.3090103@avtrex.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Apr 2008 01:37:31.0869 (UTC) FILETIME=[979B58D0:01C8A999]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19047
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Watch exception handling for HARDWARE_WATCHPOINTS.

Here we hook up the watch exception handler so that it sends SIGTRAP when
the hardware watch registers are triggered.

Signed-off-by: David Daney <ddaney@avtrex.com>
---
 arch/mips/kernel/genex.S |    4 ++++
 arch/mips/kernel/traps.c |   14 ++++++++++++++
 2 files changed, 18 insertions(+), 0 deletions(-)

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
index 824b187..22bb053 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -39,6 +39,7 @@
 #include <asm/tlbdebug.h>
 #include <asm/traps.h>
 #include <asm/uaccess.h>
+#include <asm/watch.h>
 #include <asm/mmu_context.h>
 #include <asm/types.h>
 #include <asm/stacktrace.h>
@@ -871,6 +872,18 @@ asmlinkage void do_mdmx(struct pt_regs *regs)
 
 asmlinkage void do_watch(struct pt_regs *regs)
 {
+#ifdef CONFIG_HARDWARE_WATCHPOINTS
+	/*
+	 * If the current thread has the watch registers loaded, save
+	 * their values and send SIGTRAP.  Otherwise another thread
+	 * left the registers set, clear them and continue.
+	 */
+	if (test_tsk_thread_flag(current, TIF_LOAD_WATCH)) {
+		mips_read_watch_registers();
+		force_sig(SIGTRAP, current);
+	} else
+		mips_clear_watch_registers();
+#else
 	if (board_watchpoint_handler) {
 		(*board_watchpoint_handler)(regs);
 		return;
@@ -883,6 +896,7 @@ asmlinkage void do_watch(struct pt_regs *regs)
 	dump_tlb_all();
 	show_regs(regs);
 	panic("Caught WATCH exception - probably caused by stack overflow.");
+#endif
 }
 
 asmlinkage void do_mcheck(struct pt_regs *regs)
-- 
1.5.5
