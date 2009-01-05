Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Jan 2009 23:31:29 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:54255 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S24207836AbZAEXbG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 5 Jan 2009 23:31:06 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B496297fc0000>; Mon, 05 Jan 2009 18:30:09 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 5 Jan 2009 15:30:01 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 5 Jan 2009 15:30:01 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id n05NTxjV018563;
	Mon, 5 Jan 2009 15:29:59 -0800
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id n05NTwLq018562;
	Mon, 5 Jan 2009 15:29:58 -0800
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Read watch registers with interrupts disabled.
Date:	Mon,  5 Jan 2009 15:29:58 -0800
Message-Id: <1231198198-18539-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.6.6
X-OriginalArrivalTime: 05 Jan 2009 23:30:01.0404 (UTC) FILETIME=[87AC07C0:01C96F8D]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21685
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

If a context switch occurred between the watch exception and reading
the watch registers, it would be possible for the new process to
corrupt their state.  Enabling interrupts only after the watch
registers are read avoids this race.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/kernel/genex.S |    6 +++++-
 arch/mips/kernel/traps.c |    8 +++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
index fb6f731..8882e57 100644
--- a/arch/mips/kernel/genex.S
+++ b/arch/mips/kernel/genex.S
@@ -458,7 +458,11 @@ NESTED(nmi_handler, PT_SIZE, sp)
 	BUILD_HANDLER fpe fpe fpe silent		/* #15 */
 	BUILD_HANDLER mdmx mdmx sti silent		/* #22 */
 #ifdef 	CONFIG_HARDWARE_WATCHPOINTS
-	BUILD_HANDLER watch watch sti silent		/* #23 */
+	/*
+	 * For watch, interrupts will be enabled after the watch
+	 * registers are read.
+	 */
+	BUILD_HANDLER watch watch cli silent		/* #23 */
 #else
 	BUILD_HANDLER watch watch sti verbose		/* #23 */
 #endif
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index f6083c6..7a97b3f 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -944,6 +944,9 @@ asmlinkage void do_mdmx(struct pt_regs *regs)
 	force_sig(SIGILL, current);
 }
 
+/*
+ * Called with interrupts disabled.
+ */
 asmlinkage void do_watch(struct pt_regs *regs)
 {
 	u32 cause;
@@ -963,9 +966,12 @@ asmlinkage void do_watch(struct pt_regs *regs)
 	 */
 	if (test_tsk_thread_flag(current, TIF_LOAD_WATCH)) {
 		mips_read_watch_registers();
+		local_irq_enable();
 		force_sig(SIGTRAP, current);
-	} else
+	} else {
 		mips_clear_watch_registers();
+		local_irq_enable();
+	}
 }
 
 asmlinkage void do_mcheck(struct pt_regs *regs)
-- 
1.5.6.6
