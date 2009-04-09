Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Apr 2009 05:50:54 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:40351 "EHLO lemote.com")
	by ftp.linux-mips.org with ESMTP id S20031508AbZDIEun (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 9 Apr 2009 05:50:43 +0100
Received: from localhost (localhost [127.0.0.1])
	by lemote.com (Postfix) with ESMTP id ADE8134131;
	Thu,  9 Apr 2009 12:47:36 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at lemote.com
Received: from lemote.com ([127.0.0.1])
	by localhost (www.lemote.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OJAhnwXk0hEq; Thu,  9 Apr 2009 12:47:24 +0800 (CST)
Received: from [127.0.0.1] (unknown [222.92.8.142])
	by lemote.com (Postfix) with ESMTP id B1AC93412F;
	Thu,  9 Apr 2009 12:47:24 +0800 (CST)
Message-ID: <49DD7E88.7040305@lemote.com>
Date:	Thu, 09 Apr 2009 12:50:16 +0800
From:	yanhua <yanh@lemote.com>
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
CC:	=?GB2312?B?xe3Bwb31?= <penglj@lemote.com>,
	"zhangfx@lemote.com" <zhangfx@lemote.com>
Subject: [PATCH 1/14] lemote: Loongson2F based machines support
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Return-Path: <yanh@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22287
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yanh@lemote.com
Precedence: bulk
X-list: linux-mips

Mini fuloong, yeeloong are all Loongson2F based systems. Loongson2F have
builtin DDR2 and PCIX controller. The PCIX controller have a similar
programming interface with FPGA northbridge used in Loongson2E.
---
arch/mips/Kconfig | 9 +-
arch/mips/Makefile | 19 +
arch/mips/include/asm/mach-lemote/dma-coherence.h | 11 +
arch/mips/include/asm/mips-boards/bonito64.h | 2 +-
arch/mips/lemote/lm2f/Kconfig | 70 +
arch/mips/lemote/lm2f/common/Makefile | 9 +
arch/mips/lemote/lm2f/common/cs5536.h | 578 ++++++
arch/mips/lemote/lm2f/common/cs5536_pci.h | 181 ++
arch/mips/lemote/lm2f/common/cs5536_vsm.c | 2294 +++++++++++++++++++++
arch/mips/lemote/lm2f/common/mem.c | 23 +
arch/mips/lemote/lm2f/common/mfgpt.c | 222 ++
arch/mips/lemote/lm2f/common/mipsdha.c | 164 ++
arch/mips/lemote/lm2f/common/pci.c | 89 +
arch/mips/lemote/lm2f/common/pcireg.h | 485 +++++
arch/mips/lemote/lm2f/common/plat.c | 82 +
arch/mips/lemote/lm2f/fuloong/Makefile | 7 +
arch/mips/lemote/lm2f/fuloong/bonito-irq.c | 105 +
arch/mips/lemote/lm2f/fuloong/dbg_io.c | 182 ++
arch/mips/lemote/lm2f/fuloong/irq.c | 234 +++
arch/mips/lemote/lm2f/fuloong/prom.c | 106 +
arch/mips/lemote/lm2f/fuloong/reset.c | 87 +
arch/mips/lemote/lm2f/fuloong/setup.c | 132 ++
arch/mips/lemote/lm2f/yeeloong/Makefile | 7 +
arch/mips/lemote/lm2f/yeeloong/bonito-irq.c | 104 +
arch/mips/lemote/lm2f/yeeloong/dbg_io.c | 170 ++
arch/mips/lemote/lm2f/yeeloong/irq.c | 234 +++
arch/mips/lemote/lm2f/yeeloong/prom.c | 157 ++
arch/mips/lemote/lm2f/yeeloong/reset.c | 80 +
arch/mips/lemote/lm2f/yeeloong/setup.c | 134 ++
arch/mips/pci/Makefile | 2 +
arch/mips/pci/fixup-fl2f.c | 256 +++
arch/mips/pci/fixup-yl2f.c | 245 +++
arch/mips/pci/ops-lm2f.c | 205 ++
33 files changed, 6683 insertions(+), 2 deletions(-)
create mode 100644 arch/mips/lemote/lm2f/Kconfig
create mode 100644 arch/mips/lemote/lm2f/common/Makefile
create mode 100644 arch/mips/lemote/lm2f/common/cs5536.h
create mode 100644 arch/mips/lemote/lm2f/common/cs5536_pci.h
create mode 100644 arch/mips/lemote/lm2f/common/cs5536_vsm.c
create mode 100644 arch/mips/lemote/lm2f/common/mem.c
create mode 100644 arch/mips/lemote/lm2f/common/mfgpt.c
create mode 100644 arch/mips/lemote/lm2f/common/mipsdha.c
create mode 100644 arch/mips/lemote/lm2f/common/pci.c
create mode 100644 arch/mips/lemote/lm2f/common/pcireg.h
create mode 100644 arch/mips/lemote/lm2f/common/plat.c
create mode 100644 arch/mips/lemote/lm2f/fuloong/Makefile
create mode 100644 arch/mips/lemote/lm2f/fuloong/bonito-irq.c
create mode 100644 arch/mips/lemote/lm2f/fuloong/dbg_io.c
create mode 100644 arch/mips/lemote/lm2f/fuloong/irq.c
create mode 100644 arch/mips/lemote/lm2f/fuloong/prom.c
create mode 100644 arch/mips/lemote/lm2f/fuloong/reset.c
create mode 100644 arch/mips/lemote/lm2f/fuloong/setup.c
create mode 100644 arch/mips/lemote/lm2f/yeeloong/Makefile
create mode 100644 arch/mips/lemote/lm2f/yeeloong/bonito-irq.c
create mode 100644 arch/mips/lemote/lm2f/yeeloong/dbg_io.c
create mode 100644 arch/mips/lemote/lm2f/yeeloong/irq.c
create mode 100644 arch/mips/lemote/lm2f/yeeloong/prom.c
create mode 100644 arch/mips/lemote/lm2f/yeeloong/reset.c
create mode 100644 arch/mips/lemote/lm2f/yeeloong/setup.c
create mode 100644 arch/mips/pci/fixup-fl2f.c
create mode 100644 arch/mips/pci/fixup-yl2f.c
create mode 100644 arch/mips/pci/ops-lm2f.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 206cb79..182df7c 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -182,6 +182,13 @@ config LEMOTE_FULONG
Lemote Fulong mini-PC board based on the Chinese Loongson-2E CPU and
an FPGA northbridge

+config MACH_LM2F
+ bool "Lemote Loongson2F based machines"
+ help
+ Loongson2F have built-in DDR2 and PCIX controller. The PCIX controller
+ have a similar programming interface with FPGA northbridge used in
+ Loongson2E.
+
config MIPS_MALTA
bool "MIPS Malta board"
select ARCH_MAY_HAVE_PC_FDC
@@ -649,6 +656,7 @@ source "arch/mips/sibyte/Kconfig"
source "arch/mips/txx9/Kconfig"
source "arch/mips/vr41xx/Kconfig"
source "arch/mips/cavium-octeon/Kconfig"
+source "arch/mips/lemote/lm2f/Kconfig"

endmenu

@@ -1401,7 +1409,6 @@ config 32BIT
config 64BIT
bool "64-bit kernel"
depends on CPU_SUPPORTS_64BIT_KERNEL && SYS_SUPPORTS_64BIT_KERNEL
- select HAVE_SYSCALL_WRAPPERS
help
Select this option if you want to build a 64-bit kernel.

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 22dab2e..6ccfb3d 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -311,6 +311,25 @@ load-$(CONFIG_LEMOTE_FULONG) +=0xffffffff80100000
cflags-$(CONFIG_LEMOTE_FULONG) +=
-I$(srctree)/arch/mips/include/asm/mach-lemote

#
+# common lemote loongson2f stuffs
+#
+core-$(CONFIG_MACH_LM2F) +=arch/mips/lemote/lm2f/common/
+
+#
+# lemote loongson2f fuloong mini-PC board
+#
+core-$(CONFIG_LEMOTE_FULOONG2F) +=arch/mips/lemote/lm2f/fuloong/
+load-$(CONFIG_LEMOTE_FULOONG2F) +=0xffffffff80200000
+cflags-$(CONFIG_LEMOTE_FULOONG2F) +=
-I$(srctree)/arch/mips/include/asm/mach-lemote
+
+#
+# lemote loongson2f yeeloong mini laptop
+#
+core-$(CONFIG_LEMOTE_YEELOONG2F) +=arch/mips/lemote/lm2f/yeeloong/
+load-$(CONFIG_LEMOTE_YEELOONG2F) +=0xffffffff80200000
+cflags-$(CONFIG_LEMOTE_YEELOONG2F) +=
-I$(srctree)/arch/mips/include/asm/mach-lemote
+
+#
# MIPS Malta board
#
core-$(CONFIG_MIPS_MALTA) += arch/mips/mti-malta/
diff --git a/arch/mips/include/asm/mach-lemote/dma-coherence.h
b/arch/mips/include/asm/mach-lemote/dma-coherence.h
index 38fad7d..b8d79e2 100644
--- a/arch/mips/include/asm/mach-lemote/dma-coherence.h
+++ b/arch/mips/include/asm/mach-lemote/dma-coherence.h
@@ -27,7 +27,18 @@ static inline dma_addr_t plat_map_dma_mem_page(struct
device *dev,

static inline unsigned long plat_dma_addr_to_phys(dma_addr_t dma_addr)
{
+#ifdef CONFIG_64BIT
+#ifdef CONFIG_MACH_LM2F
+ if (dma_addr > 0x8fffffff)
+ return dma_addr;
+ else
+ return dma_addr & 0x0fffffff;
+#else
return dma_addr & 0x7fffffff;
+#endif
+#else
+ return dma_addr & 0x7fffffff;
+#endif
}

static inline void plat_unmap_dma_mem(struct device *dev, dma_addr_t
dma_addr)
diff --git a/arch/mips/include/asm/mips-boards/bonito64.h
b/arch/mips/include/asm/mips-boards/bonito64.h
index a0f04bb..4495f81 100644
--- a/arch/mips/include/asm/mips-boards/bonito64.h
+++ b/arch/mips/include/asm/mips-boards/bonito64.h
@@ -26,7 +26,7 @@
/* offsets from base register */
#define BONITO(x) (x)

-#elif defined(CONFIG_LEMOTE_FULONG)
+#elif defined(CONFIG_LEMOTE_FULONG) || defined(CONFIG_MACH_LM2F)

#define BONITO(x) (*(volatile u32 *)((char *)CKSEG1ADDR(BONITO_REG_BASE)
+ (x)))
#define BONITO_IRQ_BASE 32
diff --git a/arch/mips/lemote/lm2f/Kconfig b/arch/mips/lemote/lm2f/Kconfig
new file mode 100644
index 0000000..25fb9c0
--- /dev/null
+++ b/arch/mips/lemote/lm2f/Kconfig
@@ -0,0 +1,70 @@
+choice
+ prompt "Machine type"
+ depends on MACH_LM2F
+ default LEMOTE_FULOONG2F
+
+config LEMOTE_FULOONG2F
+ bool "Lemote Fuloong mini-PC"
+ select ARCH_SPARSEMEM_ENABLE
+ select CEVT_R4K
+ select CSRC_R4K
+ select SYS_HAS_CPU_LOONGSON2
+ select DMA_NONCOHERENT
+ select BOOT_ELF32
+ select BOARD_SCACHE
+ select HW_HAS_PCI
+ select I8259
+ select ISA
+ select IRQ_CPU
+ select SYS_SUPPORTS_32BIT_KERNEL
+ select SYS_SUPPORTS_64BIT_KERNEL
+ select SYS_SUPPORTS_LITTLE_ENDIAN
+ select SYS_SUPPORTS_HIGHMEM
+ select SYS_HAS_EARLY_PRINTK
+ select GENERIC_HARDIRQS_NO__DO_IRQ
+ select GENERIC_ISA_DMA_SUPPORT_BROKEN
+ select CPU_HAS_WB
+ select CS5536
+ help
+ Lemote Fulong mini-PC board based on the Chinese Loongson-2F CPU
+
+config LEMOTE_YEELOONG2F
+ bool "Lemote Yeloong2F mini Notebook"
+ select ARCH_SPARSEMEM_ENABLE
+ select CEVT_R4K
+ select CSRC_R4K
+ select SYS_HAS_CPU_LOONGSON2
+ select DMA_NONCOHERENT
+ select BOOT_ELF32
+ select BOARD_SCACHE
+ select HW_HAS_PCI
+ select I8259
+ select ISA
+ select IRQ_CPU
+ select SYS_SUPPORTS_32BIT_KERNEL
+ select SYS_SUPPORTS_64BIT_KERNEL
+ select SYS_SUPPORTS_LITTLE_ENDIAN
+ select SYS_SUPPORTS_HIGHMEM
+ select SYS_HAS_EARLY_PRINTK
+ select GENERIC_HARDIRQS_NO__DO_IRQ
+ select GENERIC_ISA_DMA_SUPPORT_BROKEN
+ select CPU_HAS_WB
+ select CS5536
+ help
+ Lemote Notebook based on the Chinese Loongson-2F CPU
+
+endchoice
+
+config CS5536_RTC_BUG
+ bool
+
+config CS5536
+ bool
+ select CS5536_RTC_BUG
+
+config LEMOTE_NAS
+ bool "Lemote NAS machine"
+ depends on LEMOTE_FULOONG2F
+ help
+ Lemote's Loongson-2F based network attached system
+
diff --git a/arch/mips/lemote/lm2f/common/Makefile
b/arch/mips/lemote/lm2f/common/Makefile
new file mode 100644
index 0000000..d13d2e8
--- /dev/null
+++ b/arch/mips/lemote/lm2f/common/Makefile
@@ -0,0 +1,9 @@
+#
+# Copyright 2007, 2008 Lemote Tec
+# Author: www.lemote.com Inc
+#
+# Makefile for the loongson2f CPUS, generic files
+#
+
+obj-y += mem.o mipsdha.o pci.o mem.o plat.o
+obj-$(CONFIG_CS5536) += cs5536_vsm.o
diff --git a/arch/mips/lemote/lm2f/common/cs5536.h
b/arch/mips/lemote/lm2f/common/cs5536.h
new file mode 100644
index 0000000..c18522a
--- /dev/null
+++ b/arch/mips/lemote/lm2f/common/cs5536.h
@@ -0,0 +1,578 @@
+/*
+ * cs5536.h
+ *
+ * The include file of cs5536 sourthbridge define which is used in the
pmon only.
+ * you can modify it or change it, please set the modify time and steps.
+ *
+ * Author : jlliu <liujl@lemote.com>
+ * Data : 07-6-27
+ */
+
+#ifndef _CS5536_H
+#define _CS5536_H
+
+/*************************************************************************/
+
+/*
+ * basic define
+ */
+#define PCI_IO_BASE 0x1fd00000 //( < 0x1fe00000)
+#define PCI_IO_BASE_VA 0xbfd00000
+#define PCI_MEM_BASE 0x10000000 //( < 0x1c000000 )
+#define PCI_MEM_BASE_VA 0xb0000000
+
+/*
+ * MSR module base
+ */
+#define CS5536_SB_MSR_BASE (0x00000000)
+#define CS5536_GLIU_MSR_BASE (0x10000000)
+#define CS5536_ILLEGAL_MSR_BASE (0x20000000)
+#define CS5536_USB_MSR_BASE (0x40000000)
+#define CS5536_IDE_MSR_BASE (0x60000000)
+#define CS5536_DIVIL_MSR_BASE (0x80000000)
+#define CS5536_ACC_MSR_BASE (0xa0000000)
+#define CS5536_UNUSED_MSR_BASE (0xc0000000)
+#define CS5536_GLCP_MSR_BASE (0xe0000000)
+
+#define SB_MSR_REG(offset) (CS5536_SB_MSR_BASE | offset)
+#define GLIU_MSR_REG(offset) (CS5536_GLIU_MSR_BASE | offset)
+#define ILLEGAL_MSR_REG(offset) (CS5536_ILLEGAL_MSR_BASE| offset)
+#define USB_MSR_REG(offset) (CS5536_USB_MSR_BASE | offset)
+#define IDE_MSR_REG(offset) (CS5536_IDE_MSR_BASE | offset)
+#define DIVIL_MSR_REG(offset) (CS5536_DIVIL_MSR_BASE | offset)
+#define ACC_MSR_REG(offset) (CS5536_ACC_MSR_BASE | offset)
+#define UNUSED_MSR_REG(offset) (CS5536_UNUSED_MSR_BASE | offset)
+#define GLCP_MSR_REG(offset) (CS5536_GLCP_MSR_BASE | offset)
+
+/*
+ * BAR SPACE OF VIRTUAL PCI : range for pci probe use, length is the
actual size.
+ */
+// IO space for all DIVIL modules
+#define CS5536_IRQ_RANGE 0xffffffe0 // USERD FOR PCI PROBE
+#define CS5536_IRQ_LENGTH 0x20 // THE REGS ACTUAL LENGTH
+#define CS5536_SMB_RANGE 0xfffffff8
+#define CS5536_SMB_LENGTH 0x08
+#define CS5536_GPIO_RANGE 0xffffff00
+#define CS5536_GPIO_LENGTH 0x100
+#define CS5536_MFGPT_RANGE 0xffffffc0
+#define CS5536_MFGPT_LENGTH 0x40
+#define CS5536_ACPI_RANGE 0xffffffe0
+#define CS5536_ACPI_LENGTH 0x20
+#define CS5536_PMS_RANGE 0xffffff80
+#define CS5536_PMS_LENGTH 0x80
+// MEM space for 4KB nand flash; IO space for 16B nor flash.
+#ifdef CS5536_USE_NOR_FLASH
+#define CS5536_FLSH0_RANGE 0xfffffff0
+#define CS5536_FLSH0_LENGTH 0x10
+#define CS5536_FLSH1_RANGE 0xfffffff0
+#define CS5536_FLSH1_LENGTH 0x10
+#define CS5536_FLSH2_RANGE 0xfffffff0
+#define CS5536_FLSH2_LENGTH 0x10
+#define CS5536_FLSH3_RANGE 0xfffffff0
+#define CS5536_FLSH3_LENGTH 0x10
+#else
+#define CS5536_FLSH0_RANGE 0xfffff000
+#define CS5536_FLSH0_LENGTH 0x1000
+#define CS5536_FLSH1_RANGE 0xfffff000
+#define CS5536_FLSH1_LENGTH 0x1000
+#define CS5536_FLSH2_RANGE 0xfffff000
+#define CS5536_FLSH2_LENGTH 0x1000
+#define CS5536_FLSH3_RANGE 0xfffff000
+#define CS5536_FLSH3_LENGTH 0x1000
+#endif
+// IO space for IDE
+#define CS5536_IDE_RANGE 0xfffffff0
+#define CS5536_IDE_LENGTH 0x10
+// IO space for ACC
+#define CS5536_ACC_RANGE 0xffffff80
+#define CS5536_ACC_LENGTH 0x80
+// MEM space for ALL USB modules
+//#define CS5536_OHCI_RANGE 0xfffffff0
+#define CS5536_OHCI_RANGE 0xfffff000
+#define CS5536_OHCI_LENGTH 0x1000
+//#define CS5536_EHCI_RANGE 0xfffffff0
+#define CS5536_EHCI_RANGE 0xfffff000
+#define CS5536_EHCI_LENGTH 0x1000
+#define CS5536_UDC_RANGE 0xffffe000
+#define CS5536_UDC_LENGTH 0x2000
+#define CS5536_OTG_RANGE 0xfffff000
+#define CS5536_OTG_LENGTH 0x1000
+
+/*
+ * PCI MSR ACCESS
+ */
+#define PCI_MSR_CTRL 0xF0
+#define PCI_MSR_ADDR 0xF4
+#define PCI_MSR_DATA_LO 0xF8
+#define PCI_MSR_DATA_HI 0xFC
+
+/******************************* MSR
*********************************************/
+
+/*
+ * GLIU STANDARD MSR
+ */
+#define GLIU_CAP 0x00
+#define GLIU_CONFIG 0x01
+#define GLIU_SMI 0x02
+#define GLIU_ERROR 0x03
+#define GLIU_PM 0x04
+#define GLIU_DIAG 0x05
+
+/*
+ * GLIU SPEC. MSR
+ */
+#define GLIU_P2D_BM0 0x20
+#define GLIU_P2D_BM1 0x21
+#define GLIU_P2D_BM2 0x22
+#define GLIU_P2D_BMK0 0x23
+#define GLIU_P2D_BMK1 0x24
+#define GLIU_P2D_BM3 0x25
+#define GLIU_P2D_BM4 0x26
+#define GLIU_COH 0x80
+#define GLIU_PAE 0x81
+#define GLIU_ARB 0x82
+#define GLIU_ASMI 0x83
+#define GLIU_AERR 0x84
+#define GLIU_DEBUG 0x85
+#define GLIU_PHY_CAP 0x86
+#define GLIU_NOUT_RESP 0x87
+#define GLIU_NOUT_WDATA 0x88
+#define GLIU_WHOAMI 0x8B
+#define GLIU_SLV_DIS 0x8C
+#define GLIU_IOD_BM0 0xE0
+#define GLIU_IOD_BM1 0xE1
+#define GLIU_IOD_BM2 0xE2
+#define GLIU_IOD_BM3 0xE3
+#define GLIU_IOD_BM4 0xE4
+#define GLIU_IOD_BM5 0xE5
+#define GLIU_IOD_BM6 0xE6
+#define GLIU_IOD_BM7 0xE7
+#define GLIU_IOD_BM8 0xE8
+#define GLIU_IOD_BM9 0xE9
+#define GLIU_IOD_SC0 0xEA
+#define GLIU_IOD_SC1 0xEB
+#define GLIU_IOD_SC2 0xEC
+#define GLIU_IOD_SC3 0xED
+#define GLIU_IOD_SC4 0xEE
+#define GLIU_IOD_SC5 0xEF
+#define GLIU_IOD_SC6 0xF0
+#define GLIU_IOD_SC7 0xF1
+
+/*
+ * SB STANDARD
+ */
+#define SB_CAP 0x00
+#define SB_CONFIG 0x01
+#define SB_SMI 0x02
+#define SB_ERROR 0x03
+#define SB_MAR_ERR_EN 0x00000001
+#define SB_TAR_ERR_EN 0x00000002
+#define SB_RSVD_BIT1 0x00000004
+#define SB_EXCEP_ERR_EN 0x00000008
+#define SB_SYSE_ERR_EN 0x00000010
+#define SB_PARE_ERR_EN 0x00000020
+#define SB_TAS_ERR_EN 0x00000040
+#define SB_MAR_ERR_FLAG 0x00010000
+#define SB_TAR_ERR_FLAG 0x00020000
+#define SB_RSVD_BIT2 0x00040000
+#define SB_EXCEP_ERR_FLAG 0x00080000
+#define SB_SYSE_ERR_FLAG 0x00100000
+#define SB_PARE_ERR_FLAG 0x00200000
+#define SB_TAS_ERR_FLAG 0x00400000
+#define SB_PM 0x04
+#define SB_DIAG 0x05
+
+/*
+ * SB SPEC.
+ */
+#define SB_CTRL 0x10
+#define SB_R0 0x20
+#define SB_R1 0x21
+#define SB_R2 0x22
+#define SB_R3 0x23
+#define SB_R4 0x24
+#define SB_R5 0x25
+#define SB_R6 0x26
+#define SB_R7 0x27
+#define SB_R8 0x28
+#define SB_R9 0x29
+#define SB_R10 0x2A
+#define SB_R11 0x2B
+#define SB_R12 0x2C
+#define SB_R13 0x2D
+#define SB_R14 0x2E
+#define SB_R15 0x2F
+
+/*
+ * GLCP STANDARD
+ */
+#define GLCP_CAP 0x00
+#define GLCP_CONFIG 0x01
+#define GLCP_SMI 0x02
+#define GLCP_ERROR 0x03
+#define GLCP_PM 0x04
+#define GLCP_DIAG 0x05
+
+/*
+ * GLCP SPEC.
+ */
+#define GLCP_CLK_DIS_DELAY 0x08
+#define GLCP_PM_CLK_DISABLE 0x09
+#define GLCP_GLB_PM 0x0B
+#define GLCP_DBG_OUT 0x0C
+#define GLCP_RSVD1 0x0D
+#define GLCP_SOFT_COM 0x0E
+#define SOFT_BAR_SMB_FLAG 0x00000001
+#define SOFT_BAR_GPIO_FLAG 0x00000002
+#define SOFT_BAR_MFGPT_FLAG 0x00000004
+#define SOFT_BAR_IRQ_FLAG 0x00000008
+#define SOFT_BAR_PMS_FLAG 0x00000010
+#define SOFT_BAR_ACPI_FLAG 0x00000020
+#define SOFT_BAR_FLSH0_FLAG 0x00000040
+#define SOFT_BAR_FLSH1_FLAG 0x00000080
+#define SOFT_BAR_FLSH2_FLAG 0x00000100
+#define SOFT_BAR_FLSH3_FLAG 0x00000200
+#define SOFT_BAR_IDE_FLAG 0x00000400
+#define SOFT_BAR_ACC_FLAG 0x00000800
+#define SOFT_BAR_OHCI_FLAG 0x00001000
+#define SOFT_BAR_EHCI_FLAG 0x00002000
+#define SOFT_BAR_UDC_FLAG 0x00004000
+#define SOFT_BAR_OTG_FLAG 0x00008000
+#define GLCP_RSVD2 0x0F
+#define GLCP_CLK_OFF 0x10
+#define GLCP_CLK_ACTIVE 0x11
+#define GLCP_CLK_DISABLE 0x12
+#define GLCP_CLK4ACK 0x13
+#define GLCP_SYS_RST 0x14
+#define GLCP_RSVD3 0x15
+#define GLCP_DBG_CLK_CTRL 0x16
+#define GLCP_CHIP_REV_ID 0x17
+
+/*
+ * DIVIL STANDARD
+ */
+#define DIVIL_CAP 0x00
+#define DIVIL_CONFIG 0x01
+#define DIVIL_SMI 0x02
+#define DIVIL_ERROR 0x03
+#define DIVIL_PM 0x04
+#define DIVIL_DIAG 0x05
+
+/*
+ * DIVIL SPEC.
+ */
+#define DIVIL_LBAR_IRQ 0x08
+#define DIVIL_LBAR_KEL 0x09
+#define DIVIL_LBAR_SMB 0x0B
+#define DIVIL_LBAR_GPIO 0x0C
+#define DIVIL_LBAR_MFGPT 0x0D
+#define DIVIL_LBAR_ACPI 0x0E
+#define DIVIL_LBAR_PMS 0x0F
+#define DIVIL_LBAR_FLSH0 0x10
+#define DIVIL_LBAR_FLSH1 0x11
+#define DIVIL_LBAR_FLSH2 0x12
+#define DIVIL_LBAR_FLSH3 0x13
+#define DIVIL_LEG_IO 0x14
+#define DIVIL_BALL_OPTS 0x15
+#define DIVIL_SOFT_IRQ 0x16
+#define DIVIL_SOFT_RESET 0x17
+// NOR FLASH
+#define NORF_CTRL 0x18
+#define NORF_T01 0x19
+#define NORF_T23 0x1A
+// NAND FLASH
+#define NANDF_DATA 0x1B
+#define NANDF_CTRL 0x1C
+#define NANDF_RSVD 0x1D
+// KEL Keyboard Emulation Logic
+#define KEL_CTRL 0x1F
+// PIC
+#define PIC_YSEL_LOW 0x20
+#define PIC_YSEL_LOW_USB_SHIFT 8
+#define PIC_YSEL_LOW_ACC_SHIFT 16
+#define PIC_YSEL_LOW_FLASH_SHIFT 24
+#define PIC_YSEL_HIGH 0x21
+#define PIC_ZSEL_LOW 0x22
+#define PIC_ZSEL_HIGH 0x23
+#define PIC_IRQM_PRIM 0x24
+#define PIC_IRQM_LPC 0x25
+#define PIC_XIRR_STS_LOW 0x26
+#define PIC_XIRR_STS_HIGH 0x27
+#define PCI_SHDW 0x34
+// MFGPT
+#define MFGPT_IRQ 0x28
+#define MFGPT_NR 0x29
+#define MFGPT_RSVD 0x2A
+#define MFGPT_SETUP 0x2B
+// FLOPPY
+#define FLPY_3F2_SHDW 0x30
+#define FLPY_3F7_SHDW 0x31
+#define FLPY_372_SHDW 0x32
+#define FLPY_377_SHDW 0x33
+// PIT
+#define PIT_SHDW 0x36
+#define PIT_CNTRL 0x37
+// UART
+#define UART1_MOD 0x38
+#define UART1_DONG 0x39
+#define UART1_CONF 0x3A
+#define UART1_RSVD 0x3B
+#define UART2_MOD 0x3C
+#define UART2_DONG 0x3D
+#define UART2_CONF 0x3E
+#define UART2_RSVD 0x3F
+// DMA
+#define DIVIL_AC_DMA 0x1E
+#define DMA_MAP 0x40
+#define DMA_SHDW_CH0 0x41
+#define DMA_SHDW_CH1 0x42
+#define DMA_SHDW_CH2 0x43
+#define DMA_SHDW_CH3 0x44
+#define DMA_SHDW_CH4 0x45
+#define DMA_SHDW_CH5 0x46
+#define DMA_SHDW_CH6 0x47
+#define DMA_SHDW_CH7 0x48
+#define DMA_MSK_SHDW 0x49
+// LPC
+#define LPC_EADDR 0x4C
+#define LPC_ESTAT 0x4D
+#define LPC_SIRQ 0x4E
+#define LPC_RSVD 0x4F
+// PMC
+#define PMC_LTMR 0x50
+#define PMC_RSVD 0x51
+// RTC
+#define RTC_RAM_LOCK 0x54
+#define RTC_DOMA_OFFSET 0x55
+#define RTC_MONA_OFFSET 0x56
+#define RTC_CEN_OFFSET 0x57
+
+/*
+ * IDE STANDARD
+ */
+#define IDE_CAP 0x00
+#define IDE_CONFIG 0x01
+#define IDE_SMI 0x02
+#define IDE_ERROR 0x03
+#define IDE_PM 0x04
+#define IDE_DIAG 0x05
+
+/*
+ * IDE SPEC.
+ */
+#define IDE_IO_BAR 0x08
+#define IDE_CFG 0x10
+#define IDE_DTC 0x12
+#define IDE_CAST 0x13
+#define IDE_ETC 0x14
+#define IDE_INTERNAL_PM 0x15
+
+/*
+ * ACC STANDARD
+ */
+#define ACC_CAP 0x00
+#define ACC_CONFIG 0x01
+#define ACC_SMI 0x02
+#define ACC_ERROR 0x03
+#define ACC_PM 0x04
+#define ACC_DIAG 0x05
+
+/*
+ * USB STANDARD
+ */
+#define USB_CAP 0x00
+#define USB_CONFIG 0x01
+#define USB_SMI 0x02
+#define USB_ERROR 0x03
+#define USB_PM 0x04
+#define USB_DIAG 0x05
+
+/*
+ * USB SPEC.
+ */
+#define USB_OHCI 0x08
+#define USB_EHCI 0x09
+#define USB_UDC 0x0A
+#define USB_OTG 0x0B
+
+/********************************** NATIVE
****************************************/
+// IDE NATIVE registers
+#define IDE_BM_CMD 0x00
+#define IDE_BM_STS 0x02
+#define IDE_BM_PRD 0x04
+
+// OHCI native registers
+#define OHCI_REVISION 0x00
+#define OHCI_CONTROL 0x04
+#define OHCI_COMMAND_STATUS 0x08
+#define OHCI_INT_STATUS 0x0C
+#define OHCI_INT_ENABLE 0x10
+#define OHCI_INT_DISABLE 0x14
+#define OHCI_HCCA 0x18
+#define OHCI_PERI_CUR_ED 0x1C
+#define OHCI_CTRL_HEAD_ED 0x20
+#define OHCI_CTRL_CUR_ED 0x24
+#define OHCI_BULK_HEAD_ED 0x28
+#define OHCI_BULK_CUR_ED 0x2C
+#define OHCI_DONE_HEAD 0x30
+#define OHCI_FM_INTERVAL 0x34
+#define OHCI_FM_REMAINING 0x38
+#define OHCI_FM_NUMBER 0x3C
+#define OHCI_PERI_START 0x40
+#define OHCI_LS_THRESHOLD 0x44
+#define OHCI_RH_DESCRIPTORA 0x48
+#define OHCI_RH_DESCRIPTORB 0x4C
+#define OHCI_RH_STATUS 0x50
+#define OHCI_RH_PORT_STATUS1 0x54
+#define OHCI_RH_PORT_STATUS2 0x58
+#define OHCI_RH_PORT_STATUS3 0x5C
+#define OHCI_RH_PORT_STATUS4 0x60
+
+// KEL : MEM SPACE; REG :32BITS WIDTH
+#define KEL_HCE_CTRL 0x100
+#define KEL_HCE_IN 0x104
+#define KEL_HCE_OUT 0x108
+#define KEL_HCE_STS 0x10C
+#define KEL_PORTA 0x92 //8bits
+// PIC : I/O SPACE; REG : 8BITS
+#define PIC_ICW1_MASTER 0x20
+#define PIC_ICW1_SLAVE 0xA0
+#define PIC_ICW2_MASTER 0x21
+#define PIC_ICW2_SLAVE 0xA1
+#define PIC_ICW3_MASTER 0x21
+#define PIC_ICW3_SLAVE 0xA1
+#define PIC_ICW4_MASTER 0x21
+#define PIC_ICW4_SLAVE 0xA1
+#define PIC_OCW1_MASTER 0x21
+#define PIC_OCW1_SLAVE 0xA1
+#define PIC_OCW2_MASTER 0x20
+#define PIC_OCW2_SLAVE 0xA0
+#define PIC_OCW3_MASTER 0x20
+#define PIC_OCW3_SLAVE 0xA0
+#define PIC_IRR_MASTER 0x20
+#define PIC_IRR_SLAVE 0xA0
+#define PIC_ISR_MASTER 0x20
+#define PIC_ISR_SLAVE 0xA0
+#define PIC_INT_SEL1 0x4D0
+#define PIC_INT_SEL2 0x4D1
+// GPIO : I/O SPACE; REG : 32BITS
+#define GPIOL_OUT_VAL 0x00
+#define GPIOL_OUT_EN 0x04
+#define GPIOL_OUT_OD_EN 0x08
+#define GPIOL_OUT_INVRT_EN 0x0c
+#define GPIOL_OUT_AUX1_SEL 0x10
+#define GPIOL_OUT_AUX2_SEL 0x14
+#define GPIOL_PU_EN 0x18
+#define GPIOL_PD_EN 0x1c
+#define GPIOL_IN_EN 0x20
+#define GPIOL_IN_INVRT_EN 0x24
+#define GPIOL_IN_FLTR_EN 0x28
+#define GPIOL_IN_EVNTCNT_EN 0x2c
+#define GPIOL_IN_READBACK 0x30
+#define GPIOL_IN_AUX1_SEL 0x34
+#define GPIOL_EVNT_EN 0x38
+#define GPIOL_LOCK_EN 0x3c
+#define GPIOL_IN_POSEDGE_EN 0x40
+#define GPIOL_IN_NEGEDGE_EN 0x44
+#define GPIOL_IN_POSEDGE_STS 0x48
+#define GPIOL_IN_NEGEDGE_STS 0x4c
+#define GPIOH_OUT_VAL 0x80
+#define GPIOH_OUT_EN 0x84
+#define GPIOH_OUT_OD_EN 0x88
+#define GPIOH_OUT_INVRT_EN 0x8c
+#define GPIOH_OUT_AUX1_SEL 0x90
+#define GPIOH_OUT_AUX2_SEL 0x94
+#define GPIOH_PU_EN 0x98
+#define GPIOH_PD_EN 0x9c
+#define GPIOH_IN_EN 0xA0
+#define GPIOH_IN_INVRT_EN 0xA4
+#define GPIOH_IN_FLTR_EN 0xA8
+#define GPIOH_IN_EVNTCNT_EN 0xAc
+#define GPIOH_IN_READBACK 0xB0
+#define GPIOH_IN_AUX1_SEL 0xB4
+#define GPIOH_EVNT_EN 0xB8
+#define GPIOH_LOCK_EN 0xBc
+#define GPIOH_IN_POSEDGE_EN 0xC0
+#define GPIOH_IN_NEGEDGE_EN 0xC4
+#define GPIOH_IN_POSEDGE_STS 0xC8
+#define GPIOH_IN_NEGEDGE_STS 0xCC
+// SMB : I/O SPACE, REG : 8BITS WIDTH
+#define SMB_SDA 0x00
+#define SMB_STS 0x01
+#define SMB_STS_SLVSTP (1 << 7)
+#define SMB_STS_SDAST (1 << 6)
+#define SMB_STS_BER (1 << 5)
+#define SMB_STS_NEGACK (1 << 4)
+#define SMB_STS_STASTR (1 << 3)
+#define SMB_STS_NMATCH (1 << 2)
+#define SMB_STS_MASTER (1 << 1)
+#define SMB_STS_XMIT (1 << 0)
+#define SMB_CTRL_STS 0x02
+#define SMB_CSTS_TGSTL (1 << 5)
+#define SMB_CSTS_TSDA (1 << 4)
+#define SMB_CSTS_GCMTCH (1 << 3)
+#define SMB_CSTS_MATCH (1 << 2)
+#define SMB_CSTS_BB (1 << 1)
+#define SMB_CSTS_BUSY (1 << 0)
+#define SMB_CTRL1 0x03
+#define SMB_CTRL1_STASTRE (1 << 7)
+#define SMB_CTRL1_NMINTE (1 << 6)
+#define SMB_CTRL1_GCMEN (1 << 5)
+#define SMB_CTRL1_ACK (1 << 4)
+#define SMB_CTRL1_RSVD (1 << 3)
+#define SMB_CTRL1_INTEN (1 << 2)
+#define SMB_CTRL1_STOP (1 << 1)
+#define SMB_CTRL1_START (1 << 0)
+#define SMB_ADDR 0x04
+#define SMB_ADDR_SAEN (1 << 7)
+#define SMB_CONTROLLER_ADDR (0xef << 0)
+#define SMB_CTRL2 0x05
+#define SMB_FREQ (0x20 << 1) //(0x7f << 1)
+#define SMB_ENABLE (0x01 << 0)
+#define SMB_CTRL3 0x06
+
+/*********************************** LEGACY I/O
*******************************/
+
+/*
+ * LEGACY I/O SPACE BASE
+ */
+#define CS5536_LEGACY_BASE_ADDR (PCI_IO_BASE_VA | 0x0000)
+
+/*
+ * IDE LEGACY REG : legacy IO address is 0x170~0x177 and 0x376
(0x1f0~0x1f7 and 0x3f6)
+ * all registers are 16bits except the IDE_LEGACY_DATA reg
+ * some registers are read only and the
+ */
+#define PRI_IDE_LEGACY_REG(offset) (CS5536_LEGACY_BASE_ADDR | 0x1f0 |
offset)
+#define SEC_IDE_LEGACY_REG(offset) (CS5536_LEGACY_BASE_ADDR | 0x170 |
offset)
+
+#define IDE_LEGACY_DATA 0x00 // RW
+#define IDE_LEGACY_ERROR 0x01 // RO
+#define IDE_LEGACY_FEATURE 0x01 // WO
+#define IDE_LEGACY_SECTOR_COUNT 0x02 // RW
+#define IDE_LEGACY_SECTOR_NUM 0x03 // RW
+#define IDE_LEGACY_CYL_LO 0x04 // RW
+#define IDE_LEGACY_CYL_HI 0x05 // RW
+#define IDE_LEGACY_HEAD 0x06 // RW
+#define IDE_LEGACY_HEAD_DRV (1 << 4)
+#define IDE_LEGACY_HEAD_LBA (1 << 6)
+#define IDE_LEGACY_HEAD_IBM (1 << 7 | 1 << 5)
+#define IDE_LEGACY_STATUS 0x07 // RO
+#define IDE_LEGACY_STATUS_ERR (1 << 0)
+#define IDE_LEGACY_STATUS_IDX (1 << 1)
+#define IDE_LEGACY_STATUS_CORR (1 << 2)
+#define IDE_LEGACY_STATUS_DRQ (1 << 3)
+#define IDE_LEGACY_STATUS_DSC (1 << 4)
+#define IDE_LEGACY_STATUS_DWF (1 << 5)
+#define IDE_LEGACY_STATUS_DRDY (1 << 6)
+#define IDE_LEGACY_STATUS_BUSY (1 << 7)
+#define IDE_LEGACY_COMMAND 0x07 // WO
+#define IDE_LEGACY_ASTATUS 0x206 // RO
+#define IDE_LEGACY_CTRL 0x206 // WO
+#define IDE_LEGACY_CTRL_IDS 0x02
+#define IDE_LEGACY_CTRL_RST 0x04
+#define IDE_LEGACY_CTRL_4BIT 0x08
+
+/**********************************************************************************/
+
+#endif /* _CS5536_H */
diff --git a/arch/mips/lemote/lm2f/common/cs5536_pci.h
b/arch/mips/lemote/lm2f/common/cs5536_pci.h
new file mode 100644
index 0000000..eed94fb
--- /dev/null
+++ b/arch/mips/lemote/lm2f/common/cs5536_pci.h
@@ -0,0 +1,181 @@
+/*
+ * cs5536_vsm.h
+ * the definition file of cs5536 Virtual Support Module(VSM).
+ * pci configuration space can be accessed through the VSM, so
+ * there is no need the MSR read/write now, except the spec. MSR
+ * registers which are not implemented yet.
+ *
+ * Author : jlliu <liujl@lemote.com>
+ * Date : 07-07-04
+ *
+ */
+
+#ifndef _CS5536_PCI_H
+#define _CS5536_PCI_H
+
+/**********************************************************************/
+
+//#define TEST_CS5536_USE_FLASH
+//#ifdef TEST_CS5536_USE_FLASH
+//#define TEST_CS5536_USE_NOR_FLASH
+//#endif
+#define TEST_CS5536_USE_EHCI
+#define TEST_CS5536_USE_UDC
+#define TEST_CS5536_USE_OTG
+
+/**********************************************************************/
+
+#define PCI_SPECIAL_SHUTDOWN 1
+#define CS5536_FLASH_INTR 6
+#define CS5536_ACC_INTR 9
+#define CS5536_IDE_INTR 14
+#define CS5536_USB_INTR 11
+#define CS5536_UART1_INTR 4
+#define CS5536_UART2_INTR 3
+
+/************************* PCI BUS DEVICE FUNCTION ********************/
+
+/*
+ * PCI bus device function
+ */
+#define PCI_BUS_CS5536 0
+#define PCI_IDSEL_CS5536 14
+#define PCI_CFG_BASE 0x02000000
+
+#define CS5536_ISA_FUNC 0
+#define CS5536_FLASH_FUNC 1
+#define CS5536_IDE_FUNC 2
+#define CS5536_ACC_FUNC 3
+#define CS5536_OHCI_FUNC 4
+#define CS5536_EHCI_FUNC 5
+#define CS5536_UDC_FUNC 6
+#define CS5536_OTG_FUNC 7
+#define CS5536_FUNC_START 0
+#define CS5536_FUNC_END 7
+#define CS5536_FUNC_COUNT (CS5536_FUNC_END - CS5536_FUNC_START + 1)
+
+/***************************** STANDARD PCI-2.2 EXPANSION
***********************/
+
+/*
+ * PCI configuration space
+ * we have to virtualize the PCI configure space head, so we should
+ * define the necessary IDs and some others.
+ */
+/* VENDOR ID */
+#define CS5536_VENDOR_ID 0x1022
+
+/* DEVICE ID */
+#define CS5536_ISA_DEVICE_ID 0x2090
+#define CS5536_FLASH_DEVICE_ID 0x2091
+#define CS5536_IDE_DEVICE_ID 0x209a
+#define CS5536_ACC_DEVICE_ID 0x2093
+#define CS5536_OHCI_DEVICE_ID 0x2094
+#define CS5536_EHCI_DEVICE_ID 0x2095
+#define CS5536_UDC_DEVICE_ID 0x2096
+#define CS5536_OTG_DEVICE_ID 0x2097
+
+/* CLASS CODE : CLASS SUB-CLASS INTERFACE */
+#define CS5536_ISA_CLASS_CODE 0x060100
+#define CS5536_FLASH_CLASS_CODE 0x050100
+#define CS5536_IDE_CLASS_CODE 0x010180
+#define CS5536_ACC_CLASS_CODE 0x040100
+#define CS5536_OHCI_CLASS_CODE 0x0C0310
+#define CS5536_EHCI_CLASS_CODE 0x0C0320
+#define CS5536_UDC_CLASS_CODE 0x0C03FE
+#define CS5536_OTG_CLASS_CODE 0x0C0380
+
+/* BHLC : BIST HEADER-TYPE LATENCY-TIMER CACHE-LINE-SIZE */
+#define PCI_NONE_BIST 0x00 //RO not implemented yet.
+#define PCI_BRIDGE_HEADER_TYPE 0x80 //RO
+#define PCI_NORMAL_HEADER_TYPE 0x00
+#define PCI_NORMAL_LATENCY_TIMER 0x00
+#define PCI_NORMAL_CACHE_LINE_SIZE 0x08 //RW
+
+/* BAR */
+#define PCI_BAR0_REG 0x10
+#define PCI_BAR1_REG 0x14
+#define PCI_BAR2_REG 0x18
+#define PCI_BAR3_REG 0x1c
+#define PCI_BAR4_REG 0x20
+#define PCI_BAR5_REG 0x24
+#define PCI_BAR_COUNT 6
+#define PCI_BAR_RANGE_MASK 0xFFFFFFFF
+
+/* CARDBUS CIS POINTER */
+#define PCI_CARDBUS_CIS_POINTER 0x00000000
+
+/* SUBSYSTEM VENDOR ID */
+#define CS5536_SUB_VENDOR_ID CS5536_VENDOR_ID
+
+/* SUBSYSTEM ID */
+#define CS5536_ISA_SUB_ID CS5536_ISA_DEVICE_ID
+#define CS5536_FLASH_SUB_ID CS5536_FLASH_DEVICE_ID
+#define CS5536_IDE_SUB_ID CS5536_IDE_DEVICE_ID
+#define CS5536_ACC_SUB_ID CS5536_ACC_DEVICE_ID
+#define CS5536_OHCI_SUB_ID CS5536_OHCI_DEVICE_ID
+#define CS5536_EHCI_SUB_ID CS5536_EHCI_DEVICE_ID
+#define CS5536_UDC_SUB_ID CS5536_UDC_DEVICE_ID
+#define CS5536_OTG_SUB_ID CS5536_OTG_DEVICE_ID
+
+/* EXPANSION ROM BAR */
+#define PCI_EXPANSION_ROM_BAR 0x00000000
+
+/* CAPABILITIES POINTER */
+#define PCI_CAPLIST_POINTER 0x00000000
+#define PCI_CAPLIST_USB_POINTER 0x40
+/* INTERRUPT */
+#define PCI_MAX_LATENCY 0x40
+#define PCI_MIN_GRANT 0x00
+#define PCI_DEFAULT_PIN 0x01
+
+/**************************** EXPANSION PCI REG
**************************************/
+
+/*
+ * ISA EXPANSION
+ */
+#define PCI_UART1_INT_REG 0x50
+#define PCI_UART2_INT_REG 0x54
+#define PCI_ISA_FIXUP_REG 0x58
+
+/*
+ * FLASH EXPANSION
+ */
+#define PCI_FLASH_INT_REG 0x50
+#define PCI_NOR_FLASH_CTRL_REG 0x40
+#define PCI_NOR_FLASH_T01_REG 0x44
+#define PCI_NOR_FLASH_T23_REG 0x48
+#define PCI_NAND_FLASH_TDATA_REG 0x60
+#define PCI_NAND_FLASH_TCTRL_REG 0x64
+#define PCI_NAND_FLASH_RSVD_REG 0x68
+#define PCI_FLASH_SELECT_REG 0x70
+
+/*
+ * IDE EXPANSION
+ */
+#define PCI_IDE_CFG_REG 0x40
+#define CS5536_IDE_FLASH_SIGNATURE 0xDEADBEEF
+#define PCI_IDE_DTC_REG 0x48
+#define PCI_IDE_CAST_REG 0x4C
+#define PCI_IDE_ETC_REG 0x50
+#define PCI_IDE_PM_REG 0x54
+#define PCI_IDE_INT_REG 0x60
+
+/*
+ * ACC EXPANSION
+ */
+#define PCI_ACC_INT_REG 0x50
+
+/*
+ * OHCI EXPANSION : INTTERUPT IS IMPLEMENTED BY THE OHCI
+ */
+#define PCI_OHCI_PM_REG 0x40
+#define PCI_OHCI_INT_REG 0x50
+
+/*
+ * EHCI EXPANSION
+ */
+#define PCI_EHCI_LEGSMIEN_REG 0x50
+#define PCI_EHCI_LEGSMISTS_REG 0x54
+#define PCI_EHCI_FLADJ_REG 0x60
+
+#endif /* _CS5536_PCI_H_ */
diff --git a/arch/mips/lemote/lm2f/common/cs5536_vsm.c
b/arch/mips/lemote/lm2f/common/cs5536_vsm.c
new file mode 100644
index 0000000..01b06b1
--- /dev/null
+++ b/arch/mips/lemote/lm2f/common/cs5536_vsm.c
@@ -0,0 +1,2294 @@
+/*
+ * pci_machdep_cs5536.c
+ * the Virtual Support Module(VSM) for virtulize the PCI configure
+ * space. so user can access the PCI configure space directly as
+ * a normal multi-function PCI device which following the PCI-2.2 spec.
+ *
+ * Author : jlliu <liujl@lemote.com>
+ * Date : 07-07-05
+ *
+ */
+#include <linux/types.h>
+
+#include "cs5536.h"
+#include "cs5536_pci.h"
+#include "pcireg.h"
+
+extern void _wrmsr(u32 reg, u32 hi, u32 lo);
+extern void _rdmsr(u32 reg, u32 *hi, u32 *lo);
+
+/******************************INTERNAL USED
FUNCTIONS***********************************/
+
+/*
+ * divil_lbar_enable_disable : enable/disable the divil module bar space.
+ * For all the DIVIL module LBAR, you should control the DIVIL LBAR reg
+ * and the RCONFx(0~5) reg to use the modules.
+ */
+static void divil_lbar_enable_disable(int enable)
+{
+ u32 hi, lo;
+
+ /*
+ * The DIVIL IRQ is not used yet. and make the RCONF0 reserved.
+ */
+
+ _rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_SMB), &hi, &lo);
+ if(enable)
+ hi |= 0x01;
+ else
+ hi &= ~0x01;
+ _wrmsr(DIVIL_MSR_REG(DIVIL_LBAR_SMB), hi, lo);
+
+ _rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_GPIO), &hi, &lo);
+ if(enable)
+ hi |= 0x01;
+ else
+ hi &= ~0x01;
+ _wrmsr(DIVIL_MSR_REG(DIVIL_LBAR_GPIO), hi, lo);
+
+ _rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_MFGPT), &hi, &lo);
+ if(enable)
+ hi |= 0x01;
+ else
+ hi &= ~0x01;
+ _wrmsr(DIVIL_MSR_REG(DIVIL_LBAR_MFGPT), hi, lo);
+
+ _rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_PMS), &hi, &lo);
+ if(enable)
+ hi |= 0x01;
+ else
+ hi &= ~0x01;
+ _wrmsr(DIVIL_MSR_REG(DIVIL_LBAR_PMS), hi, lo);
+
+ _rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_ACPI), &hi, &lo);
+ if(enable)
+ hi |= 0x01;
+ else
+ hi &= ~0x01;
+ _wrmsr(DIVIL_MSR_REG(DIVIL_LBAR_ACPI), hi, lo);
+
+ /*
+ * RCONF0 is reserved to the DIVIL IRQ mdoule
+ */
+#if 0
+ _rdmsr(SB_MSR_REG(SB_R1), &hi, &lo);
+ if(enable)
+ lo |= 0x01;
+ else
+ lo &= ~0x01;
+ _wrmsr(SB_MSR_REG(SB_R1), hi, lo);
+
+ _rdmsr(SB_MSR_REG(SB_R2), &hi, &lo);
+ if(enable)
+ lo |= 0x01;
+ else
+ lo &= ~0x01;
+ _wrmsr(SB_MSR_REG(SB_R2), hi, lo);
+
+ _rdmsr(SB_MSR_REG(SB_R3), &hi, &lo);
+ if(enable)
+ lo |= 0x01;
+ else
+ lo &= ~0x01;
+ _wrmsr(SB_MSR_REG(SB_R3), hi, lo);
+
+ _rdmsr(SB_MSR_REG(SB_R4), &hi, &lo);
+ if(enable)
+ lo |= 0x01;
+ else
+ lo &= ~0x01;
+ _wrmsr(SB_MSR_REG(SB_R4), hi, lo);
+
+ _rdmsr(SB_MSR_REG(SB_R5), &hi, &lo);
+ if(enable)
+ lo |= 0x01;
+ else
+ lo &= ~0x01;
+ _wrmsr(SB_MSR_REG(SB_R5), hi, lo);
+#endif
+ return;
+}
+
+#ifdef TEST_CS5536_USE_FLASH
+/*
+ * flash_lbar_enable_disable : enable or disable the region of
flashs(NOR or NAND)
+ * the same as the DIVIL other modules above, two groups of regs should
be modified
+ * here to control the region. DIVIL flash LBAR and the RCONFx(6~9
reserved).
+ */
+static void flash_lbar_enable_disable(int enable)
+{
+ u32 hi, lo;
+
+ _rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_FLSH0), &hi, &lo);
+ if(enable)
+ hi |= 0x01;
+ else
+ hi &= ~0x01;
+ _wrmsr(DIVIL_MSR_REG(DIVIL_LBAR_FLSH0), hi, lo);
+
+ _rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_FLSH1), &hi, &lo);
+ if(enable)
+ hi |= 0x01;
+ else
+ hi &= ~0x01;
+ _wrmsr(DIVIL_MSR_REG(DIVIL_LBAR_FLSH1), hi, lo);
+
+ _rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_FLSH2), &hi, &lo);
+ if(enable)
+ hi |= 0x01;
+ else
+ hi &= ~0x01;
+ _wrmsr(DIVIL_MSR_REG(DIVIL_LBAR_FLSH2), hi, lo);
+
+ _rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_FLSH3), &hi, &lo);
+ if(enable)
+ hi |= 0x01;
+ else
+ hi &= ~0x01;
+ _wrmsr(DIVIL_MSR_REG(DIVIL_LBAR_FLSH3), hi, lo);
+
+ _rdmsr(SB_MSR_REG(SB_R6), &hi, &lo);
+ if(enable)
+ lo |= 0x01;
+ else
+ lo &= ~0x01;
+ _wrmsr(SB_MSR_REG(SB_R6), hi, lo);
+
+ _rdmsr(SB_MSR_REG(SB_R7), &hi, &lo);
+ if(enable)
+ lo |= 0x01;
+ else
+ lo &= ~0x01;
+ _wrmsr(SB_MSR_REG(SB_R7), hi, lo);
+
+ _rdmsr(SB_MSR_REG(SB_R8), &hi, &lo);
+ if(enable)
+ lo |= 0x01;
+ else
+ lo &= ~0x01;
+ _wrmsr(SB_MSR_REG(SB_R8), hi, lo);
+
+ _rdmsr(SB_MSR_REG(SB_R9), &hi, &lo);
+ if(enable)
+ lo |= 0x01;
+ else
+ lo &= ~0x01;
+ _wrmsr(SB_MSR_REG(SB_R9), hi, lo);
+
+ return;
+}
+#endif
+
+
+/**********************************MODULES*********************************************/
+
+/*
+ * isa_write : isa write transfering.
+ * WE assume that the ISA is not the BUS MASTER.!!!
+ */
+/* FAST BACK TO BACK '1' for BUS MASTER '0' for BUS SALVE */
+/* COMMAND :
+ * bit0 : IO SPACE ENABLE
+ * bit1 : MEMORY SPACE ENABLE(ignore)
+ * bit2 : BUS MASTER ENABLE(ignore)
+ * bit3 : SPECIAL CYCLE(ignore)? default is ignored.
+ * bit4 : MEMORY WRITE and INVALIDATE(ignore)
+ * bit5 : VGA PALETTE(ignore)
+ * bit6 : PARITY ERROR(ignore)? : default is ignored.
+ * bit7 : WAIT CYCLE CONTROL(ignore)
+ * bit8 : SYSTEM ERROR(ignore)
+ * bit9 : FAST BACK TO BACK(ignore)
+ * bit10-bit15 : RESERVED
+ * STATUS :
+ * bit0-bit3 : RESERVED
+ * bit4 : CAPABILITY LIST(ignore)
+ * bit5 : 66MHZ CAPABLE
+ * bit6 : RESERVED
+ * bit7 : FAST BACK TO BACK(ignore)
+ * bit8 : DATA PARITY ERROR DETECED(ignore)
+ * bit9-bit10 : DEVSEL TIMING(ALL MEDIUM)
+ * bit11: SIGNALED TARGET ABORT
+ * bit12: RECEIVED TARGET ABORT
+ * bit13: RECEIVED MASTER ABORT
+ * bit14: SIGNALED SYSTEM ERROR
+ * bit15: DETECTED PARITY ERROR
+ */
+static void pci_isa_write_reg(int reg, u32 value)
+{
+ u32 hi, lo;
+ u32 temp;
+
+ switch(reg){
+ case PCI_COMMAND_STATUS_REG :
+ // command
+ if( value & PCI_COMMAND_IO_ENABLE ){
+ divil_lbar_enable_disable(1);
+ }else{
+ divil_lbar_enable_disable(0);
+ }
+#if 0
+ /* PER response enable or disable. */
+ if( value & PCI_COMMAND_PARITY_ENABLE ){
+ _rdmsr(SB_MSR_REG(SB_ERROR), &hi, &lo);
+ lo |= SB_PARE_ERR_EN;
+ _wrmsr(SB_MSR_REG(SB_ERROR), hi, lo);
+ }else{
+ _rdmsr(SB_MSR_REG(SB_ERROR), &hi, &lo);
+ lo &= ~SB_PARE_ERR_EN;
+ _wrmsr(SB_MSR_REG(SB_ERROR), hi, lo);
+ }
+#endif
+ // status
+ _rdmsr(SB_MSR_REG(SB_ERROR), &hi, &lo);
+ temp = lo & 0x0000ffff;
+ if( (value & PCI_STATUS_TARGET_TARGET_ABORT) &&
+ (lo & SB_TAS_ERR_EN) ){
+ temp |= SB_TAS_ERR_FLAG;
+ }
+ if( (value & PCI_STATUS_MASTER_TARGET_ABORT) &&
+ (lo & SB_TAR_ERR_EN) ){
+ temp |= SB_TAR_ERR_FLAG;
+ }
+ if( (value & PCI_STATUS_MASTER_ABORT) &&
+ (lo & SB_MAR_ERR_EN) ){
+ temp |= SB_MAR_ERR_FLAG;
+ }
+ if( (value & PCI_STATUS_PARITY_DETECT) &&
+ (lo & SB_PARE_ERR_EN) ){
+ temp |= SB_PARE_ERR_FLAG;
+ }
+ lo = temp;
+ _wrmsr(SB_MSR_REG(SB_ERROR), hi, lo);
+ break;
+ case PCI_BHLC_REG :
+ value &= 0x0000ff00;
+ _rdmsr(SB_MSR_REG(SB_CTRL), &hi, &lo);
+ hi &= 0xffffff00;
+ hi |= (value >> 8);
+ _wrmsr(SB_MSR_REG(SB_CTRL), hi, lo);
+ break;
+ case PCI_BAR0_REG :
+ if(value == PCI_BAR_RANGE_MASK){
+ _rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+ lo |= SOFT_BAR_SMB_FLAG;
+ _wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
+ }else if(value & 0x01){
+ // SMB NATIVE IO space has 8bytes
+ hi = 0x0000f001;
+ lo = value & 0x0000fff8;
+ _wrmsr(DIVIL_MSR_REG(DIVIL_LBAR_SMB), hi, lo);
+
+ // RCONFx is 4bytes in units for IO space.
+ hi = ((value & 0x000ffffc) << 12) | ((CS5536_SMB_LENGTH - 4) << 12) |
0x01;
+ lo = ((value & 0x000ffffc) << 12) | 0x01;
+ _wrmsr(SB_MSR_REG(SB_R0), hi, lo);
+ }
+ break;
+ case PCI_BAR1_REG :
+ if(value == PCI_BAR_RANGE_MASK){
+ _rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+ lo |= SOFT_BAR_GPIO_FLAG;
+ _wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
+ }else if(value & 0x01){
+ // GPIO NATIVE reg is 256bytes
+ hi = 0x0000f001;
+ lo = value & 0x0000ff00;
+ _wrmsr(DIVIL_MSR_REG(DIVIL_LBAR_GPIO), hi, lo);
+
+ // RCONFx is 4bytes in units for IO space
+ hi = ((value & 0x000ffffc) << 12) | ((CS5536_GPIO_LENGTH - 4) << 12) |
0x01;
+ lo = ((value & 0x000ffffc) << 12) | 0x01;
+ _wrmsr(SB_MSR_REG(SB_R1), hi, lo);
+ }
+ break;
+ case PCI_BAR2_REG :
+ if(value == PCI_BAR_RANGE_MASK){
+ _rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+ lo |= SOFT_BAR_MFGPT_FLAG;
+ _wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
+ }else if(value & 0x01){
+ // MFGPT NATIVE reg is 64bytes
+ hi = 0x0000f001;
+ lo = value & 0x0000ffc0;
+ _wrmsr(DIVIL_MSR_REG(DIVIL_LBAR_MFGPT), hi, lo);
+
+ // RCONFx is 4bytes in units for IO space
+ hi = ((value & 0x000ffffc) << 12) | ((CS5536_MFGPT_LENGTH - 4) << 12)
| 0x01;
+ lo = ((value & 0x000ffffc) << 12) | 0x01;
+ _wrmsr(SB_MSR_REG(SB_R2), hi, lo);
+ }
+ break;
+ case PCI_BAR3_REG :
+ if(value == PCI_BAR_RANGE_MASK){
+ _rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+ lo |= SOFT_BAR_IRQ_FLAG;
+ _wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
+ }else if(value & 0x01){
+ // IRQ NATIVE reg is 32bytes
+ hi = 0x0000f001;
+ lo = value & 0x0000ffc0;
+ _wrmsr(DIVIL_MSR_REG(DIVIL_LBAR_IRQ), hi, lo);
+
+ // RCONFx is 4bytes in units for IO space
+ hi = ((value & 0x000ffffc) << 12) | ((CS5536_IRQ_LENGTH - 4) << 12) |
0x01;
+ lo = ((value & 0x000ffffc) << 12) | 0x01;
+ _wrmsr(SB_MSR_REG(SB_R3), hi, lo);
+ }
+ break;
+ case PCI_BAR4_REG :
+ if(value == PCI_BAR_RANGE_MASK){
+ _rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+ lo |= SOFT_BAR_PMS_FLAG;
+ _wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
+ }else if(value & 0x01){
+ // PMS NATIVE reg is 128bytes
+ hi = 0x0000f001;
+ lo = value & 0x0000ff80;
+ _wrmsr(DIVIL_MSR_REG(DIVIL_LBAR_PMS), hi, lo);
+
+ // RCONFx is 4bytes in units for IO space.
+ hi = ((value & 0x000ffffc) << 12) | ((CS5536_PMS_LENGTH - 4) << 12) |
0x01;
+ lo = ((value & 0x000ffffc) << 12) | 0x01;
+ _wrmsr(SB_MSR_REG(SB_R4), hi, lo);
+ }
+ break;
+ case PCI_BAR5_REG :
+ if(value == PCI_BAR_RANGE_MASK){
+ _rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+ lo |= SOFT_BAR_ACPI_FLAG;
+ _wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
+ }else if(value & 0x01){
+ // ACPI NATIVE reg is 32bytes
+ hi = 0x0000f001;
+ lo = value & 0x0000ffe0;
+ _wrmsr(DIVIL_MSR_REG(DIVIL_LBAR_ACPI), hi, lo);
+
+ // RCONFx is 4bytes in units for IO space.
+ hi = ((value & 0x000ffffc) << 12) | ((CS5536_ACPI_LENGTH - 4) << 12) |
0x01;
+ lo = ((value & 0x000ffffc) << 12) | 0x01;
+ _wrmsr(SB_MSR_REG(SB_R5), hi, lo);
+ }
+ break;
+ case PCI_UART1_INT_REG :
+ if(value){
+ /* enable uart1 interrupt in PIC */
+ _rdmsr(DIVIL_MSR_REG(PIC_YSEL_HIGH), &hi, &lo);
+ lo &= ~(0xf << 24);
+ lo |= (CS5536_UART1_INTR << 24);
+ _wrmsr(DIVIL_MSR_REG(PIC_YSEL_HIGH), hi, lo);
+ }else{
+ /* disable uart1 interrupt in PIC */
+ _rdmsr(DIVIL_MSR_REG(PIC_YSEL_HIGH), &hi, &lo);
+ lo &= ~(0xf << 24);
+ _wrmsr(DIVIL_MSR_REG(PIC_YSEL_HIGH), hi, lo);
+ }
+ break;
+ case PCI_UART2_INT_REG :
+ if(value){
+ /* enable uart2 interrupt in PIC */
+ _rdmsr(DIVIL_MSR_REG(PIC_YSEL_HIGH), &hi, &lo);
+ lo &= ~(0xf << 28);
+ lo |= (CS5536_UART2_INTR << 28);
+ _wrmsr(DIVIL_MSR_REG(PIC_YSEL_HIGH), hi, lo);
+ }else{
+ /* disable uart2 interrupt in PIC */
+ _rdmsr(DIVIL_MSR_REG(PIC_YSEL_HIGH), &hi, &lo);
+ lo &= ~(0xf << 28);
+ _wrmsr(DIVIL_MSR_REG(PIC_YSEL_HIGH), hi, lo);
+ }
+ break;
+ case PCI_ISA_FIXUP_REG :
+ if(value){
+ /* enable the TARGET ABORT/MASTER ABORT etc. */
+ _rdmsr(SB_MSR_REG(SB_ERROR), &hi, &lo);
+ lo |= 0x00000063;
+ _wrmsr(SB_MSR_REG(SB_ERROR), hi, lo);
+ }
+
+ default :
+ /* ALL OTHER PCI CONFIG SPACE HEADER IS NOT IMPLEMENTED. */
+ break;
+ }
+
+ return;
+}
+
+/*
+ * isa_read : isa read transfering.
+ * we assume that the ISA is not the BUS MASTER.
+ */
+
+ /* COMMAND :
+ * bit0 : IO SPACE ENABLE
+ * bit1 : MEMORY SPACE ENABLE(ignore)
+ * bit2 : BUS MASTER ENABLE(ignore)
+ * bit3 : SPECIAL CYCLE(ignore)? default is ignored.
+ * bit4 : MEMORY WRITE and INVALIDATE(ignore)
+ * bit5 : VGA PALETTE(ignore)
+ * bit6 : PARITY ERROR(ignore)? : default is ignored.
+ * bit7 : WAIT CYCLE CONTROL(ignore)
+ * bit8 : SYSTEM ERROR(ignore)
+ * bit9 : FAST BACK TO BACK(ignore)
+ * bit10-bit15 : RESERVED
+ * STATUS :
+ * bit0-bit3 : RESERVED
+ * bit4 : CAPABILITY LIST(ignore)
+ * bit5 : 66MHZ CAPABLE
+ * bit6 : RESERVED
+ * bit7 : FAST BACK TO BACK(ignore)
+ * bit8 : DATA PARITY ERROR DETECED(ignore)?
+ * bit9-bit10 : DEVSEL TIMING(ALL MEDIUM)
+ * bit11: SIGNALED TARGET ABORT
+ * bit12: RECEIVED TARGET ABORT
+ * bit13: RECEIVED MASTER ABORT
+ * bit14: SIGNALED SYSTEM ERROR
+ * bit15: DETECTED PARITY ERROR(?)
+ */
+
+static u32 pci_isa_read_reg(int reg)
+{
+ u32 conf_data;
+ u32 hi, lo;
+
+ switch(reg){
+ case PCI_ID_REG :
+ conf_data = (CS5536_ISA_DEVICE_ID << 16 | CS5536_VENDOR_ID);
+ break;
+ case PCI_COMMAND_STATUS_REG :
+ conf_data = 0;
+ // COMMAND
+ // we just check the first LBAR for the IO enable bit,
+ // maybe we should changed later.
+ _rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_SMB), &hi, &lo);
+ if(hi & 0x01){
+ conf_data |= PCI_COMMAND_IO_ENABLE;
+ }
+ //conf_data |= PCI_COMMAND_IO_ENABLE | PCI_COMMAND_MEM_ENABLE |
PCI_COMMAND_MASTER_ENABLE;
+#if 0
+ conf_data |= PCI_COMMAND_SPECIAL_ENABLE;
+#endif
+#if 0
+ _rdmsr(SB_MSR_REG(SB_ERROR), &hi, &lo);
+ if(lo & SB_PARE_ERR_EN){
+ conf_data |= PCI_COMMAND_PARITY_ENABLE;
+ }else{
+ conf_data &= ~PCI_COMMAND_PARITY_ENABLE;
+ }
+#endif
+ // STATUS
+ conf_data |= PCI_STATUS_66MHZ_SUPPORT;
+ conf_data |= PCI_STATUS_DEVSEL_MEDIUM;
+#if 1
+ conf_data |= PCI_STATUS_BACKTOBACK_SUPPORT;
+#endif
+ _rdmsr(SB_MSR_REG(SB_ERROR), &hi, &lo);
+ if(lo & SB_TAS_ERR_FLAG)
+ conf_data |= PCI_STATUS_TARGET_TARGET_ABORT;
+ if(lo & SB_TAR_ERR_FLAG)
+ conf_data |= PCI_STATUS_MASTER_TARGET_ABORT;
+ if(lo & SB_MAR_ERR_FLAG)
+ conf_data |= PCI_STATUS_MASTER_ABORT;
+ if(lo & SB_PARE_ERR_FLAG)
+ conf_data |= PCI_STATUS_PARITY_DETECT;
+ break;
+ case PCI_CLASS_REG :
+ _rdmsr(GLCP_MSR_REG(GLCP_CHIP_REV_ID), &hi, &lo);
+ conf_data = lo & 0x000000ff;
+ conf_data |= (CS5536_ISA_CLASS_CODE << 8);
+ break;
+ case PCI_BHLC_REG :
+ _rdmsr(SB_MSR_REG(SB_CTRL), &hi, &lo);
+ hi &= 0x000000f8;
+ conf_data = (PCI_NONE_BIST << 24) | (PCI_BRIDGE_HEADER_TYPE << 16) |
+ (hi << 8) | PCI_NORMAL_CACHE_LINE_SIZE;
+ break;
+ /*
+ * we only use the LBAR of DIVIL, no RCONF used.
+ * all of them are IO space.
+ */
+ case PCI_BAR0_REG :
+ _rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+ if(lo & SOFT_BAR_SMB_FLAG){
+ conf_data = CS5536_SMB_RANGE | PCI_MAPREG_TYPE_IO;
+ _rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+ lo &= ~SOFT_BAR_SMB_FLAG;
+ _wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
+ }else{
+ _rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_SMB), &hi, &lo);
+ conf_data = lo & 0x0000fff8;
+ conf_data |= 0x01;
+ conf_data &= ~0x02;
+ }
+ break;
+ case PCI_BAR1_REG :
+ _rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+ if(lo & SOFT_BAR_GPIO_FLAG){
+ conf_data = CS5536_GPIO_RANGE | PCI_MAPREG_TYPE_IO;
+ _rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+ lo &= ~SOFT_BAR_GPIO_FLAG;
+ _wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
+ }else{
+ _rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_GPIO), &hi, &lo);
+ conf_data = lo & 0x0000ff00;
+ conf_data |= 0x01;
+ conf_data &= ~0x02;
+ }
+ break;
+ case PCI_BAR2_REG :
+ _rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+ if(lo & SOFT_BAR_MFGPT_FLAG){
+ conf_data = CS5536_MFGPT_RANGE | PCI_MAPREG_TYPE_IO;
+ _rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+ lo &= ~SOFT_BAR_MFGPT_FLAG;
+ _wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
+ }else{
+ _rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_MFGPT), &hi, &lo);
+ conf_data = lo & 0x0000ffc0;
+ conf_data |= 0x01;
+ conf_data &= ~0x02;
+ }
+ break;
+#if 1
+ case PCI_BAR3_REG :
+ conf_data = 0;
+ break;
+#else
+ case PCI_BAR3_REG :
+ _rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+ if(lo & SOFT_BAR_IRQ_FLAG){
+ conf_data = CS5536_IRQ_RANGE | PCI_MAPREG_TYPE_IO;
+ _rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+ lo &= ~SOFT_BAR_IRQ_FLAG;
+ _wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
+ }else{
+ _rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_IRQ), &hi, &lo);
+ conf_data = lo & 0x0000ffc0;
+ conf_data |= 0x01;
+ conf_data &= ~0x02;
+ }
+ break;
+#endif
+ case PCI_BAR4_REG :
+ _rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+ if(lo & SOFT_BAR_PMS_FLAG){
+ conf_data = CS5536_PMS_RANGE | PCI_MAPREG_TYPE_IO;
+ _rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+ lo &= ~SOFT_BAR_PMS_FLAG;
+ _wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
+ }else{
+ _rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_PMS), &hi, &lo);
+ conf_data = lo & 0x0000ff80;
+ conf_data |= 0x01;
+ conf_data &= ~0x02;
+ }
+ break;
+ case PCI_BAR5_REG :
+ _rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+ if(lo & SOFT_BAR_ACPI_FLAG){
+ conf_data = CS5536_ACPI_RANGE | PCI_MAPREG_TYPE_IO;
+ _rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+ lo &= ~SOFT_BAR_ACPI_FLAG;
+ _wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
+ }else{
+ _rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_ACPI), &hi, &lo);
+ conf_data = lo & 0x0000ffe0;
+ conf_data |= 0x01;
+ conf_data &= ~0x02;
+ }
+ break;
+ case PCI_CARDBUS_CIS_REG :
+ conf_data = PCI_CARDBUS_CIS_POINTER;
+ break;
+ case PCI_SUBSYS_ID_REG :
+ conf_data = (CS5536_ISA_SUB_ID << 16) | CS5536_SUB_VENDOR_ID;
+ break;
+ case PCI_MAPREG_ROM :
+ conf_data = PCI_EXPANSION_ROM_BAR;
+ break;
+ case PCI_CAPLISTPTR_REG :
+ conf_data = PCI_CAPLIST_POINTER;
+ break;
+ case PCI_INTERRUPT_REG :
+ conf_data = (PCI_MAX_LATENCY << 24) | (PCI_MIN_GRANT << 16) |
+ (0x00 << 8) | 0x00;
+ break;
+ default :
+ conf_data = 0;
+ break;
+ }
+
+ return conf_data;
+}
+
+#ifdef TEST_CS5536_USE_FLASH
+
+#ifndef TEST_CS5536_USE_NOR_FLASH /* for nand flash */
+static void pci_flash_write_reg(int reg, u32 value)
+{
+ u32 hi, lo;
+
+ switch(reg){
+ case PCI_COMMAND_STATUS_REG :
+ // command
+ if( value & PCI_COMMAND_MEM_ENABLE ){
+ flash_lbar_enable_disable(1);
+ }else{
+ flash_lbar_enable_disable(0);
+ }
+ // STATUS
+ if(value & PCI_STATUS_PARITY_ERROR){
+ _rdmsr(SB_MSR_REG(SB_ERROR), &hi, &lo);
+ if(lo & SB_PARE_ERR_FLAG){
+ lo = (lo & 0x0000ffff) | SB_PARE_ERR_FLAG;
+ _wrmsr(SB_MSR_REG(SB_ERROR), hi, lo);
+ }
+ }
+ break;
+ case PCI_BAR0_REG :
+ if(value == PCI_BAR_RANGE_MASK){
+ // make the flag for reading the bar length.
+ _rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+ lo |= SOFT_BAR_FLSH0_FLAG;
+ _wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
+ }else if( (value & 0x01) == 0x00 ){
+ // mem space nand flash native reg base addr
+ hi = 0xfffff007;
+ lo = value & 0xfffff000;
+ _wrmsr(DIVIL_MSR_REG(DIVIL_LBAR_FLSH0), hi, lo);
+
+ // RCONFx is 4KB in units for mem space.
+ hi = ((value & 0xfffff000) << 12) | ( (CS5536_FLSH0_LENGTH &
0xfffff000) - (1 << 12) ) | 0x00;
+ lo = ((value & 0xfffff000) << 12) | 0x01;
+ _wrmsr(SB_MSR_REG(SB_R6), hi, lo);
+ }
+ break;
+ case PCI_BAR1_REG :
+ if(value == PCI_BAR_RANGE_MASK){
+ _rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+ lo |= SOFT_BAR_FLSH1_FLAG;
+ _wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
+ }else if( (value & 0x01) == 0x00 ){
+ // mem space nand flash native reg base addr
+ hi = 0xfffff007;
+ lo = value & 0xfffff000;
+ _wrmsr(DIVIL_MSR_REG(DIVIL_LBAR_FLSH1), hi, lo);
+
+ // RCONFx is 4KB in units for mem space.
+ hi = ((value & 0xfffff000) << 12) | ( (CS5536_FLSH1_LENGTH &
0xfffff000) - (1 << 12) ) | 0x00;
+ lo = ((value & 0xfffff000) << 12) | 0x01;
+ _wrmsr(SB_MSR_REG(SB_R7), hi, lo);
+ }
+ break;
+ case PCI_BAR2_REG :
+ if(value == PCI_BAR_RANGE_MASK){
+ _rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+ lo |= SOFT_BAR_FLSH2_FLAG;
+ _wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
+ }else if( (value & 0x01) == 0x00 ){
+ // mem space nand flash native reg base addr
+ hi = 0xfffff007;
+ lo = value & 0xfffff000;
+ _wrmsr(DIVIL_MSR_REG(DIVIL_LBAR_FLSH2), hi, lo);
+
+ // RCONFx is 4KB in units for mem space.
+ hi = ((value & 0xfffff000) << 12) | ( (CS5536_FLSH2_LENGTH &
0xfffff000) - (1 << 12) ) | 0x00;
+ lo = ((value & 0xfffff000) << 12) | 0x01;
+ _wrmsr(SB_MSR_REG(SB_R8), hi, lo);
+ }
+ break;
+ case PCI_BAR3_REG :
+ if(value == PCI_BAR_RANGE_MASK){
+ _rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+ lo |= SOFT_BAR_FLSH3_FLAG;
+ _wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
+ }else if( (value & 0x01) == 0x00 ){
+ // mem space nand flash native reg base addr
+ hi = 0xfffff007;
+ lo = value & 0xfffff000;
+ _wrmsr(DIVIL_MSR_REG(DIVIL_LBAR_FLSH3), hi, lo);
+
+ // RCONFx is 4KB in units for mem space.
+ hi = ((value & 0xfffff000) << 12) | ( (CS5536_FLSH3_LENGTH &
0xfffff000)- (1 << 12) ) | 0x00;
+ lo = ((value & 0xfffff000) << 12) | 0x01;
+ _wrmsr(SB_MSR_REG(SB_R9), hi, lo);
+ }
+ break;
+ case PCI_FLASH_INT_REG :
+ if(value){
+ /* enable all the flash interrupt in PIC */
+ _rdmsr(DIVIL_MSR_REG(PIC_YSEL_LOW), &hi, &lo);
+ lo &= ~(0xf << PIC_YSEL_LOW_FLASH_SHIFT);
+ lo |= (CS5536_FLASH_INTR << PIC_YSEL_LOW_FLASH_SHIFT);
+ _wrmsr(DIVIL_MSR_REG(PIC_YSEL_LOW), hi, lo);
+ }else{
+ /* disable all the flash interrupt in PIC */
+ _rdmsr(DIVIL_MSR_REG(PIC_YSEL_LOW), &hi, &lo);
+ lo &= ~(0xf << PIC_YSEL_LOW_FLASH_SHIFT);
+ _wrmsr(DIVIL_MSR_REG(PIC_YSEL_LOW), hi, lo);
+ }
+ break;
+ case PCI_NAND_FLASH_TDATA_REG :
+ hi = 0;
+ lo = value;
+ _wrmsr(DIVIL_MSR_REG(NANDF_DATA), hi, lo);
+ break;
+ case PCI_NAND_FLASH_TCTRL_REG :
+ hi = 0;
+ lo = value & 0x00000fff;
+ _wrmsr(DIVIL_MSR_REG(NANDF_CTRL), hi, lo);
+ break;
+ case PCI_NAND_FLASH_RSVD_REG :
+ hi = 0;
+ lo = value;
+ _wrmsr(DIVIL_MSR_REG(NANDF_RSVD), hi, lo);
+ break;
+ case PCI_FLASH_SELECT_REG :
+ if(value == CS5536_IDE_FLASH_SIGNATURE){
+ _rdmsr(DIVIL_MSR_REG(DIVIL_BALL_OPTS), &hi, &lo);
+ lo &= ~0x01;
+ _wrmsr(DIVIL_MSR_REG(DIVIL_BALL_OPTS), hi, lo);
+ }
+ break;
+ default :
+ break;
+ }
+
+ return;
+}
+
+static u32 pci_flash_read_reg(int reg)
+{
+ u32 conf_data;
+ u32 hi, lo;
+
+ switch(reg){
+ case PCI_ID_REG :
+ conf_data = (CS5536_FLASH_DEVICE_ID << 16 | CS5536_VENDOR_ID);
+ break;
+ case PCI_COMMAND_STATUS_REG :
+ conf_data = 0;
+ // COMMAND
+ // we just read one lbar for returning.
+ _rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_FLSH0), &hi, &lo);
+ if(hi & 0x01)
+ conf_data |= PCI_COMMAND_MEM_ENABLE;
+ //STATUS
+ conf_data |= PCI_STATUS_66MHZ_SUPPORT;
+ conf_data |= PCI_STATUS_BACKTOBACK_SUPPORT;
+ _rdmsr(SB_MSR_REG(SB_ERROR), &hi, &lo);
+ if(lo & SB_PARE_ERR_FLAG)
+ conf_data |= PCI_STATUS_PARITY_ERROR;
+ conf_data |= PCI_STATUS_DEVSEL_MEDIUM;
+ break;
+ case PCI_CLASS_REG :
+ _rdmsr(DIVIL_MSR_REG(DIVIL_CAP), &hi, &lo);
+ conf_data = lo & 0x000000ff;
+ conf_data |= (CS5536_FLASH_CLASS_CODE << 8);
+ break;
+ case PCI_BHLC_REG :
+ conf_data = (PCI_NONE_BIST << 24) | (PCI_NORMAL_HEADER_TYPE << 16) |
+ (PCI_NORMAL_LATENCY_TIMER << 8) | PCI_NORMAL_CACHE_LINE_SIZE;
+ break;
+ case PCI_BAR0_REG :
+ _rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+ if(lo & SOFT_BAR_FLSH0_FLAG){
+ conf_data = CS5536_FLSH0_RANGE | PCI_MAPREG_TYPE_MEM;
+ _rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+ lo &= ~SOFT_BAR_FLSH0_FLAG;
+ _wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
+ }else{
+ _rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_FLSH0), &hi, &lo);
+ conf_data = lo;
+ conf_data &= ~0x0f;
+ }
+ break;
+ case PCI_BAR1_REG :
+ _rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+ if(lo & SOFT_BAR_FLSH1_FLAG){
+ conf_data = CS5536_FLSH1_RANGE | PCI_MAPREG_TYPE_MEM;
+ _rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+ lo &= ~SOFT_BAR_FLSH1_FLAG;
+ _wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
+ }else{
+ _rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_FLSH1), &hi, &lo);
+ conf_data = lo;
+ conf_data &= ~0x0f;
+ }
+ break;
+ case PCI_BAR2_REG :
+ _rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+ if(lo & SOFT_BAR_FLSH2_FLAG){
+ conf_data = CS5536_FLSH2_RANGE | PCI_MAPREG_TYPE_MEM;
+ _rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+ lo &= ~SOFT_BAR_FLSH2_FLAG;
+ _wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
+ }else{
+ _rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_FLSH2), &hi, &lo);
+ conf_data = lo;
+ conf_data &= ~0x0f;
+ }
+ break;
+ case PCI_BAR3_REG :
+ _rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+ if(lo & SOFT_BAR_FLSH3_FLAG){
+ conf_data = CS5536_FLSH3_RANGE | PCI_MAPREG_TYPE_MEM;
+ _rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+ lo &= ~SOFT_BAR_FLSH3_FLAG;
+ _wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
+ }else{
+ _rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_FLSH3), &hi, &lo);
+ conf_data = lo;
+ conf_data &= ~0x0f;
+ }
+ break;
+ case PCI_CARDBUS_CIS_REG :
+ conf_data = PCI_CARDBUS_CIS_POINTER;
+ break;
+ case PCI_SUBSYS_ID_REG :
+ conf_data = (CS5536_FLASH_SUB_ID << 16) | CS5536_SUB_VENDOR_ID;
+ break;
+ case PCI_MAPREG_ROM :
+ conf_data = PCI_EXPANSION_ROM_BAR;
+ break;
+ case PCI_CAPLISTPTR_REG :
+ conf_data = PCI_CAPLIST_POINTER;
+ break;
+ case PCI_INTERRUPT_REG :
+ conf_data = (PCI_MAX_LATENCY << 24) | (PCI_MIN_GRANT << 16) |
+ (PCI_DEFAULT_PIN << 8) | (CS5536_FLASH_INTR);
+ break;
+ case PCI_NAND_FLASH_TDATA_REG :
+ _rdmsr(DIVIL_MSR_REG(NANDF_DATA), &hi, &lo);
+ conf_data = lo;
+ break;
+ case PCI_NAND_FLASH_TCTRL_REG :
+ _rdmsr(DIVIL_MSR_REG(NANDF_CTRL), &hi, &lo);
+ conf_data = lo & 0x00000fff;
+ break;
+ case PCI_NAND_FLASH_RSVD_REG :
+ _rdmsr(DIVIL_MSR_REG(NANDF_RSVD), &hi, &lo);
+ conf_data = lo;
+ break;
+ case PCI_FLASH_SELECT_REG :
+ _rdmsr(DIVIL_MSR_REG(DIVIL_BALL_OPTS), &hi, &lo);
+ conf_data = lo & 0x01;
+ break;
+
+ }
+ return 0;
+}
+
+#else /* nor flash */
+
+static void pci_flash_write_reg(int reg, u32 value)
+{
+ u32 hi, lo;
+
+ switch(reg){
+ case PCI_COMMAND_STATUS_REG :
+ // command
+ if( value & PCI_COMMAND_IO_ENABLE ){
+ flash_lbar_enable_disable(1);
+ }else{
+ flash_lbar_enable_disable(0);
+ }
+ // STATUS
+ if(value & PCI_STATUS_PARITY_ERROR){
+ _rdmsr(SB_MSR_REG(SB_ERROR), &hi, &lo);
+ if(lo & SB_PARE_ERR_FLAG){
+ lo = (lo & 0x0000ffff) | SB_PARE_ERR_FLAG;
+ _wrmsr(SB_MSR_REG(SB_ERROR), hi, lo);
+ }
+ }
+ break;
+ case PCI_BAR0_REG :
+ if(value == PCI_BAR_RANGE_MASK){
+ _rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+ lo |= SOFT_BAR_FLSH0_FLAG;
+ _wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
+ }else if(value & 0x01){
+ // IO space of 16bytes nor flash
+ hi = 0x0000fff1;
+ lo = value & 0x0000fff0;
+ _wrmsr(DIVIL_MSR_REG(DIVIL_LBAR_FLSH0), hi, lo);
+
+ // RCONFx used for 16bytes reserved.
+ hi = ((value & 0x000ffffc) << 12) | ((CS5536_FLSH0_LENGTH - 4) << 12)
| 0x01;
+ lo = ((value & 0x000ffffc) << 12) | 0x01;
+ _wrmsr(SB_MSR_REG(SB_R6), hi, lo);
+ }
+ break;
+ case PCI_BAR1_REG :
+ if(value == PCI_BAR_RANGE_MASK){
+ _rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+ lo |= SOFT_BAR_FLSH1_FLAG;
+ _wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
+ }else if(value & 0x01){
+ // IO space of 16bytes nor flash
+ hi = 0x0000fff1;
+ lo = value & 0x0000fff0;
+ _wrmsr(DIVIL_MSR_REG(DIVIL_LBAR_FLSH1), hi, lo);
+
+ // RCONFx used for 16bytes reserved.
+ hi = ((value & 0x000ffffc) << 12) | ((CS5536_FLSH1_LENGTH - 4) << 12)
| 0x01;
+ lo = ((value & 0x000ffffc) << 12) | 0x01;
+ _wrmsr(SB_MSR_REG(SB_R7), hi, lo);
+ }
+ break;
+ case PCI_BAR2_REG :
+ if(value == PCI_BAR_RANGE_MASK){
+ _rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+ lo |= SOFT_BAR_FLSH2_FLAG;
+ _wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
+ }else if(value & 0x01){
+ hi = 0x0000fff1;
+ lo = value & 0x0000fff0;
+ _wrmsr(DIVIL_MSR_REG(DIVIL_LBAR_FLSH2), hi, lo);
+
+ hi = ((value & 0x000ffffc) << 12) | ((CS5536_FLSH2_LENGTH - 4) << 12)
| 0x01;
+ lo = ((value & 0x000ffffc) << 12) | 0x01;
+ _wrmsr(SB_MSR_REG(SB_R8), hi, lo);
+ }
+ break;
+ case PCI_BAR3_REG :
+ if(value == PCI_BAR_RANGE_MASK){
+ _rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+ lo |= SOFT_BAR_FLSH3_FLAG;
+ _wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
+ }else if(value & 0x01){
+ // 16bytes for nor flash
+ hi = 0x0000fff1;
+ lo = value & 0x0000fff0;
+ _wrmsr(DIVIL_MSR_REG(DIVIL_LBAR_FLSH3), hi, lo);
+
+ // 16bytes of IO space of RCONFx region.
+ hi = ((value & 0x000ffffc) << 12) | ((CS5536_FLSH3_LENGTH - 4) << 12)
| 0x01;
+ lo = ((value & 0x000ffffc) << 12) | 0x01;
+ _wrmsr(SB_MSR_REG(SB_R9), hi, lo);
+ }
+ break;
+
+ case PCI_INTERRUPT_REG :
+ conf_data = (PCI_MAX_LATENCY << 24) | (PCI_MIN_GRANT << 16) |
+ (PCI_DEFAULT_PIN << 8) | (CS5536_FLASH_INTR);
+ break;
+ case PCI_FLASH_INT_REG :
+ if(value){
+ /* enable all the flash interrupt in PIC */
+ _rdmsr(DIVIL_MSR_REG(PIC_YSEL_LOW), &hi, &lo);
+ lo &= ~(0xf << PIC_YSEL_LOW_FLASH_SHIFT);
+ lo |= (CS5536_FLASH_INTR << PIC_YSEL_LOW_FLASH_SHIFT);
+ _wrmsr(DIVIL_MSR_REG(PIC_YSEL_LOW), hi, lo);
+ }else{
+ /* disable all the flash interrupt in PIC */
+ _rdmsr(DIVIL_MSR_REG(PIC_YSEL_LOW), &hi, &lo);
+ lo &= ~(0xf << PIC_YSEL_LOW_FLASH_SHIFT);
+ _wrmsr(DIVIL_MSR_REG(PIC_YSEL_LOW), hi, lo);
+ }
+ break;
+ case PCI_NOR_FLASH_CTRL_REG :
+ hi = 0;
+ lo = value & 0x000000ff;
+ _wrmsr(DIVIL_MSR_REG(NORF_CTRL), hi, lo);
+ break;
+ case PCI_NOR_FLASH_T01_REG :
+ hi = 0;
+ lo = value;
+ _wrmsr(DIVIL_MSR_REG(NORF_T01), hi, lo);
+ break;
+ case PCI_NOR_FLASH_T23_REG :
+ hi = 0;
+ lo = value;
+ _wrmsr(DIVIL_MSR_REG(NORF_T23), hi, lo);
+ break;
+ case PCI_FLASH_SELECT_REG :
+ if(value == CS5536_IDE_FLASH_SIGNATURE){
+ _rdmsr(DIVIL_MSR_REG(DIVIL_BALL_OPTS), &hi, &lo);
+ lo &= ~0x01;
+ _wrmsr(DIVIL_MSR_REG(DIVIL_BALL_OPTS), hi, lo);
+ }
+ break;
+
+ default :
+ break;
+ }
+
+ return;
+}
+
+static u32 pci_flash_read_reg(int reg)
+{
+ u32 conf_data;
+ u32 hi, lo;
+
+ switch(reg){
+ case PCI_ID_REG :
+ conf_data = (CS5536_FLASH_DEVICE_ID << 16 | CS5536_VENDOR_ID);
+ break;
+ case PCI_COMMAND_STATUS_REG :
+ conf_data = 0;
+ // COMMAND
+ // we just check one flash bar for returning.
+ _rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_FLSH0), &hi, &lo);
+ if(hi & 0x01)
+ conf_data |= PCI_COMMAND_IO_ENABLE;
+ //STATUS
+ conf_data |= PCI_STATUS_66MHZ_SUPPORT;
+ conf_data |= PCI_STATUS_BACKTOBACK_SUPPORT;
+ _rdmsr(SB_MSR_REG(SB_ERROR), &hi, &lo);
+ if(lo & SB_PARE_ERR_FLAG)
+ conf_data |= PCI_STATUS_PARITY_ERROR;
+ conf_data |= PCI_STATUS_DEVSEL_MEDIUM;
+ break;
+ case PCI_CLASS_REG :
+ _rdmsr(DIVIL_MSR_REG(DIVIL_CAP), &hi, &lo);
+ conf_data = lo & 0x000000ff;
+ conf_data |= (CS5536_FLASH_CLASS_CODE << 8);
+ break;
+ case PCI_BHLC_REG :
+ conf_data = (PCI_NONE_BIST << 24) | (PCI_NORMAL_HEADER_TYPE << 16) |
+ (PCI_NORMAL_LATENCY_TIMER << 8) | PCI_NORMAL_CACHE_LINE_SIZE;
+ break;
+ case PCI_BAR0_REG :
+ _rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+ if(lo & SOFT_BAR_FLSH0_FLAG){
+ conf_data = CS5536_FLSH0_RANGE | PCI_MAPREG_TYPE_IO;
+ _rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+ lo &= ~SOFT_BAR_FLSH0_FLAG;
+ _wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
+ }else{
+ _rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_FLSH0), &hi, &lo);
+ conf_data = lo & 0x0000ffff;
+ conf_data |= 0x01;
+ conf_data &= ~0x02;
+ }
+ break;
+ case PCI_BAR1_REG :
+ _rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+ if(lo & SOFT_BAR_FLSH1_FLAG){
+ conf_data = CS5536_FLSH1_RANGE | PCI_MAPREG_TYPE_IO;
+ _rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+ lo &= ~SOFT_BAR_FLSH1_FLAG;
+ _wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
+ }else{
+ _rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_FLSH1), &hi, &lo);
+ conf_data = lo & 0x0000ffff;
+ conf_data |= 0x01;
+ conf_data &= ~0x02;
+ }
+ break;
+ case PCI_BAR2_REG :
+ _rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+ if(lo & SOFT_BAR_FLSH2_FLAG){
+ conf_data = CS5536_FLSH2_RANGE | PCI_MAPREG_TYPE_IO;
+ _rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+ lo &= ~SOFT_BAR_FLSH2_FLAG;
+ _wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
+ }else{
+ _rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_FLSH2), &hi, &lo);
+ conf_data = lo & 0x0000ffff;
+ conf_data |= 0x01;
+ conf_data &= ~0x02;
+ }
+ break;
+ case PCI_BAR3_REG :
+ _rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+ if(lo & SOFT_BAR_FLSH3_FLAG){
+ conf_data = CS5536_FLSH3_RANGE | PCI_MAPREG_TYPE_IO;
+ _rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+ lo &= ~SOFT_BAR_FLSH3_FLAG;
+ _wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
+ }else{
+ _rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_FLSH3), &hi, &lo);
+ conf_data = lo & 0x0000ffff;
+ conf_data |= 0x01;
+ conf_data &= ~0x02;
+ }
+ break;
+ case PCI_CARDBUS_CIS_REG :
+ conf_data = PCI_CARDBUS_CIS_POINTER;
+ break;
+ case PCI_SUBSYS_ID_REG :
+ conf_data = (CS5536_FLASH_SUB_ID << 16) | CS5536_SUB_VENDOR_ID;
+ break;
+ case PCI_MAPREG_ROM :
+ conf_data = PCI_EXPANSION_ROM_BAR;
+ break;
+ case PCI_CAPLISTPTR_REG :
+ conf_data = PCI_CAPLIST_POINTER;
+ break;
+ case PCI_INTERRUPT_REG :
+ conf_data = (PCI_MAX_LATENCY << 24) | (PCI_MIN_GRANT << 16) |
+ (PCI_DEFAULT_PIN << 8) | (CS5536_FLASH_INTR);
+ break;
+ case PCI_NOR_FLASH_CTRL_REG :
+ _rdmsr(DIVIL_MSR_REG(NORF_CTRL), &hi, &lo);
+ conf_data = lo & 0x000000ff;
+ break;
+ case PCI_NOR_FLASH_T01_REG :
+ _rdmsr(DIVIL_MSR_REG(NORF_T01), &hi, &lo);
+ conf_data = lo;
+ break;
+ case PCI_NOR_FLASH_T23_REG :
+ _rdmsr(DIVIL_MSR_REG(NORF_T23), &hi, &lo);
+ conf_data = lo;
+ break;
+ default :
+ conf_data = 0;
+ break;
+ }
+ return conf_data;
+}
+#endif /* TEST_CS5536_USE_NOR_FLASH */
+
+#else /* TEST_CS5536_USE_FLASH */
+
+static void pci_flash_write_reg(int reg, u32 value)
+{
+ return;
+}
+
+static u32 pci_flash_read_reg(int reg)
+{
+ return 0xffffffff;
+}
+
+#endif /* TEST_CS5536_USE_FLASH */
+
+/*
+ * ide_write : ide write transfering
+ */
+static void pci_ide_write_reg(int reg, u32 value)
+{
+ u32 hi, lo;
+
+ switch(reg){
+ case PCI_COMMAND_STATUS_REG :
+ // COMMAND
+ if(value & PCI_COMMAND_MASTER_ENABLE){
+ _rdmsr(GLIU_MSR_REG(GLIU_PAE), &hi, &lo);
+ lo |= (0x03 << 4);
+ _wrmsr(GLIU_MSR_REG(GLIU_PAE), hi, lo);
+ }else{
+ _rdmsr(GLIU_MSR_REG(GLIU_PAE), &hi, &lo);
+ lo &= ~(0x03 << 4);
+ _wrmsr(GLIU_MSR_REG(GLIU_PAE), hi, lo);
+ }
+ // STATUS
+ if(value & PCI_STATUS_PARITY_ERROR){
+ _rdmsr(SB_MSR_REG(SB_ERROR), &hi, &lo);
+ if(lo & SB_PARE_ERR_FLAG){
+ lo = (lo & 0x0000ffff) | SB_PARE_ERR_FLAG;
+ _wrmsr(SB_MSR_REG(SB_ERROR), hi, lo);
+ }
+ }
+ break;
+ case PCI_BHLC_REG :
+ value &= 0x0000ff00;
+ _rdmsr(SB_MSR_REG(SB_CTRL), &hi, &lo);
+ hi &= 0xffffff00;
+ hi |= (value >> 8);
+ _wrmsr(SB_MSR_REG(SB_CTRL), hi, lo);
+ break;
+ case PCI_BAR4_REG :
+ if(value == PCI_BAR_RANGE_MASK){
+ _rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+ lo |= SOFT_BAR_IDE_FLAG;
+ _wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
+ }else if(value & 0x01){
+ hi = 0x00000000;
+ //lo = ((value & 0x0fffffff) << 4) | 0x001;
+ lo = (value & 0xfffffff0) | 0x1;
+ _wrmsr(IDE_MSR_REG(IDE_IO_BAR), hi, lo);
+
+ value &= 0xfffffffc;
+ hi = 0x60000000 | ((value & 0x000ff000) >> 12);
+ lo = 0x000ffff0 | ((value & 0x00000fff) << 20);
+ _wrmsr(GLIU_MSR_REG(GLIU_IOD_BM2), hi, lo);
+ }
+ break;
+ case PCI_IDE_CFG_REG :
+ if(value == CS5536_IDE_FLASH_SIGNATURE){
+ _rdmsr(DIVIL_MSR_REG(DIVIL_BALL_OPTS), &hi, &lo);
+ lo |= 0x01;
+ _wrmsr(DIVIL_MSR_REG(DIVIL_BALL_OPTS), hi, lo);
+ }else{
+ hi = 0;
+ lo = value;
+ _wrmsr(IDE_MSR_REG(IDE_CFG), hi, lo);
+ }
+ break;
+ case PCI_IDE_DTC_REG :
+ hi = 0;
+ lo = value;
+ _wrmsr(IDE_MSR_REG(IDE_DTC), hi, lo);
+ break;
+ case PCI_IDE_CAST_REG :
+ hi = 0;
+ lo = value;
+ _wrmsr(IDE_MSR_REG(IDE_CAST), hi, lo);
+ break;
+ case PCI_IDE_ETC_REG :
+ hi = 0;
+ lo = value;
+ _wrmsr(IDE_MSR_REG(IDE_ETC), hi, lo);
+ break;
+ case PCI_IDE_PM_REG :
+ hi = 0;
+ lo = value;
+ _wrmsr(IDE_MSR_REG(IDE_INTERNAL_PM), hi, lo);
+ break;
+ default :
+ break;
+ }
+
+ return;
+}
+
+/*
+ * ide_read : ide read tranfering.
+ */
+static u32 pci_ide_read_reg(int reg)
+{
+ u32 conf_data;
+ u32 hi, lo;
+
+ switch(reg){
+ case PCI_ID_REG :
+ conf_data = (CS5536_IDE_DEVICE_ID << 16 | CS5536_VENDOR_ID);
+ break;
+ case PCI_COMMAND_STATUS_REG :
+ conf_data = 0;
+ // COMMAND
+ _rdmsr(IDE_MSR_REG(IDE_IO_BAR), &hi, &lo);
+ if(lo & 0xfffffff0)
+ conf_data |= PCI_COMMAND_IO_ENABLE;
+ _rdmsr(GLIU_MSR_REG(GLIU_PAE), &hi, &lo);
+ if( (lo & 0x30) == 0x30 )
+ conf_data |= PCI_COMMAND_MASTER_ENABLE;
+ /* conf_data |= PCI_COMMAND_BACKTOBACK_ENABLE??? HOW TO GET..*/
+ //STATUS
+ conf_data |= PCI_STATUS_66MHZ_SUPPORT;
+ conf_data |= PCI_STATUS_BACKTOBACK_SUPPORT;
+ _rdmsr(SB_MSR_REG(SB_ERROR), &hi, &lo);
+ if(lo & SB_PARE_ERR_FLAG)
+ conf_data |= PCI_STATUS_PARITY_ERROR;
+ conf_data |= PCI_STATUS_DEVSEL_MEDIUM;
+ break;
+ case PCI_CLASS_REG :
+ _rdmsr(IDE_MSR_REG(IDE_CAP), &hi, &lo);
+ conf_data = lo & 0x000000ff;
+ conf_data |= (CS5536_IDE_CLASS_CODE << 8);
+ break;
+ case PCI_BHLC_REG :
+ _rdmsr(SB_MSR_REG(SB_CTRL), &hi, &lo);
+ hi &= 0x000000f8;
+ conf_data = (PCI_NONE_BIST << 24) | (PCI_NORMAL_HEADER_TYPE << 16) |
+ (hi << 8) | PCI_NORMAL_CACHE_LINE_SIZE;
+ break;
+ case PCI_BAR0_REG :
+ conf_data = 0x00000000;
+ break;
+ case PCI_BAR1_REG :
+ conf_data = 0x00000000;
+ break;
+ case PCI_BAR2_REG :
+ conf_data = 0x00000000;
+ break;
+ case PCI_BAR3_REG :
+ conf_data = 0x00000000;
+ break;
+ case PCI_BAR4_REG :
+ _rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+ if(lo & SOFT_BAR_IDE_FLAG){
+ conf_data = CS5536_IDE_RANGE | PCI_MAPREG_TYPE_IO;
+ _rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+ lo &= ~SOFT_BAR_IDE_FLAG;
+ _wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
+ }else{
+ _rdmsr(IDE_MSR_REG(IDE_IO_BAR), &hi, &lo);
+ //conf_data = lo >> 4;
+ conf_data = lo & 0xfffffff0;
+ conf_data |= 0x01;
+ conf_data &= ~0x02;
+ }
+ break;
+ case PCI_BAR5_REG :
+ conf_data = 0x00000000;
+ break;
+ case PCI_CARDBUS_CIS_REG :
+ conf_data = PCI_CARDBUS_CIS_POINTER;
+ break;
+ case PCI_SUBSYS_ID_REG :
+ conf_data = (CS5536_IDE_SUB_ID << 16) | CS5536_SUB_VENDOR_ID;
+ break;
+ case PCI_MAPREG_ROM :
+ conf_data = PCI_EXPANSION_ROM_BAR;
+ break;
+ case PCI_CAPLISTPTR_REG :
+ conf_data = PCI_CAPLIST_POINTER;
+ break;
+ case PCI_INTERRUPT_REG :
+ conf_data = (PCI_MAX_LATENCY << 24) | (PCI_MIN_GRANT << 16) |
+ (PCI_DEFAULT_PIN << 8) | (CS5536_IDE_INTR);
+ break;
+ case PCI_IDE_CFG_REG :
+ _rdmsr(IDE_MSR_REG(IDE_CFG), &hi, &lo);
+ conf_data = lo;
+ break;
+ case PCI_IDE_DTC_REG :
+ _rdmsr(IDE_MSR_REG(IDE_DTC), &hi, &lo);
+ conf_data = lo;
+ break;
+ case PCI_IDE_CAST_REG :
+ _rdmsr(IDE_MSR_REG(IDE_CAST), &hi, &lo);
+ conf_data = lo;
+ break;
+ case PCI_IDE_ETC_REG :
+ _rdmsr(IDE_MSR_REG(IDE_ETC), &hi, &lo);
+ conf_data = lo;
+ case PCI_IDE_PM_REG :
+ _rdmsr(IDE_MSR_REG(IDE_INTERNAL_PM), &hi, &lo);
+ conf_data = lo;
+ break;
+
+ default :
+ conf_data = 0;
+ break;
+ }
+
+ return conf_data;
+}
+
+static void pci_acc_write_reg(int reg, u32 value)
+{
+ u32 hi, lo;
+
+ switch(reg){
+ case PCI_COMMAND_STATUS_REG :
+ // COMMAND
+ if(value & PCI_COMMAND_MASTER_ENABLE){
+ _rdmsr(GLIU_MSR_REG(GLIU_PAE), &hi, &lo);
+ lo |= (0x03 << 8);
+ _wrmsr(GLIU_MSR_REG(GLIU_PAE), hi, lo);
+ }else{
+ _rdmsr(GLIU_MSR_REG(GLIU_PAE), &hi, &lo);
+ lo &= ~(0x03 << 8);
+ _wrmsr(GLIU_MSR_REG(GLIU_PAE), hi, lo);
+ }
+ // STATUS
+ if(value & PCI_STATUS_PARITY_ERROR){
+ _rdmsr(SB_MSR_REG(SB_ERROR), &hi, &lo);
+ if(lo & SB_PARE_ERR_FLAG){
+ lo = (lo & 0x0000ffff) | SB_PARE_ERR_FLAG;
+ _wrmsr(SB_MSR_REG(SB_ERROR), hi, lo);
+ }
+ }
+ break;
+ case PCI_BAR0_REG :
+ if(value == PCI_BAR_RANGE_MASK){
+ _rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+ lo |= SOFT_BAR_ACC_FLAG;
+ _wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
+ }else if( value & 0x01 ){
+ value &= 0xfffffffc;
+ hi = 0xA0000000 | ((value & 0x000ff000) >> 12);
+ lo = 0x000fff80 | ((value & 0x00000fff) << 20);
+ _wrmsr(GLIU_MSR_REG(GLIU_IOD_BM1), hi, lo);
+ }
+ break;
+ case PCI_ACC_INT_REG :
+ if(value){
+ /* enable all the acc interrupt in PIC */
+ _rdmsr(DIVIL_MSR_REG(PIC_YSEL_LOW), &hi, &lo);
+ lo &= ~(0xf << PIC_YSEL_LOW_ACC_SHIFT);
+ lo |= (CS5536_ACC_INTR << PIC_YSEL_LOW_ACC_SHIFT);
+ _wrmsr(DIVIL_MSR_REG(PIC_YSEL_LOW), hi, lo);
+ }else{
+ /* disable all the usb interrupt in PIC */
+ _rdmsr(DIVIL_MSR_REG(PIC_YSEL_LOW), &hi, &lo);
+ lo &= ~(0xf << PIC_YSEL_LOW_ACC_SHIFT);
+ _wrmsr(DIVIL_MSR_REG(PIC_YSEL_LOW), hi, lo);
+ }
+ break;
+ default :
+ break;
+ }
+
+ return;
+}
+
+static u32 pci_acc_read_reg(int reg)
+{
+ u32 hi, lo;
+ u32 conf_data;
+
+ switch(reg){
+ case PCI_ID_REG :
+ conf_data = (CS5536_ACC_DEVICE_ID << 16 | CS5536_VENDOR_ID);
+ break;
+ case PCI_COMMAND_STATUS_REG :
+
+ conf_data = 0;
+ // COMMAND
+ _rdmsr(GLIU_MSR_REG(GLIU_IOD_BM1), &hi, &lo);
+ if( ( (lo & 0xfff00000) || (hi & 0x000000ff) )
+ && ((hi & 0xf0000000) == 0xa0000000) )
+ conf_data |= PCI_COMMAND_IO_ENABLE;
+ _rdmsr(GLIU_MSR_REG(GLIU_PAE), &hi, &lo);
+ if( (lo & 0x300) == 0x300 )
+ conf_data |= PCI_COMMAND_MASTER_ENABLE;
+ /* conf_data |= PCI_COMMAND_BACKTOBACK_ENABLE??? HOW TO GET..*/
+ //STATUS
+ conf_data |= PCI_STATUS_66MHZ_SUPPORT;
+ conf_data |= PCI_STATUS_BACKTOBACK_SUPPORT;
+ _rdmsr(SB_MSR_REG(SB_ERROR), &hi, &lo);
+ if(lo & SB_PARE_ERR_FLAG)
+ conf_data |= PCI_STATUS_PARITY_ERROR;
+ conf_data |= PCI_STATUS_DEVSEL_MEDIUM;
+ break;
+ case PCI_CLASS_REG :
+ _rdmsr(ACC_MSR_REG(ACC_CAP), &hi, &lo);
+ conf_data = lo & 0x000000ff;
+ conf_data |= (CS5536_ACC_CLASS_CODE << 8);
+ break;
+ case PCI_BHLC_REG :
+ conf_data = (PCI_NONE_BIST << 24) | (PCI_NORMAL_HEADER_TYPE << 16) |
+ (PCI_NORMAL_LATENCY_TIMER << 8) | PCI_NORMAL_CACHE_LINE_SIZE;
+ break;
+ case PCI_BAR0_REG :
+ _rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+ if(lo & SOFT_BAR_ACC_FLAG){
+ conf_data = CS5536_ACC_RANGE | PCI_MAPREG_TYPE_IO;
+ _rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+ lo &= ~SOFT_BAR_ACC_FLAG;
+ _wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
+ }else{
+ _rdmsr(GLIU_MSR_REG(GLIU_IOD_BM1), &hi, &lo);
+ conf_data = (hi & 0x000000ff) << 12;
+ conf_data |= (lo & 0xfff00000) >> 20;
+ conf_data |= 0x01;
+ conf_data &= ~0x02;
+ }
+ break;
+ case PCI_BAR1_REG :
+ conf_data = 0x000000;
+ break;
+ case PCI_BAR2_REG :
+ conf_data = 0x000000;
+ break;
+ case PCI_BAR3_REG :
+ conf_data = 0x000000;
+ break;
+ case PCI_BAR4_REG :
+ conf_data = 0x000000;
+ break;
+ case PCI_BAR5_REG :
+ conf_data = 0x000000;
+ break;
+ case PCI_CARDBUS_CIS_REG :
+ conf_data = PCI_CARDBUS_CIS_POINTER;
+ break;
+ case PCI_SUBSYS_ID_REG :
+ conf_data = (CS5536_ACC_SUB_ID << 16) | CS5536_SUB_VENDOR_ID;
+ break;
+ case PCI_MAPREG_ROM :
+ conf_data = PCI_EXPANSION_ROM_BAR;
+ break;
+ case PCI_CAPLISTPTR_REG :
+ conf_data = PCI_CAPLIST_USB_POINTER;
+ break;
+ case PCI_INTERRUPT_REG :
+ conf_data = (PCI_MAX_LATENCY << 24) | (PCI_MIN_GRANT << 16) |
+ (PCI_DEFAULT_PIN << 8) | (CS5536_ACC_INTR);
+ break;
+ default :
+ conf_data = 0;
+ break;
+ }
+
+ return conf_data;
+}
+
+
+/*
+ * ohci_write : ohci write tranfering.
+ */
+static void pci_ohci_write_reg(int reg, u32 value)
+{
+ u32 hi, lo;
+
+ switch(reg){
+ case PCI_COMMAND_STATUS_REG :
+ // COMMAND
+ if(value & PCI_COMMAND_MASTER_ENABLE){
+ _rdmsr(USB_MSR_REG(USB_OHCI), &hi, &lo);
+ hi |= (1 << 2);
+ _wrmsr(USB_MSR_REG(USB_OHCI), hi, lo);
+ }else{
+ _rdmsr(USB_MSR_REG(USB_OHCI), &hi, &lo);
+ hi &= ~(1 << 2);
+ _wrmsr(USB_MSR_REG(USB_OHCI), hi, lo);
+ }
+ if(value & PCI_COMMAND_MEM_ENABLE){
+ _rdmsr(USB_MSR_REG(USB_OHCI), &hi, &lo);
+ hi |= (1 << 1);
+ _wrmsr(USB_MSR_REG(USB_OHCI), hi, lo);
+ }else{
+ _rdmsr(USB_MSR_REG(USB_OHCI), &hi, &lo);
+ hi &= ~(1 << 1);
+ _wrmsr(USB_MSR_REG(USB_OHCI), hi, lo);
+ }
+ // STATUS
+ if(value & PCI_STATUS_PARITY_ERROR){
+ _rdmsr(SB_MSR_REG(SB_ERROR), &hi, &lo);
+ if(lo & SB_PARE_ERR_FLAG){
+ lo = (lo & 0x0000ffff) | SB_PARE_ERR_FLAG;
+ _wrmsr(SB_MSR_REG(SB_ERROR), hi, lo);
+ }
+ }
+ break;
+ case PCI_BAR0_REG :
+ if(value == PCI_BAR_RANGE_MASK){
+ _rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+ lo |= SOFT_BAR_OHCI_FLAG;
+ _wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
+ }else if( (value & 0x01) == 0x00 ){
+ _rdmsr(USB_MSR_REG(USB_OHCI), &hi, &lo);
+ //lo = (value & 0xffffff00) << 8;
+ lo = value;
+ _wrmsr(USB_MSR_REG(USB_OHCI), hi, lo);
+
+ value &= 0xfffffff0;
+ hi = 0x40000000 | ((value & 0xff000000) >> 24);
+ lo = 0x000fffff | ((value & 0x00fff000) << 8);
+ _wrmsr(GLIU_MSR_REG(GLIU_P2D_BM3), hi, lo);
+ }
+ break;
+ case PCI_INTERRUPT_REG :
+ value &= 0x000000ff;
+ break;
+ case PCI_OHCI_PM_REG :
+ break;
+ case PCI_OHCI_INT_REG :
+ if(value){
+ /* enable all the usb interrupt in PIC */
+ _rdmsr(DIVIL_MSR_REG(PIC_YSEL_LOW), &hi, &lo);
+ lo &= ~(0xf << 8);
+ lo |= (CS5536_USB_INTR << 8);
+ _wrmsr(DIVIL_MSR_REG(PIC_YSEL_LOW), hi, lo);
+ }else{
+ /* disable all the usb interrupt in PIC */
+ _rdmsr(DIVIL_MSR_REG(PIC_YSEL_LOW), &hi, &lo);
+ lo &= ~(0xf << 8);
+ _wrmsr(DIVIL_MSR_REG(PIC_YSEL_LOW), hi, lo);
+ }
+ break;
+ default :
+ break;
+ }
+
+ return;
+}
+
+/*
+ * ohci_read : ohci read transfering.
+ */
+static u32 pci_ohci_read_reg(int reg)
+{
+ u32 conf_data;
+ u32 hi, lo;
+
+ switch(reg){
+ case PCI_ID_REG :
+ conf_data = (CS5536_OHCI_DEVICE_ID << 16 | CS5536_VENDOR_ID);
+ break;
+ case PCI_COMMAND_STATUS_REG :
+ conf_data = 0;
+ // COMMAND
+ _rdmsr(USB_MSR_REG(USB_OHCI), &hi, &lo);
+ if(hi & 0x04)
+ conf_data |= PCI_COMMAND_MASTER_ENABLE;
+ if(hi & 0x02)
+ conf_data |= PCI_COMMAND_MEM_ENABLE;
+ // STATUS
+ conf_data |= PCI_STATUS_66MHZ_SUPPORT;
+ conf_data |= PCI_STATUS_BACKTOBACK_SUPPORT;
+ _rdmsr(SB_MSR_REG(SB_ERROR), &hi, &lo);
+ if(lo & SB_PARE_ERR_FLAG)
+ conf_data |= PCI_STATUS_PARITY_ERROR;
+ conf_data |= PCI_STATUS_DEVSEL_MEDIUM;
+ break;
+ case PCI_CLASS_REG :
+ _rdmsr(USB_MSR_REG(USB_CAP), &hi, &lo);
+ conf_data = lo & 0x000000ff;
+ conf_data |= (CS5536_OHCI_CLASS_CODE << 8);
+ break;
+ case PCI_BHLC_REG :
+ conf_data = (PCI_NONE_BIST << 24) | (PCI_NORMAL_HEADER_TYPE << 16) |
+ (0x00 << 8) | PCI_NORMAL_CACHE_LINE_SIZE;
+ break;
+ case PCI_BAR0_REG :
+ _rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+ if(lo & SOFT_BAR_OHCI_FLAG){
+ conf_data = CS5536_OHCI_RANGE | PCI_MAPREG_TYPE_MEM;
+ _rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+ lo &= ~SOFT_BAR_OHCI_FLAG;
+ _wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
+ }else{
+ _rdmsr(USB_MSR_REG(USB_OHCI), &hi, &lo);
+ //conf_data = lo >> 8;
+ conf_data = lo & 0xffffff00;
+ conf_data &= ~0x0000000f; // 32bit mem
+ }
+ break;
+ case PCI_BAR1_REG :
+ conf_data = 0x000000;
+ break;
+ case PCI_BAR2_REG :
+ conf_data = 0x000000;
+ break;
+ case PCI_BAR3_REG :
+ conf_data = 0x000000;
+ break;
+ case PCI_BAR4_REG :
+ conf_data = 0x000000;
+ break;
+ case PCI_BAR5_REG :
+ conf_data = 0x000000;
+ break;
+ case PCI_CARDBUS_CIS_REG :
+ conf_data = PCI_CARDBUS_CIS_POINTER;
+ break;
+ case PCI_SUBSYS_ID_REG :
+ conf_data = (CS5536_OHCI_SUB_ID << 16) | CS5536_SUB_VENDOR_ID;
+ break;
+ case PCI_MAPREG_ROM :
+ conf_data = PCI_EXPANSION_ROM_BAR;
+ break;
+ case PCI_CAPLISTPTR_REG :
+ conf_data = PCI_CAPLIST_USB_POINTER;
+ break;
+ case PCI_INTERRUPT_REG :
+ conf_data = (PCI_MAX_LATENCY << 24) | (PCI_MIN_GRANT << 16) |
+ (PCI_DEFAULT_PIN << 8) | (CS5536_USB_INTR);
+ break;
+ case PCI_OHCI_PM_REG :
+ conf_data = 0;
+ break;
+ case PCI_OHCI_INT_REG :
+ _rdmsr(DIVIL_MSR_REG(0x20), &hi, &lo);
+ if((lo & 0x00000f00) == 11)
+ conf_data = 1;
+ else
+ conf_data = 0;
+ break;
+ default :
+ conf_data = 0;
+ break;
+ }
+
+ return conf_data;
+}
+
+#ifdef TEST_CS5536_USE_EHCI
+static void pci_ehci_write_reg(int reg, u32 value)
+{
+ u32 hi, lo;
+
+ switch(reg){
+ case PCI_COMMAND_STATUS_REG :
+ // COMMAND
+ if(value & PCI_COMMAND_MASTER_ENABLE){
+ _rdmsr(USB_MSR_REG(USB_EHCI), &hi, &lo);
+ hi |= (1 << 2);
+ _wrmsr(USB_MSR_REG(USB_EHCI), hi, lo);
+ }else{
+ _rdmsr(USB_MSR_REG(USB_EHCI), &hi, &lo);
+ hi &= ~(1 << 2);
+ _wrmsr(USB_MSR_REG(USB_EHCI), hi, lo);
+ }
+ if(value & PCI_COMMAND_MEM_ENABLE){
+ _rdmsr(USB_MSR_REG(USB_EHCI), &hi, &lo);
+ hi |= (1 << 1);
+ _wrmsr(USB_MSR_REG(USB_EHCI), hi, lo);
+ }else{
+ _rdmsr(USB_MSR_REG(USB_EHCI), &hi, &lo);
+ hi &= ~(1 << 1);
+ _wrmsr(USB_MSR_REG(USB_EHCI), hi, lo);
+ }
+ // STATUS
+ if(value & PCI_STATUS_PARITY_ERROR){
+ _rdmsr(SB_MSR_REG(SB_ERROR), &hi, &lo);
+ if(lo & SB_PARE_ERR_FLAG){
+ lo = (lo & 0x0000ffff) | SB_PARE_ERR_FLAG;
+ _wrmsr(SB_MSR_REG(SB_ERROR), hi, lo);
+ }
+ }
+ break;
+ case PCI_BAR0_REG :
+ if(value == PCI_BAR_RANGE_MASK){
+ _rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+ lo |= SOFT_BAR_EHCI_FLAG;
+ _wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
+ }else if( (value & 0x01) == 0x00 ){
+ _rdmsr(USB_MSR_REG(USB_EHCI), &hi, &lo);
+ lo = value;
+ _wrmsr(USB_MSR_REG(USB_EHCI), hi, lo);
+
+ value &= 0xfffffff0;
+ hi = 0x40000000 | ((value & 0xff000000) >> 24);
+ lo = 0x000fffff | ((value & 0x00fff000) << 8);
+ _wrmsr(GLIU_MSR_REG(GLIU_P2D_BM4), hi, lo);
+ }
+ break;
+ case PCI_EHCI_LEGSMIEN_REG :
+ _rdmsr(USB_MSR_REG(USB_EHCI), &hi, &lo);
+ hi &= 0x003f0000;
+ hi |= (value & 0x3f) << 16;
+ _wrmsr(USB_MSR_REG(USB_EHCI), hi, lo);
+ break;
+ case PCI_EHCI_FLADJ_REG :
+ _rdmsr(USB_MSR_REG(USB_EHCI), &hi, &lo);
+ hi &= ~0x00003f00;
+ hi |= value & 0x00003f00;
+ _wrmsr(USB_MSR_REG(USB_EHCI), hi, lo);
+ break;
+ default :
+ break;
+ }
+
+ return;
+}
+
+static u32 pci_ehci_read_reg(int reg)
+{
+ u32 conf_data;
+ u32 hi, lo;
+
+ switch(reg){
+ case PCI_ID_REG :
+ conf_data = (CS5536_EHCI_DEVICE_ID << 16 | CS5536_VENDOR_ID);
+ break;
+ case PCI_COMMAND_STATUS_REG :
+ conf_data = 0;
+ // COMMAND
+ _rdmsr(USB_MSR_REG(USB_EHCI), &hi, &lo);
+ if(hi & 0x04)
+ conf_data |= PCI_COMMAND_MASTER_ENABLE;
+ if(hi & 0x02)
+ conf_data |= PCI_COMMAND_MEM_ENABLE;
+ // STATUS
+ conf_data |= PCI_STATUS_66MHZ_SUPPORT;
+ conf_data |= PCI_STATUS_BACKTOBACK_SUPPORT;
+ _rdmsr(SB_MSR_REG(SB_ERROR), &hi, &lo);
+ if(lo & SB_PARE_ERR_FLAG)
+ conf_data |= PCI_STATUS_PARITY_ERROR;
+ conf_data |= PCI_STATUS_DEVSEL_MEDIUM;
+ break;
+ case PCI_CLASS_REG :
+ _rdmsr(USB_MSR_REG(USB_CAP), &hi, &lo);
+ conf_data = lo & 0x000000ff;
+ conf_data |= (CS5536_EHCI_CLASS_CODE << 8);
+ break;
+ case PCI_BHLC_REG :
+ conf_data = (PCI_NONE_BIST << 24) | (PCI_NORMAL_HEADER_TYPE << 16) |
+ (PCI_NORMAL_LATENCY_TIMER << 8) | PCI_NORMAL_CACHE_LINE_SIZE;
+ break;
+ case PCI_BAR0_REG :
+ _rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+ if(lo & SOFT_BAR_EHCI_FLAG){
+ conf_data = CS5536_EHCI_RANGE | PCI_MAPREG_TYPE_MEM;
+ _rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+ lo &= ~SOFT_BAR_EHCI_FLAG;
+ _wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
+ }else{
+ _rdmsr(USB_MSR_REG(USB_EHCI), &hi, &lo);
+ conf_data = lo & 0xfffff000;
+ }
+ break;
+ case PCI_BAR1_REG :
+ conf_data = 0x000000;
+ break;
+ case PCI_BAR2_REG :
+ conf_data = 0x000000;
+ break;
+ case PCI_BAR3_REG :
+ conf_data = 0x000000;
+ break;
+ case PCI_BAR4_REG :
+ conf_data = 0x000000;
+ break;
+ case PCI_BAR5_REG :
+ conf_data = 0x000000;
+ break;
+ case PCI_CARDBUS_CIS_REG :
+ conf_data = PCI_CARDBUS_CIS_POINTER;
+ break;
+ case PCI_SUBSYS_ID_REG :
+ conf_data = (CS5536_EHCI_SUB_ID << 16) | CS5536_SUB_VENDOR_ID;
+ break;
+ case PCI_MAPREG_ROM :
+ conf_data = PCI_EXPANSION_ROM_BAR;
+ break;
+ case PCI_CAPLISTPTR_REG :
+ conf_data = PCI_CAPLIST_USB_POINTER;
+ break;
+ case PCI_INTERRUPT_REG :
+ conf_data = (PCI_MAX_LATENCY << 24) | (PCI_MIN_GRANT << 16) |
+ (PCI_DEFAULT_PIN << 8) | (CS5536_USB_INTR);
+ break;
+ case PCI_EHCI_LEGSMIEN_REG :
+ _rdmsr(USB_MSR_REG(USB_EHCI), &hi, &lo);
+ conf_data = (hi & 0x003f0000) >> 16;
+ break;
+ case PCI_EHCI_LEGSMISTS_REG :
+ _rdmsr(USB_MSR_REG(USB_EHCI), &hi, &lo);
+ conf_data = (hi & 0x3f000000) >> 24;
+ break;
+ case PCI_EHCI_FLADJ_REG :
+ _rdmsr(USB_MSR_REG(USB_EHCI), &hi, &lo);
+ conf_data = hi & 0x00003f00;
+ break;
+ default :
+ conf_data = 0;
+ break;
+ }
+
+ return conf_data;
+}
+#else
+static void pci_ehci_write_reg(int reg, u32 value)
+{
+ return;
+}
+
+static u32 pci_ehci_read_reg(int reg)
+{
+ return 0xffffffff;
+}
+
+
+#endif
+
+#ifdef TEST_CS5536_USE_UDC
+static void pci_udc_write_reg(int reg, u32 value)
+{
+ u32 hi, lo;
+
+ switch(reg){
+ case PCI_COMMAND_STATUS_REG :
+ // COMMAND
+ if(value & PCI_COMMAND_MASTER_ENABLE){
+ _rdmsr(USB_MSR_REG(USB_UDC), &hi, &lo);
+ hi |= (1 << 2);
+ _wrmsr(USB_MSR_REG(USB_UDC), hi, lo);
+ }else{
+ _rdmsr(USB_MSR_REG(USB_UDC), &hi, &lo);
+ hi &= ~(1 << 2);
+ _wrmsr(USB_MSR_REG(USB_UDC), hi, lo);
+ }
+ if(value & PCI_COMMAND_MEM_ENABLE){
+ _rdmsr(USB_MSR_REG(USB_UDC), &hi, &lo);
+ hi |= (1 << 1);
+ _wrmsr(USB_MSR_REG(USB_UDC), hi, lo);
+ }else{
+ _rdmsr(USB_MSR_REG(USB_UDC), &hi, &lo);
+ hi &= ~(1 << 1);
+ _wrmsr(USB_MSR_REG(USB_UDC), hi, lo);
+ }
+ // STATUS
+ if(value & PCI_STATUS_PARITY_ERROR){
+ _rdmsr(SB_MSR_REG(SB_ERROR), &hi, &lo);
+ if(lo & SB_PARE_ERR_FLAG){
+ lo = (lo & 0x0000ffff) | SB_PARE_ERR_FLAG;
+ _wrmsr(SB_MSR_REG(SB_ERROR), hi, lo);
+ }
+ }
+ break;
+ case PCI_BAR0_REG :
+ if(value == PCI_BAR_RANGE_MASK){
+ _rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+ lo |= SOFT_BAR_UDC_FLAG;
+ _wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
+ }else if( (value & 0x01) == 0x00 ){
+ _rdmsr(USB_MSR_REG(USB_UDC), &hi, &lo);
+ lo = value;
+ _wrmsr(USB_MSR_REG(USB_UDC), hi, lo);
+
+ value &= 0xfffffff0;
+ hi = 0x40000000 | ((value & 0xff000000) >> 24);
+ lo = 0x000fffff | ((value & 0x00fff000) << 8);
+ _wrmsr(GLIU_MSR_REG(GLIU_P2D_BM0), hi, lo);
+ }
+ break;
+ default :
+ break;
+ }
+
+ return;
+}
+
+static u32 pci_udc_read_reg(int reg)
+{
+ u32 conf_data;
+ u32 hi, lo;
+
+ switch(reg){
+ case PCI_ID_REG :
+ conf_data = (CS5536_UDC_DEVICE_ID << 16 | CS5536_VENDOR_ID);
+ break;
+ case PCI_COMMAND_STATUS_REG :
+ conf_data = 0;
+ // COMMAND
+ _rdmsr(USB_MSR_REG(USB_UDC), &hi, &lo);
+ if(hi & 0x04)
+ conf_data |= PCI_COMMAND_MASTER_ENABLE;
+ if(hi & 0x02)
+ conf_data |= PCI_COMMAND_MEM_ENABLE;
+ // STATUS
+ conf_data |= PCI_STATUS_66MHZ_SUPPORT;
+ conf_data |= PCI_STATUS_BACKTOBACK_SUPPORT;
+ _rdmsr(SB_MSR_REG(SB_ERROR), &hi, &lo);
+ if(lo & SB_PARE_ERR_FLAG)
+ conf_data |= PCI_STATUS_PARITY_ERROR;
+ conf_data |= PCI_STATUS_DEVSEL_MEDIUM;
+ break;
+ case PCI_CLASS_REG :
+ _rdmsr(USB_MSR_REG(USB_CAP), &hi, &lo);
+ conf_data = lo & 0x000000ff;
+ conf_data |= (CS5536_UDC_CLASS_CODE << 8);
+ break;
+ case PCI_BHLC_REG :
+ conf_data = (PCI_NONE_BIST << 24) | (PCI_NORMAL_HEADER_TYPE << 16) |
+ (0x00 << 8) | PCI_NORMAL_CACHE_LINE_SIZE;
+ break;
+ case PCI_BAR0_REG :
+ _rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+ if(lo & SOFT_BAR_UDC_FLAG){
+ conf_data = CS5536_UDC_RANGE | PCI_MAPREG_TYPE_MEM;
+ _rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+ lo &= ~SOFT_BAR_UDC_FLAG;
+ _wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
+ }else{
+ _rdmsr(USB_MSR_REG(USB_UDC), &hi, &lo);
+ conf_data = lo & 0xfffff000;
+ conf_data &= ~0x0000000f; // 32bit mem
+ }
+ break;
+ case PCI_BAR1_REG :
+ conf_data = 0x000000;
+ break;
+ case PCI_BAR2_REG :
+ conf_data = 0x000000;
+ break;
+ case PCI_BAR3_REG :
+ conf_data = 0x000000;
+ break;
+ case PCI_BAR4_REG :
+ conf_data = 0x000000;
+ break;
+ case PCI_BAR5_REG :
+ conf_data = 0x000000;
+ break;
+ case PCI_CARDBUS_CIS_REG :
+ conf_data = PCI_CARDBUS_CIS_POINTER;
+ break;
+ case PCI_SUBSYS_ID_REG :
+ conf_data = (CS5536_UDC_SUB_ID << 16) | CS5536_SUB_VENDOR_ID;
+ break;
+ case PCI_MAPREG_ROM :
+ conf_data = PCI_EXPANSION_ROM_BAR;
+ break;
+ case PCI_CAPLISTPTR_REG :
+ conf_data = PCI_CAPLIST_USB_POINTER;
+ break;
+ case PCI_INTERRUPT_REG :
+ conf_data = (PCI_MAX_LATENCY << 24) | (PCI_MIN_GRANT << 16) |
+ (PCI_DEFAULT_PIN << 8) | (CS5536_USB_INTR);
+ break;
+ default :
+ conf_data = 0;
+ break;
+ }
+
+ return conf_data;
+}
+
+#else /* TEST_CS5536_USE_UDC */
+
+static void pci_udc_write_reg(int reg, u32 value)
+{
+ return;
+}
+
+static u32 pci_udc_read_reg(int reg)
+{
+ return 0xffffffff;
+}
+
+#endif /* TEST_CS5536_USE_UDC */
+
+
+#ifdef TEST_CS5536_USE_OTG
+static void pci_otg_write_reg(int reg, u32 value)
+{
+ u32 hi, lo;
+
+ switch(reg){
+ case PCI_COMMAND_STATUS_REG :
+ // COMMAND
+ if(value & PCI_COMMAND_MEM_ENABLE){
+ _rdmsr(USB_MSR_REG(USB_OTG), &hi, &lo);
+ hi |= (1 << 1);
+ _wrmsr(USB_MSR_REG(USB_OTG), hi, lo);
+ }else{
+ _rdmsr(USB_MSR_REG(USB_OTG), &hi, &lo);
+ hi &= ~(1 << 1);
+ _wrmsr(USB_MSR_REG(USB_OTG), hi, lo);
+ }
+ // STATUS
+ if(value & PCI_STATUS_PARITY_ERROR){
+ _rdmsr(SB_MSR_REG(SB_ERROR), &hi, &lo);
+ if(lo & SB_PARE_ERR_FLAG){
+ lo = (lo & 0x0000ffff) | SB_PARE_ERR_FLAG;
+ _wrmsr(SB_MSR_REG(SB_ERROR), hi, lo);
+ }
+ }
+ break;
+ case PCI_BAR0_REG :
+ if(value == PCI_BAR_RANGE_MASK){
+ _rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+ lo |= SOFT_BAR_OTG_FLAG;
+ _wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
+ }else if( (value & 0x01) == 0x00 ){
+ _rdmsr(USB_MSR_REG(USB_OTG), &hi, &lo);
+ lo = value & 0xffffff00;
+ _wrmsr(USB_MSR_REG(USB_OTG), hi, lo);
+
+ value &= 0xfffffff0;
+ hi = 0x40000000 | ((value & 0xff000000) >> 24);
+ lo = 0x000fffff | ((value & 0x00fff000) << 8);
+ _wrmsr(GLIU_MSR_REG(GLIU_P2D_BM1), hi, lo);
+ }
+ break;
+ default :
+ break;
+ }
+
+ return;
+}
+
+static u32 pci_otg_read_reg(int reg)
+{
+ u32 conf_data;
+ u32 hi, lo;
+
+ switch(reg){
+ case PCI_ID_REG :
+ conf_data = (CS5536_OTG_DEVICE_ID << 16 | CS5536_VENDOR_ID);
+ break;
+ case PCI_COMMAND_STATUS_REG :
+ conf_data = 0;
+ // COMMAND
+ _rdmsr(USB_MSR_REG(USB_OTG), &hi, &lo);
+ if(hi & 0x02)
+ conf_data |= PCI_COMMAND_MEM_ENABLE;
+ // STATUS
+ conf_data |= PCI_STATUS_66MHZ_SUPPORT;
+ conf_data |= PCI_STATUS_BACKTOBACK_SUPPORT;
+ _rdmsr(SB_MSR_REG(SB_ERROR), &hi, &lo);
+ if(lo & SB_PARE_ERR_FLAG)
+ conf_data |= PCI_STATUS_PARITY_ERROR;
+ conf_data |= PCI_STATUS_DEVSEL_MEDIUM;
+ break;
+ case PCI_CLASS_REG :
+ _rdmsr(USB_MSR_REG(USB_CAP), &hi, &lo);
+ conf_data = lo & 0x000000ff;
+ conf_data |= (CS5536_OTG_CLASS_CODE << 8);
+ break;
+ case PCI_BHLC_REG :
+ conf_data = (PCI_NONE_BIST << 24) | (PCI_NORMAL_HEADER_TYPE << 16) |
+ (0x00 << 8) | PCI_NORMAL_CACHE_LINE_SIZE;
+ break;
+ case PCI_BAR0_REG :
+ _rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+ if(lo & SOFT_BAR_OTG_FLAG){
+ conf_data = CS5536_OTG_RANGE | PCI_MAPREG_TYPE_MEM;
+ _rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
+ lo &= ~SOFT_BAR_OTG_FLAG;
+ _wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
+ }else{
+ _rdmsr(USB_MSR_REG(USB_OTG), &hi, &lo);
+ conf_data = lo & 0xffffff00;
+ conf_data &= ~0x0000000f;
+ }
+ break;
+ case PCI_BAR1_REG :
+ conf_data = 0x000000;
+ break;
+ case PCI_BAR2_REG :
+ conf_data = 0x000000;
+ break;
+ case PCI_BAR3_REG :
+ conf_data = 0x000000;
+ break;
+ case PCI_BAR4_REG :
+ conf_data = 0x000000;
+ break;
+ case PCI_BAR5_REG :
+ conf_data = 0x000000;
+ break;
+ case PCI_CARDBUS_CIS_REG :
+ conf_data = PCI_CARDBUS_CIS_POINTER;
+ break;
+ case PCI_SUBSYS_ID_REG :
+ conf_data = (CS5536_OTG_SUB_ID << 16) | CS5536_SUB_VENDOR_ID;
+ break;
+ case PCI_MAPREG_ROM :
+ conf_data = PCI_EXPANSION_ROM_BAR;
+ break;
+ case PCI_CAPLISTPTR_REG :
+ conf_data = PCI_CAPLIST_USB_POINTER;
+ break;
+ case PCI_INTERRUPT_REG :
+ conf_data = (PCI_MAX_LATENCY << 24) | (PCI_MIN_GRANT << 16) |
+ (PCI_DEFAULT_PIN << 8) | (CS5536_USB_INTR);
+ break;
+ default :
+ conf_data = 0;
+ break;
+ }
+
+ return conf_data;
+}
+
+#else /* TEST_CS5536_USE_OTG */
+
+static void pci_otg_write_reg(int reg, u32 value)
+{
+ return;
+}
+
+static u32 pci_otg_read_reg(int reg)
+{
+ return 0xffffffff;
+}
+
+#endif /* TEST_CS5536_USE_OTG */
+
+/*******************************************************************************/
+
+/*
+ * writen : write to PCI config space and transfer it to MSR write.
+ */
+void cs5536_pci_conf_write4(int function, int reg, u32 value)
+{
+ /* some basic checking. */
+ if( (function < CS5536_FUNC_START) || (function > CS5536_FUNC_END) ){
+ return;
+ }
+ if( (reg < 0) || (reg > 0x100) || ((reg & 0x03) != 0) ){
+ return;
+ }
+
+ switch(function){
+ case CS5536_ISA_FUNC :
+ pci_isa_write_reg(reg, value);
+ break;
+
+ case CS5536_FLASH_FUNC :
+ pci_flash_write_reg(reg, value);
+ break;
+
+ case CS5536_IDE_FUNC :
+ pci_ide_write_reg(reg, value);
+ break;
+
+ case CS5536_ACC_FUNC :
+ pci_acc_write_reg(reg, value);
+ break;
+
+ case CS5536_OHCI_FUNC :
+ pci_ohci_write_reg(reg, value);
+ break;
+
+ case CS5536_EHCI_FUNC :
+ pci_ehci_write_reg(reg, value);
+ break;
+
+ case CS5536_UDC_FUNC :
+ pci_udc_write_reg(reg, value);
+ break;
+
+ case CS5536_OTG_FUNC :
+ pci_otg_write_reg(reg, value);
+ break;
+
+ default :
+ break;
+ }
+
+ return;
+}
+
+/*
+ * readn : read PCI config space and transfer it to MSR access.
+ */
+u32 cs5536_pci_conf_read4(int function, int reg)
+{
+ u32 data = 0;
+
+ /* some basic checking. */
+ if( (function < CS5536_FUNC_START) || (function > CS5536_FUNC_END) ){
+ return 0;
+ }
+ if( (reg < 0) || ((reg & 0x03) != 0) ){
+ return 0;
+ }
+ if( reg > 0x100 )
+ return 0xffffffff;
+
+ switch(function){
+ case CS5536_ISA_FUNC :
+ data = pci_isa_read_reg(reg);
+ break;
+
+ case CS5536_FLASH_FUNC :
+ data = pci_flash_read_reg(reg);
+ break;
+
+ case CS5536_IDE_FUNC :
+ data = pci_ide_read_reg(reg);
+ break;
+
+ case CS5536_ACC_FUNC :
+ data = pci_acc_read_reg(reg);
+ break;
+
+ case CS5536_OHCI_FUNC :
+ data = pci_ohci_read_reg(reg);
+ break;
+
+ case CS5536_EHCI_FUNC :
+ data = pci_ehci_read_reg(reg);
+ break;
+
+ case CS5536_UDC_FUNC :
+ data = pci_udc_read_reg(reg);
+ break;
+
+ case CS5536_OTG_FUNC :
+ data = pci_otg_read_reg(reg);
+ break;
+
+ default :
+ break;
+
+ }
+
+ return data;
+}
+
+/**************************************************************************/
+
diff --git a/arch/mips/lemote/lm2f/common/mem.c
b/arch/mips/lemote/lm2f/common/mem.c
new file mode 100644
index 0000000..aa25ad4
--- /dev/null
+++ b/arch/mips/lemote/lm2f/common/mem.c
@@ -0,0 +1,23 @@
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ */
+#include <linux/fs.h>
+#include <linux/fcntl.h>
+#include <linux/mm.h>
+
+/* override of arch/mips/mm/cache.c: __uncached_access */
+int __uncached_access(struct file *file, unsigned long addr)
+{
+ if (file->f_flags & O_SYNC)
+ return 1;
+
+ /*
+ * On the Lemote 2f system, the peripheral IO/MMIO space
+ * reside between 0x1000:0000 and 0x8000:0000.
+ */
+ return addr >= __pa(high_memory) ||
+ ((addr >= 0x10000000) && (addr < 0x80000000));
+}
diff --git a/arch/mips/lemote/lm2f/common/mfgpt.c
b/arch/mips/lemote/lm2f/common/mfgpt.c
new file mode 100644
index 0000000..e62a7fd
--- /dev/null
+++ b/arch/mips/lemote/lm2f/common/mfgpt.c
@@ -0,0 +1,222 @@
+/*
+ * CS5536 General timer functions
+ *
+ */
+#include <linux/clockchips.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/jiffies.h>
+#include <linux/module.h>
+#include <linux/spinlock.h>
+
+#include <asm/delay.h>
+#include <asm/io.h>
+#include <asm/time.h>
+
+DEFINE_SPINLOCK(mfgpt_lock);
+
+#if 1
+#define MFGFT_TICK_RATE 14318000
+#else
+#define MFGFT_TICK_RATE (14318180 / 8)
+#endif
+#define COMPARE ((MFGFT_TICK_RATE + HZ/2) / HZ)
+
+extern void _wrmsr(u32 reg, u32 hi, u32 lo);
+extern void _rdmsr(u32 reg, u32 *hi, u32 *lo);
+
+static u32 base ;
+
+/*
+ * Initialize the MFGPT timer.
+ *
+ * This is also called after resume to bring the MFGPT into operation
again.
+ */
+/* setup register bit fields:
+ 15: counter enable
+ 14: compare2 output status, write 1 to clear when in event mode
+ 13: compare1 output status
+ 12: setup(ro)
+ 11: stop enable, stop on sleep
+ 10: external enable
+ 9:8 compare2 mode; 00: disable, 01: compare on equal; 10: compare on
GE, 11 event: GE + irq
+ 7:6 compare1 mode
+ 5: reverse enable, bit reverse of the counter
+ 4: clock select. 0: 32KHz, 1: 14.318MHz
+ 3:0 counter prescaler scale factor. select the input clock divide-by
value. 2^n
+ bit 11:0 is write once.
+*/
+
+
+static void init_mfgpt_timer(enum clock_event_mode mode,
+ struct clock_event_device *evt)
+{
+ spin_lock(&mfgpt_lock);
+
+ switch(mode) {
+ case CLOCK_EVT_MODE_PERIODIC:
+ /* set comparator2 */
+ outw(COMPARE, base + 2);
+ /* set counter to 0 */
+ outw(0, base + 4);
+ /* setup; enable, comparator2 to event mode,14.318MHz clock */
+ //outw(0xe313, base + 6);
+ outw(0xe310, base + 6);
+ break;
+
+ case CLOCK_EVT_MODE_SHUTDOWN:
+ case CLOCK_EVT_MODE_UNUSED:
+ if (evt->mode == CLOCK_EVT_MODE_PERIODIC ||
+ evt->mode == CLOCK_EVT_MODE_ONESHOT) {
+ /* disable counter */
+ outw(inw(base+6) & 0x7fff, base + 6);
+ }
+ break;
+
+ case CLOCK_EVT_MODE_ONESHOT:
+ /* One shot setup */
+ break;
+
+ case CLOCK_EVT_MODE_RESUME:
+ /* Nothing to do here */
+ break;
+ }
+ spin_unlock(&mfgpt_lock);
+}
+
+/*
+ * Program the next event in oneshot mode
+ *
+ * Delta is given in MFGPT ticks
+ */
+static int mfgpt_next_event(unsigned long delta, struct
clock_event_device *evt)
+{
+ spin_lock(&mfgpt_lock);
+
+ /* set comparator2 */
+ outw(delta & 0xffff, base + 2);
+ /* set counter to 0 */
+ outw(0, base + 4);
+ /* setup; enable, comparator2 */
+ outw(0xe310, base + 6);
+
+ spin_unlock(&mfgpt_lock);
+
+ return 0;
+}
+
+static struct clock_event_device mfgpt_clockevent = {
+ .name = "mfgpt",
+ .features = CLOCK_EVT_FEAT_PERIODIC,
+ .set_mode = init_mfgpt_timer,
+ .set_next_event = mfgpt_next_event,
+ .rating = 2000,
+ .irq = 5,
+};
+
+static irqreturn_t timer_interrupt(int irq, void *dev_id)
+{
+ u32 basehi,baselo;
+
+ _rdmsr(0x8000000d,&basehi,&baselo);
+
+ base = baselo;
+ /* ack */
+// outw(0x0, baselo + 4);
+ outw(0xc000, baselo + 6);
+
+ mfgpt_clockevent.event_handler(&mfgpt_clockevent);
+
+ return IRQ_HANDLED;
+}
+
+static struct irqaction irq5 = {
+ .handler = timer_interrupt,
+ .flags = IRQF_DISABLED | IRQF_NOBALANCING,
+ .mask = CPU_MASK_NONE,
+ .name = "timer"
+};
+
+/*
+ * Initialize the conversion factor and the min/max deltas of the clock
event
+ * structure and register the clock event source with the framework.
+ */
+void __init setup_mfgpt_timer(void)
+{
+ u32 basehi;
+ struct clock_event_device *cd = &mfgpt_clockevent;
+ unsigned int cpu = smp_processor_id();
+
+ cd->cpumask = cpumask_of_cpu(cpu);
+ clockevent_set_clock(cd, MFGFT_TICK_RATE);
+ cd->max_delta_ns = clockevent_delta2ns(0xFFFF, cd);
+ cd->min_delta_ns = clockevent_delta2ns(0xF, cd);
+
+ /* connect multifunction timer0 comparator 2 to irq mapper*/
+ _wrmsr(0x80000028, 0, 0x100);
+
+ /* map unrestricted interrupt source Z4 to IG5 */
+ _wrmsr(0x80000022, 0, 0x50000);
+
+ _rdmsr(0x8000000d, &basehi, &base);
+
+ irq5.mask = cpumask_of_cpu(cpu);
+
+ clockevents_register_device(cd);
+
+ setup_irq(5, &irq5);
+
+}
+
+/*
+ * Since the MFGPT overflows every tick, its not very useful
+ * to just read by itself. So use jiffies to emulate a free
+ * running counter:
+ */
+static cycle_t mfgpt_read(void)
+{
+ static cycle_t count, old_count;
+ static unsigned long old_jifs;
+ unsigned long jifs;
+ unsigned long flags;
+
+ spin_lock_irqsave(&mfgpt_lock, flags);
+
+ jifs = jiffies;
+
+ count = inw(base + 4);
+
+ /* overflow ?*/
+ if (count < old_count && jifs == old_jifs) {
+ count = old_count;
+ }
+ old_count = count;
+ old_jifs = jifs;
+
+ spin_unlock_irqrestore(&mfgpt_lock, flags);
+
+ return (cycle_t)(jifs * COMPARE) + count;
+}
+
+static struct clocksource clocksource_mfgpt = {
+ .name = "mfgpt",
+ .rating = 1200,
+ .read = mfgpt_read,
+ .mask = CLOCKSOURCE_MASK(32),
+ .mult = 0,
+ .shift = 22,
+};
+
+int __init init_mfgpt_clocksource(void)
+{
+
+ if (num_possible_cpus() > 1) /* MFGPT does not scale! */
+ return 0;
+
+ setup_mfgpt_timer();
+
+ clocksource_mfgpt.mult = clocksource_hz2mult(MFGFT_TICK_RATE, 22);
+ return clocksource_register(&clocksource_mfgpt);
+}
+/* Too late for kernel calc delay */
+//arch_initcall(init_mfgpt_clocksource);
diff --git a/arch/mips/lemote/lm2f/common/mipsdha.c
b/arch/mips/lemote/lm2f/common/mipsdha.c
new file mode 100644
index 0000000..fd90454
--- /dev/null
+++ b/arch/mips/lemote/lm2f/common/mipsdha.c
@@ -0,0 +1,164 @@
+/*
+ * Copyright (C) 2007 Lemote, Inc. & Institute of Computing Technology
+ * Author: Fuxin Zhang, zhangfx@lemote.com
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
+ * NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
+ * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/mm.h>
+#include <linux/pci.h>
+#include <linux/init.h>
+#include <linux/proc_fs.h>
+#include <asm/uaccess.h>
+#include <asm/io.h>
+
+static ssize_t mipsdha_proc_read(struct file *file, char *buf, size_t
len, loff_t *ppos);
+
+static ssize_t mipsdha_proc_write(struct file *file, const char *buf,
size_t len, loff_t *ppos);
+
+
+static struct proc_dir_entry *mipsdha_proc_entry;
+
+#define INFO_SIZE 4096
+static char info_buf[INFO_SIZE];
+
+static struct file_operations mipsdha_fops =
+{
+ owner: THIS_MODULE,
+ read: mipsdha_proc_read,
+ write: mipsdha_proc_write,
+};
+
+static enum {CMD_ERR, CMD_GIB, CMD_GPI} cmd;
+
+typedef struct pciinfo_s
+{
+ int bus,card,func;
+ unsigned short command;
+ unsigned short vendor,device;
+ unsigned base0,base1,base2,baserom;
+} pciinfo_t;
+
+
+extern struct proc_dir_entry proc_root;
+
+static int __init mipsdha_proc_init(void)
+{
+ mipsdha_proc_entry = create_proc_entry("mipsdha", S_IWUSR | S_IRUGO,
&proc_root);
+ if (mipsdha_proc_entry == NULL) {
+ printk("MIPSDHA: register /proc/mipsdha failed!\n");
+ return 0;
+ }
+
+ mipsdha_proc_entry->owner = THIS_MODULE;
+ mipsdha_proc_entry->proc_fops = &mipsdha_fops;
+
+ cmd=CMD_ERR;
+ return 0;
+}
+
+static ssize_t mipsdha_proc_write (struct file *file, const char *buf,
size_t len, loff_t *ppos)
+{
+ char cmd_gib[]="GET IO BASE";
+ char cmd_gpi[]="GET PCI INFO";
+
+ if (len >= INFO_SIZE) return -ENOMEM;
+
+ if (copy_from_user(info_buf, buf, len)) return -EFAULT;
+ info_buf[len] = '\0';
+
+ if (strncmp(info_buf, cmd_gib, sizeof(cmd_gib)-1)==0) {
+ cmd = CMD_GIB;
+ return len;
+ } else if (strncmp(info_buf, cmd_gpi, sizeof(cmd_gpi)-1)==0) {
+ cmd = CMD_GPI;
+ return len;
+ } else {
+ return -EINVAL;
+ }
+}
+
+static ssize_t mipsdha_proc_read (struct file *file, char *buf, size_t
len, loff_t *ppos)
+{
+ int info_cnt;
+ pciinfo_t *pciinfo;
+ struct pci_dev *dev = NULL;
+
+ switch (cmd) {
+ default:
+ printk("MIPSDHA: BUG found in function %s!(cmd=%d)\n",
+ __FUNCTION__, cmd);
+ return -EINVAL;
+
+
+ case CMD_ERR:
+ return -EINVAL;
+
+
+ case CMD_GIB:
+ *(unsigned long *)info_buf =
+ virt_to_phys((void *) mips_io_port_base);
+ info_cnt=sizeof(unsigned long);
+ break;
+
+
+ case CMD_GPI:
+ pciinfo = (pciinfo_t *) info_buf;
+ info_cnt = 0;
+ for_each_pci_dev(dev) {
+
+ if (info_cnt+sizeof(pciinfo_t)>INFO_SIZE) return -ENOMEM;
+
+ pciinfo->bus = dev->bus->number;
+ pciinfo->card = PCI_SLOT(dev->devfn);
+ pciinfo->func = PCI_FUNC(dev->devfn);
+
+ if (pci_read_config_word(dev, PCI_COMMAND, &pciinfo->command)
+ != PCIBIOS_SUCCESSFUL) {
+ printk("MIPSDHA: BUG found in function %s!\n",
+ __FUNCTION__);
+ pciinfo->command=0;
+ }
+
+ pciinfo->vendor = dev->vendor;
+ pciinfo->device = dev->device;
+
+ pciinfo->base0 = (dev->resource[0]).start;
+ pciinfo->base1 = (dev->resource[1]).start;
+ pciinfo->base2 = (dev->resource[2]).start;
+ pciinfo->baserom = (dev->resource[PCI_ROM_RESOURCE]).start;
+
+ pciinfo++;
+ info_cnt += sizeof(pciinfo_t);
+ }
+ break;
+ }
+
+ if (len < info_cnt) return -ENOMEM;
+ if (copy_to_user(buf, info_buf, info_cnt)) return -EFAULT;
+
+ return info_cnt;
+}
+
+__initcall(mipsdha_proc_init);
diff --git a/arch/mips/lemote/lm2f/common/pci.c
b/arch/mips/lemote/lm2f/common/pci.c
new file mode 100644
index 0000000..f7acbe7
--- /dev/null
+++ b/arch/mips/lemote/lm2f/common/pci.c
@@ -0,0 +1,89 @@
+/*
+ * pci.c
+ *
+ * Copyright (C) 2007 Lemote, Inc. & Institute of Computing Technology
+ * Author: Fuxin Zhang, zhangfx@lemote.com
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
+ * NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
+ * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+#include <linux/types.h>
+#include <linux/pci.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+
+extern struct pci_ops loongson2f_pci_pci_ops;
+/* if you want to expand the pci memory space, you should config 64bits
kernel too. */
+
+static struct resource loongson2f_pci_mem_resource = {
+ .name = "LOONGSON2E PCI MEM",
+ .start = 0x14000000UL,
+ .end = 0x1fffffffUL,
+ .flags = IORESOURCE_MEM,
+};
+
+static struct resource loongson2f_pci_io_resource = {
+ .name = "LOONGSON2E PCI IO MEM",
+ .start = 0x00004000UL,
+ .end = 0x0000ffffUL,
+ .flags = IORESOURCE_IO,
+};
+
+
+static struct pci_controller loongson2f_pci_controller = {
+ .pci_ops = &loongson2f_pci_pci_ops,
+ .io_resource = &loongson2f_pci_io_resource,
+ .mem_resource = &loongson2f_pci_mem_resource,
+ .mem_offset = 0x00000000UL,
+ .io_offset = 0x00000000UL,
+};
+
+static int __init pcibios_init(void)
+{
+ extern int pci_probe_only;
+ pci_probe_only = 0;
+
+#ifdef CONFIG_TRACE_BOOT
+ printk(KERN_INFO"arch_initcall:pcibios_init\n");
+ printk(KERN_INFO"register_pci_controller :
%x\n",&loongson2f_pci_controller);
+#endif
+
+#ifdef CONFIG_64BIT
+ loongson2f_pci_mem_resource.start = 0x50000000UL;
+ loongson2f_pci_mem_resource.end = 0x7fffffffUL;
+ __asm__(".set mips3\n"
+ "dli $2,0x900000003ff00000\n"
+ "li $3,0x40000000\n"
+ "sd $3,0x18($2)\n"
+ "or $3,1\n"
+ "sd $3,0x58($2)\n"
+ "dli $3,0xffffffffc0000000\n"
+ "sd $3,0x38($2)\n"
+ ".set mips0\n"
+ :::"$2","$3","memory"
+ );
+#endif
+ loongson2f_pci_controller.io_map_base = mips_io_port_base;
+ register_pci_controller(&loongson2f_pci_controller);
+ return 0;
+}
+
+arch_initcall(pcibios_init);
diff --git a/arch/mips/lemote/lm2f/common/pcireg.h
b/arch/mips/lemote/lm2f/common/pcireg.h
new file mode 100644
index 0000000..aa823d3
--- /dev/null
+++ b/arch/mips/lemote/lm2f/common/pcireg.h
@@ -0,0 +1,485 @@
+/*
+ * Copyright (c) 2001, 2006 www.ict.ac.cn.
+ * Copyright (c) 2006, 2008 www.lemote.com.cn.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the named License,
+ * or any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef _DEV_PCI_PCIREG_H_
+#define _DEV_PCI_PCIREG_H_
+
+
+/*
+ * Standardized PCI configuration information
+ *
+ * XXX This is not complete.
+ */
+
+/*
+ * Device identification register; contains a vendor ID and a device ID.
+ */
+#define PCI_ID_REG 0x00
+
+typedef u_int16_t pci_vendor_id_t;
+typedef u_int16_t pci_product_id_t;
+
+#define PCI_VENDOR_SHIFT 0
+#define PCI_VENDOR_MASK 0xffff
+#define PCI_VENDOR(id) \
+ (((id) >> PCI_VENDOR_SHIFT) & PCI_VENDOR_MASK)
+
+#define PCI_PRODUCT_SHIFT 16
+#define PCI_PRODUCT_MASK 0xffff
+#define PCI_PRODUCT(id) \
+ (((id) >> PCI_PRODUCT_SHIFT) & PCI_PRODUCT_MASK)
+
+/*
+ * Command and status register.
+ */
+#define PCI_COMMAND_STATUS_REG 0x04
+
+#define PCI_COMMAND_IO_ENABLE 0x00000001
+#define PCI_COMMAND_MEM_ENABLE 0x00000002
+#define PCI_COMMAND_MASTER_ENABLE 0x00000004
+#define PCI_COMMAND_SPECIAL_ENABLE 0x00000008
+#define PCI_COMMAND_INVALIDATE_ENABLE 0x00000010
+#define PCI_COMMAND_PALETTE_ENABLE 0x00000020
+#define PCI_COMMAND_PARITY_ENABLE 0x00000040
+#define PCI_COMMAND_STEPPING_ENABLE 0x00000080
+#define PCI_COMMAND_SERR_ENABLE 0x00000100
+#define PCI_COMMAND_BACKTOBACK_ENABLE 0x00000200
+
+#define PCI_STATUS_CAPLIST_SUPPORT 0x00100000
+#define PCI_STATUS_66MHZ_SUPPORT 0x00200000
+#define PCI_STATUS_UDF_SUPPORT 0x00400000
+#define PCI_STATUS_BACKTOBACK_SUPPORT 0x00800000
+#define PCI_STATUS_PARITY_ERROR 0x01000000
+#define PCI_STATUS_DEVSEL_FAST 0x00000000
+#define PCI_STATUS_DEVSEL_MEDIUM 0x02000000
+#define PCI_STATUS_DEVSEL_SLOW 0x04000000
+#define PCI_STATUS_DEVSEL_MASK 0x06000000
+#define PCI_STATUS_TARGET_TARGET_ABORT 0x08000000
+#define PCI_STATUS_MASTER_TARGET_ABORT 0x10000000
+#define PCI_STATUS_MASTER_ABORT 0x20000000
+#define PCI_STATUS_SPECIAL_ERROR 0x40000000
+#define PCI_STATUS_PARITY_DETECT 0x80000000
+
+/*
+ * PCI Class and Revision Register; defines type and revision of device.
+ */
+#define PCI_CLASS_REG 0x08
+
+typedef u_int8_t pci_class_t;
+typedef u_int8_t pci_subclass_t;
+typedef u_int8_t pci_interface_t;
+typedef u_int8_t pci_revision_t;
+
+#define PCI_CLASS_SHIFT 24
+#define PCI_CLASS_MASK 0xff
+#define PCI_CLASS(cr) \
+ (((cr) >> PCI_CLASS_SHIFT) & PCI_CLASS_MASK)
+
+#define PCI_SUBCLASS_SHIFT 16
+#define PCI_SUBCLASS_MASK 0xff
+#define PCI_SUBCLASS(cr) \
+ (((cr) >> PCI_SUBCLASS_SHIFT) & PCI_SUBCLASS_MASK)
+
+#define PCI_ISCLASS(what, class, subclass) \
+ (((what) & 0xffff0000) == (class << 24 | subclass << 16))
+
+#define PCI_INTERFACE_SHIFT 8
+#define PCI_INTERFACE_MASK 0xff
+#define PCI_INTERFACE(cr) \
+ (((cr) >> PCI_INTERFACE_SHIFT) & PCI_INTERFACE_MASK)
+
+#define PCI_REVISION_SHIFT 0
+#define PCI_REVISION_MASK 0xff
+#define PCI_REVISION(cr) \
+ (((cr) >> PCI_REVISION_SHIFT) & PCI_REVISION_MASK)
+
+/* base classes */
+#define PCI_CLASS_PREHISTORIC 0x00
+#define PCI_CLASS_MASS_STORAGE 0x01
+#define PCI_CLASS_NETWORK 0x02
+#define PCI_CLASS_DISPLAY 0x03
+#define PCI_CLASS_MULTIMEDIA 0x04
+#define PCI_CLASS_MEMORY 0x05
+#define PCI_CLASS_BRIDGE 0x06
+#define PCI_CLASS_COMMUNICATIONS 0x07
+#define PCI_CLASS_SYSTEM 0x08
+#define PCI_CLASS_INPUT 0x09
+#define PCI_CLASS_DOCK 0x0a
+#define PCI_CLASS_PROCESSOR 0x0b
+#define PCI_CLASS_SERIALBUS 0x0c
+#define PCI_CLASS_WIRELESS 0x0d
+#define PCI_CLASS_I2O 0x0e
+#define PCI_CLASS_SATCOM 0x0f
+#define PCI_CLASS_CRYPTO 0x10
+#define PCI_CLASS_DASP 0x11
+#define PCI_CLASS_UNDEFINED 0xff
+
+/* 0x00 prehistoric subclasses */
+#define PCI_SUBCLASS_PREHISTORIC_MISC 0x00
+#define PCI_SUBCLASS_PREHISTORIC_VGA 0x01
+
+/* 0x01 mass storage subclasses */
+#define PCI_SUBCLASS_MASS_STORAGE_SCSI 0x00
+#define PCI_SUBCLASS_MASS_STORAGE_IDE 0x01
+#define PCI_SUBCLASS_MASS_STORAGE_FLOPPY 0x02
+#define PCI_SUBCLASS_MASS_STORAGE_IPI 0x03
+#define PCI_SUBCLASS_MASS_STORAGE_RAID 0x04
+#define PCI_SUBCLASS_MASS_STORAGE_ATA 0x05
+#define PCI_SUBCLASS_MASS_STORAGE_MISC 0x80
+
+/* 0x02 network subclasses */
+#define PCI_SUBCLASS_NETWORK_ETHERNET 0x00
+#define PCI_SUBCLASS_NETWORK_TOKENRING 0x01
+#define PCI_SUBCLASS_NETWORK_FDDI 0x02
+#define PCI_SUBCLASS_NETWORK_ATM 0x03
+#define PCI_SUBCLASS_NETWORK_ISDN 0x04
+#define PCI_SUBCLASS_NETWORK_WORLDFIP 0x05
+#define PCI_SUBCLASS_NETWORK_PCIMGMULTICOMP 0x06
+#define PCI_SUBCLASS_NETWORK_MISC 0x80
+
+/* 0x03 display subclasses */
+#define PCI_SUBCLASS_DISPLAY_VGA 0x00
+#define PCI_SUBCLASS_DISPLAY_XGA 0x01
+#define PCI_SUBCLASS_DISPLAY_3D 0x02
+#define PCI_SUBCLASS_DISPLAY_MISC 0x80
+
+/* 0x04 multimedia subclasses */
+#define PCI_SUBCLASS_MULTIMEDIA_VIDEO 0x00
+#define PCI_SUBCLASS_MULTIMEDIA_AUDIO 0x01
+#define PCI_SUBCLASS_MULTIMEDIA_TELEPHONY 0x02
+#define PCI_SUBCLASS_MULTIMEDIA_MISC 0x80
+
+/* 0x05 memory subclasses */
+#define PCI_SUBCLASS_MEMORY_RAM 0x00
+#define PCI_SUBCLASS_MEMORY_FLASH 0x01
+#define PCI_SUBCLASS_MEMORY_MISC 0x80
+
+/* 0x06 bridge subclasses */
+#define PCI_SUBCLASS_BRIDGE_HOST 0x00
+#define PCI_SUBCLASS_BRIDGE_ISA 0x01
+#define PCI_SUBCLASS_BRIDGE_EISA 0x02
+#define PCI_SUBCLASS_BRIDGE_MC 0x03
+#define PCI_SUBCLASS_BRIDGE_PCI 0x04
+#define PCI_SUBCLASS_BRIDGE_PCMCIA 0x05
+#define PCI_SUBCLASS_BRIDGE_NUBUS 0x06
+#define PCI_SUBCLASS_BRIDGE_CARDBUS 0x07
+#define PCI_SUBCLASS_BRIDGE_RACEWAY 0x08
+#define PCI_SUBCLASS_BRIDGE_STPCI 0x09
+#define PCI_SUBCLASS_BRIDGE_INFINIBAND 0x0a
+#define PCI_SUBCLASS_BRIDGE_MISC 0x80
+
+/* 0x07 communications subclasses */
+#define PCI_SUBCLASS_COMMUNICATIONS_SERIAL 0x00
+#define PCI_SUBCLASS_COMMUNICATIONS_PARALLEL 0x01
+#define PCI_SUBCLASS_COMMUNICATIONS_MPSERIAL 0x02
+#define PCI_SUBCLASS_COMMUNICATIONS_MODEM 0x03
+#define PCI_SUBCLASS_COMMUNICATIONS_MISC 0x80
+
+/* 0x08 system subclasses */
+#define PCI_SUBCLASS_SYSTEM_PIC 0x00
+#define PCI_SUBCLASS_SYSTEM_DMA 0x01
+#define PCI_SUBCLASS_SYSTEM_TIMER 0x02
+#define PCI_SUBCLASS_SYSTEM_RTC 0x03
+#define PCI_SUBCLASS_SYSTEM_PCIHOTPLUG 0x04
+#define PCI_SUBCLASS_SYSTEM_MISC 0x80
+
+/* 0x09 input subclasses */
+#define PCI_SUBCLASS_INPUT_KEYBOARD 0x00
+#define PCI_SUBCLASS_INPUT_DIGITIZER 0x01
+#define PCI_SUBCLASS_INPUT_MOUSE 0x02
+#define PCI_SUBCLASS_INPUT_SCANNER 0x03
+#define PCI_SUBCLASS_INPUT_GAMEPORT 0x04
+#define PCI_SUBCLASS_INPUT_MISC 0x80
+
+/* 0x0a dock subclasses */
+#define PCI_SUBCLASS_DOCK_GENERIC 0x00
+#define PCI_SUBCLASS_DOCK_MISC 0x80
+
+/* 0x0b processor subclasses */
+#define PCI_SUBCLASS_PROCESSOR_386 0x00
+#define PCI_SUBCLASS_PROCESSOR_486 0x01
+#define PCI_SUBCLASS_PROCESSOR_PENTIUM 0x02
+#define PCI_SUBCLASS_PROCESSOR_ALPHA 0x10
+#define PCI_SUBCLASS_PROCESSOR_POWERPC 0x20
+#define PCI_SUBCLASS_PROCESSOR_MIPS 0x30
+#define PCI_SUBCLASS_PROCESSOR_COPROC 0x40
+
+/* 0x0c serial bus subclasses */
+#define PCI_SUBCLASS_SERIALBUS_FIREWIRE 0x00
+#define PCI_SUBCLASS_SERIALBUS_ACCESS 0x01
+#define PCI_SUBCLASS_SERIALBUS_SSA 0x02
+#define PCI_SUBCLASS_SERIALBUS_USB 0x03
+#define PCI_SUBCLASS_SERIALBUS_FIBER 0x04
+#define PCI_SUBCLASS_SERIALBUS_SMBUS 0x05
+#define PCI_SUBCLASS_SERIALBUS_INFINIBAND 0x06
+#define PCI_SUBCLASS_SERIALBUS_IPMI 0x07
+#define PCI_SUBCLASS_SERIALBUS_SERCOS 0x08
+#define PCI_SUBCLASS_SERIALBUS_CANBUS 0x09
+
+/* 0x0d wireless subclasses */
+#define PCI_SUBCLASS_WIRELESS_IRDA 0x00
+#define PCI_SUBCLASS_WIRELESS_CONSUMERIR 0x01
+#define PCI_SUBCLASS_WIRELESS_RF 0x10
+#define PCI_SUBCLASS_WIRELESS_MISC 0x80
+
+/* 0x0e I2O (Intelligent I/O) subclasses */
+#define PCI_SUBCLASS_I2O_STANDARD 0x00
+
+/* 0x0f satellite communication subclasses */
+/* PCI_SUBCLASS_SATCOM_??? 0x00 / * XXX ??? */
+#define PCI_SUBCLASS_SATCOM_TV 0x01
+#define PCI_SUBCLASS_SATCOM_AUDIO 0x02
+#define PCI_SUBCLASS_SATCOM_VOICE 0x03
+#define PCI_SUBCLASS_SATCOM_DATA 0x04
+
+/* 0x10 encryption/decryption subclasses */
+#define PCI_SUBCLASS_CRYPTO_NETCOMP 0x00
+#define PCI_SUBCLASS_CRYPTO_ENTERTAINMENT 0x10
+#define PCI_SUBCLASS_CRYPTO_MISC 0x80
+
+/* 0x11 data acquisition and signal processing subclasses */
+#define PCI_SUBCLASS_DASP_DPIO 0x00
+#define PCI_SUBCLASS_DASP_TIMEFREQ 0x01
+#define PCI_SUBCLASS_DASP_MISC 0x80
+
+/*
+ * PCI BIST/Header Type/Latency Timer/Cache Line Size Register.
+ */
+#define PCI_BHLC_REG 0x0c
+
+#define PCI_BIST_SHIFT 24
+#define PCI_BIST_MASK 0xff
+#define PCI_BIST(bhlcr) \
+ (((bhlcr) >> PCI_BIST_SHIFT) & PCI_BIST_MASK)
+
+#define PCI_HDRTYPE_SHIFT 16
+#define PCI_HDRTYPE_MASK 0xff
+#define PCI_HDRTYPE(bhlcr) \
+ (((bhlcr) >> PCI_HDRTYPE_SHIFT) & PCI_HDRTYPE_MASK)
+
+#define PCI_HDRTYPE_TYPE(bhlcr) \
+ (PCI_HDRTYPE(bhlcr) & 0x7f)
+#define PCI_HDRTYPE_MULTIFN(bhlcr) \
+ ((PCI_HDRTYPE(bhlcr) & 0x80) != 0)
+
+#define PCI_LATTIMER_SHIFT 8
+#define PCI_LATTIMER_MASK 0xff
+#define PCI_LATTIMER(bhlcr) \
+ (((bhlcr) >> PCI_LATTIMER_SHIFT) & PCI_LATTIMER_MASK)
+
+#define PCI_CACHELINE_SHIFT 0
+#define PCI_CACHELINE_MASK 0xff
+#define PCI_CACHELINE(bhlcr) \
+ (((bhlcr) >> PCI_CACHELINE_SHIFT) & PCI_CACHELINE_MASK)
+
+/* config registers for header type 0 devices */
+
+#define PCI_MAPS 0x10
+#define PCI_CARDBUSCIS 0x28
+#define PCI_SUBVEND_0 0x2c
+#define PCI_SUBDEV_0 0x2e
+#define PCI_INTLINE 0x3c
+#define PCI_INTPIN 0x3d
+#define PCI_MINGNT 0x3e
+#define PCI_MAXLAT 0x3f
+
+/* config registers for header type 1 devices */
+
+#define PCI_SECSTAT_1 0 /**/
+
+#define PCI_PRIBUS_1 0x18
+#define PCI_SECBUS_1 0x19
+#define PCI_SUBBUS_1 0x1a
+#define PCI_SECLAT_1 0x1b
+
+#define PCI_IOBASEL_1 0x1c
+#define PCI_IOLIMITL_1 0x1d
+#define PCI_IOBASEH_1 0x30 /**/
+#define PCI_IOLIMITH_1 0x32 /**/
+
+#define PCI_MEMBASE_1 0x20
+#define PCI_MEMLIMIT_1 0x22
+
+#define PCI_PMBASEL_1 0x24
+#define PCI_PMLIMITL_1 0x26
+#define PCI_PMBASEH_1 0 /**/
+#define PCI_PMLIMITH_1 0 /**/
+
+#define PCI_BRIDGECTL_1 0 /**/
+
+#define PCI_SUBVEND_1 0x34
+#define PCI_SUBDEV_1 0x36
+
+/* config registers for header type 2 devices */
+
+#define PCI_SECSTAT_2 0x16
+
+#define PCI_PRIBUS_2 0x18
+#define PCI_SECBUS_2 0x19
+#define PCI_SUBBUS_2 0x1a
+#define PCI_SECLAT_2 0x1b
+
+#define PCI_MEMBASE0_2 0x1c
+#define PCI_MEMLIMIT0_2 0x20
+#define PCI_MEMBASE1_2 0x24
+#define PCI_MEMLIMIT1_2 0x28
+#define PCI_IOBASE0_2 0x2c
+#define PCI_IOLIMIT0_2 0x30
+#define PCI_IOBASE1_2 0x34
+#define PCI_IOLIMIT1_2 0x38
+
+#define PCI_BRIDGECTL_2 0x3e
+
+#define PCI_SUBVEND_2 0x40
+#define PCI_SUBDEV_2 0x42
+
+#define PCI_PCCARDIF_2 0x44
+
+/*
+ * Mapping registers
+ */
+#define PCI_MAPREG_START 0x10
+#define PCI_MAPREG_END 0x28
+#define PCI_MAPREG_ROM 0x30
+#define PCI_MAPREG_PPB_END 0x18
+#define PCI_MAPREG_PCB_END 0x14
+
+#define PCI_MAPREG_TYPE(mr) \
+ ((mr) & PCI_MAPREG_TYPE_MASK)
+#define PCI_MAPREG_TYPE_MASK 0x00000001
+
+#define PCI_MAPREG_TYPE_MEM 0x00000000
+#define PCI_MAPREG_TYPE_IO 0x00000001
+#define PCI_MAPREG_TYPE_ROM 0x00000001
+
+#define PCI_MAPREG_MEM_TYPE(mr) \
+ ((mr) & PCI_MAPREG_MEM_TYPE_MASK)
+#define PCI_MAPREG_MEM_TYPE_MASK 0x00000006
+
+#define PCI_MAPREG_MEM_TYPE_32BIT 0x00000000
+#define PCI_MAPREG_MEM_TYPE_32BIT_1M 0x00000002
+#define PCI_MAPREG_MEM_TYPE_64BIT 0x00000004
+
+#define PCI_MAPREG_MEM_CACHEABLE(mr) \
+ (((mr) & PCI_MAPREG_MEM_CACHEABLE_MASK) != 0)
+#define PCI_MAPREG_MEM_CACHEABLE_MASK 0x00000008
+
+#define PCI_MAPREG_MEM_PREFETCHABLE(mr) \
+ (((mr) & PCI_MAPREG_MEM_PREFETCHABLE_MASK) != 0)
+#define PCI_MAPREG_MEM_PREFETCHABLE_MASK 0x00000008
+
+#define PCI_MAPREG_MEM_ADDR(mr) \
+ ((mr) & PCI_MAPREG_MEM_ADDR_MASK)
+#define PCI_MAPREG_MEM_SIZE(mr) \
+ (PCI_MAPREG_MEM_ADDR(mr) & -PCI_MAPREG_MEM_ADDR(mr))
+#define PCI_MAPREG_MEM_ADDR_MASK 0xfffffff0
+
+#define PCI_MAPREG_MEM64_ADDR(mr) \
+ ((mr) & PCI_MAPREG_MEM64_ADDR_MASK)
+#define PCI_MAPREG_MEM64_SIZE(mr) \
+ (PCI_MAPREG_MEM64_ADDR(mr) & -PCI_MAPREG_MEM64_ADDR(mr))
+#define PCI_MAPREG_MEM64_ADDR_MASK 0xfffffffffffffff0
+
+#define PCI_MAPREG_IO_ADDR(mr) \
+ ((mr) & PCI_MAPREG_IO_ADDR_MASK)
+#define PCI_MAPREG_IO_SIZE(mr) \
+ (PCI_MAPREG_IO_ADDR(mr) & -PCI_MAPREG_IO_ADDR(mr))
+#define PCI_MAPREG_IO_ADDR_MASK 0xfffffffe
+
+#define PCI_MAPREG_ROM_ADDR(mr) \
+ ((mr) & PCI_MAPREG_ROM_ADDR_MASK)
+#define PCI_MAPREG_ROM_SIZE(mr) \
+ (PCI_MAPREG_ROM_ADDR(mr) & -PCI_MAPREG_ROM_ADDR(mr))
+#define PCI_MAPREG_ROM_ADDR_MASK 0xfffff800
+
+/*
+ * Cardbus CIS pointer (PCI rev. 2.1)
+ */
+#define PCI_CARDBUS_CIS_REG 0x28
+
+/*
+ * Subsystem identification register; contains a vendor ID and a device ID.
+ * Types/macros for PCI_ID_REG apply.
+ * (PCI rev. 2.1)
+ */
+#define PCI_SUBSYS_ID_REG 0x2c
+
+/*
+ * capabilities link list (PCI rev. 2.2)
+ */
+#define PCI_CAPLISTPTR_REG 0x34
+#define PCI_CAPLIST_PTR(cpr) ((cpr) & 0xff)
+#define PCI_CAPLIST_NEXT(cr) (((cr) >> 8) & 0xff)
+#define PCI_CAPLIST_CAP(cr) ((cr) & 0xff)
+
+#define PCI_CAP_REESSERVED 0x00
+#define PCI_CAP_PWRMGMT 0x01
+#define PCI_CAP_AGP 0x02
+#define PCI_CAP_VPD 0x03
+#define PCI_CAP_SLOTID 0x04
+#define PCI_CAP_MBI 0x05
+#define PCI_CAP_CPCI_HOTSWAP 0x06
+#define PCI_CAP_PCIX 0x07
+#define PCI_CAP_LDT 0x08
+#define PCI_CAP_VENDSPEC 0x09
+#define PCI_CAP_DEBUGPORT 0x0a
+#define PCI_CAP_CPCI_RSRCCTL 0x0b
+#define PCI_CAP_HOTPLUG 0x0c
+
+/*
+ * Power Management Control Status Register; access via capability pointer.
+ */
+#define PCI_PMCSR_STATE_MASK 0x03
+#define PCI_PMCSR_STATE_D0 0x00
+#define PCI_PMCSR_STATE_D1 0x01
+#define PCI_PMCSR_STATE_D2 0x02
+#define PCI_PMCSR_STATE_D3 0x03
+
+/*
+ * Interrupt Configuration Register; contains interrupt pin and line.
+ */
+#define PCI_INTERRUPT_REG 0x3c
+
+typedef u_int8_t pci_intr_pin_t;
+typedef u_int8_t pci_intr_line_t;
+
+#define PCI_INTERRUPT_PIN_SHIFT 8
+#define PCI_INTERRUPT_PIN_MASK 0xff
+#define PCI_INTERRUPT_PIN(icr) \
+ (((icr) >> PCI_INTERRUPT_PIN_SHIFT) & PCI_INTERRUPT_PIN_MASK)
+
+#define PCI_INTERRUPT_LINE_SHIFT 0
+#define PCI_INTERRUPT_LINE_MASK 0xff
+#define PCI_INTERRUPT_LINE(icr) \
+ (((icr) >> PCI_INTERRUPT_LINE_SHIFT) & PCI_INTERRUPT_LINE_MASK)
+
+#define PCI_MIN_GNT_SHIFT 16
+#define PCI_MIN_GNT_MASK 0xff
+#define PCI_MIN_GNT(icr) \
+ (((icr) >> PCI_MIN_GNT_SHIFT) & PCI_MIN_GNT_MASK)
+
+#define PCI_MAX_LAT_SHIFT 24
+#define PCI_MAX_LAT_MASK 0xff
+#define PCI_MAX_LAT(icr) \
+ (((icr) >> PCI_MAX_LAT_SHIFT) & PCI_MAX_LAT_MASK)
+
+#define PCI_INTERRUPT_PIN_NONE 0x00
+#define PCI_INTERRUPT_PIN_A 0x01
+#define PCI_INTERRUPT_PIN_B 0x02
+#define PCI_INTERRUPT_PIN_C 0x03
+#define PCI_INTERRUPT_PIN_D 0x04
+#define PCI_INTERRUPT_PIN_MAX 0x04
+
+#endif /* _DEV_PCI_PCIREG_H_ */
diff --git a/arch/mips/lemote/lm2f/common/plat.c
b/arch/mips/lemote/lm2f/common/plat.c
new file mode 100644
index 0000000..507351a
--- /dev/null
+++ b/arch/mips/lemote/lm2f/common/plat.c
@@ -0,0 +1,82 @@
+
+/*
+ * This file is subject to the terms and conditions of the GNU General
Public
+ * License. See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2009 yanhua (yanhua@lemote.com)
+ * Copyright (C) 2007 Ralf Baechle (ralf@linux-mips.org)
+ */
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/serial_8250.h>
+
+#ifdef CONFIG_64BIT
+#define CPU_UART_BASE (void *)0xffffffffbff003f8
+#else
+#define CPU_UART_BASE (void *)0xbff003f8
+#endif
+
+#define PORT(base, int) \
+{ \
+ .iobase = base, \
+ .irq = int, \
+ .uartclk = 1843200, \
+ .iotype = UPIO_PORT, \
+ .flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST, \
+ .regshift = 0, \
+}
+
+static struct plat_serial8250_port uart8250_data[] = {
+#if defined(CONFIG_LEMOTE_YEELOONG2F) || defined(CONFIG_LEMOTE_NAS)
+ { .membase = CPU_UART_BASE,
+ .irq = 19,
+ .uartclk = 3686400,
+ .iotype = UPIO_MEM,
+ .flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,
+ .regshift = 0,
+ },
+#else
+ PORT(0x2F8, 3),
+#endif
+ { },
+};
+
+static struct platform_device uart8250_device = {
+ .name = "serial8250",
+ .id = PLAT8250_DEV_PLATFORM,
+ .dev = {
+ .platform_data = uart8250_data,
+ },
+};
+
+static struct resource cmos_rsrc[] = {
+ {
+ .start = 0x70,
+ .end = 0x71,
+ .flags = IORESOURCE_IO
+ },
+ {
+ .start = 8,
+ .end = 8,
+ .flags = IORESOURCE_IRQ
+ }
+};
+
+static struct platform_device cmos_device = {
+ .name = "rtc_cmos",
+ .num_resources = ARRAY_SIZE(cmos_rsrc),
+ .resource = cmos_rsrc
+};
+
+static int __init plat_init(void)
+{
+ platform_device_register(&uart8250_device);
+ platform_device_register(&cmos_device);
+
+ return 0;
+}
+
+device_initcall(plat_init);
+
+MODULE_LICENSE("GPL");
diff --git a/arch/mips/lemote/lm2f/fuloong/Makefile
b/arch/mips/lemote/lm2f/fuloong/Makefile
new file mode 100644
index 0000000..dfb021b
--- /dev/null
+++ b/arch/mips/lemote/lm2f/fuloong/Makefile
@@ -0,0 +1,7 @@
+#
+# Makefile for Lemote Loongson-2F based mini box.
+#
+
+obj-y += setup.o prom.o reset.o irq.o bonito-irq.o dbg_io.o
+
+EXTRA_AFLAGS := $(CFLAGS)
diff --git a/arch/mips/lemote/lm2f/fuloong/bonito-irq.c
b/arch/mips/lemote/lm2f/fuloong/bonito-irq.c
new file mode 100644
index 0000000..ce04b4d
--- /dev/null
+++ b/arch/mips/lemote/lm2f/fuloong/bonito-irq.c
@@ -0,0 +1,105 @@
+/*
+ * Copyright 2001 MontaVista Software Inc.
+ * Author: Jun Sun, jsun@mvista.com or jsun@junsun.net
+ * Copyright (C) 2000, 2001 Ralf Baechle (ralf@gnu.org)
+ *
+ * Copyright (C) 2007 Lemote Inc. & Insititute of Computing Technology
+ * Author: Fuxin Zhang, zhangfx@lemote.com
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
+ * NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
+ * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <asm/io.h>
+
+#include <asm/mips-boards/bonito64.h>
+
+#define bonito_irq_shutdown bonito_irq_disable
+
+
+static inline void bonito_irq_enable(unsigned int irq)
+{
+ BONITO_INTENSET = (1 << (irq - BONITO_IRQ_BASE));
+ (void)BONITO_INTENSET;
+ mmiowb();
+}
+
+static unsigned int bonito_irq_startup(unsigned int irq)
+{
+ bonito_irq_enable(irq);
+ return 0;
+}
+
+static inline void bonito_irq_ack(unsigned int irq)
+{
+ BONITO_INTENCLR = (1 << (irq - BONITO_IRQ_BASE));
+ (void)BONITO_INTENCLR;
+ mmiowb();
+}
+
+static inline void bonito_irq_end(unsigned int irq)
+{
+ BONITO_INTENSET = (1 << (irq - BONITO_IRQ_BASE ));
+ mmiowb();
+}
+
+static inline void bonito_irq_disable(unsigned int irq)
+{
+ BONITO_INTENCLR = (1 << (irq - BONITO_IRQ_BASE));
+ (void)BONITO_INTENCLR;
+ mmiowb();
+}
+
+static struct irq_chip bonito_irq_type = {
+ .name = "bonito_irq",
+ .startup = bonito_irq_startup,
+ .shutdown = bonito_irq_shutdown,
+ .enable = bonito_irq_enable,
+ .disable = bonito_irq_disable,
+ .ack = bonito_irq_ack,
+ .end = bonito_irq_end,
+ .mask = bonito_irq_disable,
+ .mask_ack = bonito_irq_disable,
+ .unmask = bonito_irq_enable,
+};
+
+/* There is no need to handle the DMA IO problem on godson2f any more. */
+/*
+static struct irqaction dma_timeout_irqaction = {
+ .handler = no_action,
+ .name = "dma_timeout",
+};
+*/
+
+void bonito_irq_init(void)
+{
+ u32 i;
+
+ for (i = BONITO_IRQ_BASE; i < BONITO_IRQ_BASE + 32; i++) {
+ set_irq_chip_and_handler(i, &bonito_irq_type, handle_level_irq);
+ }
+
+ /* setup_irq(BONITO_IRQ_BASE + 10, &dma_timeout_irqaction); */
+}
diff --git a/arch/mips/lemote/lm2f/fuloong/dbg_io.c
b/arch/mips/lemote/lm2f/fuloong/dbg_io.c
new file mode 100644
index 0000000..5900fdc
--- /dev/null
+++ b/arch/mips/lemote/lm2f/fuloong/dbg_io.c
@@ -0,0 +1,182 @@
+/*
+ * Copyright 2001 MontaVista Software Inc.
+ * Author: Jun Sun, jsun@mvista.com or jsun@junsun.net
+ * Copyright (C) 2000, 2001 Ralf Baechle (ralf@gnu.org)
+ *
+ * Copyright (C) 2007 Lemote Inc. & Insititute of Computing Technology
+ * Author: Fuxin Zhang, zhangfx@lemote.com
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
+ * NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
+ * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+
+#include <linux/io.h>
+#include <asm/types.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <asm/serial.h> /* For the serial port location and base baud */
+
+#define UART16550_BAUD_2400 2400
+#define UART16550_BAUD_4800 4800
+#define UART16550_BAUD_9600 9600
+#define UART16550_BAUD_19200 19200
+#define UART16550_BAUD_38400 38400
+#define UART16550_BAUD_57600 57600
+#define UART16550_BAUD_115200 115200
+
+#define UART16550_PARITY_NONE 0
+#define UART16550_PARITY_ODD 0x08
+#define UART16550_PARITY_EVEN 0x18
+#define UART16550_PARITY_MARK 0x28
+#define UART16550_PARITY_SPACE 0x38
+
+#define UART16550_DATA_5BIT 0x0
+#define UART16550_DATA_6BIT 0x1
+#define UART16550_DATA_7BIT 0x2
+#define UART16550_DATA_8BIT 0x3
+
+#define UART16550_STOP_1BIT 0x0
+#define UART16550_STOP_2BIT 0x4
+
+/* ----------------------------------------------------- */
+
+#ifdef USE_GODSON2F_UART
+
+/* === CONFIG === */
+#ifdef CONFIG_64BIT
+#define BASE (0xffffffffbff003f8)
+#else
+#define BASE (0xbff003f8)
+#endif
+
+#else /* USE_CS5536_UART1/2 */
+
+#ifdef CONFIG_64BIT
+#define BASE 0xffffffffbfd002f8
+#else
+#define BASE 0xbfd002f8
+#endif
+
+#endif /* end of USE_GODSON2F_UART */
+
+#define MAX_BAUD BASE_BAUD
+/* === END OF CONFIG === */
+
+#define REG_OFFSET 1
+
+/* register offset */
+#define OFS_RCV_BUFFER 0
+#define OFS_TRANS_HOLD 0
+#define OFS_SEND_BUFFER 0
+#define OFS_INTR_ENABLE (1*REG_OFFSET)
+#define OFS_INTR_ID (2*REG_OFFSET)
+#define OFS_DATA_FORMAT (3*REG_OFFSET)
+#define OFS_LINE_CONTROL (3*REG_OFFSET)
+#define OFS_MODEM_CONTROL (4*REG_OFFSET)
+#define OFS_RS232_OUTPUT (4*REG_OFFSET)
+#define OFS_LINE_STATUS (5*REG_OFFSET)
+#define OFS_MODEM_STATUS (6*REG_OFFSET)
+#define OFS_RS232_INPUT (6*REG_OFFSET)
+#define OFS_SCRATCH_PAD (7*REG_OFFSET)
+
+#define OFS_DIVISOR_LSB (0*REG_OFFSET)
+#define OFS_DIVISOR_MSB (1*REG_OFFSET)
+
+/* memory-mapped read/write of the port */
+#define UART16550_READ(y) (*((volatile u8*)(BASE + y)))
+#define UART16550_WRITE(y, z) ((*((volatile u8*)(BASE + y))) = z)
+
+void debugInit(u32 baud, u8 data, u8 parity, u8 stop)
+{
+ /* disable interrupts */
+ UART16550_WRITE(OFS_INTR_ENABLE, 0);
+
+ /* set up buad rate */
+ {
+ u32 divisor;
+
+ /* set DIAB bit */
+ UART16550_WRITE(OFS_LINE_CONTROL, 0x80);
+
+ /* set divisor */
+ divisor = MAX_BAUD / baud;
+ UART16550_WRITE(OFS_DIVISOR_LSB, divisor & 0xff);
+ UART16550_WRITE(OFS_DIVISOR_MSB, (divisor & 0xff00) >> 8);
+
+ /* clear DIAB bit */
+ UART16550_WRITE(OFS_LINE_CONTROL, 0x0);
+ }
+
+ /* set data format */
+ UART16550_WRITE(OFS_DATA_FORMAT, data | parity | stop);
+}
+
+static int remoteDebugInitialized = 0;
+
+u8 getDebugChar(void)
+{
+ if (!remoteDebugInitialized) {
+ remoteDebugInitialized = 1;
+ debugInit(UART16550_BAUD_115200,
+ UART16550_DATA_8BIT,
+ UART16550_PARITY_NONE, UART16550_STOP_1BIT);
+ }
+
+ while ((UART16550_READ(OFS_LINE_STATUS) & 0x1) == 0) ;
+ return UART16550_READ(OFS_RCV_BUFFER);
+}
+
+int putDebugChar(u8 byte)
+{
+ if (!remoteDebugInitialized) {
+ remoteDebugInitialized = 1;
+ /*
+ debugInit(UART16550_BAUD_115200,
+ UART16550_DATA_8BIT,
+ UART16550_PARITY_NONE, UART16550_STOP_1BIT); */
+ }
+
+ while ((UART16550_READ(OFS_LINE_STATUS) & 0x20) == 0) ;
+ UART16550_WRITE(OFS_SEND_BUFFER, byte);
+ return 1;
+}
+
+extern void prom_putchar(char c);
+
+void prom_printf(char *fmt, ...)
+{
+ va_list args;
+ char ppbuf[1024];
+ char *bptr;
+
+ va_start(args, fmt);
+ vsprintf(ppbuf, fmt, args);
+
+ bptr = ppbuf;
+
+ while (*bptr != 0) {
+ if (*bptr == '\n')
+ prom_putchar('\r');
+
+ prom_putchar(*bptr++);
+ }
+ va_end(args);
+}
diff --git a/arch/mips/lemote/lm2f/fuloong/irq.c
b/arch/mips/lemote/lm2f/fuloong/irq.c
new file mode 100644
index 0000000..622c7b0
--- /dev/null
+++ b/arch/mips/lemote/lm2f/fuloong/irq.c
@@ -0,0 +1,234 @@
+/*
+ * Copyright (C) 2007 Lemote Inc. & Insititute of Computing Technology
+ * Author: Fuxin Zhang, zhangfx@lemote.com
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
+ * NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
+ * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/irq_cpu.h>
+#include <asm/i8259.h>
+#include <asm/mipsregs.h>
+#include <asm/delay.h>
+#include <asm/mips-boards/bonito64.h>
+
+#define BONITO_INT_BIT_GPIO0 (1 << 0)
+#define BONITO_INT_BIT_GPIO1 (1 << 1)
+#define BONITO_INT_BIT_GPIO2 (1 << 2)
+#define BONITO_INT_BIT_GPIO3 (1 << 3)
+#define BONITO_INT_BIT_PCI_INTA (1 << 4)
+#define BONITO_INT_BIT_PCI_INTB (1 << 5)
+#define BONITO_INT_BIT_PCI_INTC (1 << 6)
+#define BONITO_INT_BIT_PCI_INTD (1 << 7)
+#define BONITO_INT_BIT_PCI_PERR (1 << 8)
+#define BONITO_INT_BIT_PCI_SERR (1 << 9)
+#define BONITO_INT_BIT_DDR (1 << 10)
+#define BONITO_INT_BIT_INT0 (1 << 11)
+#define BONITO_INT_BIT_INT1 (1 << 12)
+#define BONITO_INT_BIT_INT2 (1 << 13)
+#define BONITO_INT_BIT_INT3 (1 << 14)
+
+#define BONITO_INT_TIMER_OFF 7
+#define BONITO_INT_BONITO_OFF 6
+#define BONITO_INT_UART_OFF 3
+#define BONITO_INT_I8259_OFF 2
+
+/****************************************************************/
+
+static void loongson2f_timer_dispatch(void)
+{
+ /* place the loongson2f timer interrupt on 23 */
+ do_IRQ(MIPS_CPU_IRQ_BASE + BONITO_INT_TIMER_OFF);
+ return;
+}
+
+static void loongson2f_bonito_dispatch(void)
+{
+ int int_status;
+ int i = 0;
+
+ /* place the other interrupt on bit6 for bonito, inclding PCI and so on */
+ int_status = BONITO_INTISR & BONITO_INTEN;
+
+ for(i = 0; (i < 10) && int_status; i++){
+ if(int_status & (1 << i)){
+ if(i == 10)
+ printk("ddr int.\n");
+ if(int_status & 0x000000f0)
+ do_IRQ(BONITO_IRQ_BASE + i);
+ int_status &= ~(1 << i);
+ }
+ }
+
+ return;
+}
+
+static void loongson2f_int3_dispatch(void)
+{
+ int int_status;
+
+ int_status = BONITO_INTISR & BONITO_INTEN;
+ if(int_status & BONITO_INT_BIT_INT3){
+ }
+
+ return;
+}
+
+static void loongson2f_int2_dispatch(void)
+{
+ int int_status;
+
+ int_status = BONITO_INTISR & BONITO_INTEN;
+ if(int_status & BONITO_INT_BIT_INT2){
+ }
+
+ return;
+}
+
+static void loongson2f_int1_dispatch(void)
+{
+ /* place the loongson2f uart interrupt on int1 */
+ do_IRQ(MIPS_CPU_IRQ_BASE + BONITO_INT_UART_OFF);
+}
+
+static void i8259_irqdispatch(void)
+{
+ int irq, isr, imr;
+
+ if((BONITO_INTISR & BONITO_INTEN) & BONITO_INT_BIT_INT0) {
+
+ imr = inb(0x21) | (inb(0xa1) << 8);
+ isr = inb(0x20) | (inb(0xa0) << 8);
+ isr &= ~0x4; // irq2 for cascade
+ isr &= ~imr;
+ irq = ffs(isr) - 1;
+
+ if(irq >= 0) {
+ do_IRQ(irq);
+ } else {
+ spurious_interrupt();
+ }
+ }
+}
+
+static void loongson2f_steer1_dispatch(void)
+{
+ return;
+}
+
+static void loongson2f_steer0_dispatch(void)
+{
+ return;
+}
+
+
+asmlinkage void plat_irq_dispatch(void)
+{
+ unsigned int pending = read_c0_cause() & read_c0_status() & ST0_IM;
+
+ if(pending & CAUSEF_IP7){
+ loongson2f_timer_dispatch();
+ }else if(pending & CAUSEF_IP6){ /* North Bridge, Performance counter */
+ do_IRQ(MIPS_CPU_IRQ_BASE + 6);
+ loongson2f_bonito_dispatch();
+ }else if(pending & CAUSEF_IP5){
+ loongson2f_int3_dispatch();
+ }else if(pending & CAUSEF_IP4){
+ loongson2f_int2_dispatch();
+ }else if(pending & CAUSEF_IP3){ /* CPU UART */
+ loongson2f_int1_dispatch();
+ }else if(pending & CAUSEF_IP2){ /* South Bridge */
+ i8259_irqdispatch();
+ }else if(pending & CAUSEF_IP1){
+ loongson2f_steer1_dispatch();
+ }else if(pending & CAUSEF_IP0){
+ loongson2f_steer0_dispatch();
+ }else{
+ spurious_interrupt();
+ }
+ return;
+}
+
+static struct irqaction cascade_irqaction = {
+ .handler = no_action,
+ .mask = CPU_MASK_NONE,
+ .name = "cascade",
+};
+
+irqreturn_t ip6_action(int cpl, void *dev_id, struct pt_regs *regs)
+{
+ return IRQ_HANDLED;
+}
+
+static struct irqaction ip6_irqaction = {
+ .handler = ip6_action,
+ .mask = CPU_MASK_NONE,
+ .name = "cascade",
+ .flags = IRQF_SHARED,
+};
+
+void __init arch_init_irq(void)
+{
+ extern void bonito_irq_init(void);
+
+ /*
+ * Clear all of the interrupts while we change the able around a bit.
+ * int-handler is not on bootstrap
+ */
+ clear_c0_status(ST0_IM | ST0_BEV);
+ local_irq_disable();
+
+ /* setup cs5536 as high level */
+ BONITO_INTPOL = (1 << 11 | 1 << 12);
+ BONITO_INTEDGE &= ~(1 << 11 | 1 << 12);
+
+ /* no steer */
+ BONITO_INTSTEER = 0;
+
+ /*
+ * Mask out all interrupt by writing "1" to all bit position in
+ * the interrupt reset reg.
+ */
+ BONITO_INTENCLR = ~0;
+
+ /* init all controller
+ * 0-15 ------> i8259 interrupt
+ * 16-23 ------> mips cpu interrupt
+ * 32-63 ------> bonito irq
+ */
+
+ /* Sets the first-level interrupt dispatcher. */
+ mips_cpu_irq_init();
+
+ init_i8259_irqs();
+ bonito_irq_init();
+
+ /* setup bonito interrupt */
+ setup_irq(MIPS_CPU_IRQ_BASE + BONITO_INT_BONITO_OFF, &ip6_irqaction);
+ /* 8259 irq at IP2 */
+ setup_irq(MIPS_CPU_IRQ_BASE + BONITO_INT_I8259_OFF, &cascade_irqaction);
+
+}
diff --git a/arch/mips/lemote/lm2f/fuloong/prom.c
b/arch/mips/lemote/lm2f/fuloong/prom.c
new file mode 100644
index 0000000..d40a929
--- /dev/null
+++ b/arch/mips/lemote/lm2f/fuloong/prom.c
@@ -0,0 +1,106 @@
+/*
+ * Based on Ocelot Linux port, which is
+ * Copyright 2001 MontaVista Software Inc.
+ * Author: jsun@mvista.com or jsun@junsun.net
+ *
+ * Copyright 2003 ICT CAS
+ * Author: Michael Guo <guoyi@ict.ac.cn>
+ *
+ * Copyright (C) 2007 Lemote Inc. & Insititute of Computing Technology
+ * Author: Fuxin Zhang, zhangfx@lemote.com
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ */
+#include <linux/init.h>
+#include <linux/mm.h>
+#include <linux/sched.h>
+#include <linux/bootmem.h>
+
+#include <asm/addrspace.h>
+#include <asm/bootinfo.h>
+
+extern unsigned long bus_clock;
+extern unsigned long cpu_clock_freq;
+extern unsigned int memsize, highmemsize;
+extern int putDebugChar(unsigned char byte);
+
+static int argc;
+/* pmon passes arguments in 32bit pointers */
+static int *arg;
+static int *env;
+
+const char *get_system_type(void)
+{
+ return "lemote-fuloong(2F)";
+}
+
+void __init prom_init_cmdline(void)
+{
+ int i;
+ long l;
+
+ /* arg[0] is "g", the rest is boot parameters */
+ arcs_cmdline[0] = '\0';
+ for (i = 1; i < argc; i++) {
+ l = (long)arg[i];
+ if (strlen(arcs_cmdline) + strlen(((char *)l) + 1)
+ >= sizeof(arcs_cmdline))
+ break;
+ strcat(arcs_cmdline, ((char *)l));
+ strcat(arcs_cmdline, " ");
+ }
+}
+
+void __init prom_init(void)
+{
+ long l;
+ argc = fw_arg0;
+ arg = (int *)fw_arg1;
+ env = (int *)fw_arg2;
+
+ prom_init_cmdline();
+
+ if ((strstr(arcs_cmdline, "console=")) == NULL)
+ strcat(arcs_cmdline, " console=ttyS0,115200");
+ if ((strstr(arcs_cmdline, "root=")) == NULL)
+ strcat(arcs_cmdline, " root=/dev/hda1");
+
+ l = (long)*env;
+ while (l != 0) {
+ if (strncmp("busclock", (char *)l, strlen("busclock")) == 0) {
+ bus_clock = simple_strtol((char *)l + strlen("busclock="),
+ NULL, 10);
+ }
+ if (strncmp("cpuclock", (char *)l, strlen("cpuclock")) == 0) {
+ cpu_clock_freq = simple_strtol((char *)l + strlen("cpuclock="),
+ NULL, 10);
+ }
+ if (strncmp("memsize", (char *)l, strlen("memsize")) == 0) {
+ memsize = simple_strtol((char *)l + strlen("memsize="),
+ NULL, 10);
+ }
+ if (strncmp("highmemsize", (char *)l, strlen("highmemsize")) == 0) {
+ highmemsize = simple_strtol((char *)l + strlen("highmemsize="),
+ NULL, 10);
+ }
+ env++;
+ l = (long)*env;
+ }
+ if (memsize == 0)
+ memsize = 256;
+
+ printk("busclock=%ld, cpuclock=%ld,memsize=%d,highmemsize=%d\n",
+ bus_clock, cpu_clock_freq, memsize, highmemsize);
+}
+
+void __init prom_free_prom_memory(void)
+{
+}
+
+void prom_putchar(char c)
+{
+ putDebugChar(c);
+}
diff --git a/arch/mips/lemote/lm2f/fuloong/reset.c
b/arch/mips/lemote/lm2f/fuloong/reset.c
new file mode 100644
index 0000000..64dfe84
--- /dev/null
+++ b/arch/mips/lemote/lm2f/fuloong/reset.c
@@ -0,0 +1,87 @@
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * Copyright (C) 2007 Lemote, Inc. & Institute of Computing Technology
+ * Author: Fuxin Zhang, zhangfx@lemote.com
+ */
+
+#include <asm/io.h>
+#include <asm/pgtable.h>
+#include <asm/processor.h>
+#include <asm/reboot.h>
+#include <asm/system.h>
+
+#include <linux/sched.h>
+#include <linux/mm.h>
+#include <linux/pm.h>
+#include <linux/delay.h>
+
+extern void _wrmsr(u32 reg, u32 hi, u32 lo);
+extern void _rdmsr(u32 reg, u32 *hi, u32 *lo);
+
+static void loongson2f_restart(char *command)
+{
+ u32 hi, lo;
+
+#ifdef CONFIG_32BIT
+ *(volatile u32*)0xbfe00180 |= 0x7;
+#else
+ *(volatile u32*)0xffffffffbfe00180 |= 0x7;
+#endif
+ _rdmsr(0xe0000014, &hi, &lo);
+ lo |= 0x00000001;
+ _wrmsr(0xe0000014, hi, lo);
+
+ printk("Hard reset not take effect!!\n");
+ __asm__ __volatile__ (
+ ".long 0x3c02bfc0\n"
+ ".long 0x00400008\n"
+ :::"v0"
+ );
+}
+
+
+static void delay(void)
+{
+ volatile int i;
+ for (i=0; i<0x10000; i++);
+}
+static void loongson2f_halt(void)
+{
+#ifdef CONFIG_32BIT
+ u32 base;
+#else
+ u64 base;
+#endif
+ u32 hi, lo, val;
+
+ _rdmsr(0x8000000c, &hi, &lo);
+#ifdef CONFIG_32BIT
+ base = (lo & 0xff00) | 0xbfd00000;
+#else
+ base = (lo & 0xff00) | 0xffffffffbfd00000ULL;
+#endif
+ val = (val & ~(1 << (16 + 13))) | (1 << 13);
+ delay();
+ *(__volatile__ u32 *)(base + 0x04) = val;
+ delay();
+ val = (val & ~(1 << (13))) | (1 << (16 + 13));
+ delay();
+ *(__volatile__ u32 *)(base + 0x00) = val;
+ delay();
+}
+
+static void loongson2f_power_off(void)
+{
+ loongson2f_halt();
+}
+
+void mips_reboot_setup(void)
+{
+ _machine_restart = loongson2f_restart;
+ _machine_halt = loongson2f_halt;
+ pm_power_off = loongson2f_power_off;
+}
diff --git a/arch/mips/lemote/lm2f/fuloong/setup.c
b/arch/mips/lemote/lm2f/fuloong/setup.c
new file mode 100644
index 0000000..e0c393e
--- /dev/null
+++ b/arch/mips/lemote/lm2f/fuloong/setup.c
@@ -0,0 +1,132 @@
+/*
+ * BRIEF MODULE DESCRIPTION
+ * setup.c - board dependent boot routines
+ *
+ * Copyright (C) 2007 Lemote Inc. & Insititute of Computing Technology
+ * Author: Fuxin Zhang, zhangfx@lemote.com
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
+ * NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
+ * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+#include <linux/bootmem.h>
+#include <linux/init.h>
+#include <linux/irq.h>
+
+#include <asm/bootinfo.h>
+#include <asm/mc146818-time.h>
+#include <asm/time.h>
+#include <asm/wbflush.h>
+
+#ifdef CONFIG_VT
+#include <linux/console.h>
+#include <linux/screen_info.h>
+#endif
+
+extern void mips_reboot_setup(void);
+
+#ifdef CONFIG_64BIT
+#define PTR_PAD(p) ((0xffffffff00000000)|((unsigned long long)(p)))
+#else
+#define PTR_PAD(p) (p)
+#endif
+
+unsigned long cpu_clock_freq;
+unsigned long bus_clock;
+unsigned int memsize;
+unsigned int highmemsize = 0;
+
+extern int __init init_mfgpt_clocksource(void);
+
+void __init plat_time_init(void)
+{
+ /* setup mips r4k timer */
+ mips_hpt_frequency = cpu_clock_freq / 2;
+
+#ifdef CONFIG_LS2F_CPU_FREQ
+ init_mfgpt_clocksource();
+#endif
+}
+
+unsigned long read_persistent_clock(void)
+{
+ return mc146818_get_cmos_time();
+}
+
+void (*__wbflush)(void);
+EXPORT_SYMBOL(__wbflush);
+
+static void wbflush_loongson2f(void)
+{
+ asm(".set\tpush\n\t"
+ ".set\tnoreorder\n\t"
+ ".set mips3\n\t"
+ "sync\n\t"
+ "nop\n\t"
+ ".set\tpop\n\t"
+ ".set mips0\n\t");
+}
+
+void __init plat_mem_setup(void)
+{
+ set_io_port_base(PTR_PAD(0xbfd00000));
+
+ mips_reboot_setup();
+
+ __wbflush = wbflush_loongson2f;
+
+ add_memory_region(0x0, (memsize << 20), BOOT_MEM_RAM);
+#ifdef CONFIG_64BIT
+ __asm__(
+ ".set mips3\n"
+ "dli $2, 0x900000003ff00000\n"
+ "dli $3, 0x0000000080000000\n"
+ "sd $3, 0x10($2)\n"
+ "sd $0, 0x50($2)\n"
+ "dli $3, 0xffffffff80000000\n"
+ "sd $3, 0x30($2)\n"
+ ".set mips0\n"
+ :::"$2","$3","memory");
+ if (highmemsize > 0) {
+ add_memory_region(0x90000000, highmemsize << 20, BOOT_MEM_RAM);
+ }
+#endif
+
+#ifdef CONFIG_VT
+#if defined(CONFIG_VGA_CONSOLE)
+ conswitchp = &vga_con;
+
+ screen_info = (struct screen_info) {
+ 0, 25, /* orig-x, orig-y */
+ 0, /* unused */
+ 0, /* orig-video-page */
+ 0, /* orig-video-mode */
+ 80, /* orig-video-cols */
+ 0, 0, 0, /* ega_ax, ega_bx, ega_cx */
+ 25, /* orig-video-lines */
+ VIDEO_TYPE_VGAC, /* orig-video-isVGA */
+ 16 /* orig-video-points */
+ };
+#elif defined(CONFIG_DUMMY_CONSOLE)
+ conswitchp = &dummy_con;
+#endif
+#endif
+
+}
diff --git a/arch/mips/lemote/lm2f/yeeloong/Makefile
b/arch/mips/lemote/lm2f/yeeloong/Makefile
new file mode 100644
index 0000000..92a19c3
--- /dev/null
+++ b/arch/mips/lemote/lm2f/yeeloong/Makefile
@@ -0,0 +1,7 @@
+#
+# Makefile for Lemote Loongson-2F mini notebook
+#
+
+obj-y += setup.o prom.o reset.o irq.o bonito-irq.o dbg_io.o
+
+EXTRA_AFLAGS := $(CFLAGS)
diff --git a/arch/mips/lemote/lm2f/yeeloong/bonito-irq.c
b/arch/mips/lemote/lm2f/yeeloong/bonito-irq.c
new file mode 100644
index 0000000..65e5659
--- /dev/null
+++ b/arch/mips/lemote/lm2f/yeeloong/bonito-irq.c
@@ -0,0 +1,104 @@
+/*
+ * Copyright 2001 MontaVista Software Inc.
+ * Author: Jun Sun, jsun@mvista.com or jsun@junsun.net
+ * Copyright (C) 2000, 2001 Ralf Baechle (ralf@gnu.org)
+ *
+ * Copyright (C) 2007 Lemote Inc. & Insititute of Computing Technology
+ * Author: Fuxin Zhang, zhangfx@lemote.com
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
+ * NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
+ * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <asm/io.h>
+
+#include <asm/mips-boards/bonito64.h>
+
+#define bonito_irq_shutdown bonito_irq_disable
+
+
+static inline void bonito_irq_enable(unsigned int irq)
+{
+ BONITO_INTENSET = (1 << (irq - BONITO_IRQ_BASE));
+ (void)BONITO_INTENSET;
+ mmiowb();
+}
+
+static unsigned int bonito_irq_startup(unsigned int irq)
+{
+ bonito_irq_enable(irq);
+ return 0;
+}
+
+static inline void bonito_irq_ack(unsigned int irq)
+{
+ BONITO_INTENCLR = (1 << (irq - BONITO_IRQ_BASE));
+ (void)BONITO_INTENCLR;
+ mmiowb();
+}
+
+static inline void bonito_irq_end(unsigned int irq)
+{
+ BONITO_INTENSET = (1 << (irq - BONITO_IRQ_BASE ));
+ mmiowb();
+}
+
+static inline void bonito_irq_disable(unsigned int irq)
+{
+ BONITO_INTENCLR = (1 << (irq - BONITO_IRQ_BASE));
+ (void)BONITO_INTENCLR;
+ mmiowb();
+}
+
+static struct irq_chip bonito_irq_type = {
+ .name = "bonito_irq",
+ .startup = bonito_irq_startup,
+ .shutdown = bonito_irq_shutdown,
+ .enable = bonito_irq_enable,
+ .disable = bonito_irq_disable,
+ .ack = bonito_irq_ack,
+ .end = bonito_irq_end,
+ .mask = bonito_irq_disable,
+ .mask_ack = bonito_irq_disable,
+ .unmask = bonito_irq_enable,
+};
+
+/* There is no need to handle the DMA IO problem on godson2f any more. */
+/*
+static struct irqaction dma_timeout_irqaction = {
+ .handler = no_action,
+ .name = "dma_timeout",
+};
+*/
+
+void bonito_irq_init(void)
+{
+ u32 i;
+
+ for (i = BONITO_IRQ_BASE; i < BONITO_IRQ_BASE + 32; i++) {
+ set_irq_chip_and_handler(i, &bonito_irq_type, handle_level_irq);
+ }
+
+}
diff --git a/arch/mips/lemote/lm2f/yeeloong/dbg_io.c
b/arch/mips/lemote/lm2f/yeeloong/dbg_io.c
new file mode 100644
index 0000000..be80ca0
--- /dev/null
+++ b/arch/mips/lemote/lm2f/yeeloong/dbg_io.c
@@ -0,0 +1,170 @@
+/*
+ * Copyright 2001 MontaVista Software Inc.
+ * Author: Jun Sun, jsun@mvista.com or jsun@junsun.net
+ * Copyright (C) 2000, 2001 Ralf Baechle (ralf@gnu.org)
+ *
+ * Copyright (C) 2007 Lemote Inc. & Insititute of Computing Technology
+ * Author: Fuxin Zhang, zhangfx@lemote.com
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
+ * NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
+ * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+
+#include <linux/io.h>
+#include <asm/types.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <asm/serial.h> /* For the serial port location and base baud */
+
+#define UART16550_BAUD_2400 2400
+#define UART16550_BAUD_4800 4800
+#define UART16550_BAUD_9600 9600
+#define UART16550_BAUD_19200 19200
+#define UART16550_BAUD_38400 38400
+#define UART16550_BAUD_57600 57600
+#define UART16550_BAUD_115200 115200
+
+#define UART16550_PARITY_NONE 0
+#define UART16550_PARITY_ODD 0x08
+#define UART16550_PARITY_EVEN 0x18
+#define UART16550_PARITY_MARK 0x28
+#define UART16550_PARITY_SPACE 0x38
+
+#define UART16550_DATA_5BIT 0x0
+#define UART16550_DATA_6BIT 0x1
+#define UART16550_DATA_7BIT 0x2
+#define UART16550_DATA_8BIT 0x3
+
+#define UART16550_STOP_1BIT 0x0
+#define UART16550_STOP_2BIT 0x4
+
+/* ----------------------------------------------------- */
+
+/* === CONFIG === */
+#ifdef CONFIG_64BIT
+#define BASE (0xffffffffbff003f8)
+#else
+#define BASE (0xbff003f8)
+#endif
+
+#define MAX_BAUD BASE_BAUD
+/* === END OF CONFIG === */
+
+#define REG_OFFSET 1
+
+/* register offset */
+#define OFS_RCV_BUFFER 0
+#define OFS_TRANS_HOLD 0
+#define OFS_SEND_BUFFER 0
+#define OFS_INTR_ENABLE (1*REG_OFFSET)
+#define OFS_INTR_ID (2*REG_OFFSET)
+#define OFS_DATA_FORMAT (3*REG_OFFSET)
+#define OFS_LINE_CONTROL (3*REG_OFFSET)
+#define OFS_MODEM_CONTROL (4*REG_OFFSET)
+#define OFS_RS232_OUTPUT (4*REG_OFFSET)
+#define OFS_LINE_STATUS (5*REG_OFFSET)
+#define OFS_MODEM_STATUS (6*REG_OFFSET)
+#define OFS_RS232_INPUT (6*REG_OFFSET)
+#define OFS_SCRATCH_PAD (7*REG_OFFSET)
+
+#define OFS_DIVISOR_LSB (0*REG_OFFSET)
+#define OFS_DIVISOR_MSB (1*REG_OFFSET)
+
+/* memory-mapped read/write of the port */
+#define UART16550_READ(y) (*((volatile u8*)(BASE + y)))
+#define UART16550_WRITE(y, z) ((*((volatile u8*)(BASE + y))) = z)
+
+void debugInit(u32 baud, u8 data, u8 parity, u8 stop)
+{
+ /* disable interrupts */
+ UART16550_WRITE(OFS_INTR_ENABLE, 0);
+
+ /* set up buad rate */
+ {
+ u32 divisor;
+
+ /* set DIAB bit */
+ UART16550_WRITE(OFS_LINE_CONTROL, 0x80);
+
+ /* set divisor */
+ divisor = MAX_BAUD / baud;
+ UART16550_WRITE(OFS_DIVISOR_LSB, divisor & 0xff);
+ UART16550_WRITE(OFS_DIVISOR_MSB, (divisor & 0xff00) >> 8);
+
+ /* clear DIAB bit */
+ UART16550_WRITE(OFS_LINE_CONTROL, 0x0);
+ }
+
+ /* set data format */
+ UART16550_WRITE(OFS_DATA_FORMAT, data | parity | stop);
+}
+
+static int remoteDebugInitialized = 0;
+
+u8 getDebugChar(void)
+{
+ if (!remoteDebugInitialized) {
+ remoteDebugInitialized = 1;
+ debugInit(UART16550_BAUD_115200,
+ UART16550_DATA_8BIT,
+ UART16550_PARITY_NONE, UART16550_STOP_1BIT);
+ }
+
+ while ((UART16550_READ(OFS_LINE_STATUS) & 0x1) == 0) ;
+ return UART16550_READ(OFS_RCV_BUFFER);
+}
+
+int putDebugChar(u8 byte)
+{
+ if (!remoteDebugInitialized) {
+ remoteDebugInitialized = 1;
+ /*
+ debugInit(UART16550_BAUD_115200,
+ UART16550_DATA_8BIT,
+ UART16550_PARITY_NONE, UART16550_STOP_1BIT); */
+ }
+
+ while ((UART16550_READ(OFS_LINE_STATUS) & 0x20) == 0) ;
+ UART16550_WRITE(OFS_SEND_BUFFER, byte);
+ return 1;
+}
+
+extern void prom_putchar(char c);
+
+void prom_printf(char *fmt, ...)
+{
+ va_list args;
+ char ppbuf[1024];
+ char *bptr;
+
+ va_start(args, fmt);
+ vsprintf(ppbuf, fmt, args);
+
+ bptr = ppbuf;
+
+ while (*bptr != 0) {
+ if (*bptr == '\n')
+ prom_putchar('\r');
+
+ prom_putchar(*bptr++);
+ }
+ va_end(args);
+}
diff --git a/arch/mips/lemote/lm2f/yeeloong/irq.c
b/arch/mips/lemote/lm2f/yeeloong/irq.c
new file mode 100644
index 0000000..622c7b0
--- /dev/null
+++ b/arch/mips/lemote/lm2f/yeeloong/irq.c
@@ -0,0 +1,234 @@
+/*
+ * Copyright (C) 2007 Lemote Inc. & Insititute of Computing Technology
+ * Author: Fuxin Zhang, zhangfx@lemote.com
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
+ * NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
+ * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/irq_cpu.h>
+#include <asm/i8259.h>
+#include <asm/mipsregs.h>
+#include <asm/delay.h>
+#include <asm/mips-boards/bonito64.h>
+
+#define BONITO_INT_BIT_GPIO0 (1 << 0)
+#define BONITO_INT_BIT_GPIO1 (1 << 1)
+#define BONITO_INT_BIT_GPIO2 (1 << 2)
+#define BONITO_INT_BIT_GPIO3 (1 << 3)
+#define BONITO_INT_BIT_PCI_INTA (1 << 4)
+#define BONITO_INT_BIT_PCI_INTB (1 << 5)
+#define BONITO_INT_BIT_PCI_INTC (1 << 6)
+#define BONITO_INT_BIT_PCI_INTD (1 << 7)
+#define BONITO_INT_BIT_PCI_PERR (1 << 8)
+#define BONITO_INT_BIT_PCI_SERR (1 << 9)
+#define BONITO_INT_BIT_DDR (1 << 10)
+#define BONITO_INT_BIT_INT0 (1 << 11)
+#define BONITO_INT_BIT_INT1 (1 << 12)
+#define BONITO_INT_BIT_INT2 (1 << 13)
+#define BONITO_INT_BIT_INT3 (1 << 14)
+
+#define BONITO_INT_TIMER_OFF 7
+#define BONITO_INT_BONITO_OFF 6
+#define BONITO_INT_UART_OFF 3
+#define BONITO_INT_I8259_OFF 2
+
+/****************************************************************/
+
+static void loongson2f_timer_dispatch(void)
+{
+ /* place the loongson2f timer interrupt on 23 */
+ do_IRQ(MIPS_CPU_IRQ_BASE + BONITO_INT_TIMER_OFF);
+ return;
+}
+
+static void loongson2f_bonito_dispatch(void)
+{
+ int int_status;
+ int i = 0;
+
+ /* place the other interrupt on bit6 for bonito, inclding PCI and so on */
+ int_status = BONITO_INTISR & BONITO_INTEN;
+
+ for(i = 0; (i < 10) && int_status; i++){
+ if(int_status & (1 << i)){
+ if(i == 10)
+ printk("ddr int.\n");
+ if(int_status & 0x000000f0)
+ do_IRQ(BONITO_IRQ_BASE + i);
+ int_status &= ~(1 << i);
+ }
+ }
+
+ return;
+}
+
+static void loongson2f_int3_dispatch(void)
+{
+ int int_status;
+
+ int_status = BONITO_INTISR & BONITO_INTEN;
+ if(int_status & BONITO_INT_BIT_INT3){
+ }
+
+ return;
+}
+
+static void loongson2f_int2_dispatch(void)
+{
+ int int_status;
+
+ int_status = BONITO_INTISR & BONITO_INTEN;
+ if(int_status & BONITO_INT_BIT_INT2){
+ }
+
+ return;
+}
+
+static void loongson2f_int1_dispatch(void)
+{
+ /* place the loongson2f uart interrupt on int1 */
+ do_IRQ(MIPS_CPU_IRQ_BASE + BONITO_INT_UART_OFF);
+}
+
+static void i8259_irqdispatch(void)
+{
+ int irq, isr, imr;
+
+ if((BONITO_INTISR & BONITO_INTEN) & BONITO_INT_BIT_INT0) {
+
+ imr = inb(0x21) | (inb(0xa1) << 8);
+ isr = inb(0x20) | (inb(0xa0) << 8);
+ isr &= ~0x4; // irq2 for cascade
+ isr &= ~imr;
+ irq = ffs(isr) - 1;
+
+ if(irq >= 0) {
+ do_IRQ(irq);
+ } else {
+ spurious_interrupt();
+ }
+ }
+}
+
+static void loongson2f_steer1_dispatch(void)
+{
+ return;
+}
+
+static void loongson2f_steer0_dispatch(void)
+{
+ return;
+}
+
+
+asmlinkage void plat_irq_dispatch(void)
+{
+ unsigned int pending = read_c0_cause() & read_c0_status() & ST0_IM;
+
+ if(pending & CAUSEF_IP7){
+ loongson2f_timer_dispatch();
+ }else if(pending & CAUSEF_IP6){ /* North Bridge, Performance counter */
+ do_IRQ(MIPS_CPU_IRQ_BASE + 6);
+ loongson2f_bonito_dispatch();
+ }else if(pending & CAUSEF_IP5){
+ loongson2f_int3_dispatch();
+ }else if(pending & CAUSEF_IP4){
+ loongson2f_int2_dispatch();
+ }else if(pending & CAUSEF_IP3){ /* CPU UART */
+ loongson2f_int1_dispatch();
+ }else if(pending & CAUSEF_IP2){ /* South Bridge */
+ i8259_irqdispatch();
+ }else if(pending & CAUSEF_IP1){
+ loongson2f_steer1_dispatch();
+ }else if(pending & CAUSEF_IP0){
+ loongson2f_steer0_dispatch();
+ }else{
+ spurious_interrupt();
+ }
+ return;
+}
+
+static struct irqaction cascade_irqaction = {
+ .handler = no_action,
+ .mask = CPU_MASK_NONE,
+ .name = "cascade",
+};
+
+irqreturn_t ip6_action(int cpl, void *dev_id, struct pt_regs *regs)
+{
+ return IRQ_HANDLED;
+}
+
+static struct irqaction ip6_irqaction = {
+ .handler = ip6_action,
+ .mask = CPU_MASK_NONE,
+ .name = "cascade",
+ .flags = IRQF_SHARED,
+};
+
+void __init arch_init_irq(void)
+{
+ extern void bonito_irq_init(void);
+
+ /*
+ * Clear all of the interrupts while we change the able around a bit.
+ * int-handler is not on bootstrap
+ */
+ clear_c0_status(ST0_IM | ST0_BEV);
+ local_irq_disable();
+
+ /* setup cs5536 as high level */
+ BONITO_INTPOL = (1 << 11 | 1 << 12);
+ BONITO_INTEDGE &= ~(1 << 11 | 1 << 12);
+
+ /* no steer */
+ BONITO_INTSTEER = 0;
+
+ /*
+ * Mask out all interrupt by writing "1" to all bit position in
+ * the interrupt reset reg.
+ */
+ BONITO_INTENCLR = ~0;
+
+ /* init all controller
+ * 0-15 ------> i8259 interrupt
+ * 16-23 ------> mips cpu interrupt
+ * 32-63 ------> bonito irq
+ */
+
+ /* Sets the first-level interrupt dispatcher. */
+ mips_cpu_irq_init();
+
+ init_i8259_irqs();
+ bonito_irq_init();
+
+ /* setup bonito interrupt */
+ setup_irq(MIPS_CPU_IRQ_BASE + BONITO_INT_BONITO_OFF, &ip6_irqaction);
+ /* 8259 irq at IP2 */
+ setup_irq(MIPS_CPU_IRQ_BASE + BONITO_INT_I8259_OFF, &cascade_irqaction);
+
+}
diff --git a/arch/mips/lemote/lm2f/yeeloong/prom.c
b/arch/mips/lemote/lm2f/yeeloong/prom.c
new file mode 100644
index 0000000..7e027ae
--- /dev/null
+++ b/arch/mips/lemote/lm2f/yeeloong/prom.c
@@ -0,0 +1,157 @@
+/*
+ * Based on Ocelot Linux port, which is
+ * Copyright 2001 MontaVista Software Inc.
+ * Author: jsun@mvista.com or jsun@junsun.net
+ *
+ * Copyright 2003 ICT CAS
+ * Author: Michael Guo <guoyi@ict.ac.cn>
+ *
+ * Copyright (C) 2007 Lemote Inc. & Insititute of Computing Technology
+ * Author: Fuxin Zhang, zhangfx@lemote.com
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ */
+#include <linux/init.h>
+#include <linux/mm.h>
+#include <linux/sched.h>
+#include <linux/bootmem.h>
+
+#include <asm/addrspace.h>
+#include <asm/bootinfo.h>
+
+extern unsigned long bus_clock;
+extern unsigned long cpu_clock_freq;
+extern unsigned int memsize, highmemsize;
+extern int putDebugChar(unsigned char byte);
+
+static int argc;
+/* pmon passes arguments in 32bit pointers */
+static int *arg;
+static int *env;
+
+const char *get_system_type(void)
+{
+ return "lemote-yeloong";
+}
+
+void __init prom_init_cmdline(void)
+{
+ int i;
+ long l;
+
+ /* arg[0] is "g", the rest is boot parameters */
+ arcs_cmdline[0] = '\0';
+ for (i = 1; i < argc; i++) {
+ l = (long)arg[i];
+ if (strlen(arcs_cmdline) + strlen(((char *)l) + 1)
+ >= sizeof(arcs_cmdline))
+ break;
+ strcat(arcs_cmdline, ((char *)l));
+ strcat(arcs_cmdline, " ");
+ }
+}
+
+extern void _wrmsr(u32 msr, u32 hi, u32 lo);
+
+void __init prom_init(void)
+{
+ long l;
+ unsigned char default_root[50] = "/dev/hda1";
+ argc = fw_arg0;
+ arg = (int *)fw_arg1;
+ env = (int *)fw_arg2;
+
+ /* set lpc irq to quiet mode*/
+ //_wrmsr(0x8000004e, 0, 0);
+ //_wrmsr(0x8000004e, 0, 0xc0);
+ _wrmsr(0x80000014, 0x00, 0x16000003);
+
+ /*Emulate post for usb*/
+ _wrmsr(0x40000001, 0x4, 0xBF000);
+
+ prom_init_cmdline();
+
+#if 1
+ if (!strstr(arcs_cmdline, "no_auto_cmd")) {
+ char *pmon_ver, *ec_ver, *p, version[60], ec_version[64];
+
+ p = arcs_cmdline;
+
+ pmon_ver = strstr(arcs_cmdline, "PMON_VER");
+ if (pmon_ver) {
+ if((p = strstr(pmon_ver, " ")))
+ *p++ = '\0';
+ strncpy(version, pmon_ver, 60);
+ } else
+ strncpy(version, "PMON_VER=Unknown", 60);
+
+ ec_ver = strstr(p, "EC_VER");
+ if (ec_ver) {
+ if((p = strstr(ec_ver, " ")))
+ *p = '\0';
+ strncpy(ec_version, ec_ver, 64);
+ } else
+ strncpy(ec_version, "EC_VER=Unknown", 64);
+
+ p = strstr(arcs_cmdline, "root=");
+ if(p) {
+ strncpy(default_root, p, sizeof(default_root));
+ if(p=strstr(default_root, " "))
+ *p = '\0';
+ }
+
+ memset(arcs_cmdline, 0, sizeof(arcs_cmdline));
+ strcat(arcs_cmdline, version);
+ strcat(arcs_cmdline, " ");
+ strcat(arcs_cmdline, ec_version);
+ strcat(arcs_cmdline, " ");
+ strcat(arcs_cmdline, default_root);
+ strcat(arcs_cmdline, " console=tty2");
+ strcat(arcs_cmdline, " quiet");
+ }
+#endif
+ if ((strstr(arcs_cmdline, "console=")) == NULL)
+ strcat(arcs_cmdline, " console=ttyS0,115200");
+
+ if ((strstr(arcs_cmdline, "root=")) == NULL)
+ strcat(arcs_cmdline, " root=/dev/hda1");
+
+ l = (long)*env;
+ while (l != 0) {
+ if (strncmp("busclock", (char *)l, strlen("busclock")) == 0) {
+ bus_clock = simple_strtol((char *)l + strlen("busclock="),
+ NULL, 10);
+ }
+ if (strncmp("cpuclock", (char *)l, strlen("cpuclock")) == 0) {
+ cpu_clock_freq = simple_strtol((char *)l + strlen("cpuclock="),
+ NULL, 10);
+ }
+ if (strncmp("memsize", (char *)l, strlen("memsize")) == 0) {
+ memsize = simple_strtol((char *)l + strlen("memsize="),
+ NULL, 10);
+ }
+ if (strncmp("highmemsize", (char *)l, strlen("highmemsize")) == 0) {
+ highmemsize = simple_strtol((char *)l + strlen("highmemsize="),
+ NULL, 10);
+ }
+ env++;
+ l = (long)*env;
+ }
+ if (memsize == 0)
+ memsize = 256;
+
+ printk("busclock=%ld, cpuclock=%ld,memsize=%d,highmemsize=%d\n",
+ bus_clock, cpu_clock_freq, memsize, highmemsize);
+}
+
+void __init prom_free_prom_memory(void)
+{
+}
+
+void prom_putchar(char c)
+{
+ putDebugChar(c);
+}
diff --git a/arch/mips/lemote/lm2f/yeeloong/reset.c
b/arch/mips/lemote/lm2f/yeeloong/reset.c
new file mode 100644
index 0000000..f0323f7
--- /dev/null
+++ b/arch/mips/lemote/lm2f/yeeloong/reset.c
@@ -0,0 +1,80 @@
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * Copyright (C) 2007 Lemote, Inc. & Institute of Computing Technology
+ * Author: Fuxin Zhang, zhangfx@lemote.com
+ */
+
+#include <asm/io.h>
+#include <asm/pgtable.h>
+#include <asm/processor.h>
+#include <asm/reboot.h>
+#include <asm/system.h>
+
+#include <linux/sched.h>
+#include <linux/mm.h>
+#include <linux/pm.h>
+#include <linux/delay.h>
+
+extern void _wrmsr(u32 reg, u32 hi, u32 lo);
+extern void _rdmsr(u32 reg, u32 *hi, u32 *lo);
+
+static void loongson2f_restart(char *command)
+{
+#ifdef CONFIG_32BIT
+ *(volatile u32*)0xbfe00180 |= 0x7;
+#else
+ *(volatile u32*)0xffffffffbfe00180 |= 0x7;
+#endif
+
+#ifdef CONFIG_64BIT
+ *((volatile u8*)(0xffffffffbfd00381)) = 0xf4;
+ *((volatile u8*)(0xffffffffbfd00382)) = 0xec;
+ *((volatile u8*)(0xffffffffbfd00383)) = 0x01;
+#else
+ *((volatile u8*)(0xbfd00381)) = 0xfe;
+ *((volatile u8*)(0xbfd00382)) = 0xec;
+ *((volatile u8*)(0xbfd00383)) = 0x01;
+#endif
+
+ while (1);
+ /* Wait the system reset completely */
+#if 0
+ __asm__ __volatile__ (
+ ".long 0x3c02bfc0\n"
+ ".long 0x00400008\n"
+ :::"v0"
+ );
+#endif
+}
+
+static void loongson2f_halt(void)
+{
+#ifdef CONFIG_64BIT
+ /* cpu-gpio0 output low */
+ *((volatile u32*)(0xffffffffbfe0011c)) &= ~0x00000001;
+ /* cpu-gpio0 as output */
+ *((volatile u32*)(0xffffffffbfe00120)) &= ~0x00000001;
+#else
+ /* cpu-gpio0 output low */
+ *((volatile u32*)(0xbfe0011c)) &= ~0x00000001;
+ /* cpu-gpio0 as output */
+ *((volatile u32*)(0xbfe00120)) &= ~0x00000001;
+#endif
+
+}
+
+static void loongson2f_power_off(void)
+{
+ loongson2f_halt();
+}
+
+void mips_reboot_setup(void)
+{
+ _machine_restart = loongson2f_restart;
+ _machine_halt = loongson2f_halt;
+ pm_power_off = loongson2f_power_off;
+}
diff --git a/arch/mips/lemote/lm2f/yeeloong/setup.c
b/arch/mips/lemote/lm2f/yeeloong/setup.c
new file mode 100644
index 0000000..33c422c
--- /dev/null
+++ b/arch/mips/lemote/lm2f/yeeloong/setup.c
@@ -0,0 +1,134 @@
+/*
+ * BRIEF MODULE DESCRIPTION
+ * setup.c - board dependent boot routines
+ *
+ * Copyright (C) 2007 Lemote Inc. & Insititute of Computing Technology
+ * Author: Fuxin Zhang, zhangfx@lemote.com
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
+ * NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
+ * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+#include <linux/bootmem.h>
+#include <linux/init.h>
+#include <linux/irq.h>
+
+#include <asm/bootinfo.h>
+#include <asm/mc146818-time.h>
+#include <asm/time.h>
+#include <asm/wbflush.h>
+
+#ifdef CONFIG_VT
+#include <linux/console.h>
+#include <linux/screen_info.h>
+#endif
+
+extern void mips_reboot_setup(void);
+
+#ifdef CONFIG_64BIT
+#define PTR_PAD(p) ((0xffffffff00000000)|((unsigned long long)(p)))
+#else
+#define PTR_PAD(p) (p)
+#endif
+
+unsigned long cpu_clock_freq;
+unsigned long bus_clock;
+unsigned int memsize;
+unsigned int highmemsize = 0;
+
+extern int __init init_mfgpt_clocksource(void);
+
+void __init plat_time_init(void)
+{
+ /* setup mips r4k timer */
+ mips_hpt_frequency = cpu_clock_freq / 2;
+
+#ifdef CONFIG_LS2F_CPU_FREQ
+ init_mfgpt_clocksource();
+#endif
+}
+
+unsigned long read_persistent_clock(void)
+{
+ return mc146818_get_cmos_time();
+}
+
+void (*__wbflush)(void);
+EXPORT_SYMBOL(__wbflush);
+
+static void wbflush_loongson2f(void)
+{
+ asm(".set\tpush\n\t"
+ ".set\tnoreorder\n\t"
+ ".set mips3\n\t"
+ "sync\n\t"
+ "nop\n\t"
+ ".set\tpop\n\t"
+ ".set mips0\n\t");
+}
+
+void __init plat_mem_setup(void)
+{
+ set_io_port_base(PTR_PAD(0xbfd00000));
+
+ mips_reboot_setup();
+
+ __wbflush = wbflush_loongson2f;
+
+ add_memory_region(0x0, (memsize << 20), BOOT_MEM_RAM);
+#ifdef CONFIG_64BIT
+ __asm__(
+ ".set mips3\n"
+ "dli $2, 0x900000003ff00000\n"
+ "dli $3, 0x0000000080000000\n"
+ "sd $3, 0x10($2)\n"
+ "sd $0, 0x50($2)\n"
+ "dli $3, 0xffffffffc0000000\n"
+ "sd $3, 0x30($2)\n"
+ ".set mips0\n"
+ :::"$2","$3","memory");
+ if (highmemsize > 0) {
+ add_memory_region(0x90000000, highmemsize << 20, BOOT_MEM_RAM);
+ }
+#endif
+
+#ifdef CONFIG_VT
+#if defined(CONFIG_VGA_CONSOLE)
+ conswitchp = &vga_con;
+
+ screen_info = (struct screen_info) {
+ 0, 25, /* orig-x, orig-y */
+ 0, /* unused */
+ 0, /* orig-video-page */
+ 0, /* orig-video-mode */
+ 80, /* orig-video-cols */
+ 0, 0, 0, /* ega_ax, ega_bx, ega_cx */
+ 25, /* orig-video-lines */
+ VIDEO_TYPE_VGAC, /* orig-video-isVGA */
+ 16 /* orig-video-points */
+ };
+#elif defined(CONFIG_DUMMY_CONSOLE)
+ conswitchp = &dummy_con;
+#endif
+#endif
+
+}
+
+EXPORT_SYMBOL(cpu_clock_freq);
diff --git a/arch/mips/pci/Makefile b/arch/mips/pci/Makefile
index e8a97f5..9bcdff5 100644
--- a/arch/mips/pci/Makefile
+++ b/arch/mips/pci/Makefile
@@ -27,6 +27,8 @@ obj-$(CONFIG_SOC_AU1500) += fixup-au1000.o ops-au1000.o
obj-$(CONFIG_SOC_AU1550) += fixup-au1000.o ops-au1000.o
obj-$(CONFIG_SOC_PNX8550) += fixup-pnx8550.o ops-pnx8550.o
obj-$(CONFIG_LEMOTE_FULONG) += fixup-lm2e.o ops-bonito64.o
+obj-$(CONFIG_LEMOTE_FULOONG2F) += fixup-fl2f.o ops-lm2f.o
+obj-$(CONFIG_LEMOTE_YEELOONG2F) += fixup-yl2f.o ops-lm2f.o
obj-$(CONFIG_MIPS_MALTA) += fixup-malta.o
obj-$(CONFIG_PMC_MSP7120_GW) += fixup-pmcmsp.o ops-pmcmsp.o
obj-$(CONFIG_PMC_MSP7120_EVAL) += fixup-pmcmsp.o ops-pmcmsp.o
diff --git a/arch/mips/pci/fixup-fl2f.c b/arch/mips/pci/fixup-fl2f.c
new file mode 100644
index 0000000..58a1a18
--- /dev/null
+++ b/arch/mips/pci/fixup-fl2f.c
@@ -0,0 +1,256 @@
+/*
+ * fixup-lm2f.c
+ *
+ * Copyright (C) 2004 ICT CAS
+ * Author: Li xiaoyu, ICT CAS
+ * lixy@ict.ac.cn
+ *
+ * Copyright (C) 2007 Lemote, Inc. & Institute of Computing Technology
+ * Author: Fuxin Zhang, zhangfx@lemote.com
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
+ * NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
+ * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <asm/mips-boards/bonito64.h>
+
+/* PCI interrupt pins */
+/* These should not be changed, or you should consider godson2f
interrupt register and
+ * your pci card dispatch
+ */
+#define PCIA 4
+#define PCIB 5
+#define PCIC 6
+#define PCID 7
+
+/* all the pci device has the PCIA pin, check the datasheet. */
+static char irq_tab[][5] __initdata = {
+ /* INTA INTB INTC INTD */
+ {0, 0, 0, 0, 0 }, /* 11: Unused */
+ {0, 0, 0, 0, 0 }, /* 12: Unused */
+ {0, 0, 0, 0, 0 }, /* 13: Unused */
+ {0, 0, 0, 0, 0 }, /* 14: Unused */
+ {0, 0, 0, 0, 0 }, /* 15: Unused */
+ {0, 0, 0, 0, 0 }, /* 16: Unused */
+ {0, PCIA, 0, 0, 0 }, /* 17: RTL8110-0 */
+ {0, PCIB, 0, 0, 0 }, /* 18: RTL8110-1 */
+ {0, PCIC, 0, 0, 0 }, /* 19: SiI3114 */
+ {0, PCID, 0, 0, 0 }, /* 20: 3-ports nec usb*/
+ {0, PCIA, PCIB, PCIC, PCID }, /* 21: PCI-SLOT */
+ {0, 0, 0, 0, 0 }, /* 22: Unused */
+ {0, 0, 0, 0, 0 }, /* 23: Unused */
+ {0, 0, 0, 0, 0 }, /* 24: Unused */
+ {0, 0, 0, 0, 0 }, /* 25: Unused */
+ {0, 0, 0, 0, 0 }, /* 26: Unused */
+ {0, 0, 0, 0, 0 }, /* 27: Unused */
+};
+
+int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+{
+ int virq;
+
+ if( (PCI_SLOT(dev->devfn) != (14)) && (PCI_SLOT(dev->devfn) < 32) ){
+ virq = irq_tab[slot][pin];
+ printk("slot: %d, pin: %d, irq: %d\n", slot, pin, virq+BONITO_IRQ_BASE);
+ if(virq != 0)
+ return (BONITO_IRQ_BASE + virq);
+ else
+ return 0;
+ }else if( PCI_SLOT(dev->devfn) == 14){ // cs5536
+ switch(PCI_FUNC(dev->devfn)){
+ case 2 :
+ pci_write_config_byte(dev, PCI_INTERRUPT_LINE, 14);
+ return 14; // for IDE
+ case 3 :
+ pci_write_config_byte(dev, PCI_INTERRUPT_LINE, 9);
+ return 9; // for AUDIO
+ case 4 : // for OHCI
+ case 5 : // for EHCI
+ case 6 : // for UDC
+ case 7 : // for OTG
+ pci_write_config_byte(dev, PCI_INTERRUPT_LINE, 11);
+ return 11;
+ }
+ return dev->irq;
+ }else{
+ printk(" strange pci slot number.\n");
+ return 0;
+ }
+}
+
+/* Do platform specific device initialization at pci_enable_device()
time */
+int pcibios_plat_dev_init(struct pci_dev *dev)
+{
+ return 0;
+}
+
+#ifndef TEST_NO_CS5536
+
+extern void _wrmsr(u32 reg, u32 hi, u32 lo);
+extern void _rdmsr(u32 reg, u32 *hi, u32 *lo);
+
+/* CS5536 SPEC. fixup */
+static void __init loongson2f_cs5536_isa_fixup(struct pci_dev *pdev)
+{
+ /* the uart1 and uart2 interrupt in PIC is enabled as default */
+ pci_write_config_dword(pdev, 0x50, 1);
+ pci_write_config_dword(pdev, 0x54, 1);
+ /* enable the pci MASTER ABORT/ TARGET ABORT etc. */
+ //pci_write_config_dword(pdev, 0x58, 1);
+ return;
+}
+
+
+static void __init loongson2f_cs5536_ide_fixup(struct pci_dev *pdev)
+{
+ /* setting the mutex pin as IDE function */
+ /* the IDE interrupt in PIC is enabled as default */
+ pci_write_config_dword(pdev, 0x40, 0xDEADBEEF);
+ return;
+}
+
+static void __init loongson2f_cs5536_acc_fixup(struct pci_dev *pdev)
+{
+ u8 val;
+
+ /* enable the AUDIO interrupt in PIC */
+ pci_write_config_dword(pdev, 0x50, 1);
+
+#if 1
+ pci_read_config_byte(pdev, PCI_LATENCY_TIMER, &val);
+ printk("cs5536 acc latency %x\n", val);
+ pci_write_config_byte(pdev, PCI_LATENCY_TIMER, 0xc0);
+#endif
+ return;
+}
+
+static void __init loongson2f_cs5536_ohci_fixup(struct pci_dev *pdev)
+{
+ /* enable the OHCI interrupt in PIC */
+ /* THE OHCI, EHCI, UDC, OTG are shared with interrupt in PIC */
+ pci_write_config_dword(pdev, 0x50, 1);
+ return;
+}
+
+static void __init loongson2f_cs5536_ehci_fixup(struct pci_dev *pdev)
+{
+ u32 hi, lo;
+#if 0
+ u32 bar;
+ void __iomem *base;
+#endif
+
+ /* Serial short detect enable */
+ _rdmsr(0x40000001, &hi, &lo);
+ _wrmsr(0x40000001, (1<<1)|(1<<2)|(1<<3), lo);
+
+#if 0
+ /* Write to clear diag register */
+ _rdmsr(0x40000005, &hi, &lo);
+ _wrmsr(0x40000005, hi, lo);
+
+ pci_read_config_dword(pdev, 0x10, &bar);
+ base = ioremap_nocache(bar, 0x100);
+
+ /* Make HCCAPARMS writable */
+ writel(readl(base + 0xA0) | (1<<1), (base + 0xA0));
+
+ /* EECP=50h, IST=01h, ASPC=1h */
+ writel(0x00000012, base + 0x08);
+ iounmap(base);
+#endif
+
+ /* setting the USB2.0 micro frame length */
+ pci_write_config_dword(pdev, 0x60, 0x2000);
+ return;
+}
+#endif /* TEST_NO_CS5536 */
+
+static void __init loongson2f_fixup_pcimap(struct pci_dev *pdev)
+{
+ static int first = 1;
+
+ (void)pdev;
+ if (first)
+ first = 0;
+ else
+ return;
+
+ /* local to PCI mapping: [256M,512M] -> [256M,512M]; differ from pmon */
+ /*
+ * cpu address space [256M,448M] is window for accessing pci space
+ * we set pcimap_lo[0,1,2] to map it to pci space [256M,448M]
+ * pcimap: bit18,pcimap_2; bit[17-12],lo2;bit[11-6],lo1;bit[5-0],lo0
+ */
+ /* 1,00 0110 ,0001 01,00 0000 */
+ BONITO_PCIMAP = 0x46140;
+ //1, 00 0010, 0000,01, 00 0000
+ //BONITO_PCIMAP = 0x42040;
+
+ /*
+ * PCI to local mapping: [2G,2G+256M] -> [0,256M]
+ */
+#if 1 // for GODSON2F
+ BONITO_PCIBASE0 = 0x80000000;
+ BONITO_PCIBASE1 = 0x00000000;
+ BONITO(BONITO_REGBASE + 0x50) = 0xc000000c;
+ BONITO(BONITO_REGBASE + 0x54) = 0xffffffff;
+ BONITO(BONITO_REGBASE + 0x58) = 0x00000006;
+ BONITO(BONITO_REGBASE + 0x5c) = 0x00000000;
+ BONITO(BONITO_REGBASE + 0x60) = 0x00000006;
+ BONITO(BONITO_REGBASE + 0x64) = 0x00000000;
+#else // for GODSON2E
+ BONITO_PCIBASE0 = 0x80000000;
+ BONITO_PCIBASE1 = 0x00800000;
+ BONITO_PCIBASE2 = 0x90000000;
+#endif
+
+#ifdef CONFIG_64BIT
+ *(volatile u32*)0xffffffffbfe0004c = 0xd2000001;
+#else
+ *(volatile u32*)0xbfe0004c = 0xd2000001;
+#endif
+}
+
+static void __init loongson2f_nec_fixup(struct pci_dev *pdev)
+{
+ unsigned int val;
+
+ /* Configues port 1, 2, 3 to be validate*/
+ pci_read_config_dword(pdev, 0xe0, &val);
+ pci_write_config_dword(pdev, 0xe0, (val & ~3) | 0x2); /*Only 2 port be
used*/
+}
+#ifndef TEST_NO_CS5536
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CS5536_ISA,
+ loongson2f_cs5536_isa_fixup);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CS5536_OHC,
+ loongson2f_cs5536_ohci_fixup);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CS5536_EHC,
+ loongson2f_cs5536_ehci_fixup);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD,
PCI_DEVICE_ID_AMD_CS5536_AUDIO,
+ loongson2f_cs5536_acc_fixup);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CS5536_IDE,
+ loongson2f_cs5536_ide_fixup);
+#endif /* TEST_NO_CS5536 */
+DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, loongson2f_fixup_pcimap);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NEC, PCI_DEVICE_ID_NEC_USB,
+ loongson2f_nec_fixup);
diff --git a/arch/mips/pci/fixup-yl2f.c b/arch/mips/pci/fixup-yl2f.c
new file mode 100644
index 0000000..142f0a0
--- /dev/null
+++ b/arch/mips/pci/fixup-yl2f.c
@@ -0,0 +1,245 @@
+/*
+ * fixup-lm2f.c
+ *
+ * Copyright (C) 2008 Lemote Technology
+ * Copyright (C) 2004 ICT CAS
+ * Author: Li xiaoyu, ICT CAS
+ * lixy@ict.ac.cn
+ *
+ * Copyright (C) 2007 Lemote, Inc. & Institute of Computing Technology
+ * Author: Fuxin Zhang, zhangfx@lemote.com
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
+ * NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
+ * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <asm/mips-boards/bonito64.h>
+
+/* PCI interrupt pins */
+/* These should not be changed, or you should consider godson2f
interrupt register and
+ * your pci card dispatch
+ */
+#define PCIA 4
+#define PCIB 5
+#define PCIC 6
+#define PCID 7
+
+/* all the pci device has the PCIA pin, check the datasheet. */
+static char irq_tab[][5] __initdata = {
+ /* INTA INTB INTC INTD */
+ {0, 0, 0, 0, 0 }, /* 11: Unused */
+ {0, 0, 0, 0, 0 }, /* 12: Unused */
+ {0, 0, 0, 0, 0 }, /* 13: Unused */
+ {0, 0, 0, 0, 0 }, /* 14: Unused */
+ {0, 0, 0, 0, 0 }, /* 15: Unused */
+ {0, 0, 0, 0, 0 }, /* 16: Unused */
+ {0, PCIA, 0, 0, 0 }, /* 17: RTL8110-0 */
+ {0, PCIB, 0, 0, 0 }, /* 18: RTL8110-1 */
+ {0, PCIC, 0, 0, 0 }, /* 19: SiI3114 */
+ {0, PCID, 0, 0, 0 }, /* 20: 3-ports nec usb*/
+ {0, PCIA, PCIB, PCIC, PCID }, /* 21: PCI-SLOT */
+ {0, 0, 0, 0, 0 }, /* 22: Unused */
+ {0, 0, 0, 0, 0 }, /* 23: Unused */
+ {0, 0, 0, 0, 0 }, /* 24: Unused */
+ {0, 0, 0, 0, 0 }, /* 25: Unused */
+ {0, 0, 0, 0, 0 }, /* 26: Unused */
+ {0, 0, 0, 0, 0 }, /* 27: Unused */
+};
+
+int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+{
+ int virq;
+
+ if( (PCI_SLOT(dev->devfn) != (14)) && (PCI_SLOT(dev->devfn) < 32) ){
+ virq = irq_tab[slot][pin];
+ printk("slot: %d, pin: %d, irq: %d\n", slot, pin, virq+BONITO_IRQ_BASE);
+ if(virq != 0)
+ return (BONITO_IRQ_BASE + virq);
+ else
+ return 0;
+ }else if( PCI_SLOT(dev->devfn) == 14){ // cs5536
+ switch(PCI_FUNC(dev->devfn)){
+ case 2 :
+ pci_write_config_byte(dev, PCI_INTERRUPT_LINE, 14);
+ return 14; // for IDE
+ case 3 :
+ pci_write_config_byte(dev, PCI_INTERRUPT_LINE, 9);
+ return 9; // for AUDIO
+ case 4 : // for OHCI
+ case 5 : // for EHCI
+ case 6 : // for UDC
+ case 7 : // for OTG
+ pci_write_config_byte(dev, PCI_INTERRUPT_LINE, 11);
+ return 11;
+ }
+ return dev->irq;
+ }else{
+ printk(" strange pci slot number.\n");
+ return 0;
+ }
+}
+
+/* Do platform specific device initialization at pci_enable_device()
time */
+int pcibios_plat_dev_init(struct pci_dev *dev)
+{
+ return 0;
+}
+
+extern void _wrmsr(u32 reg, u32 hi, u32 lo);
+extern void _rdmsr(u32 reg, u32 *hi, u32 *lo);
+
+/* CS5536 SPEC. fixup */
+static void __init loongson2f_cs5536_isa_fixup(struct pci_dev *pdev)
+{
+ /* the uart1 and uart2 interrupt in PIC is enabled as default */
+ pci_write_config_dword(pdev, 0x50, 1);
+ pci_write_config_dword(pdev, 0x54, 1);
+ /* enable the pci MASTER ABORT/ TARGET ABORT etc. */
+ //pci_write_config_dword(pdev, 0x58, 1);
+ return;
+}
+
+
+static void __init loongson2f_cs5536_ide_fixup(struct pci_dev *pdev)
+{
+ /* setting the mutex pin as IDE function */
+ /* the IDE interrupt in PIC is enabled as default */
+ pci_write_config_dword(pdev, 0x40, 0xDEADBEEF);
+ return;
+}
+
+static void __init loongson2f_cs5536_acc_fixup(struct pci_dev *pdev)
+{
+ u8 val;
+
+ /* enable the AUDIO interrupt in PIC */
+ pci_write_config_dword(pdev, 0x50, 1);
+
+#if 1
+ pci_read_config_byte(pdev, PCI_LATENCY_TIMER, &val);
+ printk("cs5536 acc latency %x\n", val);
+ pci_write_config_byte(pdev, PCI_LATENCY_TIMER, 0xc0);
+#endif
+ return;
+}
+
+static void __init loongson2f_cs5536_ohci_fixup(struct pci_dev *pdev)
+{
+ /* enable the OHCI interrupt in PIC */
+ /* THE OHCI, EHCI, UDC, OTG are shared with interrupt in PIC */
+ pci_write_config_dword(pdev, 0x50, 1);
+ return;
+}
+
+static void __init loongson2f_cs5536_ehci_fixup(struct pci_dev *pdev)
+{
+ u32 hi, lo;
+#if 0
+ u32 bar;
+ void __iomem *base;
+#endif
+
+ /* Serial short detect enable */
+ _rdmsr(0x40000001, &hi, &lo);
+ _wrmsr(0x40000001, (1<<1)|(1<<2)|(1<<3), lo);
+
+#if 0
+ /* Write to clear diag register */
+ _rdmsr(0x40000005, &hi, &lo);
+ _wrmsr(0x40000005, hi, lo);
+
+ pci_read_config_dword(pdev, 0x10, &bar);
+ base = ioremap_nocache(bar, 0x100);
+
+ /* Make HCCAPARMS writable */
+ writel(readl(base + 0xA0) | (1<<1), (base + 0xA0));
+
+ /* EECP=50h, IST=01h, ASPC=1h */
+ writel(0x00000012, base + 0x08);
+ iounmap(base);
+#endif
+
+ /* setting the USB2.0 micro frame length */
+ pci_write_config_dword(pdev, 0x60, 0x2000);
+ return;
+}
+
+static void __init loongson2f_fixup_pcimap(struct pci_dev *pdev)
+{
+ static int first = 1;
+
+ (void)pdev;
+ if (first)
+ first = 0;
+ else
+ return;
+
+ /* local to PCI mapping: [256M,512M] -> [256M,512M]; differ from pmon */
+ /*
+ * cpu address space [256M,448M] is window for accessing pci space
+ * we set pcimap_lo[0,1,2] to map it to pci space [256M,448M]
+ * pcimap: bit18,pcimap_2; bit[17-12],lo2;bit[11-6],lo1;bit[5-0],lo0
+ */
+ /* 1,00 0110 ,0001 01,00 0000 */
+ BONITO_PCIMAP = 0x46140;
+
+ /*
+ * PCI to local mapping: [2G,2G+256M] -> [0,256M]
+ */
+ BONITO_PCIBASE0 = 0x80000000;
+ BONITO_PCIBASE1 = 0x00000000;
+ BONITO(BONITO_REGBASE + 0x50) = 0xc000000c;
+ BONITO(BONITO_REGBASE + 0x54) = 0xffffffff;
+ BONITO(BONITO_REGBASE + 0x58) = 0x00000006;
+ BONITO(BONITO_REGBASE + 0x5c) = 0x00000000;
+ BONITO(BONITO_REGBASE + 0x60) = 0x00000006;
+ BONITO(BONITO_REGBASE + 0x64) = 0x00000000;
+
+ BONITO(0x4c) = 0xd2000001;
+#ifdef CONFIG_64BIT
+ *(volatile u32*)0xffffffffbfe0004c = 0xd2000001;
+#else
+ *(volatile u32*)0xbfe0004c = 0xd2000001;
+#endif
+}
+
+static void __init loongson2f_nec_fixup(struct pci_dev *pdev)
+{
+ unsigned int val;
+
+ pci_read_config_dword(pdev, 0xe0, &val);
+ /* Only 2 port be used */
+ pci_write_config_dword(pdev, 0xe0, (val & ~3) | 0x2);
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CS5536_ISA,
+ loongson2f_cs5536_isa_fixup);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CS5536_OHC,
+ loongson2f_cs5536_ohci_fixup);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CS5536_EHC,
+ loongson2f_cs5536_ehci_fixup);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD,
PCI_DEVICE_ID_AMD_CS5536_AUDIO,
+ loongson2f_cs5536_acc_fixup);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CS5536_IDE,
+ loongson2f_cs5536_ide_fixup);
+DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, loongson2f_fixup_pcimap);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NEC, PCI_DEVICE_ID_NEC_USB,
+ loongson2f_nec_fixup);
diff --git a/arch/mips/pci/ops-lm2f.c b/arch/mips/pci/ops-lm2f.c
new file mode 100644
index 0000000..08e8b7f
--- /dev/null
+++ b/arch/mips/pci/ops-lm2f.c
@@ -0,0 +1,205 @@
+/*
+ * ops-lm2f.c
+ *
+ * Copyright (C) 2004 ICT CAS
+ * Author: Li xiaoyu, ICT CAS
+ * lixy@ict.ac.cn
+ *
+ * Copyright (C) 2007 Lemote, Inc. & Institute of Computing Technology
+ * Author: Fuxin Zhang, zhangfx@lemote.com
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
+ * NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
+ * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+
+#include <linux/types.h>
+#include <linux/pci.h>
+#include <linux/kernel.h>
+
+#include <asm/mips-boards/bonito64.h>
+
+#define PCI_OPS_CS5536_IDSEL 14
+
+#define PCI_ACCESS_READ 0
+#define PCI_ACCESS_WRITE 1
+
+extern void cs5536_pci_conf_write4(int function, int reg, u32 value);
+extern u32 cs5536_pci_conf_read4(int function, int reg);
+
+static inline void bflush(void)
+{
+ /* flush Bonito register writes */
+ (void)BONITO_PCICMD;
+}
+
+static int lm2f_pci_config_access(unsigned char access_type,
+ struct pci_bus *bus, unsigned int devfn,
+ int where, u32 *data)
+{
+ u32 busnum = bus->number;
+ u32 addr, type;
+ void *addrp;
+ int device = PCI_SLOT(devfn);
+ int function = PCI_FUNC(devfn);
+ int reg = where & ~3;
+
+ /************************************************************************/
+ /* CS5536 PCI ACCESS ROUTINE : */
+ /* Note the functions circle call : */
+ /* lm2e_pci_config_access()--->cs5536_pci_conf_read/write4()---> */
+ /* _rdmsr/_wrmsr()--->lm2e_pci_config_access() */
+ /************************************************************************/
+ if( (busnum == 0) && (device == PCI_OPS_CS5536_IDSEL) && (reg < 0xF0) ){
+ switch(access_type){
+ case PCI_ACCESS_READ :
+ *data = cs5536_pci_conf_read4(function, reg);
+ break;
+ case PCI_ACCESS_WRITE :
+ cs5536_pci_conf_write4(function, reg, *data);
+ break;
+ }
+ return 0;
+ }
+
+ if (busnum == 0) {
+ /* Type 0 configuration on onboard PCI bus */
+ if (device > 20 || function > 7) {
+ *data = -1; /* device out of range */
+ return PCIBIOS_DEVICE_NOT_FOUND;
+ }
+ addr = (1 << (device + 11)) | (function << 8) | reg;
+ type = 0;
+ } else {
+ /* Type 1 configuration on offboard PCI bus */
+ if (device > 31 || function > 7) {
+ *data = -1; /* device out of range */
+ return PCIBIOS_DEVICE_NOT_FOUND;
+ }
+ addr = (busnum << 16) | (device << 11) | (function << 8) | reg;
+ type = 0x10000;
+ }
+
+ /* clear aborts */
+ BONITO_PCICMD |= BONITO_PCICMD_MABORT_CLR | BONITO_PCICMD_MTABORT_CLR;
+
+ BONITO_PCIMAP_CFG = (addr >> 16) | type;
+ bflush();
+
+ addrp = (void *)CKSEG1ADDR(BONITO_PCICFG_BASE | (addr & 0xffff));
+ if (access_type == PCI_ACCESS_WRITE) {
+ *(volatile unsigned int *)addrp = cpu_to_le32(*data);
+ } else {
+ *data = le32_to_cpu(*(volatile unsigned int *)addrp);
+ }
+
+ /* Detect Master/Target abort */
+ if (BONITO_PCICMD & (BONITO_PCICMD_MABORT_CLR |
BONITO_PCICMD_MTABORT_CLR)) {
+ BONITO_PCICMD |= BONITO_PCICMD_MABORT_CLR | BONITO_PCICMD_MTABORT_CLR;
+ *data = -1;
+ return PCIBIOS_DEVICE_NOT_FOUND;
+ }
+
+ return PCIBIOS_SUCCESSFUL;
+
+}
+
+static int lm2f_pci_pcibios_read(struct pci_bus *bus, unsigned int devfn,
+ int where, int size, u32 * val)
+{
+ u32 data = 0;
+
+ int ret = lm2f_pci_config_access(PCI_ACCESS_READ,
+ bus, devfn, where, &data);
+
+ if (ret != PCIBIOS_SUCCESSFUL)
+ return ret;
+
+ if (size == 1)
+ *val = (data >> ((where & 3) << 3)) & 0xff;
+ else if (size == 2)
+ *val = (data >> ((where & 3) << 3)) & 0xffff;
+ else
+ *val = data;
+
+ return PCIBIOS_SUCCESSFUL;
+}
+
+static int lm2f_pci_pcibios_write(struct pci_bus *bus, unsigned int devfn,
+ int where, int size, u32 val)
+{
+ u32 data = 0;
+ int ret;
+
+ if (size == 4)
+ data = val;
+ else {
+ ret = lm2f_pci_config_access(PCI_ACCESS_READ,
+ bus, devfn, where, &data);
+ if (ret != PCIBIOS_SUCCESSFUL)
+ return ret;
+
+ if (size == 1)
+ data = (data & ~(0xff << ((where & 3) << 3))) |
+ (val << ((where & 3) << 3));
+ else if (size == 2)
+ data = (data & ~(0xffff << ((where & 3) << 3))) |
+ (val << ((where & 3) << 3));
+ }
+
+ ret = lm2f_pci_config_access(PCI_ACCESS_WRITE,
+ bus, devfn, where, &data);
+ if (ret != PCIBIOS_SUCCESSFUL)
+ return ret;
+
+ return PCIBIOS_SUCCESSFUL;
+}
+
+void _rdmsr(u32 msr, u32 *hi, u32 *lo)
+{
+ struct pci_bus bus = {
+ .number = 0
+ };
+ u32 devfn = PCI_DEVFN(14, 0);
+ lm2f_pci_pcibios_write(&bus, devfn, 0xf4, 4, msr);
+ lm2f_pci_pcibios_read(&bus, devfn, 0xf8, 4, lo);
+ lm2f_pci_pcibios_read(&bus, devfn, 0xfc, 4, hi);
+ //printk("rdmsr msr %x, lo %x, hi %x\n", msr, *lo, *hi);
+}
+
+void _wrmsr(u32 msr, u32 hi, u32 lo)
+{
+ struct pci_bus bus = {
+ .number = 0
+ };
+ u32 devfn = PCI_DEVFN(14, 0);
+ lm2f_pci_pcibios_write(&bus, devfn, 0xf4, 4, msr);
+ lm2f_pci_pcibios_write(&bus, devfn, 0xf8, 4, lo);
+ lm2f_pci_pcibios_write(&bus, devfn, 0xfc, 4, hi);
+ //printk("wrmsr msr %x, lo %x, hi %x\n", msr, lo, hi);
+}
+
+EXPORT_SYMBOL(_rdmsr);
+EXPORT_SYMBOL(_wrmsr);
+
+struct pci_ops loongson2f_pci_pci_ops = {
+ .read = lm2f_pci_pcibios_read,
+ .write = lm2f_pci_pcibios_write
+};
-- 
1.5.6.5
