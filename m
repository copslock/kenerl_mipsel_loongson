Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Oct 2008 00:04:23 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:5908 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S22533306AbYJ1AEN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 28 Oct 2008 00:04:13 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B490656f60000>; Mon, 27 Oct 2008 20:04:06 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 27 Oct 2008 17:03:07 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 27 Oct 2008 17:03:07 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id m9S032XA003252;
	Mon, 27 Oct 2008 17:03:02 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id m9S032Kf003251;
	Mon, 27 Oct 2008 17:03:02 -0700
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>,
	Paul Gortmaker <Paul.Gortmaker@windriver.com>
Subject: [PATCH 02/36] Add Cavium OCTEON files to arch/mips/include/asm/mach-cavium-octeon
Date:	Mon, 27 Oct 2008 17:02:34 -0700
Message-Id: <1225152181-3221-2-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1225152181-3221-1-git-send-email-ddaney@caviumnetworks.com>
References: <490655B6.4030406@caviumnetworks.com>
 <1225152181-3221-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 28 Oct 2008 00:03:07.0460 (UTC) FILETIME=[8E89A040:01C93890]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21011
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Signed-off-by: Paul Gortmaker <Paul.Gortmaker@windriver.com>
Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 .../asm/mach-cavium-octeon/cpu-feature-overrides.h |   63 +++++
 .../include/asm/mach-cavium-octeon/dma-coherence.h |   64 +++++
 arch/mips/include/asm/mach-cavium-octeon/irq.h     |  253 ++++++++++++++++++++
 .../asm/mach-cavium-octeon/kernel-entry-init.h     |  140 +++++++++++
 .../asm/mach-cavium-octeon/octeon-hal-read-write.h |   38 +++
 arch/mips/include/asm/mach-cavium-octeon/war.h     |   26 ++
 6 files changed, 584 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
 create mode 100644 arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h
 create mode 100644 arch/mips/include/asm/mach-cavium-octeon/irq.h
 create mode 100644 arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
 create mode 100644 arch/mips/include/asm/mach-cavium-octeon/octeon-hal-read-write.h
 create mode 100644 arch/mips/include/asm/mach-cavium-octeon/war.h

diff --git a/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h b/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
new file mode 100644
index 0000000..2b85565
--- /dev/null
+++ b/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
@@ -0,0 +1,63 @@
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
+#ifdef CONFIG_SMP
+#define cpu_has_llsc		1
+#else
+/* Disable LL/SC on non SMP systems. It is faster to disable interrupts for
+   atomic access than a LL/SC */
+#define cpu_has_llsc		0
+#endif
+#define cpu_has_prefetch  	1
+#define cpu_has_dc_aliases      0
+#define cpu_has_fpu             0
+#define cpu_has_64bits          1
+#define cpu_has_octeon_cache    1
+#define cpu_has_4k_cache	0
+#define cpu_has_saa             octeon_has_saa()
+#define cpu_has_mips64r2        1
+#define cpu_has_counter         1
+#define ARCH_HAS_READ_CURRENT_TIMER 1
+#define ARCH_HAS_IRQ_PER_CPU 1
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
index 0000000..3dc0e0b
--- /dev/null
+++ b/arch/mips/include/asm/mach-cavium-octeon/irq.h
@@ -0,0 +1,253 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2004-2007 Cavium Networks
+ */
+#ifndef __OCTEON_IRQ_H__
+#define __OCTEON_IRQ_H__
+
+#define NR_IRQS OCTEON_IRQ_LAST
+#define MIPS_CPU_IRQ_BASE 0
+
+/* 0 - 7 represent the 8 MIPS standard interrupt sources */
+#define OCTEON_IRQ_SW0          0
+#define OCTEON_IRQ_SW1          1
+#define OCTEON_IRQ_CIU0         2
+#define OCTEON_IRQ_CIU1         3
+#define OCTEON_IRQ_CIU4         4
+#define OCTEON_IRQ_5            5
+#define OCTEON_IRQ_PERF         6
+#define OCTEON_IRQ_TIMER        7
+/* 8 - 71 represent the sources in CIU_INTX_EN0 */
+#define OCTEON_IRQ_WORKQ0       8
+#define OCTEON_IRQ_WORKQ1       9
+#define OCTEON_IRQ_WORKQ2       10
+#define OCTEON_IRQ_WORKQ3       11
+#define OCTEON_IRQ_WORKQ4       12
+#define OCTEON_IRQ_WORKQ5       13
+#define OCTEON_IRQ_WORKQ6       14
+#define OCTEON_IRQ_WORKQ7       15
+#define OCTEON_IRQ_WORKQ8       16
+#define OCTEON_IRQ_WORKQ9       17
+#define OCTEON_IRQ_WORKQ10      18
+#define OCTEON_IRQ_WORKQ11      19
+#define OCTEON_IRQ_WORKQ12      20
+#define OCTEON_IRQ_WORKQ13      21
+#define OCTEON_IRQ_WORKQ14      22
+#define OCTEON_IRQ_WORKQ15      23
+#define OCTEON_IRQ_GPIO0        24
+#define OCTEON_IRQ_GPIO1        25
+#define OCTEON_IRQ_GPIO2        26
+#define OCTEON_IRQ_GPIO3        27
+#define OCTEON_IRQ_GPIO4        28
+#define OCTEON_IRQ_GPIO5        29
+#define OCTEON_IRQ_GPIO6        30
+#define OCTEON_IRQ_GPIO7        31
+#define OCTEON_IRQ_GPIO8        32
+#define OCTEON_IRQ_GPIO9        33
+#define OCTEON_IRQ_GPIO10       34
+#define OCTEON_IRQ_GPIO11       35
+#define OCTEON_IRQ_GPIO12       36
+#define OCTEON_IRQ_GPIO13       37
+#define OCTEON_IRQ_GPIO14       38
+#define OCTEON_IRQ_GPIO15       39
+#define OCTEON_IRQ_MBOX0        40
+#define OCTEON_IRQ_MBOX1        41
+#define OCTEON_IRQ_UART0        42
+#define OCTEON_IRQ_UART1        43
+#define OCTEON_IRQ_PCI_INT0     44
+#define OCTEON_IRQ_PCI_INT1     45
+#define OCTEON_IRQ_PCI_INT2     46
+#define OCTEON_IRQ_PCI_INT3     47
+#define OCTEON_IRQ_PCI_MSI0     48
+#define OCTEON_IRQ_PCI_MSI1     49
+#define OCTEON_IRQ_PCI_MSI2     50
+#define OCTEON_IRQ_PCI_MSI3     51
+#define OCTEON_IRQ_RESERVED52   52	/* Summary of CIU_INT_SUM1 */
+#define OCTEON_IRQ_TWSI         53
+#define OCTEON_IRQ_RML          54
+#define OCTEON_IRQ_TRACE        55
+#define OCTEON_IRQ_GMX_DRP0     56
+#define OCTEON_IRQ_GMX_DRP1     57
+#define OCTEON_IRQ_IPD_DRP      58
+#define OCTEON_IRQ_KEY_ZERO     59
+#define OCTEON_IRQ_TIMER0       60
+#define OCTEON_IRQ_TIMER1       61
+#define OCTEON_IRQ_TIMER2       62
+#define OCTEON_IRQ_TIMER3       63
+#define OCTEON_IRQ_USB0         64
+#define OCTEON_IRQ_PCM          65
+#define OCTEON_IRQ_MPI          66
+#define OCTEON_IRQ_TWSI2        67
+#define OCTEON_IRQ_POWIQ        68
+#define OCTEON_IRQ_IPDPPTHR     69
+#define OCTEON_IRQ_MII0         70
+#define OCTEON_IRQ_BOOTDMA      71
+/* 72 - 135 represent the sources in CIU_INTX_EN1 */
+#define OCTEON_IRQ_WDOG0        72
+#define OCTEON_IRQ_WDOG1        73
+#define OCTEON_IRQ_WDOG2        74
+#define OCTEON_IRQ_WDOG3        75
+#define OCTEON_IRQ_WDOG4        76
+#define OCTEON_IRQ_WDOG5        77
+#define OCTEON_IRQ_WDOG6        78
+#define OCTEON_IRQ_WDOG7        79
+#define OCTEON_IRQ_WDOG8        80
+#define OCTEON_IRQ_WDOG9        81
+#define OCTEON_IRQ_WDOG10       82
+#define OCTEON_IRQ_WDOG11       83
+#define OCTEON_IRQ_WDOG12       84
+#define OCTEON_IRQ_WDOG13       85
+#define OCTEON_IRQ_WDOG14       86
+#define OCTEON_IRQ_WDOG15       87
+#define OCTEON_IRQ_UART2        88
+#define OCTEON_IRQ_USB1         89
+#define OCTEON_IRQ_MII1         90
+#define OCTEON_IRQ_RESERVED91   91
+#define OCTEON_IRQ_RESERVED92   92
+#define OCTEON_IRQ_RESERVED93   93
+#define OCTEON_IRQ_RESERVED94   94
+#define OCTEON_IRQ_RESERVED95   95
+#define OCTEON_IRQ_RESERVED96   96
+#define OCTEON_IRQ_RESERVED97   97
+#define OCTEON_IRQ_RESERVED98   98
+#define OCTEON_IRQ_RESERVED99   99
+#define OCTEON_IRQ_RESERVED100  100
+#define OCTEON_IRQ_RESERVED101  101
+#define OCTEON_IRQ_RESERVED102  102
+#define OCTEON_IRQ_RESERVED103  103
+#define OCTEON_IRQ_RESERVED104  104
+#define OCTEON_IRQ_RESERVED105  105
+#define OCTEON_IRQ_RESERVED106  106
+#define OCTEON_IRQ_RESERVED107  107
+#define OCTEON_IRQ_RESERVED108  108
+#define OCTEON_IRQ_RESERVED109  109
+#define OCTEON_IRQ_RESERVED110  110
+#define OCTEON_IRQ_RESERVED111  111
+#define OCTEON_IRQ_RESERVED112  112
+#define OCTEON_IRQ_RESERVED113  113
+#define OCTEON_IRQ_RESERVED114  114
+#define OCTEON_IRQ_RESERVED115  115
+#define OCTEON_IRQ_RESERVED116  116
+#define OCTEON_IRQ_RESERVED117  117
+#define OCTEON_IRQ_RESERVED118  118
+#define OCTEON_IRQ_RESERVED119  119
+#define OCTEON_IRQ_RESERVED120  120
+#define OCTEON_IRQ_RESERVED121  121
+#define OCTEON_IRQ_RESERVED122  122
+#define OCTEON_IRQ_RESERVED123  123
+#define OCTEON_IRQ_RESERVED124  124
+#define OCTEON_IRQ_RESERVED125  125
+#define OCTEON_IRQ_RESERVED126  126
+#define OCTEON_IRQ_RESERVED127  127
+#define OCTEON_IRQ_RESERVED128  128
+#define OCTEON_IRQ_RESERVED129  129
+#define OCTEON_IRQ_RESERVED130  130
+#define OCTEON_IRQ_RESERVED131  131
+#define OCTEON_IRQ_RESERVED132  132
+#define OCTEON_IRQ_RESERVED133  133
+#define OCTEON_IRQ_RESERVED134  134
+#define OCTEON_IRQ_RESERVED135  135
+/* 136 - 143 are reserved to align the i8259 in a multiple of 16. This
+   alignment is necessary since old style ISA interrupts hanging off the i8259
+   have internal alignment assumptions */
+#define OCTEON_IRQ_RESERVED136  136
+#define OCTEON_IRQ_RESERVED137  137
+#define OCTEON_IRQ_RESERVED138  138
+#define OCTEON_IRQ_RESERVED139  139
+#define OCTEON_IRQ_RESERVED140  140
+#define OCTEON_IRQ_RESERVED141  141
+#define OCTEON_IRQ_RESERVED142  142
+#define OCTEON_IRQ_RESERVED143  143
+/* 144 - 151 represent the i8259 master */
+#define OCTEON_IRQ_I8259M0      144
+#define OCTEON_IRQ_I8259M1      145
+#define OCTEON_IRQ_I8259M2      146
+#define OCTEON_IRQ_I8259M3      147
+#define OCTEON_IRQ_I8259M4      148
+#define OCTEON_IRQ_I8259M5      149
+#define OCTEON_IRQ_I8259M6      150
+#define OCTEON_IRQ_I8259M7      151
+/* 152 - 159 represent the i8259 slave */
+#define OCTEON_IRQ_I8259S0      152
+#define OCTEON_IRQ_I8259S1      153
+#define OCTEON_IRQ_I8259S2      154
+#define OCTEON_IRQ_I8259S3      155
+#define OCTEON_IRQ_I8259S4      156
+#define OCTEON_IRQ_I8259S5      157
+#define OCTEON_IRQ_I8259S6      158
+#define OCTEON_IRQ_I8259S7      159
+#ifdef CONFIG_PCI_MSI
+/* 160 - 223 represent the MSI interrupts 0-63 */
+#define OCTEON_IRQ_MSI_BIT0     160
+#define OCTEON_IRQ_MSI_BIT1     161
+#define OCTEON_IRQ_MSI_BIT2     162
+#define OCTEON_IRQ_MSI_BIT3     163
+#define OCTEON_IRQ_MSI_BIT4     164
+#define OCTEON_IRQ_MSI_BIT5     165
+#define OCTEON_IRQ_MSI_BIT6     166
+#define OCTEON_IRQ_MSI_BIT7     167
+#define OCTEON_IRQ_MSI_BIT8     168
+#define OCTEON_IRQ_MSI_BIT9     169
+#define OCTEON_IRQ_MSI_BIT10    170
+#define OCTEON_IRQ_MSI_BIT11    171
+#define OCTEON_IRQ_MSI_BIT12    172
+#define OCTEON_IRQ_MSI_BIT13    173
+#define OCTEON_IRQ_MSI_BIT14    174
+#define OCTEON_IRQ_MSI_BIT15    175
+#define OCTEON_IRQ_MSI_BIT16    176
+#define OCTEON_IRQ_MSI_BIT17    177
+#define OCTEON_IRQ_MSI_BIT18    178
+#define OCTEON_IRQ_MSI_BIT19    179
+#define OCTEON_IRQ_MSI_BIT20    180
+#define OCTEON_IRQ_MSI_BIT21    181
+#define OCTEON_IRQ_MSI_BIT22    182
+#define OCTEON_IRQ_MSI_BIT23    183
+#define OCTEON_IRQ_MSI_BIT24    184
+#define OCTEON_IRQ_MSI_BIT25    185
+#define OCTEON_IRQ_MSI_BIT26    186
+#define OCTEON_IRQ_MSI_BIT27    187
+#define OCTEON_IRQ_MSI_BIT28    188
+#define OCTEON_IRQ_MSI_BIT29    189
+#define OCTEON_IRQ_MSI_BIT30    190
+#define OCTEON_IRQ_MSI_BIT31    191
+#define OCTEON_IRQ_MSI_BIT32    192
+#define OCTEON_IRQ_MSI_BIT33    193
+#define OCTEON_IRQ_MSI_BIT34    194
+#define OCTEON_IRQ_MSI_BIT35    195
+#define OCTEON_IRQ_MSI_BIT36    196
+#define OCTEON_IRQ_MSI_BIT37    197
+#define OCTEON_IRQ_MSI_BIT38    198
+#define OCTEON_IRQ_MSI_BIT39    199
+#define OCTEON_IRQ_MSI_BIT40    200
+#define OCTEON_IRQ_MSI_BIT41    201
+#define OCTEON_IRQ_MSI_BIT42    202
+#define OCTEON_IRQ_MSI_BIT43    203
+#define OCTEON_IRQ_MSI_BIT44    204
+#define OCTEON_IRQ_MSI_BIT45    205
+#define OCTEON_IRQ_MSI_BIT46    206
+#define OCTEON_IRQ_MSI_BIT47    207
+#define OCTEON_IRQ_MSI_BIT48    208
+#define OCTEON_IRQ_MSI_BIT49    209
+#define OCTEON_IRQ_MSI_BIT50    210
+#define OCTEON_IRQ_MSI_BIT51    211
+#define OCTEON_IRQ_MSI_BIT52    212
+#define OCTEON_IRQ_MSI_BIT53    213
+#define OCTEON_IRQ_MSI_BIT54    214
+#define OCTEON_IRQ_MSI_BIT55    215
+#define OCTEON_IRQ_MSI_BIT56    216
+#define OCTEON_IRQ_MSI_BIT57    217
+#define OCTEON_IRQ_MSI_BIT58    218
+#define OCTEON_IRQ_MSI_BIT59    219
+#define OCTEON_IRQ_MSI_BIT60    220
+#define OCTEON_IRQ_MSI_BIT61    221
+#define OCTEON_IRQ_MSI_BIT62    222
+#define OCTEON_IRQ_MSI_BIT63    223
+#define OCTEON_IRQ_LAST         224
+#else
+#define OCTEON_IRQ_LAST         160
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
diff --git a/arch/mips/include/asm/mach-cavium-octeon/octeon-hal-read-write.h b/arch/mips/include/asm/mach-cavium-octeon/octeon-hal-read-write.h
new file mode 100644
index 0000000..8c1dfc8
--- /dev/null
+++ b/arch/mips/include/asm/mach-cavium-octeon/octeon-hal-read-write.h
@@ -0,0 +1,38 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2004-2007 Cavium Networks
+ */
+#ifndef __CAVIUM_OCTEON_HAL_READ_WRITE_H__
+#define __CAVIUM_OCTEON_HAL_READ_WRITE_H__
+
+#include "cvmx.h"
+
+
+/**
+ * Write a 32bit value to the Octeon NPI register space
+ *
+ * @param address Address to write to
+ * @param val     Value to write
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
+ * @param address Address to read
+ * @return The result
+ */
+static inline uint32_t octeon_npi_read32(uint64_t address)
+{
+	return cvmx_read64_uint32(address ^ 4);
+}
+
+#endif
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
-- 
1.5.6.5
