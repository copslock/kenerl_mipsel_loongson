Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Nov 2008 20:55:50 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:2970 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S23298031AbYKFUzI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 6 Nov 2008 20:55:08 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B491359990001>; Thu, 06 Nov 2008 15:54:49 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 6 Nov 2008 12:54:49 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 6 Nov 2008 12:54:48 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id mA6KsiwX027684;
	Thu, 6 Nov 2008 12:54:44 -0800
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id mA6KsigY027683;
	Thu, 6 Nov 2008 12:54:44 -0800
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Subject: [PATCH 02/29] MIPS: Add Cavium OCTEON files to arch/mips/include/asm/mach-cavium-octeon
Date:	Thu,  6 Nov 2008 12:54:15 -0800
Message-Id: <1226004875-27654-2-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <491358F5.7040002@caviumnetworks.com>
References: <491358F5.7040002@caviumnetworks.com>
X-OriginalArrivalTime: 06 Nov 2008 20:54:48.0855 (UTC) FILETIME=[E82CD270:01C94051]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21197
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 .../asm/mach-cavium-octeon/cpu-feature-overrides.h |   62 +
 .../include/asm/mach-cavium-octeon/dma-coherence.h |   64 +
 arch/mips/include/asm/mach-cavium-octeon/irq.h     |  244 +++
 .../asm/mach-cavium-octeon/kernel-entry-init.h     |  140 ++
 arch/mips/include/asm/mach-cavium-octeon/war.h     |   26 +
 arch/mips/include/asm/octeon/cvmx-ciu-defs.h       | 1615 ++++++++++++++++
 arch/mips/include/asm/octeon/cvmx-gpio-defs.h      |  218 +++
 arch/mips/include/asm/octeon/cvmx-iob-defs.h       |  529 +++++
 arch/mips/include/asm/octeon/cvmx-ipd-defs.h       |  861 +++++++++
 arch/mips/include/asm/octeon/cvmx-l2c-defs.h       |  958 +++++++++
 arch/mips/include/asm/octeon/cvmx-l2d-defs.h       |  368 ++++
 arch/mips/include/asm/octeon/cvmx-l2t-defs.h       |  140 ++
 arch/mips/include/asm/octeon/cvmx-led-defs.h       |  239 +++
 arch/mips/include/asm/octeon/cvmx-mio-defs.h       | 2028 ++++++++++++++++++++
 arch/mips/include/asm/octeon/cvmx-pow-defs.h       |  697 +++++++
 arch/mips/include/asm/octeon/octeon.h              |  238 +++
 16 files changed, 8427 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
 create mode 100644 arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h
 create mode 100644 arch/mips/include/asm/mach-cavium-octeon/irq.h
 create mode 100644 arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
 create mode 100644 arch/mips/include/asm/mach-cavium-octeon/war.h
 create mode 100644 arch/mips/include/asm/octeon/cvmx-ciu-defs.h
 create mode 100644 arch/mips/include/asm/octeon/cvmx-gpio-defs.h
 create mode 100644 arch/mips/include/asm/octeon/cvmx-iob-defs.h
 create mode 100644 arch/mips/include/asm/octeon/cvmx-ipd-defs.h
 create mode 100644 arch/mips/include/asm/octeon/cvmx-l2c-defs.h
 create mode 100644 arch/mips/include/asm/octeon/cvmx-l2d-defs.h
 create mode 100644 arch/mips/include/asm/octeon/cvmx-l2t-defs.h
 create mode 100644 arch/mips/include/asm/octeon/cvmx-led-defs.h
 create mode 100644 arch/mips/include/asm/octeon/cvmx-mio-defs.h
 create mode 100644 arch/mips/include/asm/octeon/cvmx-pow-defs.h
 create mode 100644 arch/mips/include/asm/octeon/octeon.h

diff --git a/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h b/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
new file mode 100644
index 0000000..914cfc9
--- /dev/null
+++ b/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
@@ -0,0 +1,62 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2004 Cavium Networks
+ */
+#ifndef __ASM_MACH_CAVIUM_OCTEON_CPU_FEATURE_OVERRIDES_H
+#define __ASM_MACH_CAVIUM_OCTEON_CPU_FEATURE_OVERRIDES_H
+
+#include <linux/types.h>
+#include <asm/mipsregs.h>
+
+/*
+ * Cavium Octeons are MIPS64v2 processors
+ */
+#define cpu_dcache_line_size()	128
+#define cpu_icache_line_size()	128
+
+/*
+ * We should disable LL/SC on non SMP systems as it is faster to
+ * disable interrupts for atomic access than a LL/SC.  Unfortunatly we
+ * cannot as this breaks asm/futex.h
+ */
+#define cpu_has_llsc		1
+#define cpu_has_prefetch	1
+#define cpu_has_dc_aliases	0
+#define cpu_has_fpu		0
+#define cpu_has_64bits		1
+#define cpu_has_octeon_cache	1
+#define cpu_has_4k_cache	0
+#define cpu_has_saa		octeon_has_saa()
+#define cpu_has_mips64r2	1
+#define cpu_has_counter		1
+#define ARCH_HAS_READ_CURRENT_TIMER 1
+#define ARCH_HAS_IRQ_PER_CPU	1
+#define ARCH_HAS_SPINLOCK_PREFETCH 1
+#define spin_lock_prefetch(x) prefetch(x)
+#define PREFETCH_STRIDE 128
+
+static inline int read_current_timer(unsigned long *result)
+{
+	asm volatile ("rdhwr %0,$31\n"
+#ifndef CONFIG_64BIT
+		      "sll %0, 0\n"
+#endif
+		      : "=r" (*result));
+	return 0;
+}
+
+static inline int octeon_has_saa(void)
+{
+#ifdef CONFIG_CPU_CAVIUM_OCTEON
+	int id;
+	asm volatile ("mfc0 %0, $15,0" : "=r" (id));
+	return id >= 0x000d0300;
+#else
+	return 0;
+#endif
+}
+
+#endif
diff --git a/arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h b/arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h
new file mode 100644
index 0000000..f30fce9
--- /dev/null
+++ b/arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h
@@ -0,0 +1,64 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2006  Ralf Baechle <ralf@linux-mips.org>
+ *
+ *
+ * Similar to mach-generic/dma-coherence.h except
+ * plat_device_is_coherent hard coded to return 1.
+ *
+ */
+#ifndef __ASM_MACH_CAVIUM_OCTEON_DMA_COHERENCE_H
+#define __ASM_MACH_CAVIUM_OCTEON_DMA_COHERENCE_H
+
+struct device;
+
+dma_addr_t octeon_map_dma_mem(struct device *, void *, size_t);
+void octeon_unmap_dma_mem(struct device *, dma_addr_t);
+
+static inline dma_addr_t plat_map_dma_mem(struct device *dev, void *addr,
+	size_t size)
+{
+	return octeon_map_dma_mem(dev, addr, size);
+}
+
+static inline dma_addr_t plat_map_dma_mem_page(struct device *dev,
+	struct page *page)
+{
+	return octeon_map_dma_mem(dev, page_address(page), PAGE_SIZE);
+}
+
+static inline unsigned long plat_dma_addr_to_phys(dma_addr_t dma_addr)
+{
+	return dma_addr;
+}
+
+static inline void plat_unmap_dma_mem(struct device *dev, dma_addr_t dma_addr)
+{
+	octeon_unmap_dma_mem(dev, dma_addr);
+}
+
+static inline int plat_dma_supported(struct device *dev, u64 mask)
+{
+	return 1;
+}
+
+static inline void plat_extra_sync_for_device(struct device *dev)
+{
+	mb();
+}
+
+static inline int plat_device_is_coherent(struct device *dev)
+{
+	return 1;
+}
+
+static inline int plat_dma_mapping_error(struct device *dev,
+					 dma_addr_t dma_addr)
+{
+	return dma_addr == -1;
+}
+
+#endif /* __ASM_MACH_CAVIUM_OCTEON_DMA_COHERENCE_H */
diff --git a/arch/mips/include/asm/mach-cavium-octeon/irq.h b/arch/mips/include/asm/mach-cavium-octeon/irq.h
new file mode 100644
index 0000000..a2fbc29
--- /dev/null
+++ b/arch/mips/include/asm/mach-cavium-octeon/irq.h
@@ -0,0 +1,244 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2004-2008 Cavium Networks
+ */
+#ifndef __OCTEON_IRQ_H__
+#define __OCTEON_IRQ_H__
+
+#define NR_IRQS OCTEON_IRQ_LAST
+#define MIPS_CPU_IRQ_BASE OCTEON_IRQ_SW0
+
+/* 0 - 7 represent the i8259 master */
+#define OCTEON_IRQ_I8259M0	0
+#define OCTEON_IRQ_I8259M1	1
+#define OCTEON_IRQ_I8259M2	2
+#define OCTEON_IRQ_I8259M3	3
+#define OCTEON_IRQ_I8259M4	4
+#define OCTEON_IRQ_I8259M5	5
+#define OCTEON_IRQ_I8259M6	6
+#define OCTEON_IRQ_I8259M7	7
+/* 8 - 15 represent the i8259 slave */
+#define OCTEON_IRQ_I8259S0	8
+#define OCTEON_IRQ_I8259S1	9
+#define OCTEON_IRQ_I8259S2	10
+#define OCTEON_IRQ_I8259S3	11
+#define OCTEON_IRQ_I8259S4	12
+#define OCTEON_IRQ_I8259S5	13
+#define OCTEON_IRQ_I8259S6	14
+#define OCTEON_IRQ_I8259S7	15
+/* 16 - 23 represent the 8 MIPS standard interrupt sources */
+#define OCTEON_IRQ_SW0		16
+#define OCTEON_IRQ_SW1		17
+#define OCTEON_IRQ_CIU0		18
+#define OCTEON_IRQ_CIU1		19
+#define OCTEON_IRQ_CIU4		20
+#define OCTEON_IRQ_5		21
+#define OCTEON_IRQ_PERF		22
+#define OCTEON_IRQ_TIMER	23
+/* 24 - 87 represent the sources in CIU_INTX_EN0 */
+#define OCTEON_IRQ_WORKQ0	24
+#define OCTEON_IRQ_WORKQ1	25
+#define OCTEON_IRQ_WORKQ2	26
+#define OCTEON_IRQ_WORKQ3	27
+#define OCTEON_IRQ_WORKQ4	28
+#define OCTEON_IRQ_WORKQ5	29
+#define OCTEON_IRQ_WORKQ6	30
+#define OCTEON_IRQ_WORKQ7	31
+#define OCTEON_IRQ_WORKQ8	32
+#define OCTEON_IRQ_WORKQ9	33
+#define OCTEON_IRQ_WORKQ10	34
+#define OCTEON_IRQ_WORKQ11	35
+#define OCTEON_IRQ_WORKQ12	36
+#define OCTEON_IRQ_WORKQ13	37
+#define OCTEON_IRQ_WORKQ14	38
+#define OCTEON_IRQ_WORKQ15	39
+#define OCTEON_IRQ_GPIO0	40
+#define OCTEON_IRQ_GPIO1	41
+#define OCTEON_IRQ_GPIO2	42
+#define OCTEON_IRQ_GPIO3	43
+#define OCTEON_IRQ_GPIO4	44
+#define OCTEON_IRQ_GPIO5	45
+#define OCTEON_IRQ_GPIO6	46
+#define OCTEON_IRQ_GPIO7	47
+#define OCTEON_IRQ_GPIO8	48
+#define OCTEON_IRQ_GPIO9	49
+#define OCTEON_IRQ_GPIO10	50
+#define OCTEON_IRQ_GPIO11	51
+#define OCTEON_IRQ_GPIO12	52
+#define OCTEON_IRQ_GPIO13	53
+#define OCTEON_IRQ_GPIO14	54
+#define OCTEON_IRQ_GPIO15	55
+#define OCTEON_IRQ_MBOX0	56
+#define OCTEON_IRQ_MBOX1	57
+#define OCTEON_IRQ_UART0	58
+#define OCTEON_IRQ_UART1	59
+#define OCTEON_IRQ_PCI_INT0	60
+#define OCTEON_IRQ_PCI_INT1	61
+#define OCTEON_IRQ_PCI_INT2	62
+#define OCTEON_IRQ_PCI_INT3	63
+#define OCTEON_IRQ_PCI_MSI0	64
+#define OCTEON_IRQ_PCI_MSI1	65
+#define OCTEON_IRQ_PCI_MSI2	66
+#define OCTEON_IRQ_PCI_MSI3	67
+#define OCTEON_IRQ_RESERVED68	68	/* Summary of CIU_INT_SUM1 */
+#define OCTEON_IRQ_TWSI		69
+#define OCTEON_IRQ_RML		70
+#define OCTEON_IRQ_TRACE	71
+#define OCTEON_IRQ_GMX_DRP0	72
+#define OCTEON_IRQ_GMX_DRP1	73
+#define OCTEON_IRQ_IPD_DRP	74
+#define OCTEON_IRQ_KEY_ZERO	75
+#define OCTEON_IRQ_TIMER0	76
+#define OCTEON_IRQ_TIMER1	77
+#define OCTEON_IRQ_TIMER2	78
+#define OCTEON_IRQ_TIMER3	79
+#define OCTEON_IRQ_USB0		80
+#define OCTEON_IRQ_PCM		81
+#define OCTEON_IRQ_MPI		82
+#define OCTEON_IRQ_TWSI2	83
+#define OCTEON_IRQ_POWIQ	84
+#define OCTEON_IRQ_IPDPPTHR	85
+#define OCTEON_IRQ_MII0		86
+#define OCTEON_IRQ_BOOTDMA	87
+/* 72 - 135 represent the sources in CIU_INTX_EN1 */
+#define OCTEON_IRQ_WDOG0	88
+#define OCTEON_IRQ_WDOG1	89
+#define OCTEON_IRQ_WDOG2	90
+#define OCTEON_IRQ_WDOG3	91
+#define OCTEON_IRQ_WDOG4	92
+#define OCTEON_IRQ_WDOG5	93
+#define OCTEON_IRQ_WDOG6	94
+#define OCTEON_IRQ_WDOG7	95
+#define OCTEON_IRQ_WDOG8	96
+#define OCTEON_IRQ_WDOG9	97
+#define OCTEON_IRQ_WDOG10	98
+#define OCTEON_IRQ_WDOG11	99
+#define OCTEON_IRQ_WDOG12	100
+#define OCTEON_IRQ_WDOG13	101
+#define OCTEON_IRQ_WDOG14	102
+#define OCTEON_IRQ_WDOG15	103
+#define OCTEON_IRQ_UART2	104
+#define OCTEON_IRQ_USB1		105
+#define OCTEON_IRQ_MII1		106
+#define OCTEON_IRQ_RESERVED107	107
+#define OCTEON_IRQ_RESERVED108	108
+#define OCTEON_IRQ_RESERVED109	109
+#define OCTEON_IRQ_RESERVED110	110
+#define OCTEON_IRQ_RESERVED111	111
+#define OCTEON_IRQ_RESERVED112	112
+#define OCTEON_IRQ_RESERVED113	113
+#define OCTEON_IRQ_RESERVED114	114
+#define OCTEON_IRQ_RESERVED115	115
+#define OCTEON_IRQ_RESERVED116	116
+#define OCTEON_IRQ_RESERVED117	117
+#define OCTEON_IRQ_RESERVED118	118
+#define OCTEON_IRQ_RESERVED119	119
+#define OCTEON_IRQ_RESERVED120	120
+#define OCTEON_IRQ_RESERVED121	121
+#define OCTEON_IRQ_RESERVED122	122
+#define OCTEON_IRQ_RESERVED123	123
+#define OCTEON_IRQ_RESERVED124	124
+#define OCTEON_IRQ_RESERVED125	125
+#define OCTEON_IRQ_RESERVED126	126
+#define OCTEON_IRQ_RESERVED127	127
+#define OCTEON_IRQ_RESERVED128	128
+#define OCTEON_IRQ_RESERVED129	129
+#define OCTEON_IRQ_RESERVED130	130
+#define OCTEON_IRQ_RESERVED131	131
+#define OCTEON_IRQ_RESERVED132	132
+#define OCTEON_IRQ_RESERVED133	133
+#define OCTEON_IRQ_RESERVED134	134
+#define OCTEON_IRQ_RESERVED135	135
+#define OCTEON_IRQ_RESERVED136	136
+#define OCTEON_IRQ_RESERVED137	137
+#define OCTEON_IRQ_RESERVED138	138
+#define OCTEON_IRQ_RESERVED139	139
+#define OCTEON_IRQ_RESERVED140	140
+#define OCTEON_IRQ_RESERVED141	141
+#define OCTEON_IRQ_RESERVED142	142
+#define OCTEON_IRQ_RESERVED143	143
+#define OCTEON_IRQ_RESERVED144	144
+#define OCTEON_IRQ_RESERVED145	145
+#define OCTEON_IRQ_RESERVED146	146
+#define OCTEON_IRQ_RESERVED147	147
+#define OCTEON_IRQ_RESERVED148	148
+#define OCTEON_IRQ_RESERVED149	149
+#define OCTEON_IRQ_RESERVED150	150
+#define OCTEON_IRQ_RESERVED151	151
+
+#ifdef CONFIG_PCI_MSI
+/* 152 - 215 represent the MSI interrupts 0-63 */
+#define OCTEON_IRQ_MSI_BIT0	152
+#define OCTEON_IRQ_MSI_BIT1	153
+#define OCTEON_IRQ_MSI_BIT2	154
+#define OCTEON_IRQ_MSI_BIT3	155
+#define OCTEON_IRQ_MSI_BIT4	156
+#define OCTEON_IRQ_MSI_BIT5	157
+#define OCTEON_IRQ_MSI_BIT6	158
+#define OCTEON_IRQ_MSI_BIT7	159
+#define OCTEON_IRQ_MSI_BIT8	160
+#define OCTEON_IRQ_MSI_BIT9	161
+#define OCTEON_IRQ_MSI_BIT10	162
+#define OCTEON_IRQ_MSI_BIT11	163
+#define OCTEON_IRQ_MSI_BIT12	164
+#define OCTEON_IRQ_MSI_BIT13	165
+#define OCTEON_IRQ_MSI_BIT14	166
+#define OCTEON_IRQ_MSI_BIT15	167
+#define OCTEON_IRQ_MSI_BIT16	168
+#define OCTEON_IRQ_MSI_BIT17	169
+#define OCTEON_IRQ_MSI_BIT18	170
+#define OCTEON_IRQ_MSI_BIT19	171
+#define OCTEON_IRQ_MSI_BIT20	172
+#define OCTEON_IRQ_MSI_BIT21	173
+#define OCTEON_IRQ_MSI_BIT22	174
+#define OCTEON_IRQ_MSI_BIT23	175
+#define OCTEON_IRQ_MSI_BIT24	176
+#define OCTEON_IRQ_MSI_BIT25	177
+#define OCTEON_IRQ_MSI_BIT26	178
+#define OCTEON_IRQ_MSI_BIT27	179
+#define OCTEON_IRQ_MSI_BIT28	180
+#define OCTEON_IRQ_MSI_BIT29	181
+#define OCTEON_IRQ_MSI_BIT30	182
+#define OCTEON_IRQ_MSI_BIT31	183
+#define OCTEON_IRQ_MSI_BIT32	184
+#define OCTEON_IRQ_MSI_BIT33	185
+#define OCTEON_IRQ_MSI_BIT34	186
+#define OCTEON_IRQ_MSI_BIT35	187
+#define OCTEON_IRQ_MSI_BIT36	188
+#define OCTEON_IRQ_MSI_BIT37	189
+#define OCTEON_IRQ_MSI_BIT38	190
+#define OCTEON_IRQ_MSI_BIT39	191
+#define OCTEON_IRQ_MSI_BIT40	192
+#define OCTEON_IRQ_MSI_BIT41	193
+#define OCTEON_IRQ_MSI_BIT42	194
+#define OCTEON_IRQ_MSI_BIT43	195
+#define OCTEON_IRQ_MSI_BIT44	196
+#define OCTEON_IRQ_MSI_BIT45	197
+#define OCTEON_IRQ_MSI_BIT46	198
+#define OCTEON_IRQ_MSI_BIT47	199
+#define OCTEON_IRQ_MSI_BIT48	200
+#define OCTEON_IRQ_MSI_BIT49	201
+#define OCTEON_IRQ_MSI_BIT50	202
+#define OCTEON_IRQ_MSI_BIT51	203
+#define OCTEON_IRQ_MSI_BIT52	204
+#define OCTEON_IRQ_MSI_BIT53	205
+#define OCTEON_IRQ_MSI_BIT54	206
+#define OCTEON_IRQ_MSI_BIT55	207
+#define OCTEON_IRQ_MSI_BIT56	208
+#define OCTEON_IRQ_MSI_BIT57	209
+#define OCTEON_IRQ_MSI_BIT58	210
+#define OCTEON_IRQ_MSI_BIT59	211
+#define OCTEON_IRQ_MSI_BIT60	212
+#define OCTEON_IRQ_MSI_BIT61	213
+#define OCTEON_IRQ_MSI_BIT62	214
+#define OCTEON_IRQ_MSI_BIT63	215
+
+#define OCTEON_IRQ_LAST         216
+#else
+#define OCTEON_IRQ_LAST         152
+#endif
+
+#endif
diff --git a/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h b/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
new file mode 100644
index 0000000..5851dbd
--- /dev/null
+++ b/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
@@ -0,0 +1,140 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2005-2008 Cavium Networks, Inc
+ */
+#ifndef __ASM_MACH_CAVIUM_OCTEON_KERNEL_ENTRY_H
+#define __ASM_MACH_CAVIUM_OCTEON_KERNEL_ENTRY_H
+
+
+#define CP0_CYCLE_COUNTER $9,6
+#define CP0_CVMCTL_REG $9,7
+#define CP0_CVMMEMCTL_REG $11,7
+#define CP0_PRID_REG $15,0
+#define CP0_PRID_OCTEON_PASS1 0x000d0000
+#define CP0_PRID_OCTEON_CN30XX 0x000d0200
+
+.macro  kernel_entry_setup
+	# Registers set by bootloader:
+	# (only 32 bits set by bootloader, all addresses are physical
+	# addresses, and need to have the appropriate memory region set
+	# by the kernel
+	# a0 = argc
+	# a1 = argv (kseg0 compat addr )
+	# a2 = 1 if init core, zero otherwise
+	# a3 = address of boot descriptor block
+	.set push
+	.set arch=octeon
+	# Read the cavium mem control register
+	dmfc0   v0, CP0_CVMMEMCTL_REG
+	# Clear the lower 6 bits, the CVMSEG size
+	dins    v0, $0, 0, 6
+	ori     v0, CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE
+	dmtc0   v0, CP0_CVMMEMCTL_REG	# Write the cavium mem control register
+	dmfc0   v0, CP0_CVMCTL_REG	# Read the cavium control register
+#ifdef CONFIG_CAVIUM_OCTEON_HW_FIX_UNALIGNED
+	# Disable unaligned load/store support but leave HW fixup enabled
+	or  v0, v0, 0x5001
+	xor v0, v0, 0x1001
+#else
+	# Disable unaligned load/store and HW fixup support
+	or  v0, v0, 0x5001
+	xor v0, v0, 0x5001
+#endif
+	# Read the processor ID register
+	mfc0 v1, CP0_PRID_REG
+	# Disable instruction prefetching (Octeon Pass1 errata)
+	or  v0, v0, 0x2000
+	# Skip reenable of prefetching for Octeon Pass1
+	beq v1, CP0_PRID_OCTEON_PASS1,skip
+	nop
+	# Reenable instruction prefetching, not on Pass1
+	xor v0, v0, 0x2000
+	# Strip off pass number off of processor id
+	srl v1, 8
+	sll v1, 8
+	# CN30XX needs some extra stuff turned off for better performance
+	bne v1, CP0_PRID_OCTEON_CN30XX,skip
+	nop
+	# CN30XX Use random Icache replacement
+	or  v0, v0, 0x400
+	# CN30XX Disable instruction prefetching
+	or  v0, v0, 0x2000
+skip:
+	# Write the cavium control register
+	dmtc0   v0, CP0_CVMCTL_REG
+	sync
+	# Flush dcache after config change
+	cache   9, 0($0)
+	# Store the boot descriptor pointer
+	PTR_LA  t2, octeon_boot_desc_ptr
+	LONG_S  a3, (t2)
+	# Get my core id
+	rdhwr   v0, $0
+	# Jump the master to kernel_entry
+	bne     a2, zero, octeon_main_processor
+	nop
+
+#ifdef CONFIG_SMP
+
+	#
+	# All cores other than the master need to wait here for SMP bootstrap
+	# to begin
+	#
+
+	# This is the variable where the next core to boot os stored
+	PTR_LA  t0, octeon_processor_boot
+octeon_spin_wait_boot:
+	# Get the core id of the next to be booted
+	LONG_L  t1, (t0)
+	# Keep looping if it isn't me
+	bne t1, v0, octeon_spin_wait_boot
+	nop
+	# Synchronize the cycle counters
+	PTR_LA  t0, octeon_processor_cycle
+	LONG_L  t0, (t0)
+	# Aproximately how many cycles we will be off
+	LONG_ADDU t0, 122
+	MTC0    t0, CP0_CYCLE_COUNTER
+	# Get my GP from the global variable
+	PTR_LA  t0, octeon_processor_gp
+	LONG_L  gp, (t0)
+	# Get my SP from the global variable
+	PTR_LA  t0, octeon_processor_sp
+	LONG_L  sp, (t0)
+	# Set the SP global variable to zero so the master knows we've started
+	LONG_S  zero, (t0)
+#ifdef __OCTEON__
+	syncw
+	syncw
+#else
+	sync
+#endif
+	# Jump to the normal Linux SMP entry point
+	j   smp_bootstrap
+	nop
+#else /* CONFIG_SMP */
+
+	#
+	# Someone tried to boot SMP with a non SMP kernel. All extra cores
+	# will halt here.
+	#
+octeon_wait_forever:
+	wait
+	b   octeon_wait_forever
+	nop
+
+#endif /* CONFIG_SMP */
+octeon_main_processor:
+	.set pop
+.endm
+
+/*
+ * Do SMP slave processor setup necessary before we can savely execute C code.
+ */
+	.macro  smp_slave_setup
+	.endm
+
+#endif /* __ASM_MACH_CAVIUM_OCTEON_KERNEL_ENTRY_H */
diff --git a/arch/mips/include/asm/mach-cavium-octeon/war.h b/arch/mips/include/asm/mach-cavium-octeon/war.h
new file mode 100644
index 0000000..c4712d7
--- /dev/null
+++ b/arch/mips/include/asm/mach-cavium-octeon/war.h
@@ -0,0 +1,26 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org>
+ * Copyright (C) 2008 Cavium Networks <support@caviumnetworks.com>
+ */
+#ifndef __ASM_MIPS_MACH_CAVIUM_OCTEON_WAR_H
+#define __ASM_MIPS_MACH_CAVIUM_OCTEON_WAR_H
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
+#endif /* __ASM_MIPS_MACH_CAVIUM_OCTEON_WAR_H */
diff --git a/arch/mips/include/asm/octeon/cvmx-ciu-defs.h b/arch/mips/include/asm/octeon/cvmx-ciu-defs.h
new file mode 100644
index 0000000..af1bc0f
--- /dev/null
+++ b/arch/mips/include/asm/octeon/cvmx-ciu-defs.h
@@ -0,0 +1,1615 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as published by
+ * the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful,
+ * but AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or NONINFRINGEMENT.
+ * See the GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+ ***********************license end**************************************/
+
+#ifndef __CVMX_CIU_DEFS_H__
+#define __CVMX_CIU_DEFS_H__
+
+#define CVMX_CIU_BIST                                        CVMX_ADD_IO_SEG(0x0001070000000730ull)
+#define CVMX_CIU_DINT                                        CVMX_ADD_IO_SEG(0x0001070000000720ull)
+#define CVMX_CIU_FUSE                                        CVMX_ADD_IO_SEG(0x0001070000000728ull)
+#define CVMX_CIU_GSTOP                                       CVMX_ADD_IO_SEG(0x0001070000000710ull)
+#define CVMX_CIU_INTX_EN0(offset)                            CVMX_ADD_IO_SEG(0x0001070000000200ull + (((offset) & 63) * 16))
+#define CVMX_CIU_INTX_EN0_W1C(offset)                        CVMX_ADD_IO_SEG(0x0001070000002200ull + (((offset) & 63) * 16))
+#define CVMX_CIU_INTX_EN0_W1S(offset)                        CVMX_ADD_IO_SEG(0x0001070000006200ull + (((offset) & 63) * 16))
+#define CVMX_CIU_INTX_EN1(offset)                            CVMX_ADD_IO_SEG(0x0001070000000208ull + (((offset) & 63) * 16))
+#define CVMX_CIU_INTX_EN1_W1C(offset)                        CVMX_ADD_IO_SEG(0x0001070000002208ull + (((offset) & 63) * 16))
+#define CVMX_CIU_INTX_EN1_W1S(offset)                        CVMX_ADD_IO_SEG(0x0001070000006208ull + (((offset) & 63) * 16))
+#define CVMX_CIU_INTX_EN4_0(offset)                          CVMX_ADD_IO_SEG(0x0001070000000C80ull + (((offset) & 15) * 16))
+#define CVMX_CIU_INTX_EN4_0_W1C(offset)                      CVMX_ADD_IO_SEG(0x0001070000002C80ull + (((offset) & 15) * 16))
+#define CVMX_CIU_INTX_EN4_0_W1S(offset)                      CVMX_ADD_IO_SEG(0x0001070000006C80ull + (((offset) & 15) * 16))
+#define CVMX_CIU_INTX_EN4_1(offset)                          CVMX_ADD_IO_SEG(0x0001070000000C88ull + (((offset) & 15) * 16))
+#define CVMX_CIU_INTX_EN4_1_W1C(offset)                      CVMX_ADD_IO_SEG(0x0001070000002C88ull + (((offset) & 15) * 16))
+#define CVMX_CIU_INTX_EN4_1_W1S(offset)                      CVMX_ADD_IO_SEG(0x0001070000006C88ull + (((offset) & 15) * 16))
+#define CVMX_CIU_INTX_SUM0(offset)                           CVMX_ADD_IO_SEG(0x0001070000000000ull + (((offset) & 63) * 8))
+#define CVMX_CIU_INTX_SUM4(offset)                           CVMX_ADD_IO_SEG(0x0001070000000C00ull + (((offset) & 15) * 8))
+#define CVMX_CIU_INT_SUM1                                    CVMX_ADD_IO_SEG(0x0001070000000108ull)
+#define CVMX_CIU_MBOX_CLRX(offset)                           CVMX_ADD_IO_SEG(0x0001070000000680ull + (((offset) & 15) * 8))
+#define CVMX_CIU_MBOX_SETX(offset)                           CVMX_ADD_IO_SEG(0x0001070000000600ull + (((offset) & 15) * 8))
+#define CVMX_CIU_NMI                                         CVMX_ADD_IO_SEG(0x0001070000000718ull)
+#define CVMX_CIU_PCI_INTA                                    CVMX_ADD_IO_SEG(0x0001070000000750ull)
+#define CVMX_CIU_PP_DBG                                      CVMX_ADD_IO_SEG(0x0001070000000708ull)
+#define CVMX_CIU_PP_POKEX(offset)                            CVMX_ADD_IO_SEG(0x0001070000000580ull + (((offset) & 15) * 8))
+#define CVMX_CIU_PP_RST                                      CVMX_ADD_IO_SEG(0x0001070000000700ull)
+#define CVMX_CIU_QLM_DCOK                                    CVMX_ADD_IO_SEG(0x0001070000000760ull)
+#define CVMX_CIU_QLM_JTGC                                    CVMX_ADD_IO_SEG(0x0001070000000768ull)
+#define CVMX_CIU_QLM_JTGD                                    CVMX_ADD_IO_SEG(0x0001070000000770ull)
+#define CVMX_CIU_SOFT_BIST                                   CVMX_ADD_IO_SEG(0x0001070000000738ull)
+#define CVMX_CIU_SOFT_PRST                                   CVMX_ADD_IO_SEG(0x0001070000000748ull)
+#define CVMX_CIU_SOFT_PRST1                                  CVMX_ADD_IO_SEG(0x0001070000000758ull)
+#define CVMX_CIU_SOFT_RST                                    CVMX_ADD_IO_SEG(0x0001070000000740ull)
+#define CVMX_CIU_TIMX(offset)                                CVMX_ADD_IO_SEG(0x0001070000000480ull + (((offset) & 3) * 8))
+#define CVMX_CIU_WDOGX(offset)                               CVMX_ADD_IO_SEG(0x0001070000000500ull + (((offset) & 15) * 8))
+
+union cvmx_ciu_bist {
+	uint64_t u64;
+	struct cvmx_ciu_bist_s {
+		uint64_t reserved_4_63:60;
+		uint64_t bist:4;
+	} s;
+	struct cvmx_ciu_bist_s cn30xx;
+	struct cvmx_ciu_bist_s cn31xx;
+	struct cvmx_ciu_bist_s cn38xx;
+	struct cvmx_ciu_bist_s cn38xxp2;
+	struct cvmx_ciu_bist_cn50xx {
+		uint64_t reserved_2_63:62;
+		uint64_t bist:2;
+	} cn50xx;
+	struct cvmx_ciu_bist_cn52xx {
+		uint64_t reserved_3_63:61;
+		uint64_t bist:3;
+	} cn52xx;
+	struct cvmx_ciu_bist_cn52xx cn52xxp1;
+	struct cvmx_ciu_bist_s cn56xx;
+	struct cvmx_ciu_bist_s cn56xxp1;
+	struct cvmx_ciu_bist_s cn58xx;
+	struct cvmx_ciu_bist_s cn58xxp1;
+};
+typedef union cvmx_ciu_bist cvmx_ciu_bist_t;
+
+union cvmx_ciu_dint {
+	uint64_t u64;
+	struct cvmx_ciu_dint_s {
+		uint64_t reserved_16_63:48;
+		uint64_t dint:16;
+	} s;
+	struct cvmx_ciu_dint_cn30xx {
+		uint64_t reserved_1_63:63;
+		uint64_t dint:1;
+	} cn30xx;
+	struct cvmx_ciu_dint_cn31xx {
+		uint64_t reserved_2_63:62;
+		uint64_t dint:2;
+	} cn31xx;
+	struct cvmx_ciu_dint_s cn38xx;
+	struct cvmx_ciu_dint_s cn38xxp2;
+	struct cvmx_ciu_dint_cn31xx cn50xx;
+	struct cvmx_ciu_dint_cn52xx {
+		uint64_t reserved_4_63:60;
+		uint64_t dint:4;
+	} cn52xx;
+	struct cvmx_ciu_dint_cn52xx cn52xxp1;
+	struct cvmx_ciu_dint_cn56xx {
+		uint64_t reserved_12_63:52;
+		uint64_t dint:12;
+	} cn56xx;
+	struct cvmx_ciu_dint_cn56xx cn56xxp1;
+	struct cvmx_ciu_dint_s cn58xx;
+	struct cvmx_ciu_dint_s cn58xxp1;
+};
+typedef union cvmx_ciu_dint cvmx_ciu_dint_t;
+
+union cvmx_ciu_fuse {
+	uint64_t u64;
+	struct cvmx_ciu_fuse_s {
+		uint64_t reserved_16_63:48;
+		uint64_t fuse:16;
+	} s;
+	struct cvmx_ciu_fuse_cn30xx {
+		uint64_t reserved_1_63:63;
+		uint64_t fuse:1;
+	} cn30xx;
+	struct cvmx_ciu_fuse_cn31xx {
+		uint64_t reserved_2_63:62;
+		uint64_t fuse:2;
+	} cn31xx;
+	struct cvmx_ciu_fuse_s cn38xx;
+	struct cvmx_ciu_fuse_s cn38xxp2;
+	struct cvmx_ciu_fuse_cn31xx cn50xx;
+	struct cvmx_ciu_fuse_cn52xx {
+		uint64_t reserved_4_63:60;
+		uint64_t fuse:4;
+	} cn52xx;
+	struct cvmx_ciu_fuse_cn52xx cn52xxp1;
+	struct cvmx_ciu_fuse_cn56xx {
+		uint64_t reserved_12_63:52;
+		uint64_t fuse:12;
+	} cn56xx;
+	struct cvmx_ciu_fuse_cn56xx cn56xxp1;
+	struct cvmx_ciu_fuse_s cn58xx;
+	struct cvmx_ciu_fuse_s cn58xxp1;
+};
+typedef union cvmx_ciu_fuse cvmx_ciu_fuse_t;
+
+union cvmx_ciu_gstop {
+	uint64_t u64;
+	struct cvmx_ciu_gstop_s {
+		uint64_t reserved_1_63:63;
+		uint64_t gstop:1;
+	} s;
+	struct cvmx_ciu_gstop_s cn30xx;
+	struct cvmx_ciu_gstop_s cn31xx;
+	struct cvmx_ciu_gstop_s cn38xx;
+	struct cvmx_ciu_gstop_s cn38xxp2;
+	struct cvmx_ciu_gstop_s cn50xx;
+	struct cvmx_ciu_gstop_s cn52xx;
+	struct cvmx_ciu_gstop_s cn52xxp1;
+	struct cvmx_ciu_gstop_s cn56xx;
+	struct cvmx_ciu_gstop_s cn56xxp1;
+	struct cvmx_ciu_gstop_s cn58xx;
+	struct cvmx_ciu_gstop_s cn58xxp1;
+};
+typedef union cvmx_ciu_gstop cvmx_ciu_gstop_t;
+
+union cvmx_ciu_intx_en0 {
+	uint64_t u64;
+	struct cvmx_ciu_intx_en0_s {
+		uint64_t bootdma:1;
+		uint64_t mii:1;
+		uint64_t ipdppthr:1;
+		uint64_t powiq:1;
+		uint64_t twsi2:1;
+		uint64_t mpi:1;
+		uint64_t pcm:1;
+		uint64_t usb:1;
+		uint64_t timer:4;
+		uint64_t key_zero:1;
+		uint64_t ipd_drp:1;
+		uint64_t gmx_drp:2;
+		uint64_t trace:1;
+		uint64_t rml:1;
+		uint64_t twsi:1;
+		uint64_t reserved_44_44:1;
+		uint64_t pci_msi:4;
+		uint64_t pci_int:4;
+		uint64_t uart:2;
+		uint64_t mbox:2;
+		uint64_t gpio:16;
+		uint64_t workq:16;
+	} s;
+	struct cvmx_ciu_intx_en0_cn30xx {
+		uint64_t reserved_59_63:5;
+		uint64_t mpi:1;
+		uint64_t pcm:1;
+		uint64_t usb:1;
+		uint64_t timer:4;
+		uint64_t reserved_51_51:1;
+		uint64_t ipd_drp:1;
+		uint64_t reserved_49_49:1;
+		uint64_t gmx_drp:1;
+		uint64_t reserved_47_47:1;
+		uint64_t rml:1;
+		uint64_t twsi:1;
+		uint64_t reserved_44_44:1;
+		uint64_t pci_msi:4;
+		uint64_t pci_int:4;
+		uint64_t uart:2;
+		uint64_t mbox:2;
+		uint64_t gpio:16;
+		uint64_t workq:16;
+	} cn30xx;
+	struct cvmx_ciu_intx_en0_cn31xx {
+		uint64_t reserved_59_63:5;
+		uint64_t mpi:1;
+		uint64_t pcm:1;
+		uint64_t usb:1;
+		uint64_t timer:4;
+		uint64_t reserved_51_51:1;
+		uint64_t ipd_drp:1;
+		uint64_t reserved_49_49:1;
+		uint64_t gmx_drp:1;
+		uint64_t trace:1;
+		uint64_t rml:1;
+		uint64_t twsi:1;
+		uint64_t reserved_44_44:1;
+		uint64_t pci_msi:4;
+		uint64_t pci_int:4;
+		uint64_t uart:2;
+		uint64_t mbox:2;
+		uint64_t gpio:16;
+		uint64_t workq:16;
+	} cn31xx;
+	struct cvmx_ciu_intx_en0_cn38xx {
+		uint64_t reserved_56_63:8;
+		uint64_t timer:4;
+		uint64_t key_zero:1;
+		uint64_t ipd_drp:1;
+		uint64_t gmx_drp:2;
+		uint64_t trace:1;
+		uint64_t rml:1;
+		uint64_t twsi:1;
+		uint64_t reserved_44_44:1;
+		uint64_t pci_msi:4;
+		uint64_t pci_int:4;
+		uint64_t uart:2;
+		uint64_t mbox:2;
+		uint64_t gpio:16;
+		uint64_t workq:16;
+	} cn38xx;
+	struct cvmx_ciu_intx_en0_cn38xx cn38xxp2;
+	struct cvmx_ciu_intx_en0_cn30xx cn50xx;
+	struct cvmx_ciu_intx_en0_cn52xx {
+		uint64_t bootdma:1;
+		uint64_t mii:1;
+		uint64_t ipdppthr:1;
+		uint64_t powiq:1;
+		uint64_t twsi2:1;
+		uint64_t reserved_57_58:2;
+		uint64_t usb:1;
+		uint64_t timer:4;
+		uint64_t reserved_51_51:1;
+		uint64_t ipd_drp:1;
+		uint64_t reserved_49_49:1;
+		uint64_t gmx_drp:1;
+		uint64_t trace:1;
+		uint64_t rml:1;
+		uint64_t twsi:1;
+		uint64_t reserved_44_44:1;
+		uint64_t pci_msi:4;
+		uint64_t pci_int:4;
+		uint64_t uart:2;
+		uint64_t mbox:2;
+		uint64_t gpio:16;
+		uint64_t workq:16;
+	} cn52xx;
+	struct cvmx_ciu_intx_en0_cn52xx cn52xxp1;
+	struct cvmx_ciu_intx_en0_cn56xx {
+		uint64_t bootdma:1;
+		uint64_t mii:1;
+		uint64_t ipdppthr:1;
+		uint64_t powiq:1;
+		uint64_t twsi2:1;
+		uint64_t reserved_57_58:2;
+		uint64_t usb:1;
+		uint64_t timer:4;
+		uint64_t key_zero:1;
+		uint64_t ipd_drp:1;
+		uint64_t gmx_drp:2;
+		uint64_t trace:1;
+		uint64_t rml:1;
+		uint64_t twsi:1;
+		uint64_t reserved_44_44:1;
+		uint64_t pci_msi:4;
+		uint64_t pci_int:4;
+		uint64_t uart:2;
+		uint64_t mbox:2;
+		uint64_t gpio:16;
+		uint64_t workq:16;
+	} cn56xx;
+	struct cvmx_ciu_intx_en0_cn56xx cn56xxp1;
+	struct cvmx_ciu_intx_en0_cn38xx cn58xx;
+	struct cvmx_ciu_intx_en0_cn38xx cn58xxp1;
+};
+typedef union cvmx_ciu_intx_en0 cvmx_ciu_intx_en0_t;
+
+union cvmx_ciu_intx_en0_w1c {
+	uint64_t u64;
+	struct cvmx_ciu_intx_en0_w1c_s {
+		uint64_t bootdma:1;
+		uint64_t mii:1;
+		uint64_t ipdppthr:1;
+		uint64_t powiq:1;
+		uint64_t twsi2:1;
+		uint64_t reserved_57_58:2;
+		uint64_t usb:1;
+		uint64_t timer:4;
+		uint64_t key_zero:1;
+		uint64_t ipd_drp:1;
+		uint64_t gmx_drp:2;
+		uint64_t trace:1;
+		uint64_t rml:1;
+		uint64_t twsi:1;
+		uint64_t reserved_44_44:1;
+		uint64_t pci_msi:4;
+		uint64_t pci_int:4;
+		uint64_t uart:2;
+		uint64_t mbox:2;
+		uint64_t gpio:16;
+		uint64_t workq:16;
+	} s;
+	struct cvmx_ciu_intx_en0_w1c_cn52xx {
+		uint64_t bootdma:1;
+		uint64_t mii:1;
+		uint64_t ipdppthr:1;
+		uint64_t powiq:1;
+		uint64_t twsi2:1;
+		uint64_t reserved_57_58:2;
+		uint64_t usb:1;
+		uint64_t timer:4;
+		uint64_t reserved_51_51:1;
+		uint64_t ipd_drp:1;
+		uint64_t reserved_49_49:1;
+		uint64_t gmx_drp:1;
+		uint64_t trace:1;
+		uint64_t rml:1;
+		uint64_t twsi:1;
+		uint64_t reserved_44_44:1;
+		uint64_t pci_msi:4;
+		uint64_t pci_int:4;
+		uint64_t uart:2;
+		uint64_t mbox:2;
+		uint64_t gpio:16;
+		uint64_t workq:16;
+	} cn52xx;
+	struct cvmx_ciu_intx_en0_w1c_s cn56xx;
+	struct cvmx_ciu_intx_en0_w1c_cn58xx {
+		uint64_t reserved_56_63:8;
+		uint64_t timer:4;
+		uint64_t key_zero:1;
+		uint64_t ipd_drp:1;
+		uint64_t gmx_drp:2;
+		uint64_t trace:1;
+		uint64_t rml:1;
+		uint64_t twsi:1;
+		uint64_t reserved_44_44:1;
+		uint64_t pci_msi:4;
+		uint64_t pci_int:4;
+		uint64_t uart:2;
+		uint64_t mbox:2;
+		uint64_t gpio:16;
+		uint64_t workq:16;
+	} cn58xx;
+};
+typedef union cvmx_ciu_intx_en0_w1c cvmx_ciu_intx_en0_w1c_t;
+
+union cvmx_ciu_intx_en0_w1s {
+	uint64_t u64;
+	struct cvmx_ciu_intx_en0_w1s_s {
+		uint64_t bootdma:1;
+		uint64_t mii:1;
+		uint64_t ipdppthr:1;
+		uint64_t powiq:1;
+		uint64_t twsi2:1;
+		uint64_t reserved_57_58:2;
+		uint64_t usb:1;
+		uint64_t timer:4;
+		uint64_t key_zero:1;
+		uint64_t ipd_drp:1;
+		uint64_t gmx_drp:2;
+		uint64_t trace:1;
+		uint64_t rml:1;
+		uint64_t twsi:1;
+		uint64_t reserved_44_44:1;
+		uint64_t pci_msi:4;
+		uint64_t pci_int:4;
+		uint64_t uart:2;
+		uint64_t mbox:2;
+		uint64_t gpio:16;
+		uint64_t workq:16;
+	} s;
+	struct cvmx_ciu_intx_en0_w1s_cn52xx {
+		uint64_t bootdma:1;
+		uint64_t mii:1;
+		uint64_t ipdppthr:1;
+		uint64_t powiq:1;
+		uint64_t twsi2:1;
+		uint64_t reserved_57_58:2;
+		uint64_t usb:1;
+		uint64_t timer:4;
+		uint64_t reserved_51_51:1;
+		uint64_t ipd_drp:1;
+		uint64_t reserved_49_49:1;
+		uint64_t gmx_drp:1;
+		uint64_t trace:1;
+		uint64_t rml:1;
+		uint64_t twsi:1;
+		uint64_t reserved_44_44:1;
+		uint64_t pci_msi:4;
+		uint64_t pci_int:4;
+		uint64_t uart:2;
+		uint64_t mbox:2;
+		uint64_t gpio:16;
+		uint64_t workq:16;
+	} cn52xx;
+	struct cvmx_ciu_intx_en0_w1s_s cn56xx;
+	struct cvmx_ciu_intx_en0_w1s_cn58xx {
+		uint64_t reserved_56_63:8;
+		uint64_t timer:4;
+		uint64_t key_zero:1;
+		uint64_t ipd_drp:1;
+		uint64_t gmx_drp:2;
+		uint64_t trace:1;
+		uint64_t rml:1;
+		uint64_t twsi:1;
+		uint64_t reserved_44_44:1;
+		uint64_t pci_msi:4;
+		uint64_t pci_int:4;
+		uint64_t uart:2;
+		uint64_t mbox:2;
+		uint64_t gpio:16;
+		uint64_t workq:16;
+	} cn58xx;
+};
+typedef union cvmx_ciu_intx_en0_w1s cvmx_ciu_intx_en0_w1s_t;
+
+union cvmx_ciu_intx_en1 {
+	uint64_t u64;
+	struct cvmx_ciu_intx_en1_s {
+		uint64_t reserved_20_63:44;
+		uint64_t nand:1;
+		uint64_t mii1:1;
+		uint64_t usb1:1;
+		uint64_t uart2:1;
+		uint64_t wdog:16;
+	} s;
+	struct cvmx_ciu_intx_en1_cn30xx {
+		uint64_t reserved_1_63:63;
+		uint64_t wdog:1;
+	} cn30xx;
+	struct cvmx_ciu_intx_en1_cn31xx {
+		uint64_t reserved_2_63:62;
+		uint64_t wdog:2;
+	} cn31xx;
+	struct cvmx_ciu_intx_en1_cn38xx {
+		uint64_t reserved_16_63:48;
+		uint64_t wdog:16;
+	} cn38xx;
+	struct cvmx_ciu_intx_en1_cn38xx cn38xxp2;
+	struct cvmx_ciu_intx_en1_cn31xx cn50xx;
+	struct cvmx_ciu_intx_en1_cn52xx {
+		uint64_t reserved_20_63:44;
+		uint64_t nand:1;
+		uint64_t mii1:1;
+		uint64_t usb1:1;
+		uint64_t uart2:1;
+		uint64_t reserved_4_15:12;
+		uint64_t wdog:4;
+	} cn52xx;
+	struct cvmx_ciu_intx_en1_cn52xxp1 {
+		uint64_t reserved_19_63:45;
+		uint64_t mii1:1;
+		uint64_t usb1:1;
+		uint64_t uart2:1;
+		uint64_t reserved_4_15:12;
+		uint64_t wdog:4;
+	} cn52xxp1;
+	struct cvmx_ciu_intx_en1_cn56xx {
+		uint64_t reserved_12_63:52;
+		uint64_t wdog:12;
+	} cn56xx;
+	struct cvmx_ciu_intx_en1_cn56xx cn56xxp1;
+	struct cvmx_ciu_intx_en1_cn38xx cn58xx;
+	struct cvmx_ciu_intx_en1_cn38xx cn58xxp1;
+};
+typedef union cvmx_ciu_intx_en1 cvmx_ciu_intx_en1_t;
+
+union cvmx_ciu_intx_en1_w1c {
+	uint64_t u64;
+	struct cvmx_ciu_intx_en1_w1c_s {
+		uint64_t reserved_20_63:44;
+		uint64_t nand:1;
+		uint64_t mii1:1;
+		uint64_t usb1:1;
+		uint64_t uart2:1;
+		uint64_t wdog:16;
+	} s;
+	struct cvmx_ciu_intx_en1_w1c_cn52xx {
+		uint64_t reserved_20_63:44;
+		uint64_t nand:1;
+		uint64_t mii1:1;
+		uint64_t usb1:1;
+		uint64_t uart2:1;
+		uint64_t reserved_4_15:12;
+		uint64_t wdog:4;
+	} cn52xx;
+	struct cvmx_ciu_intx_en1_w1c_cn56xx {
+		uint64_t reserved_12_63:52;
+		uint64_t wdog:12;
+	} cn56xx;
+	struct cvmx_ciu_intx_en1_w1c_cn58xx {
+		uint64_t reserved_16_63:48;
+		uint64_t wdog:16;
+	} cn58xx;
+};
+typedef union cvmx_ciu_intx_en1_w1c cvmx_ciu_intx_en1_w1c_t;
+
+union cvmx_ciu_intx_en1_w1s {
+	uint64_t u64;
+	struct cvmx_ciu_intx_en1_w1s_s {
+		uint64_t reserved_20_63:44;
+		uint64_t nand:1;
+		uint64_t mii1:1;
+		uint64_t usb1:1;
+		uint64_t uart2:1;
+		uint64_t wdog:16;
+	} s;
+	struct cvmx_ciu_intx_en1_w1s_cn52xx {
+		uint64_t reserved_20_63:44;
+		uint64_t nand:1;
+		uint64_t mii1:1;
+		uint64_t usb1:1;
+		uint64_t uart2:1;
+		uint64_t reserved_4_15:12;
+		uint64_t wdog:4;
+	} cn52xx;
+	struct cvmx_ciu_intx_en1_w1s_cn56xx {
+		uint64_t reserved_12_63:52;
+		uint64_t wdog:12;
+	} cn56xx;
+	struct cvmx_ciu_intx_en1_w1s_cn58xx {
+		uint64_t reserved_16_63:48;
+		uint64_t wdog:16;
+	} cn58xx;
+};
+typedef union cvmx_ciu_intx_en1_w1s cvmx_ciu_intx_en1_w1s_t;
+
+union cvmx_ciu_intx_en4_0 {
+	uint64_t u64;
+	struct cvmx_ciu_intx_en4_0_s {
+		uint64_t bootdma:1;
+		uint64_t mii:1;
+		uint64_t ipdppthr:1;
+		uint64_t powiq:1;
+		uint64_t twsi2:1;
+		uint64_t mpi:1;
+		uint64_t pcm:1;
+		uint64_t usb:1;
+		uint64_t timer:4;
+		uint64_t key_zero:1;
+		uint64_t ipd_drp:1;
+		uint64_t gmx_drp:2;
+		uint64_t trace:1;
+		uint64_t rml:1;
+		uint64_t twsi:1;
+		uint64_t reserved_44_44:1;
+		uint64_t pci_msi:4;
+		uint64_t pci_int:4;
+		uint64_t uart:2;
+		uint64_t mbox:2;
+		uint64_t gpio:16;
+		uint64_t workq:16;
+	} s;
+	struct cvmx_ciu_intx_en4_0_cn50xx {
+		uint64_t reserved_59_63:5;
+		uint64_t mpi:1;
+		uint64_t pcm:1;
+		uint64_t usb:1;
+		uint64_t timer:4;
+		uint64_t reserved_51_51:1;
+		uint64_t ipd_drp:1;
+		uint64_t reserved_49_49:1;
+		uint64_t gmx_drp:1;
+		uint64_t reserved_47_47:1;
+		uint64_t rml:1;
+		uint64_t twsi:1;
+		uint64_t reserved_44_44:1;
+		uint64_t pci_msi:4;
+		uint64_t pci_int:4;
+		uint64_t uart:2;
+		uint64_t mbox:2;
+		uint64_t gpio:16;
+		uint64_t workq:16;
+	} cn50xx;
+	struct cvmx_ciu_intx_en4_0_cn52xx {
+		uint64_t bootdma:1;
+		uint64_t mii:1;
+		uint64_t ipdppthr:1;
+		uint64_t powiq:1;
+		uint64_t twsi2:1;
+		uint64_t reserved_57_58:2;
+		uint64_t usb:1;
+		uint64_t timer:4;
+		uint64_t reserved_51_51:1;
+		uint64_t ipd_drp:1;
+		uint64_t reserved_49_49:1;
+		uint64_t gmx_drp:1;
+		uint64_t trace:1;
+		uint64_t rml:1;
+		uint64_t twsi:1;
+		uint64_t reserved_44_44:1;
+		uint64_t pci_msi:4;
+		uint64_t pci_int:4;
+		uint64_t uart:2;
+		uint64_t mbox:2;
+		uint64_t gpio:16;
+		uint64_t workq:16;
+	} cn52xx;
+	struct cvmx_ciu_intx_en4_0_cn52xx cn52xxp1;
+	struct cvmx_ciu_intx_en4_0_cn56xx {
+		uint64_t bootdma:1;
+		uint64_t mii:1;
+		uint64_t ipdppthr:1;
+		uint64_t powiq:1;
+		uint64_t twsi2:1;
+		uint64_t reserved_57_58:2;
+		uint64_t usb:1;
+		uint64_t timer:4;
+		uint64_t key_zero:1;
+		uint64_t ipd_drp:1;
+		uint64_t gmx_drp:2;
+		uint64_t trace:1;
+		uint64_t rml:1;
+		uint64_t twsi:1;
+		uint64_t reserved_44_44:1;
+		uint64_t pci_msi:4;
+		uint64_t pci_int:4;
+		uint64_t uart:2;
+		uint64_t mbox:2;
+		uint64_t gpio:16;
+		uint64_t workq:16;
+	} cn56xx;
+	struct cvmx_ciu_intx_en4_0_cn56xx cn56xxp1;
+	struct cvmx_ciu_intx_en4_0_cn58xx {
+		uint64_t reserved_56_63:8;
+		uint64_t timer:4;
+		uint64_t key_zero:1;
+		uint64_t ipd_drp:1;
+		uint64_t gmx_drp:2;
+		uint64_t trace:1;
+		uint64_t rml:1;
+		uint64_t twsi:1;
+		uint64_t reserved_44_44:1;
+		uint64_t pci_msi:4;
+		uint64_t pci_int:4;
+		uint64_t uart:2;
+		uint64_t mbox:2;
+		uint64_t gpio:16;
+		uint64_t workq:16;
+	} cn58xx;
+	struct cvmx_ciu_intx_en4_0_cn58xx cn58xxp1;
+};
+typedef union cvmx_ciu_intx_en4_0 cvmx_ciu_intx_en4_0_t;
+
+union cvmx_ciu_intx_en4_0_w1c {
+	uint64_t u64;
+	struct cvmx_ciu_intx_en4_0_w1c_s {
+		uint64_t bootdma:1;
+		uint64_t mii:1;
+		uint64_t ipdppthr:1;
+		uint64_t powiq:1;
+		uint64_t twsi2:1;
+		uint64_t reserved_57_58:2;
+		uint64_t usb:1;
+		uint64_t timer:4;
+		uint64_t key_zero:1;
+		uint64_t ipd_drp:1;
+		uint64_t gmx_drp:2;
+		uint64_t trace:1;
+		uint64_t rml:1;
+		uint64_t twsi:1;
+		uint64_t reserved_44_44:1;
+		uint64_t pci_msi:4;
+		uint64_t pci_int:4;
+		uint64_t uart:2;
+		uint64_t mbox:2;
+		uint64_t gpio:16;
+		uint64_t workq:16;
+	} s;
+	struct cvmx_ciu_intx_en4_0_w1c_cn52xx {
+		uint64_t bootdma:1;
+		uint64_t mii:1;
+		uint64_t ipdppthr:1;
+		uint64_t powiq:1;
+		uint64_t twsi2:1;
+		uint64_t reserved_57_58:2;
+		uint64_t usb:1;
+		uint64_t timer:4;
+		uint64_t reserved_51_51:1;
+		uint64_t ipd_drp:1;
+		uint64_t reserved_49_49:1;
+		uint64_t gmx_drp:1;
+		uint64_t trace:1;
+		uint64_t rml:1;
+		uint64_t twsi:1;
+		uint64_t reserved_44_44:1;
+		uint64_t pci_msi:4;
+		uint64_t pci_int:4;
+		uint64_t uart:2;
+		uint64_t mbox:2;
+		uint64_t gpio:16;
+		uint64_t workq:16;
+	} cn52xx;
+	struct cvmx_ciu_intx_en4_0_w1c_s cn56xx;
+	struct cvmx_ciu_intx_en4_0_w1c_cn58xx {
+		uint64_t reserved_56_63:8;
+		uint64_t timer:4;
+		uint64_t key_zero:1;
+		uint64_t ipd_drp:1;
+		uint64_t gmx_drp:2;
+		uint64_t trace:1;
+		uint64_t rml:1;
+		uint64_t twsi:1;
+		uint64_t reserved_44_44:1;
+		uint64_t pci_msi:4;
+		uint64_t pci_int:4;
+		uint64_t uart:2;
+		uint64_t mbox:2;
+		uint64_t gpio:16;
+		uint64_t workq:16;
+	} cn58xx;
+};
+typedef union cvmx_ciu_intx_en4_0_w1c cvmx_ciu_intx_en4_0_w1c_t;
+
+union cvmx_ciu_intx_en4_0_w1s {
+	uint64_t u64;
+	struct cvmx_ciu_intx_en4_0_w1s_s {
+		uint64_t bootdma:1;
+		uint64_t mii:1;
+		uint64_t ipdppthr:1;
+		uint64_t powiq:1;
+		uint64_t twsi2:1;
+		uint64_t reserved_57_58:2;
+		uint64_t usb:1;
+		uint64_t timer:4;
+		uint64_t key_zero:1;
+		uint64_t ipd_drp:1;
+		uint64_t gmx_drp:2;
+		uint64_t trace:1;
+		uint64_t rml:1;
+		uint64_t twsi:1;
+		uint64_t reserved_44_44:1;
+		uint64_t pci_msi:4;
+		uint64_t pci_int:4;
+		uint64_t uart:2;
+		uint64_t mbox:2;
+		uint64_t gpio:16;
+		uint64_t workq:16;
+	} s;
+	struct cvmx_ciu_intx_en4_0_w1s_cn52xx {
+		uint64_t bootdma:1;
+		uint64_t mii:1;
+		uint64_t ipdppthr:1;
+		uint64_t powiq:1;
+		uint64_t twsi2:1;
+		uint64_t reserved_57_58:2;
+		uint64_t usb:1;
+		uint64_t timer:4;
+		uint64_t reserved_51_51:1;
+		uint64_t ipd_drp:1;
+		uint64_t reserved_49_49:1;
+		uint64_t gmx_drp:1;
+		uint64_t trace:1;
+		uint64_t rml:1;
+		uint64_t twsi:1;
+		uint64_t reserved_44_44:1;
+		uint64_t pci_msi:4;
+		uint64_t pci_int:4;
+		uint64_t uart:2;
+		uint64_t mbox:2;
+		uint64_t gpio:16;
+		uint64_t workq:16;
+	} cn52xx;
+	struct cvmx_ciu_intx_en4_0_w1s_s cn56xx;
+	struct cvmx_ciu_intx_en4_0_w1s_cn58xx {
+		uint64_t reserved_56_63:8;
+		uint64_t timer:4;
+		uint64_t key_zero:1;
+		uint64_t ipd_drp:1;
+		uint64_t gmx_drp:2;
+		uint64_t trace:1;
+		uint64_t rml:1;
+		uint64_t twsi:1;
+		uint64_t reserved_44_44:1;
+		uint64_t pci_msi:4;
+		uint64_t pci_int:4;
+		uint64_t uart:2;
+		uint64_t mbox:2;
+		uint64_t gpio:16;
+		uint64_t workq:16;
+	} cn58xx;
+};
+typedef union cvmx_ciu_intx_en4_0_w1s cvmx_ciu_intx_en4_0_w1s_t;
+
+union cvmx_ciu_intx_en4_1 {
+	uint64_t u64;
+	struct cvmx_ciu_intx_en4_1_s {
+		uint64_t reserved_20_63:44;
+		uint64_t nand:1;
+		uint64_t mii1:1;
+		uint64_t usb1:1;
+		uint64_t uart2:1;
+		uint64_t wdog:16;
+	} s;
+	struct cvmx_ciu_intx_en4_1_cn50xx {
+		uint64_t reserved_2_63:62;
+		uint64_t wdog:2;
+	} cn50xx;
+	struct cvmx_ciu_intx_en4_1_cn52xx {
+		uint64_t reserved_20_63:44;
+		uint64_t nand:1;
+		uint64_t mii1:1;
+		uint64_t usb1:1;
+		uint64_t uart2:1;
+		uint64_t reserved_4_15:12;
+		uint64_t wdog:4;
+	} cn52xx;
+	struct cvmx_ciu_intx_en4_1_cn52xxp1 {
+		uint64_t reserved_19_63:45;
+		uint64_t mii1:1;
+		uint64_t usb1:1;
+		uint64_t uart2:1;
+		uint64_t reserved_4_15:12;
+		uint64_t wdog:4;
+	} cn52xxp1;
+	struct cvmx_ciu_intx_en4_1_cn56xx {
+		uint64_t reserved_12_63:52;
+		uint64_t wdog:12;
+	} cn56xx;
+	struct cvmx_ciu_intx_en4_1_cn56xx cn56xxp1;
+	struct cvmx_ciu_intx_en4_1_cn58xx {
+		uint64_t reserved_16_63:48;
+		uint64_t wdog:16;
+	} cn58xx;
+	struct cvmx_ciu_intx_en4_1_cn58xx cn58xxp1;
+};
+typedef union cvmx_ciu_intx_en4_1 cvmx_ciu_intx_en4_1_t;
+
+union cvmx_ciu_intx_en4_1_w1c {
+	uint64_t u64;
+	struct cvmx_ciu_intx_en4_1_w1c_s {
+		uint64_t reserved_20_63:44;
+		uint64_t nand:1;
+		uint64_t mii1:1;
+		uint64_t usb1:1;
+		uint64_t uart2:1;
+		uint64_t wdog:16;
+	} s;
+	struct cvmx_ciu_intx_en4_1_w1c_cn52xx {
+		uint64_t reserved_20_63:44;
+		uint64_t nand:1;
+		uint64_t mii1:1;
+		uint64_t usb1:1;
+		uint64_t uart2:1;
+		uint64_t reserved_4_15:12;
+		uint64_t wdog:4;
+	} cn52xx;
+	struct cvmx_ciu_intx_en4_1_w1c_cn56xx {
+		uint64_t reserved_12_63:52;
+		uint64_t wdog:12;
+	} cn56xx;
+	struct cvmx_ciu_intx_en4_1_w1c_cn58xx {
+		uint64_t reserved_16_63:48;
+		uint64_t wdog:16;
+	} cn58xx;
+};
+typedef union cvmx_ciu_intx_en4_1_w1c cvmx_ciu_intx_en4_1_w1c_t;
+
+union cvmx_ciu_intx_en4_1_w1s {
+	uint64_t u64;
+	struct cvmx_ciu_intx_en4_1_w1s_s {
+		uint64_t reserved_20_63:44;
+		uint64_t nand:1;
+		uint64_t mii1:1;
+		uint64_t usb1:1;
+		uint64_t uart2:1;
+		uint64_t wdog:16;
+	} s;
+	struct cvmx_ciu_intx_en4_1_w1s_cn52xx {
+		uint64_t reserved_20_63:44;
+		uint64_t nand:1;
+		uint64_t mii1:1;
+		uint64_t usb1:1;
+		uint64_t uart2:1;
+		uint64_t reserved_4_15:12;
+		uint64_t wdog:4;
+	} cn52xx;
+	struct cvmx_ciu_intx_en4_1_w1s_cn56xx {
+		uint64_t reserved_12_63:52;
+		uint64_t wdog:12;
+	} cn56xx;
+	struct cvmx_ciu_intx_en4_1_w1s_cn58xx {
+		uint64_t reserved_16_63:48;
+		uint64_t wdog:16;
+	} cn58xx;
+};
+typedef union cvmx_ciu_intx_en4_1_w1s cvmx_ciu_intx_en4_1_w1s_t;
+
+union cvmx_ciu_intx_sum0 {
+	uint64_t u64;
+	struct cvmx_ciu_intx_sum0_s {
+		uint64_t bootdma:1;
+		uint64_t mii:1;
+		uint64_t ipdppthr:1;
+		uint64_t powiq:1;
+		uint64_t twsi2:1;
+		uint64_t mpi:1;
+		uint64_t pcm:1;
+		uint64_t usb:1;
+		uint64_t timer:4;
+		uint64_t key_zero:1;
+		uint64_t ipd_drp:1;
+		uint64_t gmx_drp:2;
+		uint64_t trace:1;
+		uint64_t rml:1;
+		uint64_t twsi:1;
+		uint64_t wdog_sum:1;
+		uint64_t pci_msi:4;
+		uint64_t pci_int:4;
+		uint64_t uart:2;
+		uint64_t mbox:2;
+		uint64_t gpio:16;
+		uint64_t workq:16;
+	} s;
+	struct cvmx_ciu_intx_sum0_cn30xx {
+		uint64_t reserved_59_63:5;
+		uint64_t mpi:1;
+		uint64_t pcm:1;
+		uint64_t usb:1;
+		uint64_t timer:4;
+		uint64_t reserved_51_51:1;
+		uint64_t ipd_drp:1;
+		uint64_t reserved_49_49:1;
+		uint64_t gmx_drp:1;
+		uint64_t reserved_47_47:1;
+		uint64_t rml:1;
+		uint64_t twsi:1;
+		uint64_t wdog_sum:1;
+		uint64_t pci_msi:4;
+		uint64_t pci_int:4;
+		uint64_t uart:2;
+		uint64_t mbox:2;
+		uint64_t gpio:16;
+		uint64_t workq:16;
+	} cn30xx;
+	struct cvmx_ciu_intx_sum0_cn31xx {
+		uint64_t reserved_59_63:5;
+		uint64_t mpi:1;
+		uint64_t pcm:1;
+		uint64_t usb:1;
+		uint64_t timer:4;
+		uint64_t reserved_51_51:1;
+		uint64_t ipd_drp:1;
+		uint64_t reserved_49_49:1;
+		uint64_t gmx_drp:1;
+		uint64_t trace:1;
+		uint64_t rml:1;
+		uint64_t twsi:1;
+		uint64_t wdog_sum:1;
+		uint64_t pci_msi:4;
+		uint64_t pci_int:4;
+		uint64_t uart:2;
+		uint64_t mbox:2;
+		uint64_t gpio:16;
+		uint64_t workq:16;
+	} cn31xx;
+	struct cvmx_ciu_intx_sum0_cn38xx {
+		uint64_t reserved_56_63:8;
+		uint64_t timer:4;
+		uint64_t key_zero:1;
+		uint64_t ipd_drp:1;
+		uint64_t gmx_drp:2;
+		uint64_t trace:1;
+		uint64_t rml:1;
+		uint64_t twsi:1;
+		uint64_t wdog_sum:1;
+		uint64_t pci_msi:4;
+		uint64_t pci_int:4;
+		uint64_t uart:2;
+		uint64_t mbox:2;
+		uint64_t gpio:16;
+		uint64_t workq:16;
+	} cn38xx;
+	struct cvmx_ciu_intx_sum0_cn38xx cn38xxp2;
+	struct cvmx_ciu_intx_sum0_cn30xx cn50xx;
+	struct cvmx_ciu_intx_sum0_cn52xx {
+		uint64_t bootdma:1;
+		uint64_t mii:1;
+		uint64_t ipdppthr:1;
+		uint64_t powiq:1;
+		uint64_t twsi2:1;
+		uint64_t reserved_57_58:2;
+		uint64_t usb:1;
+		uint64_t timer:4;
+		uint64_t reserved_51_51:1;
+		uint64_t ipd_drp:1;
+		uint64_t reserved_49_49:1;
+		uint64_t gmx_drp:1;
+		uint64_t trace:1;
+		uint64_t rml:1;
+		uint64_t twsi:1;
+		uint64_t wdog_sum:1;
+		uint64_t pci_msi:4;
+		uint64_t pci_int:4;
+		uint64_t uart:2;
+		uint64_t mbox:2;
+		uint64_t gpio:16;
+		uint64_t workq:16;
+	} cn52xx;
+	struct cvmx_ciu_intx_sum0_cn52xx cn52xxp1;
+	struct cvmx_ciu_intx_sum0_cn56xx {
+		uint64_t bootdma:1;
+		uint64_t mii:1;
+		uint64_t ipdppthr:1;
+		uint64_t powiq:1;
+		uint64_t twsi2:1;
+		uint64_t reserved_57_58:2;
+		uint64_t usb:1;
+		uint64_t timer:4;
+		uint64_t key_zero:1;
+		uint64_t ipd_drp:1;
+		uint64_t gmx_drp:2;
+		uint64_t trace:1;
+		uint64_t rml:1;
+		uint64_t twsi:1;
+		uint64_t wdog_sum:1;
+		uint64_t pci_msi:4;
+		uint64_t pci_int:4;
+		uint64_t uart:2;
+		uint64_t mbox:2;
+		uint64_t gpio:16;
+		uint64_t workq:16;
+	} cn56xx;
+	struct cvmx_ciu_intx_sum0_cn56xx cn56xxp1;
+	struct cvmx_ciu_intx_sum0_cn38xx cn58xx;
+	struct cvmx_ciu_intx_sum0_cn38xx cn58xxp1;
+};
+typedef union cvmx_ciu_intx_sum0 cvmx_ciu_intx_sum0_t;
+
+union cvmx_ciu_intx_sum4 {
+	uint64_t u64;
+	struct cvmx_ciu_intx_sum4_s {
+		uint64_t bootdma:1;
+		uint64_t mii:1;
+		uint64_t ipdppthr:1;
+		uint64_t powiq:1;
+		uint64_t twsi2:1;
+		uint64_t mpi:1;
+		uint64_t pcm:1;
+		uint64_t usb:1;
+		uint64_t timer:4;
+		uint64_t key_zero:1;
+		uint64_t ipd_drp:1;
+		uint64_t gmx_drp:2;
+		uint64_t trace:1;
+		uint64_t rml:1;
+		uint64_t twsi:1;
+		uint64_t wdog_sum:1;
+		uint64_t pci_msi:4;
+		uint64_t pci_int:4;
+		uint64_t uart:2;
+		uint64_t mbox:2;
+		uint64_t gpio:16;
+		uint64_t workq:16;
+	} s;
+	struct cvmx_ciu_intx_sum4_cn50xx {
+		uint64_t reserved_59_63:5;
+		uint64_t mpi:1;
+		uint64_t pcm:1;
+		uint64_t usb:1;
+		uint64_t timer:4;
+		uint64_t reserved_51_51:1;
+		uint64_t ipd_drp:1;
+		uint64_t reserved_49_49:1;
+		uint64_t gmx_drp:1;
+		uint64_t reserved_47_47:1;
+		uint64_t rml:1;
+		uint64_t twsi:1;
+		uint64_t wdog_sum:1;
+		uint64_t pci_msi:4;
+		uint64_t pci_int:4;
+		uint64_t uart:2;
+		uint64_t mbox:2;
+		uint64_t gpio:16;
+		uint64_t workq:16;
+	} cn50xx;
+	struct cvmx_ciu_intx_sum4_cn52xx {
+		uint64_t bootdma:1;
+		uint64_t mii:1;
+		uint64_t ipdppthr:1;
+		uint64_t powiq:1;
+		uint64_t twsi2:1;
+		uint64_t reserved_57_58:2;
+		uint64_t usb:1;
+		uint64_t timer:4;
+		uint64_t reserved_51_51:1;
+		uint64_t ipd_drp:1;
+		uint64_t reserved_49_49:1;
+		uint64_t gmx_drp:1;
+		uint64_t trace:1;
+		uint64_t rml:1;
+		uint64_t twsi:1;
+		uint64_t wdog_sum:1;
+		uint64_t pci_msi:4;
+		uint64_t pci_int:4;
+		uint64_t uart:2;
+		uint64_t mbox:2;
+		uint64_t gpio:16;
+		uint64_t workq:16;
+	} cn52xx;
+	struct cvmx_ciu_intx_sum4_cn52xx cn52xxp1;
+	struct cvmx_ciu_intx_sum4_cn56xx {
+		uint64_t bootdma:1;
+		uint64_t mii:1;
+		uint64_t ipdppthr:1;
+		uint64_t powiq:1;
+		uint64_t twsi2:1;
+		uint64_t reserved_57_58:2;
+		uint64_t usb:1;
+		uint64_t timer:4;
+		uint64_t key_zero:1;
+		uint64_t ipd_drp:1;
+		uint64_t gmx_drp:2;
+		uint64_t trace:1;
+		uint64_t rml:1;
+		uint64_t twsi:1;
+		uint64_t wdog_sum:1;
+		uint64_t pci_msi:4;
+		uint64_t pci_int:4;
+		uint64_t uart:2;
+		uint64_t mbox:2;
+		uint64_t gpio:16;
+		uint64_t workq:16;
+	} cn56xx;
+	struct cvmx_ciu_intx_sum4_cn56xx cn56xxp1;
+	struct cvmx_ciu_intx_sum4_cn58xx {
+		uint64_t reserved_56_63:8;
+		uint64_t timer:4;
+		uint64_t key_zero:1;
+		uint64_t ipd_drp:1;
+		uint64_t gmx_drp:2;
+		uint64_t trace:1;
+		uint64_t rml:1;
+		uint64_t twsi:1;
+		uint64_t wdog_sum:1;
+		uint64_t pci_msi:4;
+		uint64_t pci_int:4;
+		uint64_t uart:2;
+		uint64_t mbox:2;
+		uint64_t gpio:16;
+		uint64_t workq:16;
+	} cn58xx;
+	struct cvmx_ciu_intx_sum4_cn58xx cn58xxp1;
+};
+typedef union cvmx_ciu_intx_sum4 cvmx_ciu_intx_sum4_t;
+
+union cvmx_ciu_int_sum1 {
+	uint64_t u64;
+	struct cvmx_ciu_int_sum1_s {
+		uint64_t reserved_20_63:44;
+		uint64_t nand:1;
+		uint64_t mii1:1;
+		uint64_t usb1:1;
+		uint64_t uart2:1;
+		uint64_t wdog:16;
+	} s;
+	struct cvmx_ciu_int_sum1_cn30xx {
+		uint64_t reserved_1_63:63;
+		uint64_t wdog:1;
+	} cn30xx;
+	struct cvmx_ciu_int_sum1_cn31xx {
+		uint64_t reserved_2_63:62;
+		uint64_t wdog:2;
+	} cn31xx;
+	struct cvmx_ciu_int_sum1_cn38xx {
+		uint64_t reserved_16_63:48;
+		uint64_t wdog:16;
+	} cn38xx;
+	struct cvmx_ciu_int_sum1_cn38xx cn38xxp2;
+	struct cvmx_ciu_int_sum1_cn31xx cn50xx;
+	struct cvmx_ciu_int_sum1_cn52xx {
+		uint64_t reserved_20_63:44;
+		uint64_t nand:1;
+		uint64_t mii1:1;
+		uint64_t usb1:1;
+		uint64_t uart2:1;
+		uint64_t reserved_4_15:12;
+		uint64_t wdog:4;
+	} cn52xx;
+	struct cvmx_ciu_int_sum1_cn52xxp1 {
+		uint64_t reserved_19_63:45;
+		uint64_t mii1:1;
+		uint64_t usb1:1;
+		uint64_t uart2:1;
+		uint64_t reserved_4_15:12;
+		uint64_t wdog:4;
+	} cn52xxp1;
+	struct cvmx_ciu_int_sum1_cn56xx {
+		uint64_t reserved_12_63:52;
+		uint64_t wdog:12;
+	} cn56xx;
+	struct cvmx_ciu_int_sum1_cn56xx cn56xxp1;
+	struct cvmx_ciu_int_sum1_cn38xx cn58xx;
+	struct cvmx_ciu_int_sum1_cn38xx cn58xxp1;
+};
+typedef union cvmx_ciu_int_sum1 cvmx_ciu_int_sum1_t;
+
+union cvmx_ciu_mbox_clrx {
+	uint64_t u64;
+	struct cvmx_ciu_mbox_clrx_s {
+		uint64_t reserved_32_63:32;
+		uint64_t bits:32;
+	} s;
+	struct cvmx_ciu_mbox_clrx_s cn30xx;
+	struct cvmx_ciu_mbox_clrx_s cn31xx;
+	struct cvmx_ciu_mbox_clrx_s cn38xx;
+	struct cvmx_ciu_mbox_clrx_s cn38xxp2;
+	struct cvmx_ciu_mbox_clrx_s cn50xx;
+	struct cvmx_ciu_mbox_clrx_s cn52xx;
+	struct cvmx_ciu_mbox_clrx_s cn52xxp1;
+	struct cvmx_ciu_mbox_clrx_s cn56xx;
+	struct cvmx_ciu_mbox_clrx_s cn56xxp1;
+	struct cvmx_ciu_mbox_clrx_s cn58xx;
+	struct cvmx_ciu_mbox_clrx_s cn58xxp1;
+};
+typedef union cvmx_ciu_mbox_clrx cvmx_ciu_mbox_clrx_t;
+
+union cvmx_ciu_mbox_setx {
+	uint64_t u64;
+	struct cvmx_ciu_mbox_setx_s {
+		uint64_t reserved_32_63:32;
+		uint64_t bits:32;
+	} s;
+	struct cvmx_ciu_mbox_setx_s cn30xx;
+	struct cvmx_ciu_mbox_setx_s cn31xx;
+	struct cvmx_ciu_mbox_setx_s cn38xx;
+	struct cvmx_ciu_mbox_setx_s cn38xxp2;
+	struct cvmx_ciu_mbox_setx_s cn50xx;
+	struct cvmx_ciu_mbox_setx_s cn52xx;
+	struct cvmx_ciu_mbox_setx_s cn52xxp1;
+	struct cvmx_ciu_mbox_setx_s cn56xx;
+	struct cvmx_ciu_mbox_setx_s cn56xxp1;
+	struct cvmx_ciu_mbox_setx_s cn58xx;
+	struct cvmx_ciu_mbox_setx_s cn58xxp1;
+};
+typedef union cvmx_ciu_mbox_setx cvmx_ciu_mbox_setx_t;
+
+union cvmx_ciu_nmi {
+	uint64_t u64;
+	struct cvmx_ciu_nmi_s {
+		uint64_t reserved_16_63:48;
+		uint64_t nmi:16;
+	} s;
+	struct cvmx_ciu_nmi_cn30xx {
+		uint64_t reserved_1_63:63;
+		uint64_t nmi:1;
+	} cn30xx;
+	struct cvmx_ciu_nmi_cn31xx {
+		uint64_t reserved_2_63:62;
+		uint64_t nmi:2;
+	} cn31xx;
+	struct cvmx_ciu_nmi_s cn38xx;
+	struct cvmx_ciu_nmi_s cn38xxp2;
+	struct cvmx_ciu_nmi_cn31xx cn50xx;
+	struct cvmx_ciu_nmi_cn52xx {
+		uint64_t reserved_4_63:60;
+		uint64_t nmi:4;
+	} cn52xx;
+	struct cvmx_ciu_nmi_cn52xx cn52xxp1;
+	struct cvmx_ciu_nmi_cn56xx {
+		uint64_t reserved_12_63:52;
+		uint64_t nmi:12;
+	} cn56xx;
+	struct cvmx_ciu_nmi_cn56xx cn56xxp1;
+	struct cvmx_ciu_nmi_s cn58xx;
+	struct cvmx_ciu_nmi_s cn58xxp1;
+};
+typedef union cvmx_ciu_nmi cvmx_ciu_nmi_t;
+
+union cvmx_ciu_pci_inta {
+	uint64_t u64;
+	struct cvmx_ciu_pci_inta_s {
+		uint64_t reserved_2_63:62;
+		uint64_t intr:2;
+	} s;
+	struct cvmx_ciu_pci_inta_s cn30xx;
+	struct cvmx_ciu_pci_inta_s cn31xx;
+	struct cvmx_ciu_pci_inta_s cn38xx;
+	struct cvmx_ciu_pci_inta_s cn38xxp2;
+	struct cvmx_ciu_pci_inta_s cn50xx;
+	struct cvmx_ciu_pci_inta_s cn52xx;
+	struct cvmx_ciu_pci_inta_s cn52xxp1;
+	struct cvmx_ciu_pci_inta_s cn56xx;
+	struct cvmx_ciu_pci_inta_s cn56xxp1;
+	struct cvmx_ciu_pci_inta_s cn58xx;
+	struct cvmx_ciu_pci_inta_s cn58xxp1;
+};
+typedef union cvmx_ciu_pci_inta cvmx_ciu_pci_inta_t;
+
+union cvmx_ciu_pp_dbg {
+	uint64_t u64;
+	struct cvmx_ciu_pp_dbg_s {
+		uint64_t reserved_16_63:48;
+		uint64_t ppdbg:16;
+	} s;
+	struct cvmx_ciu_pp_dbg_cn30xx {
+		uint64_t reserved_1_63:63;
+		uint64_t ppdbg:1;
+	} cn30xx;
+	struct cvmx_ciu_pp_dbg_cn31xx {
+		uint64_t reserved_2_63:62;
+		uint64_t ppdbg:2;
+	} cn31xx;
+	struct cvmx_ciu_pp_dbg_s cn38xx;
+	struct cvmx_ciu_pp_dbg_s cn38xxp2;
+	struct cvmx_ciu_pp_dbg_cn31xx cn50xx;
+	struct cvmx_ciu_pp_dbg_cn52xx {
+		uint64_t reserved_4_63:60;
+		uint64_t ppdbg:4;
+	} cn52xx;
+	struct cvmx_ciu_pp_dbg_cn52xx cn52xxp1;
+	struct cvmx_ciu_pp_dbg_cn56xx {
+		uint64_t reserved_12_63:52;
+		uint64_t ppdbg:12;
+	} cn56xx;
+	struct cvmx_ciu_pp_dbg_cn56xx cn56xxp1;
+	struct cvmx_ciu_pp_dbg_s cn58xx;
+	struct cvmx_ciu_pp_dbg_s cn58xxp1;
+};
+typedef union cvmx_ciu_pp_dbg cvmx_ciu_pp_dbg_t;
+
+union cvmx_ciu_pp_pokex {
+	uint64_t u64;
+	struct cvmx_ciu_pp_pokex_s {
+		uint64_t reserved_0_63:64;
+	} s;
+	struct cvmx_ciu_pp_pokex_s cn30xx;
+	struct cvmx_ciu_pp_pokex_s cn31xx;
+	struct cvmx_ciu_pp_pokex_s cn38xx;
+	struct cvmx_ciu_pp_pokex_s cn38xxp2;
+	struct cvmx_ciu_pp_pokex_s cn50xx;
+	struct cvmx_ciu_pp_pokex_s cn52xx;
+	struct cvmx_ciu_pp_pokex_s cn52xxp1;
+	struct cvmx_ciu_pp_pokex_s cn56xx;
+	struct cvmx_ciu_pp_pokex_s cn56xxp1;
+	struct cvmx_ciu_pp_pokex_s cn58xx;
+	struct cvmx_ciu_pp_pokex_s cn58xxp1;
+};
+typedef union cvmx_ciu_pp_pokex cvmx_ciu_pp_pokex_t;
+
+union cvmx_ciu_pp_rst {
+	uint64_t u64;
+	struct cvmx_ciu_pp_rst_s {
+		uint64_t reserved_16_63:48;
+		uint64_t rst:15;
+		uint64_t rst0:1;
+	} s;
+	struct cvmx_ciu_pp_rst_cn30xx {
+		uint64_t reserved_1_63:63;
+		uint64_t rst0:1;
+	} cn30xx;
+	struct cvmx_ciu_pp_rst_cn31xx {
+		uint64_t reserved_2_63:62;
+		uint64_t rst:1;
+		uint64_t rst0:1;
+	} cn31xx;
+	struct cvmx_ciu_pp_rst_s cn38xx;
+	struct cvmx_ciu_pp_rst_s cn38xxp2;
+	struct cvmx_ciu_pp_rst_cn31xx cn50xx;
+	struct cvmx_ciu_pp_rst_cn52xx {
+		uint64_t reserved_4_63:60;
+		uint64_t rst:3;
+		uint64_t rst0:1;
+	} cn52xx;
+	struct cvmx_ciu_pp_rst_cn52xx cn52xxp1;
+	struct cvmx_ciu_pp_rst_cn56xx {
+		uint64_t reserved_12_63:52;
+		uint64_t rst:11;
+		uint64_t rst0:1;
+	} cn56xx;
+	struct cvmx_ciu_pp_rst_cn56xx cn56xxp1;
+	struct cvmx_ciu_pp_rst_s cn58xx;
+	struct cvmx_ciu_pp_rst_s cn58xxp1;
+};
+typedef union cvmx_ciu_pp_rst cvmx_ciu_pp_rst_t;
+
+union cvmx_ciu_qlm_dcok {
+	uint64_t u64;
+	struct cvmx_ciu_qlm_dcok_s {
+		uint64_t reserved_4_63:60;
+		uint64_t qlm_dcok:4;
+	} s;
+	struct cvmx_ciu_qlm_dcok_cn52xx {
+		uint64_t reserved_2_63:62;
+		uint64_t qlm_dcok:2;
+	} cn52xx;
+	struct cvmx_ciu_qlm_dcok_cn52xx cn52xxp1;
+	struct cvmx_ciu_qlm_dcok_s cn56xx;
+	struct cvmx_ciu_qlm_dcok_s cn56xxp1;
+};
+typedef union cvmx_ciu_qlm_dcok cvmx_ciu_qlm_dcok_t;
+
+union cvmx_ciu_qlm_jtgc {
+	uint64_t u64;
+	struct cvmx_ciu_qlm_jtgc_s {
+		uint64_t reserved_11_63:53;
+		uint64_t clk_div:3;
+		uint64_t reserved_6_7:2;
+		uint64_t mux_sel:2;
+		uint64_t bypass:4;
+	} s;
+	struct cvmx_ciu_qlm_jtgc_cn52xx {
+		uint64_t reserved_11_63:53;
+		uint64_t clk_div:3;
+		uint64_t reserved_5_7:3;
+		uint64_t mux_sel:1;
+		uint64_t reserved_2_3:2;
+		uint64_t bypass:2;
+	} cn52xx;
+	struct cvmx_ciu_qlm_jtgc_cn52xx cn52xxp1;
+	struct cvmx_ciu_qlm_jtgc_s cn56xx;
+	struct cvmx_ciu_qlm_jtgc_s cn56xxp1;
+};
+typedef union cvmx_ciu_qlm_jtgc cvmx_ciu_qlm_jtgc_t;
+
+union cvmx_ciu_qlm_jtgd {
+	uint64_t u64;
+	struct cvmx_ciu_qlm_jtgd_s {
+		uint64_t capture:1;
+		uint64_t shift:1;
+		uint64_t update:1;
+		uint64_t reserved_44_60:17;
+		uint64_t select:4;
+		uint64_t reserved_37_39:3;
+		uint64_t shft_cnt:5;
+		uint64_t shft_reg:32;
+	} s;
+	struct cvmx_ciu_qlm_jtgd_cn52xx {
+		uint64_t capture:1;
+		uint64_t shift:1;
+		uint64_t update:1;
+		uint64_t reserved_42_60:19;
+		uint64_t select:2;
+		uint64_t reserved_37_39:3;
+		uint64_t shft_cnt:5;
+		uint64_t shft_reg:32;
+	} cn52xx;
+	struct cvmx_ciu_qlm_jtgd_cn52xx cn52xxp1;
+	struct cvmx_ciu_qlm_jtgd_s cn56xx;
+	struct cvmx_ciu_qlm_jtgd_cn56xxp1 {
+		uint64_t capture:1;
+		uint64_t shift:1;
+		uint64_t update:1;
+		uint64_t reserved_37_60:24;
+		uint64_t shft_cnt:5;
+		uint64_t shft_reg:32;
+	} cn56xxp1;
+};
+typedef union cvmx_ciu_qlm_jtgd cvmx_ciu_qlm_jtgd_t;
+
+union cvmx_ciu_soft_bist {
+	uint64_t u64;
+	struct cvmx_ciu_soft_bist_s {
+		uint64_t reserved_1_63:63;
+		uint64_t soft_bist:1;
+	} s;
+	struct cvmx_ciu_soft_bist_s cn30xx;
+	struct cvmx_ciu_soft_bist_s cn31xx;
+	struct cvmx_ciu_soft_bist_s cn38xx;
+	struct cvmx_ciu_soft_bist_s cn38xxp2;
+	struct cvmx_ciu_soft_bist_s cn50xx;
+	struct cvmx_ciu_soft_bist_s cn52xx;
+	struct cvmx_ciu_soft_bist_s cn52xxp1;
+	struct cvmx_ciu_soft_bist_s cn56xx;
+	struct cvmx_ciu_soft_bist_s cn56xxp1;
+	struct cvmx_ciu_soft_bist_s cn58xx;
+	struct cvmx_ciu_soft_bist_s cn58xxp1;
+};
+typedef union cvmx_ciu_soft_bist cvmx_ciu_soft_bist_t;
+
+union cvmx_ciu_soft_prst {
+	uint64_t u64;
+	struct cvmx_ciu_soft_prst_s {
+		uint64_t reserved_3_63:61;
+		uint64_t host64:1;
+		uint64_t npi:1;
+		uint64_t soft_prst:1;
+	} s;
+	struct cvmx_ciu_soft_prst_s cn30xx;
+	struct cvmx_ciu_soft_prst_s cn31xx;
+	struct cvmx_ciu_soft_prst_s cn38xx;
+	struct cvmx_ciu_soft_prst_s cn38xxp2;
+	struct cvmx_ciu_soft_prst_s cn50xx;
+	struct cvmx_ciu_soft_prst_cn52xx {
+		uint64_t reserved_1_63:63;
+		uint64_t soft_prst:1;
+	} cn52xx;
+	struct cvmx_ciu_soft_prst_cn52xx cn52xxp1;
+	struct cvmx_ciu_soft_prst_cn52xx cn56xx;
+	struct cvmx_ciu_soft_prst_cn52xx cn56xxp1;
+	struct cvmx_ciu_soft_prst_s cn58xx;
+	struct cvmx_ciu_soft_prst_s cn58xxp1;
+};
+typedef union cvmx_ciu_soft_prst cvmx_ciu_soft_prst_t;
+
+union cvmx_ciu_soft_prst1 {
+	uint64_t u64;
+	struct cvmx_ciu_soft_prst1_s {
+		uint64_t reserved_1_63:63;
+		uint64_t soft_prst:1;
+	} s;
+	struct cvmx_ciu_soft_prst1_s cn52xx;
+	struct cvmx_ciu_soft_prst1_s cn52xxp1;
+	struct cvmx_ciu_soft_prst1_s cn56xx;
+	struct cvmx_ciu_soft_prst1_s cn56xxp1;
+};
+typedef union cvmx_ciu_soft_prst1 cvmx_ciu_soft_prst1_t;
+
+union cvmx_ciu_soft_rst {
+	uint64_t u64;
+	struct cvmx_ciu_soft_rst_s {
+		uint64_t reserved_1_63:63;
+		uint64_t soft_rst:1;
+	} s;
+	struct cvmx_ciu_soft_rst_s cn30xx;
+	struct cvmx_ciu_soft_rst_s cn31xx;
+	struct cvmx_ciu_soft_rst_s cn38xx;
+	struct cvmx_ciu_soft_rst_s cn38xxp2;
+	struct cvmx_ciu_soft_rst_s cn50xx;
+	struct cvmx_ciu_soft_rst_s cn52xx;
+	struct cvmx_ciu_soft_rst_s cn52xxp1;
+	struct cvmx_ciu_soft_rst_s cn56xx;
+	struct cvmx_ciu_soft_rst_s cn56xxp1;
+	struct cvmx_ciu_soft_rst_s cn58xx;
+	struct cvmx_ciu_soft_rst_s cn58xxp1;
+};
+typedef union cvmx_ciu_soft_rst cvmx_ciu_soft_rst_t;
+
+union cvmx_ciu_timx {
+	uint64_t u64;
+	struct cvmx_ciu_timx_s {
+		uint64_t reserved_37_63:27;
+		uint64_t one_shot:1;
+		uint64_t len:36;
+	} s;
+	struct cvmx_ciu_timx_s cn30xx;
+	struct cvmx_ciu_timx_s cn31xx;
+	struct cvmx_ciu_timx_s cn38xx;
+	struct cvmx_ciu_timx_s cn38xxp2;
+	struct cvmx_ciu_timx_s cn50xx;
+	struct cvmx_ciu_timx_s cn52xx;
+	struct cvmx_ciu_timx_s cn52xxp1;
+	struct cvmx_ciu_timx_s cn56xx;
+	struct cvmx_ciu_timx_s cn56xxp1;
+	struct cvmx_ciu_timx_s cn58xx;
+	struct cvmx_ciu_timx_s cn58xxp1;
+};
+typedef union cvmx_ciu_timx cvmx_ciu_timx_t;
+
+union cvmx_ciu_wdogx {
+	uint64_t u64;
+	struct cvmx_ciu_wdogx_s {
+		uint64_t reserved_46_63:18;
+		uint64_t gstopen:1;
+		uint64_t dstop:1;
+		uint64_t cnt:24;
+		uint64_t len:16;
+		uint64_t state:2;
+		uint64_t mode:2;
+	} s;
+	struct cvmx_ciu_wdogx_s cn30xx;
+	struct cvmx_ciu_wdogx_s cn31xx;
+	struct cvmx_ciu_wdogx_s cn38xx;
+	struct cvmx_ciu_wdogx_s cn38xxp2;
+	struct cvmx_ciu_wdogx_s cn50xx;
+	struct cvmx_ciu_wdogx_s cn52xx;
+	struct cvmx_ciu_wdogx_s cn52xxp1;
+	struct cvmx_ciu_wdogx_s cn56xx;
+	struct cvmx_ciu_wdogx_s cn56xxp1;
+	struct cvmx_ciu_wdogx_s cn58xx;
+	struct cvmx_ciu_wdogx_s cn58xxp1;
+};
+typedef union cvmx_ciu_wdogx cvmx_ciu_wdogx_t;
+
+#endif
diff --git a/arch/mips/include/asm/octeon/cvmx-gpio-defs.h b/arch/mips/include/asm/octeon/cvmx-gpio-defs.h
new file mode 100644
index 0000000..7651657
--- /dev/null
+++ b/arch/mips/include/asm/octeon/cvmx-gpio-defs.h
@@ -0,0 +1,218 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as published by
+ * the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful,
+ * but AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or NONINFRINGEMENT.
+ * See the GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+ ***********************license end**************************************/
+
+#ifndef __CVMX_GPIO_DEFS_H__
+#define __CVMX_GPIO_DEFS_H__
+
+#define CVMX_GPIO_BIT_CFGX(offset)                           CVMX_ADD_IO_SEG(0x0001070000000800ull + (((offset) & 15) * 8))
+#define CVMX_GPIO_BOOT_ENA                                   CVMX_ADD_IO_SEG(0x00010700000008A8ull)
+#define CVMX_GPIO_CLK_GENX(offset)                           CVMX_ADD_IO_SEG(0x00010700000008C0ull + (((offset) & 3) * 8))
+#define CVMX_GPIO_DBG_ENA                                    CVMX_ADD_IO_SEG(0x00010700000008A0ull)
+#define CVMX_GPIO_INT_CLR                                    CVMX_ADD_IO_SEG(0x0001070000000898ull)
+#define CVMX_GPIO_RX_DAT                                     CVMX_ADD_IO_SEG(0x0001070000000880ull)
+#define CVMX_GPIO_TX_CLR                                     CVMX_ADD_IO_SEG(0x0001070000000890ull)
+#define CVMX_GPIO_TX_SET                                     CVMX_ADD_IO_SEG(0x0001070000000888ull)
+#define CVMX_GPIO_XBIT_CFGX(offset)                          CVMX_ADD_IO_SEG(0x0001070000000900ull + (((offset) & 31) * 8) - 8 * 16)
+
+union cvmx_gpio_bit_cfgx {
+	uint64_t u64;
+	struct cvmx_gpio_bit_cfgx_s {
+		uint64_t reserved_15_63:49;
+		uint64_t clk_gen:1;
+		uint64_t clk_sel:2;
+		uint64_t fil_sel:4;
+		uint64_t fil_cnt:4;
+		uint64_t int_type:1;
+		uint64_t int_en:1;
+		uint64_t rx_xor:1;
+		uint64_t tx_oe:1;
+	} s;
+	struct cvmx_gpio_bit_cfgx_cn30xx {
+		uint64_t reserved_12_63:52;
+		uint64_t fil_sel:4;
+		uint64_t fil_cnt:4;
+		uint64_t int_type:1;
+		uint64_t int_en:1;
+		uint64_t rx_xor:1;
+		uint64_t tx_oe:1;
+	} cn30xx;
+	struct cvmx_gpio_bit_cfgx_cn30xx cn31xx;
+	struct cvmx_gpio_bit_cfgx_cn30xx cn38xx;
+	struct cvmx_gpio_bit_cfgx_cn30xx cn38xxp2;
+	struct cvmx_gpio_bit_cfgx_cn30xx cn50xx;
+	struct cvmx_gpio_bit_cfgx_s cn52xx;
+	struct cvmx_gpio_bit_cfgx_s cn52xxp1;
+	struct cvmx_gpio_bit_cfgx_s cn56xx;
+	struct cvmx_gpio_bit_cfgx_s cn56xxp1;
+	struct cvmx_gpio_bit_cfgx_cn30xx cn58xx;
+	struct cvmx_gpio_bit_cfgx_cn30xx cn58xxp1;
+};
+typedef union cvmx_gpio_bit_cfgx cvmx_gpio_bit_cfgx_t;
+
+union cvmx_gpio_boot_ena {
+	uint64_t u64;
+	struct cvmx_gpio_boot_ena_s {
+		uint64_t reserved_12_63:52;
+		uint64_t boot_ena:4;
+		uint64_t reserved_0_7:8;
+	} s;
+	struct cvmx_gpio_boot_ena_s cn30xx;
+	struct cvmx_gpio_boot_ena_s cn31xx;
+	struct cvmx_gpio_boot_ena_s cn50xx;
+};
+typedef union cvmx_gpio_boot_ena cvmx_gpio_boot_ena_t;
+
+union cvmx_gpio_clk_genx {
+	uint64_t u64;
+	struct cvmx_gpio_clk_genx_s {
+		uint64_t reserved_32_63:32;
+		uint64_t n:32;
+	} s;
+	struct cvmx_gpio_clk_genx_s cn52xx;
+	struct cvmx_gpio_clk_genx_s cn52xxp1;
+	struct cvmx_gpio_clk_genx_s cn56xx;
+	struct cvmx_gpio_clk_genx_s cn56xxp1;
+};
+typedef union cvmx_gpio_clk_genx cvmx_gpio_clk_genx_t;
+
+union cvmx_gpio_dbg_ena {
+	uint64_t u64;
+	struct cvmx_gpio_dbg_ena_s {
+		uint64_t reserved_21_63:43;
+		uint64_t dbg_ena:21;
+	} s;
+	struct cvmx_gpio_dbg_ena_s cn30xx;
+	struct cvmx_gpio_dbg_ena_s cn31xx;
+	struct cvmx_gpio_dbg_ena_s cn50xx;
+};
+typedef union cvmx_gpio_dbg_ena cvmx_gpio_dbg_ena_t;
+
+union cvmx_gpio_int_clr {
+	uint64_t u64;
+	struct cvmx_gpio_int_clr_s {
+		uint64_t reserved_16_63:48;
+		uint64_t type:16;
+	} s;
+	struct cvmx_gpio_int_clr_s cn30xx;
+	struct cvmx_gpio_int_clr_s cn31xx;
+	struct cvmx_gpio_int_clr_s cn38xx;
+	struct cvmx_gpio_int_clr_s cn38xxp2;
+	struct cvmx_gpio_int_clr_s cn50xx;
+	struct cvmx_gpio_int_clr_s cn52xx;
+	struct cvmx_gpio_int_clr_s cn52xxp1;
+	struct cvmx_gpio_int_clr_s cn56xx;
+	struct cvmx_gpio_int_clr_s cn56xxp1;
+	struct cvmx_gpio_int_clr_s cn58xx;
+	struct cvmx_gpio_int_clr_s cn58xxp1;
+};
+typedef union cvmx_gpio_int_clr cvmx_gpio_int_clr_t;
+
+union cvmx_gpio_rx_dat {
+	uint64_t u64;
+	struct cvmx_gpio_rx_dat_s {
+		uint64_t reserved_24_63:40;
+		uint64_t dat:24;
+	} s;
+	struct cvmx_gpio_rx_dat_s cn30xx;
+	struct cvmx_gpio_rx_dat_s cn31xx;
+	struct cvmx_gpio_rx_dat_cn38xx {
+		uint64_t reserved_16_63:48;
+		uint64_t dat:16;
+	} cn38xx;
+	struct cvmx_gpio_rx_dat_cn38xx cn38xxp2;
+	struct cvmx_gpio_rx_dat_s cn50xx;
+	struct cvmx_gpio_rx_dat_cn38xx cn52xx;
+	struct cvmx_gpio_rx_dat_cn38xx cn52xxp1;
+	struct cvmx_gpio_rx_dat_cn38xx cn56xx;
+	struct cvmx_gpio_rx_dat_cn38xx cn56xxp1;
+	struct cvmx_gpio_rx_dat_cn38xx cn58xx;
+	struct cvmx_gpio_rx_dat_cn38xx cn58xxp1;
+};
+typedef union cvmx_gpio_rx_dat cvmx_gpio_rx_dat_t;
+
+union cvmx_gpio_tx_clr {
+	uint64_t u64;
+	struct cvmx_gpio_tx_clr_s {
+		uint64_t reserved_24_63:40;
+		uint64_t clr:24;
+	} s;
+	struct cvmx_gpio_tx_clr_s cn30xx;
+	struct cvmx_gpio_tx_clr_s cn31xx;
+	struct cvmx_gpio_tx_clr_cn38xx {
+		uint64_t reserved_16_63:48;
+		uint64_t clr:16;
+	} cn38xx;
+	struct cvmx_gpio_tx_clr_cn38xx cn38xxp2;
+	struct cvmx_gpio_tx_clr_s cn50xx;
+	struct cvmx_gpio_tx_clr_cn38xx cn52xx;
+	struct cvmx_gpio_tx_clr_cn38xx cn52xxp1;
+	struct cvmx_gpio_tx_clr_cn38xx cn56xx;
+	struct cvmx_gpio_tx_clr_cn38xx cn56xxp1;
+	struct cvmx_gpio_tx_clr_cn38xx cn58xx;
+	struct cvmx_gpio_tx_clr_cn38xx cn58xxp1;
+};
+typedef union cvmx_gpio_tx_clr cvmx_gpio_tx_clr_t;
+
+union cvmx_gpio_tx_set {
+	uint64_t u64;
+	struct cvmx_gpio_tx_set_s {
+		uint64_t reserved_24_63:40;
+		uint64_t set:24;
+	} s;
+	struct cvmx_gpio_tx_set_s cn30xx;
+	struct cvmx_gpio_tx_set_s cn31xx;
+	struct cvmx_gpio_tx_set_cn38xx {
+		uint64_t reserved_16_63:48;
+		uint64_t set:16;
+	} cn38xx;
+	struct cvmx_gpio_tx_set_cn38xx cn38xxp2;
+	struct cvmx_gpio_tx_set_s cn50xx;
+	struct cvmx_gpio_tx_set_cn38xx cn52xx;
+	struct cvmx_gpio_tx_set_cn38xx cn52xxp1;
+	struct cvmx_gpio_tx_set_cn38xx cn56xx;
+	struct cvmx_gpio_tx_set_cn38xx cn56xxp1;
+	struct cvmx_gpio_tx_set_cn38xx cn58xx;
+	struct cvmx_gpio_tx_set_cn38xx cn58xxp1;
+};
+typedef union cvmx_gpio_tx_set cvmx_gpio_tx_set_t;
+
+union cvmx_gpio_xbit_cfgx {
+	uint64_t u64;
+	struct cvmx_gpio_xbit_cfgx_s {
+		uint64_t reserved_12_63:52;
+		uint64_t fil_sel:4;
+		uint64_t fil_cnt:4;
+		uint64_t reserved_2_3:2;
+		uint64_t rx_xor:1;
+		uint64_t tx_oe:1;
+	} s;
+	struct cvmx_gpio_xbit_cfgx_s cn30xx;
+	struct cvmx_gpio_xbit_cfgx_s cn31xx;
+	struct cvmx_gpio_xbit_cfgx_s cn50xx;
+};
+typedef union cvmx_gpio_xbit_cfgx cvmx_gpio_xbit_cfgx_t;
+
+#endif
diff --git a/arch/mips/include/asm/octeon/cvmx-iob-defs.h b/arch/mips/include/asm/octeon/cvmx-iob-defs.h
new file mode 100644
index 0000000..dc388b8
--- /dev/null
+++ b/arch/mips/include/asm/octeon/cvmx-iob-defs.h
@@ -0,0 +1,529 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as published by
+ * the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful,
+ * but AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or NONINFRINGEMENT.
+ * See the GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+ ***********************license end**************************************/
+
+#ifndef __CVMX_IOB_DEFS_H__
+#define __CVMX_IOB_DEFS_H__
+
+#define CVMX_IOB_BIST_STATUS                                 CVMX_ADD_IO_SEG(0x00011800F00007F8ull)
+#define CVMX_IOB_CTL_STATUS                                  CVMX_ADD_IO_SEG(0x00011800F0000050ull)
+#define CVMX_IOB_DWB_PRI_CNT                                 CVMX_ADD_IO_SEG(0x00011800F0000028ull)
+#define CVMX_IOB_FAU_TIMEOUT                                 CVMX_ADD_IO_SEG(0x00011800F0000000ull)
+#define CVMX_IOB_I2C_PRI_CNT                                 CVMX_ADD_IO_SEG(0x00011800F0000010ull)
+#define CVMX_IOB_INB_CONTROL_MATCH                           CVMX_ADD_IO_SEG(0x00011800F0000078ull)
+#define CVMX_IOB_INB_CONTROL_MATCH_ENB                       CVMX_ADD_IO_SEG(0x00011800F0000088ull)
+#define CVMX_IOB_INB_DATA_MATCH                              CVMX_ADD_IO_SEG(0x00011800F0000070ull)
+#define CVMX_IOB_INB_DATA_MATCH_ENB                          CVMX_ADD_IO_SEG(0x00011800F0000080ull)
+#define CVMX_IOB_INT_ENB                                     CVMX_ADD_IO_SEG(0x00011800F0000060ull)
+#define CVMX_IOB_INT_SUM                                     CVMX_ADD_IO_SEG(0x00011800F0000058ull)
+#define CVMX_IOB_N2C_L2C_PRI_CNT                             CVMX_ADD_IO_SEG(0x00011800F0000020ull)
+#define CVMX_IOB_N2C_RSP_PRI_CNT                             CVMX_ADD_IO_SEG(0x00011800F0000008ull)
+#define CVMX_IOB_OUTB_COM_PRI_CNT                            CVMX_ADD_IO_SEG(0x00011800F0000040ull)
+#define CVMX_IOB_OUTB_CONTROL_MATCH                          CVMX_ADD_IO_SEG(0x00011800F0000098ull)
+#define CVMX_IOB_OUTB_CONTROL_MATCH_ENB                      CVMX_ADD_IO_SEG(0x00011800F00000A8ull)
+#define CVMX_IOB_OUTB_DATA_MATCH                             CVMX_ADD_IO_SEG(0x00011800F0000090ull)
+#define CVMX_IOB_OUTB_DATA_MATCH_ENB                         CVMX_ADD_IO_SEG(0x00011800F00000A0ull)
+#define CVMX_IOB_OUTB_FPA_PRI_CNT                            CVMX_ADD_IO_SEG(0x00011800F0000048ull)
+#define CVMX_IOB_OUTB_REQ_PRI_CNT                            CVMX_ADD_IO_SEG(0x00011800F0000038ull)
+#define CVMX_IOB_P2C_REQ_PRI_CNT                             CVMX_ADD_IO_SEG(0x00011800F0000018ull)
+#define CVMX_IOB_PKT_ERR                                     CVMX_ADD_IO_SEG(0x00011800F0000068ull)
+
+union cvmx_iob_bist_status {
+	uint64_t u64;
+	struct cvmx_iob_bist_status_s {
+		uint64_t reserved_18_63:46;
+		uint64_t icnrcb:1;
+		uint64_t icr0:1;
+		uint64_t icr1:1;
+		uint64_t icnr1:1;
+		uint64_t icnr0:1;
+		uint64_t ibdr0:1;
+		uint64_t ibdr1:1;
+		uint64_t ibr0:1;
+		uint64_t ibr1:1;
+		uint64_t icnrt:1;
+		uint64_t ibrq0:1;
+		uint64_t ibrq1:1;
+		uint64_t icrn0:1;
+		uint64_t icrn1:1;
+		uint64_t icrp0:1;
+		uint64_t icrp1:1;
+		uint64_t ibd:1;
+		uint64_t icd:1;
+	} s;
+	struct cvmx_iob_bist_status_s cn30xx;
+	struct cvmx_iob_bist_status_s cn31xx;
+	struct cvmx_iob_bist_status_s cn38xx;
+	struct cvmx_iob_bist_status_s cn38xxp2;
+	struct cvmx_iob_bist_status_s cn50xx;
+	struct cvmx_iob_bist_status_s cn52xx;
+	struct cvmx_iob_bist_status_s cn52xxp1;
+	struct cvmx_iob_bist_status_s cn56xx;
+	struct cvmx_iob_bist_status_s cn56xxp1;
+	struct cvmx_iob_bist_status_s cn58xx;
+	struct cvmx_iob_bist_status_s cn58xxp1;
+};
+typedef union cvmx_iob_bist_status cvmx_iob_bist_status_t;
+
+union cvmx_iob_ctl_status {
+	uint64_t u64;
+	struct cvmx_iob_ctl_status_s {
+		uint64_t reserved_5_63:59;
+		uint64_t outb_mat:1;
+		uint64_t inb_mat:1;
+		uint64_t pko_enb:1;
+		uint64_t dwb_enb:1;
+		uint64_t fau_end:1;
+	} s;
+	struct cvmx_iob_ctl_status_s cn30xx;
+	struct cvmx_iob_ctl_status_s cn31xx;
+	struct cvmx_iob_ctl_status_s cn38xx;
+	struct cvmx_iob_ctl_status_s cn38xxp2;
+	struct cvmx_iob_ctl_status_s cn50xx;
+	struct cvmx_iob_ctl_status_s cn52xx;
+	struct cvmx_iob_ctl_status_s cn52xxp1;
+	struct cvmx_iob_ctl_status_s cn56xx;
+	struct cvmx_iob_ctl_status_s cn56xxp1;
+	struct cvmx_iob_ctl_status_s cn58xx;
+	struct cvmx_iob_ctl_status_s cn58xxp1;
+};
+typedef union cvmx_iob_ctl_status cvmx_iob_ctl_status_t;
+
+union cvmx_iob_dwb_pri_cnt {
+	uint64_t u64;
+	struct cvmx_iob_dwb_pri_cnt_s {
+		uint64_t reserved_16_63:48;
+		uint64_t cnt_enb:1;
+		uint64_t cnt_val:15;
+	} s;
+	struct cvmx_iob_dwb_pri_cnt_s cn38xx;
+	struct cvmx_iob_dwb_pri_cnt_s cn38xxp2;
+	struct cvmx_iob_dwb_pri_cnt_s cn52xx;
+	struct cvmx_iob_dwb_pri_cnt_s cn52xxp1;
+	struct cvmx_iob_dwb_pri_cnt_s cn56xx;
+	struct cvmx_iob_dwb_pri_cnt_s cn56xxp1;
+	struct cvmx_iob_dwb_pri_cnt_s cn58xx;
+	struct cvmx_iob_dwb_pri_cnt_s cn58xxp1;
+};
+typedef union cvmx_iob_dwb_pri_cnt cvmx_iob_dwb_pri_cnt_t;
+
+union cvmx_iob_fau_timeout {
+	uint64_t u64;
+	struct cvmx_iob_fau_timeout_s {
+		uint64_t reserved_13_63:51;
+		uint64_t tout_enb:1;
+		uint64_t tout_val:12;
+	} s;
+	struct cvmx_iob_fau_timeout_s cn30xx;
+	struct cvmx_iob_fau_timeout_s cn31xx;
+	struct cvmx_iob_fau_timeout_s cn38xx;
+	struct cvmx_iob_fau_timeout_s cn38xxp2;
+	struct cvmx_iob_fau_timeout_s cn50xx;
+	struct cvmx_iob_fau_timeout_s cn52xx;
+	struct cvmx_iob_fau_timeout_s cn52xxp1;
+	struct cvmx_iob_fau_timeout_s cn56xx;
+	struct cvmx_iob_fau_timeout_s cn56xxp1;
+	struct cvmx_iob_fau_timeout_s cn58xx;
+	struct cvmx_iob_fau_timeout_s cn58xxp1;
+};
+typedef union cvmx_iob_fau_timeout cvmx_iob_fau_timeout_t;
+
+union cvmx_iob_i2c_pri_cnt {
+	uint64_t u64;
+	struct cvmx_iob_i2c_pri_cnt_s {
+		uint64_t reserved_16_63:48;
+		uint64_t cnt_enb:1;
+		uint64_t cnt_val:15;
+	} s;
+	struct cvmx_iob_i2c_pri_cnt_s cn38xx;
+	struct cvmx_iob_i2c_pri_cnt_s cn38xxp2;
+	struct cvmx_iob_i2c_pri_cnt_s cn52xx;
+	struct cvmx_iob_i2c_pri_cnt_s cn52xxp1;
+	struct cvmx_iob_i2c_pri_cnt_s cn56xx;
+	struct cvmx_iob_i2c_pri_cnt_s cn56xxp1;
+	struct cvmx_iob_i2c_pri_cnt_s cn58xx;
+	struct cvmx_iob_i2c_pri_cnt_s cn58xxp1;
+};
+typedef union cvmx_iob_i2c_pri_cnt cvmx_iob_i2c_pri_cnt_t;
+
+union cvmx_iob_inb_control_match {
+	uint64_t u64;
+	struct cvmx_iob_inb_control_match_s {
+		uint64_t reserved_29_63:35;
+		uint64_t mask:8;
+		uint64_t opc:4;
+		uint64_t dst:9;
+		uint64_t src:8;
+	} s;
+	struct cvmx_iob_inb_control_match_s cn30xx;
+	struct cvmx_iob_inb_control_match_s cn31xx;
+	struct cvmx_iob_inb_control_match_s cn38xx;
+	struct cvmx_iob_inb_control_match_s cn38xxp2;
+	struct cvmx_iob_inb_control_match_s cn50xx;
+	struct cvmx_iob_inb_control_match_s cn52xx;
+	struct cvmx_iob_inb_control_match_s cn52xxp1;
+	struct cvmx_iob_inb_control_match_s cn56xx;
+	struct cvmx_iob_inb_control_match_s cn56xxp1;
+	struct cvmx_iob_inb_control_match_s cn58xx;
+	struct cvmx_iob_inb_control_match_s cn58xxp1;
+};
+typedef union cvmx_iob_inb_control_match cvmx_iob_inb_control_match_t;
+
+union cvmx_iob_inb_control_match_enb {
+	uint64_t u64;
+	struct cvmx_iob_inb_control_match_enb_s {
+		uint64_t reserved_29_63:35;
+		uint64_t mask:8;
+		uint64_t opc:4;
+		uint64_t dst:9;
+		uint64_t src:8;
+	} s;
+	struct cvmx_iob_inb_control_match_enb_s cn30xx;
+	struct cvmx_iob_inb_control_match_enb_s cn31xx;
+	struct cvmx_iob_inb_control_match_enb_s cn38xx;
+	struct cvmx_iob_inb_control_match_enb_s cn38xxp2;
+	struct cvmx_iob_inb_control_match_enb_s cn50xx;
+	struct cvmx_iob_inb_control_match_enb_s cn52xx;
+	struct cvmx_iob_inb_control_match_enb_s cn52xxp1;
+	struct cvmx_iob_inb_control_match_enb_s cn56xx;
+	struct cvmx_iob_inb_control_match_enb_s cn56xxp1;
+	struct cvmx_iob_inb_control_match_enb_s cn58xx;
+	struct cvmx_iob_inb_control_match_enb_s cn58xxp1;
+};
+typedef union cvmx_iob_inb_control_match_enb cvmx_iob_inb_control_match_enb_t;
+
+union cvmx_iob_inb_data_match {
+	uint64_t u64;
+	struct cvmx_iob_inb_data_match_s {
+		uint64_t data:64;
+	} s;
+	struct cvmx_iob_inb_data_match_s cn30xx;
+	struct cvmx_iob_inb_data_match_s cn31xx;
+	struct cvmx_iob_inb_data_match_s cn38xx;
+	struct cvmx_iob_inb_data_match_s cn38xxp2;
+	struct cvmx_iob_inb_data_match_s cn50xx;
+	struct cvmx_iob_inb_data_match_s cn52xx;
+	struct cvmx_iob_inb_data_match_s cn52xxp1;
+	struct cvmx_iob_inb_data_match_s cn56xx;
+	struct cvmx_iob_inb_data_match_s cn56xxp1;
+	struct cvmx_iob_inb_data_match_s cn58xx;
+	struct cvmx_iob_inb_data_match_s cn58xxp1;
+};
+typedef union cvmx_iob_inb_data_match cvmx_iob_inb_data_match_t;
+
+union cvmx_iob_inb_data_match_enb {
+	uint64_t u64;
+	struct cvmx_iob_inb_data_match_enb_s {
+		uint64_t data:64;
+	} s;
+	struct cvmx_iob_inb_data_match_enb_s cn30xx;
+	struct cvmx_iob_inb_data_match_enb_s cn31xx;
+	struct cvmx_iob_inb_data_match_enb_s cn38xx;
+	struct cvmx_iob_inb_data_match_enb_s cn38xxp2;
+	struct cvmx_iob_inb_data_match_enb_s cn50xx;
+	struct cvmx_iob_inb_data_match_enb_s cn52xx;
+	struct cvmx_iob_inb_data_match_enb_s cn52xxp1;
+	struct cvmx_iob_inb_data_match_enb_s cn56xx;
+	struct cvmx_iob_inb_data_match_enb_s cn56xxp1;
+	struct cvmx_iob_inb_data_match_enb_s cn58xx;
+	struct cvmx_iob_inb_data_match_enb_s cn58xxp1;
+};
+typedef union cvmx_iob_inb_data_match_enb cvmx_iob_inb_data_match_enb_t;
+
+union cvmx_iob_int_enb {
+	uint64_t u64;
+	struct cvmx_iob_int_enb_s {
+		uint64_t reserved_6_63:58;
+		uint64_t p_dat:1;
+		uint64_t np_dat:1;
+		uint64_t p_eop:1;
+		uint64_t p_sop:1;
+		uint64_t np_eop:1;
+		uint64_t np_sop:1;
+	} s;
+	struct cvmx_iob_int_enb_cn30xx {
+		uint64_t reserved_4_63:60;
+		uint64_t p_eop:1;
+		uint64_t p_sop:1;
+		uint64_t np_eop:1;
+		uint64_t np_sop:1;
+	} cn30xx;
+	struct cvmx_iob_int_enb_cn30xx cn31xx;
+	struct cvmx_iob_int_enb_cn30xx cn38xx;
+	struct cvmx_iob_int_enb_cn30xx cn38xxp2;
+	struct cvmx_iob_int_enb_s cn50xx;
+	struct cvmx_iob_int_enb_s cn52xx;
+	struct cvmx_iob_int_enb_s cn52xxp1;
+	struct cvmx_iob_int_enb_s cn56xx;
+	struct cvmx_iob_int_enb_s cn56xxp1;
+	struct cvmx_iob_int_enb_s cn58xx;
+	struct cvmx_iob_int_enb_s cn58xxp1;
+};
+typedef union cvmx_iob_int_enb cvmx_iob_int_enb_t;
+
+union cvmx_iob_int_sum {
+	uint64_t u64;
+	struct cvmx_iob_int_sum_s {
+		uint64_t reserved_6_63:58;
+		uint64_t p_dat:1;
+		uint64_t np_dat:1;
+		uint64_t p_eop:1;
+		uint64_t p_sop:1;
+		uint64_t np_eop:1;
+		uint64_t np_sop:1;
+	} s;
+	struct cvmx_iob_int_sum_cn30xx {
+		uint64_t reserved_4_63:60;
+		uint64_t p_eop:1;
+		uint64_t p_sop:1;
+		uint64_t np_eop:1;
+		uint64_t np_sop:1;
+	} cn30xx;
+	struct cvmx_iob_int_sum_cn30xx cn31xx;
+	struct cvmx_iob_int_sum_cn30xx cn38xx;
+	struct cvmx_iob_int_sum_cn30xx cn38xxp2;
+	struct cvmx_iob_int_sum_s cn50xx;
+	struct cvmx_iob_int_sum_s cn52xx;
+	struct cvmx_iob_int_sum_s cn52xxp1;
+	struct cvmx_iob_int_sum_s cn56xx;
+	struct cvmx_iob_int_sum_s cn56xxp1;
+	struct cvmx_iob_int_sum_s cn58xx;
+	struct cvmx_iob_int_sum_s cn58xxp1;
+};
+typedef union cvmx_iob_int_sum cvmx_iob_int_sum_t;
+
+union cvmx_iob_n2c_l2c_pri_cnt {
+	uint64_t u64;
+	struct cvmx_iob_n2c_l2c_pri_cnt_s {
+		uint64_t reserved_16_63:48;
+		uint64_t cnt_enb:1;
+		uint64_t cnt_val:15;
+	} s;
+	struct cvmx_iob_n2c_l2c_pri_cnt_s cn38xx;
+	struct cvmx_iob_n2c_l2c_pri_cnt_s cn38xxp2;
+	struct cvmx_iob_n2c_l2c_pri_cnt_s cn52xx;
+	struct cvmx_iob_n2c_l2c_pri_cnt_s cn52xxp1;
+	struct cvmx_iob_n2c_l2c_pri_cnt_s cn56xx;
+	struct cvmx_iob_n2c_l2c_pri_cnt_s cn56xxp1;
+	struct cvmx_iob_n2c_l2c_pri_cnt_s cn58xx;
+	struct cvmx_iob_n2c_l2c_pri_cnt_s cn58xxp1;
+};
+typedef union cvmx_iob_n2c_l2c_pri_cnt cvmx_iob_n2c_l2c_pri_cnt_t;
+
+union cvmx_iob_n2c_rsp_pri_cnt {
+	uint64_t u64;
+	struct cvmx_iob_n2c_rsp_pri_cnt_s {
+		uint64_t reserved_16_63:48;
+		uint64_t cnt_enb:1;
+		uint64_t cnt_val:15;
+	} s;
+	struct cvmx_iob_n2c_rsp_pri_cnt_s cn38xx;
+	struct cvmx_iob_n2c_rsp_pri_cnt_s cn38xxp2;
+	struct cvmx_iob_n2c_rsp_pri_cnt_s cn52xx;
+	struct cvmx_iob_n2c_rsp_pri_cnt_s cn52xxp1;
+	struct cvmx_iob_n2c_rsp_pri_cnt_s cn56xx;
+	struct cvmx_iob_n2c_rsp_pri_cnt_s cn56xxp1;
+	struct cvmx_iob_n2c_rsp_pri_cnt_s cn58xx;
+	struct cvmx_iob_n2c_rsp_pri_cnt_s cn58xxp1;
+};
+typedef union cvmx_iob_n2c_rsp_pri_cnt cvmx_iob_n2c_rsp_pri_cnt_t;
+
+union cvmx_iob_outb_com_pri_cnt {
+	uint64_t u64;
+	struct cvmx_iob_outb_com_pri_cnt_s {
+		uint64_t reserved_16_63:48;
+		uint64_t cnt_enb:1;
+		uint64_t cnt_val:15;
+	} s;
+	struct cvmx_iob_outb_com_pri_cnt_s cn38xx;
+	struct cvmx_iob_outb_com_pri_cnt_s cn38xxp2;
+	struct cvmx_iob_outb_com_pri_cnt_s cn52xx;
+	struct cvmx_iob_outb_com_pri_cnt_s cn52xxp1;
+	struct cvmx_iob_outb_com_pri_cnt_s cn56xx;
+	struct cvmx_iob_outb_com_pri_cnt_s cn56xxp1;
+	struct cvmx_iob_outb_com_pri_cnt_s cn58xx;
+	struct cvmx_iob_outb_com_pri_cnt_s cn58xxp1;
+};
+typedef union cvmx_iob_outb_com_pri_cnt cvmx_iob_outb_com_pri_cnt_t;
+
+union cvmx_iob_outb_control_match {
+	uint64_t u64;
+	struct cvmx_iob_outb_control_match_s {
+		uint64_t reserved_26_63:38;
+		uint64_t mask:8;
+		uint64_t eot:1;
+		uint64_t dst:8;
+		uint64_t src:9;
+	} s;
+	struct cvmx_iob_outb_control_match_s cn30xx;
+	struct cvmx_iob_outb_control_match_s cn31xx;
+	struct cvmx_iob_outb_control_match_s cn38xx;
+	struct cvmx_iob_outb_control_match_s cn38xxp2;
+	struct cvmx_iob_outb_control_match_s cn50xx;
+	struct cvmx_iob_outb_control_match_s cn52xx;
+	struct cvmx_iob_outb_control_match_s cn52xxp1;
+	struct cvmx_iob_outb_control_match_s cn56xx;
+	struct cvmx_iob_outb_control_match_s cn56xxp1;
+	struct cvmx_iob_outb_control_match_s cn58xx;
+	struct cvmx_iob_outb_control_match_s cn58xxp1;
+};
+typedef union cvmx_iob_outb_control_match cvmx_iob_outb_control_match_t;
+
+union cvmx_iob_outb_control_match_enb {
+	uint64_t u64;
+	struct cvmx_iob_outb_control_match_enb_s {
+		uint64_t reserved_26_63:38;
+		uint64_t mask:8;
+		uint64_t eot:1;
+		uint64_t dst:8;
+		uint64_t src:9;
+	} s;
+	struct cvmx_iob_outb_control_match_enb_s cn30xx;
+	struct cvmx_iob_outb_control_match_enb_s cn31xx;
+	struct cvmx_iob_outb_control_match_enb_s cn38xx;
+	struct cvmx_iob_outb_control_match_enb_s cn38xxp2;
+	struct cvmx_iob_outb_control_match_enb_s cn50xx;
+	struct cvmx_iob_outb_control_match_enb_s cn52xx;
+	struct cvmx_iob_outb_control_match_enb_s cn52xxp1;
+	struct cvmx_iob_outb_control_match_enb_s cn56xx;
+	struct cvmx_iob_outb_control_match_enb_s cn56xxp1;
+	struct cvmx_iob_outb_control_match_enb_s cn58xx;
+	struct cvmx_iob_outb_control_match_enb_s cn58xxp1;
+};
+typedef union cvmx_iob_outb_control_match_enb cvmx_iob_outb_control_match_enb_t;
+
+union cvmx_iob_outb_data_match {
+	uint64_t u64;
+	struct cvmx_iob_outb_data_match_s {
+		uint64_t data:64;
+	} s;
+	struct cvmx_iob_outb_data_match_s cn30xx;
+	struct cvmx_iob_outb_data_match_s cn31xx;
+	struct cvmx_iob_outb_data_match_s cn38xx;
+	struct cvmx_iob_outb_data_match_s cn38xxp2;
+	struct cvmx_iob_outb_data_match_s cn50xx;
+	struct cvmx_iob_outb_data_match_s cn52xx;
+	struct cvmx_iob_outb_data_match_s cn52xxp1;
+	struct cvmx_iob_outb_data_match_s cn56xx;
+	struct cvmx_iob_outb_data_match_s cn56xxp1;
+	struct cvmx_iob_outb_data_match_s cn58xx;
+	struct cvmx_iob_outb_data_match_s cn58xxp1;
+};
+typedef union cvmx_iob_outb_data_match cvmx_iob_outb_data_match_t;
+
+union cvmx_iob_outb_data_match_enb {
+	uint64_t u64;
+	struct cvmx_iob_outb_data_match_enb_s {
+		uint64_t data:64;
+	} s;
+	struct cvmx_iob_outb_data_match_enb_s cn30xx;
+	struct cvmx_iob_outb_data_match_enb_s cn31xx;
+	struct cvmx_iob_outb_data_match_enb_s cn38xx;
+	struct cvmx_iob_outb_data_match_enb_s cn38xxp2;
+	struct cvmx_iob_outb_data_match_enb_s cn50xx;
+	struct cvmx_iob_outb_data_match_enb_s cn52xx;
+	struct cvmx_iob_outb_data_match_enb_s cn52xxp1;
+	struct cvmx_iob_outb_data_match_enb_s cn56xx;
+	struct cvmx_iob_outb_data_match_enb_s cn56xxp1;
+	struct cvmx_iob_outb_data_match_enb_s cn58xx;
+	struct cvmx_iob_outb_data_match_enb_s cn58xxp1;
+};
+typedef union cvmx_iob_outb_data_match_enb cvmx_iob_outb_data_match_enb_t;
+
+union cvmx_iob_outb_fpa_pri_cnt {
+	uint64_t u64;
+	struct cvmx_iob_outb_fpa_pri_cnt_s {
+		uint64_t reserved_16_63:48;
+		uint64_t cnt_enb:1;
+		uint64_t cnt_val:15;
+	} s;
+	struct cvmx_iob_outb_fpa_pri_cnt_s cn38xx;
+	struct cvmx_iob_outb_fpa_pri_cnt_s cn38xxp2;
+	struct cvmx_iob_outb_fpa_pri_cnt_s cn52xx;
+	struct cvmx_iob_outb_fpa_pri_cnt_s cn52xxp1;
+	struct cvmx_iob_outb_fpa_pri_cnt_s cn56xx;
+	struct cvmx_iob_outb_fpa_pri_cnt_s cn56xxp1;
+	struct cvmx_iob_outb_fpa_pri_cnt_s cn58xx;
+	struct cvmx_iob_outb_fpa_pri_cnt_s cn58xxp1;
+};
+typedef union cvmx_iob_outb_fpa_pri_cnt cvmx_iob_outb_fpa_pri_cnt_t;
+
+union cvmx_iob_outb_req_pri_cnt {
+	uint64_t u64;
+	struct cvmx_iob_outb_req_pri_cnt_s {
+		uint64_t reserved_16_63:48;
+		uint64_t cnt_enb:1;
+		uint64_t cnt_val:15;
+	} s;
+	struct cvmx_iob_outb_req_pri_cnt_s cn38xx;
+	struct cvmx_iob_outb_req_pri_cnt_s cn38xxp2;
+	struct cvmx_iob_outb_req_pri_cnt_s cn52xx;
+	struct cvmx_iob_outb_req_pri_cnt_s cn52xxp1;
+	struct cvmx_iob_outb_req_pri_cnt_s cn56xx;
+	struct cvmx_iob_outb_req_pri_cnt_s cn56xxp1;
+	struct cvmx_iob_outb_req_pri_cnt_s cn58xx;
+	struct cvmx_iob_outb_req_pri_cnt_s cn58xxp1;
+};
+typedef union cvmx_iob_outb_req_pri_cnt cvmx_iob_outb_req_pri_cnt_t;
+
+union cvmx_iob_p2c_req_pri_cnt {
+	uint64_t u64;
+	struct cvmx_iob_p2c_req_pri_cnt_s {
+		uint64_t reserved_16_63:48;
+		uint64_t cnt_enb:1;
+		uint64_t cnt_val:15;
+	} s;
+	struct cvmx_iob_p2c_req_pri_cnt_s cn38xx;
+	struct cvmx_iob_p2c_req_pri_cnt_s cn38xxp2;
+	struct cvmx_iob_p2c_req_pri_cnt_s cn52xx;
+	struct cvmx_iob_p2c_req_pri_cnt_s cn52xxp1;
+	struct cvmx_iob_p2c_req_pri_cnt_s cn56xx;
+	struct cvmx_iob_p2c_req_pri_cnt_s cn56xxp1;
+	struct cvmx_iob_p2c_req_pri_cnt_s cn58xx;
+	struct cvmx_iob_p2c_req_pri_cnt_s cn58xxp1;
+};
+typedef union cvmx_iob_p2c_req_pri_cnt cvmx_iob_p2c_req_pri_cnt_t;
+
+union cvmx_iob_pkt_err {
+	uint64_t u64;
+	struct cvmx_iob_pkt_err_s {
+		uint64_t reserved_6_63:58;
+		uint64_t port:6;
+	} s;
+	struct cvmx_iob_pkt_err_s cn30xx;
+	struct cvmx_iob_pkt_err_s cn31xx;
+	struct cvmx_iob_pkt_err_s cn38xx;
+	struct cvmx_iob_pkt_err_s cn38xxp2;
+	struct cvmx_iob_pkt_err_s cn50xx;
+	struct cvmx_iob_pkt_err_s cn52xx;
+	struct cvmx_iob_pkt_err_s cn52xxp1;
+	struct cvmx_iob_pkt_err_s cn56xx;
+	struct cvmx_iob_pkt_err_s cn56xxp1;
+	struct cvmx_iob_pkt_err_s cn58xx;
+	struct cvmx_iob_pkt_err_s cn58xxp1;
+};
+typedef union cvmx_iob_pkt_err cvmx_iob_pkt_err_t;
+
+#endif
diff --git a/arch/mips/include/asm/octeon/cvmx-ipd-defs.h b/arch/mips/include/asm/octeon/cvmx-ipd-defs.h
new file mode 100644
index 0000000..652ddf5
--- /dev/null
+++ b/arch/mips/include/asm/octeon/cvmx-ipd-defs.h
@@ -0,0 +1,861 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as published by
+ * the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful,
+ * but AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or NONINFRINGEMENT.
+ * See the GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+ ***********************license end**************************************/
+
+#ifndef __CVMX_IPD_DEFS_H__
+#define __CVMX_IPD_DEFS_H__
+
+#define CVMX_IPD_1ST_MBUFF_SKIP                              CVMX_ADD_IO_SEG(0x00014F0000000000ull)
+#define CVMX_IPD_1st_NEXT_PTR_BACK                           CVMX_ADD_IO_SEG(0x00014F0000000150ull)
+#define CVMX_IPD_2nd_NEXT_PTR_BACK                           CVMX_ADD_IO_SEG(0x00014F0000000158ull)
+#define CVMX_IPD_BIST_STATUS                                 CVMX_ADD_IO_SEG(0x00014F00000007F8ull)
+#define CVMX_IPD_BP_PRT_RED_END                              CVMX_ADD_IO_SEG(0x00014F0000000328ull)
+#define CVMX_IPD_CLK_COUNT                                   CVMX_ADD_IO_SEG(0x00014F0000000338ull)
+#define CVMX_IPD_CTL_STATUS                                  CVMX_ADD_IO_SEG(0x00014F0000000018ull)
+#define CVMX_IPD_INT_ENB                                     CVMX_ADD_IO_SEG(0x00014F0000000160ull)
+#define CVMX_IPD_INT_SUM                                     CVMX_ADD_IO_SEG(0x00014F0000000168ull)
+#define CVMX_IPD_NOT_1ST_MBUFF_SKIP                          CVMX_ADD_IO_SEG(0x00014F0000000008ull)
+#define CVMX_IPD_PACKET_MBUFF_SIZE                           CVMX_ADD_IO_SEG(0x00014F0000000010ull)
+#define CVMX_IPD_PKT_PTR_VALID                               CVMX_ADD_IO_SEG(0x00014F0000000358ull)
+#define CVMX_IPD_PORTX_BP_PAGE_CNT(offset)                   CVMX_ADD_IO_SEG(0x00014F0000000028ull + (((offset) & 63) * 8))
+#define CVMX_IPD_PORTX_BP_PAGE_CNT2(offset)                  CVMX_ADD_IO_SEG(0x00014F0000000368ull + (((offset) & 63) * 8) - 8 * 36)
+#define CVMX_IPD_PORT_BP_COUNTERS2_PAIRX(offset)             CVMX_ADD_IO_SEG(0x00014F0000000388ull + (((offset) & 63) * 8) - 8 * 36)
+#define CVMX_IPD_PORT_BP_COUNTERS_PAIRX(offset)              CVMX_ADD_IO_SEG(0x00014F00000001B8ull + (((offset) & 63) * 8))
+#define CVMX_IPD_PORT_QOS_INTX(offset)                       CVMX_ADD_IO_SEG(0x00014F0000000808ull + (((offset) & 7) * 8))
+#define CVMX_IPD_PORT_QOS_INT_ENBX(offset)                   CVMX_ADD_IO_SEG(0x00014F0000000848ull + (((offset) & 7) * 8))
+#define CVMX_IPD_PORT_QOS_X_CNT(offset)                      CVMX_ADD_IO_SEG(0x00014F0000000888ull + (((offset) & 511) * 8))
+#define CVMX_IPD_PRC_HOLD_PTR_FIFO_CTL                       CVMX_ADD_IO_SEG(0x00014F0000000348ull)
+#define CVMX_IPD_PRC_PORT_PTR_FIFO_CTL                       CVMX_ADD_IO_SEG(0x00014F0000000350ull)
+#define CVMX_IPD_PTR_COUNT                                   CVMX_ADD_IO_SEG(0x00014F0000000320ull)
+#define CVMX_IPD_PWP_PTR_FIFO_CTL                            CVMX_ADD_IO_SEG(0x00014F0000000340ull)
+#define CVMX_IPD_QOS0_RED_MARKS                              CVMX_ADD_IO_SEG(0x00014F0000000178ull)
+#define CVMX_IPD_QOS1_RED_MARKS                              CVMX_ADD_IO_SEG(0x00014F0000000180ull)
+#define CVMX_IPD_QOS2_RED_MARKS                              CVMX_ADD_IO_SEG(0x00014F0000000188ull)
+#define CVMX_IPD_QOS3_RED_MARKS                              CVMX_ADD_IO_SEG(0x00014F0000000190ull)
+#define CVMX_IPD_QOS4_RED_MARKS                              CVMX_ADD_IO_SEG(0x00014F0000000198ull)
+#define CVMX_IPD_QOS5_RED_MARKS                              CVMX_ADD_IO_SEG(0x00014F00000001A0ull)
+#define CVMX_IPD_QOS6_RED_MARKS                              CVMX_ADD_IO_SEG(0x00014F00000001A8ull)
+#define CVMX_IPD_QOS7_RED_MARKS                              CVMX_ADD_IO_SEG(0x00014F00000001B0ull)
+#define CVMX_IPD_QOSX_RED_MARKS(offset)                      CVMX_ADD_IO_SEG(0x00014F0000000178ull + (((offset) & 7) * 8))
+#define CVMX_IPD_QUE0_FREE_PAGE_CNT                          CVMX_ADD_IO_SEG(0x00014F0000000330ull)
+#define CVMX_IPD_RED_PORT_ENABLE                             CVMX_ADD_IO_SEG(0x00014F00000002D8ull)
+#define CVMX_IPD_RED_PORT_ENABLE2                            CVMX_ADD_IO_SEG(0x00014F00000003A8ull)
+#define CVMX_IPD_RED_QUE0_PARAM                              CVMX_ADD_IO_SEG(0x00014F00000002E0ull)
+#define CVMX_IPD_RED_QUE1_PARAM                              CVMX_ADD_IO_SEG(0x00014F00000002E8ull)
+#define CVMX_IPD_RED_QUE2_PARAM                              CVMX_ADD_IO_SEG(0x00014F00000002F0ull)
+#define CVMX_IPD_RED_QUE3_PARAM                              CVMX_ADD_IO_SEG(0x00014F00000002F8ull)
+#define CVMX_IPD_RED_QUE4_PARAM                              CVMX_ADD_IO_SEG(0x00014F0000000300ull)
+#define CVMX_IPD_RED_QUE5_PARAM                              CVMX_ADD_IO_SEG(0x00014F0000000308ull)
+#define CVMX_IPD_RED_QUE6_PARAM                              CVMX_ADD_IO_SEG(0x00014F0000000310ull)
+#define CVMX_IPD_RED_QUE7_PARAM                              CVMX_ADD_IO_SEG(0x00014F0000000318ull)
+#define CVMX_IPD_RED_QUEX_PARAM(offset)                      CVMX_ADD_IO_SEG(0x00014F00000002E0ull + (((offset) & 7) * 8))
+#define CVMX_IPD_SUB_PORT_BP_PAGE_CNT                        CVMX_ADD_IO_SEG(0x00014F0000000148ull)
+#define CVMX_IPD_SUB_PORT_FCS                                CVMX_ADD_IO_SEG(0x00014F0000000170ull)
+#define CVMX_IPD_SUB_PORT_QOS_CNT                            CVMX_ADD_IO_SEG(0x00014F0000000800ull)
+#define CVMX_IPD_WQE_FPA_QUEUE                               CVMX_ADD_IO_SEG(0x00014F0000000020ull)
+#define CVMX_IPD_WQE_PTR_VALID                               CVMX_ADD_IO_SEG(0x00014F0000000360ull)
+
+union cvmx_ipd_1st_mbuff_skip {
+	uint64_t u64;
+	struct cvmx_ipd_1st_mbuff_skip_s {
+		uint64_t reserved_6_63:58;
+		uint64_t skip_sz:6;
+	} s;
+	struct cvmx_ipd_1st_mbuff_skip_s cn30xx;
+	struct cvmx_ipd_1st_mbuff_skip_s cn31xx;
+	struct cvmx_ipd_1st_mbuff_skip_s cn38xx;
+	struct cvmx_ipd_1st_mbuff_skip_s cn38xxp2;
+	struct cvmx_ipd_1st_mbuff_skip_s cn50xx;
+	struct cvmx_ipd_1st_mbuff_skip_s cn52xx;
+	struct cvmx_ipd_1st_mbuff_skip_s cn52xxp1;
+	struct cvmx_ipd_1st_mbuff_skip_s cn56xx;
+	struct cvmx_ipd_1st_mbuff_skip_s cn56xxp1;
+	struct cvmx_ipd_1st_mbuff_skip_s cn58xx;
+	struct cvmx_ipd_1st_mbuff_skip_s cn58xxp1;
+};
+typedef union cvmx_ipd_1st_mbuff_skip cvmx_ipd_1st_mbuff_skip_t;
+
+union cvmx_ipd_1st_next_ptr_back {
+	uint64_t u64;
+	struct cvmx_ipd_1st_next_ptr_back_s {
+		uint64_t reserved_4_63:60;
+		uint64_t back:4;
+	} s;
+	struct cvmx_ipd_1st_next_ptr_back_s cn30xx;
+	struct cvmx_ipd_1st_next_ptr_back_s cn31xx;
+	struct cvmx_ipd_1st_next_ptr_back_s cn38xx;
+	struct cvmx_ipd_1st_next_ptr_back_s cn38xxp2;
+	struct cvmx_ipd_1st_next_ptr_back_s cn50xx;
+	struct cvmx_ipd_1st_next_ptr_back_s cn52xx;
+	struct cvmx_ipd_1st_next_ptr_back_s cn52xxp1;
+	struct cvmx_ipd_1st_next_ptr_back_s cn56xx;
+	struct cvmx_ipd_1st_next_ptr_back_s cn56xxp1;
+	struct cvmx_ipd_1st_next_ptr_back_s cn58xx;
+	struct cvmx_ipd_1st_next_ptr_back_s cn58xxp1;
+};
+typedef union cvmx_ipd_1st_next_ptr_back cvmx_ipd_1st_next_ptr_back_t;
+
+union cvmx_ipd_2nd_next_ptr_back {
+	uint64_t u64;
+	struct cvmx_ipd_2nd_next_ptr_back_s {
+		uint64_t reserved_4_63:60;
+		uint64_t back:4;
+	} s;
+	struct cvmx_ipd_2nd_next_ptr_back_s cn30xx;
+	struct cvmx_ipd_2nd_next_ptr_back_s cn31xx;
+	struct cvmx_ipd_2nd_next_ptr_back_s cn38xx;
+	struct cvmx_ipd_2nd_next_ptr_back_s cn38xxp2;
+	struct cvmx_ipd_2nd_next_ptr_back_s cn50xx;
+	struct cvmx_ipd_2nd_next_ptr_back_s cn52xx;
+	struct cvmx_ipd_2nd_next_ptr_back_s cn52xxp1;
+	struct cvmx_ipd_2nd_next_ptr_back_s cn56xx;
+	struct cvmx_ipd_2nd_next_ptr_back_s cn56xxp1;
+	struct cvmx_ipd_2nd_next_ptr_back_s cn58xx;
+	struct cvmx_ipd_2nd_next_ptr_back_s cn58xxp1;
+};
+typedef union cvmx_ipd_2nd_next_ptr_back cvmx_ipd_2nd_next_ptr_back_t;
+
+union cvmx_ipd_bist_status {
+	uint64_t u64;
+	struct cvmx_ipd_bist_status_s {
+		uint64_t reserved_18_63:46;
+		uint64_t csr_mem:1;
+		uint64_t csr_ncmd:1;
+		uint64_t pwq_wqed:1;
+		uint64_t pwq_wp1:1;
+		uint64_t pwq_pow:1;
+		uint64_t ipq_pbe1:1;
+		uint64_t ipq_pbe0:1;
+		uint64_t pbm3:1;
+		uint64_t pbm2:1;
+		uint64_t pbm1:1;
+		uint64_t pbm0:1;
+		uint64_t pbm_word:1;
+		uint64_t pwq1:1;
+		uint64_t pwq0:1;
+		uint64_t prc_off:1;
+		uint64_t ipd_old:1;
+		uint64_t ipd_new:1;
+		uint64_t pwp:1;
+	} s;
+	struct cvmx_ipd_bist_status_cn30xx {
+		uint64_t reserved_16_63:48;
+		uint64_t pwq_wqed:1;
+		uint64_t pwq_wp1:1;
+		uint64_t pwq_pow:1;
+		uint64_t ipq_pbe1:1;
+		uint64_t ipq_pbe0:1;
+		uint64_t pbm3:1;
+		uint64_t pbm2:1;
+		uint64_t pbm1:1;
+		uint64_t pbm0:1;
+		uint64_t pbm_word:1;
+		uint64_t pwq1:1;
+		uint64_t pwq0:1;
+		uint64_t prc_off:1;
+		uint64_t ipd_old:1;
+		uint64_t ipd_new:1;
+		uint64_t pwp:1;
+	} cn30xx;
+	struct cvmx_ipd_bist_status_cn30xx cn31xx;
+	struct cvmx_ipd_bist_status_cn30xx cn38xx;
+	struct cvmx_ipd_bist_status_cn30xx cn38xxp2;
+	struct cvmx_ipd_bist_status_cn30xx cn50xx;
+	struct cvmx_ipd_bist_status_s cn52xx;
+	struct cvmx_ipd_bist_status_s cn52xxp1;
+	struct cvmx_ipd_bist_status_s cn56xx;
+	struct cvmx_ipd_bist_status_s cn56xxp1;
+	struct cvmx_ipd_bist_status_cn30xx cn58xx;
+	struct cvmx_ipd_bist_status_cn30xx cn58xxp1;
+};
+typedef union cvmx_ipd_bist_status cvmx_ipd_bist_status_t;
+
+union cvmx_ipd_bp_prt_red_end {
+	uint64_t u64;
+	struct cvmx_ipd_bp_prt_red_end_s {
+		uint64_t reserved_40_63:24;
+		uint64_t prt_enb:40;
+	} s;
+	struct cvmx_ipd_bp_prt_red_end_cn30xx {
+		uint64_t reserved_36_63:28;
+		uint64_t prt_enb:36;
+	} cn30xx;
+	struct cvmx_ipd_bp_prt_red_end_cn30xx cn31xx;
+	struct cvmx_ipd_bp_prt_red_end_cn30xx cn38xx;
+	struct cvmx_ipd_bp_prt_red_end_cn30xx cn38xxp2;
+	struct cvmx_ipd_bp_prt_red_end_cn30xx cn50xx;
+	struct cvmx_ipd_bp_prt_red_end_s cn52xx;
+	struct cvmx_ipd_bp_prt_red_end_s cn52xxp1;
+	struct cvmx_ipd_bp_prt_red_end_s cn56xx;
+	struct cvmx_ipd_bp_prt_red_end_s cn56xxp1;
+	struct cvmx_ipd_bp_prt_red_end_cn30xx cn58xx;
+	struct cvmx_ipd_bp_prt_red_end_cn30xx cn58xxp1;
+};
+typedef union cvmx_ipd_bp_prt_red_end cvmx_ipd_bp_prt_red_end_t;
+
+union cvmx_ipd_clk_count {
+	uint64_t u64;
+	struct cvmx_ipd_clk_count_s {
+		uint64_t clk_cnt:64;
+	} s;
+	struct cvmx_ipd_clk_count_s cn30xx;
+	struct cvmx_ipd_clk_count_s cn31xx;
+	struct cvmx_ipd_clk_count_s cn38xx;
+	struct cvmx_ipd_clk_count_s cn38xxp2;
+	struct cvmx_ipd_clk_count_s cn50xx;
+	struct cvmx_ipd_clk_count_s cn52xx;
+	struct cvmx_ipd_clk_count_s cn52xxp1;
+	struct cvmx_ipd_clk_count_s cn56xx;
+	struct cvmx_ipd_clk_count_s cn56xxp1;
+	struct cvmx_ipd_clk_count_s cn58xx;
+	struct cvmx_ipd_clk_count_s cn58xxp1;
+};
+typedef union cvmx_ipd_clk_count cvmx_ipd_clk_count_t;
+
+union cvmx_ipd_ctl_status {
+	uint64_t u64;
+	struct cvmx_ipd_ctl_status_s {
+		uint64_t reserved_15_63:49;
+		uint64_t no_wptr:1;
+		uint64_t pq_apkt:1;
+		uint64_t pq_nabuf:1;
+		uint64_t ipd_full:1;
+		uint64_t pkt_off:1;
+		uint64_t len_m8:1;
+		uint64_t reset:1;
+		uint64_t addpkt:1;
+		uint64_t naddbuf:1;
+		uint64_t pkt_lend:1;
+		uint64_t wqe_lend:1;
+		uint64_t pbp_en:1;
+		uint64_t opc_mode:2;
+		uint64_t ipd_en:1;
+	} s;
+	struct cvmx_ipd_ctl_status_cn30xx {
+		uint64_t reserved_10_63:54;
+		uint64_t len_m8:1;
+		uint64_t reset:1;
+		uint64_t addpkt:1;
+		uint64_t naddbuf:1;
+		uint64_t pkt_lend:1;
+		uint64_t wqe_lend:1;
+		uint64_t pbp_en:1;
+		uint64_t opc_mode:2;
+		uint64_t ipd_en:1;
+	} cn30xx;
+	struct cvmx_ipd_ctl_status_cn30xx cn31xx;
+	struct cvmx_ipd_ctl_status_cn30xx cn38xx;
+	struct cvmx_ipd_ctl_status_cn38xxp2 {
+		uint64_t reserved_9_63:55;
+		uint64_t reset:1;
+		uint64_t addpkt:1;
+		uint64_t naddbuf:1;
+		uint64_t pkt_lend:1;
+		uint64_t wqe_lend:1;
+		uint64_t pbp_en:1;
+		uint64_t opc_mode:2;
+		uint64_t ipd_en:1;
+	} cn38xxp2;
+	struct cvmx_ipd_ctl_status_s cn50xx;
+	struct cvmx_ipd_ctl_status_s cn52xx;
+	struct cvmx_ipd_ctl_status_s cn52xxp1;
+	struct cvmx_ipd_ctl_status_s cn56xx;
+	struct cvmx_ipd_ctl_status_s cn56xxp1;
+	struct cvmx_ipd_ctl_status_cn58xx {
+		uint64_t reserved_12_63:52;
+		uint64_t ipd_full:1;
+		uint64_t pkt_off:1;
+		uint64_t len_m8:1;
+		uint64_t reset:1;
+		uint64_t addpkt:1;
+		uint64_t naddbuf:1;
+		uint64_t pkt_lend:1;
+		uint64_t wqe_lend:1;
+		uint64_t pbp_en:1;
+		uint64_t opc_mode:2;
+		uint64_t ipd_en:1;
+	} cn58xx;
+	struct cvmx_ipd_ctl_status_cn58xx cn58xxp1;
+};
+typedef union cvmx_ipd_ctl_status cvmx_ipd_ctl_status_t;
+
+union cvmx_ipd_int_enb {
+	uint64_t u64;
+	struct cvmx_ipd_int_enb_s {
+		uint64_t reserved_12_63:52;
+		uint64_t pq_sub:1;
+		uint64_t pq_add:1;
+		uint64_t bc_ovr:1;
+		uint64_t d_coll:1;
+		uint64_t c_coll:1;
+		uint64_t cc_ovr:1;
+		uint64_t dc_ovr:1;
+		uint64_t bp_sub:1;
+		uint64_t prc_par3:1;
+		uint64_t prc_par2:1;
+		uint64_t prc_par1:1;
+		uint64_t prc_par0:1;
+	} s;
+	struct cvmx_ipd_int_enb_cn30xx {
+		uint64_t reserved_5_63:59;
+		uint64_t bp_sub:1;
+		uint64_t prc_par3:1;
+		uint64_t prc_par2:1;
+		uint64_t prc_par1:1;
+		uint64_t prc_par0:1;
+	} cn30xx;
+	struct cvmx_ipd_int_enb_cn30xx cn31xx;
+	struct cvmx_ipd_int_enb_cn38xx {
+		uint64_t reserved_10_63:54;
+		uint64_t bc_ovr:1;
+		uint64_t d_coll:1;
+		uint64_t c_coll:1;
+		uint64_t cc_ovr:1;
+		uint64_t dc_ovr:1;
+		uint64_t bp_sub:1;
+		uint64_t prc_par3:1;
+		uint64_t prc_par2:1;
+		uint64_t prc_par1:1;
+		uint64_t prc_par0:1;
+	} cn38xx;
+	struct cvmx_ipd_int_enb_cn30xx cn38xxp2;
+	struct cvmx_ipd_int_enb_cn38xx cn50xx;
+	struct cvmx_ipd_int_enb_s cn52xx;
+	struct cvmx_ipd_int_enb_s cn52xxp1;
+	struct cvmx_ipd_int_enb_s cn56xx;
+	struct cvmx_ipd_int_enb_s cn56xxp1;
+	struct cvmx_ipd_int_enb_cn38xx cn58xx;
+	struct cvmx_ipd_int_enb_cn38xx cn58xxp1;
+};
+typedef union cvmx_ipd_int_enb cvmx_ipd_int_enb_t;
+
+union cvmx_ipd_int_sum {
+	uint64_t u64;
+	struct cvmx_ipd_int_sum_s {
+		uint64_t reserved_12_63:52;
+		uint64_t pq_sub:1;
+		uint64_t pq_add:1;
+		uint64_t bc_ovr:1;
+		uint64_t d_coll:1;
+		uint64_t c_coll:1;
+		uint64_t cc_ovr:1;
+		uint64_t dc_ovr:1;
+		uint64_t bp_sub:1;
+		uint64_t prc_par3:1;
+		uint64_t prc_par2:1;
+		uint64_t prc_par1:1;
+		uint64_t prc_par0:1;
+	} s;
+	struct cvmx_ipd_int_sum_cn30xx {
+		uint64_t reserved_5_63:59;
+		uint64_t bp_sub:1;
+		uint64_t prc_par3:1;
+		uint64_t prc_par2:1;
+		uint64_t prc_par1:1;
+		uint64_t prc_par0:1;
+	} cn30xx;
+	struct cvmx_ipd_int_sum_cn30xx cn31xx;
+	struct cvmx_ipd_int_sum_cn38xx {
+		uint64_t reserved_10_63:54;
+		uint64_t bc_ovr:1;
+		uint64_t d_coll:1;
+		uint64_t c_coll:1;
+		uint64_t cc_ovr:1;
+		uint64_t dc_ovr:1;
+		uint64_t bp_sub:1;
+		uint64_t prc_par3:1;
+		uint64_t prc_par2:1;
+		uint64_t prc_par1:1;
+		uint64_t prc_par0:1;
+	} cn38xx;
+	struct cvmx_ipd_int_sum_cn30xx cn38xxp2;
+	struct cvmx_ipd_int_sum_cn38xx cn50xx;
+	struct cvmx_ipd_int_sum_s cn52xx;
+	struct cvmx_ipd_int_sum_s cn52xxp1;
+	struct cvmx_ipd_int_sum_s cn56xx;
+	struct cvmx_ipd_int_sum_s cn56xxp1;
+	struct cvmx_ipd_int_sum_cn38xx cn58xx;
+	struct cvmx_ipd_int_sum_cn38xx cn58xxp1;
+};
+typedef union cvmx_ipd_int_sum cvmx_ipd_int_sum_t;
+
+union cvmx_ipd_not_1st_mbuff_skip {
+	uint64_t u64;
+	struct cvmx_ipd_not_1st_mbuff_skip_s {
+		uint64_t reserved_6_63:58;
+		uint64_t skip_sz:6;
+	} s;
+	struct cvmx_ipd_not_1st_mbuff_skip_s cn30xx;
+	struct cvmx_ipd_not_1st_mbuff_skip_s cn31xx;
+	struct cvmx_ipd_not_1st_mbuff_skip_s cn38xx;
+	struct cvmx_ipd_not_1st_mbuff_skip_s cn38xxp2;
+	struct cvmx_ipd_not_1st_mbuff_skip_s cn50xx;
+	struct cvmx_ipd_not_1st_mbuff_skip_s cn52xx;
+	struct cvmx_ipd_not_1st_mbuff_skip_s cn52xxp1;
+	struct cvmx_ipd_not_1st_mbuff_skip_s cn56xx;
+	struct cvmx_ipd_not_1st_mbuff_skip_s cn56xxp1;
+	struct cvmx_ipd_not_1st_mbuff_skip_s cn58xx;
+	struct cvmx_ipd_not_1st_mbuff_skip_s cn58xxp1;
+};
+typedef union cvmx_ipd_not_1st_mbuff_skip cvmx_ipd_not_1st_mbuff_skip_t;
+
+union cvmx_ipd_packet_mbuff_size {
+	uint64_t u64;
+	struct cvmx_ipd_packet_mbuff_size_s {
+		uint64_t reserved_12_63:52;
+		uint64_t mb_size:12;
+	} s;
+	struct cvmx_ipd_packet_mbuff_size_s cn30xx;
+	struct cvmx_ipd_packet_mbuff_size_s cn31xx;
+	struct cvmx_ipd_packet_mbuff_size_s cn38xx;
+	struct cvmx_ipd_packet_mbuff_size_s cn38xxp2;
+	struct cvmx_ipd_packet_mbuff_size_s cn50xx;
+	struct cvmx_ipd_packet_mbuff_size_s cn52xx;
+	struct cvmx_ipd_packet_mbuff_size_s cn52xxp1;
+	struct cvmx_ipd_packet_mbuff_size_s cn56xx;
+	struct cvmx_ipd_packet_mbuff_size_s cn56xxp1;
+	struct cvmx_ipd_packet_mbuff_size_s cn58xx;
+	struct cvmx_ipd_packet_mbuff_size_s cn58xxp1;
+};
+typedef union cvmx_ipd_packet_mbuff_size cvmx_ipd_packet_mbuff_size_t;
+
+union cvmx_ipd_pkt_ptr_valid {
+	uint64_t u64;
+	struct cvmx_ipd_pkt_ptr_valid_s {
+		uint64_t reserved_29_63:35;
+		uint64_t ptr:29;
+	} s;
+	struct cvmx_ipd_pkt_ptr_valid_s cn30xx;
+	struct cvmx_ipd_pkt_ptr_valid_s cn31xx;
+	struct cvmx_ipd_pkt_ptr_valid_s cn38xx;
+	struct cvmx_ipd_pkt_ptr_valid_s cn50xx;
+	struct cvmx_ipd_pkt_ptr_valid_s cn52xx;
+	struct cvmx_ipd_pkt_ptr_valid_s cn52xxp1;
+	struct cvmx_ipd_pkt_ptr_valid_s cn56xx;
+	struct cvmx_ipd_pkt_ptr_valid_s cn56xxp1;
+	struct cvmx_ipd_pkt_ptr_valid_s cn58xx;
+	struct cvmx_ipd_pkt_ptr_valid_s cn58xxp1;
+};
+typedef union cvmx_ipd_pkt_ptr_valid cvmx_ipd_pkt_ptr_valid_t;
+
+union cvmx_ipd_portx_bp_page_cnt {
+	uint64_t u64;
+	struct cvmx_ipd_portx_bp_page_cnt_s {
+		uint64_t reserved_18_63:46;
+		uint64_t bp_enb:1;
+		uint64_t page_cnt:17;
+	} s;
+	struct cvmx_ipd_portx_bp_page_cnt_s cn30xx;
+	struct cvmx_ipd_portx_bp_page_cnt_s cn31xx;
+	struct cvmx_ipd_portx_bp_page_cnt_s cn38xx;
+	struct cvmx_ipd_portx_bp_page_cnt_s cn38xxp2;
+	struct cvmx_ipd_portx_bp_page_cnt_s cn50xx;
+	struct cvmx_ipd_portx_bp_page_cnt_s cn52xx;
+	struct cvmx_ipd_portx_bp_page_cnt_s cn52xxp1;
+	struct cvmx_ipd_portx_bp_page_cnt_s cn56xx;
+	struct cvmx_ipd_portx_bp_page_cnt_s cn56xxp1;
+	struct cvmx_ipd_portx_bp_page_cnt_s cn58xx;
+	struct cvmx_ipd_portx_bp_page_cnt_s cn58xxp1;
+};
+typedef union cvmx_ipd_portx_bp_page_cnt cvmx_ipd_portx_bp_page_cnt_t;
+
+union cvmx_ipd_portx_bp_page_cnt2 {
+	uint64_t u64;
+	struct cvmx_ipd_portx_bp_page_cnt2_s {
+		uint64_t reserved_18_63:46;
+		uint64_t bp_enb:1;
+		uint64_t page_cnt:17;
+	} s;
+	struct cvmx_ipd_portx_bp_page_cnt2_s cn52xx;
+	struct cvmx_ipd_portx_bp_page_cnt2_s cn52xxp1;
+	struct cvmx_ipd_portx_bp_page_cnt2_s cn56xx;
+	struct cvmx_ipd_portx_bp_page_cnt2_s cn56xxp1;
+};
+typedef union cvmx_ipd_portx_bp_page_cnt2 cvmx_ipd_portx_bp_page_cnt2_t;
+
+union cvmx_ipd_port_bp_counters2_pairx {
+	uint64_t u64;
+	struct cvmx_ipd_port_bp_counters2_pairx_s {
+		uint64_t reserved_25_63:39;
+		uint64_t cnt_val:25;
+	} s;
+	struct cvmx_ipd_port_bp_counters2_pairx_s cn52xx;
+	struct cvmx_ipd_port_bp_counters2_pairx_s cn52xxp1;
+	struct cvmx_ipd_port_bp_counters2_pairx_s cn56xx;
+	struct cvmx_ipd_port_bp_counters2_pairx_s cn56xxp1;
+};
+typedef union cvmx_ipd_port_bp_counters2_pairx
+    cvmx_ipd_port_bp_counters2_pairx_t;
+
+union cvmx_ipd_port_bp_counters_pairx {
+	uint64_t u64;
+	struct cvmx_ipd_port_bp_counters_pairx_s {
+		uint64_t reserved_25_63:39;
+		uint64_t cnt_val:25;
+	} s;
+	struct cvmx_ipd_port_bp_counters_pairx_s cn30xx;
+	struct cvmx_ipd_port_bp_counters_pairx_s cn31xx;
+	struct cvmx_ipd_port_bp_counters_pairx_s cn38xx;
+	struct cvmx_ipd_port_bp_counters_pairx_s cn38xxp2;
+	struct cvmx_ipd_port_bp_counters_pairx_s cn50xx;
+	struct cvmx_ipd_port_bp_counters_pairx_s cn52xx;
+	struct cvmx_ipd_port_bp_counters_pairx_s cn52xxp1;
+	struct cvmx_ipd_port_bp_counters_pairx_s cn56xx;
+	struct cvmx_ipd_port_bp_counters_pairx_s cn56xxp1;
+	struct cvmx_ipd_port_bp_counters_pairx_s cn58xx;
+	struct cvmx_ipd_port_bp_counters_pairx_s cn58xxp1;
+};
+typedef union cvmx_ipd_port_bp_counters_pairx cvmx_ipd_port_bp_counters_pairx_t;
+
+union cvmx_ipd_port_qos_x_cnt {
+	uint64_t u64;
+	struct cvmx_ipd_port_qos_x_cnt_s {
+		uint64_t wmark:32;
+		uint64_t cnt:32;
+	} s;
+	struct cvmx_ipd_port_qos_x_cnt_s cn52xx;
+	struct cvmx_ipd_port_qos_x_cnt_s cn52xxp1;
+	struct cvmx_ipd_port_qos_x_cnt_s cn56xx;
+	struct cvmx_ipd_port_qos_x_cnt_s cn56xxp1;
+};
+typedef union cvmx_ipd_port_qos_x_cnt cvmx_ipd_port_qos_x_cnt_t;
+
+union cvmx_ipd_port_qos_intx {
+	uint64_t u64;
+	struct cvmx_ipd_port_qos_intx_s {
+		uint64_t intr:64;
+	} s;
+	struct cvmx_ipd_port_qos_intx_s cn52xx;
+	struct cvmx_ipd_port_qos_intx_s cn52xxp1;
+	struct cvmx_ipd_port_qos_intx_s cn56xx;
+	struct cvmx_ipd_port_qos_intx_s cn56xxp1;
+};
+typedef union cvmx_ipd_port_qos_intx cvmx_ipd_port_qos_intx_t;
+
+union cvmx_ipd_port_qos_int_enbx {
+	uint64_t u64;
+	struct cvmx_ipd_port_qos_int_enbx_s {
+		uint64_t enb:64;
+	} s;
+	struct cvmx_ipd_port_qos_int_enbx_s cn52xx;
+	struct cvmx_ipd_port_qos_int_enbx_s cn52xxp1;
+	struct cvmx_ipd_port_qos_int_enbx_s cn56xx;
+	struct cvmx_ipd_port_qos_int_enbx_s cn56xxp1;
+};
+typedef union cvmx_ipd_port_qos_int_enbx cvmx_ipd_port_qos_int_enbx_t;
+
+union cvmx_ipd_prc_hold_ptr_fifo_ctl {
+	uint64_t u64;
+	struct cvmx_ipd_prc_hold_ptr_fifo_ctl_s {
+		uint64_t reserved_39_63:25;
+		uint64_t max_pkt:3;
+		uint64_t praddr:3;
+		uint64_t ptr:29;
+		uint64_t cena:1;
+		uint64_t raddr:3;
+	} s;
+	struct cvmx_ipd_prc_hold_ptr_fifo_ctl_s cn30xx;
+	struct cvmx_ipd_prc_hold_ptr_fifo_ctl_s cn31xx;
+	struct cvmx_ipd_prc_hold_ptr_fifo_ctl_s cn38xx;
+	struct cvmx_ipd_prc_hold_ptr_fifo_ctl_s cn50xx;
+	struct cvmx_ipd_prc_hold_ptr_fifo_ctl_s cn52xx;
+	struct cvmx_ipd_prc_hold_ptr_fifo_ctl_s cn52xxp1;
+	struct cvmx_ipd_prc_hold_ptr_fifo_ctl_s cn56xx;
+	struct cvmx_ipd_prc_hold_ptr_fifo_ctl_s cn56xxp1;
+	struct cvmx_ipd_prc_hold_ptr_fifo_ctl_s cn58xx;
+	struct cvmx_ipd_prc_hold_ptr_fifo_ctl_s cn58xxp1;
+};
+typedef union cvmx_ipd_prc_hold_ptr_fifo_ctl cvmx_ipd_prc_hold_ptr_fifo_ctl_t;
+
+union cvmx_ipd_prc_port_ptr_fifo_ctl {
+	uint64_t u64;
+	struct cvmx_ipd_prc_port_ptr_fifo_ctl_s {
+		uint64_t reserved_44_63:20;
+		uint64_t max_pkt:7;
+		uint64_t ptr:29;
+		uint64_t cena:1;
+		uint64_t raddr:7;
+	} s;
+	struct cvmx_ipd_prc_port_ptr_fifo_ctl_s cn30xx;
+	struct cvmx_ipd_prc_port_ptr_fifo_ctl_s cn31xx;
+	struct cvmx_ipd_prc_port_ptr_fifo_ctl_s cn38xx;
+	struct cvmx_ipd_prc_port_ptr_fifo_ctl_s cn50xx;
+	struct cvmx_ipd_prc_port_ptr_fifo_ctl_s cn52xx;
+	struct cvmx_ipd_prc_port_ptr_fifo_ctl_s cn52xxp1;
+	struct cvmx_ipd_prc_port_ptr_fifo_ctl_s cn56xx;
+	struct cvmx_ipd_prc_port_ptr_fifo_ctl_s cn56xxp1;
+	struct cvmx_ipd_prc_port_ptr_fifo_ctl_s cn58xx;
+	struct cvmx_ipd_prc_port_ptr_fifo_ctl_s cn58xxp1;
+};
+typedef union cvmx_ipd_prc_port_ptr_fifo_ctl cvmx_ipd_prc_port_ptr_fifo_ctl_t;
+
+union cvmx_ipd_ptr_count {
+	uint64_t u64;
+	struct cvmx_ipd_ptr_count_s {
+		uint64_t reserved_19_63:45;
+		uint64_t pktv_cnt:1;
+		uint64_t wqev_cnt:1;
+		uint64_t pfif_cnt:3;
+		uint64_t pkt_pcnt:7;
+		uint64_t wqe_pcnt:7;
+	} s;
+	struct cvmx_ipd_ptr_count_s cn30xx;
+	struct cvmx_ipd_ptr_count_s cn31xx;
+	struct cvmx_ipd_ptr_count_s cn38xx;
+	struct cvmx_ipd_ptr_count_s cn38xxp2;
+	struct cvmx_ipd_ptr_count_s cn50xx;
+	struct cvmx_ipd_ptr_count_s cn52xx;
+	struct cvmx_ipd_ptr_count_s cn52xxp1;
+	struct cvmx_ipd_ptr_count_s cn56xx;
+	struct cvmx_ipd_ptr_count_s cn56xxp1;
+	struct cvmx_ipd_ptr_count_s cn58xx;
+	struct cvmx_ipd_ptr_count_s cn58xxp1;
+};
+typedef union cvmx_ipd_ptr_count cvmx_ipd_ptr_count_t;
+
+union cvmx_ipd_pwp_ptr_fifo_ctl {
+	uint64_t u64;
+	struct cvmx_ipd_pwp_ptr_fifo_ctl_s {
+		uint64_t reserved_61_63:3;
+		uint64_t max_cnts:7;
+		uint64_t wraddr:8;
+		uint64_t praddr:8;
+		uint64_t ptr:29;
+		uint64_t cena:1;
+		uint64_t raddr:8;
+	} s;
+	struct cvmx_ipd_pwp_ptr_fifo_ctl_s cn30xx;
+	struct cvmx_ipd_pwp_ptr_fifo_ctl_s cn31xx;
+	struct cvmx_ipd_pwp_ptr_fifo_ctl_s cn38xx;
+	struct cvmx_ipd_pwp_ptr_fifo_ctl_s cn50xx;
+	struct cvmx_ipd_pwp_ptr_fifo_ctl_s cn52xx;
+	struct cvmx_ipd_pwp_ptr_fifo_ctl_s cn52xxp1;
+	struct cvmx_ipd_pwp_ptr_fifo_ctl_s cn56xx;
+	struct cvmx_ipd_pwp_ptr_fifo_ctl_s cn56xxp1;
+	struct cvmx_ipd_pwp_ptr_fifo_ctl_s cn58xx;
+	struct cvmx_ipd_pwp_ptr_fifo_ctl_s cn58xxp1;
+};
+typedef union cvmx_ipd_pwp_ptr_fifo_ctl cvmx_ipd_pwp_ptr_fifo_ctl_t;
+
+union cvmx_ipd_qosx_red_marks {
+	uint64_t u64;
+	struct cvmx_ipd_qosx_red_marks_s {
+		uint64_t drop:32;
+		uint64_t pass:32;
+	} s;
+	struct cvmx_ipd_qosx_red_marks_s cn30xx;
+	struct cvmx_ipd_qosx_red_marks_s cn31xx;
+	struct cvmx_ipd_qosx_red_marks_s cn38xx;
+	struct cvmx_ipd_qosx_red_marks_s cn38xxp2;
+	struct cvmx_ipd_qosx_red_marks_s cn50xx;
+	struct cvmx_ipd_qosx_red_marks_s cn52xx;
+	struct cvmx_ipd_qosx_red_marks_s cn52xxp1;
+	struct cvmx_ipd_qosx_red_marks_s cn56xx;
+	struct cvmx_ipd_qosx_red_marks_s cn56xxp1;
+	struct cvmx_ipd_qosx_red_marks_s cn58xx;
+	struct cvmx_ipd_qosx_red_marks_s cn58xxp1;
+};
+typedef union cvmx_ipd_qosx_red_marks cvmx_ipd_qosx_red_marks_t;
+
+union cvmx_ipd_que0_free_page_cnt {
+	uint64_t u64;
+	struct cvmx_ipd_que0_free_page_cnt_s {
+		uint64_t reserved_32_63:32;
+		uint64_t q0_pcnt:32;
+	} s;
+	struct cvmx_ipd_que0_free_page_cnt_s cn30xx;
+	struct cvmx_ipd_que0_free_page_cnt_s cn31xx;
+	struct cvmx_ipd_que0_free_page_cnt_s cn38xx;
+	struct cvmx_ipd_que0_free_page_cnt_s cn38xxp2;
+	struct cvmx_ipd_que0_free_page_cnt_s cn50xx;
+	struct cvmx_ipd_que0_free_page_cnt_s cn52xx;
+	struct cvmx_ipd_que0_free_page_cnt_s cn52xxp1;
+	struct cvmx_ipd_que0_free_page_cnt_s cn56xx;
+	struct cvmx_ipd_que0_free_page_cnt_s cn56xxp1;
+	struct cvmx_ipd_que0_free_page_cnt_s cn58xx;
+	struct cvmx_ipd_que0_free_page_cnt_s cn58xxp1;
+};
+typedef union cvmx_ipd_que0_free_page_cnt cvmx_ipd_que0_free_page_cnt_t;
+
+union cvmx_ipd_red_port_enable {
+	uint64_t u64;
+	struct cvmx_ipd_red_port_enable_s {
+		uint64_t prb_dly:14;
+		uint64_t avg_dly:14;
+		uint64_t prt_enb:36;
+	} s;
+	struct cvmx_ipd_red_port_enable_s cn30xx;
+	struct cvmx_ipd_red_port_enable_s cn31xx;
+	struct cvmx_ipd_red_port_enable_s cn38xx;
+	struct cvmx_ipd_red_port_enable_s cn38xxp2;
+	struct cvmx_ipd_red_port_enable_s cn50xx;
+	struct cvmx_ipd_red_port_enable_s cn52xx;
+	struct cvmx_ipd_red_port_enable_s cn52xxp1;
+	struct cvmx_ipd_red_port_enable_s cn56xx;
+	struct cvmx_ipd_red_port_enable_s cn56xxp1;
+	struct cvmx_ipd_red_port_enable_s cn58xx;
+	struct cvmx_ipd_red_port_enable_s cn58xxp1;
+};
+typedef union cvmx_ipd_red_port_enable cvmx_ipd_red_port_enable_t;
+
+union cvmx_ipd_red_port_enable2 {
+	uint64_t u64;
+	struct cvmx_ipd_red_port_enable2_s {
+		uint64_t reserved_4_63:60;
+		uint64_t prt_enb:4;
+	} s;
+	struct cvmx_ipd_red_port_enable2_s cn52xx;
+	struct cvmx_ipd_red_port_enable2_s cn52xxp1;
+	struct cvmx_ipd_red_port_enable2_s cn56xx;
+	struct cvmx_ipd_red_port_enable2_s cn56xxp1;
+};
+typedef union cvmx_ipd_red_port_enable2 cvmx_ipd_red_port_enable2_t;
+
+union cvmx_ipd_red_quex_param {
+	uint64_t u64;
+	struct cvmx_ipd_red_quex_param_s {
+		uint64_t reserved_49_63:15;
+		uint64_t use_pcnt:1;
+		uint64_t new_con:8;
+		uint64_t avg_con:8;
+		uint64_t prb_con:32;
+	} s;
+	struct cvmx_ipd_red_quex_param_s cn30xx;
+	struct cvmx_ipd_red_quex_param_s cn31xx;
+	struct cvmx_ipd_red_quex_param_s cn38xx;
+	struct cvmx_ipd_red_quex_param_s cn38xxp2;
+	struct cvmx_ipd_red_quex_param_s cn50xx;
+	struct cvmx_ipd_red_quex_param_s cn52xx;
+	struct cvmx_ipd_red_quex_param_s cn52xxp1;
+	struct cvmx_ipd_red_quex_param_s cn56xx;
+	struct cvmx_ipd_red_quex_param_s cn56xxp1;
+	struct cvmx_ipd_red_quex_param_s cn58xx;
+	struct cvmx_ipd_red_quex_param_s cn58xxp1;
+};
+typedef union cvmx_ipd_red_quex_param cvmx_ipd_red_quex_param_t;
+
+union cvmx_ipd_sub_port_bp_page_cnt {
+	uint64_t u64;
+	struct cvmx_ipd_sub_port_bp_page_cnt_s {
+		uint64_t reserved_31_63:33;
+		uint64_t port:6;
+		uint64_t page_cnt:25;
+	} s;
+	struct cvmx_ipd_sub_port_bp_page_cnt_s cn30xx;
+	struct cvmx_ipd_sub_port_bp_page_cnt_s cn31xx;
+	struct cvmx_ipd_sub_port_bp_page_cnt_s cn38xx;
+	struct cvmx_ipd_sub_port_bp_page_cnt_s cn38xxp2;
+	struct cvmx_ipd_sub_port_bp_page_cnt_s cn50xx;
+	struct cvmx_ipd_sub_port_bp_page_cnt_s cn52xx;
+	struct cvmx_ipd_sub_port_bp_page_cnt_s cn52xxp1;
+	struct cvmx_ipd_sub_port_bp_page_cnt_s cn56xx;
+	struct cvmx_ipd_sub_port_bp_page_cnt_s cn56xxp1;
+	struct cvmx_ipd_sub_port_bp_page_cnt_s cn58xx;
+	struct cvmx_ipd_sub_port_bp_page_cnt_s cn58xxp1;
+};
+typedef union cvmx_ipd_sub_port_bp_page_cnt cvmx_ipd_sub_port_bp_page_cnt_t;
+
+union cvmx_ipd_sub_port_fcs {
+	uint64_t u64;
+	struct cvmx_ipd_sub_port_fcs_s {
+		uint64_t reserved_40_63:24;
+		uint64_t port_bit2:4;
+		uint64_t reserved_32_35:4;
+		uint64_t port_bit:32;
+	} s;
+	struct cvmx_ipd_sub_port_fcs_cn30xx {
+		uint64_t reserved_3_63:61;
+		uint64_t port_bit:3;
+	} cn30xx;
+	struct cvmx_ipd_sub_port_fcs_cn30xx cn31xx;
+	struct cvmx_ipd_sub_port_fcs_cn38xx {
+		uint64_t reserved_32_63:32;
+		uint64_t port_bit:32;
+	} cn38xx;
+	struct cvmx_ipd_sub_port_fcs_cn38xx cn38xxp2;
+	struct cvmx_ipd_sub_port_fcs_cn30xx cn50xx;
+	struct cvmx_ipd_sub_port_fcs_s cn52xx;
+	struct cvmx_ipd_sub_port_fcs_s cn52xxp1;
+	struct cvmx_ipd_sub_port_fcs_s cn56xx;
+	struct cvmx_ipd_sub_port_fcs_s cn56xxp1;
+	struct cvmx_ipd_sub_port_fcs_cn38xx cn58xx;
+	struct cvmx_ipd_sub_port_fcs_cn38xx cn58xxp1;
+};
+typedef union cvmx_ipd_sub_port_fcs cvmx_ipd_sub_port_fcs_t;
+
+union cvmx_ipd_sub_port_qos_cnt {
+	uint64_t u64;
+	struct cvmx_ipd_sub_port_qos_cnt_s {
+		uint64_t reserved_41_63:23;
+		uint64_t port_qos:9;
+		uint64_t cnt:32;
+	} s;
+	struct cvmx_ipd_sub_port_qos_cnt_s cn52xx;
+	struct cvmx_ipd_sub_port_qos_cnt_s cn52xxp1;
+	struct cvmx_ipd_sub_port_qos_cnt_s cn56xx;
+	struct cvmx_ipd_sub_port_qos_cnt_s cn56xxp1;
+};
+typedef union cvmx_ipd_sub_port_qos_cnt cvmx_ipd_sub_port_qos_cnt_t;
+
+union cvmx_ipd_wqe_fpa_queue {
+	uint64_t u64;
+	struct cvmx_ipd_wqe_fpa_queue_s {
+		uint64_t reserved_3_63:61;
+		uint64_t wqe_pool:3;
+	} s;
+	struct cvmx_ipd_wqe_fpa_queue_s cn30xx;
+	struct cvmx_ipd_wqe_fpa_queue_s cn31xx;
+	struct cvmx_ipd_wqe_fpa_queue_s cn38xx;
+	struct cvmx_ipd_wqe_fpa_queue_s cn38xxp2;
+	struct cvmx_ipd_wqe_fpa_queue_s cn50xx;
+	struct cvmx_ipd_wqe_fpa_queue_s cn52xx;
+	struct cvmx_ipd_wqe_fpa_queue_s cn52xxp1;
+	struct cvmx_ipd_wqe_fpa_queue_s cn56xx;
+	struct cvmx_ipd_wqe_fpa_queue_s cn56xxp1;
+	struct cvmx_ipd_wqe_fpa_queue_s cn58xx;
+	struct cvmx_ipd_wqe_fpa_queue_s cn58xxp1;
+};
+typedef union cvmx_ipd_wqe_fpa_queue cvmx_ipd_wqe_fpa_queue_t;
+
+union cvmx_ipd_wqe_ptr_valid {
+	uint64_t u64;
+	struct cvmx_ipd_wqe_ptr_valid_s {
+		uint64_t reserved_29_63:35;
+		uint64_t ptr:29;
+	} s;
+	struct cvmx_ipd_wqe_ptr_valid_s cn30xx;
+	struct cvmx_ipd_wqe_ptr_valid_s cn31xx;
+	struct cvmx_ipd_wqe_ptr_valid_s cn38xx;
+	struct cvmx_ipd_wqe_ptr_valid_s cn50xx;
+	struct cvmx_ipd_wqe_ptr_valid_s cn52xx;
+	struct cvmx_ipd_wqe_ptr_valid_s cn52xxp1;
+	struct cvmx_ipd_wqe_ptr_valid_s cn56xx;
+	struct cvmx_ipd_wqe_ptr_valid_s cn56xxp1;
+	struct cvmx_ipd_wqe_ptr_valid_s cn58xx;
+	struct cvmx_ipd_wqe_ptr_valid_s cn58xxp1;
+};
+typedef union cvmx_ipd_wqe_ptr_valid cvmx_ipd_wqe_ptr_valid_t;
+
+#endif
diff --git a/arch/mips/include/asm/octeon/cvmx-l2c-defs.h b/arch/mips/include/asm/octeon/cvmx-l2c-defs.h
new file mode 100644
index 0000000..4c67597
--- /dev/null
+++ b/arch/mips/include/asm/octeon/cvmx-l2c-defs.h
@@ -0,0 +1,958 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as published by
+ * the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful,
+ * but AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or NONINFRINGEMENT.
+ * See the GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+ ***********************license end**************************************/
+
+#ifndef __CVMX_L2C_DEFS_H__
+#define __CVMX_L2C_DEFS_H__
+
+#define CVMX_L2C_BST0                                        CVMX_ADD_IO_SEG(0x00011800800007F8ull)
+#define CVMX_L2C_BST1                                        CVMX_ADD_IO_SEG(0x00011800800007F0ull)
+#define CVMX_L2C_BST2                                        CVMX_ADD_IO_SEG(0x00011800800007E8ull)
+#define CVMX_L2C_CFG                                         CVMX_ADD_IO_SEG(0x0001180080000000ull)
+#define CVMX_L2C_DBG                                         CVMX_ADD_IO_SEG(0x0001180080000030ull)
+#define CVMX_L2C_DUT                                         CVMX_ADD_IO_SEG(0x0001180080000050ull)
+#define CVMX_L2C_GRPWRR0                                     CVMX_ADD_IO_SEG(0x00011800800000C8ull)
+#define CVMX_L2C_GRPWRR1                                     CVMX_ADD_IO_SEG(0x00011800800000D0ull)
+#define CVMX_L2C_INT_EN                                      CVMX_ADD_IO_SEG(0x0001180080000100ull)
+#define CVMX_L2C_INT_STAT                                    CVMX_ADD_IO_SEG(0x00011800800000F8ull)
+#define CVMX_L2C_LCKBASE                                     CVMX_ADD_IO_SEG(0x0001180080000058ull)
+#define CVMX_L2C_LCKOFF                                      CVMX_ADD_IO_SEG(0x0001180080000060ull)
+#define CVMX_L2C_LFB0                                        CVMX_ADD_IO_SEG(0x0001180080000038ull)
+#define CVMX_L2C_LFB1                                        CVMX_ADD_IO_SEG(0x0001180080000040ull)
+#define CVMX_L2C_LFB2                                        CVMX_ADD_IO_SEG(0x0001180080000048ull)
+#define CVMX_L2C_LFB3                                        CVMX_ADD_IO_SEG(0x00011800800000B8ull)
+#define CVMX_L2C_OOB                                         CVMX_ADD_IO_SEG(0x00011800800000D8ull)
+#define CVMX_L2C_OOB1                                        CVMX_ADD_IO_SEG(0x00011800800000E0ull)
+#define CVMX_L2C_OOB2                                        CVMX_ADD_IO_SEG(0x00011800800000E8ull)
+#define CVMX_L2C_OOB3                                        CVMX_ADD_IO_SEG(0x00011800800000F0ull)
+#define CVMX_L2C_PFC0                                        CVMX_ADD_IO_SEG(0x0001180080000098ull)
+#define CVMX_L2C_PFC1                                        CVMX_ADD_IO_SEG(0x00011800800000A0ull)
+#define CVMX_L2C_PFC2                                        CVMX_ADD_IO_SEG(0x00011800800000A8ull)
+#define CVMX_L2C_PFC3                                        CVMX_ADD_IO_SEG(0x00011800800000B0ull)
+#define CVMX_L2C_PFCTL                                       CVMX_ADD_IO_SEG(0x0001180080000090ull)
+#define CVMX_L2C_PFCX(offset)                                CVMX_ADD_IO_SEG(0x0001180080000098ull + (((offset) & 3) * 8))
+#define CVMX_L2C_PPGRP                                       CVMX_ADD_IO_SEG(0x00011800800000C0ull)
+#define CVMX_L2C_SPAR0                                       CVMX_ADD_IO_SEG(0x0001180080000068ull)
+#define CVMX_L2C_SPAR1                                       CVMX_ADD_IO_SEG(0x0001180080000070ull)
+#define CVMX_L2C_SPAR2                                       CVMX_ADD_IO_SEG(0x0001180080000078ull)
+#define CVMX_L2C_SPAR3                                       CVMX_ADD_IO_SEG(0x0001180080000080ull)
+#define CVMX_L2C_SPAR4                                       CVMX_ADD_IO_SEG(0x0001180080000088ull)
+
+union cvmx_l2c_bst0 {
+	uint64_t u64;
+	struct cvmx_l2c_bst0_s {
+		uint64_t reserved_24_63:40;
+		uint64_t dtbnk:1;
+		uint64_t wlb_msk:4;
+		uint64_t dtcnt:13;
+		uint64_t dt:1;
+		uint64_t stin_msk:1;
+		uint64_t wlb_dat:4;
+	} s;
+	struct cvmx_l2c_bst0_cn30xx {
+		uint64_t reserved_23_63:41;
+		uint64_t wlb_msk:4;
+		uint64_t reserved_15_18:4;
+		uint64_t dtcnt:9;
+		uint64_t dt:1;
+		uint64_t reserved_4_4:1;
+		uint64_t wlb_dat:4;
+	} cn30xx;
+	struct cvmx_l2c_bst0_cn31xx {
+		uint64_t reserved_23_63:41;
+		uint64_t wlb_msk:4;
+		uint64_t reserved_16_18:3;
+		uint64_t dtcnt:10;
+		uint64_t dt:1;
+		uint64_t stin_msk:1;
+		uint64_t wlb_dat:4;
+	} cn31xx;
+	struct cvmx_l2c_bst0_cn38xx {
+		uint64_t reserved_19_63:45;
+		uint64_t dtcnt:13;
+		uint64_t dt:1;
+		uint64_t stin_msk:1;
+		uint64_t wlb_dat:4;
+	} cn38xx;
+	struct cvmx_l2c_bst0_cn38xx cn38xxp2;
+	struct cvmx_l2c_bst0_cn50xx {
+		uint64_t reserved_24_63:40;
+		uint64_t dtbnk:1;
+		uint64_t wlb_msk:4;
+		uint64_t reserved_16_18:3;
+		uint64_t dtcnt:10;
+		uint64_t dt:1;
+		uint64_t stin_msk:1;
+		uint64_t wlb_dat:4;
+	} cn50xx;
+	struct cvmx_l2c_bst0_cn50xx cn52xx;
+	struct cvmx_l2c_bst0_cn50xx cn52xxp1;
+	struct cvmx_l2c_bst0_s cn56xx;
+	struct cvmx_l2c_bst0_s cn56xxp1;
+	struct cvmx_l2c_bst0_s cn58xx;
+	struct cvmx_l2c_bst0_s cn58xxp1;
+};
+typedef union cvmx_l2c_bst0 cvmx_l2c_bst0_t;
+
+union cvmx_l2c_bst1 {
+	uint64_t u64;
+	struct cvmx_l2c_bst1_s {
+		uint64_t reserved_9_63:55;
+		uint64_t l2t:9;
+	} s;
+	struct cvmx_l2c_bst1_cn30xx {
+		uint64_t reserved_16_63:48;
+		uint64_t vwdf:4;
+		uint64_t lrf:2;
+		uint64_t vab_vwcf:1;
+		uint64_t reserved_5_8:4;
+		uint64_t l2t:5;
+	} cn30xx;
+	struct cvmx_l2c_bst1_cn30xx cn31xx;
+	struct cvmx_l2c_bst1_cn38xx {
+		uint64_t reserved_16_63:48;
+		uint64_t vwdf:4;
+		uint64_t lrf:2;
+		uint64_t vab_vwcf:1;
+		uint64_t l2t:9;
+	} cn38xx;
+	struct cvmx_l2c_bst1_cn38xx cn38xxp2;
+	struct cvmx_l2c_bst1_cn38xx cn50xx;
+	struct cvmx_l2c_bst1_cn52xx {
+		uint64_t reserved_19_63:45;
+		uint64_t plc2:1;
+		uint64_t plc1:1;
+		uint64_t plc0:1;
+		uint64_t vwdf:4;
+		uint64_t reserved_11_11:1;
+		uint64_t ilc:1;
+		uint64_t vab_vwcf:1;
+		uint64_t l2t:9;
+	} cn52xx;
+	struct cvmx_l2c_bst1_cn52xx cn52xxp1;
+	struct cvmx_l2c_bst1_cn56xx {
+		uint64_t reserved_24_63:40;
+		uint64_t plc2:1;
+		uint64_t plc1:1;
+		uint64_t plc0:1;
+		uint64_t ilc:1;
+		uint64_t vwdf1:4;
+		uint64_t vwdf0:4;
+		uint64_t vab_vwcf1:1;
+		uint64_t reserved_10_10:1;
+		uint64_t vab_vwcf0:1;
+		uint64_t l2t:9;
+	} cn56xx;
+	struct cvmx_l2c_bst1_cn56xx cn56xxp1;
+	struct cvmx_l2c_bst1_cn38xx cn58xx;
+	struct cvmx_l2c_bst1_cn38xx cn58xxp1;
+};
+typedef union cvmx_l2c_bst1 cvmx_l2c_bst1_t;
+
+union cvmx_l2c_bst2 {
+	uint64_t u64;
+	struct cvmx_l2c_bst2_s {
+		uint64_t reserved_16_63:48;
+		uint64_t mrb:4;
+		uint64_t reserved_4_11:8;
+		uint64_t ipcbst:1;
+		uint64_t picbst:1;
+		uint64_t xrdmsk:1;
+		uint64_t xrddat:1;
+	} s;
+	struct cvmx_l2c_bst2_cn30xx {
+		uint64_t reserved_16_63:48;
+		uint64_t mrb:4;
+		uint64_t rmdf:4;
+		uint64_t reserved_4_7:4;
+		uint64_t ipcbst:1;
+		uint64_t reserved_2_2:1;
+		uint64_t xrdmsk:1;
+		uint64_t xrddat:1;
+	} cn30xx;
+	struct cvmx_l2c_bst2_cn30xx cn31xx;
+	struct cvmx_l2c_bst2_cn38xx {
+		uint64_t reserved_16_63:48;
+		uint64_t mrb:4;
+		uint64_t rmdf:4;
+		uint64_t rhdf:4;
+		uint64_t ipcbst:1;
+		uint64_t picbst:1;
+		uint64_t xrdmsk:1;
+		uint64_t xrddat:1;
+	} cn38xx;
+	struct cvmx_l2c_bst2_cn38xx cn38xxp2;
+	struct cvmx_l2c_bst2_cn30xx cn50xx;
+	struct cvmx_l2c_bst2_cn30xx cn52xx;
+	struct cvmx_l2c_bst2_cn30xx cn52xxp1;
+	struct cvmx_l2c_bst2_cn56xx {
+		uint64_t reserved_16_63:48;
+		uint64_t mrb:4;
+		uint64_t rmdb:4;
+		uint64_t rhdb:4;
+		uint64_t ipcbst:1;
+		uint64_t picbst:1;
+		uint64_t xrdmsk:1;
+		uint64_t xrddat:1;
+	} cn56xx;
+	struct cvmx_l2c_bst2_cn56xx cn56xxp1;
+	struct cvmx_l2c_bst2_cn56xx cn58xx;
+	struct cvmx_l2c_bst2_cn56xx cn58xxp1;
+};
+typedef union cvmx_l2c_bst2 cvmx_l2c_bst2_t;
+
+union cvmx_l2c_cfg {
+	uint64_t u64;
+	struct cvmx_l2c_cfg_s {
+		uint64_t reserved_20_63:44;
+		uint64_t bstrun:1;
+		uint64_t lbist:1;
+		uint64_t xor_bank:1;
+		uint64_t dpres1:1;
+		uint64_t dpres0:1;
+		uint64_t dfill_dis:1;
+		uint64_t fpexp:4;
+		uint64_t fpempty:1;
+		uint64_t fpen:1;
+		uint64_t idxalias:1;
+		uint64_t mwf_crd:4;
+		uint64_t rsp_arb_mode:1;
+		uint64_t rfb_arb_mode:1;
+		uint64_t lrf_arb_mode:1;
+	} s;
+	struct cvmx_l2c_cfg_cn30xx {
+		uint64_t reserved_14_63:50;
+		uint64_t fpexp:4;
+		uint64_t fpempty:1;
+		uint64_t fpen:1;
+		uint64_t idxalias:1;
+		uint64_t mwf_crd:4;
+		uint64_t rsp_arb_mode:1;
+		uint64_t rfb_arb_mode:1;
+		uint64_t lrf_arb_mode:1;
+	} cn30xx;
+	struct cvmx_l2c_cfg_cn30xx cn31xx;
+	struct cvmx_l2c_cfg_cn30xx cn38xx;
+	struct cvmx_l2c_cfg_cn30xx cn38xxp2;
+	struct cvmx_l2c_cfg_cn50xx {
+		uint64_t reserved_20_63:44;
+		uint64_t bstrun:1;
+		uint64_t lbist:1;
+		uint64_t reserved_14_17:4;
+		uint64_t fpexp:4;
+		uint64_t fpempty:1;
+		uint64_t fpen:1;
+		uint64_t idxalias:1;
+		uint64_t mwf_crd:4;
+		uint64_t rsp_arb_mode:1;
+		uint64_t rfb_arb_mode:1;
+		uint64_t lrf_arb_mode:1;
+	} cn50xx;
+	struct cvmx_l2c_cfg_cn50xx cn52xx;
+	struct cvmx_l2c_cfg_cn50xx cn52xxp1;
+	struct cvmx_l2c_cfg_s cn56xx;
+	struct cvmx_l2c_cfg_s cn56xxp1;
+	struct cvmx_l2c_cfg_cn58xx {
+		uint64_t reserved_20_63:44;
+		uint64_t bstrun:1;
+		uint64_t lbist:1;
+		uint64_t reserved_15_17:3;
+		uint64_t dfill_dis:1;
+		uint64_t fpexp:4;
+		uint64_t fpempty:1;
+		uint64_t fpen:1;
+		uint64_t idxalias:1;
+		uint64_t mwf_crd:4;
+		uint64_t rsp_arb_mode:1;
+		uint64_t rfb_arb_mode:1;
+		uint64_t lrf_arb_mode:1;
+	} cn58xx;
+	struct cvmx_l2c_cfg_cn58xxp1 {
+		uint64_t reserved_15_63:49;
+		uint64_t dfill_dis:1;
+		uint64_t fpexp:4;
+		uint64_t fpempty:1;
+		uint64_t fpen:1;
+		uint64_t idxalias:1;
+		uint64_t mwf_crd:4;
+		uint64_t rsp_arb_mode:1;
+		uint64_t rfb_arb_mode:1;
+		uint64_t lrf_arb_mode:1;
+	} cn58xxp1;
+};
+typedef union cvmx_l2c_cfg cvmx_l2c_cfg_t;
+
+union cvmx_l2c_dbg {
+	uint64_t u64;
+	struct cvmx_l2c_dbg_s {
+		uint64_t reserved_15_63:49;
+		uint64_t lfb_enum:4;
+		uint64_t lfb_dmp:1;
+		uint64_t ppnum:4;
+		uint64_t set:3;
+		uint64_t finv:1;
+		uint64_t l2d:1;
+		uint64_t l2t:1;
+	} s;
+	struct cvmx_l2c_dbg_cn30xx {
+		uint64_t reserved_13_63:51;
+		uint64_t lfb_enum:2;
+		uint64_t lfb_dmp:1;
+		uint64_t reserved_5_9:5;
+		uint64_t set:2;
+		uint64_t finv:1;
+		uint64_t l2d:1;
+		uint64_t l2t:1;
+	} cn30xx;
+	struct cvmx_l2c_dbg_cn31xx {
+		uint64_t reserved_14_63:50;
+		uint64_t lfb_enum:3;
+		uint64_t lfb_dmp:1;
+		uint64_t reserved_7_9:3;
+		uint64_t ppnum:1;
+		uint64_t reserved_5_5:1;
+		uint64_t set:2;
+		uint64_t finv:1;
+		uint64_t l2d:1;
+		uint64_t l2t:1;
+	} cn31xx;
+	struct cvmx_l2c_dbg_s cn38xx;
+	struct cvmx_l2c_dbg_s cn38xxp2;
+	struct cvmx_l2c_dbg_cn50xx {
+		uint64_t reserved_14_63:50;
+		uint64_t lfb_enum:3;
+		uint64_t lfb_dmp:1;
+		uint64_t reserved_7_9:3;
+		uint64_t ppnum:1;
+		uint64_t set:3;
+		uint64_t finv:1;
+		uint64_t l2d:1;
+		uint64_t l2t:1;
+	} cn50xx;
+	struct cvmx_l2c_dbg_cn52xx {
+		uint64_t reserved_14_63:50;
+		uint64_t lfb_enum:3;
+		uint64_t lfb_dmp:1;
+		uint64_t reserved_8_9:2;
+		uint64_t ppnum:2;
+		uint64_t set:3;
+		uint64_t finv:1;
+		uint64_t l2d:1;
+		uint64_t l2t:1;
+	} cn52xx;
+	struct cvmx_l2c_dbg_cn52xx cn52xxp1;
+	struct cvmx_l2c_dbg_s cn56xx;
+	struct cvmx_l2c_dbg_s cn56xxp1;
+	struct cvmx_l2c_dbg_s cn58xx;
+	struct cvmx_l2c_dbg_s cn58xxp1;
+};
+typedef union cvmx_l2c_dbg cvmx_l2c_dbg_t;
+
+union cvmx_l2c_dut {
+	uint64_t u64;
+	struct cvmx_l2c_dut_s {
+		uint64_t reserved_32_63:32;
+		uint64_t dtena:1;
+		uint64_t reserved_30_30:1;
+		uint64_t dt_vld:1;
+		uint64_t dt_tag:29;
+	} s;
+	struct cvmx_l2c_dut_s cn30xx;
+	struct cvmx_l2c_dut_s cn31xx;
+	struct cvmx_l2c_dut_s cn38xx;
+	struct cvmx_l2c_dut_s cn38xxp2;
+	struct cvmx_l2c_dut_s cn50xx;
+	struct cvmx_l2c_dut_s cn52xx;
+	struct cvmx_l2c_dut_s cn52xxp1;
+	struct cvmx_l2c_dut_s cn56xx;
+	struct cvmx_l2c_dut_s cn56xxp1;
+	struct cvmx_l2c_dut_s cn58xx;
+	struct cvmx_l2c_dut_s cn58xxp1;
+};
+typedef union cvmx_l2c_dut cvmx_l2c_dut_t;
+
+union cvmx_l2c_grpwrr0 {
+	uint64_t u64;
+	struct cvmx_l2c_grpwrr0_s {
+		uint64_t plc1rmsk:32;
+		uint64_t plc0rmsk:32;
+	} s;
+	struct cvmx_l2c_grpwrr0_s cn52xx;
+	struct cvmx_l2c_grpwrr0_s cn52xxp1;
+	struct cvmx_l2c_grpwrr0_s cn56xx;
+	struct cvmx_l2c_grpwrr0_s cn56xxp1;
+};
+typedef union cvmx_l2c_grpwrr0 cvmx_l2c_grpwrr0_t;
+
+union cvmx_l2c_grpwrr1 {
+	uint64_t u64;
+	struct cvmx_l2c_grpwrr1_s {
+		uint64_t ilcrmsk:32;
+		uint64_t plc2rmsk:32;
+	} s;
+	struct cvmx_l2c_grpwrr1_s cn52xx;
+	struct cvmx_l2c_grpwrr1_s cn52xxp1;
+	struct cvmx_l2c_grpwrr1_s cn56xx;
+	struct cvmx_l2c_grpwrr1_s cn56xxp1;
+};
+typedef union cvmx_l2c_grpwrr1 cvmx_l2c_grpwrr1_t;
+
+union cvmx_l2c_int_en {
+	uint64_t u64;
+	struct cvmx_l2c_int_en_s {
+		uint64_t reserved_9_63:55;
+		uint64_t lck2ena:1;
+		uint64_t lckena:1;
+		uint64_t l2ddeden:1;
+		uint64_t l2dsecen:1;
+		uint64_t l2tdeden:1;
+		uint64_t l2tsecen:1;
+		uint64_t oob3en:1;
+		uint64_t oob2en:1;
+		uint64_t oob1en:1;
+	} s;
+	struct cvmx_l2c_int_en_s cn52xx;
+	struct cvmx_l2c_int_en_s cn52xxp1;
+	struct cvmx_l2c_int_en_s cn56xx;
+	struct cvmx_l2c_int_en_s cn56xxp1;
+};
+typedef union cvmx_l2c_int_en cvmx_l2c_int_en_t;
+
+union cvmx_l2c_int_stat {
+	uint64_t u64;
+	struct cvmx_l2c_int_stat_s {
+		uint64_t reserved_9_63:55;
+		uint64_t lck2:1;
+		uint64_t lck:1;
+		uint64_t l2dded:1;
+		uint64_t l2dsec:1;
+		uint64_t l2tded:1;
+		uint64_t l2tsec:1;
+		uint64_t oob3:1;
+		uint64_t oob2:1;
+		uint64_t oob1:1;
+	} s;
+	struct cvmx_l2c_int_stat_s cn52xx;
+	struct cvmx_l2c_int_stat_s cn52xxp1;
+	struct cvmx_l2c_int_stat_s cn56xx;
+	struct cvmx_l2c_int_stat_s cn56xxp1;
+};
+typedef union cvmx_l2c_int_stat cvmx_l2c_int_stat_t;
+
+union cvmx_l2c_lckbase {
+	uint64_t u64;
+	struct cvmx_l2c_lckbase_s {
+		uint64_t reserved_31_63:33;
+		uint64_t lck_base:27;
+		uint64_t reserved_1_3:3;
+		uint64_t lck_ena:1;
+	} s;
+	struct cvmx_l2c_lckbase_s cn30xx;
+	struct cvmx_l2c_lckbase_s cn31xx;
+	struct cvmx_l2c_lckbase_s cn38xx;
+	struct cvmx_l2c_lckbase_s cn38xxp2;
+	struct cvmx_l2c_lckbase_s cn50xx;
+	struct cvmx_l2c_lckbase_s cn52xx;
+	struct cvmx_l2c_lckbase_s cn52xxp1;
+	struct cvmx_l2c_lckbase_s cn56xx;
+	struct cvmx_l2c_lckbase_s cn56xxp1;
+	struct cvmx_l2c_lckbase_s cn58xx;
+	struct cvmx_l2c_lckbase_s cn58xxp1;
+};
+typedef union cvmx_l2c_lckbase cvmx_l2c_lckbase_t;
+
+union cvmx_l2c_lckoff {
+	uint64_t u64;
+	struct cvmx_l2c_lckoff_s {
+		uint64_t reserved_10_63:54;
+		uint64_t lck_offset:10;
+	} s;
+	struct cvmx_l2c_lckoff_s cn30xx;
+	struct cvmx_l2c_lckoff_s cn31xx;
+	struct cvmx_l2c_lckoff_s cn38xx;
+	struct cvmx_l2c_lckoff_s cn38xxp2;
+	struct cvmx_l2c_lckoff_s cn50xx;
+	struct cvmx_l2c_lckoff_s cn52xx;
+	struct cvmx_l2c_lckoff_s cn52xxp1;
+	struct cvmx_l2c_lckoff_s cn56xx;
+	struct cvmx_l2c_lckoff_s cn56xxp1;
+	struct cvmx_l2c_lckoff_s cn58xx;
+	struct cvmx_l2c_lckoff_s cn58xxp1;
+};
+typedef union cvmx_l2c_lckoff cvmx_l2c_lckoff_t;
+
+union cvmx_l2c_lfb0 {
+	uint64_t u64;
+	struct cvmx_l2c_lfb0_s {
+		uint64_t reserved_32_63:32;
+		uint64_t stcpnd:1;
+		uint64_t stpnd:1;
+		uint64_t stinv:1;
+		uint64_t stcfl:1;
+		uint64_t vam:1;
+		uint64_t inxt:4;
+		uint64_t itl:1;
+		uint64_t ihd:1;
+		uint64_t set:3;
+		uint64_t vabnum:4;
+		uint64_t sid:9;
+		uint64_t cmd:4;
+		uint64_t vld:1;
+	} s;
+	struct cvmx_l2c_lfb0_cn30xx {
+		uint64_t reserved_32_63:32;
+		uint64_t stcpnd:1;
+		uint64_t stpnd:1;
+		uint64_t stinv:1;
+		uint64_t stcfl:1;
+		uint64_t vam:1;
+		uint64_t reserved_25_26:2;
+		uint64_t inxt:2;
+		uint64_t itl:1;
+		uint64_t ihd:1;
+		uint64_t reserved_20_20:1;
+		uint64_t set:2;
+		uint64_t reserved_16_17:2;
+		uint64_t vabnum:2;
+		uint64_t sid:9;
+		uint64_t cmd:4;
+		uint64_t vld:1;
+	} cn30xx;
+	struct cvmx_l2c_lfb0_cn31xx {
+		uint64_t reserved_32_63:32;
+		uint64_t stcpnd:1;
+		uint64_t stpnd:1;
+		uint64_t stinv:1;
+		uint64_t stcfl:1;
+		uint64_t vam:1;
+		uint64_t reserved_26_26:1;
+		uint64_t inxt:3;
+		uint64_t itl:1;
+		uint64_t ihd:1;
+		uint64_t reserved_20_20:1;
+		uint64_t set:2;
+		uint64_t reserved_17_17:1;
+		uint64_t vabnum:3;
+		uint64_t sid:9;
+		uint64_t cmd:4;
+		uint64_t vld:1;
+	} cn31xx;
+	struct cvmx_l2c_lfb0_s cn38xx;
+	struct cvmx_l2c_lfb0_s cn38xxp2;
+	struct cvmx_l2c_lfb0_cn50xx {
+		uint64_t reserved_32_63:32;
+		uint64_t stcpnd:1;
+		uint64_t stpnd:1;
+		uint64_t stinv:1;
+		uint64_t stcfl:1;
+		uint64_t vam:1;
+		uint64_t reserved_26_26:1;
+		uint64_t inxt:3;
+		uint64_t itl:1;
+		uint64_t ihd:1;
+		uint64_t set:3;
+		uint64_t reserved_17_17:1;
+		uint64_t vabnum:3;
+		uint64_t sid:9;
+		uint64_t cmd:4;
+		uint64_t vld:1;
+	} cn50xx;
+	struct cvmx_l2c_lfb0_cn50xx cn52xx;
+	struct cvmx_l2c_lfb0_cn50xx cn52xxp1;
+	struct cvmx_l2c_lfb0_s cn56xx;
+	struct cvmx_l2c_lfb0_s cn56xxp1;
+	struct cvmx_l2c_lfb0_s cn58xx;
+	struct cvmx_l2c_lfb0_s cn58xxp1;
+};
+typedef union cvmx_l2c_lfb0 cvmx_l2c_lfb0_t;
+
+union cvmx_l2c_lfb1 {
+	uint64_t u64;
+	struct cvmx_l2c_lfb1_s {
+		uint64_t reserved_19_63:45;
+		uint64_t dsgoing:1;
+		uint64_t bid:2;
+		uint64_t wtrsp:1;
+		uint64_t wtdw:1;
+		uint64_t wtdq:1;
+		uint64_t wtwhp:1;
+		uint64_t wtwhf:1;
+		uint64_t wtwrm:1;
+		uint64_t wtstm:1;
+		uint64_t wtrda:1;
+		uint64_t wtstdt:1;
+		uint64_t wtstrsp:1;
+		uint64_t wtstrsc:1;
+		uint64_t wtvtm:1;
+		uint64_t wtmfl:1;
+		uint64_t prbrty:1;
+		uint64_t wtprb:1;
+		uint64_t vld:1;
+	} s;
+	struct cvmx_l2c_lfb1_s cn30xx;
+	struct cvmx_l2c_lfb1_s cn31xx;
+	struct cvmx_l2c_lfb1_s cn38xx;
+	struct cvmx_l2c_lfb1_s cn38xxp2;
+	struct cvmx_l2c_lfb1_s cn50xx;
+	struct cvmx_l2c_lfb1_s cn52xx;
+	struct cvmx_l2c_lfb1_s cn52xxp1;
+	struct cvmx_l2c_lfb1_s cn56xx;
+	struct cvmx_l2c_lfb1_s cn56xxp1;
+	struct cvmx_l2c_lfb1_s cn58xx;
+	struct cvmx_l2c_lfb1_s cn58xxp1;
+};
+typedef union cvmx_l2c_lfb1 cvmx_l2c_lfb1_t;
+
+union cvmx_l2c_lfb2 {
+	uint64_t u64;
+	struct cvmx_l2c_lfb2_s {
+		uint64_t reserved_0_63:64;
+	} s;
+	struct cvmx_l2c_lfb2_cn30xx {
+		uint64_t reserved_27_63:37;
+		uint64_t lfb_tag:19;
+		uint64_t lfb_idx:8;
+	} cn30xx;
+	struct cvmx_l2c_lfb2_cn31xx {
+		uint64_t reserved_27_63:37;
+		uint64_t lfb_tag:17;
+		uint64_t lfb_idx:10;
+	} cn31xx;
+	struct cvmx_l2c_lfb2_cn31xx cn38xx;
+	struct cvmx_l2c_lfb2_cn31xx cn38xxp2;
+	struct cvmx_l2c_lfb2_cn50xx {
+		uint64_t reserved_27_63:37;
+		uint64_t lfb_tag:20;
+		uint64_t lfb_idx:7;
+	} cn50xx;
+	struct cvmx_l2c_lfb2_cn52xx {
+		uint64_t reserved_27_63:37;
+		uint64_t lfb_tag:18;
+		uint64_t lfb_idx:9;
+	} cn52xx;
+	struct cvmx_l2c_lfb2_cn52xx cn52xxp1;
+	struct cvmx_l2c_lfb2_cn56xx {
+		uint64_t reserved_27_63:37;
+		uint64_t lfb_tag:16;
+		uint64_t lfb_idx:11;
+	} cn56xx;
+	struct cvmx_l2c_lfb2_cn56xx cn56xxp1;
+	struct cvmx_l2c_lfb2_cn56xx cn58xx;
+	struct cvmx_l2c_lfb2_cn56xx cn58xxp1;
+};
+typedef union cvmx_l2c_lfb2 cvmx_l2c_lfb2_t;
+
+union cvmx_l2c_lfb3 {
+	uint64_t u64;
+	struct cvmx_l2c_lfb3_s {
+		uint64_t reserved_5_63:59;
+		uint64_t stpartdis:1;
+		uint64_t lfb_hwm:4;
+	} s;
+	struct cvmx_l2c_lfb3_cn30xx {
+		uint64_t reserved_5_63:59;
+		uint64_t stpartdis:1;
+		uint64_t reserved_2_3:2;
+		uint64_t lfb_hwm:2;
+	} cn30xx;
+	struct cvmx_l2c_lfb3_cn31xx {
+		uint64_t reserved_5_63:59;
+		uint64_t stpartdis:1;
+		uint64_t reserved_3_3:1;
+		uint64_t lfb_hwm:3;
+	} cn31xx;
+	struct cvmx_l2c_lfb3_s cn38xx;
+	struct cvmx_l2c_lfb3_s cn38xxp2;
+	struct cvmx_l2c_lfb3_cn31xx cn50xx;
+	struct cvmx_l2c_lfb3_cn31xx cn52xx;
+	struct cvmx_l2c_lfb3_cn31xx cn52xxp1;
+	struct cvmx_l2c_lfb3_s cn56xx;
+	struct cvmx_l2c_lfb3_s cn56xxp1;
+	struct cvmx_l2c_lfb3_s cn58xx;
+	struct cvmx_l2c_lfb3_s cn58xxp1;
+};
+typedef union cvmx_l2c_lfb3 cvmx_l2c_lfb3_t;
+
+union cvmx_l2c_oob {
+	uint64_t u64;
+	struct cvmx_l2c_oob_s {
+		uint64_t reserved_2_63:62;
+		uint64_t dwbena:1;
+		uint64_t stena:1;
+	} s;
+	struct cvmx_l2c_oob_s cn52xx;
+	struct cvmx_l2c_oob_s cn52xxp1;
+	struct cvmx_l2c_oob_s cn56xx;
+	struct cvmx_l2c_oob_s cn56xxp1;
+};
+typedef union cvmx_l2c_oob cvmx_l2c_oob_t;
+
+union cvmx_l2c_oob1 {
+	uint64_t u64;
+	struct cvmx_l2c_oob1_s {
+		uint64_t fadr:27;
+		uint64_t fsrc:1;
+		uint64_t reserved_34_35:2;
+		uint64_t sadr:14;
+		uint64_t reserved_14_19:6;
+		uint64_t size:14;
+	} s;
+	struct cvmx_l2c_oob1_s cn52xx;
+	struct cvmx_l2c_oob1_s cn52xxp1;
+	struct cvmx_l2c_oob1_s cn56xx;
+	struct cvmx_l2c_oob1_s cn56xxp1;
+};
+typedef union cvmx_l2c_oob1 cvmx_l2c_oob1_t;
+
+union cvmx_l2c_oob2 {
+	uint64_t u64;
+	struct cvmx_l2c_oob2_s {
+		uint64_t fadr:27;
+		uint64_t fsrc:1;
+		uint64_t reserved_34_35:2;
+		uint64_t sadr:14;
+		uint64_t reserved_14_19:6;
+		uint64_t size:14;
+	} s;
+	struct cvmx_l2c_oob2_s cn52xx;
+	struct cvmx_l2c_oob2_s cn52xxp1;
+	struct cvmx_l2c_oob2_s cn56xx;
+	struct cvmx_l2c_oob2_s cn56xxp1;
+};
+typedef union cvmx_l2c_oob2 cvmx_l2c_oob2_t;
+
+union cvmx_l2c_oob3 {
+	uint64_t u64;
+	struct cvmx_l2c_oob3_s {
+		uint64_t fadr:27;
+		uint64_t fsrc:1;
+		uint64_t reserved_34_35:2;
+		uint64_t sadr:14;
+		uint64_t reserved_14_19:6;
+		uint64_t size:14;
+	} s;
+	struct cvmx_l2c_oob3_s cn52xx;
+	struct cvmx_l2c_oob3_s cn52xxp1;
+	struct cvmx_l2c_oob3_s cn56xx;
+	struct cvmx_l2c_oob3_s cn56xxp1;
+};
+typedef union cvmx_l2c_oob3 cvmx_l2c_oob3_t;
+
+union cvmx_l2c_pfcx {
+	uint64_t u64;
+	struct cvmx_l2c_pfcx_s {
+		uint64_t reserved_36_63:28;
+		uint64_t pfcnt0:36;
+	} s;
+	struct cvmx_l2c_pfcx_s cn30xx;
+	struct cvmx_l2c_pfcx_s cn31xx;
+	struct cvmx_l2c_pfcx_s cn38xx;
+	struct cvmx_l2c_pfcx_s cn38xxp2;
+	struct cvmx_l2c_pfcx_s cn50xx;
+	struct cvmx_l2c_pfcx_s cn52xx;
+	struct cvmx_l2c_pfcx_s cn52xxp1;
+	struct cvmx_l2c_pfcx_s cn56xx;
+	struct cvmx_l2c_pfcx_s cn56xxp1;
+	struct cvmx_l2c_pfcx_s cn58xx;
+	struct cvmx_l2c_pfcx_s cn58xxp1;
+};
+typedef union cvmx_l2c_pfcx cvmx_l2c_pfcx_t;
+
+union cvmx_l2c_pfctl {
+	uint64_t u64;
+	struct cvmx_l2c_pfctl_s {
+		uint64_t reserved_36_63:28;
+		uint64_t cnt3rdclr:1;
+		uint64_t cnt2rdclr:1;
+		uint64_t cnt1rdclr:1;
+		uint64_t cnt0rdclr:1;
+		uint64_t cnt3ena:1;
+		uint64_t cnt3clr:1;
+		uint64_t cnt3sel:6;
+		uint64_t cnt2ena:1;
+		uint64_t cnt2clr:1;
+		uint64_t cnt2sel:6;
+		uint64_t cnt1ena:1;
+		uint64_t cnt1clr:1;
+		uint64_t cnt1sel:6;
+		uint64_t cnt0ena:1;
+		uint64_t cnt0clr:1;
+		uint64_t cnt0sel:6;
+	} s;
+	struct cvmx_l2c_pfctl_s cn30xx;
+	struct cvmx_l2c_pfctl_s cn31xx;
+	struct cvmx_l2c_pfctl_s cn38xx;
+	struct cvmx_l2c_pfctl_s cn38xxp2;
+	struct cvmx_l2c_pfctl_s cn50xx;
+	struct cvmx_l2c_pfctl_s cn52xx;
+	struct cvmx_l2c_pfctl_s cn52xxp1;
+	struct cvmx_l2c_pfctl_s cn56xx;
+	struct cvmx_l2c_pfctl_s cn56xxp1;
+	struct cvmx_l2c_pfctl_s cn58xx;
+	struct cvmx_l2c_pfctl_s cn58xxp1;
+};
+typedef union cvmx_l2c_pfctl cvmx_l2c_pfctl_t;
+
+union cvmx_l2c_ppgrp {
+	uint64_t u64;
+	struct cvmx_l2c_ppgrp_s {
+		uint64_t reserved_24_63:40;
+		uint64_t pp11grp:2;
+		uint64_t pp10grp:2;
+		uint64_t pp9grp:2;
+		uint64_t pp8grp:2;
+		uint64_t pp7grp:2;
+		uint64_t pp6grp:2;
+		uint64_t pp5grp:2;
+		uint64_t pp4grp:2;
+		uint64_t pp3grp:2;
+		uint64_t pp2grp:2;
+		uint64_t pp1grp:2;
+		uint64_t pp0grp:2;
+	} s;
+	struct cvmx_l2c_ppgrp_cn52xx {
+		uint64_t reserved_8_63:56;
+		uint64_t pp3grp:2;
+		uint64_t pp2grp:2;
+		uint64_t pp1grp:2;
+		uint64_t pp0grp:2;
+	} cn52xx;
+	struct cvmx_l2c_ppgrp_cn52xx cn52xxp1;
+	struct cvmx_l2c_ppgrp_s cn56xx;
+	struct cvmx_l2c_ppgrp_s cn56xxp1;
+};
+typedef union cvmx_l2c_ppgrp cvmx_l2c_ppgrp_t;
+
+union cvmx_l2c_spar0 {
+	uint64_t u64;
+	struct cvmx_l2c_spar0_s {
+		uint64_t reserved_32_63:32;
+		uint64_t umsk3:8;
+		uint64_t umsk2:8;
+		uint64_t umsk1:8;
+		uint64_t umsk0:8;
+	} s;
+	struct cvmx_l2c_spar0_cn30xx {
+		uint64_t reserved_4_63:60;
+		uint64_t umsk0:4;
+	} cn30xx;
+	struct cvmx_l2c_spar0_cn31xx {
+		uint64_t reserved_12_63:52;
+		uint64_t umsk1:4;
+		uint64_t reserved_4_7:4;
+		uint64_t umsk0:4;
+	} cn31xx;
+	struct cvmx_l2c_spar0_s cn38xx;
+	struct cvmx_l2c_spar0_s cn38xxp2;
+	struct cvmx_l2c_spar0_cn50xx {
+		uint64_t reserved_16_63:48;
+		uint64_t umsk1:8;
+		uint64_t umsk0:8;
+	} cn50xx;
+	struct cvmx_l2c_spar0_s cn52xx;
+	struct cvmx_l2c_spar0_s cn52xxp1;
+	struct cvmx_l2c_spar0_s cn56xx;
+	struct cvmx_l2c_spar0_s cn56xxp1;
+	struct cvmx_l2c_spar0_s cn58xx;
+	struct cvmx_l2c_spar0_s cn58xxp1;
+};
+typedef union cvmx_l2c_spar0 cvmx_l2c_spar0_t;
+
+union cvmx_l2c_spar1 {
+	uint64_t u64;
+	struct cvmx_l2c_spar1_s {
+		uint64_t reserved_32_63:32;
+		uint64_t umsk7:8;
+		uint64_t umsk6:8;
+		uint64_t umsk5:8;
+		uint64_t umsk4:8;
+	} s;
+	struct cvmx_l2c_spar1_s cn38xx;
+	struct cvmx_l2c_spar1_s cn38xxp2;
+	struct cvmx_l2c_spar1_s cn56xx;
+	struct cvmx_l2c_spar1_s cn56xxp1;
+	struct cvmx_l2c_spar1_s cn58xx;
+	struct cvmx_l2c_spar1_s cn58xxp1;
+};
+typedef union cvmx_l2c_spar1 cvmx_l2c_spar1_t;
+
+union cvmx_l2c_spar2 {
+	uint64_t u64;
+	struct cvmx_l2c_spar2_s {
+		uint64_t reserved_32_63:32;
+		uint64_t umsk11:8;
+		uint64_t umsk10:8;
+		uint64_t umsk9:8;
+		uint64_t umsk8:8;
+	} s;
+	struct cvmx_l2c_spar2_s cn38xx;
+	struct cvmx_l2c_spar2_s cn38xxp2;
+	struct cvmx_l2c_spar2_s cn56xx;
+	struct cvmx_l2c_spar2_s cn56xxp1;
+	struct cvmx_l2c_spar2_s cn58xx;
+	struct cvmx_l2c_spar2_s cn58xxp1;
+};
+typedef union cvmx_l2c_spar2 cvmx_l2c_spar2_t;
+
+union cvmx_l2c_spar3 {
+	uint64_t u64;
+	struct cvmx_l2c_spar3_s {
+		uint64_t reserved_32_63:32;
+		uint64_t umsk15:8;
+		uint64_t umsk14:8;
+		uint64_t umsk13:8;
+		uint64_t umsk12:8;
+	} s;
+	struct cvmx_l2c_spar3_s cn38xx;
+	struct cvmx_l2c_spar3_s cn38xxp2;
+	struct cvmx_l2c_spar3_s cn58xx;
+	struct cvmx_l2c_spar3_s cn58xxp1;
+};
+typedef union cvmx_l2c_spar3 cvmx_l2c_spar3_t;
+
+union cvmx_l2c_spar4 {
+	uint64_t u64;
+	struct cvmx_l2c_spar4_s {
+		uint64_t reserved_8_63:56;
+		uint64_t umskiob:8;
+	} s;
+	struct cvmx_l2c_spar4_cn30xx {
+		uint64_t reserved_4_63:60;
+		uint64_t umskiob:4;
+	} cn30xx;
+	struct cvmx_l2c_spar4_cn30xx cn31xx;
+	struct cvmx_l2c_spar4_s cn38xx;
+	struct cvmx_l2c_spar4_s cn38xxp2;
+	struct cvmx_l2c_spar4_s cn50xx;
+	struct cvmx_l2c_spar4_s cn52xx;
+	struct cvmx_l2c_spar4_s cn52xxp1;
+	struct cvmx_l2c_spar4_s cn56xx;
+	struct cvmx_l2c_spar4_s cn56xxp1;
+	struct cvmx_l2c_spar4_s cn58xx;
+	struct cvmx_l2c_spar4_s cn58xxp1;
+};
+typedef union cvmx_l2c_spar4 cvmx_l2c_spar4_t;
+
+#endif
diff --git a/arch/mips/include/asm/octeon/cvmx-l2d-defs.h b/arch/mips/include/asm/octeon/cvmx-l2d-defs.h
new file mode 100644
index 0000000..9922092
--- /dev/null
+++ b/arch/mips/include/asm/octeon/cvmx-l2d-defs.h
@@ -0,0 +1,368 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as published by
+ * the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful,
+ * but AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or NONINFRINGEMENT.
+ * See the GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+ ***********************license end**************************************/
+
+#ifndef __CVMX_L2D_DEFS_H__
+#define __CVMX_L2D_DEFS_H__
+
+#define CVMX_L2D_BST0                                        CVMX_ADD_IO_SEG(0x0001180080000780ull)
+#define CVMX_L2D_BST1                                        CVMX_ADD_IO_SEG(0x0001180080000788ull)
+#define CVMX_L2D_BST2                                        CVMX_ADD_IO_SEG(0x0001180080000790ull)
+#define CVMX_L2D_BST3                                        CVMX_ADD_IO_SEG(0x0001180080000798ull)
+#define CVMX_L2D_ERR                                         CVMX_ADD_IO_SEG(0x0001180080000010ull)
+#define CVMX_L2D_FADR                                        CVMX_ADD_IO_SEG(0x0001180080000018ull)
+#define CVMX_L2D_FSYN0                                       CVMX_ADD_IO_SEG(0x0001180080000020ull)
+#define CVMX_L2D_FSYN1                                       CVMX_ADD_IO_SEG(0x0001180080000028ull)
+#define CVMX_L2D_FUS0                                        CVMX_ADD_IO_SEG(0x00011800800007A0ull)
+#define CVMX_L2D_FUS1                                        CVMX_ADD_IO_SEG(0x00011800800007A8ull)
+#define CVMX_L2D_FUS2                                        CVMX_ADD_IO_SEG(0x00011800800007B0ull)
+#define CVMX_L2D_FUS3                                        CVMX_ADD_IO_SEG(0x00011800800007B8ull)
+
+union cvmx_l2d_bst0 {
+	uint64_t u64;
+	struct cvmx_l2d_bst0_s {
+		uint64_t reserved_35_63:29;
+		uint64_t ftl:1;
+		uint64_t q0stat:34;
+	} s;
+	struct cvmx_l2d_bst0_s cn30xx;
+	struct cvmx_l2d_bst0_s cn31xx;
+	struct cvmx_l2d_bst0_s cn38xx;
+	struct cvmx_l2d_bst0_s cn38xxp2;
+	struct cvmx_l2d_bst0_s cn50xx;
+	struct cvmx_l2d_bst0_s cn52xx;
+	struct cvmx_l2d_bst0_s cn52xxp1;
+	struct cvmx_l2d_bst0_s cn56xx;
+	struct cvmx_l2d_bst0_s cn56xxp1;
+	struct cvmx_l2d_bst0_s cn58xx;
+	struct cvmx_l2d_bst0_s cn58xxp1;
+};
+typedef union cvmx_l2d_bst0 cvmx_l2d_bst0_t;
+
+union cvmx_l2d_bst1 {
+	uint64_t u64;
+	struct cvmx_l2d_bst1_s {
+		uint64_t reserved_34_63:30;
+		uint64_t q1stat:34;
+	} s;
+	struct cvmx_l2d_bst1_s cn30xx;
+	struct cvmx_l2d_bst1_s cn31xx;
+	struct cvmx_l2d_bst1_s cn38xx;
+	struct cvmx_l2d_bst1_s cn38xxp2;
+	struct cvmx_l2d_bst1_s cn50xx;
+	struct cvmx_l2d_bst1_s cn52xx;
+	struct cvmx_l2d_bst1_s cn52xxp1;
+	struct cvmx_l2d_bst1_s cn56xx;
+	struct cvmx_l2d_bst1_s cn56xxp1;
+	struct cvmx_l2d_bst1_s cn58xx;
+	struct cvmx_l2d_bst1_s cn58xxp1;
+};
+typedef union cvmx_l2d_bst1 cvmx_l2d_bst1_t;
+
+union cvmx_l2d_bst2 {
+	uint64_t u64;
+	struct cvmx_l2d_bst2_s {
+		uint64_t reserved_34_63:30;
+		uint64_t q2stat:34;
+	} s;
+	struct cvmx_l2d_bst2_s cn30xx;
+	struct cvmx_l2d_bst2_s cn31xx;
+	struct cvmx_l2d_bst2_s cn38xx;
+	struct cvmx_l2d_bst2_s cn38xxp2;
+	struct cvmx_l2d_bst2_s cn50xx;
+	struct cvmx_l2d_bst2_s cn52xx;
+	struct cvmx_l2d_bst2_s cn52xxp1;
+	struct cvmx_l2d_bst2_s cn56xx;
+	struct cvmx_l2d_bst2_s cn56xxp1;
+	struct cvmx_l2d_bst2_s cn58xx;
+	struct cvmx_l2d_bst2_s cn58xxp1;
+};
+typedef union cvmx_l2d_bst2 cvmx_l2d_bst2_t;
+
+union cvmx_l2d_bst3 {
+	uint64_t u64;
+	struct cvmx_l2d_bst3_s {
+		uint64_t reserved_34_63:30;
+		uint64_t q3stat:34;
+	} s;
+	struct cvmx_l2d_bst3_s cn30xx;
+	struct cvmx_l2d_bst3_s cn31xx;
+	struct cvmx_l2d_bst3_s cn38xx;
+	struct cvmx_l2d_bst3_s cn38xxp2;
+	struct cvmx_l2d_bst3_s cn50xx;
+	struct cvmx_l2d_bst3_s cn52xx;
+	struct cvmx_l2d_bst3_s cn52xxp1;
+	struct cvmx_l2d_bst3_s cn56xx;
+	struct cvmx_l2d_bst3_s cn56xxp1;
+	struct cvmx_l2d_bst3_s cn58xx;
+	struct cvmx_l2d_bst3_s cn58xxp1;
+};
+typedef union cvmx_l2d_bst3 cvmx_l2d_bst3_t;
+
+union cvmx_l2d_err {
+	uint64_t u64;
+	struct cvmx_l2d_err_s {
+		uint64_t reserved_6_63:58;
+		uint64_t bmhclsel:1;
+		uint64_t ded_err:1;
+		uint64_t sec_err:1;
+		uint64_t ded_intena:1;
+		uint64_t sec_intena:1;
+		uint64_t ecc_ena:1;
+	} s;
+	struct cvmx_l2d_err_s cn30xx;
+	struct cvmx_l2d_err_s cn31xx;
+	struct cvmx_l2d_err_s cn38xx;
+	struct cvmx_l2d_err_s cn38xxp2;
+	struct cvmx_l2d_err_s cn50xx;
+	struct cvmx_l2d_err_s cn52xx;
+	struct cvmx_l2d_err_s cn52xxp1;
+	struct cvmx_l2d_err_s cn56xx;
+	struct cvmx_l2d_err_s cn56xxp1;
+	struct cvmx_l2d_err_s cn58xx;
+	struct cvmx_l2d_err_s cn58xxp1;
+};
+typedef union cvmx_l2d_err cvmx_l2d_err_t;
+
+union cvmx_l2d_fadr {
+	uint64_t u64;
+	struct cvmx_l2d_fadr_s {
+		uint64_t reserved_19_63:45;
+		uint64_t fadru:1;
+		uint64_t fowmsk:4;
+		uint64_t fset:3;
+		uint64_t fadr:11;
+	} s;
+	struct cvmx_l2d_fadr_cn30xx {
+		uint64_t reserved_18_63:46;
+		uint64_t fowmsk:4;
+		uint64_t reserved_13_13:1;
+		uint64_t fset:2;
+		uint64_t reserved_9_10:2;
+		uint64_t fadr:9;
+	} cn30xx;
+	struct cvmx_l2d_fadr_cn31xx {
+		uint64_t reserved_18_63:46;
+		uint64_t fowmsk:4;
+		uint64_t reserved_13_13:1;
+		uint64_t fset:2;
+		uint64_t reserved_10_10:1;
+		uint64_t fadr:10;
+	} cn31xx;
+	struct cvmx_l2d_fadr_cn38xx {
+		uint64_t reserved_18_63:46;
+		uint64_t fowmsk:4;
+		uint64_t fset:3;
+		uint64_t fadr:11;
+	} cn38xx;
+	struct cvmx_l2d_fadr_cn38xx cn38xxp2;
+	struct cvmx_l2d_fadr_cn50xx {
+		uint64_t reserved_18_63:46;
+		uint64_t fowmsk:4;
+		uint64_t fset:3;
+		uint64_t reserved_8_10:3;
+		uint64_t fadr:8;
+	} cn50xx;
+	struct cvmx_l2d_fadr_cn52xx {
+		uint64_t reserved_18_63:46;
+		uint64_t fowmsk:4;
+		uint64_t fset:3;
+		uint64_t reserved_10_10:1;
+		uint64_t fadr:10;
+	} cn52xx;
+	struct cvmx_l2d_fadr_cn52xx cn52xxp1;
+	struct cvmx_l2d_fadr_s cn56xx;
+	struct cvmx_l2d_fadr_s cn56xxp1;
+	struct cvmx_l2d_fadr_s cn58xx;
+	struct cvmx_l2d_fadr_s cn58xxp1;
+};
+typedef union cvmx_l2d_fadr cvmx_l2d_fadr_t;
+
+union cvmx_l2d_fsyn0 {
+	uint64_t u64;
+	struct cvmx_l2d_fsyn0_s {
+		uint64_t reserved_20_63:44;
+		uint64_t fsyn_ow1:10;
+		uint64_t fsyn_ow0:10;
+	} s;
+	struct cvmx_l2d_fsyn0_s cn30xx;
+	struct cvmx_l2d_fsyn0_s cn31xx;
+	struct cvmx_l2d_fsyn0_s cn38xx;
+	struct cvmx_l2d_fsyn0_s cn38xxp2;
+	struct cvmx_l2d_fsyn0_s cn50xx;
+	struct cvmx_l2d_fsyn0_s cn52xx;
+	struct cvmx_l2d_fsyn0_s cn52xxp1;
+	struct cvmx_l2d_fsyn0_s cn56xx;
+	struct cvmx_l2d_fsyn0_s cn56xxp1;
+	struct cvmx_l2d_fsyn0_s cn58xx;
+	struct cvmx_l2d_fsyn0_s cn58xxp1;
+};
+typedef union cvmx_l2d_fsyn0 cvmx_l2d_fsyn0_t;
+
+union cvmx_l2d_fsyn1 {
+	uint64_t u64;
+	struct cvmx_l2d_fsyn1_s {
+		uint64_t reserved_20_63:44;
+		uint64_t fsyn_ow3:10;
+		uint64_t fsyn_ow2:10;
+	} s;
+	struct cvmx_l2d_fsyn1_s cn30xx;
+	struct cvmx_l2d_fsyn1_s cn31xx;
+	struct cvmx_l2d_fsyn1_s cn38xx;
+	struct cvmx_l2d_fsyn1_s cn38xxp2;
+	struct cvmx_l2d_fsyn1_s cn50xx;
+	struct cvmx_l2d_fsyn1_s cn52xx;
+	struct cvmx_l2d_fsyn1_s cn52xxp1;
+	struct cvmx_l2d_fsyn1_s cn56xx;
+	struct cvmx_l2d_fsyn1_s cn56xxp1;
+	struct cvmx_l2d_fsyn1_s cn58xx;
+	struct cvmx_l2d_fsyn1_s cn58xxp1;
+};
+typedef union cvmx_l2d_fsyn1 cvmx_l2d_fsyn1_t;
+
+union cvmx_l2d_fus0 {
+	uint64_t u64;
+	struct cvmx_l2d_fus0_s {
+		uint64_t reserved_34_63:30;
+		uint64_t q0fus:34;
+	} s;
+	struct cvmx_l2d_fus0_s cn30xx;
+	struct cvmx_l2d_fus0_s cn31xx;
+	struct cvmx_l2d_fus0_s cn38xx;
+	struct cvmx_l2d_fus0_s cn38xxp2;
+	struct cvmx_l2d_fus0_s cn50xx;
+	struct cvmx_l2d_fus0_s cn52xx;
+	struct cvmx_l2d_fus0_s cn52xxp1;
+	struct cvmx_l2d_fus0_s cn56xx;
+	struct cvmx_l2d_fus0_s cn56xxp1;
+	struct cvmx_l2d_fus0_s cn58xx;
+	struct cvmx_l2d_fus0_s cn58xxp1;
+};
+typedef union cvmx_l2d_fus0 cvmx_l2d_fus0_t;
+
+union cvmx_l2d_fus1 {
+	uint64_t u64;
+	struct cvmx_l2d_fus1_s {
+		uint64_t reserved_34_63:30;
+		uint64_t q1fus:34;
+	} s;
+	struct cvmx_l2d_fus1_s cn30xx;
+	struct cvmx_l2d_fus1_s cn31xx;
+	struct cvmx_l2d_fus1_s cn38xx;
+	struct cvmx_l2d_fus1_s cn38xxp2;
+	struct cvmx_l2d_fus1_s cn50xx;
+	struct cvmx_l2d_fus1_s cn52xx;
+	struct cvmx_l2d_fus1_s cn52xxp1;
+	struct cvmx_l2d_fus1_s cn56xx;
+	struct cvmx_l2d_fus1_s cn56xxp1;
+	struct cvmx_l2d_fus1_s cn58xx;
+	struct cvmx_l2d_fus1_s cn58xxp1;
+};
+typedef union cvmx_l2d_fus1 cvmx_l2d_fus1_t;
+
+union cvmx_l2d_fus2 {
+	uint64_t u64;
+	struct cvmx_l2d_fus2_s {
+		uint64_t reserved_34_63:30;
+		uint64_t q2fus:34;
+	} s;
+	struct cvmx_l2d_fus2_s cn30xx;
+	struct cvmx_l2d_fus2_s cn31xx;
+	struct cvmx_l2d_fus2_s cn38xx;
+	struct cvmx_l2d_fus2_s cn38xxp2;
+	struct cvmx_l2d_fus2_s cn50xx;
+	struct cvmx_l2d_fus2_s cn52xx;
+	struct cvmx_l2d_fus2_s cn52xxp1;
+	struct cvmx_l2d_fus2_s cn56xx;
+	struct cvmx_l2d_fus2_s cn56xxp1;
+	struct cvmx_l2d_fus2_s cn58xx;
+	struct cvmx_l2d_fus2_s cn58xxp1;
+};
+typedef union cvmx_l2d_fus2 cvmx_l2d_fus2_t;
+
+union cvmx_l2d_fus3 {
+	uint64_t u64;
+	struct cvmx_l2d_fus3_s {
+		uint64_t reserved_40_63:24;
+		uint64_t ema_ctl:3;
+		uint64_t reserved_34_36:3;
+		uint64_t q3fus:34;
+	} s;
+	struct cvmx_l2d_fus3_cn30xx {
+		uint64_t reserved_35_63:29;
+		uint64_t crip_64k:1;
+		uint64_t q3fus:34;
+	} cn30xx;
+	struct cvmx_l2d_fus3_cn31xx {
+		uint64_t reserved_35_63:29;
+		uint64_t crip_128k:1;
+		uint64_t q3fus:34;
+	} cn31xx;
+	struct cvmx_l2d_fus3_cn38xx {
+		uint64_t reserved_36_63:28;
+		uint64_t crip_256k:1;
+		uint64_t crip_512k:1;
+		uint64_t q3fus:34;
+	} cn38xx;
+	struct cvmx_l2d_fus3_cn38xx cn38xxp2;
+	struct cvmx_l2d_fus3_cn50xx {
+		uint64_t reserved_40_63:24;
+		uint64_t ema_ctl:3;
+		uint64_t reserved_36_36:1;
+		uint64_t crip_32k:1;
+		uint64_t crip_64k:1;
+		uint64_t q3fus:34;
+	} cn50xx;
+	struct cvmx_l2d_fus3_cn52xx {
+		uint64_t reserved_40_63:24;
+		uint64_t ema_ctl:3;
+		uint64_t reserved_36_36:1;
+		uint64_t crip_128k:1;
+		uint64_t crip_256k:1;
+		uint64_t q3fus:34;
+	} cn52xx;
+	struct cvmx_l2d_fus3_cn52xx cn52xxp1;
+	struct cvmx_l2d_fus3_cn56xx {
+		uint64_t reserved_40_63:24;
+		uint64_t ema_ctl:3;
+		uint64_t reserved_36_36:1;
+		uint64_t crip_512k:1;
+		uint64_t crip_1024k:1;
+		uint64_t q3fus:34;
+	} cn56xx;
+	struct cvmx_l2d_fus3_cn56xx cn56xxp1;
+	struct cvmx_l2d_fus3_cn58xx {
+		uint64_t reserved_39_63:25;
+		uint64_t ema_ctl:2;
+		uint64_t reserved_36_36:1;
+		uint64_t crip_512k:1;
+		uint64_t crip_1024k:1;
+		uint64_t q3fus:34;
+	} cn58xx;
+	struct cvmx_l2d_fus3_cn58xx cn58xxp1;
+};
+typedef union cvmx_l2d_fus3 cvmx_l2d_fus3_t;
+
+#endif
diff --git a/arch/mips/include/asm/octeon/cvmx-l2t-defs.h b/arch/mips/include/asm/octeon/cvmx-l2t-defs.h
new file mode 100644
index 0000000..94ebc49
--- /dev/null
+++ b/arch/mips/include/asm/octeon/cvmx-l2t-defs.h
@@ -0,0 +1,140 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as published by
+ * the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful,
+ * but AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or NONINFRINGEMENT.
+ * See the GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+ ***********************license end**************************************/
+
+#ifndef __CVMX_L2T_DEFS_H__
+#define __CVMX_L2T_DEFS_H__
+
+#define CVMX_L2T_ERR                                         CVMX_ADD_IO_SEG(0x0001180080000008ull)
+
+union cvmx_l2t_err {
+	uint64_t u64;
+	struct cvmx_l2t_err_s {
+		uint64_t reserved_29_63:35;
+		uint64_t fadru:1;
+		uint64_t lck_intena2:1;
+		uint64_t lckerr2:1;
+		uint64_t lck_intena:1;
+		uint64_t lckerr:1;
+		uint64_t fset:3;
+		uint64_t fadr:10;
+		uint64_t fsyn:6;
+		uint64_t ded_err:1;
+		uint64_t sec_err:1;
+		uint64_t ded_intena:1;
+		uint64_t sec_intena:1;
+		uint64_t ecc_ena:1;
+	} s;
+	struct cvmx_l2t_err_cn30xx {
+		uint64_t reserved_28_63:36;
+		uint64_t lck_intena2:1;
+		uint64_t lckerr2:1;
+		uint64_t lck_intena:1;
+		uint64_t lckerr:1;
+		uint64_t reserved_23_23:1;
+		uint64_t fset:2;
+		uint64_t reserved_19_20:2;
+		uint64_t fadr:8;
+		uint64_t fsyn:6;
+		uint64_t ded_err:1;
+		uint64_t sec_err:1;
+		uint64_t ded_intena:1;
+		uint64_t sec_intena:1;
+		uint64_t ecc_ena:1;
+	} cn30xx;
+	struct cvmx_l2t_err_cn31xx {
+		uint64_t reserved_28_63:36;
+		uint64_t lck_intena2:1;
+		uint64_t lckerr2:1;
+		uint64_t lck_intena:1;
+		uint64_t lckerr:1;
+		uint64_t reserved_23_23:1;
+		uint64_t fset:2;
+		uint64_t reserved_20_20:1;
+		uint64_t fadr:9;
+		uint64_t fsyn:6;
+		uint64_t ded_err:1;
+		uint64_t sec_err:1;
+		uint64_t ded_intena:1;
+		uint64_t sec_intena:1;
+		uint64_t ecc_ena:1;
+	} cn31xx;
+	struct cvmx_l2t_err_cn38xx {
+		uint64_t reserved_28_63:36;
+		uint64_t lck_intena2:1;
+		uint64_t lckerr2:1;
+		uint64_t lck_intena:1;
+		uint64_t lckerr:1;
+		uint64_t fset:3;
+		uint64_t fadr:10;
+		uint64_t fsyn:6;
+		uint64_t ded_err:1;
+		uint64_t sec_err:1;
+		uint64_t ded_intena:1;
+		uint64_t sec_intena:1;
+		uint64_t ecc_ena:1;
+	} cn38xx;
+	struct cvmx_l2t_err_cn38xx cn38xxp2;
+	struct cvmx_l2t_err_cn50xx {
+		uint64_t reserved_28_63:36;
+		uint64_t lck_intena2:1;
+		uint64_t lckerr2:1;
+		uint64_t lck_intena:1;
+		uint64_t lckerr:1;
+		uint64_t fset:3;
+		uint64_t reserved_18_20:3;
+		uint64_t fadr:7;
+		uint64_t fsyn:6;
+		uint64_t ded_err:1;
+		uint64_t sec_err:1;
+		uint64_t ded_intena:1;
+		uint64_t sec_intena:1;
+		uint64_t ecc_ena:1;
+	} cn50xx;
+	struct cvmx_l2t_err_cn52xx {
+		uint64_t reserved_28_63:36;
+		uint64_t lck_intena2:1;
+		uint64_t lckerr2:1;
+		uint64_t lck_intena:1;
+		uint64_t lckerr:1;
+		uint64_t fset:3;
+		uint64_t reserved_20_20:1;
+		uint64_t fadr:9;
+		uint64_t fsyn:6;
+		uint64_t ded_err:1;
+		uint64_t sec_err:1;
+		uint64_t ded_intena:1;
+		uint64_t sec_intena:1;
+		uint64_t ecc_ena:1;
+	} cn52xx;
+	struct cvmx_l2t_err_cn52xx cn52xxp1;
+	struct cvmx_l2t_err_s cn56xx;
+	struct cvmx_l2t_err_s cn56xxp1;
+	struct cvmx_l2t_err_s cn58xx;
+	struct cvmx_l2t_err_s cn58xxp1;
+};
+typedef union cvmx_l2t_err cvmx_l2t_err_t;
+
+#endif
diff --git a/arch/mips/include/asm/octeon/cvmx-led-defs.h b/arch/mips/include/asm/octeon/cvmx-led-defs.h
new file mode 100644
index 0000000..e59f625
--- /dev/null
+++ b/arch/mips/include/asm/octeon/cvmx-led-defs.h
@@ -0,0 +1,239 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as published by
+ * the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful,
+ * but AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or NONINFRINGEMENT.
+ * See the GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+ ***********************license end**************************************/
+
+#ifndef __CVMX_LED_DEFS_H__
+#define __CVMX_LED_DEFS_H__
+
+#define CVMX_LED_BLINK                                       CVMX_ADD_IO_SEG(0x0001180000001A48ull)
+#define CVMX_LED_CLK_PHASE                                   CVMX_ADD_IO_SEG(0x0001180000001A08ull)
+#define CVMX_LED_CYLON                                       CVMX_ADD_IO_SEG(0x0001180000001AF8ull)
+#define CVMX_LED_DBG                                         CVMX_ADD_IO_SEG(0x0001180000001A18ull)
+#define CVMX_LED_EN                                          CVMX_ADD_IO_SEG(0x0001180000001A00ull)
+#define CVMX_LED_POLARITY                                    CVMX_ADD_IO_SEG(0x0001180000001A50ull)
+#define CVMX_LED_PRT                                         CVMX_ADD_IO_SEG(0x0001180000001A10ull)
+#define CVMX_LED_PRT_FMT                                     CVMX_ADD_IO_SEG(0x0001180000001A30ull)
+#define CVMX_LED_PRT_STATUSX(offset)                         CVMX_ADD_IO_SEG(0x0001180000001A80ull + (((offset) & 7) * 8))
+#define CVMX_LED_UDD_CNTX(offset)                            CVMX_ADD_IO_SEG(0x0001180000001A20ull + (((offset) & 1) * 8))
+#define CVMX_LED_UDD_DATX(offset)                            CVMX_ADD_IO_SEG(0x0001180000001A38ull + (((offset) & 1) * 8))
+#define CVMX_LED_UDD_DAT_CLRX(offset)                        CVMX_ADD_IO_SEG(0x0001180000001AC8ull + (((offset) & 1) * 16))
+#define CVMX_LED_UDD_DAT_SETX(offset)                        CVMX_ADD_IO_SEG(0x0001180000001AC0ull + (((offset) & 1) * 16))
+
+union cvmx_led_blink {
+	uint64_t u64;
+	struct cvmx_led_blink_s {
+		uint64_t reserved_8_63:56;
+		uint64_t rate:8;
+	} s;
+	struct cvmx_led_blink_s cn38xx;
+	struct cvmx_led_blink_s cn38xxp2;
+	struct cvmx_led_blink_s cn56xx;
+	struct cvmx_led_blink_s cn56xxp1;
+	struct cvmx_led_blink_s cn58xx;
+	struct cvmx_led_blink_s cn58xxp1;
+};
+typedef union cvmx_led_blink cvmx_led_blink_t;
+
+union cvmx_led_clk_phase {
+	uint64_t u64;
+	struct cvmx_led_clk_phase_s {
+		uint64_t reserved_7_63:57;
+		uint64_t phase:7;
+	} s;
+	struct cvmx_led_clk_phase_s cn38xx;
+	struct cvmx_led_clk_phase_s cn38xxp2;
+	struct cvmx_led_clk_phase_s cn56xx;
+	struct cvmx_led_clk_phase_s cn56xxp1;
+	struct cvmx_led_clk_phase_s cn58xx;
+	struct cvmx_led_clk_phase_s cn58xxp1;
+};
+typedef union cvmx_led_clk_phase cvmx_led_clk_phase_t;
+
+union cvmx_led_cylon {
+	uint64_t u64;
+	struct cvmx_led_cylon_s {
+		uint64_t reserved_16_63:48;
+		uint64_t rate:16;
+	} s;
+	struct cvmx_led_cylon_s cn38xx;
+	struct cvmx_led_cylon_s cn38xxp2;
+	struct cvmx_led_cylon_s cn56xx;
+	struct cvmx_led_cylon_s cn56xxp1;
+	struct cvmx_led_cylon_s cn58xx;
+	struct cvmx_led_cylon_s cn58xxp1;
+};
+typedef union cvmx_led_cylon cvmx_led_cylon_t;
+
+union cvmx_led_dbg {
+	uint64_t u64;
+	struct cvmx_led_dbg_s {
+		uint64_t reserved_1_63:63;
+		uint64_t dbg_en:1;
+	} s;
+	struct cvmx_led_dbg_s cn38xx;
+	struct cvmx_led_dbg_s cn38xxp2;
+	struct cvmx_led_dbg_s cn56xx;
+	struct cvmx_led_dbg_s cn56xxp1;
+	struct cvmx_led_dbg_s cn58xx;
+	struct cvmx_led_dbg_s cn58xxp1;
+};
+typedef union cvmx_led_dbg cvmx_led_dbg_t;
+
+union cvmx_led_en {
+	uint64_t u64;
+	struct cvmx_led_en_s {
+		uint64_t reserved_1_63:63;
+		uint64_t en:1;
+	} s;
+	struct cvmx_led_en_s cn38xx;
+	struct cvmx_led_en_s cn38xxp2;
+	struct cvmx_led_en_s cn56xx;
+	struct cvmx_led_en_s cn56xxp1;
+	struct cvmx_led_en_s cn58xx;
+	struct cvmx_led_en_s cn58xxp1;
+};
+typedef union cvmx_led_en cvmx_led_en_t;
+
+union cvmx_led_polarity {
+	uint64_t u64;
+	struct cvmx_led_polarity_s {
+		uint64_t reserved_1_63:63;
+		uint64_t polarity:1;
+	} s;
+	struct cvmx_led_polarity_s cn38xx;
+	struct cvmx_led_polarity_s cn38xxp2;
+	struct cvmx_led_polarity_s cn56xx;
+	struct cvmx_led_polarity_s cn56xxp1;
+	struct cvmx_led_polarity_s cn58xx;
+	struct cvmx_led_polarity_s cn58xxp1;
+};
+typedef union cvmx_led_polarity cvmx_led_polarity_t;
+
+union cvmx_led_prt {
+	uint64_t u64;
+	struct cvmx_led_prt_s {
+		uint64_t reserved_8_63:56;
+		uint64_t prt_en:8;
+	} s;
+	struct cvmx_led_prt_s cn38xx;
+	struct cvmx_led_prt_s cn38xxp2;
+	struct cvmx_led_prt_s cn56xx;
+	struct cvmx_led_prt_s cn56xxp1;
+	struct cvmx_led_prt_s cn58xx;
+	struct cvmx_led_prt_s cn58xxp1;
+};
+typedef union cvmx_led_prt cvmx_led_prt_t;
+
+union cvmx_led_prt_fmt {
+	uint64_t u64;
+	struct cvmx_led_prt_fmt_s {
+		uint64_t reserved_4_63:60;
+		uint64_t format:4;
+	} s;
+	struct cvmx_led_prt_fmt_s cn38xx;
+	struct cvmx_led_prt_fmt_s cn38xxp2;
+	struct cvmx_led_prt_fmt_s cn56xx;
+	struct cvmx_led_prt_fmt_s cn56xxp1;
+	struct cvmx_led_prt_fmt_s cn58xx;
+	struct cvmx_led_prt_fmt_s cn58xxp1;
+};
+typedef union cvmx_led_prt_fmt cvmx_led_prt_fmt_t;
+
+union cvmx_led_prt_statusx {
+	uint64_t u64;
+	struct cvmx_led_prt_statusx_s {
+		uint64_t reserved_6_63:58;
+		uint64_t status:6;
+	} s;
+	struct cvmx_led_prt_statusx_s cn38xx;
+	struct cvmx_led_prt_statusx_s cn38xxp2;
+	struct cvmx_led_prt_statusx_s cn56xx;
+	struct cvmx_led_prt_statusx_s cn56xxp1;
+	struct cvmx_led_prt_statusx_s cn58xx;
+	struct cvmx_led_prt_statusx_s cn58xxp1;
+};
+typedef union cvmx_led_prt_statusx cvmx_led_prt_statusx_t;
+
+union cvmx_led_udd_cntx {
+	uint64_t u64;
+	struct cvmx_led_udd_cntx_s {
+		uint64_t reserved_6_63:58;
+		uint64_t cnt:6;
+	} s;
+	struct cvmx_led_udd_cntx_s cn38xx;
+	struct cvmx_led_udd_cntx_s cn38xxp2;
+	struct cvmx_led_udd_cntx_s cn56xx;
+	struct cvmx_led_udd_cntx_s cn56xxp1;
+	struct cvmx_led_udd_cntx_s cn58xx;
+	struct cvmx_led_udd_cntx_s cn58xxp1;
+};
+typedef union cvmx_led_udd_cntx cvmx_led_udd_cntx_t;
+
+union cvmx_led_udd_datx {
+	uint64_t u64;
+	struct cvmx_led_udd_datx_s {
+		uint64_t reserved_32_63:32;
+		uint64_t dat:32;
+	} s;
+	struct cvmx_led_udd_datx_s cn38xx;
+	struct cvmx_led_udd_datx_s cn38xxp2;
+	struct cvmx_led_udd_datx_s cn56xx;
+	struct cvmx_led_udd_datx_s cn56xxp1;
+	struct cvmx_led_udd_datx_s cn58xx;
+	struct cvmx_led_udd_datx_s cn58xxp1;
+};
+typedef union cvmx_led_udd_datx cvmx_led_udd_datx_t;
+
+union cvmx_led_udd_dat_clrx {
+	uint64_t u64;
+	struct cvmx_led_udd_dat_clrx_s {
+		uint64_t reserved_32_63:32;
+		uint64_t clr:32;
+	} s;
+	struct cvmx_led_udd_dat_clrx_s cn38xx;
+	struct cvmx_led_udd_dat_clrx_s cn38xxp2;
+	struct cvmx_led_udd_dat_clrx_s cn56xx;
+	struct cvmx_led_udd_dat_clrx_s cn56xxp1;
+	struct cvmx_led_udd_dat_clrx_s cn58xx;
+	struct cvmx_led_udd_dat_clrx_s cn58xxp1;
+};
+typedef union cvmx_led_udd_dat_clrx cvmx_led_udd_dat_clrx_t;
+
+union cvmx_led_udd_dat_setx {
+	uint64_t u64;
+	struct cvmx_led_udd_dat_setx_s {
+		uint64_t reserved_32_63:32;
+		uint64_t set:32;
+	} s;
+	struct cvmx_led_udd_dat_setx_s cn38xx;
+	struct cvmx_led_udd_dat_setx_s cn38xxp2;
+	struct cvmx_led_udd_dat_setx_s cn56xx;
+	struct cvmx_led_udd_dat_setx_s cn56xxp1;
+	struct cvmx_led_udd_dat_setx_s cn58xx;
+	struct cvmx_led_udd_dat_setx_s cn58xxp1;
+};
+typedef union cvmx_led_udd_dat_setx cvmx_led_udd_dat_setx_t;
+
+#endif
diff --git a/arch/mips/include/asm/octeon/cvmx-mio-defs.h b/arch/mips/include/asm/octeon/cvmx-mio-defs.h
new file mode 100644
index 0000000..98d1982
--- /dev/null
+++ b/arch/mips/include/asm/octeon/cvmx-mio-defs.h
@@ -0,0 +1,2028 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as published by
+ * the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful,
+ * but AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or NONINFRINGEMENT.
+ * See the GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+ ***********************license end**************************************/
+
+#ifndef __CVMX_MIO_DEFS_H__
+#define __CVMX_MIO_DEFS_H__
+
+#define CVMX_MIO_BOOT_BIST_STAT                              CVMX_ADD_IO_SEG(0x00011800000000F8ull)
+#define CVMX_MIO_BOOT_COMP                                   CVMX_ADD_IO_SEG(0x00011800000000B8ull)
+#define CVMX_MIO_BOOT_DMA_CFGX(offset)                       CVMX_ADD_IO_SEG(0x0001180000000100ull + (((offset) & 3) * 8))
+#define CVMX_MIO_BOOT_DMA_INTX(offset)                       CVMX_ADD_IO_SEG(0x0001180000000138ull + (((offset) & 3) * 8))
+#define CVMX_MIO_BOOT_DMA_INT_ENX(offset)                    CVMX_ADD_IO_SEG(0x0001180000000150ull + (((offset) & 3) * 8))
+#define CVMX_MIO_BOOT_DMA_TIMX(offset)                       CVMX_ADD_IO_SEG(0x0001180000000120ull + (((offset) & 3) * 8))
+#define CVMX_MIO_BOOT_ERR                                    CVMX_ADD_IO_SEG(0x00011800000000A0ull)
+#define CVMX_MIO_BOOT_INT                                    CVMX_ADD_IO_SEG(0x00011800000000A8ull)
+#define CVMX_MIO_BOOT_LOC_ADR                                CVMX_ADD_IO_SEG(0x0001180000000090ull)
+#define CVMX_MIO_BOOT_LOC_CFGX(offset)                       CVMX_ADD_IO_SEG(0x0001180000000080ull + (((offset) & 1) * 8))
+#define CVMX_MIO_BOOT_LOC_DAT                                CVMX_ADD_IO_SEG(0x0001180000000098ull)
+#define CVMX_MIO_BOOT_PIN_DEFS                               CVMX_ADD_IO_SEG(0x00011800000000C0ull)
+#define CVMX_MIO_BOOT_REG_CFGX(offset)                       CVMX_ADD_IO_SEG(0x0001180000000000ull + (((offset) & 7) * 8))
+#define CVMX_MIO_BOOT_REG_TIMX(offset)                       CVMX_ADD_IO_SEG(0x0001180000000040ull + (((offset) & 7) * 8))
+#define CVMX_MIO_BOOT_THR                                    CVMX_ADD_IO_SEG(0x00011800000000B0ull)
+#define CVMX_MIO_FUS_BNK_DATX(offset)                        CVMX_ADD_IO_SEG(0x0001180000001520ull + (((offset) & 3) * 8))
+#define CVMX_MIO_FUS_DAT0                                    CVMX_ADD_IO_SEG(0x0001180000001400ull)
+#define CVMX_MIO_FUS_DAT1                                    CVMX_ADD_IO_SEG(0x0001180000001408ull)
+#define CVMX_MIO_FUS_DAT2                                    CVMX_ADD_IO_SEG(0x0001180000001410ull)
+#define CVMX_MIO_FUS_DAT3                                    CVMX_ADD_IO_SEG(0x0001180000001418ull)
+#define CVMX_MIO_FUS_EMA                                     CVMX_ADD_IO_SEG(0x0001180000001550ull)
+#define CVMX_MIO_FUS_PDF                                     CVMX_ADD_IO_SEG(0x0001180000001420ull)
+#define CVMX_MIO_FUS_PLL                                     CVMX_ADD_IO_SEG(0x0001180000001580ull)
+#define CVMX_MIO_FUS_PROG                                    CVMX_ADD_IO_SEG(0x0001180000001510ull)
+#define CVMX_MIO_FUS_PROG_TIMES                              CVMX_ADD_IO_SEG(0x0001180000001518ull)
+#define CVMX_MIO_FUS_RCMD                                    CVMX_ADD_IO_SEG(0x0001180000001500ull)
+#define CVMX_MIO_FUS_SPR_REPAIR_RES                          CVMX_ADD_IO_SEG(0x0001180000001548ull)
+#define CVMX_MIO_FUS_SPR_REPAIR_SUM                          CVMX_ADD_IO_SEG(0x0001180000001540ull)
+#define CVMX_MIO_FUS_UNLOCK                                  CVMX_ADD_IO_SEG(0x0001180000001578ull)
+#define CVMX_MIO_FUS_WADR                                    CVMX_ADD_IO_SEG(0x0001180000001508ull)
+#define CVMX_MIO_NDF_DMA_CFG                                 CVMX_ADD_IO_SEG(0x0001180000000168ull)
+#define CVMX_MIO_NDF_DMA_INT                                 CVMX_ADD_IO_SEG(0x0001180000000170ull)
+#define CVMX_MIO_NDF_DMA_INT_EN                              CVMX_ADD_IO_SEG(0x0001180000000178ull)
+#define CVMX_MIO_PLL_CTL                                     CVMX_ADD_IO_SEG(0x0001180000001448ull)
+#define CVMX_MIO_PLL_SETTING                                 CVMX_ADD_IO_SEG(0x0001180000001440ull)
+#define CVMX_MIO_TWSX_INT(offset)                            CVMX_ADD_IO_SEG(0x0001180000001010ull + (((offset) & 1) * 512))
+#define CVMX_MIO_TWSX_SW_TWSI(offset)                        CVMX_ADD_IO_SEG(0x0001180000001000ull + (((offset) & 1) * 512))
+#define CVMX_MIO_TWSX_SW_TWSI_EXT(offset)                    CVMX_ADD_IO_SEG(0x0001180000001018ull + (((offset) & 1) * 512))
+#define CVMX_MIO_TWSX_TWSI_SW(offset)                        CVMX_ADD_IO_SEG(0x0001180000001008ull + (((offset) & 1) * 512))
+#define CVMX_MIO_UART2_DLH                                   CVMX_ADD_IO_SEG(0x0001180000000488ull)
+#define CVMX_MIO_UART2_DLL                                   CVMX_ADD_IO_SEG(0x0001180000000480ull)
+#define CVMX_MIO_UART2_FAR                                   CVMX_ADD_IO_SEG(0x0001180000000520ull)
+#define CVMX_MIO_UART2_FCR                                   CVMX_ADD_IO_SEG(0x0001180000000450ull)
+#define CVMX_MIO_UART2_HTX                                   CVMX_ADD_IO_SEG(0x0001180000000708ull)
+#define CVMX_MIO_UART2_IER                                   CVMX_ADD_IO_SEG(0x0001180000000408ull)
+#define CVMX_MIO_UART2_IIR                                   CVMX_ADD_IO_SEG(0x0001180000000410ull)
+#define CVMX_MIO_UART2_LCR                                   CVMX_ADD_IO_SEG(0x0001180000000418ull)
+#define CVMX_MIO_UART2_LSR                                   CVMX_ADD_IO_SEG(0x0001180000000428ull)
+#define CVMX_MIO_UART2_MCR                                   CVMX_ADD_IO_SEG(0x0001180000000420ull)
+#define CVMX_MIO_UART2_MSR                                   CVMX_ADD_IO_SEG(0x0001180000000430ull)
+#define CVMX_MIO_UART2_RBR                                   CVMX_ADD_IO_SEG(0x0001180000000400ull)
+#define CVMX_MIO_UART2_RFL                                   CVMX_ADD_IO_SEG(0x0001180000000608ull)
+#define CVMX_MIO_UART2_RFW                                   CVMX_ADD_IO_SEG(0x0001180000000530ull)
+#define CVMX_MIO_UART2_SBCR                                  CVMX_ADD_IO_SEG(0x0001180000000620ull)
+#define CVMX_MIO_UART2_SCR                                   CVMX_ADD_IO_SEG(0x0001180000000438ull)
+#define CVMX_MIO_UART2_SFE                                   CVMX_ADD_IO_SEG(0x0001180000000630ull)
+#define CVMX_MIO_UART2_SRR                                   CVMX_ADD_IO_SEG(0x0001180000000610ull)
+#define CVMX_MIO_UART2_SRT                                   CVMX_ADD_IO_SEG(0x0001180000000638ull)
+#define CVMX_MIO_UART2_SRTS                                  CVMX_ADD_IO_SEG(0x0001180000000618ull)
+#define CVMX_MIO_UART2_STT                                   CVMX_ADD_IO_SEG(0x0001180000000700ull)
+#define CVMX_MIO_UART2_TFL                                   CVMX_ADD_IO_SEG(0x0001180000000600ull)
+#define CVMX_MIO_UART2_TFR                                   CVMX_ADD_IO_SEG(0x0001180000000528ull)
+#define CVMX_MIO_UART2_THR                                   CVMX_ADD_IO_SEG(0x0001180000000440ull)
+#define CVMX_MIO_UART2_USR                                   CVMX_ADD_IO_SEG(0x0001180000000538ull)
+#define CVMX_MIO_UARTX_DLH(offset)                           CVMX_ADD_IO_SEG(0x0001180000000888ull + (((offset) & 1) * 1024))
+#define CVMX_MIO_UARTX_DLL(offset)                           CVMX_ADD_IO_SEG(0x0001180000000880ull + (((offset) & 1) * 1024))
+#define CVMX_MIO_UARTX_FAR(offset)                           CVMX_ADD_IO_SEG(0x0001180000000920ull + (((offset) & 1) * 1024))
+#define CVMX_MIO_UARTX_FCR(offset)                           CVMX_ADD_IO_SEG(0x0001180000000850ull + (((offset) & 1) * 1024))
+#define CVMX_MIO_UARTX_HTX(offset)                           CVMX_ADD_IO_SEG(0x0001180000000B08ull + (((offset) & 1) * 1024))
+#define CVMX_MIO_UARTX_IER(offset)                           CVMX_ADD_IO_SEG(0x0001180000000808ull + (((offset) & 1) * 1024))
+#define CVMX_MIO_UARTX_IIR(offset)                           CVMX_ADD_IO_SEG(0x0001180000000810ull + (((offset) & 1) * 1024))
+#define CVMX_MIO_UARTX_LCR(offset)                           CVMX_ADD_IO_SEG(0x0001180000000818ull + (((offset) & 1) * 1024))
+#define CVMX_MIO_UARTX_LSR(offset)                           CVMX_ADD_IO_SEG(0x0001180000000828ull + (((offset) & 1) * 1024))
+#define CVMX_MIO_UARTX_MCR(offset)                           CVMX_ADD_IO_SEG(0x0001180000000820ull + (((offset) & 1) * 1024))
+#define CVMX_MIO_UARTX_MSR(offset)                           CVMX_ADD_IO_SEG(0x0001180000000830ull + (((offset) & 1) * 1024))
+#define CVMX_MIO_UARTX_RBR(offset)                           CVMX_ADD_IO_SEG(0x0001180000000800ull + (((offset) & 1) * 1024))
+#define CVMX_MIO_UARTX_RFL(offset)                           CVMX_ADD_IO_SEG(0x0001180000000A08ull + (((offset) & 1) * 1024))
+#define CVMX_MIO_UARTX_RFW(offset)                           CVMX_ADD_IO_SEG(0x0001180000000930ull + (((offset) & 1) * 1024))
+#define CVMX_MIO_UARTX_SBCR(offset)                          CVMX_ADD_IO_SEG(0x0001180000000A20ull + (((offset) & 1) * 1024))
+#define CVMX_MIO_UARTX_SCR(offset)                           CVMX_ADD_IO_SEG(0x0001180000000838ull + (((offset) & 1) * 1024))
+#define CVMX_MIO_UARTX_SFE(offset)                           CVMX_ADD_IO_SEG(0x0001180000000A30ull + (((offset) & 1) * 1024))
+#define CVMX_MIO_UARTX_SRR(offset)                           CVMX_ADD_IO_SEG(0x0001180000000A10ull + (((offset) & 1) * 1024))
+#define CVMX_MIO_UARTX_SRT(offset)                           CVMX_ADD_IO_SEG(0x0001180000000A38ull + (((offset) & 1) * 1024))
+#define CVMX_MIO_UARTX_SRTS(offset)                          CVMX_ADD_IO_SEG(0x0001180000000A18ull + (((offset) & 1) * 1024))
+#define CVMX_MIO_UARTX_STT(offset)                           CVMX_ADD_IO_SEG(0x0001180000000B00ull + (((offset) & 1) * 1024))
+#define CVMX_MIO_UARTX_TFL(offset)                           CVMX_ADD_IO_SEG(0x0001180000000A00ull + (((offset) & 1) * 1024))
+#define CVMX_MIO_UARTX_TFR(offset)                           CVMX_ADD_IO_SEG(0x0001180000000928ull + (((offset) & 1) * 1024))
+#define CVMX_MIO_UARTX_THR(offset)                           CVMX_ADD_IO_SEG(0x0001180000000840ull + (((offset) & 1) * 1024))
+#define CVMX_MIO_UARTX_USR(offset)                           CVMX_ADD_IO_SEG(0x0001180000000938ull + (((offset) & 1) * 1024))
+
+union cvmx_mio_boot_bist_stat {
+	uint64_t u64;
+	struct cvmx_mio_boot_bist_stat_s {
+		uint64_t reserved_2_63:62;
+		uint64_t loc:1;
+		uint64_t ncbi:1;
+	} s;
+	struct cvmx_mio_boot_bist_stat_cn30xx {
+		uint64_t reserved_4_63:60;
+		uint64_t ncbo_1:1;
+		uint64_t ncbo_0:1;
+		uint64_t loc:1;
+		uint64_t ncbi:1;
+	} cn30xx;
+	struct cvmx_mio_boot_bist_stat_cn30xx cn31xx;
+	struct cvmx_mio_boot_bist_stat_cn38xx {
+		uint64_t reserved_3_63:61;
+		uint64_t ncbo_0:1;
+		uint64_t loc:1;
+		uint64_t ncbi:1;
+	} cn38xx;
+	struct cvmx_mio_boot_bist_stat_cn38xx cn38xxp2;
+	struct cvmx_mio_boot_bist_stat_cn50xx {
+		uint64_t reserved_6_63:58;
+		uint64_t pcm_1:1;
+		uint64_t pcm_0:1;
+		uint64_t ncbo_1:1;
+		uint64_t ncbo_0:1;
+		uint64_t loc:1;
+		uint64_t ncbi:1;
+	} cn50xx;
+	struct cvmx_mio_boot_bist_stat_cn52xx {
+		uint64_t reserved_6_63:58;
+		uint64_t ndf:2;
+		uint64_t ncbo_0:1;
+		uint64_t dma:1;
+		uint64_t loc:1;
+		uint64_t ncbi:1;
+	} cn52xx;
+	struct cvmx_mio_boot_bist_stat_cn52xxp1 {
+		uint64_t reserved_4_63:60;
+		uint64_t ncbo_0:1;
+		uint64_t dma:1;
+		uint64_t loc:1;
+		uint64_t ncbi:1;
+	} cn52xxp1;
+	struct cvmx_mio_boot_bist_stat_cn52xxp1 cn56xx;
+	struct cvmx_mio_boot_bist_stat_cn52xxp1 cn56xxp1;
+	struct cvmx_mio_boot_bist_stat_cn38xx cn58xx;
+	struct cvmx_mio_boot_bist_stat_cn38xx cn58xxp1;
+};
+typedef union cvmx_mio_boot_bist_stat cvmx_mio_boot_bist_stat_t;
+
+union cvmx_mio_boot_comp {
+	uint64_t u64;
+	struct cvmx_mio_boot_comp_s {
+		uint64_t reserved_10_63:54;
+		uint64_t pctl:5;
+		uint64_t nctl:5;
+	} s;
+	struct cvmx_mio_boot_comp_s cn50xx;
+	struct cvmx_mio_boot_comp_s cn52xx;
+	struct cvmx_mio_boot_comp_s cn52xxp1;
+	struct cvmx_mio_boot_comp_s cn56xx;
+	struct cvmx_mio_boot_comp_s cn56xxp1;
+};
+typedef union cvmx_mio_boot_comp cvmx_mio_boot_comp_t;
+
+union cvmx_mio_boot_dma_cfgx {
+	uint64_t u64;
+	struct cvmx_mio_boot_dma_cfgx_s {
+		uint64_t en:1;
+		uint64_t rw:1;
+		uint64_t clr:1;
+		uint64_t reserved_60_60:1;
+		uint64_t swap32:1;
+		uint64_t swap16:1;
+		uint64_t swap8:1;
+		uint64_t endian:1;
+		uint64_t size:20;
+		uint64_t adr:36;
+	} s;
+	struct cvmx_mio_boot_dma_cfgx_s cn52xx;
+	struct cvmx_mio_boot_dma_cfgx_s cn52xxp1;
+	struct cvmx_mio_boot_dma_cfgx_s cn56xx;
+	struct cvmx_mio_boot_dma_cfgx_s cn56xxp1;
+};
+typedef union cvmx_mio_boot_dma_cfgx cvmx_mio_boot_dma_cfgx_t;
+
+union cvmx_mio_boot_dma_intx {
+	uint64_t u64;
+	struct cvmx_mio_boot_dma_intx_s {
+		uint64_t reserved_2_63:62;
+		uint64_t dmarq:1;
+		uint64_t done:1;
+	} s;
+	struct cvmx_mio_boot_dma_intx_s cn52xx;
+	struct cvmx_mio_boot_dma_intx_s cn52xxp1;
+	struct cvmx_mio_boot_dma_intx_s cn56xx;
+	struct cvmx_mio_boot_dma_intx_s cn56xxp1;
+};
+typedef union cvmx_mio_boot_dma_intx cvmx_mio_boot_dma_intx_t;
+
+union cvmx_mio_boot_dma_int_enx {
+	uint64_t u64;
+	struct cvmx_mio_boot_dma_int_enx_s {
+		uint64_t reserved_2_63:62;
+		uint64_t dmarq:1;
+		uint64_t done:1;
+	} s;
+	struct cvmx_mio_boot_dma_int_enx_s cn52xx;
+	struct cvmx_mio_boot_dma_int_enx_s cn52xxp1;
+	struct cvmx_mio_boot_dma_int_enx_s cn56xx;
+	struct cvmx_mio_boot_dma_int_enx_s cn56xxp1;
+};
+typedef union cvmx_mio_boot_dma_int_enx cvmx_mio_boot_dma_int_enx_t;
+
+union cvmx_mio_boot_dma_timx {
+	uint64_t u64;
+	struct cvmx_mio_boot_dma_timx_s {
+		uint64_t dmack_pi:1;
+		uint64_t dmarq_pi:1;
+		uint64_t tim_mult:2;
+		uint64_t rd_dly:3;
+		uint64_t ddr:1;
+		uint64_t width:1;
+		uint64_t reserved_48_54:7;
+		uint64_t pause:6;
+		uint64_t dmack_h:6;
+		uint64_t we_n:6;
+		uint64_t we_a:6;
+		uint64_t oe_n:6;
+		uint64_t oe_a:6;
+		uint64_t dmack_s:6;
+		uint64_t dmarq:6;
+	} s;
+	struct cvmx_mio_boot_dma_timx_s cn52xx;
+	struct cvmx_mio_boot_dma_timx_s cn52xxp1;
+	struct cvmx_mio_boot_dma_timx_s cn56xx;
+	struct cvmx_mio_boot_dma_timx_s cn56xxp1;
+};
+typedef union cvmx_mio_boot_dma_timx cvmx_mio_boot_dma_timx_t;
+
+union cvmx_mio_boot_err {
+	uint64_t u64;
+	struct cvmx_mio_boot_err_s {
+		uint64_t reserved_2_63:62;
+		uint64_t wait_err:1;
+		uint64_t adr_err:1;
+	} s;
+	struct cvmx_mio_boot_err_s cn30xx;
+	struct cvmx_mio_boot_err_s cn31xx;
+	struct cvmx_mio_boot_err_s cn38xx;
+	struct cvmx_mio_boot_err_s cn38xxp2;
+	struct cvmx_mio_boot_err_s cn50xx;
+	struct cvmx_mio_boot_err_s cn52xx;
+	struct cvmx_mio_boot_err_s cn52xxp1;
+	struct cvmx_mio_boot_err_s cn56xx;
+	struct cvmx_mio_boot_err_s cn56xxp1;
+	struct cvmx_mio_boot_err_s cn58xx;
+	struct cvmx_mio_boot_err_s cn58xxp1;
+};
+typedef union cvmx_mio_boot_err cvmx_mio_boot_err_t;
+
+union cvmx_mio_boot_int {
+	uint64_t u64;
+	struct cvmx_mio_boot_int_s {
+		uint64_t reserved_2_63:62;
+		uint64_t wait_int:1;
+		uint64_t adr_int:1;
+	} s;
+	struct cvmx_mio_boot_int_s cn30xx;
+	struct cvmx_mio_boot_int_s cn31xx;
+	struct cvmx_mio_boot_int_s cn38xx;
+	struct cvmx_mio_boot_int_s cn38xxp2;
+	struct cvmx_mio_boot_int_s cn50xx;
+	struct cvmx_mio_boot_int_s cn52xx;
+	struct cvmx_mio_boot_int_s cn52xxp1;
+	struct cvmx_mio_boot_int_s cn56xx;
+	struct cvmx_mio_boot_int_s cn56xxp1;
+	struct cvmx_mio_boot_int_s cn58xx;
+	struct cvmx_mio_boot_int_s cn58xxp1;
+};
+typedef union cvmx_mio_boot_int cvmx_mio_boot_int_t;
+
+union cvmx_mio_boot_loc_adr {
+	uint64_t u64;
+	struct cvmx_mio_boot_loc_adr_s {
+		uint64_t reserved_8_63:56;
+		uint64_t adr:5;
+		uint64_t reserved_0_2:3;
+	} s;
+	struct cvmx_mio_boot_loc_adr_s cn30xx;
+	struct cvmx_mio_boot_loc_adr_s cn31xx;
+	struct cvmx_mio_boot_loc_adr_s cn38xx;
+	struct cvmx_mio_boot_loc_adr_s cn38xxp2;
+	struct cvmx_mio_boot_loc_adr_s cn50xx;
+	struct cvmx_mio_boot_loc_adr_s cn52xx;
+	struct cvmx_mio_boot_loc_adr_s cn52xxp1;
+	struct cvmx_mio_boot_loc_adr_s cn56xx;
+	struct cvmx_mio_boot_loc_adr_s cn56xxp1;
+	struct cvmx_mio_boot_loc_adr_s cn58xx;
+	struct cvmx_mio_boot_loc_adr_s cn58xxp1;
+};
+typedef union cvmx_mio_boot_loc_adr cvmx_mio_boot_loc_adr_t;
+
+union cvmx_mio_boot_loc_cfgx {
+	uint64_t u64;
+	struct cvmx_mio_boot_loc_cfgx_s {
+		uint64_t reserved_32_63:32;
+		uint64_t en:1;
+		uint64_t reserved_28_30:3;
+		uint64_t base:25;
+		uint64_t reserved_0_2:3;
+	} s;
+	struct cvmx_mio_boot_loc_cfgx_s cn30xx;
+	struct cvmx_mio_boot_loc_cfgx_s cn31xx;
+	struct cvmx_mio_boot_loc_cfgx_s cn38xx;
+	struct cvmx_mio_boot_loc_cfgx_s cn38xxp2;
+	struct cvmx_mio_boot_loc_cfgx_s cn50xx;
+	struct cvmx_mio_boot_loc_cfgx_s cn52xx;
+	struct cvmx_mio_boot_loc_cfgx_s cn52xxp1;
+	struct cvmx_mio_boot_loc_cfgx_s cn56xx;
+	struct cvmx_mio_boot_loc_cfgx_s cn56xxp1;
+	struct cvmx_mio_boot_loc_cfgx_s cn58xx;
+	struct cvmx_mio_boot_loc_cfgx_s cn58xxp1;
+};
+typedef union cvmx_mio_boot_loc_cfgx cvmx_mio_boot_loc_cfgx_t;
+
+union cvmx_mio_boot_loc_dat {
+	uint64_t u64;
+	struct cvmx_mio_boot_loc_dat_s {
+		uint64_t data:64;
+	} s;
+	struct cvmx_mio_boot_loc_dat_s cn30xx;
+	struct cvmx_mio_boot_loc_dat_s cn31xx;
+	struct cvmx_mio_boot_loc_dat_s cn38xx;
+	struct cvmx_mio_boot_loc_dat_s cn38xxp2;
+	struct cvmx_mio_boot_loc_dat_s cn50xx;
+	struct cvmx_mio_boot_loc_dat_s cn52xx;
+	struct cvmx_mio_boot_loc_dat_s cn52xxp1;
+	struct cvmx_mio_boot_loc_dat_s cn56xx;
+	struct cvmx_mio_boot_loc_dat_s cn56xxp1;
+	struct cvmx_mio_boot_loc_dat_s cn58xx;
+	struct cvmx_mio_boot_loc_dat_s cn58xxp1;
+};
+typedef union cvmx_mio_boot_loc_dat cvmx_mio_boot_loc_dat_t;
+
+union cvmx_mio_boot_pin_defs {
+	uint64_t u64;
+	struct cvmx_mio_boot_pin_defs_s {
+		uint64_t reserved_16_63:48;
+		uint64_t ale:1;
+		uint64_t width:1;
+		uint64_t dmack_p2:1;
+		uint64_t dmack_p1:1;
+		uint64_t dmack_p0:1;
+		uint64_t term:2;
+		uint64_t nand:1;
+		uint64_t reserved_0_7:8;
+	} s;
+	struct cvmx_mio_boot_pin_defs_cn52xx {
+		uint64_t reserved_16_63:48;
+		uint64_t ale:1;
+		uint64_t width:1;
+		uint64_t reserved_13_13:1;
+		uint64_t dmack_p1:1;
+		uint64_t dmack_p0:1;
+		uint64_t term:2;
+		uint64_t nand:1;
+		uint64_t reserved_0_7:8;
+	} cn52xx;
+	struct cvmx_mio_boot_pin_defs_cn56xx {
+		uint64_t reserved_16_63:48;
+		uint64_t ale:1;
+		uint64_t width:1;
+		uint64_t dmack_p2:1;
+		uint64_t dmack_p1:1;
+		uint64_t dmack_p0:1;
+		uint64_t term:2;
+		uint64_t reserved_0_8:9;
+	} cn56xx;
+};
+typedef union cvmx_mio_boot_pin_defs cvmx_mio_boot_pin_defs_t;
+
+union cvmx_mio_boot_reg_cfgx {
+	uint64_t u64;
+	struct cvmx_mio_boot_reg_cfgx_s {
+		uint64_t reserved_44_63:20;
+		uint64_t dmack:2;
+		uint64_t tim_mult:2;
+		uint64_t rd_dly:3;
+		uint64_t sam:1;
+		uint64_t we_ext:2;
+		uint64_t oe_ext:2;
+		uint64_t en:1;
+		uint64_t orbit:1;
+		uint64_t ale:1;
+		uint64_t width:1;
+		uint64_t size:12;
+		uint64_t base:16;
+	} s;
+	struct cvmx_mio_boot_reg_cfgx_cn30xx {
+		uint64_t reserved_37_63:27;
+		uint64_t sam:1;
+		uint64_t we_ext:2;
+		uint64_t oe_ext:2;
+		uint64_t en:1;
+		uint64_t orbit:1;
+		uint64_t ale:1;
+		uint64_t width:1;
+		uint64_t size:12;
+		uint64_t base:16;
+	} cn30xx;
+	struct cvmx_mio_boot_reg_cfgx_cn30xx cn31xx;
+	struct cvmx_mio_boot_reg_cfgx_cn38xx {
+		uint64_t reserved_32_63:32;
+		uint64_t en:1;
+		uint64_t orbit:1;
+		uint64_t reserved_28_29:2;
+		uint64_t size:12;
+		uint64_t base:16;
+	} cn38xx;
+	struct cvmx_mio_boot_reg_cfgx_cn38xx cn38xxp2;
+	struct cvmx_mio_boot_reg_cfgx_cn50xx {
+		uint64_t reserved_42_63:22;
+		uint64_t tim_mult:2;
+		uint64_t rd_dly:3;
+		uint64_t sam:1;
+		uint64_t we_ext:2;
+		uint64_t oe_ext:2;
+		uint64_t en:1;
+		uint64_t orbit:1;
+		uint64_t ale:1;
+		uint64_t width:1;
+		uint64_t size:12;
+		uint64_t base:16;
+	} cn50xx;
+	struct cvmx_mio_boot_reg_cfgx_s cn52xx;
+	struct cvmx_mio_boot_reg_cfgx_s cn52xxp1;
+	struct cvmx_mio_boot_reg_cfgx_s cn56xx;
+	struct cvmx_mio_boot_reg_cfgx_s cn56xxp1;
+	struct cvmx_mio_boot_reg_cfgx_cn30xx cn58xx;
+	struct cvmx_mio_boot_reg_cfgx_cn30xx cn58xxp1;
+};
+typedef union cvmx_mio_boot_reg_cfgx cvmx_mio_boot_reg_cfgx_t;
+
+union cvmx_mio_boot_reg_timx {
+	uint64_t u64;
+	struct cvmx_mio_boot_reg_timx_s {
+		uint64_t pagem:1;
+		uint64_t waitm:1;
+		uint64_t pages:2;
+		uint64_t ale:6;
+		uint64_t page:6;
+		uint64_t wait:6;
+		uint64_t pause:6;
+		uint64_t wr_hld:6;
+		uint64_t rd_hld:6;
+		uint64_t we:6;
+		uint64_t oe:6;
+		uint64_t ce:6;
+		uint64_t adr:6;
+	} s;
+	struct cvmx_mio_boot_reg_timx_s cn30xx;
+	struct cvmx_mio_boot_reg_timx_s cn31xx;
+	struct cvmx_mio_boot_reg_timx_cn38xx {
+		uint64_t pagem:1;
+		uint64_t waitm:1;
+		uint64_t pages:2;
+		uint64_t reserved_54_59:6;
+		uint64_t page:6;
+		uint64_t wait:6;
+		uint64_t pause:6;
+		uint64_t wr_hld:6;
+		uint64_t rd_hld:6;
+		uint64_t we:6;
+		uint64_t oe:6;
+		uint64_t ce:6;
+		uint64_t adr:6;
+	} cn38xx;
+	struct cvmx_mio_boot_reg_timx_cn38xx cn38xxp2;
+	struct cvmx_mio_boot_reg_timx_s cn50xx;
+	struct cvmx_mio_boot_reg_timx_s cn52xx;
+	struct cvmx_mio_boot_reg_timx_s cn52xxp1;
+	struct cvmx_mio_boot_reg_timx_s cn56xx;
+	struct cvmx_mio_boot_reg_timx_s cn56xxp1;
+	struct cvmx_mio_boot_reg_timx_s cn58xx;
+	struct cvmx_mio_boot_reg_timx_s cn58xxp1;
+};
+typedef union cvmx_mio_boot_reg_timx cvmx_mio_boot_reg_timx_t;
+
+union cvmx_mio_boot_thr {
+	uint64_t u64;
+	struct cvmx_mio_boot_thr_s {
+		uint64_t reserved_22_63:42;
+		uint64_t dma_thr:6;
+		uint64_t reserved_14_15:2;
+		uint64_t fif_cnt:6;
+		uint64_t reserved_6_7:2;
+		uint64_t fif_thr:6;
+	} s;
+	struct cvmx_mio_boot_thr_cn30xx {
+		uint64_t reserved_14_63:50;
+		uint64_t fif_cnt:6;
+		uint64_t reserved_6_7:2;
+		uint64_t fif_thr:6;
+	} cn30xx;
+	struct cvmx_mio_boot_thr_cn30xx cn31xx;
+	struct cvmx_mio_boot_thr_cn30xx cn38xx;
+	struct cvmx_mio_boot_thr_cn30xx cn38xxp2;
+	struct cvmx_mio_boot_thr_cn30xx cn50xx;
+	struct cvmx_mio_boot_thr_s cn52xx;
+	struct cvmx_mio_boot_thr_s cn52xxp1;
+	struct cvmx_mio_boot_thr_s cn56xx;
+	struct cvmx_mio_boot_thr_s cn56xxp1;
+	struct cvmx_mio_boot_thr_cn30xx cn58xx;
+	struct cvmx_mio_boot_thr_cn30xx cn58xxp1;
+};
+typedef union cvmx_mio_boot_thr cvmx_mio_boot_thr_t;
+
+union cvmx_mio_fus_bnk_datx {
+	uint64_t u64;
+	struct cvmx_mio_fus_bnk_datx_s {
+		uint64_t dat:64;
+	} s;
+	struct cvmx_mio_fus_bnk_datx_s cn50xx;
+	struct cvmx_mio_fus_bnk_datx_s cn52xx;
+	struct cvmx_mio_fus_bnk_datx_s cn52xxp1;
+	struct cvmx_mio_fus_bnk_datx_s cn56xx;
+	struct cvmx_mio_fus_bnk_datx_s cn56xxp1;
+	struct cvmx_mio_fus_bnk_datx_s cn58xx;
+	struct cvmx_mio_fus_bnk_datx_s cn58xxp1;
+};
+typedef union cvmx_mio_fus_bnk_datx cvmx_mio_fus_bnk_datx_t;
+
+union cvmx_mio_fus_dat0 {
+	uint64_t u64;
+	struct cvmx_mio_fus_dat0_s {
+		uint64_t reserved_32_63:32;
+		uint64_t man_info:32;
+	} s;
+	struct cvmx_mio_fus_dat0_s cn30xx;
+	struct cvmx_mio_fus_dat0_s cn31xx;
+	struct cvmx_mio_fus_dat0_s cn38xx;
+	struct cvmx_mio_fus_dat0_s cn38xxp2;
+	struct cvmx_mio_fus_dat0_s cn50xx;
+	struct cvmx_mio_fus_dat0_s cn52xx;
+	struct cvmx_mio_fus_dat0_s cn52xxp1;
+	struct cvmx_mio_fus_dat0_s cn56xx;
+	struct cvmx_mio_fus_dat0_s cn56xxp1;
+	struct cvmx_mio_fus_dat0_s cn58xx;
+	struct cvmx_mio_fus_dat0_s cn58xxp1;
+};
+typedef union cvmx_mio_fus_dat0 cvmx_mio_fus_dat0_t;
+
+union cvmx_mio_fus_dat1 {
+	uint64_t u64;
+	struct cvmx_mio_fus_dat1_s {
+		uint64_t reserved_32_63:32;
+		uint64_t man_info:32;
+	} s;
+	struct cvmx_mio_fus_dat1_s cn30xx;
+	struct cvmx_mio_fus_dat1_s cn31xx;
+	struct cvmx_mio_fus_dat1_s cn38xx;
+	struct cvmx_mio_fus_dat1_s cn38xxp2;
+	struct cvmx_mio_fus_dat1_s cn50xx;
+	struct cvmx_mio_fus_dat1_s cn52xx;
+	struct cvmx_mio_fus_dat1_s cn52xxp1;
+	struct cvmx_mio_fus_dat1_s cn56xx;
+	struct cvmx_mio_fus_dat1_s cn56xxp1;
+	struct cvmx_mio_fus_dat1_s cn58xx;
+	struct cvmx_mio_fus_dat1_s cn58xxp1;
+};
+typedef union cvmx_mio_fus_dat1 cvmx_mio_fus_dat1_t;
+
+union cvmx_mio_fus_dat2 {
+	uint64_t u64;
+	struct cvmx_mio_fus_dat2_s {
+		uint64_t reserved_34_63:30;
+		uint64_t fus318:1;
+		uint64_t raid_en:1;
+		uint64_t reserved_30_31:2;
+		uint64_t nokasu:1;
+		uint64_t nodfa_cp2:1;
+		uint64_t nomul:1;
+		uint64_t nocrypto:1;
+		uint64_t rst_sht:1;
+		uint64_t bist_dis:1;
+		uint64_t chip_id:8;
+		uint64_t reserved_0_15:16;
+	} s;
+	struct cvmx_mio_fus_dat2_cn30xx {
+		uint64_t reserved_29_63:35;
+		uint64_t nodfa_cp2:1;
+		uint64_t nomul:1;
+		uint64_t nocrypto:1;
+		uint64_t rst_sht:1;
+		uint64_t bist_dis:1;
+		uint64_t chip_id:8;
+		uint64_t pll_off:4;
+		uint64_t reserved_1_11:11;
+		uint64_t pp_dis:1;
+	} cn30xx;
+	struct cvmx_mio_fus_dat2_cn31xx {
+		uint64_t reserved_29_63:35;
+		uint64_t nodfa_cp2:1;
+		uint64_t nomul:1;
+		uint64_t nocrypto:1;
+		uint64_t rst_sht:1;
+		uint64_t bist_dis:1;
+		uint64_t chip_id:8;
+		uint64_t pll_off:4;
+		uint64_t reserved_2_11:10;
+		uint64_t pp_dis:2;
+	} cn31xx;
+	struct cvmx_mio_fus_dat2_cn38xx {
+		uint64_t reserved_29_63:35;
+		uint64_t nodfa_cp2:1;
+		uint64_t nomul:1;
+		uint64_t nocrypto:1;
+		uint64_t rst_sht:1;
+		uint64_t bist_dis:1;
+		uint64_t chip_id:8;
+		uint64_t pp_dis:16;
+	} cn38xx;
+	struct cvmx_mio_fus_dat2_cn38xx cn38xxp2;
+	struct cvmx_mio_fus_dat2_cn50xx {
+		uint64_t reserved_34_63:30;
+		uint64_t fus318:1;
+		uint64_t raid_en:1;
+		uint64_t reserved_30_31:2;
+		uint64_t nokasu:1;
+		uint64_t nodfa_cp2:1;
+		uint64_t nomul:1;
+		uint64_t nocrypto:1;
+		uint64_t rst_sht:1;
+		uint64_t bist_dis:1;
+		uint64_t chip_id:8;
+		uint64_t reserved_2_15:14;
+		uint64_t pp_dis:2;
+	} cn50xx;
+	struct cvmx_mio_fus_dat2_cn52xx {
+		uint64_t reserved_34_63:30;
+		uint64_t fus318:1;
+		uint64_t raid_en:1;
+		uint64_t reserved_30_31:2;
+		uint64_t nokasu:1;
+		uint64_t nodfa_cp2:1;
+		uint64_t nomul:1;
+		uint64_t nocrypto:1;
+		uint64_t rst_sht:1;
+		uint64_t bist_dis:1;
+		uint64_t chip_id:8;
+		uint64_t reserved_4_15:12;
+		uint64_t pp_dis:4;
+	} cn52xx;
+	struct cvmx_mio_fus_dat2_cn52xx cn52xxp1;
+	struct cvmx_mio_fus_dat2_cn56xx {
+		uint64_t reserved_34_63:30;
+		uint64_t fus318:1;
+		uint64_t raid_en:1;
+		uint64_t reserved_30_31:2;
+		uint64_t nokasu:1;
+		uint64_t nodfa_cp2:1;
+		uint64_t nomul:1;
+		uint64_t nocrypto:1;
+		uint64_t rst_sht:1;
+		uint64_t bist_dis:1;
+		uint64_t chip_id:8;
+		uint64_t reserved_12_15:4;
+		uint64_t pp_dis:12;
+	} cn56xx;
+	struct cvmx_mio_fus_dat2_cn56xx cn56xxp1;
+	struct cvmx_mio_fus_dat2_cn58xx {
+		uint64_t reserved_30_63:34;
+		uint64_t nokasu:1;
+		uint64_t nodfa_cp2:1;
+		uint64_t nomul:1;
+		uint64_t nocrypto:1;
+		uint64_t rst_sht:1;
+		uint64_t bist_dis:1;
+		uint64_t chip_id:8;
+		uint64_t pp_dis:16;
+	} cn58xx;
+	struct cvmx_mio_fus_dat2_cn58xx cn58xxp1;
+};
+typedef union cvmx_mio_fus_dat2 cvmx_mio_fus_dat2_t;
+
+union cvmx_mio_fus_dat3 {
+	uint64_t u64;
+	struct cvmx_mio_fus_dat3_s {
+		uint64_t reserved_32_63:32;
+		uint64_t pll_div4:1;
+		uint64_t zip_crip:2;
+		uint64_t bar2_en:1;
+		uint64_t efus_lck:1;
+		uint64_t efus_ign:1;
+		uint64_t nozip:1;
+		uint64_t nodfa_dte:1;
+		uint64_t icache:24;
+	} s;
+	struct cvmx_mio_fus_dat3_cn30xx {
+		uint64_t reserved_32_63:32;
+		uint64_t pll_div4:1;
+		uint64_t reserved_29_30:2;
+		uint64_t bar2_en:1;
+		uint64_t efus_lck:1;
+		uint64_t efus_ign:1;
+		uint64_t nozip:1;
+		uint64_t nodfa_dte:1;
+		uint64_t icache:24;
+	} cn30xx;
+	struct cvmx_mio_fus_dat3_s cn31xx;
+	struct cvmx_mio_fus_dat3_cn38xx {
+		uint64_t reserved_31_63:33;
+		uint64_t zip_crip:2;
+		uint64_t bar2_en:1;
+		uint64_t efus_lck:1;
+		uint64_t efus_ign:1;
+		uint64_t nozip:1;
+		uint64_t nodfa_dte:1;
+		uint64_t icache:24;
+	} cn38xx;
+	struct cvmx_mio_fus_dat3_cn38xxp2 {
+		uint64_t reserved_29_63:35;
+		uint64_t bar2_en:1;
+		uint64_t efus_lck:1;
+		uint64_t efus_ign:1;
+		uint64_t nozip:1;
+		uint64_t nodfa_dte:1;
+		uint64_t icache:24;
+	} cn38xxp2;
+	struct cvmx_mio_fus_dat3_cn38xx cn50xx;
+	struct cvmx_mio_fus_dat3_cn38xx cn52xx;
+	struct cvmx_mio_fus_dat3_cn38xx cn52xxp1;
+	struct cvmx_mio_fus_dat3_cn38xx cn56xx;
+	struct cvmx_mio_fus_dat3_cn38xx cn56xxp1;
+	struct cvmx_mio_fus_dat3_cn38xx cn58xx;
+	struct cvmx_mio_fus_dat3_cn38xx cn58xxp1;
+};
+typedef union cvmx_mio_fus_dat3 cvmx_mio_fus_dat3_t;
+
+union cvmx_mio_fus_ema {
+	uint64_t u64;
+	struct cvmx_mio_fus_ema_s {
+		uint64_t reserved_7_63:57;
+		uint64_t eff_ema:3;
+		uint64_t reserved_3_3:1;
+		uint64_t ema:3;
+	} s;
+	struct cvmx_mio_fus_ema_s cn50xx;
+	struct cvmx_mio_fus_ema_s cn52xx;
+	struct cvmx_mio_fus_ema_s cn52xxp1;
+	struct cvmx_mio_fus_ema_s cn56xx;
+	struct cvmx_mio_fus_ema_s cn56xxp1;
+	struct cvmx_mio_fus_ema_cn58xx {
+		uint64_t reserved_2_63:62;
+		uint64_t ema:2;
+	} cn58xx;
+	struct cvmx_mio_fus_ema_cn58xx cn58xxp1;
+};
+typedef union cvmx_mio_fus_ema cvmx_mio_fus_ema_t;
+
+union cvmx_mio_fus_pdf {
+	uint64_t u64;
+	struct cvmx_mio_fus_pdf_s {
+		uint64_t pdf:64;
+	} s;
+	struct cvmx_mio_fus_pdf_s cn50xx;
+	struct cvmx_mio_fus_pdf_s cn52xx;
+	struct cvmx_mio_fus_pdf_s cn52xxp1;
+	struct cvmx_mio_fus_pdf_s cn56xx;
+	struct cvmx_mio_fus_pdf_s cn56xxp1;
+	struct cvmx_mio_fus_pdf_s cn58xx;
+};
+typedef union cvmx_mio_fus_pdf cvmx_mio_fus_pdf_t;
+
+union cvmx_mio_fus_pll {
+	uint64_t u64;
+	struct cvmx_mio_fus_pll_s {
+		uint64_t reserved_2_63:62;
+		uint64_t rfslip:1;
+		uint64_t fbslip:1;
+	} s;
+	struct cvmx_mio_fus_pll_s cn50xx;
+	struct cvmx_mio_fus_pll_s cn52xx;
+	struct cvmx_mio_fus_pll_s cn52xxp1;
+	struct cvmx_mio_fus_pll_s cn56xx;
+	struct cvmx_mio_fus_pll_s cn56xxp1;
+	struct cvmx_mio_fus_pll_s cn58xx;
+	struct cvmx_mio_fus_pll_s cn58xxp1;
+};
+typedef union cvmx_mio_fus_pll cvmx_mio_fus_pll_t;
+
+union cvmx_mio_fus_prog {
+	uint64_t u64;
+	struct cvmx_mio_fus_prog_s {
+		uint64_t reserved_1_63:63;
+		uint64_t prog:1;
+	} s;
+	struct cvmx_mio_fus_prog_s cn30xx;
+	struct cvmx_mio_fus_prog_s cn31xx;
+	struct cvmx_mio_fus_prog_s cn38xx;
+	struct cvmx_mio_fus_prog_s cn38xxp2;
+	struct cvmx_mio_fus_prog_s cn50xx;
+	struct cvmx_mio_fus_prog_s cn52xx;
+	struct cvmx_mio_fus_prog_s cn52xxp1;
+	struct cvmx_mio_fus_prog_s cn56xx;
+	struct cvmx_mio_fus_prog_s cn56xxp1;
+	struct cvmx_mio_fus_prog_s cn58xx;
+	struct cvmx_mio_fus_prog_s cn58xxp1;
+};
+typedef union cvmx_mio_fus_prog cvmx_mio_fus_prog_t;
+
+union cvmx_mio_fus_prog_times {
+	uint64_t u64;
+	struct cvmx_mio_fus_prog_times_s {
+		uint64_t reserved_33_63:31;
+		uint64_t prog_pin:1;
+		uint64_t out:8;
+		uint64_t sclk_lo:4;
+		uint64_t sclk_hi:12;
+		uint64_t setup:8;
+	} s;
+	struct cvmx_mio_fus_prog_times_s cn50xx;
+	struct cvmx_mio_fus_prog_times_s cn52xx;
+	struct cvmx_mio_fus_prog_times_s cn52xxp1;
+	struct cvmx_mio_fus_prog_times_s cn56xx;
+	struct cvmx_mio_fus_prog_times_s cn56xxp1;
+	struct cvmx_mio_fus_prog_times_s cn58xx;
+	struct cvmx_mio_fus_prog_times_s cn58xxp1;
+};
+typedef union cvmx_mio_fus_prog_times cvmx_mio_fus_prog_times_t;
+
+union cvmx_mio_fus_rcmd {
+	uint64_t u64;
+	struct cvmx_mio_fus_rcmd_s {
+		uint64_t reserved_24_63:40;
+		uint64_t dat:8;
+		uint64_t reserved_13_15:3;
+		uint64_t pend:1;
+		uint64_t reserved_9_11:3;
+		uint64_t efuse:1;
+		uint64_t addr:8;
+	} s;
+	struct cvmx_mio_fus_rcmd_cn30xx {
+		uint64_t reserved_24_63:40;
+		uint64_t dat:8;
+		uint64_t reserved_13_15:3;
+		uint64_t pend:1;
+		uint64_t reserved_9_11:3;
+		uint64_t efuse:1;
+		uint64_t reserved_7_7:1;
+		uint64_t addr:7;
+	} cn30xx;
+	struct cvmx_mio_fus_rcmd_cn30xx cn31xx;
+	struct cvmx_mio_fus_rcmd_cn30xx cn38xx;
+	struct cvmx_mio_fus_rcmd_cn30xx cn38xxp2;
+	struct cvmx_mio_fus_rcmd_cn30xx cn50xx;
+	struct cvmx_mio_fus_rcmd_s cn52xx;
+	struct cvmx_mio_fus_rcmd_s cn52xxp1;
+	struct cvmx_mio_fus_rcmd_s cn56xx;
+	struct cvmx_mio_fus_rcmd_s cn56xxp1;
+	struct cvmx_mio_fus_rcmd_cn30xx cn58xx;
+	struct cvmx_mio_fus_rcmd_cn30xx cn58xxp1;
+};
+typedef union cvmx_mio_fus_rcmd cvmx_mio_fus_rcmd_t;
+
+union cvmx_mio_fus_spr_repair_res {
+	uint64_t u64;
+	struct cvmx_mio_fus_spr_repair_res_s {
+		uint64_t reserved_42_63:22;
+		uint64_t repair2:14;
+		uint64_t repair1:14;
+		uint64_t repair0:14;
+	} s;
+	struct cvmx_mio_fus_spr_repair_res_s cn30xx;
+	struct cvmx_mio_fus_spr_repair_res_s cn31xx;
+	struct cvmx_mio_fus_spr_repair_res_s cn38xx;
+	struct cvmx_mio_fus_spr_repair_res_s cn50xx;
+	struct cvmx_mio_fus_spr_repair_res_s cn52xx;
+	struct cvmx_mio_fus_spr_repair_res_s cn52xxp1;
+	struct cvmx_mio_fus_spr_repair_res_s cn56xx;
+	struct cvmx_mio_fus_spr_repair_res_s cn56xxp1;
+	struct cvmx_mio_fus_spr_repair_res_s cn58xx;
+	struct cvmx_mio_fus_spr_repair_res_s cn58xxp1;
+};
+typedef union cvmx_mio_fus_spr_repair_res cvmx_mio_fus_spr_repair_res_t;
+
+union cvmx_mio_fus_spr_repair_sum {
+	uint64_t u64;
+	struct cvmx_mio_fus_spr_repair_sum_s {
+		uint64_t reserved_1_63:63;
+		uint64_t too_many:1;
+	} s;
+	struct cvmx_mio_fus_spr_repair_sum_s cn30xx;
+	struct cvmx_mio_fus_spr_repair_sum_s cn31xx;
+	struct cvmx_mio_fus_spr_repair_sum_s cn38xx;
+	struct cvmx_mio_fus_spr_repair_sum_s cn50xx;
+	struct cvmx_mio_fus_spr_repair_sum_s cn52xx;
+	struct cvmx_mio_fus_spr_repair_sum_s cn52xxp1;
+	struct cvmx_mio_fus_spr_repair_sum_s cn56xx;
+	struct cvmx_mio_fus_spr_repair_sum_s cn56xxp1;
+	struct cvmx_mio_fus_spr_repair_sum_s cn58xx;
+	struct cvmx_mio_fus_spr_repair_sum_s cn58xxp1;
+};
+typedef union cvmx_mio_fus_spr_repair_sum cvmx_mio_fus_spr_repair_sum_t;
+
+union cvmx_mio_fus_unlock {
+	uint64_t u64;
+	struct cvmx_mio_fus_unlock_s {
+		uint64_t reserved_24_63:40;
+		uint64_t key:24;
+	} s;
+	struct cvmx_mio_fus_unlock_s cn30xx;
+	struct cvmx_mio_fus_unlock_s cn31xx;
+};
+typedef union cvmx_mio_fus_unlock cvmx_mio_fus_unlock_t;
+
+union cvmx_mio_fus_wadr {
+	uint64_t u64;
+	struct cvmx_mio_fus_wadr_s {
+		uint64_t reserved_10_63:54;
+		uint64_t addr:10;
+	} s;
+	struct cvmx_mio_fus_wadr_s cn30xx;
+	struct cvmx_mio_fus_wadr_s cn31xx;
+	struct cvmx_mio_fus_wadr_s cn38xx;
+	struct cvmx_mio_fus_wadr_s cn38xxp2;
+	struct cvmx_mio_fus_wadr_cn50xx {
+		uint64_t reserved_2_63:62;
+		uint64_t addr:2;
+	} cn50xx;
+	struct cvmx_mio_fus_wadr_cn52xx {
+		uint64_t reserved_3_63:61;
+		uint64_t addr:3;
+	} cn52xx;
+	struct cvmx_mio_fus_wadr_cn52xx cn52xxp1;
+	struct cvmx_mio_fus_wadr_cn52xx cn56xx;
+	struct cvmx_mio_fus_wadr_cn52xx cn56xxp1;
+	struct cvmx_mio_fus_wadr_cn50xx cn58xx;
+	struct cvmx_mio_fus_wadr_cn50xx cn58xxp1;
+};
+typedef union cvmx_mio_fus_wadr cvmx_mio_fus_wadr_t;
+
+union cvmx_mio_ndf_dma_cfg {
+	uint64_t u64;
+	struct cvmx_mio_ndf_dma_cfg_s {
+		uint64_t en:1;
+		uint64_t rw:1;
+		uint64_t clr:1;
+		uint64_t reserved_60_60:1;
+		uint64_t swap32:1;
+		uint64_t swap16:1;
+		uint64_t swap8:1;
+		uint64_t endian:1;
+		uint64_t size:20;
+		uint64_t adr:36;
+	} s;
+	struct cvmx_mio_ndf_dma_cfg_s cn52xx;
+};
+typedef union cvmx_mio_ndf_dma_cfg cvmx_mio_ndf_dma_cfg_t;
+
+union cvmx_mio_ndf_dma_int {
+	uint64_t u64;
+	struct cvmx_mio_ndf_dma_int_s {
+		uint64_t reserved_1_63:63;
+		uint64_t done:1;
+	} s;
+	struct cvmx_mio_ndf_dma_int_s cn52xx;
+};
+typedef union cvmx_mio_ndf_dma_int cvmx_mio_ndf_dma_int_t;
+
+union cvmx_mio_ndf_dma_int_en {
+	uint64_t u64;
+	struct cvmx_mio_ndf_dma_int_en_s {
+		uint64_t reserved_1_63:63;
+		uint64_t done:1;
+	} s;
+	struct cvmx_mio_ndf_dma_int_en_s cn52xx;
+};
+typedef union cvmx_mio_ndf_dma_int_en cvmx_mio_ndf_dma_int_en_t;
+
+union cvmx_mio_pll_ctl {
+	uint64_t u64;
+	struct cvmx_mio_pll_ctl_s {
+		uint64_t reserved_5_63:59;
+		uint64_t bw_ctl:5;
+	} s;
+	struct cvmx_mio_pll_ctl_s cn30xx;
+	struct cvmx_mio_pll_ctl_s cn31xx;
+};
+typedef union cvmx_mio_pll_ctl cvmx_mio_pll_ctl_t;
+
+union cvmx_mio_pll_setting {
+	uint64_t u64;
+	struct cvmx_mio_pll_setting_s {
+		uint64_t reserved_17_63:47;
+		uint64_t setting:17;
+	} s;
+	struct cvmx_mio_pll_setting_s cn30xx;
+	struct cvmx_mio_pll_setting_s cn31xx;
+};
+typedef union cvmx_mio_pll_setting cvmx_mio_pll_setting_t;
+
+union cvmx_mio_twsx_int {
+	uint64_t u64;
+	struct cvmx_mio_twsx_int_s {
+		uint64_t reserved_12_63:52;
+		uint64_t scl:1;
+		uint64_t sda:1;
+		uint64_t scl_ovr:1;
+		uint64_t sda_ovr:1;
+		uint64_t reserved_7_7:1;
+		uint64_t core_en:1;
+		uint64_t ts_en:1;
+		uint64_t st_en:1;
+		uint64_t reserved_3_3:1;
+		uint64_t core_int:1;
+		uint64_t ts_int:1;
+		uint64_t st_int:1;
+	} s;
+	struct cvmx_mio_twsx_int_s cn30xx;
+	struct cvmx_mio_twsx_int_s cn31xx;
+	struct cvmx_mio_twsx_int_s cn38xx;
+	struct cvmx_mio_twsx_int_cn38xxp2 {
+		uint64_t reserved_7_63:57;
+		uint64_t core_en:1;
+		uint64_t ts_en:1;
+		uint64_t st_en:1;
+		uint64_t reserved_3_3:1;
+		uint64_t core_int:1;
+		uint64_t ts_int:1;
+		uint64_t st_int:1;
+	} cn38xxp2;
+	struct cvmx_mio_twsx_int_s cn50xx;
+	struct cvmx_mio_twsx_int_s cn52xx;
+	struct cvmx_mio_twsx_int_s cn52xxp1;
+	struct cvmx_mio_twsx_int_s cn56xx;
+	struct cvmx_mio_twsx_int_s cn56xxp1;
+	struct cvmx_mio_twsx_int_s cn58xx;
+	struct cvmx_mio_twsx_int_s cn58xxp1;
+};
+typedef union cvmx_mio_twsx_int cvmx_mio_twsx_int_t;
+
+union cvmx_mio_twsx_sw_twsi {
+	uint64_t u64;
+	struct cvmx_mio_twsx_sw_twsi_s {
+		uint64_t v:1;
+		uint64_t slonly:1;
+		uint64_t eia:1;
+		uint64_t op:4;
+		uint64_t r:1;
+		uint64_t sovr:1;
+		uint64_t size:3;
+		uint64_t scr:2;
+		uint64_t a:10;
+		uint64_t ia:5;
+		uint64_t eop_ia:3;
+		uint64_t d:32;
+	} s;
+	struct cvmx_mio_twsx_sw_twsi_s cn30xx;
+	struct cvmx_mio_twsx_sw_twsi_s cn31xx;
+	struct cvmx_mio_twsx_sw_twsi_s cn38xx;
+	struct cvmx_mio_twsx_sw_twsi_s cn38xxp2;
+	struct cvmx_mio_twsx_sw_twsi_s cn50xx;
+	struct cvmx_mio_twsx_sw_twsi_s cn52xx;
+	struct cvmx_mio_twsx_sw_twsi_s cn52xxp1;
+	struct cvmx_mio_twsx_sw_twsi_s cn56xx;
+	struct cvmx_mio_twsx_sw_twsi_s cn56xxp1;
+	struct cvmx_mio_twsx_sw_twsi_s cn58xx;
+	struct cvmx_mio_twsx_sw_twsi_s cn58xxp1;
+};
+typedef union cvmx_mio_twsx_sw_twsi cvmx_mio_twsx_sw_twsi_t;
+
+union cvmx_mio_twsx_sw_twsi_ext {
+	uint64_t u64;
+	struct cvmx_mio_twsx_sw_twsi_ext_s {
+		uint64_t reserved_40_63:24;
+		uint64_t ia:8;
+		uint64_t d:32;
+	} s;
+	struct cvmx_mio_twsx_sw_twsi_ext_s cn30xx;
+	struct cvmx_mio_twsx_sw_twsi_ext_s cn31xx;
+	struct cvmx_mio_twsx_sw_twsi_ext_s cn38xx;
+	struct cvmx_mio_twsx_sw_twsi_ext_s cn38xxp2;
+	struct cvmx_mio_twsx_sw_twsi_ext_s cn50xx;
+	struct cvmx_mio_twsx_sw_twsi_ext_s cn52xx;
+	struct cvmx_mio_twsx_sw_twsi_ext_s cn52xxp1;
+	struct cvmx_mio_twsx_sw_twsi_ext_s cn56xx;
+	struct cvmx_mio_twsx_sw_twsi_ext_s cn56xxp1;
+	struct cvmx_mio_twsx_sw_twsi_ext_s cn58xx;
+	struct cvmx_mio_twsx_sw_twsi_ext_s cn58xxp1;
+};
+typedef union cvmx_mio_twsx_sw_twsi_ext cvmx_mio_twsx_sw_twsi_ext_t;
+
+union cvmx_mio_twsx_twsi_sw {
+	uint64_t u64;
+	struct cvmx_mio_twsx_twsi_sw_s {
+		uint64_t v:2;
+		uint64_t reserved_32_61:30;
+		uint64_t d:32;
+	} s;
+	struct cvmx_mio_twsx_twsi_sw_s cn30xx;
+	struct cvmx_mio_twsx_twsi_sw_s cn31xx;
+	struct cvmx_mio_twsx_twsi_sw_s cn38xx;
+	struct cvmx_mio_twsx_twsi_sw_s cn38xxp2;
+	struct cvmx_mio_twsx_twsi_sw_s cn50xx;
+	struct cvmx_mio_twsx_twsi_sw_s cn52xx;
+	struct cvmx_mio_twsx_twsi_sw_s cn52xxp1;
+	struct cvmx_mio_twsx_twsi_sw_s cn56xx;
+	struct cvmx_mio_twsx_twsi_sw_s cn56xxp1;
+	struct cvmx_mio_twsx_twsi_sw_s cn58xx;
+	struct cvmx_mio_twsx_twsi_sw_s cn58xxp1;
+};
+typedef union cvmx_mio_twsx_twsi_sw cvmx_mio_twsx_twsi_sw_t;
+
+union cvmx_mio_uartx_dlh {
+	uint64_t u64;
+	struct cvmx_mio_uartx_dlh_s {
+		uint64_t reserved_8_63:56;
+		uint64_t dlh:8;
+	} s;
+	struct cvmx_mio_uartx_dlh_s cn30xx;
+	struct cvmx_mio_uartx_dlh_s cn31xx;
+	struct cvmx_mio_uartx_dlh_s cn38xx;
+	struct cvmx_mio_uartx_dlh_s cn38xxp2;
+	struct cvmx_mio_uartx_dlh_s cn50xx;
+	struct cvmx_mio_uartx_dlh_s cn52xx;
+	struct cvmx_mio_uartx_dlh_s cn52xxp1;
+	struct cvmx_mio_uartx_dlh_s cn56xx;
+	struct cvmx_mio_uartx_dlh_s cn56xxp1;
+	struct cvmx_mio_uartx_dlh_s cn58xx;
+	struct cvmx_mio_uartx_dlh_s cn58xxp1;
+};
+typedef union cvmx_mio_uartx_dlh cvmx_mio_uartx_dlh_t;
+typedef cvmx_mio_uartx_dlh_t cvmx_uart_dlh_t;
+
+union cvmx_mio_uartx_dll {
+	uint64_t u64;
+	struct cvmx_mio_uartx_dll_s {
+		uint64_t reserved_8_63:56;
+		uint64_t dll:8;
+	} s;
+	struct cvmx_mio_uartx_dll_s cn30xx;
+	struct cvmx_mio_uartx_dll_s cn31xx;
+	struct cvmx_mio_uartx_dll_s cn38xx;
+	struct cvmx_mio_uartx_dll_s cn38xxp2;
+	struct cvmx_mio_uartx_dll_s cn50xx;
+	struct cvmx_mio_uartx_dll_s cn52xx;
+	struct cvmx_mio_uartx_dll_s cn52xxp1;
+	struct cvmx_mio_uartx_dll_s cn56xx;
+	struct cvmx_mio_uartx_dll_s cn56xxp1;
+	struct cvmx_mio_uartx_dll_s cn58xx;
+	struct cvmx_mio_uartx_dll_s cn58xxp1;
+};
+typedef union cvmx_mio_uartx_dll cvmx_mio_uartx_dll_t;
+typedef cvmx_mio_uartx_dll_t cvmx_uart_dll_t;
+
+union cvmx_mio_uartx_far {
+	uint64_t u64;
+	struct cvmx_mio_uartx_far_s {
+		uint64_t reserved_1_63:63;
+		uint64_t far:1;
+	} s;
+	struct cvmx_mio_uartx_far_s cn30xx;
+	struct cvmx_mio_uartx_far_s cn31xx;
+	struct cvmx_mio_uartx_far_s cn38xx;
+	struct cvmx_mio_uartx_far_s cn38xxp2;
+	struct cvmx_mio_uartx_far_s cn50xx;
+	struct cvmx_mio_uartx_far_s cn52xx;
+	struct cvmx_mio_uartx_far_s cn52xxp1;
+	struct cvmx_mio_uartx_far_s cn56xx;
+	struct cvmx_mio_uartx_far_s cn56xxp1;
+	struct cvmx_mio_uartx_far_s cn58xx;
+	struct cvmx_mio_uartx_far_s cn58xxp1;
+};
+typedef union cvmx_mio_uartx_far cvmx_mio_uartx_far_t;
+typedef cvmx_mio_uartx_far_t cvmx_uart_far_t;
+
+union cvmx_mio_uartx_fcr {
+	uint64_t u64;
+	struct cvmx_mio_uartx_fcr_s {
+		uint64_t reserved_8_63:56;
+		uint64_t rxtrig:2;
+		uint64_t txtrig:2;
+		uint64_t reserved_3_3:1;
+		uint64_t txfr:1;
+		uint64_t rxfr:1;
+		uint64_t en:1;
+	} s;
+	struct cvmx_mio_uartx_fcr_s cn30xx;
+	struct cvmx_mio_uartx_fcr_s cn31xx;
+	struct cvmx_mio_uartx_fcr_s cn38xx;
+	struct cvmx_mio_uartx_fcr_s cn38xxp2;
+	struct cvmx_mio_uartx_fcr_s cn50xx;
+	struct cvmx_mio_uartx_fcr_s cn52xx;
+	struct cvmx_mio_uartx_fcr_s cn52xxp1;
+	struct cvmx_mio_uartx_fcr_s cn56xx;
+	struct cvmx_mio_uartx_fcr_s cn56xxp1;
+	struct cvmx_mio_uartx_fcr_s cn58xx;
+	struct cvmx_mio_uartx_fcr_s cn58xxp1;
+};
+typedef union cvmx_mio_uartx_fcr cvmx_mio_uartx_fcr_t;
+typedef cvmx_mio_uartx_fcr_t cvmx_uart_fcr_t;
+
+union cvmx_mio_uartx_htx {
+	uint64_t u64;
+	struct cvmx_mio_uartx_htx_s {
+		uint64_t reserved_1_63:63;
+		uint64_t htx:1;
+	} s;
+	struct cvmx_mio_uartx_htx_s cn30xx;
+	struct cvmx_mio_uartx_htx_s cn31xx;
+	struct cvmx_mio_uartx_htx_s cn38xx;
+	struct cvmx_mio_uartx_htx_s cn38xxp2;
+	struct cvmx_mio_uartx_htx_s cn50xx;
+	struct cvmx_mio_uartx_htx_s cn52xx;
+	struct cvmx_mio_uartx_htx_s cn52xxp1;
+	struct cvmx_mio_uartx_htx_s cn56xx;
+	struct cvmx_mio_uartx_htx_s cn56xxp1;
+	struct cvmx_mio_uartx_htx_s cn58xx;
+	struct cvmx_mio_uartx_htx_s cn58xxp1;
+};
+typedef union cvmx_mio_uartx_htx cvmx_mio_uartx_htx_t;
+typedef cvmx_mio_uartx_htx_t cvmx_uart_htx_t;
+
+union cvmx_mio_uartx_ier {
+	uint64_t u64;
+	struct cvmx_mio_uartx_ier_s {
+		uint64_t reserved_8_63:56;
+		uint64_t ptime:1;
+		uint64_t reserved_4_6:3;
+		uint64_t edssi:1;
+		uint64_t elsi:1;
+		uint64_t etbei:1;
+		uint64_t erbfi:1;
+	} s;
+	struct cvmx_mio_uartx_ier_s cn30xx;
+	struct cvmx_mio_uartx_ier_s cn31xx;
+	struct cvmx_mio_uartx_ier_s cn38xx;
+	struct cvmx_mio_uartx_ier_s cn38xxp2;
+	struct cvmx_mio_uartx_ier_s cn50xx;
+	struct cvmx_mio_uartx_ier_s cn52xx;
+	struct cvmx_mio_uartx_ier_s cn52xxp1;
+	struct cvmx_mio_uartx_ier_s cn56xx;
+	struct cvmx_mio_uartx_ier_s cn56xxp1;
+	struct cvmx_mio_uartx_ier_s cn58xx;
+	struct cvmx_mio_uartx_ier_s cn58xxp1;
+};
+typedef union cvmx_mio_uartx_ier cvmx_mio_uartx_ier_t;
+typedef cvmx_mio_uartx_ier_t cvmx_uart_ier_t;
+
+union cvmx_mio_uartx_iir {
+	uint64_t u64;
+	struct cvmx_mio_uartx_iir_s {
+		uint64_t reserved_8_63:56;
+		uint64_t fen:2;
+		uint64_t reserved_4_5:2;
+		uint64_t iid:4;
+	} s;
+	struct cvmx_mio_uartx_iir_s cn30xx;
+	struct cvmx_mio_uartx_iir_s cn31xx;
+	struct cvmx_mio_uartx_iir_s cn38xx;
+	struct cvmx_mio_uartx_iir_s cn38xxp2;
+	struct cvmx_mio_uartx_iir_s cn50xx;
+	struct cvmx_mio_uartx_iir_s cn52xx;
+	struct cvmx_mio_uartx_iir_s cn52xxp1;
+	struct cvmx_mio_uartx_iir_s cn56xx;
+	struct cvmx_mio_uartx_iir_s cn56xxp1;
+	struct cvmx_mio_uartx_iir_s cn58xx;
+	struct cvmx_mio_uartx_iir_s cn58xxp1;
+};
+typedef union cvmx_mio_uartx_iir cvmx_mio_uartx_iir_t;
+typedef cvmx_mio_uartx_iir_t cvmx_uart_iir_t;
+
+union cvmx_mio_uartx_lcr {
+	uint64_t u64;
+	struct cvmx_mio_uartx_lcr_s {
+		uint64_t reserved_8_63:56;
+		uint64_t dlab:1;
+		uint64_t brk:1;
+		uint64_t reserved_5_5:1;
+		uint64_t eps:1;
+		uint64_t pen:1;
+		uint64_t stop:1;
+		uint64_t cls:2;
+	} s;
+	struct cvmx_mio_uartx_lcr_s cn30xx;
+	struct cvmx_mio_uartx_lcr_s cn31xx;
+	struct cvmx_mio_uartx_lcr_s cn38xx;
+	struct cvmx_mio_uartx_lcr_s cn38xxp2;
+	struct cvmx_mio_uartx_lcr_s cn50xx;
+	struct cvmx_mio_uartx_lcr_s cn52xx;
+	struct cvmx_mio_uartx_lcr_s cn52xxp1;
+	struct cvmx_mio_uartx_lcr_s cn56xx;
+	struct cvmx_mio_uartx_lcr_s cn56xxp1;
+	struct cvmx_mio_uartx_lcr_s cn58xx;
+	struct cvmx_mio_uartx_lcr_s cn58xxp1;
+};
+typedef union cvmx_mio_uartx_lcr cvmx_mio_uartx_lcr_t;
+typedef cvmx_mio_uartx_lcr_t cvmx_uart_lcr_t;
+
+union cvmx_mio_uartx_lsr {
+	uint64_t u64;
+	struct cvmx_mio_uartx_lsr_s {
+		uint64_t reserved_8_63:56;
+		uint64_t ferr:1;
+		uint64_t temt:1;
+		uint64_t thre:1;
+		uint64_t bi:1;
+		uint64_t fe:1;
+		uint64_t pe:1;
+		uint64_t oe:1;
+		uint64_t dr:1;
+	} s;
+	struct cvmx_mio_uartx_lsr_s cn30xx;
+	struct cvmx_mio_uartx_lsr_s cn31xx;
+	struct cvmx_mio_uartx_lsr_s cn38xx;
+	struct cvmx_mio_uartx_lsr_s cn38xxp2;
+	struct cvmx_mio_uartx_lsr_s cn50xx;
+	struct cvmx_mio_uartx_lsr_s cn52xx;
+	struct cvmx_mio_uartx_lsr_s cn52xxp1;
+	struct cvmx_mio_uartx_lsr_s cn56xx;
+	struct cvmx_mio_uartx_lsr_s cn56xxp1;
+	struct cvmx_mio_uartx_lsr_s cn58xx;
+	struct cvmx_mio_uartx_lsr_s cn58xxp1;
+};
+typedef union cvmx_mio_uartx_lsr cvmx_mio_uartx_lsr_t;
+typedef cvmx_mio_uartx_lsr_t cvmx_uart_lsr_t;
+
+union cvmx_mio_uartx_mcr {
+	uint64_t u64;
+	struct cvmx_mio_uartx_mcr_s {
+		uint64_t reserved_6_63:58;
+		uint64_t afce:1;
+		uint64_t loop:1;
+		uint64_t out2:1;
+		uint64_t out1:1;
+		uint64_t rts:1;
+		uint64_t dtr:1;
+	} s;
+	struct cvmx_mio_uartx_mcr_s cn30xx;
+	struct cvmx_mio_uartx_mcr_s cn31xx;
+	struct cvmx_mio_uartx_mcr_s cn38xx;
+	struct cvmx_mio_uartx_mcr_s cn38xxp2;
+	struct cvmx_mio_uartx_mcr_s cn50xx;
+	struct cvmx_mio_uartx_mcr_s cn52xx;
+	struct cvmx_mio_uartx_mcr_s cn52xxp1;
+	struct cvmx_mio_uartx_mcr_s cn56xx;
+	struct cvmx_mio_uartx_mcr_s cn56xxp1;
+	struct cvmx_mio_uartx_mcr_s cn58xx;
+	struct cvmx_mio_uartx_mcr_s cn58xxp1;
+};
+typedef union cvmx_mio_uartx_mcr cvmx_mio_uartx_mcr_t;
+typedef cvmx_mio_uartx_mcr_t cvmx_uart_mcr_t;
+
+union cvmx_mio_uartx_msr {
+	uint64_t u64;
+	struct cvmx_mio_uartx_msr_s {
+		uint64_t reserved_8_63:56;
+		uint64_t dcd:1;
+		uint64_t ri:1;
+		uint64_t dsr:1;
+		uint64_t cts:1;
+		uint64_t ddcd:1;
+		uint64_t teri:1;
+		uint64_t ddsr:1;
+		uint64_t dcts:1;
+	} s;
+	struct cvmx_mio_uartx_msr_s cn30xx;
+	struct cvmx_mio_uartx_msr_s cn31xx;
+	struct cvmx_mio_uartx_msr_s cn38xx;
+	struct cvmx_mio_uartx_msr_s cn38xxp2;
+	struct cvmx_mio_uartx_msr_s cn50xx;
+	struct cvmx_mio_uartx_msr_s cn52xx;
+	struct cvmx_mio_uartx_msr_s cn52xxp1;
+	struct cvmx_mio_uartx_msr_s cn56xx;
+	struct cvmx_mio_uartx_msr_s cn56xxp1;
+	struct cvmx_mio_uartx_msr_s cn58xx;
+	struct cvmx_mio_uartx_msr_s cn58xxp1;
+};
+typedef union cvmx_mio_uartx_msr cvmx_mio_uartx_msr_t;
+typedef cvmx_mio_uartx_msr_t cvmx_uart_msr_t;
+
+union cvmx_mio_uartx_rbr {
+	uint64_t u64;
+	struct cvmx_mio_uartx_rbr_s {
+		uint64_t reserved_8_63:56;
+		uint64_t rbr:8;
+	} s;
+	struct cvmx_mio_uartx_rbr_s cn30xx;
+	struct cvmx_mio_uartx_rbr_s cn31xx;
+	struct cvmx_mio_uartx_rbr_s cn38xx;
+	struct cvmx_mio_uartx_rbr_s cn38xxp2;
+	struct cvmx_mio_uartx_rbr_s cn50xx;
+	struct cvmx_mio_uartx_rbr_s cn52xx;
+	struct cvmx_mio_uartx_rbr_s cn52xxp1;
+	struct cvmx_mio_uartx_rbr_s cn56xx;
+	struct cvmx_mio_uartx_rbr_s cn56xxp1;
+	struct cvmx_mio_uartx_rbr_s cn58xx;
+	struct cvmx_mio_uartx_rbr_s cn58xxp1;
+};
+typedef union cvmx_mio_uartx_rbr cvmx_mio_uartx_rbr_t;
+typedef cvmx_mio_uartx_rbr_t cvmx_uart_rbr_t;
+
+union cvmx_mio_uartx_rfl {
+	uint64_t u64;
+	struct cvmx_mio_uartx_rfl_s {
+		uint64_t reserved_7_63:57;
+		uint64_t rfl:7;
+	} s;
+	struct cvmx_mio_uartx_rfl_s cn30xx;
+	struct cvmx_mio_uartx_rfl_s cn31xx;
+	struct cvmx_mio_uartx_rfl_s cn38xx;
+	struct cvmx_mio_uartx_rfl_s cn38xxp2;
+	struct cvmx_mio_uartx_rfl_s cn50xx;
+	struct cvmx_mio_uartx_rfl_s cn52xx;
+	struct cvmx_mio_uartx_rfl_s cn52xxp1;
+	struct cvmx_mio_uartx_rfl_s cn56xx;
+	struct cvmx_mio_uartx_rfl_s cn56xxp1;
+	struct cvmx_mio_uartx_rfl_s cn58xx;
+	struct cvmx_mio_uartx_rfl_s cn58xxp1;
+};
+typedef union cvmx_mio_uartx_rfl cvmx_mio_uartx_rfl_t;
+typedef cvmx_mio_uartx_rfl_t cvmx_uart_rfl_t;
+
+union cvmx_mio_uartx_rfw {
+	uint64_t u64;
+	struct cvmx_mio_uartx_rfw_s {
+		uint64_t reserved_10_63:54;
+		uint64_t rffe:1;
+		uint64_t rfpe:1;
+		uint64_t rfwd:8;
+	} s;
+	struct cvmx_mio_uartx_rfw_s cn30xx;
+	struct cvmx_mio_uartx_rfw_s cn31xx;
+	struct cvmx_mio_uartx_rfw_s cn38xx;
+	struct cvmx_mio_uartx_rfw_s cn38xxp2;
+	struct cvmx_mio_uartx_rfw_s cn50xx;
+	struct cvmx_mio_uartx_rfw_s cn52xx;
+	struct cvmx_mio_uartx_rfw_s cn52xxp1;
+	struct cvmx_mio_uartx_rfw_s cn56xx;
+	struct cvmx_mio_uartx_rfw_s cn56xxp1;
+	struct cvmx_mio_uartx_rfw_s cn58xx;
+	struct cvmx_mio_uartx_rfw_s cn58xxp1;
+};
+typedef union cvmx_mio_uartx_rfw cvmx_mio_uartx_rfw_t;
+typedef cvmx_mio_uartx_rfw_t cvmx_uart_rfw_t;
+
+union cvmx_mio_uartx_sbcr {
+	uint64_t u64;
+	struct cvmx_mio_uartx_sbcr_s {
+		uint64_t reserved_1_63:63;
+		uint64_t sbcr:1;
+	} s;
+	struct cvmx_mio_uartx_sbcr_s cn30xx;
+	struct cvmx_mio_uartx_sbcr_s cn31xx;
+	struct cvmx_mio_uartx_sbcr_s cn38xx;
+	struct cvmx_mio_uartx_sbcr_s cn38xxp2;
+	struct cvmx_mio_uartx_sbcr_s cn50xx;
+	struct cvmx_mio_uartx_sbcr_s cn52xx;
+	struct cvmx_mio_uartx_sbcr_s cn52xxp1;
+	struct cvmx_mio_uartx_sbcr_s cn56xx;
+	struct cvmx_mio_uartx_sbcr_s cn56xxp1;
+	struct cvmx_mio_uartx_sbcr_s cn58xx;
+	struct cvmx_mio_uartx_sbcr_s cn58xxp1;
+};
+typedef union cvmx_mio_uartx_sbcr cvmx_mio_uartx_sbcr_t;
+typedef cvmx_mio_uartx_sbcr_t cvmx_uart_sbcr_t;
+
+union cvmx_mio_uartx_scr {
+	uint64_t u64;
+	struct cvmx_mio_uartx_scr_s {
+		uint64_t reserved_8_63:56;
+		uint64_t scr:8;
+	} s;
+	struct cvmx_mio_uartx_scr_s cn30xx;
+	struct cvmx_mio_uartx_scr_s cn31xx;
+	struct cvmx_mio_uartx_scr_s cn38xx;
+	struct cvmx_mio_uartx_scr_s cn38xxp2;
+	struct cvmx_mio_uartx_scr_s cn50xx;
+	struct cvmx_mio_uartx_scr_s cn52xx;
+	struct cvmx_mio_uartx_scr_s cn52xxp1;
+	struct cvmx_mio_uartx_scr_s cn56xx;
+	struct cvmx_mio_uartx_scr_s cn56xxp1;
+	struct cvmx_mio_uartx_scr_s cn58xx;
+	struct cvmx_mio_uartx_scr_s cn58xxp1;
+};
+typedef union cvmx_mio_uartx_scr cvmx_mio_uartx_scr_t;
+typedef cvmx_mio_uartx_scr_t cvmx_uart_scr_t;
+
+union cvmx_mio_uartx_sfe {
+	uint64_t u64;
+	struct cvmx_mio_uartx_sfe_s {
+		uint64_t reserved_1_63:63;
+		uint64_t sfe:1;
+	} s;
+	struct cvmx_mio_uartx_sfe_s cn30xx;
+	struct cvmx_mio_uartx_sfe_s cn31xx;
+	struct cvmx_mio_uartx_sfe_s cn38xx;
+	struct cvmx_mio_uartx_sfe_s cn38xxp2;
+	struct cvmx_mio_uartx_sfe_s cn50xx;
+	struct cvmx_mio_uartx_sfe_s cn52xx;
+	struct cvmx_mio_uartx_sfe_s cn52xxp1;
+	struct cvmx_mio_uartx_sfe_s cn56xx;
+	struct cvmx_mio_uartx_sfe_s cn56xxp1;
+	struct cvmx_mio_uartx_sfe_s cn58xx;
+	struct cvmx_mio_uartx_sfe_s cn58xxp1;
+};
+typedef union cvmx_mio_uartx_sfe cvmx_mio_uartx_sfe_t;
+typedef cvmx_mio_uartx_sfe_t cvmx_uart_sfe_t;
+
+union cvmx_mio_uartx_srr {
+	uint64_t u64;
+	struct cvmx_mio_uartx_srr_s {
+		uint64_t reserved_3_63:61;
+		uint64_t stfr:1;
+		uint64_t srfr:1;
+		uint64_t usr:1;
+	} s;
+	struct cvmx_mio_uartx_srr_s cn30xx;
+	struct cvmx_mio_uartx_srr_s cn31xx;
+	struct cvmx_mio_uartx_srr_s cn38xx;
+	struct cvmx_mio_uartx_srr_s cn38xxp2;
+	struct cvmx_mio_uartx_srr_s cn50xx;
+	struct cvmx_mio_uartx_srr_s cn52xx;
+	struct cvmx_mio_uartx_srr_s cn52xxp1;
+	struct cvmx_mio_uartx_srr_s cn56xx;
+	struct cvmx_mio_uartx_srr_s cn56xxp1;
+	struct cvmx_mio_uartx_srr_s cn58xx;
+	struct cvmx_mio_uartx_srr_s cn58xxp1;
+};
+typedef union cvmx_mio_uartx_srr cvmx_mio_uartx_srr_t;
+typedef cvmx_mio_uartx_srr_t cvmx_uart_srr_t;
+
+union cvmx_mio_uartx_srt {
+	uint64_t u64;
+	struct cvmx_mio_uartx_srt_s {
+		uint64_t reserved_2_63:62;
+		uint64_t srt:2;
+	} s;
+	struct cvmx_mio_uartx_srt_s cn30xx;
+	struct cvmx_mio_uartx_srt_s cn31xx;
+	struct cvmx_mio_uartx_srt_s cn38xx;
+	struct cvmx_mio_uartx_srt_s cn38xxp2;
+	struct cvmx_mio_uartx_srt_s cn50xx;
+	struct cvmx_mio_uartx_srt_s cn52xx;
+	struct cvmx_mio_uartx_srt_s cn52xxp1;
+	struct cvmx_mio_uartx_srt_s cn56xx;
+	struct cvmx_mio_uartx_srt_s cn56xxp1;
+	struct cvmx_mio_uartx_srt_s cn58xx;
+	struct cvmx_mio_uartx_srt_s cn58xxp1;
+};
+typedef union cvmx_mio_uartx_srt cvmx_mio_uartx_srt_t;
+typedef cvmx_mio_uartx_srt_t cvmx_uart_srt_t;
+
+union cvmx_mio_uartx_srts {
+	uint64_t u64;
+	struct cvmx_mio_uartx_srts_s {
+		uint64_t reserved_1_63:63;
+		uint64_t srts:1;
+	} s;
+	struct cvmx_mio_uartx_srts_s cn30xx;
+	struct cvmx_mio_uartx_srts_s cn31xx;
+	struct cvmx_mio_uartx_srts_s cn38xx;
+	struct cvmx_mio_uartx_srts_s cn38xxp2;
+	struct cvmx_mio_uartx_srts_s cn50xx;
+	struct cvmx_mio_uartx_srts_s cn52xx;
+	struct cvmx_mio_uartx_srts_s cn52xxp1;
+	struct cvmx_mio_uartx_srts_s cn56xx;
+	struct cvmx_mio_uartx_srts_s cn56xxp1;
+	struct cvmx_mio_uartx_srts_s cn58xx;
+	struct cvmx_mio_uartx_srts_s cn58xxp1;
+};
+typedef union cvmx_mio_uartx_srts cvmx_mio_uartx_srts_t;
+typedef cvmx_mio_uartx_srts_t cvmx_uart_srts_t;
+
+union cvmx_mio_uartx_stt {
+	uint64_t u64;
+	struct cvmx_mio_uartx_stt_s {
+		uint64_t reserved_2_63:62;
+		uint64_t stt:2;
+	} s;
+	struct cvmx_mio_uartx_stt_s cn30xx;
+	struct cvmx_mio_uartx_stt_s cn31xx;
+	struct cvmx_mio_uartx_stt_s cn38xx;
+	struct cvmx_mio_uartx_stt_s cn38xxp2;
+	struct cvmx_mio_uartx_stt_s cn50xx;
+	struct cvmx_mio_uartx_stt_s cn52xx;
+	struct cvmx_mio_uartx_stt_s cn52xxp1;
+	struct cvmx_mio_uartx_stt_s cn56xx;
+	struct cvmx_mio_uartx_stt_s cn56xxp1;
+	struct cvmx_mio_uartx_stt_s cn58xx;
+	struct cvmx_mio_uartx_stt_s cn58xxp1;
+};
+typedef union cvmx_mio_uartx_stt cvmx_mio_uartx_stt_t;
+typedef cvmx_mio_uartx_stt_t cvmx_uart_stt_t;
+
+union cvmx_mio_uartx_tfl {
+	uint64_t u64;
+	struct cvmx_mio_uartx_tfl_s {
+		uint64_t reserved_7_63:57;
+		uint64_t tfl:7;
+	} s;
+	struct cvmx_mio_uartx_tfl_s cn30xx;
+	struct cvmx_mio_uartx_tfl_s cn31xx;
+	struct cvmx_mio_uartx_tfl_s cn38xx;
+	struct cvmx_mio_uartx_tfl_s cn38xxp2;
+	struct cvmx_mio_uartx_tfl_s cn50xx;
+	struct cvmx_mio_uartx_tfl_s cn52xx;
+	struct cvmx_mio_uartx_tfl_s cn52xxp1;
+	struct cvmx_mio_uartx_tfl_s cn56xx;
+	struct cvmx_mio_uartx_tfl_s cn56xxp1;
+	struct cvmx_mio_uartx_tfl_s cn58xx;
+	struct cvmx_mio_uartx_tfl_s cn58xxp1;
+};
+typedef union cvmx_mio_uartx_tfl cvmx_mio_uartx_tfl_t;
+typedef cvmx_mio_uartx_tfl_t cvmx_uart_tfl_t;
+
+union cvmx_mio_uartx_tfr {
+	uint64_t u64;
+	struct cvmx_mio_uartx_tfr_s {
+		uint64_t reserved_8_63:56;
+		uint64_t tfr:8;
+	} s;
+	struct cvmx_mio_uartx_tfr_s cn30xx;
+	struct cvmx_mio_uartx_tfr_s cn31xx;
+	struct cvmx_mio_uartx_tfr_s cn38xx;
+	struct cvmx_mio_uartx_tfr_s cn38xxp2;
+	struct cvmx_mio_uartx_tfr_s cn50xx;
+	struct cvmx_mio_uartx_tfr_s cn52xx;
+	struct cvmx_mio_uartx_tfr_s cn52xxp1;
+	struct cvmx_mio_uartx_tfr_s cn56xx;
+	struct cvmx_mio_uartx_tfr_s cn56xxp1;
+	struct cvmx_mio_uartx_tfr_s cn58xx;
+	struct cvmx_mio_uartx_tfr_s cn58xxp1;
+};
+typedef union cvmx_mio_uartx_tfr cvmx_mio_uartx_tfr_t;
+typedef cvmx_mio_uartx_tfr_t cvmx_uart_tfr_t;
+
+union cvmx_mio_uartx_thr {
+	uint64_t u64;
+	struct cvmx_mio_uartx_thr_s {
+		uint64_t reserved_8_63:56;
+		uint64_t thr:8;
+	} s;
+	struct cvmx_mio_uartx_thr_s cn30xx;
+	struct cvmx_mio_uartx_thr_s cn31xx;
+	struct cvmx_mio_uartx_thr_s cn38xx;
+	struct cvmx_mio_uartx_thr_s cn38xxp2;
+	struct cvmx_mio_uartx_thr_s cn50xx;
+	struct cvmx_mio_uartx_thr_s cn52xx;
+	struct cvmx_mio_uartx_thr_s cn52xxp1;
+	struct cvmx_mio_uartx_thr_s cn56xx;
+	struct cvmx_mio_uartx_thr_s cn56xxp1;
+	struct cvmx_mio_uartx_thr_s cn58xx;
+	struct cvmx_mio_uartx_thr_s cn58xxp1;
+};
+typedef union cvmx_mio_uartx_thr cvmx_mio_uartx_thr_t;
+typedef cvmx_mio_uartx_thr_t cvmx_uart_thr_t;
+
+union cvmx_mio_uartx_usr {
+	uint64_t u64;
+	struct cvmx_mio_uartx_usr_s {
+		uint64_t reserved_5_63:59;
+		uint64_t rff:1;
+		uint64_t rfne:1;
+		uint64_t tfe:1;
+		uint64_t tfnf:1;
+		uint64_t busy:1;
+	} s;
+	struct cvmx_mio_uartx_usr_s cn30xx;
+	struct cvmx_mio_uartx_usr_s cn31xx;
+	struct cvmx_mio_uartx_usr_s cn38xx;
+	struct cvmx_mio_uartx_usr_s cn38xxp2;
+	struct cvmx_mio_uartx_usr_s cn50xx;
+	struct cvmx_mio_uartx_usr_s cn52xx;
+	struct cvmx_mio_uartx_usr_s cn52xxp1;
+	struct cvmx_mio_uartx_usr_s cn56xx;
+	struct cvmx_mio_uartx_usr_s cn56xxp1;
+	struct cvmx_mio_uartx_usr_s cn58xx;
+	struct cvmx_mio_uartx_usr_s cn58xxp1;
+};
+typedef union cvmx_mio_uartx_usr cvmx_mio_uartx_usr_t;
+typedef cvmx_mio_uartx_usr_t cvmx_uart_usr_t;
+
+union cvmx_mio_uart2_dlh {
+	uint64_t u64;
+	struct cvmx_mio_uart2_dlh_s {
+		uint64_t reserved_8_63:56;
+		uint64_t dlh:8;
+	} s;
+	struct cvmx_mio_uart2_dlh_s cn52xx;
+	struct cvmx_mio_uart2_dlh_s cn52xxp1;
+};
+typedef union cvmx_mio_uart2_dlh cvmx_mio_uart2_dlh_t;
+
+union cvmx_mio_uart2_dll {
+	uint64_t u64;
+	struct cvmx_mio_uart2_dll_s {
+		uint64_t reserved_8_63:56;
+		uint64_t dll:8;
+	} s;
+	struct cvmx_mio_uart2_dll_s cn52xx;
+	struct cvmx_mio_uart2_dll_s cn52xxp1;
+};
+typedef union cvmx_mio_uart2_dll cvmx_mio_uart2_dll_t;
+
+union cvmx_mio_uart2_far {
+	uint64_t u64;
+	struct cvmx_mio_uart2_far_s {
+		uint64_t reserved_1_63:63;
+		uint64_t far:1;
+	} s;
+	struct cvmx_mio_uart2_far_s cn52xx;
+	struct cvmx_mio_uart2_far_s cn52xxp1;
+};
+typedef union cvmx_mio_uart2_far cvmx_mio_uart2_far_t;
+
+union cvmx_mio_uart2_fcr {
+	uint64_t u64;
+	struct cvmx_mio_uart2_fcr_s {
+		uint64_t reserved_8_63:56;
+		uint64_t rxtrig:2;
+		uint64_t txtrig:2;
+		uint64_t reserved_3_3:1;
+		uint64_t txfr:1;
+		uint64_t rxfr:1;
+		uint64_t en:1;
+	} s;
+	struct cvmx_mio_uart2_fcr_s cn52xx;
+	struct cvmx_mio_uart2_fcr_s cn52xxp1;
+};
+typedef union cvmx_mio_uart2_fcr cvmx_mio_uart2_fcr_t;
+
+union cvmx_mio_uart2_htx {
+	uint64_t u64;
+	struct cvmx_mio_uart2_htx_s {
+		uint64_t reserved_1_63:63;
+		uint64_t htx:1;
+	} s;
+	struct cvmx_mio_uart2_htx_s cn52xx;
+	struct cvmx_mio_uart2_htx_s cn52xxp1;
+};
+typedef union cvmx_mio_uart2_htx cvmx_mio_uart2_htx_t;
+
+union cvmx_mio_uart2_ier {
+	uint64_t u64;
+	struct cvmx_mio_uart2_ier_s {
+		uint64_t reserved_8_63:56;
+		uint64_t ptime:1;
+		uint64_t reserved_4_6:3;
+		uint64_t edssi:1;
+		uint64_t elsi:1;
+		uint64_t etbei:1;
+		uint64_t erbfi:1;
+	} s;
+	struct cvmx_mio_uart2_ier_s cn52xx;
+	struct cvmx_mio_uart2_ier_s cn52xxp1;
+};
+typedef union cvmx_mio_uart2_ier cvmx_mio_uart2_ier_t;
+
+union cvmx_mio_uart2_iir {
+	uint64_t u64;
+	struct cvmx_mio_uart2_iir_s {
+		uint64_t reserved_8_63:56;
+		uint64_t fen:2;
+		uint64_t reserved_4_5:2;
+		uint64_t iid:4;
+	} s;
+	struct cvmx_mio_uart2_iir_s cn52xx;
+	struct cvmx_mio_uart2_iir_s cn52xxp1;
+};
+typedef union cvmx_mio_uart2_iir cvmx_mio_uart2_iir_t;
+
+union cvmx_mio_uart2_lcr {
+	uint64_t u64;
+	struct cvmx_mio_uart2_lcr_s {
+		uint64_t reserved_8_63:56;
+		uint64_t dlab:1;
+		uint64_t brk:1;
+		uint64_t reserved_5_5:1;
+		uint64_t eps:1;
+		uint64_t pen:1;
+		uint64_t stop:1;
+		uint64_t cls:2;
+	} s;
+	struct cvmx_mio_uart2_lcr_s cn52xx;
+	struct cvmx_mio_uart2_lcr_s cn52xxp1;
+};
+typedef union cvmx_mio_uart2_lcr cvmx_mio_uart2_lcr_t;
+
+union cvmx_mio_uart2_lsr {
+	uint64_t u64;
+	struct cvmx_mio_uart2_lsr_s {
+		uint64_t reserved_8_63:56;
+		uint64_t ferr:1;
+		uint64_t temt:1;
+		uint64_t thre:1;
+		uint64_t bi:1;
+		uint64_t fe:1;
+		uint64_t pe:1;
+		uint64_t oe:1;
+		uint64_t dr:1;
+	} s;
+	struct cvmx_mio_uart2_lsr_s cn52xx;
+	struct cvmx_mio_uart2_lsr_s cn52xxp1;
+};
+typedef union cvmx_mio_uart2_lsr cvmx_mio_uart2_lsr_t;
+
+union cvmx_mio_uart2_mcr {
+	uint64_t u64;
+	struct cvmx_mio_uart2_mcr_s {
+		uint64_t reserved_6_63:58;
+		uint64_t afce:1;
+		uint64_t loop:1;
+		uint64_t out2:1;
+		uint64_t out1:1;
+		uint64_t rts:1;
+		uint64_t dtr:1;
+	} s;
+	struct cvmx_mio_uart2_mcr_s cn52xx;
+	struct cvmx_mio_uart2_mcr_s cn52xxp1;
+};
+typedef union cvmx_mio_uart2_mcr cvmx_mio_uart2_mcr_t;
+
+union cvmx_mio_uart2_msr {
+	uint64_t u64;
+	struct cvmx_mio_uart2_msr_s {
+		uint64_t reserved_8_63:56;
+		uint64_t dcd:1;
+		uint64_t ri:1;
+		uint64_t dsr:1;
+		uint64_t cts:1;
+		uint64_t ddcd:1;
+		uint64_t teri:1;
+		uint64_t ddsr:1;
+		uint64_t dcts:1;
+	} s;
+	struct cvmx_mio_uart2_msr_s cn52xx;
+	struct cvmx_mio_uart2_msr_s cn52xxp1;
+};
+typedef union cvmx_mio_uart2_msr cvmx_mio_uart2_msr_t;
+
+union cvmx_mio_uart2_rbr {
+	uint64_t u64;
+	struct cvmx_mio_uart2_rbr_s {
+		uint64_t reserved_8_63:56;
+		uint64_t rbr:8;
+	} s;
+	struct cvmx_mio_uart2_rbr_s cn52xx;
+	struct cvmx_mio_uart2_rbr_s cn52xxp1;
+};
+typedef union cvmx_mio_uart2_rbr cvmx_mio_uart2_rbr_t;
+
+union cvmx_mio_uart2_rfl {
+	uint64_t u64;
+	struct cvmx_mio_uart2_rfl_s {
+		uint64_t reserved_7_63:57;
+		uint64_t rfl:7;
+	} s;
+	struct cvmx_mio_uart2_rfl_s cn52xx;
+	struct cvmx_mio_uart2_rfl_s cn52xxp1;
+};
+typedef union cvmx_mio_uart2_rfl cvmx_mio_uart2_rfl_t;
+
+union cvmx_mio_uart2_rfw {
+	uint64_t u64;
+	struct cvmx_mio_uart2_rfw_s {
+		uint64_t reserved_10_63:54;
+		uint64_t rffe:1;
+		uint64_t rfpe:1;
+		uint64_t rfwd:8;
+	} s;
+	struct cvmx_mio_uart2_rfw_s cn52xx;
+	struct cvmx_mio_uart2_rfw_s cn52xxp1;
+};
+typedef union cvmx_mio_uart2_rfw cvmx_mio_uart2_rfw_t;
+
+union cvmx_mio_uart2_sbcr {
+	uint64_t u64;
+	struct cvmx_mio_uart2_sbcr_s {
+		uint64_t reserved_1_63:63;
+		uint64_t sbcr:1;
+	} s;
+	struct cvmx_mio_uart2_sbcr_s cn52xx;
+	struct cvmx_mio_uart2_sbcr_s cn52xxp1;
+};
+typedef union cvmx_mio_uart2_sbcr cvmx_mio_uart2_sbcr_t;
+
+union cvmx_mio_uart2_scr {
+	uint64_t u64;
+	struct cvmx_mio_uart2_scr_s {
+		uint64_t reserved_8_63:56;
+		uint64_t scr:8;
+	} s;
+	struct cvmx_mio_uart2_scr_s cn52xx;
+	struct cvmx_mio_uart2_scr_s cn52xxp1;
+};
+typedef union cvmx_mio_uart2_scr cvmx_mio_uart2_scr_t;
+
+union cvmx_mio_uart2_sfe {
+	uint64_t u64;
+	struct cvmx_mio_uart2_sfe_s {
+		uint64_t reserved_1_63:63;
+		uint64_t sfe:1;
+	} s;
+	struct cvmx_mio_uart2_sfe_s cn52xx;
+	struct cvmx_mio_uart2_sfe_s cn52xxp1;
+};
+typedef union cvmx_mio_uart2_sfe cvmx_mio_uart2_sfe_t;
+
+union cvmx_mio_uart2_srr {
+	uint64_t u64;
+	struct cvmx_mio_uart2_srr_s {
+		uint64_t reserved_3_63:61;
+		uint64_t stfr:1;
+		uint64_t srfr:1;
+		uint64_t usr:1;
+	} s;
+	struct cvmx_mio_uart2_srr_s cn52xx;
+	struct cvmx_mio_uart2_srr_s cn52xxp1;
+};
+typedef union cvmx_mio_uart2_srr cvmx_mio_uart2_srr_t;
+
+union cvmx_mio_uart2_srt {
+	uint64_t u64;
+	struct cvmx_mio_uart2_srt_s {
+		uint64_t reserved_2_63:62;
+		uint64_t srt:2;
+	} s;
+	struct cvmx_mio_uart2_srt_s cn52xx;
+	struct cvmx_mio_uart2_srt_s cn52xxp1;
+};
+typedef union cvmx_mio_uart2_srt cvmx_mio_uart2_srt_t;
+
+union cvmx_mio_uart2_srts {
+	uint64_t u64;
+	struct cvmx_mio_uart2_srts_s {
+		uint64_t reserved_1_63:63;
+		uint64_t srts:1;
+	} s;
+	struct cvmx_mio_uart2_srts_s cn52xx;
+	struct cvmx_mio_uart2_srts_s cn52xxp1;
+};
+typedef union cvmx_mio_uart2_srts cvmx_mio_uart2_srts_t;
+
+union cvmx_mio_uart2_stt {
+	uint64_t u64;
+	struct cvmx_mio_uart2_stt_s {
+		uint64_t reserved_2_63:62;
+		uint64_t stt:2;
+	} s;
+	struct cvmx_mio_uart2_stt_s cn52xx;
+	struct cvmx_mio_uart2_stt_s cn52xxp1;
+};
+typedef union cvmx_mio_uart2_stt cvmx_mio_uart2_stt_t;
+
+union cvmx_mio_uart2_tfl {
+	uint64_t u64;
+	struct cvmx_mio_uart2_tfl_s {
+		uint64_t reserved_7_63:57;
+		uint64_t tfl:7;
+	} s;
+	struct cvmx_mio_uart2_tfl_s cn52xx;
+	struct cvmx_mio_uart2_tfl_s cn52xxp1;
+};
+typedef union cvmx_mio_uart2_tfl cvmx_mio_uart2_tfl_t;
+
+union cvmx_mio_uart2_tfr {
+	uint64_t u64;
+	struct cvmx_mio_uart2_tfr_s {
+		uint64_t reserved_8_63:56;
+		uint64_t tfr:8;
+	} s;
+	struct cvmx_mio_uart2_tfr_s cn52xx;
+	struct cvmx_mio_uart2_tfr_s cn52xxp1;
+};
+typedef union cvmx_mio_uart2_tfr cvmx_mio_uart2_tfr_t;
+
+union cvmx_mio_uart2_thr {
+	uint64_t u64;
+	struct cvmx_mio_uart2_thr_s {
+		uint64_t reserved_8_63:56;
+		uint64_t thr:8;
+	} s;
+	struct cvmx_mio_uart2_thr_s cn52xx;
+	struct cvmx_mio_uart2_thr_s cn52xxp1;
+};
+typedef union cvmx_mio_uart2_thr cvmx_mio_uart2_thr_t;
+
+union cvmx_mio_uart2_usr {
+	uint64_t u64;
+	struct cvmx_mio_uart2_usr_s {
+		uint64_t reserved_5_63:59;
+		uint64_t rff:1;
+		uint64_t rfne:1;
+		uint64_t tfe:1;
+		uint64_t tfnf:1;
+		uint64_t busy:1;
+	} s;
+	struct cvmx_mio_uart2_usr_s cn52xx;
+	struct cvmx_mio_uart2_usr_s cn52xxp1;
+};
+typedef union cvmx_mio_uart2_usr cvmx_mio_uart2_usr_t;
+
+#endif
diff --git a/arch/mips/include/asm/octeon/cvmx-pow-defs.h b/arch/mips/include/asm/octeon/cvmx-pow-defs.h
new file mode 100644
index 0000000..01baabb
--- /dev/null
+++ b/arch/mips/include/asm/octeon/cvmx-pow-defs.h
@@ -0,0 +1,697 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as published by
+ * the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful,
+ * but AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or NONINFRINGEMENT.
+ * See the GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+ ***********************license end**************************************/
+
+#ifndef __CVMX_POW_DEFS_H__
+#define __CVMX_POW_DEFS_H__
+
+#define CVMX_POW_BIST_STAT                                   CVMX_ADD_IO_SEG(0x00016700000003F8ull)
+#define CVMX_POW_DS_PC                                       CVMX_ADD_IO_SEG(0x0001670000000398ull)
+#define CVMX_POW_ECC_ERR                                     CVMX_ADD_IO_SEG(0x0001670000000218ull)
+#define CVMX_POW_INT_CTL                                     CVMX_ADD_IO_SEG(0x0001670000000220ull)
+#define CVMX_POW_IQ_CNTX(offset)                             CVMX_ADD_IO_SEG(0x0001670000000340ull + (((offset) & 7) * 8))
+#define CVMX_POW_IQ_COM_CNT                                  CVMX_ADD_IO_SEG(0x0001670000000388ull)
+#define CVMX_POW_IQ_INT                                      CVMX_ADD_IO_SEG(0x0001670000000238ull)
+#define CVMX_POW_IQ_INT_EN                                   CVMX_ADD_IO_SEG(0x0001670000000240ull)
+#define CVMX_POW_IQ_THRX(offset)                             CVMX_ADD_IO_SEG(0x00016700000003A0ull + (((offset) & 7) * 8))
+#define CVMX_POW_NOS_CNT                                     CVMX_ADD_IO_SEG(0x0001670000000228ull)
+#define CVMX_POW_NW_TIM                                      CVMX_ADD_IO_SEG(0x0001670000000210ull)
+#define CVMX_POW_PF_RST_MSK                                  CVMX_ADD_IO_SEG(0x0001670000000230ull)
+#define CVMX_POW_PP_GRP_MSKX(offset)                         CVMX_ADD_IO_SEG(0x0001670000000000ull + (((offset) & 15) * 8))
+#define CVMX_POW_QOS_RNDX(offset)                            CVMX_ADD_IO_SEG(0x00016700000001C0ull + (((offset) & 7) * 8))
+#define CVMX_POW_QOS_THRX(offset)                            CVMX_ADD_IO_SEG(0x0001670000000180ull + (((offset) & 7) * 8))
+#define CVMX_POW_TS_PC                                       CVMX_ADD_IO_SEG(0x0001670000000390ull)
+#define CVMX_POW_WA_COM_PC                                   CVMX_ADD_IO_SEG(0x0001670000000380ull)
+#define CVMX_POW_WA_PCX(offset)                              CVMX_ADD_IO_SEG(0x0001670000000300ull + (((offset) & 7) * 8))
+#define CVMX_POW_WQ_INT                                      CVMX_ADD_IO_SEG(0x0001670000000200ull)
+#define CVMX_POW_WQ_INT_CNTX(offset)                         CVMX_ADD_IO_SEG(0x0001670000000100ull + (((offset) & 15) * 8))
+#define CVMX_POW_WQ_INT_PC                                   CVMX_ADD_IO_SEG(0x0001670000000208ull)
+#define CVMX_POW_WQ_INT_THRX(offset)                         CVMX_ADD_IO_SEG(0x0001670000000080ull + (((offset) & 15) * 8))
+#define CVMX_POW_WS_PCX(offset)                              CVMX_ADD_IO_SEG(0x0001670000000280ull + (((offset) & 15) * 8))
+
+union cvmx_pow_bist_stat {
+	uint64_t u64;
+	struct cvmx_pow_bist_stat_s {
+		uint64_t reserved_32_63:32;
+		uint64_t pp:16;
+		uint64_t reserved_0_15:16;
+	} s;
+	struct cvmx_pow_bist_stat_cn30xx {
+		uint64_t reserved_17_63:47;
+		uint64_t pp:1;
+		uint64_t reserved_9_15:7;
+		uint64_t cam:1;
+		uint64_t nbt1:1;
+		uint64_t nbt0:1;
+		uint64_t index:1;
+		uint64_t fidx:1;
+		uint64_t nbr1:1;
+		uint64_t nbr0:1;
+		uint64_t pend:1;
+		uint64_t adr:1;
+	} cn30xx;
+	struct cvmx_pow_bist_stat_cn31xx {
+		uint64_t reserved_18_63:46;
+		uint64_t pp:2;
+		uint64_t reserved_9_15:7;
+		uint64_t cam:1;
+		uint64_t nbt1:1;
+		uint64_t nbt0:1;
+		uint64_t index:1;
+		uint64_t fidx:1;
+		uint64_t nbr1:1;
+		uint64_t nbr0:1;
+		uint64_t pend:1;
+		uint64_t adr:1;
+	} cn31xx;
+	struct cvmx_pow_bist_stat_cn38xx {
+		uint64_t reserved_32_63:32;
+		uint64_t pp:16;
+		uint64_t reserved_10_15:6;
+		uint64_t cam:1;
+		uint64_t nbt:1;
+		uint64_t index:1;
+		uint64_t fidx:1;
+		uint64_t nbr1:1;
+		uint64_t nbr0:1;
+		uint64_t pend1:1;
+		uint64_t pend0:1;
+		uint64_t adr1:1;
+		uint64_t adr0:1;
+	} cn38xx;
+	struct cvmx_pow_bist_stat_cn38xx cn38xxp2;
+	struct cvmx_pow_bist_stat_cn31xx cn50xx;
+	struct cvmx_pow_bist_stat_cn52xx {
+		uint64_t reserved_20_63:44;
+		uint64_t pp:4;
+		uint64_t reserved_9_15:7;
+		uint64_t cam:1;
+		uint64_t nbt1:1;
+		uint64_t nbt0:1;
+		uint64_t index:1;
+		uint64_t fidx:1;
+		uint64_t nbr1:1;
+		uint64_t nbr0:1;
+		uint64_t pend:1;
+		uint64_t adr:1;
+	} cn52xx;
+	struct cvmx_pow_bist_stat_cn52xx cn52xxp1;
+	struct cvmx_pow_bist_stat_cn56xx {
+		uint64_t reserved_28_63:36;
+		uint64_t pp:12;
+		uint64_t reserved_10_15:6;
+		uint64_t cam:1;
+		uint64_t nbt:1;
+		uint64_t index:1;
+		uint64_t fidx:1;
+		uint64_t nbr1:1;
+		uint64_t nbr0:1;
+		uint64_t pend1:1;
+		uint64_t pend0:1;
+		uint64_t adr1:1;
+		uint64_t adr0:1;
+	} cn56xx;
+	struct cvmx_pow_bist_stat_cn56xx cn56xxp1;
+	struct cvmx_pow_bist_stat_cn38xx cn58xx;
+	struct cvmx_pow_bist_stat_cn38xx cn58xxp1;
+};
+typedef union cvmx_pow_bist_stat cvmx_pow_bist_stat_t;
+
+union cvmx_pow_ds_pc {
+	uint64_t u64;
+	struct cvmx_pow_ds_pc_s {
+		uint64_t reserved_32_63:32;
+		uint64_t ds_pc:32;
+	} s;
+	struct cvmx_pow_ds_pc_s cn30xx;
+	struct cvmx_pow_ds_pc_s cn31xx;
+	struct cvmx_pow_ds_pc_s cn38xx;
+	struct cvmx_pow_ds_pc_s cn38xxp2;
+	struct cvmx_pow_ds_pc_s cn50xx;
+	struct cvmx_pow_ds_pc_s cn52xx;
+	struct cvmx_pow_ds_pc_s cn52xxp1;
+	struct cvmx_pow_ds_pc_s cn56xx;
+	struct cvmx_pow_ds_pc_s cn56xxp1;
+	struct cvmx_pow_ds_pc_s cn58xx;
+	struct cvmx_pow_ds_pc_s cn58xxp1;
+};
+typedef union cvmx_pow_ds_pc cvmx_pow_ds_pc_t;
+
+union cvmx_pow_ecc_err {
+	uint64_t u64;
+	struct cvmx_pow_ecc_err_s {
+		uint64_t reserved_45_63:19;
+		uint64_t iop_ie:13;
+		uint64_t reserved_29_31:3;
+		uint64_t iop:13;
+		uint64_t reserved_14_15:2;
+		uint64_t rpe_ie:1;
+		uint64_t rpe:1;
+		uint64_t reserved_9_11:3;
+		uint64_t syn:5;
+		uint64_t dbe_ie:1;
+		uint64_t sbe_ie:1;
+		uint64_t dbe:1;
+		uint64_t sbe:1;
+	} s;
+	struct cvmx_pow_ecc_err_s cn30xx;
+	struct cvmx_pow_ecc_err_cn31xx {
+		uint64_t reserved_14_63:50;
+		uint64_t rpe_ie:1;
+		uint64_t rpe:1;
+		uint64_t reserved_9_11:3;
+		uint64_t syn:5;
+		uint64_t dbe_ie:1;
+		uint64_t sbe_ie:1;
+		uint64_t dbe:1;
+		uint64_t sbe:1;
+	} cn31xx;
+	struct cvmx_pow_ecc_err_s cn38xx;
+	struct cvmx_pow_ecc_err_cn31xx cn38xxp2;
+	struct cvmx_pow_ecc_err_s cn50xx;
+	struct cvmx_pow_ecc_err_s cn52xx;
+	struct cvmx_pow_ecc_err_s cn52xxp1;
+	struct cvmx_pow_ecc_err_s cn56xx;
+	struct cvmx_pow_ecc_err_s cn56xxp1;
+	struct cvmx_pow_ecc_err_s cn58xx;
+	struct cvmx_pow_ecc_err_s cn58xxp1;
+};
+typedef union cvmx_pow_ecc_err cvmx_pow_ecc_err_t;
+
+union cvmx_pow_int_ctl {
+	uint64_t u64;
+	struct cvmx_pow_int_ctl_s {
+		uint64_t reserved_6_63:58;
+		uint64_t pfr_dis:1;
+		uint64_t nbr_thr:5;
+	} s;
+	struct cvmx_pow_int_ctl_s cn30xx;
+	struct cvmx_pow_int_ctl_s cn31xx;
+	struct cvmx_pow_int_ctl_s cn38xx;
+	struct cvmx_pow_int_ctl_s cn38xxp2;
+	struct cvmx_pow_int_ctl_s cn50xx;
+	struct cvmx_pow_int_ctl_s cn52xx;
+	struct cvmx_pow_int_ctl_s cn52xxp1;
+	struct cvmx_pow_int_ctl_s cn56xx;
+	struct cvmx_pow_int_ctl_s cn56xxp1;
+	struct cvmx_pow_int_ctl_s cn58xx;
+	struct cvmx_pow_int_ctl_s cn58xxp1;
+};
+typedef union cvmx_pow_int_ctl cvmx_pow_int_ctl_t;
+
+union cvmx_pow_iq_cntx {
+	uint64_t u64;
+	struct cvmx_pow_iq_cntx_s {
+		uint64_t reserved_32_63:32;
+		uint64_t iq_cnt:32;
+	} s;
+	struct cvmx_pow_iq_cntx_s cn30xx;
+	struct cvmx_pow_iq_cntx_s cn31xx;
+	struct cvmx_pow_iq_cntx_s cn38xx;
+	struct cvmx_pow_iq_cntx_s cn38xxp2;
+	struct cvmx_pow_iq_cntx_s cn50xx;
+	struct cvmx_pow_iq_cntx_s cn52xx;
+	struct cvmx_pow_iq_cntx_s cn52xxp1;
+	struct cvmx_pow_iq_cntx_s cn56xx;
+	struct cvmx_pow_iq_cntx_s cn56xxp1;
+	struct cvmx_pow_iq_cntx_s cn58xx;
+	struct cvmx_pow_iq_cntx_s cn58xxp1;
+};
+typedef union cvmx_pow_iq_cntx cvmx_pow_iq_cntx_t;
+
+union cvmx_pow_iq_com_cnt {
+	uint64_t u64;
+	struct cvmx_pow_iq_com_cnt_s {
+		uint64_t reserved_32_63:32;
+		uint64_t iq_cnt:32;
+	} s;
+	struct cvmx_pow_iq_com_cnt_s cn30xx;
+	struct cvmx_pow_iq_com_cnt_s cn31xx;
+	struct cvmx_pow_iq_com_cnt_s cn38xx;
+	struct cvmx_pow_iq_com_cnt_s cn38xxp2;
+	struct cvmx_pow_iq_com_cnt_s cn50xx;
+	struct cvmx_pow_iq_com_cnt_s cn52xx;
+	struct cvmx_pow_iq_com_cnt_s cn52xxp1;
+	struct cvmx_pow_iq_com_cnt_s cn56xx;
+	struct cvmx_pow_iq_com_cnt_s cn56xxp1;
+	struct cvmx_pow_iq_com_cnt_s cn58xx;
+	struct cvmx_pow_iq_com_cnt_s cn58xxp1;
+};
+typedef union cvmx_pow_iq_com_cnt cvmx_pow_iq_com_cnt_t;
+
+union cvmx_pow_iq_int {
+	uint64_t u64;
+	struct cvmx_pow_iq_int_s {
+		uint64_t reserved_8_63:56;
+		uint64_t iq_int:8;
+	} s;
+	struct cvmx_pow_iq_int_s cn52xx;
+	struct cvmx_pow_iq_int_s cn52xxp1;
+	struct cvmx_pow_iq_int_s cn56xx;
+	struct cvmx_pow_iq_int_s cn56xxp1;
+};
+typedef union cvmx_pow_iq_int cvmx_pow_iq_int_t;
+
+union cvmx_pow_iq_int_en {
+	uint64_t u64;
+	struct cvmx_pow_iq_int_en_s {
+		uint64_t reserved_8_63:56;
+		uint64_t int_en:8;
+	} s;
+	struct cvmx_pow_iq_int_en_s cn52xx;
+	struct cvmx_pow_iq_int_en_s cn52xxp1;
+	struct cvmx_pow_iq_int_en_s cn56xx;
+	struct cvmx_pow_iq_int_en_s cn56xxp1;
+};
+typedef union cvmx_pow_iq_int_en cvmx_pow_iq_int_en_t;
+
+union cvmx_pow_iq_thrx {
+	uint64_t u64;
+	struct cvmx_pow_iq_thrx_s {
+		uint64_t reserved_32_63:32;
+		uint64_t iq_thr:32;
+	} s;
+	struct cvmx_pow_iq_thrx_s cn52xx;
+	struct cvmx_pow_iq_thrx_s cn52xxp1;
+	struct cvmx_pow_iq_thrx_s cn56xx;
+	struct cvmx_pow_iq_thrx_s cn56xxp1;
+};
+typedef union cvmx_pow_iq_thrx cvmx_pow_iq_thrx_t;
+
+union cvmx_pow_nos_cnt {
+	uint64_t u64;
+	struct cvmx_pow_nos_cnt_s {
+		uint64_t reserved_12_63:52;
+		uint64_t nos_cnt:12;
+	} s;
+	struct cvmx_pow_nos_cnt_cn30xx {
+		uint64_t reserved_7_63:57;
+		uint64_t nos_cnt:7;
+	} cn30xx;
+	struct cvmx_pow_nos_cnt_cn31xx {
+		uint64_t reserved_9_63:55;
+		uint64_t nos_cnt:9;
+	} cn31xx;
+	struct cvmx_pow_nos_cnt_s cn38xx;
+	struct cvmx_pow_nos_cnt_s cn38xxp2;
+	struct cvmx_pow_nos_cnt_cn31xx cn50xx;
+	struct cvmx_pow_nos_cnt_cn52xx {
+		uint64_t reserved_10_63:54;
+		uint64_t nos_cnt:10;
+	} cn52xx;
+	struct cvmx_pow_nos_cnt_cn52xx cn52xxp1;
+	struct cvmx_pow_nos_cnt_s cn56xx;
+	struct cvmx_pow_nos_cnt_s cn56xxp1;
+	struct cvmx_pow_nos_cnt_s cn58xx;
+	struct cvmx_pow_nos_cnt_s cn58xxp1;
+};
+typedef union cvmx_pow_nos_cnt cvmx_pow_nos_cnt_t;
+
+union cvmx_pow_nw_tim {
+	uint64_t u64;
+	struct cvmx_pow_nw_tim_s {
+		uint64_t reserved_10_63:54;
+		uint64_t nw_tim:10;
+	} s;
+	struct cvmx_pow_nw_tim_s cn30xx;
+	struct cvmx_pow_nw_tim_s cn31xx;
+	struct cvmx_pow_nw_tim_s cn38xx;
+	struct cvmx_pow_nw_tim_s cn38xxp2;
+	struct cvmx_pow_nw_tim_s cn50xx;
+	struct cvmx_pow_nw_tim_s cn52xx;
+	struct cvmx_pow_nw_tim_s cn52xxp1;
+	struct cvmx_pow_nw_tim_s cn56xx;
+	struct cvmx_pow_nw_tim_s cn56xxp1;
+	struct cvmx_pow_nw_tim_s cn58xx;
+	struct cvmx_pow_nw_tim_s cn58xxp1;
+};
+typedef union cvmx_pow_nw_tim cvmx_pow_nw_tim_t;
+
+union cvmx_pow_pf_rst_msk {
+	uint64_t u64;
+	struct cvmx_pow_pf_rst_msk_s {
+		uint64_t reserved_8_63:56;
+		uint64_t rst_msk:8;
+	} s;
+	struct cvmx_pow_pf_rst_msk_s cn50xx;
+	struct cvmx_pow_pf_rst_msk_s cn52xx;
+	struct cvmx_pow_pf_rst_msk_s cn52xxp1;
+	struct cvmx_pow_pf_rst_msk_s cn56xx;
+	struct cvmx_pow_pf_rst_msk_s cn56xxp1;
+	struct cvmx_pow_pf_rst_msk_s cn58xx;
+	struct cvmx_pow_pf_rst_msk_s cn58xxp1;
+};
+typedef union cvmx_pow_pf_rst_msk cvmx_pow_pf_rst_msk_t;
+
+union cvmx_pow_pp_grp_mskx {
+	uint64_t u64;
+	struct cvmx_pow_pp_grp_mskx_s {
+		uint64_t reserved_48_63:16;
+		uint64_t qos7_pri:4;
+		uint64_t qos6_pri:4;
+		uint64_t qos5_pri:4;
+		uint64_t qos4_pri:4;
+		uint64_t qos3_pri:4;
+		uint64_t qos2_pri:4;
+		uint64_t qos1_pri:4;
+		uint64_t qos0_pri:4;
+		uint64_t grp_msk:16;
+	} s;
+	struct cvmx_pow_pp_grp_mskx_cn30xx {
+		uint64_t reserved_16_63:48;
+		uint64_t grp_msk:16;
+	} cn30xx;
+	struct cvmx_pow_pp_grp_mskx_cn30xx cn31xx;
+	struct cvmx_pow_pp_grp_mskx_cn30xx cn38xx;
+	struct cvmx_pow_pp_grp_mskx_cn30xx cn38xxp2;
+	struct cvmx_pow_pp_grp_mskx_s cn50xx;
+	struct cvmx_pow_pp_grp_mskx_s cn52xx;
+	struct cvmx_pow_pp_grp_mskx_s cn52xxp1;
+	struct cvmx_pow_pp_grp_mskx_s cn56xx;
+	struct cvmx_pow_pp_grp_mskx_s cn56xxp1;
+	struct cvmx_pow_pp_grp_mskx_s cn58xx;
+	struct cvmx_pow_pp_grp_mskx_s cn58xxp1;
+};
+typedef union cvmx_pow_pp_grp_mskx cvmx_pow_pp_grp_mskx_t;
+
+union cvmx_pow_qos_rndx {
+	uint64_t u64;
+	struct cvmx_pow_qos_rndx_s {
+		uint64_t reserved_32_63:32;
+		uint64_t rnd_p3:8;
+		uint64_t rnd_p2:8;
+		uint64_t rnd_p1:8;
+		uint64_t rnd:8;
+	} s;
+	struct cvmx_pow_qos_rndx_s cn30xx;
+	struct cvmx_pow_qos_rndx_s cn31xx;
+	struct cvmx_pow_qos_rndx_s cn38xx;
+	struct cvmx_pow_qos_rndx_s cn38xxp2;
+	struct cvmx_pow_qos_rndx_s cn50xx;
+	struct cvmx_pow_qos_rndx_s cn52xx;
+	struct cvmx_pow_qos_rndx_s cn52xxp1;
+	struct cvmx_pow_qos_rndx_s cn56xx;
+	struct cvmx_pow_qos_rndx_s cn56xxp1;
+	struct cvmx_pow_qos_rndx_s cn58xx;
+	struct cvmx_pow_qos_rndx_s cn58xxp1;
+};
+typedef union cvmx_pow_qos_rndx cvmx_pow_qos_rndx_t;
+
+union cvmx_pow_qos_thrx {
+	uint64_t u64;
+	struct cvmx_pow_qos_thrx_s {
+		uint64_t reserved_60_63:4;
+		uint64_t des_cnt:12;
+		uint64_t buf_cnt:12;
+		uint64_t free_cnt:12;
+		uint64_t reserved_23_23:1;
+		uint64_t max_thr:11;
+		uint64_t reserved_11_11:1;
+		uint64_t min_thr:11;
+	} s;
+	struct cvmx_pow_qos_thrx_cn30xx {
+		uint64_t reserved_55_63:9;
+		uint64_t des_cnt:7;
+		uint64_t reserved_43_47:5;
+		uint64_t buf_cnt:7;
+		uint64_t reserved_31_35:5;
+		uint64_t free_cnt:7;
+		uint64_t reserved_18_23:6;
+		uint64_t max_thr:6;
+		uint64_t reserved_6_11:6;
+		uint64_t min_thr:6;
+	} cn30xx;
+	struct cvmx_pow_qos_thrx_cn31xx {
+		uint64_t reserved_57_63:7;
+		uint64_t des_cnt:9;
+		uint64_t reserved_45_47:3;
+		uint64_t buf_cnt:9;
+		uint64_t reserved_33_35:3;
+		uint64_t free_cnt:9;
+		uint64_t reserved_20_23:4;
+		uint64_t max_thr:8;
+		uint64_t reserved_8_11:4;
+		uint64_t min_thr:8;
+	} cn31xx;
+	struct cvmx_pow_qos_thrx_s cn38xx;
+	struct cvmx_pow_qos_thrx_s cn38xxp2;
+	struct cvmx_pow_qos_thrx_cn31xx cn50xx;
+	struct cvmx_pow_qos_thrx_cn52xx {
+		uint64_t reserved_58_63:6;
+		uint64_t des_cnt:10;
+		uint64_t reserved_46_47:2;
+		uint64_t buf_cnt:10;
+		uint64_t reserved_34_35:2;
+		uint64_t free_cnt:10;
+		uint64_t reserved_21_23:3;
+		uint64_t max_thr:9;
+		uint64_t reserved_9_11:3;
+		uint64_t min_thr:9;
+	} cn52xx;
+	struct cvmx_pow_qos_thrx_cn52xx cn52xxp1;
+	struct cvmx_pow_qos_thrx_s cn56xx;
+	struct cvmx_pow_qos_thrx_s cn56xxp1;
+	struct cvmx_pow_qos_thrx_s cn58xx;
+	struct cvmx_pow_qos_thrx_s cn58xxp1;
+};
+typedef union cvmx_pow_qos_thrx cvmx_pow_qos_thrx_t;
+
+union cvmx_pow_ts_pc {
+	uint64_t u64;
+	struct cvmx_pow_ts_pc_s {
+		uint64_t reserved_32_63:32;
+		uint64_t ts_pc:32;
+	} s;
+	struct cvmx_pow_ts_pc_s cn30xx;
+	struct cvmx_pow_ts_pc_s cn31xx;
+	struct cvmx_pow_ts_pc_s cn38xx;
+	struct cvmx_pow_ts_pc_s cn38xxp2;
+	struct cvmx_pow_ts_pc_s cn50xx;
+	struct cvmx_pow_ts_pc_s cn52xx;
+	struct cvmx_pow_ts_pc_s cn52xxp1;
+	struct cvmx_pow_ts_pc_s cn56xx;
+	struct cvmx_pow_ts_pc_s cn56xxp1;
+	struct cvmx_pow_ts_pc_s cn58xx;
+	struct cvmx_pow_ts_pc_s cn58xxp1;
+};
+typedef union cvmx_pow_ts_pc cvmx_pow_ts_pc_t;
+
+union cvmx_pow_wa_com_pc {
+	uint64_t u64;
+	struct cvmx_pow_wa_com_pc_s {
+		uint64_t reserved_32_63:32;
+		uint64_t wa_pc:32;
+	} s;
+	struct cvmx_pow_wa_com_pc_s cn30xx;
+	struct cvmx_pow_wa_com_pc_s cn31xx;
+	struct cvmx_pow_wa_com_pc_s cn38xx;
+	struct cvmx_pow_wa_com_pc_s cn38xxp2;
+	struct cvmx_pow_wa_com_pc_s cn50xx;
+	struct cvmx_pow_wa_com_pc_s cn52xx;
+	struct cvmx_pow_wa_com_pc_s cn52xxp1;
+	struct cvmx_pow_wa_com_pc_s cn56xx;
+	struct cvmx_pow_wa_com_pc_s cn56xxp1;
+	struct cvmx_pow_wa_com_pc_s cn58xx;
+	struct cvmx_pow_wa_com_pc_s cn58xxp1;
+};
+typedef union cvmx_pow_wa_com_pc cvmx_pow_wa_com_pc_t;
+
+union cvmx_pow_wa_pcx {
+	uint64_t u64;
+	struct cvmx_pow_wa_pcx_s {
+		uint64_t reserved_32_63:32;
+		uint64_t wa_pc:32;
+	} s;
+	struct cvmx_pow_wa_pcx_s cn30xx;
+	struct cvmx_pow_wa_pcx_s cn31xx;
+	struct cvmx_pow_wa_pcx_s cn38xx;
+	struct cvmx_pow_wa_pcx_s cn38xxp2;
+	struct cvmx_pow_wa_pcx_s cn50xx;
+	struct cvmx_pow_wa_pcx_s cn52xx;
+	struct cvmx_pow_wa_pcx_s cn52xxp1;
+	struct cvmx_pow_wa_pcx_s cn56xx;
+	struct cvmx_pow_wa_pcx_s cn56xxp1;
+	struct cvmx_pow_wa_pcx_s cn58xx;
+	struct cvmx_pow_wa_pcx_s cn58xxp1;
+};
+typedef union cvmx_pow_wa_pcx cvmx_pow_wa_pcx_t;
+
+union cvmx_pow_wq_int {
+	uint64_t u64;
+	struct cvmx_pow_wq_int_s {
+		uint64_t reserved_32_63:32;
+		uint64_t iq_dis:16;
+		uint64_t wq_int:16;
+	} s;
+	struct cvmx_pow_wq_int_s cn30xx;
+	struct cvmx_pow_wq_int_s cn31xx;
+	struct cvmx_pow_wq_int_s cn38xx;
+	struct cvmx_pow_wq_int_s cn38xxp2;
+	struct cvmx_pow_wq_int_s cn50xx;
+	struct cvmx_pow_wq_int_s cn52xx;
+	struct cvmx_pow_wq_int_s cn52xxp1;
+	struct cvmx_pow_wq_int_s cn56xx;
+	struct cvmx_pow_wq_int_s cn56xxp1;
+	struct cvmx_pow_wq_int_s cn58xx;
+	struct cvmx_pow_wq_int_s cn58xxp1;
+};
+typedef union cvmx_pow_wq_int cvmx_pow_wq_int_t;
+
+union cvmx_pow_wq_int_cntx {
+	uint64_t u64;
+	struct cvmx_pow_wq_int_cntx_s {
+		uint64_t reserved_28_63:36;
+		uint64_t tc_cnt:4;
+		uint64_t ds_cnt:12;
+		uint64_t iq_cnt:12;
+	} s;
+	struct cvmx_pow_wq_int_cntx_cn30xx {
+		uint64_t reserved_28_63:36;
+		uint64_t tc_cnt:4;
+		uint64_t reserved_19_23:5;
+		uint64_t ds_cnt:7;
+		uint64_t reserved_7_11:5;
+		uint64_t iq_cnt:7;
+	} cn30xx;
+	struct cvmx_pow_wq_int_cntx_cn31xx {
+		uint64_t reserved_28_63:36;
+		uint64_t tc_cnt:4;
+		uint64_t reserved_21_23:3;
+		uint64_t ds_cnt:9;
+		uint64_t reserved_9_11:3;
+		uint64_t iq_cnt:9;
+	} cn31xx;
+	struct cvmx_pow_wq_int_cntx_s cn38xx;
+	struct cvmx_pow_wq_int_cntx_s cn38xxp2;
+	struct cvmx_pow_wq_int_cntx_cn31xx cn50xx;
+	struct cvmx_pow_wq_int_cntx_cn52xx {
+		uint64_t reserved_28_63:36;
+		uint64_t tc_cnt:4;
+		uint64_t reserved_22_23:2;
+		uint64_t ds_cnt:10;
+		uint64_t reserved_10_11:2;
+		uint64_t iq_cnt:10;
+	} cn52xx;
+	struct cvmx_pow_wq_int_cntx_cn52xx cn52xxp1;
+	struct cvmx_pow_wq_int_cntx_s cn56xx;
+	struct cvmx_pow_wq_int_cntx_s cn56xxp1;
+	struct cvmx_pow_wq_int_cntx_s cn58xx;
+	struct cvmx_pow_wq_int_cntx_s cn58xxp1;
+};
+typedef union cvmx_pow_wq_int_cntx cvmx_pow_wq_int_cntx_t;
+
+union cvmx_pow_wq_int_pc {
+	uint64_t u64;
+	struct cvmx_pow_wq_int_pc_s {
+		uint64_t reserved_60_63:4;
+		uint64_t pc:28;
+		uint64_t reserved_28_31:4;
+		uint64_t pc_thr:20;
+		uint64_t reserved_0_7:8;
+	} s;
+	struct cvmx_pow_wq_int_pc_s cn30xx;
+	struct cvmx_pow_wq_int_pc_s cn31xx;
+	struct cvmx_pow_wq_int_pc_s cn38xx;
+	struct cvmx_pow_wq_int_pc_s cn38xxp2;
+	struct cvmx_pow_wq_int_pc_s cn50xx;
+	struct cvmx_pow_wq_int_pc_s cn52xx;
+	struct cvmx_pow_wq_int_pc_s cn52xxp1;
+	struct cvmx_pow_wq_int_pc_s cn56xx;
+	struct cvmx_pow_wq_int_pc_s cn56xxp1;
+	struct cvmx_pow_wq_int_pc_s cn58xx;
+	struct cvmx_pow_wq_int_pc_s cn58xxp1;
+};
+typedef union cvmx_pow_wq_int_pc cvmx_pow_wq_int_pc_t;
+
+union cvmx_pow_wq_int_thrx {
+	uint64_t u64;
+	struct cvmx_pow_wq_int_thrx_s {
+		uint64_t reserved_29_63:35;
+		uint64_t tc_en:1;
+		uint64_t tc_thr:4;
+		uint64_t reserved_23_23:1;
+		uint64_t ds_thr:11;
+		uint64_t reserved_11_11:1;
+		uint64_t iq_thr:11;
+	} s;
+	struct cvmx_pow_wq_int_thrx_cn30xx {
+		uint64_t reserved_29_63:35;
+		uint64_t tc_en:1;
+		uint64_t tc_thr:4;
+		uint64_t reserved_18_23:6;
+		uint64_t ds_thr:6;
+		uint64_t reserved_6_11:6;
+		uint64_t iq_thr:6;
+	} cn30xx;
+	struct cvmx_pow_wq_int_thrx_cn31xx {
+		uint64_t reserved_29_63:35;
+		uint64_t tc_en:1;
+		uint64_t tc_thr:4;
+		uint64_t reserved_20_23:4;
+		uint64_t ds_thr:8;
+		uint64_t reserved_8_11:4;
+		uint64_t iq_thr:8;
+	} cn31xx;
+	struct cvmx_pow_wq_int_thrx_s cn38xx;
+	struct cvmx_pow_wq_int_thrx_s cn38xxp2;
+	struct cvmx_pow_wq_int_thrx_cn31xx cn50xx;
+	struct cvmx_pow_wq_int_thrx_cn52xx {
+		uint64_t reserved_29_63:35;
+		uint64_t tc_en:1;
+		uint64_t tc_thr:4;
+		uint64_t reserved_21_23:3;
+		uint64_t ds_thr:9;
+		uint64_t reserved_9_11:3;
+		uint64_t iq_thr:9;
+	} cn52xx;
+	struct cvmx_pow_wq_int_thrx_cn52xx cn52xxp1;
+	struct cvmx_pow_wq_int_thrx_s cn56xx;
+	struct cvmx_pow_wq_int_thrx_s cn56xxp1;
+	struct cvmx_pow_wq_int_thrx_s cn58xx;
+	struct cvmx_pow_wq_int_thrx_s cn58xxp1;
+};
+typedef union cvmx_pow_wq_int_thrx cvmx_pow_wq_int_thrx_t;
+
+union cvmx_pow_ws_pcx {
+	uint64_t u64;
+	struct cvmx_pow_ws_pcx_s {
+		uint64_t reserved_32_63:32;
+		uint64_t ws_pc:32;
+	} s;
+	struct cvmx_pow_ws_pcx_s cn30xx;
+	struct cvmx_pow_ws_pcx_s cn31xx;
+	struct cvmx_pow_ws_pcx_s cn38xx;
+	struct cvmx_pow_ws_pcx_s cn38xxp2;
+	struct cvmx_pow_ws_pcx_s cn50xx;
+	struct cvmx_pow_ws_pcx_s cn52xx;
+	struct cvmx_pow_ws_pcx_s cn52xxp1;
+	struct cvmx_pow_ws_pcx_s cn56xx;
+	struct cvmx_pow_ws_pcx_s cn56xxp1;
+	struct cvmx_pow_ws_pcx_s cn58xx;
+	struct cvmx_pow_ws_pcx_s cn58xxp1;
+};
+typedef union cvmx_pow_ws_pcx cvmx_pow_ws_pcx_t;
+
+#endif
diff --git a/arch/mips/include/asm/octeon/octeon.h b/arch/mips/include/asm/octeon/octeon.h
new file mode 100644
index 0000000..0a9365b
--- /dev/null
+++ b/arch/mips/include/asm/octeon/octeon.h
@@ -0,0 +1,238 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2004-2008 Cavium Networks
+ */
+#ifndef __ASM_OCTEON_OCTEON_H
+#define __ASM_OCTEON_OCTEON_H
+
+#include "cvmx.h"
+
+extern uint64_t octeon_bootmem_alloc_range_phys(uint64_t size,
+						uint64_t alignment,
+						uint64_t min_addr,
+						uint64_t max_addr,
+						int do_locking);
+extern void *octeon_bootmem_alloc(uint64_t size, uint64_t alignment,
+				  int do_locking);
+extern void *octeon_bootmem_alloc_range(uint64_t size, uint64_t alignment,
+					uint64_t min_addr, uint64_t max_addr,
+					int do_locking);
+extern void *octeon_bootmem_alloc_named(uint64_t size, uint64_t alignment,
+					char *name);
+extern void *octeon_bootmem_alloc_named_range(uint64_t size, uint64_t min_addr,
+					      uint64_t max_addr, uint64_t align,
+					      char *name);
+extern void *octeon_bootmem_alloc_named_address(uint64_t size, uint64_t address,
+						char *name);
+extern int octeon_bootmem_free_named(char *name);
+extern void octeon_bootmem_lock(void);
+extern void octeon_bootmem_unlock(void);
+
+extern int octeon_is_simulation(void);
+extern int octeon_is_pci_host(void);
+extern int octeon_usb_is_ref_clk(void);
+extern uint64_t octeon_get_clock_rate(void);
+extern const char *octeon_board_type_string(void);
+extern const char *octeon_get_pci_interrupts(void);
+extern int octeon_get_southbridge_interrupt(void);
+extern int octeon_get_boot_coremask(void);
+extern int octeon_get_boot_num_arguments(void);
+extern const char *octeon_get_boot_argument(int arg);
+extern void octeon_hal_setup_reserved32(void);
+struct octeon_cop2_state;
+extern unsigned long octeon_crypto_enable(struct octeon_cop2_state *state);
+extern void octeon_crypto_disable(struct octeon_cop2_state *state,
+				  unsigned long flags);
+
+#define OCTEON_ARGV_MAX_ARGS	64
+#define OCTOEN_SERIAL_LEN	20
+
+struct octeon_boot_descriptor {
+	/* Start of block referenced by assembly code - do not change! */
+	uint32_t desc_version;
+	uint32_t desc_size;
+	uint64_t stack_top;
+	uint64_t heap_base;
+	uint64_t heap_end;
+	/* Only used by bootloader */
+	uint64_t entry_point;
+	uint64_t desc_vaddr;
+	/* End of This block referenced by assembly code - do not change! */
+	uint32_t exception_base_addr;
+	uint32_t stack_size;
+	uint32_t heap_size;
+	/* Argc count for application. */
+	uint32_t argc;
+	uint32_t argv[OCTEON_ARGV_MAX_ARGS];
+
+#define  BOOT_FLAG_INIT_CORE		(1 << 0)
+#define  OCTEON_BL_FLAG_DEBUG		(1 << 1)
+#define  OCTEON_BL_FLAG_NO_MAGIC	(1 << 2)
+	/* If set, use uart1 for console */
+#define  OCTEON_BL_FLAG_CONSOLE_UART1	(1 << 3)
+	/* If set, use PCI console */
+#define  OCTEON_BL_FLAG_CONSOLE_PCI	(1 << 4)
+	/* Call exit on break on serial port */
+#define  OCTEON_BL_FLAG_BREAK		(1 << 5)
+
+	uint32_t flags;
+	uint32_t core_mask;
+	/* DRAM size in megabyes. */
+	uint32_t dram_size;
+	/* physical address of free memory descriptor block. */
+	uint32_t phy_mem_desc_addr;
+	/* used to pass flags from app to debugger. */
+	uint32_t debugger_flags_base_addr;
+	/* CPU clock speed, in hz. */
+	uint32_t eclock_hz;
+	/* DRAM clock speed, in hz. */
+	uint32_t dclock_hz;
+	/* SPI4 clock in hz. */
+	uint32_t spi_clock_hz;
+	uint16_t board_type;
+	uint8_t board_rev_major;
+	uint8_t board_rev_minor;
+	uint16_t chip_type;
+	uint8_t chip_rev_major;
+	uint8_t chip_rev_minor;
+	char board_serial_number[OCTOEN_SERIAL_LEN];
+	uint8_t mac_addr_base[6];
+	uint8_t mac_addr_count;
+	uint64_t cvmx_desc_vaddr;
+};
+
+union octeon_cvmemctl {
+	uint64_t u64;
+	struct {
+		/* RO 1 = BIST fail, 0 = BIST pass */
+		uint64_t tlbbist:1;
+		/* RO 1 = BIST fail, 0 = BIST pass */
+		uint64_t l1cbist:1;
+		/* RO 1 = BIST fail, 0 = BIST pass */
+		uint64_t l1dbist:1;
+		/* RO 1 = BIST fail, 0 = BIST pass */
+		uint64_t dcmbist:1;
+		/* RO 1 = BIST fail, 0 = BIST pass */
+		uint64_t ptgbist:1;
+		/* RO 1 = BIST fail, 0 = BIST pass */
+		uint64_t wbfbist:1;
+		/* Reserved */
+		uint64_t reserved:22;
+		/* R/W If set, marked write-buffer entries time out
+		 * the same as as other entries; if clear, marked
+		 * write-buffer entries use the maximum timeout. */
+		uint64_t dismarkwblongto:1;
+		/* R/W If set, a merged store does not clear the
+		 * write-buffer entry timeout state. */
+		uint64_t dismrgclrwbto:1;
+		/* R/W Two bits that are the MSBs of the resultant
+		 * CVMSEG LM word location for an IOBDMA. The other 8
+		 * bits come from the SCRADDR field of the IOBDMA. */
+		uint64_t iobdmascrmsb:2;
+		/* R/W If set, SYNCWS and SYNCS only order marked
+		 * stores; if clear, SYNCWS and SYNCS only order
+		 * unmarked stores. SYNCWSMARKED has no effect when
+		 * DISSYNCWS is set. */
+		uint64_t syncwsmarked:1;
+		/* R/W If set, SYNCWS acts as SYNCW and SYNCS acts as
+		 * SYNC. */
+		uint64_t dissyncws:1;
+		/* R/W If set, no stall happens on write buffer
+		 * full. */
+		uint64_t diswbfst:1;
+		/* R/W If set (and SX set), supervisor-level
+		 * loads/stores can use XKPHYS addresses with
+		 * VA<48>==0 */
+		uint64_t xkmemenas:1;
+		/* R/W If set (and UX set), user-level loads/stores
+		 * can use XKPHYS addresses with VA<48>==0 */
+		uint64_t xkmemenau:1;
+		/* R/W If set (and SX set), supervisor-level
+		 * loads/stores can use XKPHYS addresses with
+		 * VA<48>==1 */
+		uint64_t xkioenas:1;
+		/* R/W If set (and UX set), user-level loads/stores
+		 * can use XKPHYS addresses with VA<48>==1 */
+		uint64_t xkioenau:1;
+		/* R/W If set, all stores act as SYNCW (NOMERGE must
+		 * be set when this is set) RW, reset to 0. */
+		uint64_t allsyncw:1;
+		/* R/W If set, no stores merge, and all stores reach
+		 * the coherent bus in order. */
+		uint64_t nomerge:1;
+		/* R/W Selects the bit in the counter used for DID
+		 * time-outs 0 = 231, 1 = 230, 2 = 229, 3 =
+		 * 214. Actual time-out is between 1� and 2� this
+		 * interval. For example, with DIDTTO=3, expiration
+		 * interval is between 16K and 32K. */
+		uint64_t didtto:2;
+		/* R/W If set, the (mem) CSR clock never turns off. */
+		uint64_t csrckalwys:1;
+		/* R/W If set, mclk never turns off. */
+		uint64_t mclkalwys:1;
+		/* R/W Selects the bit in the counter used for write
+		 * buffer flush time-outs (WBFLT+11) is the bit
+		 * position in an internal counter used to determine
+		 * expiration. The write buffer expires between 1� and
+		 * 2� this interval. For example, with WBFLT = 0, a
+		 * write buffer expires between 2K and 4K cycles after
+		 * the write buffer entry is allocated. */
+		uint64_t wbfltime:3;
+		/* R/W If set, do not put Istream in the L2 cache. */
+		uint64_t istrnol2:1;
+		/* R/W The write buffer threshold. */
+		uint64_t wbthresh:4;
+		/* Reserved */
+		uint64_t reserved2:2;
+		/* R/W If set, CVMSEG is available for loads/stores in
+		 * kernel/debug mode. */
+		uint64_t cvmsegenak:1;
+		/* R/W If set, CVMSEG is available for loads/stores in
+		 * supervisor mode. */
+		uint64_t cvmsegenas:1;
+		/* R/W If set, CVMSEG is available for loads/stores in
+		 * user mode. */
+		uint64_t cvmsegenau:1;
+		/* R/W Size of local memory in cache blocks, 54 (6912
+		 * bytes) is max legal value. */
+		uint64_t lmemsz:6;
+	} s;
+};
+
+extern void octeon_write_lcd(const char *s);
+extern void octeon_check_cpu_bist(void);
+extern int octeon_get_boot_debug_flag(void);
+extern int octeon_get_boot_uart(void);
+
+struct uart_port;
+extern unsigned int octeon_serial_in(struct uart_port *, int);
+extern void octeon_serial_out(struct uart_port *, int, int);
+
+/**
+ * Write a 32bit value to the Octeon NPI register space
+ *
+ * @address: Address to write to
+ * @val:     Value to write
+ */
+static inline void octeon_npi_write32(uint64_t address, uint32_t val)
+{
+	cvmx_write64_uint32(address ^ 4, val);
+	cvmx_read64_uint32(address ^ 4);
+}
+
+
+/**
+ * Read a 32bit value from the Octeon NPI register space
+ *
+ * @address: Address to read
+ * Returns The result
+ */
+static inline uint32_t octeon_npi_read32(uint64_t address)
+{
+	return cvmx_read64_uint32(address ^ 4);
+}
+
+#endif /* __ASM_OCTEON_OCTEON_H */
-- 
1.5.6.5
