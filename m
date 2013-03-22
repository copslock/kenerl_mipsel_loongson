Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Mar 2013 17:25:05 +0100 (CET)
Received: from mms3.broadcom.com ([216.31.210.19]:4096 "EHLO mms3.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823088Ab3CVQXnIt9bL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 22 Mar 2013 17:23:43 +0100
Received: from [10.9.208.57] by mms3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Fri, 22 Mar 2013 09:16:34 -0700
X-Server-Uuid: B86B6450-0931-4310-942E-F00ED04CA7AF
Received: from IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Fri, 22 Mar 2013 09:23:28 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) with Microsoft SMTP
 Server id 14.1.438.0; Fri, 22 Mar 2013 09:23:28 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id E08FC3928A; Fri, 22
 Mar 2013 09:23:26 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        ddaney.cavm@gmail.com
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 5/5] MIPS: Netlogic: COP2 save/restore code
Date:   Fri, 22 Mar 2013 21:55:02 +0530
Message-ID: <0f4ff1ad2ece49bbbc1917b4dd31031939982f02.1363966534.git.jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1363966534.git.jchandra@broadcom.com>
References: <cover.1363966534.git.jchandra@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7D525C683YC7240031-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 35943
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Add COP2 register state struct, and add functions to save and
restore COP2 at context switch.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/include/asm/cop2.h        |   10 ++++
 arch/mips/include/asm/processor.h   |   12 ++++
 arch/mips/netlogic/common/Makefile  |    1 +
 arch/mips/netlogic/common/cop2-ex.c |  113 +++++++++++++++++++++++++++++++++++
 4 files changed, 136 insertions(+)
 create mode 100644 arch/mips/netlogic/common/cop2-ex.c

diff --git a/arch/mips/include/asm/cop2.h b/arch/mips/include/asm/cop2.h
index b17f38e..39a752c 100644
--- a/arch/mips/include/asm/cop2.h
+++ b/arch/mips/include/asm/cop2.h
@@ -22,6 +22,16 @@ extern void octeon_cop2_restore(struct octeon_cop2_state *);
 #define cop2_present		1
 #define cop2_lazy_restore	1
 
+#elif defined(CONFIG_CPU_XLR) || defined(CONFIG_CPU_XLP)
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
index 131c78f..06e2f88 100644
--- a/arch/mips/include/asm/processor.h
+++ b/arch/mips/include/asm/processor.h
@@ -186,6 +186,15 @@ struct octeon_cvmseg_state {
 			    [cpu_dcache_line_size() / sizeof(unsigned long)];
 };
 
+#elif defined(CONFIG_CPU_XLR) || defined(CONFIG_CPU_XLP)
+struct nlm_cop2_state {
+	u64	rx[4];
+	u64	tx[4];
+	u32	status0;
+};
+
+#define COP2_INIT						\
+	.cp2			= {{0}, {0}, 0},
 #else
 #define COP2_INIT
 #endif
@@ -233,6 +242,9 @@ struct thread_struct {
     struct octeon_cop2_state cp2 __attribute__ ((__aligned__(128)));
     struct octeon_cvmseg_state cvmseg __attribute__ ((__aligned__(128)));
 #endif
+#if defined(CONFIG_CPU_XLR) || defined(CONFIG_CPU_XLP)
+	struct nlm_cop2_state cp2;
+#endif
 	struct mips_abi *abi;
 };
 
diff --git a/arch/mips/netlogic/common/Makefile b/arch/mips/netlogic/common/Makefile
index 291372a..fbd34d3 100644
--- a/arch/mips/netlogic/common/Makefile
+++ b/arch/mips/netlogic/common/Makefile
@@ -1,3 +1,4 @@
 obj-y				+= irq.o time.o
 obj-$(CONFIG_SMP)		+= smp.o smpboot.o
 obj-$(CONFIG_EARLY_PRINTK)	+= earlycons.o
+obj-y				+= cop2-ex.o
diff --git a/arch/mips/netlogic/common/cop2-ex.c b/arch/mips/netlogic/common/cop2-ex.c
new file mode 100644
index 0000000..73e77e5
--- /dev/null
+++ b/arch/mips/netlogic/common/cop2-ex.c
@@ -0,0 +1,113 @@
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
+#include <asm/netlogic/xlr/fmn.h>
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
+		: "r"(r->rx), "r"(r->tx));
+
+	r->status0 = nlm_read_c2_status0() & 0x3f;
+}
+
+void nlm_cop2_restore(struct nlm_cop2_state *r)
+{
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
+		: : "m"(*r), "r"(r->rx), "r"(r->tx));
+
+	nlm_write_c2_status0(r->status0);
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
