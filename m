Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Aug 2018 05:03:46 +0200 (CEST)
Received: from mga18.intel.com ([134.134.136.126]:35550 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991162AbeHCDDiPZaKH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 3 Aug 2018 05:03:38 +0200
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Aug 2018 20:03:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,437,1526367600"; 
   d="scan'208";a="60074782"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by fmsmga008.fm.intel.com with ESMTP; 02 Aug 2018 20:03:29 -0700
From:   Songjun Wu <songjun.wu@linux.intel.com>
To:     hua.ma@linux.intel.com, yixin.zhu@linux.intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com
Cc:     linux-mips@linux-mips.org, linux-clk@vger.kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        Songjun Wu <songjun.wu@linux.intel.com>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH v2 01/18] MIPS: intel: Add initial support for Intel MIPS SoCs
Date:   Fri,  3 Aug 2018 11:02:20 +0800
Message-Id: <20180803030237.3366-2-songjun.wu@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180803030237.3366-1-songjun.wu@linux.intel.com>
References: <20180803030237.3366-1-songjun.wu@linux.intel.com>
Return-Path: <songjun.wu@linux.intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65361
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: songjun.wu@linux.intel.com
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

From: Hua Ma <hua.ma@linux.intel.com>

Add initial support for Intel MIPS interAptiv SoCs made by Intel.
This series will add support for the grx500 family.

The series allows booting a minimal system using a initramfs.

Signed-off-by: Hua Ma <hua.ma@linux.intel.com>
Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
---

Changes in v2:
- Remove unused _END macros
- Remove the redundant check and not accurate comments
- Replace the get_counter_resolution function with fixed value 2
- Use obj-y and split into per line per .o
- Add EVA mapping description in code comments
- Remove unused include header file
- Do a clean-up for grx500_defconfig

 arch/mips/Kbuild.platforms                         |   1 +
 arch/mips/Kconfig                                  |  29 ++++
 arch/mips/configs/grx500_defconfig                 | 138 +++++++++++++++++
 .../asm/mach-intel-mips/cpu-feature-overrides.h    |  61 ++++++++
 arch/mips/include/asm/mach-intel-mips/ioremap.h    |  39 +++++
 arch/mips/include/asm/mach-intel-mips/irq.h        |  17 ++
 .../asm/mach-intel-mips/kernel-entry-init.h        | 104 +++++++++++++
 arch/mips/include/asm/mach-intel-mips/spaces.h     |  27 ++++
 arch/mips/include/asm/mach-intel-mips/war.h        |  18 +++
 arch/mips/intel-mips/Kconfig                       |  22 +++
 arch/mips/intel-mips/Makefile                      |   5 +
 arch/mips/intel-mips/Platform                      |  12 ++
 arch/mips/intel-mips/irq.c                         |  35 +++++
 arch/mips/intel-mips/prom.c                        | 172 +++++++++++++++++++++
 arch/mips/intel-mips/time.c                        |  42 +++++
 15 files changed, 722 insertions(+)
 create mode 100644 arch/mips/configs/grx500_defconfig
 create mode 100644 arch/mips/include/asm/mach-intel-mips/cpu-feature-overrides.h
 create mode 100644 arch/mips/include/asm/mach-intel-mips/ioremap.h
 create mode 100644 arch/mips/include/asm/mach-intel-mips/irq.h
 create mode 100644 arch/mips/include/asm/mach-intel-mips/kernel-entry-init.h
 create mode 100644 arch/mips/include/asm/mach-intel-mips/spaces.h
 create mode 100644 arch/mips/include/asm/mach-intel-mips/war.h
 create mode 100644 arch/mips/intel-mips/Kconfig
 create mode 100644 arch/mips/intel-mips/Makefile
 create mode 100644 arch/mips/intel-mips/Platform
 create mode 100644 arch/mips/intel-mips/irq.c
 create mode 100644 arch/mips/intel-mips/prom.c
 create mode 100644 arch/mips/intel-mips/time.c

diff --git a/arch/mips/Kbuild.platforms b/arch/mips/Kbuild.platforms
index ac7ad54f984f..bcd647060f3e 100644
--- a/arch/mips/Kbuild.platforms
+++ b/arch/mips/Kbuild.platforms
@@ -12,6 +12,7 @@ platforms += cobalt
 platforms += dec
 platforms += emma
 platforms += generic
+platforms += intel-mips
 platforms += jazz
 platforms += jz4740
 platforms += lantiq
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 08c10c518f83..2d34f17f3e24 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -409,6 +409,34 @@ config LANTIQ
 	select ARCH_HAS_RESET_CONTROLLER
 	select RESET_CONTROLLER
 
+config INTEL_MIPS
+	bool "Intel MIPS interAptiv SoC based platforms"
+	select BOOT_RAW
+	select CEVT_R4K
+	select COMMON_CLK
+	select CPU_MIPS32_3_5_EVA
+	select CPU_MIPS32_3_5_FEATURES
+	select CPU_MIPSR2_IRQ_EI
+	select CPU_MIPSR2_IRQ_VI
+	select CSRC_R4K
+	select DMA_NONCOHERENT
+	select GENERIC_ISA_DMA
+	select IRQ_MIPS_CPU
+	select MFD_CORE
+	select MFD_SYSCON
+	select MIPS_CPU_SCACHE
+	select MIPS_GIC
+	select SYS_HAS_CPU_MIPS32_R1
+	select SYS_HAS_CPU_MIPS32_R2
+	select SYS_HAS_CPU_MIPS32_R3_5
+	select SYS_SUPPORTS_BIG_ENDIAN
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_MIPS_CPS
+	select SYS_SUPPORTS_MULTITHREADING
+	select SYS_SUPPORTS_ZBOOT
+	select TIMER_OF
+	select USE_OF
+
 config LASAT
 	bool "LASAT Networks platforms"
 	select CEVT_R4K
@@ -1016,6 +1044,7 @@ source "arch/mips/bcm47xx/Kconfig"
 source "arch/mips/bcm63xx/Kconfig"
 source "arch/mips/bmips/Kconfig"
 source "arch/mips/generic/Kconfig"
+source "arch/mips/intel-mips/Kconfig"
 source "arch/mips/jazz/Kconfig"
 source "arch/mips/jz4740/Kconfig"
 source "arch/mips/lantiq/Kconfig"
diff --git a/arch/mips/configs/grx500_defconfig b/arch/mips/configs/grx500_defconfig
new file mode 100644
index 000000000000..9dd7ba8e1f74
--- /dev/null
+++ b/arch/mips/configs/grx500_defconfig
@@ -0,0 +1,138 @@
+CONFIG_INTEL_MIPS=y
+CONFIG_DTB_INTEL_MIPS_GRX500=y
+CONFIG_CPU_MIPS32_R2=y
+CONFIG_SCHED_SMT=y
+# CONFIG_MIPS_MT_FPAFF is not set
+CONFIG_MIPS_CPS=y
+CONFIG_DEFAULT_MMAP_MIN_ADDR=65536
+CONFIG_NR_CPUS=2
+CONFIG_HZ_100=y
+# CONFIG_SECCOMP is not set
+# CONFIG_LOCALVERSION_AUTO is not set
+CONFIG_DEFAULT_HOSTNAME="GRX500"
+CONFIG_SYSVIPC=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_LOG_BUF_SHIFT=18
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS_SOURCE=""
+# CONFIG_RD_GZIP is not set
+# CONFIG_RD_BZIP2 is not set
+# CONFIG_RD_LZMA is not set
+# CONFIG_RD_LZO is not set
+# CONFIG_RD_LZ4 is not set
+CONFIG_INITRAMFS_COMPRESSION_XZ=y
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+CONFIG_SYSCTL_SYSCALL=y
+# CONFIG_FHANDLE is not set
+# CONFIG_AIO is not set
+CONFIG_EMBEDDED=y
+# CONFIG_SLUB_DEBUG is not set
+# CONFIG_COMPAT_BRK is not set
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODVERSIONS=y
+# CONFIG_LBDAF is not set
+# CONFIG_BLK_DEV_BSG is not set
+# CONFIG_BLK_DEBUG_FS is not set
+# CONFIG_SUSPEND is not set
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_INET=y
+# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
+# CONFIG_INET_XFRM_MODE_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_BEET is not set
+CONFIG_IPV6_MULTIPLE_TABLES=y
+CONFIG_IPV6_SUBTREES=y
+CONFIG_IPV6_MROUTE=y
+CONFIG_NETFILTER=y
+CONFIG_NF_CONNTRACK=m
+CONFIG_NF_CONNTRACK_MARK=y
+CONFIG_NETFILTER_XT_MARK=m
+CONFIG_NETFILTER_XT_TARGET_LOG=m
+CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
+CONFIG_NETFILTER_XT_MATCH_COMMENT=m
+CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
+CONFIG_NETFILTER_XT_MATCH_LIMIT=m
+CONFIG_NETFILTER_XT_MATCH_MAC=m
+CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
+CONFIG_NETFILTER_XT_MATCH_STATE=m
+CONFIG_NETFILTER_XT_MATCH_TIME=m
+CONFIG_NF_CONNTRACK_IPV4=m
+CONFIG_IP_NF_IPTABLES=m
+CONFIG_IP_NF_FILTER=m
+CONFIG_IP_NF_TARGET_REJECT=m
+CONFIG_IP_NF_NAT=m
+CONFIG_IP_NF_TARGET_MASQUERADE=m
+CONFIG_IP_NF_TARGET_REDIRECT=m
+CONFIG_IP_NF_MANGLE=m
+CONFIG_NF_CONNTRACK_IPV6=m
+CONFIG_IP6_NF_IPTABLES=m
+CONFIG_IP6_NF_FILTER=m
+CONFIG_IP6_NF_TARGET_REJECT=m
+CONFIG_IP6_NF_MANGLE=m
+CONFIG_ATM=m
+CONFIG_ATM_BR2684=m
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=4
+CONFIG_BLK_DEV_RAM_SIZE=8192
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
+# CONFIG_SERIO is not set
+# CONFIG_CONSOLE_TRANSLATIONS is not set
+# CONFIG_VT_CONSOLE is not set
+# CONFIG_LEGACY_PTYS is not set
+# CONFIG_DEVMEM is not set
+CONFIG_SERIAL_LANTIQ=y
+# CONFIG_HW_RANDOM is not set
+# CONFIG_HWMON is not set
+# CONFIG_VGA_CONSOLE is not set
+# CONFIG_HID is not set
+# CONFIG_USB_SUPPORT is not set
+# CONFIG_VIRTIO_MENU is not set
+# CONFIG_MIPS_PLATFORM_DEVICES is not set
+CONFIG_INTEL_CGU_CLK=y
+# CONFIG_IOMMU_SUPPORT is not set
+# CONFIG_MANDATORY_FILE_LOCKING is not set
+CONFIG_QUOTA=y
+# CONFIG_PRINT_QUOTA_WARNING is not set
+CONFIG_AUTOFS4_FS=y
+CONFIG_PROC_KCORE=y
+# CONFIG_PROC_PAGE_MONITOR is not set
+CONFIG_PROC_CHILDREN=y
+CONFIG_TMPFS=y
+CONFIG_TMPFS_XATTR=y
+CONFIG_CONFIGFS_FS=y
+CONFIG_SQUASHFS=y
+CONFIG_SQUASHFS_XATTR=y
+CONFIG_SQUASHFS_LZ4=y
+CONFIG_SQUASHFS_LZO=y
+CONFIG_SQUASHFS_XZ=y
+CONFIG_NLS=y
+CONFIG_PRINTK_TIME=y
+CONFIG_BOOT_PRINTK_DELAY=y
+CONFIG_DEBUG_INFO=y
+# CONFIG_ENABLE_WARN_DEPRECATED is not set
+CONFIG_FRAME_WARN=2048
+CONFIG_STRIP_ASM_SYMS=y
+CONFIG_UNUSED_SYMBOLS=y
+CONFIG_DEBUG_FS=y
+CONFIG_HEADERS_CHECK=y
+CONFIG_MAGIC_SYSRQ=y
+# CONFIG_SCHED_DEBUG is not set
+CONFIG_DEBUG_RT_MUTEXES=y
+CONFIG_DEBUG_ATOMIC_SLEEP=y
+# CONFIG_RCU_TRACE is not set
+# CONFIG_FTRACE is not set
+# CONFIG_RUNTIME_TESTING_MENU is not set
+CONFIG_CRYPTO_CCM=y
+CONFIG_CRYPTO_GCM=y
+# CONFIG_CRYPTO_ECHAINIV is not set
+CONFIG_CRYPTO_ARC4=y
+CONFIG_CRYPTO_LZO=y
+# CONFIG_CRYPTO_HW is not set
+CONFIG_CRC_CCITT=y
+CONFIG_CRC16=y
+CONFIG_CRC_T10DIF=y
+CONFIG_LIBCRC32C=y
+CONFIG_IRQ_POLL=y
diff --git a/arch/mips/include/asm/mach-intel-mips/cpu-feature-overrides.h b/arch/mips/include/asm/mach-intel-mips/cpu-feature-overrides.h
new file mode 100644
index 000000000000..ac5f3b943d2a
--- /dev/null
+++ b/arch/mips/include/asm/mach-intel-mips/cpu-feature-overrides.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * This file was derived from: include/asm-mips/cpu-features.h
+ *	Copyright (C) 2003, 2004 Ralf Baechle
+ *	Copyright (C) 2004 Maciej W. Rozycki
+ *	Copyright (C) 2018 Intel Corporation.
+ */
+
+#ifndef __ASM_MACH_INTEL_MIPS_CPU_FEATURE_OVERRIDES_H
+#define __ASM_MACH_INTEL_MIPS_CPU_FEATURE_OVERRIDES_H
+
+#define cpu_has_tlb		1
+#define cpu_has_4kex		1
+#define cpu_has_3k_cache	0
+#define cpu_has_4k_cache	1
+#define cpu_has_tx39_cache	0
+#define cpu_has_sb1_cache	0
+#define cpu_has_fpu		0
+#define cpu_has_32fpr		0
+#define cpu_has_counter		1
+#define cpu_has_watch		1
+#define cpu_has_divec		1
+
+#define cpu_has_prefetch	1
+#define cpu_has_ejtag		1
+#define cpu_has_llsc		1
+
+#define cpu_has_mips16		0
+#define cpu_has_mdmx		0
+#define cpu_has_mips3d		0
+#define cpu_has_smartmips	0
+#define cpu_has_mmips		0
+#define cpu_has_vz		0
+
+#define cpu_has_mips32r1	1
+#define cpu_has_mips32r2	1
+#define cpu_has_mips64r1	0
+#define cpu_has_mips64r2	0
+
+#define cpu_has_dsp		1
+#define cpu_has_dsp2		0
+#define cpu_has_mipsmt		1
+
+#define cpu_has_vint		1
+#define cpu_has_veic		0
+
+#define cpu_has_64bits		0
+#define cpu_has_64bit_zero_reg	0
+#define cpu_has_64bit_gp_regs	0
+#define cpu_has_64bit_addresses	0
+
+#define cpu_has_cm2		1
+#define cpu_has_cm2_l2sync	1
+#define cpu_has_eva		1
+#define cpu_has_tlbinv		1
+
+#define cpu_dcache_line_size()	32
+#define cpu_icache_line_size()	32
+#define cpu_scache_line_size()	32
+
+#endif /* __ASM_MACH_INTEL_MIPS_CPU_FEATURE_OVERRIDES_H */
diff --git a/arch/mips/include/asm/mach-intel-mips/ioremap.h b/arch/mips/include/asm/mach-intel-mips/ioremap.h
new file mode 100644
index 000000000000..99b20ed0b457
--- /dev/null
+++ b/arch/mips/include/asm/mach-intel-mips/ioremap.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *  Copyright (C) 2014 Lei Chuanhua <Chuanhua.lei@lantiq.com>
+ *  Copyright (C) 2018 Intel Corporation.
+ */
+#ifndef __ASM_MACH_INTEL_MIPS_IOREMAP_H
+#define __ASM_MACH_INTEL_MIPS_IOREMAP_H
+
+#include <linux/types.h>
+
+static inline phys_addr_t fixup_bigphys_addr(phys_addr_t phys_addr,
+					     phys_addr_t size)
+{
+	return phys_addr;
+}
+
+/*
+ * TOP IO Space definition for SSX7 components /PCIe/ToE/Memcpy
+ * physical 0xa0000000 --> virtual 0xe0000000
+ */
+#define GRX500_TOP_IOREMAP_BASE			0xA0000000
+#define GRX500_TOP_IOREMAP_SIZE			0x20000000
+#define GRX500_TOP_IOREMAP_PHYS_VIRT_OFFSET	0x40000000
+
+static inline void __iomem *plat_ioremap(phys_addr_t offset, unsigned long size,
+					 unsigned long flags)
+{
+	if (offset >= GRX500_TOP_IOREMAP_BASE &&
+	    offset < (GRX500_TOP_IOREMAP_BASE + GRX500_TOP_IOREMAP_SIZE))
+		return (void __iomem *)(unsigned long)
+			(offset + GRX500_TOP_IOREMAP_PHYS_VIRT_OFFSET);
+	return NULL;
+}
+
+static inline int plat_iounmap(const volatile void __iomem *addr)
+{
+	return (unsigned long)addr >= (unsigned long)GRX500_TOP_IOREMAP_BASE;
+}
+#endif /* __ASM_MACH_INTEL_MIPS_IOREMAP_H */
diff --git a/arch/mips/include/asm/mach-intel-mips/irq.h b/arch/mips/include/asm/mach-intel-mips/irq.h
new file mode 100644
index 000000000000..12a949084856
--- /dev/null
+++ b/arch/mips/include/asm/mach-intel-mips/irq.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *  Copyright (C) 2014 Lei Chuanhua <Chuanhua.lei@lantiq.com>
+ *  Copyright (C) 2018 Intel Corporation.
+ */
+
+#ifndef __INTEL_MIPS_IRQ_H
+#define __INTEL_MIPS_IRQ_H
+
+#define MIPS_CPU_IRQ_BASE	0
+#define MIPS_GIC_IRQ_BASE	(MIPS_CPU_IRQ_BASE + 8)
+
+#define NR_IRQS 256
+
+#include_next <irq.h>
+
+#endif /* __INTEL_MIPS_IRQ_H */
diff --git a/arch/mips/include/asm/mach-intel-mips/kernel-entry-init.h b/arch/mips/include/asm/mach-intel-mips/kernel-entry-init.h
new file mode 100644
index 000000000000..a30542eca9ec
--- /dev/null
+++ b/arch/mips/include/asm/mach-intel-mips/kernel-entry-init.h
@@ -0,0 +1,104 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Chris Dearman (chris@mips.com)
+ * Leonid Yegoshin (yegoshin@mips.com)
+ * Copyright (C) 2012 Mips Technologies, Inc.
+ * Copyright (C) 2018 Intel Corporation.
+ */
+#ifndef __ASM_MACH_INTEL_MIPS_KERNEL_ENTRY_INIT_H
+#define __ASM_MACH_INTEL_MIPS_KERNEL_ENTRY_INIT_H
+/*
+* Prepare segments for EVA boot:
+*
+* This is in case the processor boots in legacy configuration
+* (SI_EVAReset is de-asserted and CONFIG5.K == 0) with 1GB DDR
+*
+* On entry, t1 is loaded with CP0_CONFIG
+*
+* ========================= Mappings =============================
+* Virtual memory           Physical memory            Mapping
+* 0x00000000 - 0x7fffffff  0x20000000 - 0x9ffffffff   MUSUK (kuseg)
+* 0x80000000 - 0x9fffffff  0x80000000 - 0x9ffffffff   UK    (kseg0)
+* 0xa0000000 - 0xbfffffff  0x20000000 - 0x3ffffffff   UK    (kseg1)
+* 0xc0000000 - 0xdfffffff             -               MSK   (kseg2)
+* 0xe0000000 - 0xffffffff  0xa0000000 - 0xbfffffff    UK     2nd IO
+*
+* user space virtual:   0x00000000 ~ 0x7fffffff
+* kernel space virtual: 0x60000000 ~ 0x9fffffff
+*                  physical: 0x20000000 ~ 0x5fffffff (flat 1GB)
+* user/kernel space overlapped from 0x60000000 ~ 0x7fffffff (virtual)
+* where physical 0x20000000 ~ 0x2fffffff (cached and uncached)
+*           virtual  0xa0000000 ~ 0xafffffff (1st IO space)
+*           virtual  0xf0000000 ~ 0xffffffff (2nd IO space)
+*
+* The last 64KB of physical memory are reserved for correct HIGHMEM
+* macros arithmetics.
+* Detailed KSEG and PHYS_OFFSET and PAGE_OFFSEt adaption, refer to
+* asm/mach-intel-mips/spaces.h
+*/
+	.macro  platform_eva_init
+
+	.set    push
+	.set    reorder
+	/*
+	 * Get Config.K0 value and use it to program
+	 * the segmentation registers
+	 */
+	mfc0    t1, CP0_CONFIG
+	andi    t1, 0x7 /* CCA */
+	move    t2, t1
+	ins     t2, t1, 16, 3
+	/* SegCtl0 */
+	li      t0, ((MIPS_SEGCFG_UK << MIPS_SEGCFG_AM_SHIFT) |              \
+		(5 << MIPS_SEGCFG_PA_SHIFT) | (2 << MIPS_SEGCFG_C_SHIFT) |   \
+		(1 << MIPS_SEGCFG_EU_SHIFT)) |                               \
+		(((MIPS_SEGCFG_MSK << MIPS_SEGCFG_AM_SHIFT) |                \
+		(0 << MIPS_SEGCFG_PA_SHIFT) |                                \
+		(1 << MIPS_SEGCFG_EU_SHIFT)) << 16)
+	ins     t0, t1, 16, 3
+	mtc0    t0, $5, 2
+
+	/* SegCtl1 */
+	li      t0, ((MIPS_SEGCFG_UK << MIPS_SEGCFG_AM_SHIFT) |              \
+		(1 << MIPS_SEGCFG_PA_SHIFT) | (2 << MIPS_SEGCFG_C_SHIFT) |   \
+		(1 << MIPS_SEGCFG_EU_SHIFT)) |                               \
+		(((MIPS_SEGCFG_UK << MIPS_SEGCFG_AM_SHIFT) |                 \
+		(2 << MIPS_SEGCFG_PA_SHIFT) |                                \
+		(1 << MIPS_SEGCFG_EU_SHIFT)) << 16)
+	ins     t0, t1, 16, 3
+	mtc0    t0, $5, 3
+
+	/* SegCtl2 */
+	li      t0, ((MIPS_SEGCFG_MUSUK << MIPS_SEGCFG_AM_SHIFT) |           \
+		(0 << MIPS_SEGCFG_PA_SHIFT) |                                \
+		(1 << MIPS_SEGCFG_EU_SHIFT)) |                               \
+		(((MIPS_SEGCFG_MUSK << MIPS_SEGCFG_AM_SHIFT) |               \
+		(0 << MIPS_SEGCFG_PA_SHIFT)/*| (2 << MIPS_SEGCFG_C_SHIFT)*/ | \
+		(1 << MIPS_SEGCFG_EU_SHIFT)) << 16)
+	ins     t0, t1, 0, 3
+	mtc0    t0, $5, 4
+
+	jal     mips_ihb
+	mfc0    t0, $16, 5
+	li      t2, 0x40000000      /* K bit */
+	or      t0, t0, t2
+	mtc0    t0, $16, 5
+	sync
+	jal     mips_ihb
+
+	.set    pop
+	.endm
+
+	.macro	kernel_entry_setup
+	sync
+	ehb
+	platform_eva_init
+	.endm
+
+	.macro	smp_slave_setup
+	sync
+	ehb
+	platform_eva_init
+	.endm
+
+#endif /* __ASM_MACH_INTEL_MIPS_KERNEL_ENTRY_INIT_H */
diff --git a/arch/mips/include/asm/mach-intel-mips/spaces.h b/arch/mips/include/asm/mach-intel-mips/spaces.h
new file mode 100644
index 000000000000..80e7b09f712c
--- /dev/null
+++ b/arch/mips/include/asm/mach-intel-mips/spaces.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Author: Leonid Yegoshin (yegoshin@mips.com)
+ * Copyright (C) 2012 MIPS Technologies, Inc.
+ * Copyright (C) 2014 Lei Chuanhua <Chuanhua.lei@lantiq.com>
+ * Copyright (C) 2018 Intel Corporation.
+ */
+
+#ifndef _ASM_INTEL_MIPS_SPACES_H
+#define _ASM_INTEL_MIPS_SPACES_H
+
+#define PAGE_OFFSET		_AC(0x60000000, UL)
+#define PHYS_OFFSET		_AC(0x20000000, UL)
+
+/* No Highmem Support */
+#define HIGHMEM_START		_AC(0xffff0000, UL)
+
+#define FIXADDR_TOP		((unsigned long)(long)(int)0xcffe0000)
+
+#define IO_SIZE			_AC(0x10000000, UL)
+#define IO_SHIFT		_AC(0x10000000, UL)
+
+/* IO space one */
+#define __pa_symbol(x)		__pa(x)
+
+#include <asm/mach-generic/spaces.h>
+#endif /* __ASM_INTEL_MIPS_SPACES_H */
diff --git a/arch/mips/include/asm/mach-intel-mips/war.h b/arch/mips/include/asm/mach-intel-mips/war.h
new file mode 100644
index 000000000000..1c95553151e1
--- /dev/null
+++ b/arch/mips/include/asm/mach-intel-mips/war.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_MIPS_MACH_INTEL_MIPS_WAR_H
+#define __ASM_MIPS_MACH_INTEL_MIPS_WAR_H
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
+#define ICACHE_REFILLS_WORKAROUND_WAR	0
+#define R10000_LLSC_WAR			0
+#define MIPS34K_MISSED_ITLB_WAR		0
+
+#endif /* __ASM_MIPS_MACH_INTEL_MIPS_WAR_H */
diff --git a/arch/mips/intel-mips/Kconfig b/arch/mips/intel-mips/Kconfig
new file mode 100644
index 000000000000..35d2ae2b5408
--- /dev/null
+++ b/arch/mips/intel-mips/Kconfig
@@ -0,0 +1,22 @@
+if INTEL_MIPS
+
+choice
+	prompt "Built-in device tree"
+	help
+	  Legacy bootloaders do not pass a DTB pointer to the kernel, so
+	  if a "wrapper" is not being used, the kernel will need to include
+	  a device tree that matches the target board.
+
+	  The builtin DTB will only be used if the firmware does not supply
+	  a valid DTB.
+
+config DTB_INTEL_MIPS_NONE
+	bool "None"
+
+config DTB_INTEL_MIPS_GRX500
+	bool "Intel MIPS GRX500 Board"
+	select BUILTIN_DTB
+
+endchoice
+
+endif
diff --git a/arch/mips/intel-mips/Makefile b/arch/mips/intel-mips/Makefile
new file mode 100644
index 000000000000..9067d0dd20a0
--- /dev/null
+++ b/arch/mips/intel-mips/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-y += prom.o
+obj-y += irq.o
+obj-y += time.o
diff --git a/arch/mips/intel-mips/Platform b/arch/mips/intel-mips/Platform
new file mode 100644
index 000000000000..3976788698e3
--- /dev/null
+++ b/arch/mips/intel-mips/Platform
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# MIPS SoC platform
+#
+
+platform-$(CONFIG_INTEL_MIPS)			+= intel-mips/
+cflags-$(CONFIG_INTEL_MIPS)			+= -I$(srctree)/arch/mips/include/asm/mach-intel-mips
+ifdef CONFIG_EVA
+	load-$(CONFIG_INTEL_MIPS)		= 0xffffffff60020000
+else
+	load-$(CONFIG_INTEL_MIPS)		= 0xffffffff80020000
+endif
diff --git a/arch/mips/intel-mips/irq.c b/arch/mips/intel-mips/irq.c
new file mode 100644
index 000000000000..b126c98fb391
--- /dev/null
+++ b/arch/mips/intel-mips/irq.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2016 Intel Corporation.
+ */
+#include <linux/init.h>
+#include <linux/irqchip.h>
+#include <linux/of_irq.h>
+#include <asm/irq.h>
+#include <asm/irq_cpu.h>
+
+void __init arch_init_irq(void)
+{
+	struct device_node *intc_node;
+
+	pr_info("EIC is %s\n", cpu_has_veic ? "on" : "off");
+	pr_info("VINT is %s\n", cpu_has_vint ? "on" : "off");
+
+	intc_node = of_find_compatible_node(NULL, NULL,
+					    "mti,cpu-interrupt-controller");
+	if (!cpu_has_veic && !intc_node)
+		mips_cpu_irq_init();
+
+	irqchip_init();
+}
+
+int get_c0_perfcount_int(void)
+{
+	return gic_get_c0_perfcount_int();
+}
+EXPORT_SYMBOL_GPL(get_c0_perfcount_int);
+
+unsigned int get_c0_compare_int(void)
+{
+	return gic_get_c0_compare_int();
+}
diff --git a/arch/mips/intel-mips/prom.c b/arch/mips/intel-mips/prom.c
new file mode 100644
index 000000000000..a1b1393c13bc
--- /dev/null
+++ b/arch/mips/intel-mips/prom.c
@@ -0,0 +1,172 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2014 Lei Chuanhua <Chuanhua.lei@lantiq.com>
+ * Copyright (C) 2016 Intel Corporation.
+ */
+#include <linux/export.h>
+#include <linux/init.h>
+#include <linux/of_platform.h>
+#include <linux/of_fdt.h>
+#include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
+#include <asm/dma-coherence.h>
+#include <asm/mips-cps.h>
+#include <asm/prom.h>
+#include <asm/smp-ops.h>
+
+#define CPC_BASE_ADDR		0x12310000
+#define IOPORT_RESOURCE_START   0x10000000
+#define IOMEM_RESOURCE_START    0x10000000
+
+const char *get_system_type(void)
+{
+	return "Intel MIPS interAptiv SoC";
+}
+
+void prom_free_prom_memory(void)
+{
+}
+
+static void __init prom_init_cmdline(void)
+{
+	int i;
+	int argc;
+	char **argv;
+
+	/*
+	 * If u-boot pass parameters, it is ok, however, if without u-boot
+	 * JTAG or other tool has to reset all register value before it goes
+	 * emulation most likely belongs to this category
+	 */
+	if (fw_arg0 == 0 || fw_arg1 == 0)
+		return;
+
+	/*
+	 * a0: fw_arg0 - the number of string in init cmdline
+	 * a1: fw_arg1 - the address of string in init cmdline
+	 *
+	 * In accordance with the MIPS UHI specification,
+	 * the bootloader can pass the following arguments to the kernel:
+	 * - $a0: -2.
+	 * - $a1: KSEG0 address of the flattened device-tree blob.
+	 */
+	if (fw_arg0 == -2)
+		return;
+
+	argc = fw_arg0;
+	argv = (char **)KSEG1ADDR(fw_arg1);
+
+	arcs_cmdline[0] = '\0';
+
+	for (i = 0; i < argc; i++) {
+		char *p = (char *)KSEG1ADDR(argv[i]);
+
+		if (argv[i] && *p) {
+			strlcat(arcs_cmdline, p, sizeof(arcs_cmdline));
+			strlcat(arcs_cmdline, " ", sizeof(arcs_cmdline));
+		}
+	}
+}
+
+static int __init plat_enable_iocoherency(void)
+{
+	if (!mips_cps_numiocu(0))
+		return 0;
+
+	/* Nothing special needs to be done to enable coherency */
+	pr_info("Coherence Manager IOCU detected\n");
+	/* Second IOCU for MPE or other master access register */
+	write_gcr_reg0_base(0xa0000000);
+	write_gcr_reg0_mask(0xf8000000 | CM_GCR_REGn_MASK_CMTGT_IOCU1);
+	return 1;
+}
+
+static void __init plat_setup_iocoherency(void)
+{
+	if (plat_enable_iocoherency() &&
+	    coherentio == IO_COHERENCE_DISABLED) {
+		pr_info("Hardware DMA cache coherency disabled\n");
+		return;
+	}
+	panic("This kind of IO coherency is not supported!");
+}
+
+static void free_init_pages_eva_intel(void *begin, void *end)
+{
+	free_init_pages("unused kernel", __pa_symbol((unsigned long *)begin),
+			__pa_symbol((unsigned long *)end));
+}
+
+static void plat_early_init_devtree(void)
+{
+	void *dtb = NULL;
+
+	/*
+	 * Load the builtin devicetree. This causes the chosen node to be
+	 * parsed resulting in our memory appearing
+	 */
+	if (fw_passed_dtb) /* used by CONFIG_MIPS_APPENDED_RAW_DTB as well */
+		dtb = (void *)fw_passed_dtb;
+	else if (__dtb_start != __dtb_end)
+		dtb = (void *)__dtb_start;
+	else
+		panic("no dtb found");
+
+	if (dtb)
+		__dt_setup_arch(dtb);
+}
+
+void __init plat_mem_setup(void)
+{
+	ioport_resource.start = IOPORT_RESOURCE_START;
+	ioport_resource.end = ~0UL; /* No limit */
+	iomem_resource.start = IOMEM_RESOURCE_START;
+	iomem_resource.end = ~0UL; /* No limit */
+
+	set_io_port_base((unsigned long)KSEG1);
+
+	strlcpy(arcs_cmdline, boot_command_line, COMMAND_LINE_SIZE);
+
+	plat_early_init_devtree();
+	plat_setup_iocoherency();
+
+	if (IS_ENABLED(CONFIG_EVA))
+		free_init_pages_eva = free_init_pages_eva_intel;
+	else
+		free_init_pages_eva = 0;
+}
+
+void __init device_tree_init(void)
+{
+	unflatten_and_copy_device_tree();
+}
+
+phys_addr_t mips_cpc_default_phys_base(void)
+{
+	return CPC_BASE_ADDR;
+}
+
+void __init prom_init(void)
+{
+	prom_init_cmdline();
+
+	mips_cpc_probe();
+
+	if (!register_cps_smp_ops())
+		return;
+
+	if (!register_cmp_smp_ops())
+		return;
+
+	if (!register_vsmp_smp_ops())
+		return;
+}
+
+static int __init plat_publish_devices(void)
+{
+	if (!of_have_populated_dt())
+		return 0;
+	return of_platform_populate(NULL, of_default_bus_match_table, NULL,
+				    NULL);
+}
+arch_initcall(plat_publish_devices);
diff --git a/arch/mips/intel-mips/time.c b/arch/mips/intel-mips/time.c
new file mode 100644
index 000000000000..deb462c21df6
--- /dev/null
+++ b/arch/mips/intel-mips/time.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2016 Intel Corporation.
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/clocksource.h>
+#include <linux/of.h>
+
+#include <asm/time.h>
+
+void __init plat_time_init(void)
+{
+	unsigned long cpuclk;
+	struct device_node *np;
+	struct clk *clk;
+
+	of_clk_init(NULL);
+
+	np = of_get_cpu_node(0, NULL);
+	if (!np) {
+		pr_err("Failed to get CPU node\n");
+		return;
+	}
+
+	clk = of_clk_get(np, 0);
+	if (IS_ERR(clk)) {
+		pr_err("Failed to get CPU clock: %ld\n", PTR_ERR(clk));
+		return;
+	}
+
+	cpuclk = clk_get_rate(clk);
+	/* the chip resolution is the half of the clock*/
+	mips_hpt_frequency = cpuclk / 2;
+	clk_put(clk);
+
+	write_c0_compare(read_c0_count());
+	pr_info("CPU Clock: %ldHz  mips_hpt_frequency %dHz\n",
+		cpuclk, mips_hpt_frequency);
+	timer_probe();
+}
-- 
2.11.0
