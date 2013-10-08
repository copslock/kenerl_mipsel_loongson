Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Oct 2013 13:39:41 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:14886 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822674Ab3JHLjcb1K1f (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 8 Oct 2013 13:39:32 +0200
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH] MIPS: Print correct PC in trace dump after NMI exception
Date:   Tue, 8 Oct 2013 12:39:31 +0100
Message-ID: <1381232371-25017-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.3.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.31]
X-SEF-Processed: 7_3_0_01192__2013_10_08_12_39_26
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38261
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>

An NMI exception delivered from YAMON delivers the PC in ErrorPC
instead of EPC. It's also necessary to clear the Status.BEV
bit for the page fault exception handler to work properly.

Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/kernel/genex.S | 15 ++++++++++++---
 arch/mips/kernel/traps.c | 13 +++++++++++--
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
index 31fa856..6a6bea2 100644
--- a/arch/mips/kernel/genex.S
+++ b/arch/mips/kernel/genex.S
@@ -374,12 +374,21 @@ NESTED(except_vec_nmi, 0, sp)
 NESTED(nmi_handler, PT_SIZE, sp)
 	.set	push
 	.set	noat
+	/*
+	 * Clear ERL - restore segment mapping
+	 * Clear BEV - required for page fault exception handler to work
+	 */
+	mfc0	k0, CP0_STATUS
+	ori     k0, k0, ST0_EXL
+	lui     k1, %hi(~ST0_BEV)
+	ori     k1, k1, %lo(~ST0_ERL)
+	and     k0, k0, k1
+	mtc0    k0, CP0_STATUS
+	ehb
 	SAVE_ALL
 	move	a0, sp
 	jal	nmi_exception_handler
-	RESTORE_ALL
-	.set	mips3
-	eret
+	/* nmi_exception_handler never returns */
 	.set	pop
 	END(nmi_handler)
 
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 28d1a20..709c154 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -330,6 +330,7 @@ void show_regs(struct pt_regs *regs)
 void show_registers(struct pt_regs *regs)
 {
 	const int field = 2 * sizeof(unsigned long);
+	mm_segment_t old_fs = get_fs();
 
 	__show_regs(regs);
 	print_modules();
@@ -344,9 +345,13 @@ void show_registers(struct pt_regs *regs)
 			printk("*HwTLS: %0*lx\n", field, tls);
 	}
 
+	if (!user_mode(regs))
+		/* Necessary for getting the correct stack content */
+		set_fs(KERNEL_DS);
 	show_stacktrace(current, regs);
 	show_code((unsigned int __user *) regs->cp0_epc);
 	printk("\n");
+	set_fs(old_fs);
 }
 
 static int regs_to_trapnr(struct pt_regs *regs)
@@ -1506,10 +1511,14 @@ int register_nmi_notifier(struct notifier_block *nb)
 
 void __noreturn nmi_exception_handler(struct pt_regs *regs)
 {
+	char str[100];
+
 	raw_notifier_call_chain(&nmi_chain, 0, regs);
 	bust_spinlocks(1);
-	printk("NMI taken!!!!\n");
-	die("NMI", regs);
+	snprintf(str, 100, "CPU%d NMI taken, CP0_EPC=%lx\n",
+		 smp_processor_id(), regs->cp0_epc);
+	regs->cp0_epc = read_c0_errorepc();
+	die(str, regs);
 }
 
 #define VECTORSPACING 0x100	/* for EI/VI mode */
-- 
1.8.3.2
