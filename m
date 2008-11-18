Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Nov 2008 22:28:41 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:55086 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S23754605AbYKRWYT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 18 Nov 2008 22:24:19 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4923406e0003>; Tue, 18 Nov 2008 17:23:42 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 18 Nov 2008 14:23:40 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 18 Nov 2008 14:23:39 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id mAIMNZu6004826;
	Tue, 18 Nov 2008 14:23:35 -0800
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id mAIMNZiX004825;
	Tue, 18 Nov 2008 14:23:35 -0800
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>,
	Paul Gortmaker <Paul.Gortmaker@windriver.com>
Subject: [PATCH 05/26] MIPS: For Cavium OCTEON set hwrena and lazily restore CP2 state.
Date:	Tue, 18 Nov 2008 14:23:20 -0800
Message-Id: <1227047013-4785-5-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <49233FDE.3010404@caviumnetworks.com>
References: <49233FDE.3010404@caviumnetworks.com>
X-OriginalArrivalTime: 18 Nov 2008 22:23:39.0987 (UTC) FILETIME=[4EBC0230:01C949CC]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21315
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

If on Cavium, be aware of cop2 and hwrena during do_cpu().

Signed-off-by: Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Signed-off-by: Paul Gortmaker <Paul.Gortmaker@windriver.com>
Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/kernel/traps.c |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 3530561..f6083c6 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -47,6 +47,7 @@
 #include <asm/mmu_context.h>
 #include <asm/types.h>
 #include <asm/stacktrace.h>
+#include <asm/irq.h>
 
 extern void check_wait(void);
 extern asmlinkage void r4k_wait(void);
@@ -78,6 +79,10 @@ extern asmlinkage void handle_reserved(void);
 extern int fpu_emulator_cop1Handler(struct pt_regs *xcp,
 	struct mips_fpu_struct *ctx, int has_fpu);
 
+#ifdef CONFIG_CPU_CAVIUM_OCTEON
+extern asmlinkage void octeon_cop2_restore(struct octeon_cop2_state *task);
+#endif
+
 void (*board_be_init)(void);
 int (*board_be_handler)(struct pt_regs *regs, int is_fixup);
 void (*board_nmi_handler_setup)(void);
@@ -860,6 +865,7 @@ asmlinkage void do_cpu(struct pt_regs *regs)
 	unsigned int opcode;
 	unsigned int cpid;
 	int status;
+	unsigned long __maybe_unused flags;
 
 	die_if_kernel("do_cpu invoked from kernel context!", regs);
 
@@ -915,6 +921,17 @@ asmlinkage void do_cpu(struct pt_regs *regs)
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
@@ -1488,6 +1505,10 @@ void __cpuinit per_cpu_trap_init(void)
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
1.5.6.5
