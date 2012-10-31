Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Oct 2012 14:02:48 +0100 (CET)
Received: from mms2.broadcom.com ([216.31.210.18]:2714 "EHLO mms2.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6825755Ab2JaM6zuNARl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 31 Oct 2012 13:58:55 +0100
Received: from [10.9.200.133] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Wed, 31 Oct 2012 05:57:01 -0700
X-Server-Uuid: 4500596E-606A-40F9-852D-14843D8201B2
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB02.corp.ad.broadcom.com (10.9.200.133) with Microsoft SMTP
 Server id 8.2.247.2; Wed, 31 Oct 2012 05:58:19 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 8772740FE3; Wed, 31
 Oct 2012 05:58:47 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Ganesan Ramalingam" <ganesanr@broadcom.com>,
        "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 15/15] MIPS: Netlogic: Support for XLR/XLS Fast Message
 Network
Date:   Wed, 31 Oct 2012 18:31:42 +0530
Message-ID: <2f1cd3e30b5a5cdfcd00ed0700041804c28631bb.1351688140.git.jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1351688140.git.jchandra@broadcom.com>
References: <cover.1351688140.git.jchandra@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7C8FFF973QC1968480-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 34807
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

From: Ganesan Ramalingam <ganesanr@broadcom.com>

On XLR/XLS, the cpu cores communicate with fast on-chip devices
(e.g. network accelerator, security engine etc.) using the Fast
Messaging Network(FMN). The FMN queues and credits needs to be
configured and intialized before it can be used.

The co-processor 2 on XLR/XLS CPU cores has registers for FMN access,
and the XLR/XLS has custom instructions for sending and loading
messages.  The FMN can deliver also per-cpu interrupts when messages
are available at the CPU.

This patch adds FMN initialization, adds interrupt setup and handling,
and also provides support for sending and receiving FMN messages.

Signed-off-by: Ganesan Ramalingam <ganesanr@broadcom.com>
Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/include/asm/netlogic/common.h     |    1 +
 arch/mips/include/asm/netlogic/interrupt.h  |    2 +-
 arch/mips/include/asm/netlogic/mips-extns.h |  137 ++++++++++
 arch/mips/include/asm/netlogic/xlr/fmn.h    |  363 +++++++++++++++++++++++++++
 arch/mips/include/asm/netlogic/xlr/xlr.h    |    6 +-
 arch/mips/netlogic/common/irq.c             |    8 +-
 arch/mips/netlogic/common/smp.c             |    4 +-
 arch/mips/netlogic/xlp/setup.c              |    4 +
 arch/mips/netlogic/xlr/Makefile             |    4 +-
 arch/mips/netlogic/xlr/fmn-config.c         |  290 +++++++++++++++++++++
 arch/mips/netlogic/xlr/fmn.c                |  204 +++++++++++++++
 arch/mips/netlogic/xlr/setup.c              |    9 +
 12 files changed, 1020 insertions(+), 12 deletions(-)
 create mode 100644 arch/mips/include/asm/netlogic/xlr/fmn.h
 create mode 100644 arch/mips/netlogic/xlr/fmn-config.c
 create mode 100644 arch/mips/netlogic/xlr/fmn.c

diff --git a/arch/mips/include/asm/netlogic/common.h b/arch/mips/include/asm/netlogic/common.h
index 1fee7ef..42bfd5f 100644
--- a/arch/mips/include/asm/netlogic/common.h
+++ b/arch/mips/include/asm/netlogic/common.h
@@ -57,6 +57,7 @@ void nlm_smp_irq_init(int hwcpuid);
 void nlm_boot_secondary_cpus(void);
 int nlm_wakeup_secondary_cpus(void);
 void nlm_rmiboot_preboot(void);
+void nlm_percpu_init(int hwcpuid);
 
 static inline void
 nlm_set_nmi_handler(void *handler)
diff --git a/arch/mips/include/asm/netlogic/interrupt.h b/arch/mips/include/asm/netlogic/interrupt.h
index a85aadb..ed5993d 100644
--- a/arch/mips/include/asm/netlogic/interrupt.h
+++ b/arch/mips/include/asm/netlogic/interrupt.h
@@ -39,7 +39,7 @@
 
 #define IRQ_IPI_SMP_FUNCTION	3
 #define IRQ_IPI_SMP_RESCHEDULE	4
-#define IRQ_MSGRING		6
+#define IRQ_FMN			5
 #define IRQ_TIMER		7
 
 #endif
diff --git a/arch/mips/include/asm/netlogic/mips-extns.h b/arch/mips/include/asm/netlogic/mips-extns.h
index c9f6de5..32ba6d9 100644
--- a/arch/mips/include/asm/netlogic/mips-extns.h
+++ b/arch/mips/include/asm/netlogic/mips-extns.h
@@ -78,4 +78,141 @@ static inline int nlm_nodeid(void)
 	return (__read_32bit_c0_register($15, 1) >> 5) & 0x3;
 }
 
+static inline unsigned int nlm_core_id(void)
+{
+	return (read_c0_ebase() & 0x1c) >> 2;
+}
+
+static inline unsigned int nlm_thread_id(void)
+{
+	return read_c0_ebase() & 0x3;
+}
+
+#define __read_64bit_c2_split(source, sel)				\
+({									\
+	unsigned long long __val;					\
+	unsigned long __flags;						\
+									\
+	local_irq_save(__flags);					\
+	if (sel == 0)							\
+		__asm__ __volatile__(					\
+			".set\tmips64\n\t"				\
+			"dmfc2\t%M0, " #source "\n\t"			\
+			"dsll\t%L0, %M0, 32\n\t"			\
+			"dsra\t%M0, %M0, 32\n\t"			\
+			"dsra\t%L0, %L0, 32\n\t"			\
+			".set\tmips0\n\t"				\
+			: "=r" (__val));				\
+	else								\
+		__asm__ __volatile__(					\
+			".set\tmips64\n\t"				\
+			"dmfc2\t%M0, " #source ", " #sel "\n\t"		\
+			"dsll\t%L0, %M0, 32\n\t"			\
+			"dsra\t%M0, %M0, 32\n\t"			\
+			"dsra\t%L0, %L0, 32\n\t"			\
+			".set\tmips0\n\t"				\
+			: "=r" (__val));				\
+	local_irq_restore(__flags);					\
+									\
+	__val;								\
+})
+
+#define __write_64bit_c2_split(source, sel, val)			\
+do {									\
+	unsigned long __flags;						\
+									\
+	local_irq_save(__flags);					\
+	if (sel == 0)							\
+		__asm__ __volatile__(					\
+			".set\tmips64\n\t"				\
+			"dsll\t%L0, %L0, 32\n\t"			\
+			"dsrl\t%L0, %L0, 32\n\t"			\
+			"dsll\t%M0, %M0, 32\n\t"			\
+			"or\t%L0, %L0, %M0\n\t"				\
+			"dmtc2\t%L0, " #source "\n\t"			\
+			".set\tmips0\n\t"				\
+			: : "r" (val));					\
+	else								\
+		__asm__ __volatile__(					\
+			".set\tmips64\n\t"				\
+			"dsll\t%L0, %L0, 32\n\t"			\
+			"dsrl\t%L0, %L0, 32\n\t"			\
+			"dsll\t%M0, %M0, 32\n\t"			\
+			"or\t%L0, %L0, %M0\n\t"				\
+			"dmtc2\t%L0, " #source ", " #sel "\n\t"		\
+			".set\tmips0\n\t"				\
+			: : "r" (val));					\
+	local_irq_restore(__flags);					\
+} while (0)
+
+#define __read_32bit_c2_register(source, sel)				\
+({ uint32_t __res;							\
+	if (sel == 0)							\
+		__asm__ __volatile__(					\
+			".set\tmips32\n\t"				\
+			"mfc2\t%0, " #source "\n\t"			\
+			".set\tmips0\n\t"				\
+			: "=r" (__res));				\
+	else								\
+		__asm__ __volatile__(					\
+			".set\tmips32\n\t"				\
+			"mfc2\t%0, " #source ", " #sel "\n\t"		\
+			".set\tmips0\n\t"				\
+			: "=r" (__res));				\
+	__res;								\
+})
+
+#define __read_64bit_c2_register(source, sel)				\
+({ unsigned long long __res;						\
+	if (sizeof(unsigned long) == 4)					\
+		__res = __read_64bit_c2_split(source, sel);		\
+	else if (sel == 0)						\
+		__asm__ __volatile__(					\
+			".set\tmips64\n\t"				\
+			"dmfc2\t%0, " #source "\n\t"			\
+			".set\tmips0\n\t"				\
+			: "=r" (__res));				\
+	else								\
+		__asm__ __volatile__(					\
+			".set\tmips64\n\t"				\
+			"dmfc2\t%0, " #source ", " #sel "\n\t"		\
+			".set\tmips0\n\t"				\
+			: "=r" (__res));				\
+	__res;								\
+})
+
+#define __write_64bit_c2_register(register, sel, value)			\
+do {									\
+	if (sizeof(unsigned long) == 4)					\
+		__write_64bit_c2_split(register, sel, value);		\
+	else if (sel == 0)						\
+		__asm__ __volatile__(					\
+			".set\tmips64\n\t"				\
+			"dmtc2\t%z0, " #register "\n\t"			\
+			".set\tmips0\n\t"				\
+			: : "Jr" (value));				\
+	else								\
+		__asm__ __volatile__(					\
+			".set\tmips64\n\t"				\
+			"dmtc2\t%z0, " #register ", " #sel "\n\t"	\
+			".set\tmips0\n\t"				\
+			: : "Jr" (value));				\
+} while (0)
+
+#define __write_32bit_c2_register(reg, sel, value)			\
+({									\
+	if (sel == 0)							\
+		__asm__ __volatile__(					\
+			".set\tmips32\n\t"				\
+			"mtc2\t%z0, " #reg "\n\t"			\
+			".set\tmips0\n\t"				\
+			: : "Jr" (value));				\
+	else								\
+		__asm__ __volatile__(                                   \
+			".set\tmips32\n\t"				\
+			"mtc2\t%z0, " #reg ", " #sel "\n\t"		\
+			".set\tmips0\n\t"				\
+			: : "Jr" (value));				\
+})
+
 #endif /*_ASM_NLM_MIPS_EXTS_H */
diff --git a/arch/mips/include/asm/netlogic/xlr/fmn.h b/arch/mips/include/asm/netlogic/xlr/fmn.h
new file mode 100644
index 0000000..68d5167
--- /dev/null
+++ b/arch/mips/include/asm/netlogic/xlr/fmn.h
@@ -0,0 +1,363 @@
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
+#ifndef _NLM_FMN_H_
+#define _NLM_FMN_H_
+
+#include <asm/netlogic/mips-extns.h> /* for COP2 access */
+
+/* Station IDs */
+#define	FMN_STNID_CPU0			0x00
+#define	FMN_STNID_CPU1			0x08
+#define	FMN_STNID_CPU2			0x10
+#define	FMN_STNID_CPU3			0x18
+#define	FMN_STNID_CPU4			0x20
+#define	FMN_STNID_CPU5			0x28
+#define	FMN_STNID_CPU6			0x30
+#define	FMN_STNID_CPU7			0x38
+
+#define	FMN_STNID_XGS0_TX		64
+#define	FMN_STNID_XMAC0_00_TX		64
+#define	FMN_STNID_XMAC0_01_TX		65
+#define	FMN_STNID_XMAC0_02_TX		66
+#define	FMN_STNID_XMAC0_03_TX		67
+#define	FMN_STNID_XMAC0_04_TX		68
+#define	FMN_STNID_XMAC0_05_TX		69
+#define	FMN_STNID_XMAC0_06_TX		70
+#define	FMN_STNID_XMAC0_07_TX		71
+#define	FMN_STNID_XMAC0_08_TX		72
+#define	FMN_STNID_XMAC0_09_TX		73
+#define	FMN_STNID_XMAC0_10_TX		74
+#define	FMN_STNID_XMAC0_11_TX		75
+#define	FMN_STNID_XMAC0_12_TX		76
+#define	FMN_STNID_XMAC0_13_TX		77
+#define	FMN_STNID_XMAC0_14_TX		78
+#define	FMN_STNID_XMAC0_15_TX		79
+
+#define	FMN_STNID_XGS1_TX		80
+#define	FMN_STNID_XMAC1_00_TX		80
+#define	FMN_STNID_XMAC1_01_TX		81
+#define	FMN_STNID_XMAC1_02_TX		82
+#define	FMN_STNID_XMAC1_03_TX		83
+#define	FMN_STNID_XMAC1_04_TX		84
+#define	FMN_STNID_XMAC1_05_TX		85
+#define	FMN_STNID_XMAC1_06_TX		86
+#define	FMN_STNID_XMAC1_07_TX		87
+#define	FMN_STNID_XMAC1_08_TX		88
+#define	FMN_STNID_XMAC1_09_TX		89
+#define	FMN_STNID_XMAC1_10_TX		90
+#define	FMN_STNID_XMAC1_11_TX		91
+#define	FMN_STNID_XMAC1_12_TX		92
+#define	FMN_STNID_XMAC1_13_TX		93
+#define	FMN_STNID_XMAC1_14_TX		94
+#define	FMN_STNID_XMAC1_15_TX		95
+
+#define	FMN_STNID_GMAC			96
+#define	FMN_STNID_GMACJFR_0		96
+#define	FMN_STNID_GMACRFR_0		97
+#define	FMN_STNID_GMACTX0		98
+#define	FMN_STNID_GMACTX1		99
+#define	FMN_STNID_GMACTX2		100
+#define	FMN_STNID_GMACTX3		101
+#define	FMN_STNID_GMACJFR_1		102
+#define	FMN_STNID_GMACRFR_1		103
+
+#define	FMN_STNID_DMA			104
+#define	FMN_STNID_DMA_0			104
+#define	FMN_STNID_DMA_1			105
+#define	FMN_STNID_DMA_2			106
+#define	FMN_STNID_DMA_3			107
+
+#define	FMN_STNID_XGS0FR		112
+#define	FMN_STNID_XMAC0JFR		112
+#define	FMN_STNID_XMAC0RFR		113
+
+#define	FMN_STNID_XGS1FR		114
+#define	FMN_STNID_XMAC1JFR		114
+#define	FMN_STNID_XMAC1RFR		115
+#define	FMN_STNID_SEC			120
+#define	FMN_STNID_SEC0			120
+#define	FMN_STNID_SEC1			121
+#define	FMN_STNID_SEC2			122
+#define	FMN_STNID_SEC3			123
+#define	FMN_STNID_PK0			124
+#define	FMN_STNID_SEC_RSA		124
+#define	FMN_STNID_SEC_RSVD0		125
+#define	FMN_STNID_SEC_RSVD1		126
+#define	FMN_STNID_SEC_RSVD2		127
+
+#define	FMN_STNID_GMAC1			80
+#define	FMN_STNID_GMAC1_FR_0		81
+#define	FMN_STNID_GMAC1_TX0		82
+#define	FMN_STNID_GMAC1_TX1		83
+#define	FMN_STNID_GMAC1_TX2		84
+#define	FMN_STNID_GMAC1_TX3		85
+#define	FMN_STNID_GMAC1_FR_1		87
+#define	FMN_STNID_GMAC0			96
+#define	FMN_STNID_GMAC0_FR_0		97
+#define	FMN_STNID_GMAC0_TX0		98
+#define	FMN_STNID_GMAC0_TX1		99
+#define	FMN_STNID_GMAC0_TX2		100
+#define	FMN_STNID_GMAC0_TX3		101
+#define	FMN_STNID_GMAC0_FR_1		103
+#define	FMN_STNID_CMP_0			108
+#define	FMN_STNID_CMP_1			109
+#define	FMN_STNID_CMP_2			110
+#define	FMN_STNID_CMP_3			111
+#define	FMN_STNID_PCIE_0		116
+#define	FMN_STNID_PCIE_1		117
+#define	FMN_STNID_PCIE_2		118
+#define	FMN_STNID_PCIE_3		119
+#define	FMN_STNID_XLS_PK0		121
+
+#define nlm_read_c2_cc0(s)		__read_32bit_c2_register($16, s)
+#define nlm_read_c2_cc1(s)		__read_32bit_c2_register($17, s)
+#define nlm_read_c2_cc2(s)		__read_32bit_c2_register($18, s)
+#define nlm_read_c2_cc3(s)		__read_32bit_c2_register($19, s)
+#define nlm_read_c2_cc4(s)		__read_32bit_c2_register($20, s)
+#define nlm_read_c2_cc5(s)		__read_32bit_c2_register($21, s)
+#define nlm_read_c2_cc6(s)		__read_32bit_c2_register($22, s)
+#define nlm_read_c2_cc7(s)		__read_32bit_c2_register($23, s)
+#define nlm_read_c2_cc8(s)		__read_32bit_c2_register($24, s)
+#define nlm_read_c2_cc9(s)		__read_32bit_c2_register($25, s)
+#define nlm_read_c2_cc10(s)		__read_32bit_c2_register($26, s)
+#define nlm_read_c2_cc11(s)		__read_32bit_c2_register($27, s)
+#define nlm_read_c2_cc12(s)		__read_32bit_c2_register($28, s)
+#define nlm_read_c2_cc13(s)		__read_32bit_c2_register($29, s)
+#define nlm_read_c2_cc14(s)		__read_32bit_c2_register($30, s)
+#define nlm_read_c2_cc15(s)		__read_32bit_c2_register($31, s)
+
+#define nlm_write_c2_cc0(s, v)		__write_32bit_c2_register($16, s, v)
+#define nlm_write_c2_cc1(s, v)		__write_32bit_c2_register($17, s, v)
+#define nlm_write_c2_cc2(s, v)		__write_32bit_c2_register($18, s, v)
+#define nlm_write_c2_cc3(s, v)		__write_32bit_c2_register($19, s, v)
+#define nlm_write_c2_cc4(s, v)		__write_32bit_c2_register($20, s, v)
+#define nlm_write_c2_cc5(s, v)		__write_32bit_c2_register($21, s, v)
+#define nlm_write_c2_cc6(s, v)		__write_32bit_c2_register($22, s, v)
+#define nlm_write_c2_cc7(s, v)		__write_32bit_c2_register($23, s, v)
+#define nlm_write_c2_cc8(s, v)		__write_32bit_c2_register($24, s, v)
+#define nlm_write_c2_cc9(s, v)		__write_32bit_c2_register($25, s, v)
+#define nlm_write_c2_cc10(s, v)		__write_32bit_c2_register($26, s, v)
+#define nlm_write_c2_cc11(s, v)		__write_32bit_c2_register($27, s, v)
+#define nlm_write_c2_cc12(s, v)		__write_32bit_c2_register($28, s, v)
+#define nlm_write_c2_cc13(s, v)		__write_32bit_c2_register($29, s, v)
+#define nlm_write_c2_cc14(s, v)		__write_32bit_c2_register($30, s, v)
+#define nlm_write_c2_cc15(s, v)		__write_32bit_c2_register($31, s, v)
+
+#define	nlm_read_c2_status(sel)		__read_32bit_c2_register($2, 0)
+#define	nlm_read_c2_config()		__read_32bit_c2_register($3, 0)
+#define	nlm_write_c2_config(v)		__write_32bit_c2_register($3, 0, v)
+#define	nlm_read_c2_bucksize(b)		__read_32bit_c2_register($4, b)
+#define	nlm_write_c2_bucksize(b, v)	__write_32bit_c2_register($4, b, v)
+
+#define	nlm_read_c2_rx_msg0()		__read_64bit_c2_register($1, 0)
+#define	nlm_read_c2_rx_msg1()		__read_64bit_c2_register($1, 1)
+#define	nlm_read_c2_rx_msg2()		__read_64bit_c2_register($1, 2)
+#define	nlm_read_c2_rx_msg3()		__read_64bit_c2_register($1, 3)
+
+#define	nlm_write_c2_tx_msg0(v)		__write_64bit_c2_register($0, 0, v)
+#define	nlm_write_c2_tx_msg1(v)		__write_64bit_c2_register($0, 1, v)
+#define	nlm_write_c2_tx_msg2(v)		__write_64bit_c2_register($0, 2, v)
+#define	nlm_write_c2_tx_msg3(v)		__write_64bit_c2_register($0, 3, v)
+
+#define	FMN_STN_RX_QSIZE		256
+#define	FMN_NSTATIONS			128
+#define	FMN_CORE_NBUCKETS		8
+
+static inline void nlm_msgsnd(unsigned int stid)
+{
+	__asm__ volatile (
+	    ".set	push\n"
+	    ".set	noreorder\n"
+	    ".set	noat\n"
+	    "move	$1, %0\n"
+	    "c2		0x10001\n"	/* msgsnd $1 */
+	    ".set	pop\n"
+	    : : "r" (stid) : "$1"
+	);
+}
+
+static inline void nlm_msgld(unsigned int pri)
+{
+	__asm__ volatile (
+	    ".set	push\n"
+	    ".set	noreorder\n"
+	    ".set	noat\n"
+	    "move	$1, %0\n"
+	    "c2		0x10002\n"    /* msgld $1 */
+	    ".set	pop\n"
+	    : : "r" (pri) : "$1"
+	);
+}
+
+static inline void nlm_msgwait(unsigned int mask)
+{
+	__asm__ volatile (
+	    ".set	push\n"
+	    ".set	noreorder\n"
+	    ".set	noat\n"
+	    "move	$8, %0\n"
+	    "c2		0x10003\n"    /* msgwait $1 */
+	    ".set	pop\n"
+	    : : "r" (mask) : "$1"
+	);
+}
+
+/*
+ * Disable interrupts and enable COP2 access
+ */
+static inline uint32_t nlm_cop2_enable(void)
+{
+	uint32_t sr = read_c0_status();
+
+	write_c0_status((sr & ~ST0_IE) | ST0_CU2);
+	return sr;
+}
+
+static inline void nlm_cop2_restore(uint32_t sr)
+{
+	write_c0_status(sr);
+}
+
+static inline void nlm_fmn_setup_intr(int irq, unsigned int tmask)
+{
+	uint32_t config;
+
+	config = (1 << 24)	/* interrupt water mark - 1 msg */
+		| (irq << 16)	/* irq */
+		| (tmask << 8)	/* thread mask */
+		| 0x2;		/* enable watermark intr, disable empty intr */
+	nlm_write_c2_config(config);
+}
+
+struct nlm_fmn_msg {
+	uint64_t msg0;
+	uint64_t msg1;
+	uint64_t msg2;
+	uint64_t msg3;
+};
+
+static inline int nlm_fmn_send(unsigned int size, unsigned int code,
+		unsigned int stid, struct nlm_fmn_msg *msg)
+{
+	unsigned int dest;
+	uint32_t status;
+	int i;
+
+	/*
+	 * Make sure that all the writes pending at the cpu are flushed.
+	 * Any writes pending on CPU will not be see by devices. L1/L2
+	 * caches are coherent with IO, so no cache flush needed.
+	 */
+	__asm __volatile("sync");
+
+	/* Load TX message buffers */
+	nlm_write_c2_tx_msg0(msg->msg0);
+	nlm_write_c2_tx_msg1(msg->msg1);
+	nlm_write_c2_tx_msg2(msg->msg2);
+	nlm_write_c2_tx_msg3(msg->msg3);
+	dest = ((size - 1) << 16) | (code << 8) | stid;
+
+	/*
+	 * Retry a few times on credit fail, this should be a
+	 * transient condition, unless there is a configuration
+	 * failure, or the receiver is stuck.
+	 */
+	for (i = 0; i < 8; i++) {
+		nlm_msgsnd(dest);
+		status = nlm_read_c2_status(0);
+		if ((status & 0x2) == 1)
+			pr_info("Send pending fail!\n");
+		if ((status & 0x4) == 0)
+			return 0;
+	}
+
+	/* If there is a credit failure, return error */
+	return status & 0x06;
+}
+
+static inline int nlm_fmn_receive(int bucket, int *size, int *code, int *stid,
+		struct nlm_fmn_msg *msg)
+{
+	uint32_t status, tmp;
+
+	nlm_msgld(bucket);
+
+	/* wait for load pending to clear */
+	do {
+		status = nlm_read_c2_status(1);
+	} while ((status & 0x08) != 0);
+
+	/* receive error bits */
+	tmp = status & 0x30;
+	if (tmp != 0)
+		return tmp;
+
+	*size = ((status & 0xc0) >> 6) + 1;
+	*code = (status & 0xff00) >> 8;
+	*stid = (status & 0x7f0000) >> 16;
+	msg->msg0 = nlm_read_c2_rx_msg0();
+	msg->msg1 = nlm_read_c2_rx_msg1();
+	msg->msg2 = nlm_read_c2_rx_msg2();
+	msg->msg3 = nlm_read_c2_rx_msg3();
+
+	return 0;
+}
+
+struct xlr_fmn_info {
+	int num_buckets;
+	int start_stn_id;
+	int end_stn_id;
+	int credit_config[128];
+};
+
+struct xlr_board_fmn_config {
+	int bucket_size[128];		/* size of buckets for all stations */
+	struct xlr_fmn_info cpu[8];
+	struct xlr_fmn_info gmac[2];
+	struct xlr_fmn_info dma;
+	struct xlr_fmn_info cmp;
+	struct xlr_fmn_info sae;
+	struct xlr_fmn_info xgmac[2];
+};
+
+extern int nlm_register_fmn_handler(int start, int end,
+	void (*fn)(int, int, int, int, struct nlm_fmn_msg *, void *),
+	void *arg);
+extern void xlr_percpu_fmn_init(void);
+extern void nlm_setup_fmn_irq(void);
+extern void xlr_board_info_setup(void);
+
+extern struct xlr_board_fmn_config xlr_board_fmn_config;
+#endif
diff --git a/arch/mips/include/asm/netlogic/xlr/xlr.h b/arch/mips/include/asm/netlogic/xlr/xlr.h
index ff4a17b..c1667e0 100644
--- a/arch/mips/include/asm/netlogic/xlr/xlr.h
+++ b/arch/mips/include/asm/netlogic/xlr/xlr.h
@@ -51,10 +51,8 @@ static inline unsigned int nlm_chip_is_xls_b(void)
 	return ((prid & 0xf000) == 0x4000);
 }
 
-/*
- *  XLR chip types
- */
- /* The XLS product line has chip versions 0x[48c]? */
+/*  XLR chip types */
+/* The XLS product line has chip versions 0x[48c]? */
 static inline unsigned int nlm_chip_is_xls(void)
 {
 	uint32_t prid = read_c0_prid();
diff --git a/arch/mips/netlogic/common/irq.c b/arch/mips/netlogic/common/irq.c
index b89d5a6..00dcc7a 100644
--- a/arch/mips/netlogic/common/irq.c
+++ b/arch/mips/netlogic/common/irq.c
@@ -58,6 +58,7 @@
 #elif defined(CONFIG_CPU_XLR)
 #include <asm/netlogic/xlr/iomap.h>
 #include <asm/netlogic/xlr/pic.h>
+#include <asm/netlogic/xlr/fmn.h>
 #else
 #error "Unknown CPU"
 #endif
@@ -68,8 +69,8 @@
 #else
 #define SMP_IRQ_MASK	0
 #endif
-#define PERCPU_IRQ_MASK	(SMP_IRQ_MASK | (1ull << IRQ_TIMER))
-
+#define PERCPU_IRQ_MASK	(SMP_IRQ_MASK | (1ull << IRQ_TIMER) | \
+				(1ull << IRQ_FMN))
 
 struct nlm_pic_irq {
 	void	(*extra_ack)(struct irq_data *);
@@ -241,6 +242,9 @@ void __init arch_init_irq(void)
 	nlm_init_percpu_irqs();
 	nlm_init_node_irqs(0);
 	write_c0_eimr(nlm_current_node()->irqmask);
+#if defined(CONFIG_CPU_XLR)
+	nlm_setup_fmn_irq();
+#endif
 }
 
 void nlm_smp_irq_init(int hwcpuid)
diff --git a/arch/mips/netlogic/common/smp.c b/arch/mips/netlogic/common/smp.c
index 0315b29..a080d9e 100644
--- a/arch/mips/netlogic/common/smp.c
+++ b/arch/mips/netlogic/common/smp.c
@@ -118,6 +118,7 @@ static void __cpuinit nlm_init_secondary(void)
 
 	hwtid = hard_smp_processor_id();
 	current_cpu_data.core = hwtid / NLM_THREADS_PER_CORE;
+	nlm_percpu_init(hwtid);
 	nlm_smp_irq_init(hwtid);
 }
 
@@ -129,9 +130,6 @@ void nlm_prepare_cpus(unsigned int max_cpus)
 
 void nlm_smp_finish(void)
 {
-#ifdef notyet
-	nlm_common_msgring_cpu_init();
-#endif
 	local_irq_enable();
 }
 
diff --git a/arch/mips/netlogic/xlp/setup.c b/arch/mips/netlogic/xlp/setup.c
index 465b8d6..4894d62 100644
--- a/arch/mips/netlogic/xlp/setup.c
+++ b/arch/mips/netlogic/xlp/setup.c
@@ -108,6 +108,10 @@ void xlp_mmu_init(void)
 		(13 + (ffz(PM_DEFAULT_MASK >> 13) / 2)));
 }
 
+void nlm_percpu_init(int hwcpuid)
+{
+}
+
 void __init prom_init(void)
 {
 	nlm_io_base = CKSEG1ADDR(XLP_DEFAULT_IO_BASE);
diff --git a/arch/mips/netlogic/xlr/Makefile b/arch/mips/netlogic/xlr/Makefile
index c287dea..05902bc 100644
--- a/arch/mips/netlogic/xlr/Makefile
+++ b/arch/mips/netlogic/xlr/Makefile
@@ -1,2 +1,2 @@
-obj-y				+= setup.o platform.o platform-flash.o
-obj-$(CONFIG_SMP)		+= wakeup.o
+obj-y			+=  fmn.o fmn-config.o setup.o platform.o platform-flash.o
+obj-$(CONFIG_SMP)	+= wakeup.o
diff --git a/arch/mips/netlogic/xlr/fmn-config.c b/arch/mips/netlogic/xlr/fmn-config.c
new file mode 100644
index 0000000..bed2cff
--- /dev/null
+++ b/arch/mips/netlogic/xlr/fmn-config.c
@@ -0,0 +1,290 @@
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
+#include <asm/cpu-info.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+
+#include <asm/mipsregs.h>
+#include <asm/netlogic/xlr/fmn.h>
+#include <asm/netlogic/xlr/xlr.h>
+#include <asm/netlogic/common.h>
+#include <asm/netlogic/haldefs.h>
+
+struct xlr_board_fmn_config xlr_board_fmn_config;
+
+static void __maybe_unused print_credit_config(struct xlr_fmn_info *fmn_info)
+{
+	int bkt;
+
+	pr_info("Bucket size :\n");
+	pr_info("Station\t: Size\n");
+	for (bkt = 0; bkt < 16; bkt++)
+		pr_info(" %d  %d  %d  %d  %d  %d  %d %d\n",
+			xlr_board_fmn_config.bucket_size[(bkt * 8) + 0],
+			xlr_board_fmn_config.bucket_size[(bkt * 8) + 1],
+			xlr_board_fmn_config.bucket_size[(bkt * 8) + 2],
+			xlr_board_fmn_config.bucket_size[(bkt * 8) + 3],
+			xlr_board_fmn_config.bucket_size[(bkt * 8) + 4],
+			xlr_board_fmn_config.bucket_size[(bkt * 8) + 5],
+			xlr_board_fmn_config.bucket_size[(bkt * 8) + 6],
+			xlr_board_fmn_config.bucket_size[(bkt * 8) + 7]);
+	pr_info("\n");
+
+	pr_info("Credits distribution :\n");
+	pr_info("Station\t: Size\n");
+	for (bkt = 0; bkt < 16; bkt++)
+		pr_info(" %d  %d  %d  %d  %d  %d  %d %d\n",
+			fmn_info->credit_config[(bkt * 8) + 0],
+			fmn_info->credit_config[(bkt * 8) + 1],
+			fmn_info->credit_config[(bkt * 8) + 2],
+			fmn_info->credit_config[(bkt * 8) + 3],
+			fmn_info->credit_config[(bkt * 8) + 4],
+			fmn_info->credit_config[(bkt * 8) + 5],
+			fmn_info->credit_config[(bkt * 8) + 6],
+			fmn_info->credit_config[(bkt * 8) + 7]);
+	pr_info("\n");
+}
+
+static void check_credit_distribution(void)
+{
+	struct xlr_board_fmn_config *cfg = &xlr_board_fmn_config;
+	int bkt, n, total_credits, ncores;
+
+	ncores = hweight32(nlm_current_node()->coremask);
+	for (bkt = 0; bkt < 128; bkt++) {
+		total_credits = 0;
+		for (n = 0; n < ncores; n++)
+			total_credits += cfg->cpu[n].credit_config[bkt];
+		total_credits += cfg->gmac[0].credit_config[bkt];
+		total_credits += cfg->gmac[1].credit_config[bkt];
+		total_credits += cfg->dma.credit_config[bkt];
+		total_credits += cfg->cmp.credit_config[bkt];
+		total_credits += cfg->sae.credit_config[bkt];
+		total_credits += cfg->xgmac[0].credit_config[bkt];
+		total_credits += cfg->xgmac[1].credit_config[bkt];
+		if (total_credits > cfg->bucket_size[bkt])
+			pr_err("ERROR: Bucket %d: credits (%d) > size (%d)\n",
+				bkt, total_credits, cfg->bucket_size[bkt]);
+	}
+	pr_info("Credit distribution complete.\n");
+}
+
+/**
+ * Configure bucket size and credits for a device. 'size' is the size of
+ * the buckets for the device. This size is distributed among all the CPUs
+ * so that all of them can send messages to the device.
+ *
+ * The device is also given 'cpu_credits' to send messages to the CPUs
+ *
+ * @dev_info: FMN information structure for each devices
+ * @start_stn_id: Starting station id of dev_info
+ * @end_stn_id: End station id of dev_info
+ * @num_buckets: Total number of buckets for den_info
+ * @cpu_credits: Allowed credits to cpu for each devices pointing by dev_info
+ * @size: Size of the each buckets in the device station
+ */
+static void setup_fmn_cc(struct xlr_fmn_info *dev_info, int start_stn_id,
+		int end_stn_id, int num_buckets, int cpu_credits, int size)
+{
+	int i, j, num_core, n, credits_per_cpu;
+	struct xlr_fmn_info *cpu = xlr_board_fmn_config.cpu;
+
+	num_core = hweight32(nlm_current_node()->coremask);
+	dev_info->num_buckets	= num_buckets;
+	dev_info->start_stn_id	= start_stn_id;
+	dev_info->end_stn_id	= end_stn_id;
+
+	n = num_core;
+	if (num_core == 3)
+		n = 4;
+
+	for (i = start_stn_id; i <= end_stn_id; i++) {
+		xlr_board_fmn_config.bucket_size[i] = size;
+
+		/* Dividing device credits equally to cpus */
+		credits_per_cpu = size / n;
+		for (j = 0; j < num_core; j++)
+			cpu[j].credit_config[i] = credits_per_cpu;
+
+		/* credits left to distribute */
+		credits_per_cpu = size - (credits_per_cpu * num_core);
+
+		/* distribute the remaining credits (if any), among cores */
+		for (j = 0; (j < num_core) && (credits_per_cpu >= 4); j++) {
+			cpu[j].credit_config[i] += 4;
+			credits_per_cpu -= 4;
+		}
+	}
+
+	/* Distributing cpu per bucket credits to devices */
+	for (i = 0; i < num_core; i++) {
+		for (j = 0; j < FMN_CORE_NBUCKETS; j++)
+			dev_info->credit_config[(i * 8) + j] = cpu_credits;
+	}
+}
+
+/*
+ * Each core has 256 slots and 8 buckets,
+ * Configure the 8 buckets each with 32 slots
+ */
+static void setup_cpu_fmninfo(struct xlr_fmn_info *cpu, int num_core)
+{
+	int i, j;
+
+	for (i = 0; i < num_core; i++) {
+		cpu[i].start_stn_id     = (8 * i);
+		cpu[i].end_stn_id       = (8 * i + 8);
+
+		for (j = cpu[i].start_stn_id; j < cpu[i].end_stn_id; j++)
+			xlr_board_fmn_config.bucket_size[j] = 32;
+	}
+}
+
+/**
+ * Setup the FMN details for each devices according to the device available
+ * in each variant of XLR/XLS processor
+ */
+void xlr_board_info_setup(void)
+{
+	struct xlr_fmn_info *cpu = xlr_board_fmn_config.cpu;
+	struct xlr_fmn_info *gmac = xlr_board_fmn_config.gmac;
+	struct xlr_fmn_info *xgmac = xlr_board_fmn_config.xgmac;
+	struct xlr_fmn_info *dma = &xlr_board_fmn_config.dma;
+	struct xlr_fmn_info *cmp = &xlr_board_fmn_config.cmp;
+	struct xlr_fmn_info *sae = &xlr_board_fmn_config.sae;
+	int processor_id, num_core;
+
+	num_core = hweight32(nlm_current_node()->coremask);
+	processor_id = read_c0_prid() & 0xff00;
+
+	setup_cpu_fmninfo(cpu, num_core);
+	switch (processor_id) {
+	case PRID_IMP_NETLOGIC_XLS104:
+	case PRID_IMP_NETLOGIC_XLS108:
+		setup_fmn_cc(&gmac[0], FMN_STNID_GMAC0,
+					FMN_STNID_GMAC0_TX3, 8, 16, 32);
+		setup_fmn_cc(dma, FMN_STNID_DMA_0,
+					FMN_STNID_DMA_3, 4, 8, 64);
+		setup_fmn_cc(sae, FMN_STNID_SEC0,
+					FMN_STNID_SEC1, 2, 8, 128);
+		break;
+
+	case PRID_IMP_NETLOGIC_XLS204:
+	case PRID_IMP_NETLOGIC_XLS208:
+		setup_fmn_cc(&gmac[0], FMN_STNID_GMAC0,
+					FMN_STNID_GMAC0_TX3, 8, 16, 32);
+		setup_fmn_cc(dma, FMN_STNID_DMA_0,
+					FMN_STNID_DMA_3, 4, 8, 64);
+		setup_fmn_cc(sae, FMN_STNID_SEC0,
+					FMN_STNID_SEC1, 2, 8, 128);
+		break;
+
+	case PRID_IMP_NETLOGIC_XLS404:
+	case PRID_IMP_NETLOGIC_XLS408:
+	case PRID_IMP_NETLOGIC_XLS404B:
+	case PRID_IMP_NETLOGIC_XLS408B:
+	case PRID_IMP_NETLOGIC_XLS416B:
+		setup_fmn_cc(&gmac[0], FMN_STNID_GMAC0,
+					FMN_STNID_GMAC0_TX3, 8, 8, 32);
+		setup_fmn_cc(&gmac[1], FMN_STNID_GMAC1_FR_0,
+					FMN_STNID_GMAC1_TX3, 8, 8, 32);
+		setup_fmn_cc(dma, FMN_STNID_DMA_0,
+					FMN_STNID_DMA_3, 4, 4, 64);
+		setup_fmn_cc(cmp, FMN_STNID_CMP_0,
+					FMN_STNID_CMP_3, 4, 4, 64);
+		setup_fmn_cc(sae, FMN_STNID_SEC0,
+					FMN_STNID_SEC1, 2, 8, 128);
+		break;
+
+	case PRID_IMP_NETLOGIC_XLS412B:
+		setup_fmn_cc(&gmac[0], FMN_STNID_GMAC0,
+					FMN_STNID_GMAC0_TX3, 8, 8, 32);
+		setup_fmn_cc(&gmac[1], FMN_STNID_GMAC1_FR_0,
+					FMN_STNID_GMAC1_TX3, 8, 8, 32);
+		setup_fmn_cc(dma, FMN_STNID_DMA_0,
+					FMN_STNID_DMA_3, 4, 4, 64);
+		setup_fmn_cc(cmp, FMN_STNID_CMP_0,
+					FMN_STNID_CMP_3, 4, 4, 64);
+		setup_fmn_cc(sae, FMN_STNID_SEC0,
+					FMN_STNID_SEC1, 2, 8, 128);
+		break;
+
+	case PRID_IMP_NETLOGIC_XLR308:
+	case PRID_IMP_NETLOGIC_XLR308C:
+		setup_fmn_cc(&gmac[0], FMN_STNID_GMAC0,
+					FMN_STNID_GMAC0_TX3, 8, 16, 32);
+		setup_fmn_cc(dma, FMN_STNID_DMA_0,
+					FMN_STNID_DMA_3, 4, 8, 64);
+		setup_fmn_cc(sae, FMN_STNID_SEC0,
+					FMN_STNID_SEC1, 2, 4, 128);
+		break;
+
+	case PRID_IMP_NETLOGIC_XLR532:
+	case PRID_IMP_NETLOGIC_XLR532C:
+	case PRID_IMP_NETLOGIC_XLR516C:
+	case PRID_IMP_NETLOGIC_XLR508C:
+		setup_fmn_cc(&gmac[0], FMN_STNID_GMAC0,
+					FMN_STNID_GMAC0_TX3, 8, 16, 32);
+		setup_fmn_cc(dma, FMN_STNID_DMA_0,
+					FMN_STNID_DMA_3, 4, 8, 64);
+		setup_fmn_cc(sae, FMN_STNID_SEC0,
+					FMN_STNID_SEC1, 2, 4, 128);
+		break;
+
+	case PRID_IMP_NETLOGIC_XLR732:
+	case PRID_IMP_NETLOGIC_XLR716:
+		setup_fmn_cc(&xgmac[0], FMN_STNID_XMAC0_00_TX,
+					FMN_STNID_XMAC0_15_TX, 8, 0, 32);
+		setup_fmn_cc(&xgmac[1], FMN_STNID_XMAC1_00_TX,
+					FMN_STNID_XMAC1_15_TX, 8, 0, 32);
+		setup_fmn_cc(&gmac[0], FMN_STNID_GMAC0,
+					FMN_STNID_GMAC0_TX3, 8, 24, 32);
+		setup_fmn_cc(dma, FMN_STNID_DMA_0,
+					FMN_STNID_DMA_3, 4, 4, 64);
+		setup_fmn_cc(sae, FMN_STNID_SEC0,
+					FMN_STNID_SEC1, 2, 4, 128);
+		break;
+	default:
+		pr_err("Unknown CPU with processor ID [%d]\n", processor_id);
+		pr_err("Error: Cannot initialize FMN credits.\n");
+	}
+
+	check_credit_distribution();
+
+#if 0 /* debug */
+	print_credit_config(&cpu[0]);
+	print_credit_config(&gmac[0]);
+#endif
+}
diff --git a/arch/mips/netlogic/xlr/fmn.c b/arch/mips/netlogic/xlr/fmn.c
new file mode 100644
index 0000000..4d74f03
--- /dev/null
+++ b/arch/mips/netlogic/xlr/fmn.c
@@ -0,0 +1,204 @@
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
+#include <linux/kernel.h>
+#include <linux/irqreturn.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+
+#include <asm/mipsregs.h>
+#include <asm/netlogic/interrupt.h>
+#include <asm/netlogic/xlr/fmn.h>
+#include <asm/netlogic/common.h>
+
+#define COP2_CC_INIT_CPU_DEST(dest, conf) \
+do { \
+	nlm_write_c2_cc##dest(0, conf[(dest * 8) + 0]); \
+	nlm_write_c2_cc##dest(1, conf[(dest * 8) + 1]); \
+	nlm_write_c2_cc##dest(2, conf[(dest * 8) + 2]); \
+	nlm_write_c2_cc##dest(3, conf[(dest * 8) + 3]); \
+	nlm_write_c2_cc##dest(4, conf[(dest * 8) + 4]); \
+	nlm_write_c2_cc##dest(5, conf[(dest * 8) + 5]); \
+	nlm_write_c2_cc##dest(6, conf[(dest * 8) + 6]); \
+	nlm_write_c2_cc##dest(7, conf[(dest * 8) + 7]); \
+} while (0)
+
+struct fmn_message_handler {
+	void (*action)(int, int, int, int, struct nlm_fmn_msg *, void *);
+	void *arg;
+} msg_handlers[128];
+
+/*
+ * FMN interrupt handler. We configure the FMN so that any messages in
+ * any of the CPU buckets will trigger an interrupt on the CPU.
+ * The message can be from any device on the FMN (like NAE/SAE/DMA).
+ * The source station id is used to figure out which of the registered
+ * handlers have to be called.
+ */
+static irqreturn_t fmn_message_handler(int irq, void *data)
+{
+	struct fmn_message_handler *hndlr;
+	int bucket, rv;
+	int size = 0, code = 0, src_stnid = 0;
+	struct nlm_fmn_msg msg;
+	uint32_t mflags, bkt_status;
+
+	mflags = nlm_cop2_enable();
+	/* Disable message ring interrupt */
+	nlm_fmn_setup_intr(irq, 0);
+	while (1) {
+		/* 8 bkts per core, [24:31] each bit represents one bucket
+		 * Bit is Zero if bucket is not empty */
+		bkt_status = (nlm_read_c2_status() >> 24) & 0xff;
+		if (bkt_status == 0xff)
+			break;
+		for (bucket = 0; bucket < 8; bucket++) {
+			/* Continue on empty bucket */
+			if (bkt_status & (1 << bucket))
+				continue;
+			rv = nlm_fmn_receive(bucket, &size, &code, &src_stnid,
+						&msg);
+			if (rv != 0)
+				continue;
+
+			hndlr = &msg_handlers[src_stnid];
+			if (hndlr->action == NULL)
+				pr_warn("No msgring handler for stnid %d\n",
+						src_stnid);
+			else {
+				nlm_cop2_restore(mflags);
+				hndlr->action(bucket, src_stnid, size, code,
+					&msg, hndlr->arg);
+				mflags = nlm_cop2_enable();
+			}
+		}
+	};
+	/* Enable message ring intr, to any thread in core */
+	nlm_fmn_setup_intr(irq, (1 << nlm_threads_per_core) - 1);
+	nlm_cop2_restore(mflags);
+	return IRQ_HANDLED;
+}
+
+struct irqaction fmn_irqaction = {
+	.handler = fmn_message_handler,
+	.flags = IRQF_PERCPU,
+	.name = "fmn",
+};
+
+void xlr_percpu_fmn_init(void)
+{
+	struct xlr_fmn_info *cpu_fmn_info;
+	int *bucket_sizes;
+	uint32_t flags;
+	int id;
+
+	BUG_ON(nlm_thread_id() != 0);
+	id = nlm_core_id();
+
+	bucket_sizes = xlr_board_fmn_config.bucket_size;
+	cpu_fmn_info = &xlr_board_fmn_config.cpu[id];
+	flags = nlm_cop2_enable();
+
+	/* Setup bucket sizes for the core. */
+	nlm_write_c2_bucksize(0, bucket_sizes[id * 8 + 0]);
+	nlm_write_c2_bucksize(1, bucket_sizes[id * 8 + 1]);
+	nlm_write_c2_bucksize(2, bucket_sizes[id * 8 + 2]);
+	nlm_write_c2_bucksize(3, bucket_sizes[id * 8 + 3]);
+	nlm_write_c2_bucksize(4, bucket_sizes[id * 8 + 4]);
+	nlm_write_c2_bucksize(5, bucket_sizes[id * 8 + 5]);
+	nlm_write_c2_bucksize(6, bucket_sizes[id * 8 + 6]);
+	nlm_write_c2_bucksize(7, bucket_sizes[id * 8 + 7]);
+
+	/*
+	 * For sending FMN messages, we need credits on the destination
+	 * bucket. Program the credits this core has on the 128 possible
+	 * destination buckets.
+	 * We cannot use a loop here, because the the first argument has
+	 * to be a constant integer value.
+	 */
+	COP2_CC_INIT_CPU_DEST(0, cpu_fmn_info->credit_config);
+	COP2_CC_INIT_CPU_DEST(1, cpu_fmn_info->credit_config);
+	COP2_CC_INIT_CPU_DEST(2, cpu_fmn_info->credit_config);
+	COP2_CC_INIT_CPU_DEST(3, cpu_fmn_info->credit_config);
+	COP2_CC_INIT_CPU_DEST(4, cpu_fmn_info->credit_config);
+	COP2_CC_INIT_CPU_DEST(5, cpu_fmn_info->credit_config);
+	COP2_CC_INIT_CPU_DEST(6, cpu_fmn_info->credit_config);
+	COP2_CC_INIT_CPU_DEST(7, cpu_fmn_info->credit_config);
+	COP2_CC_INIT_CPU_DEST(8, cpu_fmn_info->credit_config);
+	COP2_CC_INIT_CPU_DEST(9, cpu_fmn_info->credit_config);
+	COP2_CC_INIT_CPU_DEST(10, cpu_fmn_info->credit_config);
+	COP2_CC_INIT_CPU_DEST(11, cpu_fmn_info->credit_config);
+	COP2_CC_INIT_CPU_DEST(12, cpu_fmn_info->credit_config);
+	COP2_CC_INIT_CPU_DEST(13, cpu_fmn_info->credit_config);
+	COP2_CC_INIT_CPU_DEST(14, cpu_fmn_info->credit_config);
+	COP2_CC_INIT_CPU_DEST(15, cpu_fmn_info->credit_config);
+
+	/* enable FMN interrupts on this CPU */
+	nlm_fmn_setup_intr(IRQ_FMN, (1 << nlm_threads_per_core) - 1);
+	nlm_cop2_restore(flags);
+}
+
+
+/*
+ * Register a FMN message handler with respect to the source station id
+ * @stnid: source station id
+ * @action: Handler function pointer
+ */
+int nlm_register_fmn_handler(int start_stnid, int end_stnid,
+	void (*action)(int, int, int, int, struct nlm_fmn_msg *, void *),
+	void *arg)
+{
+	int sstnid;
+
+	for (sstnid = start_stnid; sstnid <= end_stnid; sstnid++) {
+		msg_handlers[sstnid].arg = arg;
+		smp_wmb();
+		msg_handlers[sstnid].action = action;
+	}
+	pr_debug("Registered FMN msg handler for stnid %d-%d\n",
+			start_stnid, end_stnid);
+	return 0;
+}
+
+void nlm_setup_fmn_irq(void)
+{
+	uint32_t flags;
+
+	/* setup irq only once */
+	setup_irq(IRQ_FMN, &fmn_irqaction);
+
+	flags = nlm_cop2_enable();
+	nlm_fmn_setup_intr(IRQ_FMN, (1 << nlm_threads_per_core) - 1);
+	nlm_cop2_restore(flags);
+}
diff --git a/arch/mips/netlogic/xlr/setup.c b/arch/mips/netlogic/xlr/setup.c
index 696d424..4e7f49d 100644
--- a/arch/mips/netlogic/xlr/setup.c
+++ b/arch/mips/netlogic/xlr/setup.c
@@ -49,6 +49,7 @@
 #include <asm/netlogic/xlr/iomap.h>
 #include <asm/netlogic/xlr/pic.h>
 #include <asm/netlogic/xlr/gpio.h>
+#include <asm/netlogic/xlr/fmn.h>
 
 uint64_t nlm_io_base = DEFAULT_NETLOGIC_IO_BASE;
 struct psb_info nlm_prom_info;
@@ -111,6 +112,12 @@ void __init prom_free_prom_memory(void)
 	/* Nothing yet */
 }
 
+void nlm_percpu_init(int hwcpuid)
+{
+	if (hwcpuid % 4 == 0)
+		xlr_percpu_fmn_init();
+}
+
 static void __init build_arcs_cmdline(int *argv)
 {
 	int i, remain, len;
@@ -208,4 +215,6 @@ void __init prom_init(void)
 	nlm_wakeup_secondary_cpus();
 	register_smp_ops(&nlm_smp_ops);
 #endif
+	xlr_board_info_setup();
+	xlr_percpu_fmn_init();
 }
-- 
1.7.9.5
