Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Aug 2008 14:58:32 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:34513 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28580951AbYHSNzZ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 19 Aug 2008 14:55:25 +0100
Received: from localhost.localdomain (p6195-ipad311funabasi.chiba.ocn.ne.jp [123.217.216.195])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id DA70AB6B9; Tue, 19 Aug 2008 22:55:20 +0900 (JST)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH 12/14] TXx9: Add board_be_init for TX4927/TX4938
Date:	Tue, 19 Aug 2008 22:55:16 +0900
Message-Id: <1219154118-21193-12-git-send-email-anemo@mba.ocn.ne.jp>
X-Mailer: git-send-email 1.5.6.3
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20268
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Setup default board_be_handler for TX4927/TX4938.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/txx9/generic/setup_tx4927.c |   23 +++++++++++++++++++++++
 arch/mips/txx9/generic/setup_tx4938.c |   23 +++++++++++++++++++++++
 2 files changed, 46 insertions(+), 0 deletions(-)

diff --git a/arch/mips/txx9/generic/setup_tx4927.c b/arch/mips/txx9/generic/setup_tx4927.c
index 7189675..c4248cb 100644
--- a/arch/mips/txx9/generic/setup_tx4927.c
+++ b/arch/mips/txx9/generic/setup_tx4927.c
@@ -14,8 +14,10 @@
 #include <linux/ioport.h>
 #include <linux/delay.h>
 #include <linux/param.h>
+#include <linux/ptrace.h>
 #include <linux/mtd/physmap.h>
 #include <asm/reboot.h>
+#include <asm/traps.h>
 #include <asm/txx9irq.h>
 #include <asm/txx9tmr.h>
 #include <asm/txx9pio.h>
@@ -60,6 +62,26 @@ static void tx4927_machine_restart(char *command)
 	(*_machine_halt)();
 }
 
+void show_registers(struct pt_regs *regs);
+static int tx4927_be_handler(struct pt_regs *regs, int is_fixup)
+{
+	int data = regs->cp0_cause & 4;
+	console_verbose();
+	pr_err("%cBE exception at %#lx\n", data ? 'D' : 'I', regs->cp0_epc);
+	pr_err("ccfg:%llx, toea:%llx\n",
+	       (unsigned long long)____raw_readq(&tx4927_ccfgptr->ccfg),
+	       (unsigned long long)____raw_readq(&tx4927_ccfgptr->toea));
+#ifdef CONFIG_PCI
+	tx4927_report_pcic_status();
+#endif
+	show_registers(regs);
+	panic("BusError!");
+}
+static void __init tx4927_be_init(void)
+{
+	board_be_handler = tx4927_be_handler;
+}
+
 static struct resource tx4927_sdram_resource[4];
 
 void __init tx4927_setup(void)
@@ -197,6 +219,7 @@ void __init tx4927_setup(void)
 	__raw_writel(0, &tx4927_pioptr->maskext);
 
 	_machine_restart = tx4927_machine_restart;
+	board_be_init = tx4927_be_init;
 }
 
 void __init tx4927_time_init(unsigned int tmrnr)
diff --git a/arch/mips/txx9/generic/setup_tx4938.c b/arch/mips/txx9/generic/setup_tx4938.c
index 4fbc85a..0d8517a 100644
--- a/arch/mips/txx9/generic/setup_tx4938.c
+++ b/arch/mips/txx9/generic/setup_tx4938.c
@@ -14,8 +14,10 @@
 #include <linux/ioport.h>
 #include <linux/delay.h>
 #include <linux/param.h>
+#include <linux/ptrace.h>
 #include <linux/mtd/physmap.h>
 #include <asm/reboot.h>
+#include <asm/traps.h>
 #include <asm/txx9irq.h>
 #include <asm/txx9tmr.h>
 #include <asm/txx9pio.h>
@@ -60,6 +62,26 @@ static void tx4938_machine_restart(char *command)
 	(*_machine_halt)();
 }
 
+void show_registers(struct pt_regs *regs);
+static int tx4938_be_handler(struct pt_regs *regs, int is_fixup)
+{
+	int data = regs->cp0_cause & 4;
+	console_verbose();
+	pr_err("%cBE exception at %#lx\n", data ? 'D' : 'I', regs->cp0_epc);
+	pr_err("ccfg:%llx, toea:%llx\n",
+	       (unsigned long long)____raw_readq(&tx4938_ccfgptr->ccfg),
+	       (unsigned long long)____raw_readq(&tx4938_ccfgptr->toea));
+#ifdef CONFIG_PCI
+	tx4927_report_pcic_status();
+#endif
+	show_registers(regs);
+	panic("BusError!");
+}
+static void __init tx4938_be_init(void)
+{
+	board_be_handler = tx4938_be_handler;
+}
+
 static struct resource tx4938_sdram_resource[4];
 static struct resource tx4938_sram_resource;
 
@@ -257,6 +279,7 @@ void __init tx4938_setup(void)
 	}
 
 	_machine_restart = tx4938_machine_restart;
+	board_be_init = tx4938_be_init;
 }
 
 void __init tx4938_time_init(unsigned int tmrnr)
-- 
1.5.6.3
