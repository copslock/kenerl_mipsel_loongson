Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Mar 2011 12:52:05 +0100 (CET)
Received: from mx1.netlogicmicro.com ([12.49.93.86]:4776 "EHLO
        orion5.netlogicmicro.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491057Ab1CPLwC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Mar 2011 12:52:02 +0100
X-TM-IMSS-Message-ID: <248d20c100013bfe@netlogicmicro.com>
Received: from orion8.netlogicmicro.com ([10.10.16.60]) by netlogicmicro.com ([10.10.16.19]) with ESMTP (TREND IMSS SMTP Service 7.0) id 248d20c100013bfe ; Wed, 16 Mar 2011 04:51:55 -0700
Received: from jayachandranc.netlogicmicro.com ([10.7.0.77]) by orion8.netlogicmicro.com with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 16 Mar 2011 04:52:26 -0700
Date:   Wed, 16 Mar 2011 17:27:29 +0530
From:   Jayachandran C <jayachandranc@netlogicmicro.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: [PATCH 2/7] mach-netlogic include directory and files
Message-ID: <e7027edfc00221c212ea31b6545bc9683d689795.1300275485.git.jayachandranc@netlogicmicro.com>
References: <cover.1300275485.git.jayachandranc@netlogicmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1300275485.git.jayachandranc@netlogicmicro.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-OriginalArrivalTime: 16 Mar 2011 11:52:26.0790 (UTC) FILETIME=[9ED8C460:01CBE3D0]
Return-Path: <jayachandranc@netlogicmicro.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29383
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips

Add war.h and irq.h with XLR/XLS definitions.

Signed-off-by: Jayachandran C <jayachandranc@netlogicmicro.com>
---
 arch/mips/include/asm/mach-netlogic/irq.h |   14 ++++++++++++++
 arch/mips/include/asm/mach-netlogic/war.h |   26 ++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-netlogic/irq.h
 create mode 100644 arch/mips/include/asm/mach-netlogic/war.h

diff --git a/arch/mips/include/asm/mach-netlogic/irq.h b/arch/mips/include/asm/mach-netlogic/irq.h
new file mode 100644
index 0000000..b590245
--- /dev/null
+++ b/arch/mips/include/asm/mach-netlogic/irq.h
@@ -0,0 +1,14 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2011 Netlogic Microsystems.
+ */
+#ifndef __ASM_NETLOGIC_IRQ_H
+#define __ASM_NETLOGIC_IRQ_H
+
+#define NR_IRQS			64
+#define MIPS_CPU_IRQ_BASE	0
+
+#endif /* __ASM_NETLOGIC_IRQ_H */
diff --git a/arch/mips/include/asm/mach-netlogic/war.h b/arch/mips/include/asm/mach-netlogic/war.h
new file mode 100644
index 0000000..22da893
--- /dev/null
+++ b/arch/mips/include/asm/mach-netlogic/war.h
@@ -0,0 +1,26 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2011 Netlogic Microsystems.
+ * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org>
+ */
+#ifndef __ASM_MIPS_MACH_NLM_WAR_H
+#define __ASM_MIPS_MACH_NLM_WAR_H
+
+#define R4600_V1_INDEX_ICACHEOP_WAR	0
+#define R4600_V1_HIT_CACHEOP_WAR	0
+#define R4600_V2_HIT_CACHEOP_WAR	0
+#define R5432_CP0_INTERRUPT_WAR		0
+#define BCM1250_M3_WAR			0
+#define SIBYTE_1956_WAR			0
+#define MIPS4K_ICACHE_REFILL_WAR	0
+#define MIPS_CACHE_SYNC_WAR		0
+#define TX49XX_ICACHE_INDEX_INV_WAR	0
+#define RM9000_CDEX_SMP_WAR		0
+#define ICACHE_REFILLS_WORKAROUND_WAR	0
+#define R10000_LLSC_WAR			0
+#define MIPS34K_MISSED_ITLB_WAR		0
+
+#endif /* __ASM_MIPS_MACH_NLM_WAR_H */
-- 
1.7.1


-- 
Jayachandran C.
jayachandranc@netlogicmicro.com                  (Netlogic Microsystems)
jchandra@freebsd.org                               (The FreeBSD Project)
