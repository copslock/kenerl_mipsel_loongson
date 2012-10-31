Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Oct 2012 14:03:27 +0100 (CET)
Received: from mms3.broadcom.com ([216.31.210.19]:4912 "EHLO mms3.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6825878Ab2JaM65mkiOg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 31 Oct 2012 13:58:57 +0100
Received: from [10.9.200.133] by mms3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Wed, 31 Oct 2012 05:55:38 -0700
X-Server-Uuid: B86B6450-0931-4310-942E-F00ED04CA7AF
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB02.corp.ad.broadcom.com (10.9.200.133) with Microsoft SMTP
 Server id 8.2.247.2; Wed, 31 Oct 2012 05:58:15 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 4A05540FE4; Wed, 31
 Oct 2012 05:58:44 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 13/15] MIPS: Netlogic: Make number of nodes configurable
Date:   Wed, 31 Oct 2012 18:31:40 +0530
Message-ID: <28f9760316d33165c8979baa30c476cbd8201a21.1351688140.git.jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1351688140.git.jchandra@broadcom.com>
References: <cover.1351688140.git.jchandra@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7C8FC0403QG1951230-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 34809
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

There can be 1, 2 or 4 SoCs(nodes) in a multi-chip XLP board. Add an
option for multi-chip boards in case of XLP, and make the number of
nodes configurable.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/include/asm/mach-netlogic/irq.h        |    4 +-
 arch/mips/include/asm/mach-netlogic/multi-node.h |   54 ++++++++++++++++++++++
 arch/mips/include/asm/netlogic/common.h          |    9 ++--
 arch/mips/netlogic/Kconfig                       |   28 +++++++++++
 4 files changed, 90 insertions(+), 5 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-netlogic/multi-node.h

diff --git a/arch/mips/include/asm/mach-netlogic/irq.h b/arch/mips/include/asm/mach-netlogic/irq.h
index b590245..868ed8a 100644
--- a/arch/mips/include/asm/mach-netlogic/irq.h
+++ b/arch/mips/include/asm/mach-netlogic/irq.h
@@ -8,7 +8,9 @@
 #ifndef __ASM_NETLOGIC_IRQ_H
 #define __ASM_NETLOGIC_IRQ_H
 
-#define NR_IRQS			64
+#include <asm/mach-netlogic/multi-node.h>
+#define NR_IRQS			(64 * NLM_NR_NODES)
+
 #define MIPS_CPU_IRQ_BASE	0
 
 #endif /* __ASM_NETLOGIC_IRQ_H */
diff --git a/arch/mips/include/asm/mach-netlogic/multi-node.h b/arch/mips/include/asm/mach-netlogic/multi-node.h
new file mode 100644
index 0000000..d62fc77
--- /dev/null
+++ b/arch/mips/include/asm/mach-netlogic/multi-node.h
@@ -0,0 +1,54 @@
+/*
+ * Copyright (c) 2003-2012 Broadcom Corporation
+ * All Rights Reserved
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the Broadcom
+ * license below:
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ *
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in
+ *    the documentation and/or other materials provided with the
+ *    distribution.
+ *
+ * THIS SOFTWARE IS PROVIDED BY BROADCOM ``AS IS'' AND ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL BROADCOM OR CONTRIBUTORS BE LIABLE
+ * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
+ * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
+ * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
+ * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
+ * IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#ifndef _NETLOGIC_MULTI_NODE_H_
+#define _NETLOGIC_MULTI_NODE_H_
+
+#ifndef CONFIG_NLM_MULTINODE
+#define NLM_NR_NODES		1
+#else
+#if defined(CONFIG_NLM_MULTINODE_2)
+#define NLM_NR_NODES		2
+#elif defined(CONFIG_NLM_MULTINODE_4)
+#define NLM_NR_NODES		4
+#else
+#define NLM_NR_NODES		1
+#endif
+#endif
+
+#define NLM_CORES_PER_NODE	8
+#define NLM_THREADS_PER_CORE	4
+#define NLM_CPUS_PER_NODE	(NLM_CORES_PER_NODE * NLM_THREADS_PER_CORE)
+
+#endif
diff --git a/arch/mips/include/asm/netlogic/common.h b/arch/mips/include/asm/netlogic/common.h
index 2eb39fa..3c6814e 100644
--- a/arch/mips/include/asm/netlogic/common.h
+++ b/arch/mips/include/asm/netlogic/common.h
@@ -48,6 +48,7 @@
 #include <linux/cpumask.h>
 #include <linux/spinlock.h>
 #include <asm/irq.h>
+#include <asm/mach-netlogic/multi-node.h>
 
 struct irq_desc;
 void nlm_smp_function_ipi_handler(unsigned int irq, struct irq_desc *desc);
@@ -86,12 +87,12 @@ struct nlm_soc_info {
 	spinlock_t piclock;
 };
 
-#define NLM_CORES_PER_NODE	8
-#define NLM_THREADS_PER_CORE	4
-#define NLM_CPUS_PER_NODE	(NLM_CORES_PER_NODE * NLM_THREADS_PER_CORE)
 #define	nlm_get_node(i)		(&nlm_nodes[i])
-#define NLM_NR_NODES		1
+#ifdef CONFIG_CPU_XLR
 #define	nlm_current_node()	(&nlm_nodes[0])
+#else
+#define nlm_current_node()	(&nlm_nodes[nlm_nodeid()])
+#endif
 
 struct irq_data;
 uint64_t nlm_pci_irqmask(int node);
diff --git a/arch/mips/netlogic/Kconfig b/arch/mips/netlogic/Kconfig
index 8059eb7..3c05bf9 100644
--- a/arch/mips/netlogic/Kconfig
+++ b/arch/mips/netlogic/Kconfig
@@ -9,6 +9,34 @@ config DT_XLP_EVP
 	  This DTB will be used if the firmware does not pass in a DTB
           pointer to the kernel.  The corresponding DTS file is at
           arch/mips/netlogic/dts/xlp_evp.dts
+
+config NLM_MULTINODE
+	bool "Support for multi-chip boards"
+	depends on NLM_XLP_BOARD
+	default n
+	help
+	  Add support for boards with 2 or 4 XLPs connected over ICI.
+
+if NLM_MULTINODE
+choice
+	prompt "Number of XLPs on the board"
+	default NLM_MULTINODE_2
+	help
+	  In the multi-node case, specify the number of SoCs on the board.
+
+config NLM_MULTINODE_2
+	bool "Dual-XLP board"
+	help
+	  Support boards with upto two XLPs connected over ICI.
+
+config NLM_MULTINODE_4
+	bool "Quad-XLP board"
+	help
+	  Support boards with upto four XLPs connected over ICI.
+
+endchoice
+
+endif
 endif
 
 config NLM_COMMON
-- 
1.7.9.5
