Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Oct 2013 15:18:59 +0200 (CEST)
Received: from mms1.broadcom.com ([216.31.210.17]:1245 "EHLO mms1.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6824926Ab3JNNPsubOMJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 Oct 2013 15:15:48 +0200
Received: from [10.9.208.53] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Mon, 14 Oct 2013 06:15:13 -0700
X-Server-Uuid: 06151B78-6688-425E-9DE2-57CB27892261
Received: from IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) by
 IRVEXCHCAS06.corp.ad.broadcom.com (10.9.208.53) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Mon, 14 Oct 2013 06:15:14 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) with Microsoft SMTP
 Server id 14.1.438.0; Mon, 14 Oct 2013 06:15:14 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 82519246B1; Mon, 14
 Oct 2013 06:15:11 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>, ralf@linux-mips.org
Subject: [PATCH 02/18] MIPS: Netlogic: Add topology.h for XLP family
Date:   Mon, 14 Oct 2013 18:50:58 +0530
Message-ID: <1381756874-22616-3-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1381756874-22616-1-git-send-email-jchandra@broadcom.com>
References: <1381756874-22616-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7E4531EB4FK1415136-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38330
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

Add mach-netlogic/topology.h which contains XLP cpu number to core and
node mapping.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/include/asm/mach-netlogic/multi-node.h |   19 +++++++++++++++++++
 arch/mips/include/asm/mach-netlogic/topology.h   |   20 ++++++++++++++++++++
 arch/mips/include/asm/netlogic/common.h          |   18 ------------------
 3 files changed, 39 insertions(+), 18 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-netlogic/topology.h

diff --git a/arch/mips/include/asm/mach-netlogic/multi-node.h b/arch/mips/include/asm/mach-netlogic/multi-node.h
index d62fc77..b3d91e0 100644
--- a/arch/mips/include/asm/mach-netlogic/multi-node.h
+++ b/arch/mips/include/asm/mach-netlogic/multi-node.h
@@ -51,4 +51,23 @@
 #define NLM_THREADS_PER_CORE	4
 #define NLM_CPUS_PER_NODE	(NLM_CORES_PER_NODE * NLM_THREADS_PER_CORE)
 
+struct nlm_soc_info {
+	unsigned long	coremask;	/* cores enabled on the soc */
+	unsigned long	ebase;		/* not used now */
+	uint64_t	irqmask;	/* EIMR for the node */
+	uint64_t	sysbase;	/* only for XLP - sys block base */
+	uint64_t	picbase;	/* PIC block base */
+	spinlock_t	piclock;	/* lock for PIC access */
+	cpumask_t	cpumask;	/* logical cpu mask for node */
+};
+
+extern struct nlm_soc_info nlm_nodes[NLM_NR_NODES];
+#define nlm_get_node(i)		(&nlm_nodes[i])
+#ifdef CONFIG_CPU_XLR
+#define nlm_current_node()	(&nlm_nodes[0])
+#else
+#define nlm_current_node()	(&nlm_nodes[nlm_nodeid()])
+#endif
+void nlm_node_init(int node);
+
 #endif
diff --git a/arch/mips/include/asm/mach-netlogic/topology.h b/arch/mips/include/asm/mach-netlogic/topology.h
new file mode 100644
index 0000000..0da99fa
--- /dev/null
+++ b/arch/mips/include/asm/mach-netlogic/topology.h
@@ -0,0 +1,20 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2013 Broadcom Corporation
+ */
+#ifndef _ASM_MACH_NETLOGIC_TOPOLOGY_H
+#define _ASM_MACH_NETLOGIC_TOPOLOGY_H
+
+#include <asm/mach-netlogic/multi-node.h>
+
+#define topology_physical_package_id(cpu)	cpu_to_node(cpu)
+#define topology_core_id(cpu)	(cpu_logical_map(cpu) / NLM_THREADS_PER_CORE)
+#define topology_thread_cpumask(cpu)		(&cpu_sibling_map[cpu])
+#define topology_core_cpumask(cpu)	cpumask_of_node(cpu_to_node(cpu))
+
+#include <asm-generic/topology.h>
+
+#endif /* _ASM_MACH_NETLOGIC_TOPOLOGY_H */
diff --git a/arch/mips/include/asm/netlogic/common.h b/arch/mips/include/asm/netlogic/common.h
index e6339d0..c281f03 100644
--- a/arch/mips/include/asm/netlogic/common.h
+++ b/arch/mips/include/asm/netlogic/common.h
@@ -84,7 +84,6 @@ nlm_set_nmi_handler(void *handler)
  */
 void nlm_init_boot_cpu(void);
 unsigned int nlm_get_cpu_frequency(void);
-void nlm_node_init(int node);
 extern struct plat_smp_ops nlm_smp_ops;
 extern char nlm_reset_entry[], nlm_reset_entry_end[];
 
@@ -94,22 +93,6 @@ extern struct dma_map_ops nlm_swiotlb_dma_ops;
 extern unsigned int nlm_threads_per_core;
 extern cpumask_t nlm_cpumask;
 
-struct nlm_soc_info {
-	unsigned long coremask; /* cores enabled on the soc */
-	unsigned long ebase;
-	uint64_t irqmask;
-	uint64_t sysbase;	/* only for XLP */
-	uint64_t picbase;
-	spinlock_t piclock;
-};
-
-#define nlm_get_node(i)		(&nlm_nodes[i])
-#ifdef CONFIG_CPU_XLR
-#define nlm_current_node()	(&nlm_nodes[0])
-#else
-#define nlm_current_node()	(&nlm_nodes[nlm_nodeid()])
-#endif
-
 struct irq_data;
 uint64_t nlm_pci_irqmask(int node);
 void nlm_setup_pic_irq(int node, int picirq, int irq, int irt);
@@ -128,7 +111,6 @@ static inline int nlm_irq_to_xirq(int node, int irq)
 	return node * NR_IRQS / NLM_NR_NODES + irq;
 }
 
-extern struct nlm_soc_info nlm_nodes[NLM_NR_NODES];
 extern int nlm_cpu_ready[];
 #endif
 #endif /* _NETLOGIC_COMMON_H_ */
-- 
1.7.9.5
