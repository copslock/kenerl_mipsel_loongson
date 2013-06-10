Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jun 2013 09:30:02 +0200 (CEST)
Received: from mms3.broadcom.com ([216.31.210.19]:2708 "EHLO mms3.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6818702Ab3FJH3Exa6bS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 10 Jun 2013 09:29:04 +0200
Received: from [10.9.208.57] by mms3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Mon, 10 Jun 2013 00:19:52 -0700
X-Server-Uuid: B86B6450-0931-4310-942E-F00ED04CA7AF
Received: from IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Mon, 10 Jun 2013 00:28:51 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) with Microsoft SMTP
 Server id 14.1.438.0; Mon, 10 Jun 2013 00:28:51 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id C1598F2D74; Mon, 10
 Jun 2013 00:28:49 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        ddaney.cavm@gmail.com
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 5/5] MIPS: Netlogic: COP2 save/restore code
Date:   Mon, 10 Jun 2013 13:00:04 +0530
Message-ID: <1370849404-4918-6-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1370849404-4918-1-git-send-email-jchandra@broadcom.com>
References: <1370849404-4918-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7DABA1922L830675775-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36770
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
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

Add COP2 register state structure and functions for Netlogic XLP. The
RX and TX buffers and status registers are to be saved. Since the
registers are 64-bit, do the implementation in inline assembly which
works on both 32-bit and 64-bit kernels.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/include/asm/cop2.h      |   10 ++++
 arch/mips/include/asm/processor.h |   13 ++++
 arch/mips/netlogic/xlp/Makefile   |    2 +-
 arch/mips/netlogic/xlp/cop2-ex.c  |  118 +++++++++++++++++++++++++++++++++++++
 4 files changed, 142 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/netlogic/xlp/cop2-ex.c

diff --git a/arch/mips/include/asm/cop2.h b/arch/mips/include/asm/cop2.h
index b17f38e..c1516cc 100644
--- a/arch/mips/include/asm/cop2.h
+++ b/arch/mips/include/asm/cop2.h
@@ -22,6 +22,16 @@ extern void octeon_cop2_restore(struct octeon_cop2_state *);
 #define cop2_present		1
 #define cop2_lazy_restore	1
 
+#elif defined(CONFIG_CPU_XLP)
+
+extern void nlm_cop2_save(struct nlm_cop2_state *);
+extern void nlm_cop2_restore(struct nlm_cop2_state *);
+#define cop2_save(r)		nlm_cop2_save(r)
+#define cop2_restore(r)		nlm_cop2_restore(r)
+
+#define cop2_present		1
+#define cop2_lazy_restore	0
+
 #else
 
 #define cop2_present		0
diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/processor.h
index 7c637a4..016dc4b 100644
--- a/arch/mips/include/asm/processor.h
+++ b/arch/mips/include/asm/processor.h
@@ -190,6 +190,16 @@ struct octeon_cvmseg_state {
 			    [cpu_dcache_line_size() / sizeof(unsigned long)];
 };
 
+#elif defined(CONFIG_CPU_XLP)
+struct nlm_cop2_state {
+	u64	rx[4];
+	u64	tx[4];
+	u32	tx_msg_status;
+	u32	rx_msg_status;
+};
+
+#define COP2_INIT						\
+	.cp2			= {{0}, {0}, 0, 0},
 #else
 #define COP2_INIT
 #endif
@@ -237,6 +247,9 @@ struct thread_struct {
     struct octeon_cop2_state cp2 __attribute__ ((__aligned__(128)));
     struct octeon_cvmseg_state cvmseg __attribute__ ((__aligned__(128)));
 #endif
+#ifdef CONFIG_CPU_XLP
+	struct nlm_cop2_state cp2;
+#endif
 	struct mips_abi *abi;
 };
 
diff --git a/arch/mips/netlogic/xlp/Makefile b/arch/mips/netlogic/xlp/Makefile
index a84d6ed..e8dd14c 100644
--- a/arch/mips/netlogic/xlp/Makefile
+++ b/arch/mips/netlogic/xlp/Makefile
@@ -1,3 +1,3 @@
-obj-y				+= setup.o nlm_hal.o
+obj-y				+= setup.o nlm_hal.o cop2-ex.o
 obj-$(CONFIG_SMP)		+= wakeup.o
 obj-$(CONFIG_USB)		+= usb-init.o
diff --git a/arch/mips/netlogic/xlp/cop2-ex.c b/arch/mips/netlogic/xlp/cop2-ex.c
new file mode 100644
index 0000000..52bc5de
--- /dev/null
+++ b/arch/mips/netlogic/xlp/cop2-ex.c
@@ -0,0 +1,118 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2013 Broadcom Corporation.
+ *
+ * based on arch/mips/cavium-octeon/cpu.c
+ * Copyright (C) 2009 Wind River Systems,
+ *   written by Ralf Baechle <ralf@linux-mips.org>
+ */
+#include <linux/init.h>
+#include <linux/irqflags.h>
+#include <linux/notifier.h>
+#include <linux/prefetch.h>
+#include <linux/sched.h>
+
+#include <asm/cop2.h>
+#include <asm/current.h>
+#include <asm/mipsregs.h>
+#include <asm/page.h>
+
+#include <asm/netlogic/mips-extns.h>
+
+/*
+ * 64 bit ops are done in inline assembly to support 32 bit
+ * compilation
+ */
+void nlm_cop2_save(struct nlm_cop2_state *r)
+{
+	asm volatile(
+		".set	push\n"
+		".set	noat\n"
+		"dmfc2	$1, $0, 0\n"
+		"sd	$1, 0(%1)\n"
+		"dmfc2	$1, $0, 1\n"
+		"sd	$1, 8(%1)\n"
+		"dmfc2	$1, $0, 2\n"
+		"sd	$1, 16(%1)\n"
+		"dmfc2	$1, $0, 3\n"
+		"sd	$1, 24(%1)\n"
+		"dmfc2	$1, $1, 0\n"
+		"sd	$1, 0(%2)\n"
+		"dmfc2	$1, $1, 1\n"
+		"sd	$1, 8(%2)\n"
+		"dmfc2	$1, $1, 2\n"
+		"sd	$1, 16(%2)\n"
+		"dmfc2	$1, $1, 3\n"
+		"sd	$1, 24(%2)\n"
+		".set	pop\n"
+		: "=m"(*r)
+		: "r"(r->tx), "r"(r->rx));
+
+	r->tx_msg_status = __read_32bit_c2_register($2, 0);
+	r->rx_msg_status = __read_32bit_c2_register($3, 0) & 0x0fffffff;
+}
+
+void nlm_cop2_restore(struct nlm_cop2_state *r)
+{
+	u32 rstat;
+
+	asm volatile(
+		".set	push\n"
+		".set	noat\n"
+		"ld	$1, 0(%1)\n"
+		"dmtc2	$1, $0, 0\n"
+		"ld	$1, 8(%1)\n"
+		"dmtc2	$1, $0, 1\n"
+		"ld	$1, 16(%1)\n"
+		"dmtc2	$1, $0, 2\n"
+		"ld	$1, 24(%1)\n"
+		"dmtc2	$1, $0, 3\n"
+		"ld	$1, 0(%2)\n"
+		"dmtc2	$1, $1, 0\n"
+		"ld	$1, 8(%2)\n"
+		"dmtc2	$1, $1, 1\n"
+		"ld	$1, 16(%2)\n"
+		"dmtc2	$1, $1, 2\n"
+		"ld	$1, 24(%2)\n"
+		"dmtc2	$1, $1, 3\n"
+		".set	pop\n"
+		: : "m"(*r), "r"(r->tx), "r"(r->rx));
+
+	__write_32bit_c2_register($2, 0, r->tx_msg_status);
+	rstat = __read_32bit_c2_register($3, 0) & 0xf0000000u;
+	__write_32bit_c2_register($3, 0, r->rx_msg_status | rstat);
+}
+
+static int nlm_cu2_call(struct notifier_block *nfb, unsigned long action,
+	void *data)
+{
+	unsigned long flags;
+	unsigned int status;
+
+	switch (action) {
+	case CU2_EXCEPTION:
+		if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
+			break;
+		local_irq_save(flags);
+		KSTK_STATUS(current) |= ST0_CU2;
+		status = read_c0_status();
+		write_c0_status(status | ST0_CU2);
+		nlm_cop2_restore(&(current->thread.cp2));
+		write_c0_status(status & ~ST0_CU2);
+		local_irq_restore(flags);
+		pr_info("COP2 access enabled for pid %d (%s)\n",
+					current->pid, current->comm);
+		return NOTIFY_BAD;	/* Don't call default notifier */
+	}
+
+	return NOTIFY_OK;		/* Let default notifier send signals */
+}
+
+static int __init nlm_cu2_setup(void)
+{
+	return cu2_notifier(nlm_cu2_call, 0);
+}
+early_initcall(nlm_cu2_setup);
-- 
1.7.9.5
