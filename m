Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Oct 2008 02:00:49 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:30310 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S22251730AbYJXA5v (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 24 Oct 2008 01:57:51 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B49011d660000>; Thu, 23 Oct 2008 20:57:10 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 23 Oct 2008 17:57:09 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 23 Oct 2008 17:57:08 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id m9O0v3EP005601;
	Thu, 23 Oct 2008 17:57:03 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id m9O0v35k005600;
	Thu, 23 Oct 2008 17:57:03 -0700
From:	ddaney@caviumnetworks.com
To:	linux-mips@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>,
	Paul Gortmaker <Paul.Gortmaker@windriver.com>
Subject: [PATCH 10/37] Cavium OCTEON: Set hwrena and lazily restore CP2 state.
Date:	Thu, 23 Oct 2008 17:56:34 -0700
Message-Id: <1224809821-5532-11-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1224809821-5532-1-git-send-email-ddaney@caviumnetworks.com>
References: <1224809821-5532-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 24 Oct 2008 00:57:08.0391 (UTC) FILETIME=[70A17370:01C93573]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20889
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

From: David Daney <ddaney@caviumnetworks.com>

If on Cavium, then be aware of cop2 and hwrena during do_cpu().

Signed-off-by: Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Signed-off-by: Paul Gortmaker <Paul.Gortmaker@windriver.com>
Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/kernel/traps.c |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 80b9e07..8e40795 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -46,6 +46,7 @@
 #include <asm/mmu_context.h>
 #include <asm/types.h>
 #include <asm/stacktrace.h>
+#include <asm/irq.h>
 
 extern void check_wait(void);
 extern asmlinkage void r4k_wait(void);
@@ -77,6 +78,10 @@ extern asmlinkage void handle_reserved(void);
 extern int fpu_emulator_cop1Handler(struct pt_regs *xcp,
 	struct mips_fpu_struct *ctx, int has_fpu);
 
+#ifdef CONFIG_CPU_CAVIUM_OCTEON
+extern asmlinkage void octeon_cop2_restore(struct octeon_cop2_state *task);
+#endif
+
 void (*board_be_init)(void);
 int (*board_be_handler)(struct pt_regs *regs, int is_fixup);
 void (*board_nmi_handler_setup)(void);
@@ -844,6 +849,7 @@ asmlinkage void do_cpu(struct pt_regs *regs)
 	unsigned int opcode;
 	unsigned int cpid;
 	int status;
+	unsigned long __maybe_unused flags;
 
 	die_if_kernel("do_cpu invoked from kernel context!", regs);
 
@@ -899,6 +905,17 @@ asmlinkage void do_cpu(struct pt_regs *regs)
 		return;
 
 	case 2:
+#ifdef CONFIG_CPU_CAVIUM_OCTEON
+		prefetch(&current->thread.cp2);
+		local_irq_save(flags);
+		KSTK_STATUS(current) |= ST0_CU2;
+		status = read_c0_status();
+		write_c0_status(status | ST0_CU2);
+		octeon_cop2_restore(&(current->thread.cp2));
+		write_c0_status(status & ~ST0_CU2);
+		local_irq_restore(flags);
+		return;
+#endif
 	case 3:
 		break;
 	}
@@ -1472,6 +1489,10 @@ void __cpuinit per_cpu_trap_init(void)
 		write_c0_hwrena(enable);
 	}
 
+#ifdef CONFIG_CPU_CAVIUM_OCTEON
+	write_c0_hwrena(0xc000000f); /* Octeon has register 30 and 31 */
+#endif
+
 #ifdef CONFIG_MIPS_MT_SMTC
 	if (!secondaryTC) {
 #endif /* CONFIG_MIPS_MT_SMTC */
-- 
1.5.5.1
