Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Mar 2011 05:54:29 +0100 (CET)
Received: from mx1.netlogicmicro.com ([12.49.93.86]:1402 "EHLO
        orion5.netlogicmicro.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491077Ab1CYEw3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 25 Mar 2011 05:52:29 +0100
X-TM-IMSS-Message-ID: <51661e1d0002ab97@netlogicmicro.com>
Received: from orion8.netlogicmicro.com ([10.10.16.60]) by netlogicmicro.com ([10.10.16.19]) with ESMTP (TREND IMSS SMTP Service 7.0) id 51661e1d0002ab97 ; Thu, 24 Mar 2011 21:52:20 -0700
Received: from jayachandranc.netlogicmicro.com ([10.7.0.77]) by orion8.netlogicmicro.com with Microsoft SMTPSVC(6.0.3790.3959);
         Thu, 24 Mar 2011 21:52:28 -0700
Date:   Fri, 25 Mar 2011 10:28:30 +0530
From:   Jayachandran C <jayachandranc@netlogicmicro.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: [PATCH 5/7] Platform files for XLR/XLS processor support
Message-ID: <2a4f8443a9bc1cf8b78585104a057fcb09b63b5d.1301028081.git.jayachandranc@netlogicmicro.com>
References: <cover.1301028080.git.jayachandranc@netlogicmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1301028080.git.jayachandranc@netlogicmicro.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-OriginalArrivalTime: 25 Mar 2011 04:52:28.0567 (UTC) FILETIME=[7140D270:01CBEAA8]
Return-Path: <jayachandranc@netlogicmicro.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29546
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips

* include/asm/netlogic added with files common for all Netlogic processors
 (common with XLP which will be added later)
* include/asm/netlogic/xlr for XLR/XLS chip specific files
* netlogic/xlr for XLR/XLS platform files

Signed-off-by: Jayachandran C <jayachandranc@netlogicmicro.com>
---
 arch/mips/include/asm/netlogic/interrupt.h    |   39 ++++
 arch/mips/include/asm/netlogic/mips-extns.h   |   69 +++++++
 arch/mips/include/asm/netlogic/psb-bootinfo.h |  103 ++++++++++
 arch/mips/include/asm/netlogic/xlr/gpio.h     |   67 +++++++
 arch/mips/include/asm/netlogic/xlr/iomap.h    |  125 ++++++++++++
 arch/mips/include/asm/netlogic/xlr/pic.h      |  225 ++++++++++++++++++++++
 arch/mips/include/asm/netlogic/xlr/xlr.h      |   20 ++
 arch/mips/netlogic/xlr/irq.c                  |  251 +++++++++++++++++++++++++
 arch/mips/netlogic/xlr/platform.c             |   99 ++++++++++
 arch/mips/netlogic/xlr/setup.c                |  182 ++++++++++++++++++
 arch/mips/netlogic/xlr/smp.c                  |  219 +++++++++++++++++++++
 arch/mips/netlogic/xlr/smpboot.S              |   88 +++++++++
 arch/mips/netlogic/xlr/time.c                 |   45 +++++
 arch/mips/netlogic/xlr/xlr_console.c          |   40 ++++
 14 files changed, 1572 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/include/asm/netlogic/interrupt.h
 create mode 100644 arch/mips/include/asm/netlogic/mips-extns.h
 create mode 100644 arch/mips/include/asm/netlogic/psb-bootinfo.h
 create mode 100644 arch/mips/include/asm/netlogic/xlr/gpio.h
 create mode 100644 arch/mips/include/asm/netlogic/xlr/iomap.h
 create mode 100644 arch/mips/include/asm/netlogic/xlr/pic.h
 create mode 100644 arch/mips/include/asm/netlogic/xlr/xlr.h
 create mode 100644 arch/mips/netlogic/xlr/irq.c
 create mode 100644 arch/mips/netlogic/xlr/platform.c
 create mode 100644 arch/mips/netlogic/xlr/setup.c
 create mode 100644 arch/mips/netlogic/xlr/smp.c
 create mode 100644 arch/mips/netlogic/xlr/smpboot.S
 create mode 100644 arch/mips/netlogic/xlr/time.c
 create mode 100644 arch/mips/netlogic/xlr/xlr_console.c

diff --git a/arch/mips/include/asm/netlogic/interrupt.h b/arch/mips/include/asm/netlogic/interrupt.h
new file mode 100644
index 0000000..433f7e2
--- /dev/null
+++ b/arch/mips/include/asm/netlogic/interrupt.h
@@ -0,0 +1,39 @@
+/*
+ * Copyright 2003-2011 Netlogic Microsystems (Netlogic). All rights
+ * reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are
+ * met:
+ *
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in
+ *    the documentation and/or other materials provided with the
+ *    distribution.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Netlogic Microsystems ``AS IS'' AND
+ * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
+ * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL NETLOGIC OR CONTRIBUTORS BE
+ * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
+ * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
+ * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
+ * THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#ifndef _ASM_NLM_INTERRUPT_H
+#define _ASM_NLM_INTERRUPT_H
+
+/* Defines for the IRQ numbers */
+
+#define IRQ_IPI_SMP_FUNCTION	3
+#define IRQ_IPI_SMP_RESCHEDULE	4
+#define IRQ_MSGRING		6
+#define IRQ_TIMER		7
+
+#endif
diff --git a/arch/mips/include/asm/netlogic/mips-extns.h b/arch/mips/include/asm/netlogic/mips-extns.h
new file mode 100644
index 0000000..d08359a
--- /dev/null
+++ b/arch/mips/include/asm/netlogic/mips-extns.h
@@ -0,0 +1,69 @@
+/*
+ * Copyright 2003-2011 Netlogic Microsystems (Netlogic). All rights
+ * reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are
+ * met:
+ *
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in
+ *    the documentation and/or other materials provided with the
+ *    distribution.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Netlogic Microsystems ``AS IS'' AND
+ * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
+ * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL NETLOGIC OR CONTRIBUTORS BE
+ * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
+ * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
+ * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
+ * THE POSSIBILITY OF SUCH DAMAGE.
+ */
+#ifndef _ASM_NLM_MIPS_EXTS_H
+#define _ASM_NLM_MIPS_EXTS_H
+
+/*
+ * XLR and XLP interrupt request and interrupt mask registers
+ */
+#define read_c0_eirr()		__read_64bit_c0_register($9, 6)
+#define read_c0_eimr()		__read_64bit_c0_register($9, 7)
+#define write_c0_eirr(val)	__write_64bit_c0_register($9, 6, val)
+
+/*
+ * Writing EIMR in 32 bit is a special case, the lower 8 bit of the
+ * EIMR is shadowed in the status register, so we cannot save and
+ * restore status register for split read.
+ */
+#define write_c0_eimr(val)						\
+do {									\
+	if (sizeof(unsigned long) == 4)	{				\
+		unsigned long __flags;					\
+									\
+		local_irq_save(__flags);				\
+		__asm__ __volatile__(					\
+			".set\tmips64\n\t"				\
+			"dsll\t%L0, %L0, 32\n\t"			\
+			"dsrl\t%L0, %L0, 32\n\t"			\
+			"dsll\t%M0, %M0, 32\n\t"			\
+			"or\t%L0, %L0, %M0\n\t"				\
+			"dmtc0\t%L0, $9, 7\n\t"				\
+			".set\tmips0"					\
+			: : "r" (val));					\
+		__flags = (__flags & 0xffff00ff) | (((val) & 0xff) << 8);\
+		local_irq_restore(__flags);				\
+	} else								\
+		__write_64bit_c0_register($9, 7, (val));		\
+} while (0)
+
+static inline int hard_smp_processor_id(void)
+{
+	return __read_32bit_c0_register($15, 1) & 0x3ff;
+}
+
+#endif /*_ASM_NLM_MIPS_EXTS_H */
diff --git a/arch/mips/include/asm/netlogic/psb-bootinfo.h b/arch/mips/include/asm/netlogic/psb-bootinfo.h
new file mode 100644
index 0000000..8283f03
--- /dev/null
+++ b/arch/mips/include/asm/netlogic/psb-bootinfo.h
@@ -0,0 +1,103 @@
+/*
+ * Copyright 2003-2011 Netlogic Microsystems (Netlogic). All rights
+ * reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are
+ * met:
+ *
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in
+ *    the documentation and/or other materials provided with the
+ *    distribution.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Netlogic Microsystems ``AS IS'' AND
+ * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
+ * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL NETLOGIC OR CONTRIBUTORS BE
+ * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
+ * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
+ * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
+ * THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#ifndef _ASM_NETLOGIC_BOOTINFO_H
+#define _ASM_NETLOGIC_BOOTINFO_H
+
+struct psb_info {
+	uint64_t boot_level;
+	uint64_t io_base;
+	uint64_t output_device;
+	uint64_t uart_print;
+	uint64_t led_output;
+	uint64_t init;
+	uint64_t exit;
+	uint64_t warm_reset;
+	uint64_t wakeup;
+	uint64_t online_cpu_map;
+	uint64_t master_reentry_sp;
+	uint64_t master_reentry_gp;
+	uint64_t master_reentry_fn;
+	uint64_t slave_reentry_fn;
+	uint64_t magic_dword;
+	uint64_t uart_putchar;
+	uint64_t size;
+	uint64_t uart_getchar;
+	uint64_t nmi_handler;
+	uint64_t psb_version;
+	uint64_t mac_addr;
+	uint64_t cpu_frequency;
+	uint64_t board_version;
+	uint64_t malloc;
+	uint64_t free;
+	uint64_t global_shmem_addr;
+	uint64_t global_shmem_size;
+	uint64_t psb_os_cpu_map;
+	uint64_t userapp_cpu_map;
+	uint64_t wakeup_os;
+	uint64_t psb_mem_map;
+	uint64_t board_major_version;
+	uint64_t board_minor_version;
+	uint64_t board_manf_revision;
+	uint64_t board_serial_number;
+	uint64_t psb_physaddr_map;
+	uint64_t xlr_loaderip_config;
+	uint64_t bldr_envp;
+	uint64_t avail_mem_map;
+};
+
+enum {
+	NETLOGIC_IO_SPACE = 0x10,
+	PCIX_IO_SPACE,
+	PCIX_CFG_SPACE,
+	PCIX_MEMORY_SPACE,
+	HT_IO_SPACE,
+	HT_CFG_SPACE,
+	HT_MEMORY_SPACE,
+	SRAM_SPACE,
+	FLASH_CONTROLLER_SPACE
+};
+
+#define NLM_MAX_ARGS	64
+#define NLM_MAX_ENVS	32
+
+/* This is what netlboot passes and linux boot_mem_map is subtly different */
+#define NLM_BOOT_MEM_MAP_MAX	32
+struct nlm_boot_mem_map {
+	int nr_map;
+	struct nlm_boot_mem_map_entry {
+		uint64_t addr;		/* start of memory segment */
+		uint64_t size;		/* size of memory segment */
+		uint32_t type;		/* type of memory segment */
+	} map[NLM_BOOT_MEM_MAP_MAX];
+};
+
+/* Pointer to saved boot loader info */
+extern struct psb_info nlm_prom_info;
+
+#endif
diff --git a/arch/mips/include/asm/netlogic/xlr/gpio.h b/arch/mips/include/asm/netlogic/xlr/gpio.h
new file mode 100644
index 0000000..2782c97
--- /dev/null
+++ b/arch/mips/include/asm/netlogic/xlr/gpio.h
@@ -0,0 +1,67 @@
+/*
+ * Copyright 2003-2011 Netlogic Microsystems (Netlogic). All rights
+ * reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are
+ * met:
+ *
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in
+ *    the documentation and/or other materials provided with the
+ *    distribution.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Netlogic Microsystems ``AS IS'' AND
+ * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
+ * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL NETLOGIC OR CONTRIBUTORS BE
+ * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
+ * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
+ * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
+ * THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#ifndef _ASM_NLM_GPIO_H
+#define _ASM_NLM_GPIO_H
+
+#define NETLOGIC_GPIO_INT_EN_REG		0
+#define NETLOGIC_GPIO_INPUT_INVERSION_REG	1
+#define NETLOGIC_GPIO_IO_DIR_REG		2
+#define NETLOGIC_GPIO_IO_DATA_WR_REG		3
+#define NETLOGIC_GPIO_IO_DATA_RD_REG		4
+
+#define NETLOGIC_GPIO_SWRESET_REG		8
+#define NETLOGIC_GPIO_DRAM1_CNTRL_REG		9
+#define NETLOGIC_GPIO_DRAM1_RATIO_REG		10
+#define NETLOGIC_GPIO_DRAM1_RESET_REG		11
+#define NETLOGIC_GPIO_DRAM1_STATUS_REG		12
+#define NETLOGIC_GPIO_DRAM2_CNTRL_REG		13
+#define NETLOGIC_GPIO_DRAM2_RATIO_REG		14
+#define NETLOGIC_GPIO_DRAM2_RESET_REG		15
+#define NETLOGIC_GPIO_DRAM2_STATUS_REG		16
+
+#define NETLOGIC_GPIO_PWRON_RESET_CFG_REG	21
+#define NETLOGIC_GPIO_BIST_ALL_GO_STATUS_REG	24
+#define NETLOGIC_GPIO_BIST_CPU_GO_STATUS_REG	25
+#define NETLOGIC_GPIO_BIST_DEV_GO_STATUS_REG	26
+
+#define NETLOGIC_GPIO_FUSE_BANK_REG		35
+#define NETLOGIC_GPIO_CPU_RESET_REG		40
+#define NETLOGIC_GPIO_RNG_REG			43
+
+#define NETLOGIC_PWRON_RESET_PCMCIA_BOOT	17
+#define NETLOGIC_GPIO_LED_BITMAP	0x1700000
+#define NETLOGIC_GPIO_LED_0_SHIFT		20
+#define NETLOGIC_GPIO_LED_1_SHIFT		24
+
+#define NETLOGIC_GPIO_LED_OUTPUT_CODE_RESET	0x01
+#define NETLOGIC_GPIO_LED_OUTPUT_CODE_HARD_RESET 0x02
+#define NETLOGIC_GPIO_LED_OUTPUT_CODE_SOFT_RESET 0x03
+#define NETLOGIC_GPIO_LED_OUTPUT_CODE_MAIN	0x04
+
+#endif
diff --git a/arch/mips/include/asm/netlogic/xlr/iomap.h b/arch/mips/include/asm/netlogic/xlr/iomap.h
new file mode 100644
index 0000000..756c9c8
--- /dev/null
+++ b/arch/mips/include/asm/netlogic/xlr/iomap.h
@@ -0,0 +1,125 @@
+/*
+ * Copyright 2003-2011 Netlogic Microsystems (Netlogic). All rights
+ * reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are
+ * met:
+ *
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in
+ *    the documentation and/or other materials provided with the
+ *    distribution.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Netlogic Microsystems ``AS IS'' AND
+ * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
+ * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL NETLOGIC OR CONTRIBUTORS BE
+ * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
+ * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
+ * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
+ * THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#ifndef _ASM_NLM_IOMAP_H
+#define _ASM_NLM_IOMAP_H
+
+#define DEFAULT_NETLOGIC_IO_BASE           CKSEG1ADDR(0x1ef00000)
+#define NETLOGIC_IO_DDR2_CHN0_OFFSET       0x01000
+#define NETLOGIC_IO_DDR2_CHN1_OFFSET       0x02000
+#define NETLOGIC_IO_DDR2_CHN2_OFFSET       0x03000
+#define NETLOGIC_IO_DDR2_CHN3_OFFSET       0x04000
+#define NETLOGIC_IO_PIC_OFFSET             0x08000
+#define NETLOGIC_IO_UART_0_OFFSET          0x14000
+#define NETLOGIC_IO_UART_1_OFFSET          0x15100
+
+#define NETLOGIC_IO_SIZE                   0x1000
+
+#define NETLOGIC_IO_BRIDGE_OFFSET          0x00000
+
+#define NETLOGIC_IO_RLD2_CHN0_OFFSET       0x05000
+#define NETLOGIC_IO_RLD2_CHN1_OFFSET       0x06000
+
+#define NETLOGIC_IO_SRAM_OFFSET            0x07000
+
+#define NETLOGIC_IO_PCIX_OFFSET            0x09000
+#define NETLOGIC_IO_HT_OFFSET              0x0A000
+
+#define NETLOGIC_IO_SECURITY_OFFSET        0x0B000
+
+#define NETLOGIC_IO_GMAC_0_OFFSET          0x0C000
+#define NETLOGIC_IO_GMAC_1_OFFSET          0x0D000
+#define NETLOGIC_IO_GMAC_2_OFFSET          0x0E000
+#define NETLOGIC_IO_GMAC_3_OFFSET          0x0F000
+
+/* XLS devices */
+#define NETLOGIC_IO_GMAC_4_OFFSET          0x20000
+#define NETLOGIC_IO_GMAC_5_OFFSET          0x21000
+#define NETLOGIC_IO_GMAC_6_OFFSET          0x22000
+#define NETLOGIC_IO_GMAC_7_OFFSET          0x23000
+
+#define NETLOGIC_IO_PCIE_0_OFFSET          0x1E000
+#define NETLOGIC_IO_PCIE_1_OFFSET          0x1F000
+#define NETLOGIC_IO_SRIO_0_OFFSET          0x1E000
+#define NETLOGIC_IO_SRIO_1_OFFSET          0x1F000
+
+#define NETLOGIC_IO_USB_0_OFFSET           0x24000
+#define NETLOGIC_IO_USB_1_OFFSET           0x25000
+
+#define NETLOGIC_IO_COMP_OFFSET            0x1D000
+/* end XLS devices */
+
+/* XLR devices */
+#define NETLOGIC_IO_SPI4_0_OFFSET          0x10000
+#define NETLOGIC_IO_XGMAC_0_OFFSET         0x11000
+#define NETLOGIC_IO_SPI4_1_OFFSET          0x12000
+#define NETLOGIC_IO_XGMAC_1_OFFSET         0x13000
+/* end XLR devices */
+
+#define NETLOGIC_IO_I2C_0_OFFSET           0x16000
+#define NETLOGIC_IO_I2C_1_OFFSET           0x17000
+
+#define NETLOGIC_IO_GPIO_OFFSET            0x18000
+#define NETLOGIC_IO_FLASH_OFFSET           0x19000
+#define NETLOGIC_IO_TB_OFFSET              0x1C000
+
+#define NETLOGIC_CPLD_OFFSET               KSEG1ADDR(0x1d840000)
+
+/*
+ * Base Address (Virtual) of the PCI Config address space
+ * For now, choose 256M phys in kseg1 = 0xA0000000 + (1<<28)
+ * Config space spans 256 (num of buses) * 256 (num functions) * 256 bytes
+ * ie 1<<24 = 16M
+ */
+#define DEFAULT_PCI_CONFIG_BASE         0x18000000
+#define DEFAULT_HT_TYPE0_CFG_BASE       0x16000000
+#define DEFAULT_HT_TYPE1_CFG_BASE       0x17000000
+
+#ifndef __ASSEMBLY__
+#include <linux/types.h>
+#include <asm/byteorder.h>
+
+typedef volatile __u32 nlm_reg_t;
+extern unsigned long netlogic_io_base;
+
+/* FIXME read once in write_reg */
+#ifdef CONFIG_CPU_LITTLE_ENDIAN
+#define netlogic_read_reg(base, offset)		((base)[(offset)])
+#define netlogic_write_reg(base, offset, value)	((base)[(offset)] = (value))
+#else
+#define netlogic_read_reg(base, offset)		(be32_to_cpu((base)[(offset)]))
+#define netlogic_write_reg(base, offset, value) \
+				((base)[(offset)] = cpu_to_be32((value)))
+#endif
+
+#define netlogic_read_reg_le32(base, offset) (le32_to_cpu((base)[(offset)]))
+#define netlogic_write_reg_le32(base, offset, value) \
+				((base)[(offset)] = cpu_to_le32((value)))
+#define netlogic_io_mmio(offset) ((nlm_reg_t *)(netlogic_io_base+(offset)))
+#endif /* __ASSEMBLY__ */
+#endif
diff --git a/arch/mips/include/asm/netlogic/xlr/pic.h b/arch/mips/include/asm/netlogic/xlr/pic.h
new file mode 100644
index 0000000..61da78d
--- /dev/null
+++ b/arch/mips/include/asm/netlogic/xlr/pic.h
@@ -0,0 +1,225 @@
+/*
+ * Copyright 2003-2011 Netlogic Microsystems (Netlogic). All rights
+ * reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are
+ * met:
+ *
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in
+ *    the documentation and/or other materials provided with the
+ *    distribution.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Netlogic Microsystems ``AS IS'' AND
+ * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
+ * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL NETLOGIC OR CONTRIBUTORS BE
+ * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
+ * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
+ * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
+ * THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#ifndef _ASM_NLM_XLR_PIC_H
+#define _ASM_NLM_XLR_PIC_H
+
+#define PIC_CLKS_PER_SEC		66666666ULL
+/* PIC hardware interrupt numbers */
+#define PIC_IRT_WD_INDEX		0
+#define PIC_IRT_TIMER_0_INDEX		1
+#define PIC_IRT_TIMER_1_INDEX		2
+#define PIC_IRT_TIMER_2_INDEX		3
+#define PIC_IRT_TIMER_3_INDEX		4
+#define PIC_IRT_TIMER_4_INDEX		5
+#define PIC_IRT_TIMER_5_INDEX		6
+#define PIC_IRT_TIMER_6_INDEX		7
+#define PIC_IRT_TIMER_7_INDEX		8
+#define PIC_IRT_CLOCK_INDEX		PIC_IRT_TIMER_7_INDEX
+#define PIC_IRT_UART_0_INDEX		9
+#define PIC_IRT_UART_1_INDEX		10
+#define PIC_IRT_I2C_0_INDEX		11
+#define PIC_IRT_I2C_1_INDEX		12
+#define PIC_IRT_PCMCIA_INDEX		13
+#define PIC_IRT_GPIO_INDEX		14
+#define PIC_IRT_HYPER_INDEX		15
+#define PIC_IRT_PCIX_INDEX		16
+/* XLS */
+#define PIC_IRT_CDE_INDEX		15
+#define PIC_IRT_BRIDGE_TB_XLS_INDEX	16
+/* XLS */
+#define PIC_IRT_GMAC0_INDEX		17
+#define PIC_IRT_GMAC1_INDEX		18
+#define PIC_IRT_GMAC2_INDEX		19
+#define PIC_IRT_GMAC3_INDEX		20
+#define PIC_IRT_XGS0_INDEX		21
+#define PIC_IRT_XGS1_INDEX		22
+#define PIC_IRT_HYPER_FATAL_INDEX	23
+#define PIC_IRT_PCIX_FATAL_INDEX	24
+#define PIC_IRT_BRIDGE_AERR_INDEX	25
+#define PIC_IRT_BRIDGE_BERR_INDEX	26
+#define PIC_IRT_BRIDGE_TB_XLR_INDEX	27
+#define PIC_IRT_BRIDGE_AERR_NMI_INDEX	28
+/* XLS */
+#define PIC_IRT_GMAC4_INDEX		21
+#define PIC_IRT_GMAC5_INDEX		22
+#define PIC_IRT_GMAC6_INDEX		23
+#define PIC_IRT_GMAC7_INDEX		24
+#define PIC_IRT_BRIDGE_ERR_INDEX	25
+#define PIC_IRT_PCIE_LINK0_INDEX	26
+#define PIC_IRT_PCIE_LINK1_INDEX	27
+#define PIC_IRT_PCIE_LINK2_INDEX	23
+#define PIC_IRT_PCIE_LINK3_INDEX	24
+#define PIC_IRT_PCIE_XLSB0_LINK2_INDEX	28
+#define PIC_IRT_PCIE_XLSB0_LINK3_INDEX	29
+#define PIC_IRT_SRIO_LINK0_INDEX	26
+#define PIC_IRT_SRIO_LINK1_INDEX	27
+#define PIC_IRT_SRIO_LINK2_INDEX	28
+#define PIC_IRT_SRIO_LINK3_INDEX	29
+#define PIC_IRT_PCIE_INT_INDEX		28
+#define PIC_IRT_PCIE_FATAL_INDEX	29
+#define PIC_IRT_GPIO_B_INDEX		30
+#define PIC_IRT_USB_INDEX		31
+/* XLS */
+#define PIC_NUM_IRTS			32
+
+
+#define PIC_CLOCK_TIMER			7
+
+/* PIC Registers */
+#define PIC_CTRL			0x00
+#define PIC_IPI				0x04
+#define PIC_INT_ACK			0x06
+
+#define WD_MAX_VAL_0			0x08
+#define WD_MAX_VAL_1			0x09
+#define WD_MASK_0			0x0a
+#define WD_MASK_1			0x0b
+#define WD_HEARBEAT_0			0x0c
+#define WD_HEARBEAT_1			0x0d
+
+#define PIC_IRT_0_BASE			0x40
+#define PIC_IRT_1_BASE			0x80
+#define PIC_TIMER_MAXVAL_0_BASE		0x100
+#define PIC_TIMER_MAXVAL_1_BASE		0x110
+#define PIC_TIMER_COUNT_0_BASE		0x120
+#define PIC_TIMER_COUNT_1_BASE		0x130
+
+#define PIC_IRT_0(picintr)      (PIC_IRT_0_BASE + (picintr))
+#define PIC_IRT_1(picintr)	(PIC_IRT_1_BASE + (picintr))
+
+#define PIC_TIMER_MAXVAL_0(i)	(PIC_TIMER_MAXVAL_0_BASE + (i))
+#define PIC_TIMER_MAXVAL_1(i)	(PIC_TIMER_MAXVAL_1_BASE + (i))
+#define PIC_TIMER_COUNT_0(i)	(PIC_TIMER_COUNT_0_BASE + (i))
+#define PIC_TIMER_COUNT_1(i)	(PIC_TIMER_COUNT_0_BASE + (i))
+
+/*
+ * Mapping between hardware interrupt numbers and IRQs on CPU
+ * we use a simple scheme to map PIC interrupts 0-31 to IRQs
+ * 8-39. This leaves the IRQ 0-7 for cpu interrupts like
+ * count/compare and FMN
+ */
+#define PIC_IRQ_BASE            8
+#define PIC_INTR_TO_IRQ(i)      (PIC_IRQ_BASE + (i))
+#define PIC_IRQ_TO_INTR(i)      ((i) - PIC_IRQ_BASE)
+
+#define PIC_IRT_FIRST_IRQ	PIC_IRQ_BASE
+#define PIC_WD_IRQ		PIC_INTR_TO_IRQ(PIC_IRT_WD_INDEX)
+#define PIC_TIMER_0_IRQ		PIC_INTR_TO_IRQ(PIC_IRT_TIMER_0_INDEX)
+#define PIC_TIMER_1_IRQ		PIC_INTR_TO_IRQ(PIC_IRT_TIMER_1_INDEX)
+#define PIC_TIMER_2_IRQ		PIC_INTR_TO_IRQ(PIC_IRT_TIMER_2_INDEX)
+#define PIC_TIMER_3_IRQ		PIC_INTR_TO_IRQ(PIC_IRT_TIMER_3_INDEX)
+#define PIC_TIMER_4_IRQ		PIC_INTR_TO_IRQ(PIC_IRT_TIMER_4_INDEX)
+#define PIC_TIMER_5_IRQ		PIC_INTR_TO_IRQ(PIC_IRT_TIMER_5_INDEX)
+#define PIC_TIMER_6_IRQ		PIC_INTR_TO_IRQ(PIC_IRT_TIMER_6_INDEX)
+#define PIC_TIMER_7_IRQ		PIC_INTR_TO_IRQ(PIC_IRT_TIMER_7_INDEX)
+#define PIC_CLOCK_IRQ		(PIC_TIMER_7_IRQ)
+#define PIC_UART_0_IRQ		PIC_INTR_TO_IRQ(PIC_IRT_UART_0_INDEX)
+#define PIC_UART_1_IRQ		PIC_INTR_TO_IRQ(PIC_IRT_UART_1_INDEX)
+#define PIC_I2C_0_IRQ		PIC_INTR_TO_IRQ(PIC_IRT_I2C_0_INDEX)
+#define PIC_I2C_1_IRQ		PIC_INTR_TO_IRQ(PIC_IRT_I2C_1_INDEX)
+#define PIC_PCMCIA_IRQ		PIC_INTR_TO_IRQ(PIC_IRT_PCMCIA_INDEX)
+#define PIC_GPIO_IRQ		PIC_INTR_TO_IRQ(PIC_IRT_GPIO_INDEX)
+#define PIC_HYPER_IRQ		PIC_INTR_TO_IRQ(PIC_IRT_HYPER_INDEX)
+#define PIC_PCIX_IRQ		PIC_INTR_TO_IRQ(PIC_IRT_PCIX_INDEX)
+/* XLS */
+#define PIC_CDE_IRQ		PIC_INTR_TO_IRQ(PIC_IRT_CDE_INDEX)
+#define PIC_BRIDGE_TB_XLS_IRQ	PIC_INTR_TO_IRQ(PIC_IRT_BRIDGE_TB_XLS_INDEX)
+/* end XLS */
+#define PIC_GMAC_0_IRQ		PIC_INTR_TO_IRQ(PIC_IRT_GMAC0_INDEX)
+#define PIC_GMAC_1_IRQ		PIC_INTR_TO_IRQ(PIC_IRT_GMAC1_INDEX)
+#define PIC_GMAC_2_IRQ		PIC_INTR_TO_IRQ(PIC_IRT_GMAC2_INDEX)
+#define PIC_GMAC_3_IRQ		PIC_INTR_TO_IRQ(PIC_IRT_GMAC3_INDEX)
+#define PIC_XGS_0_IRQ		PIC_INTR_TO_IRQ(PIC_IRT_XGS0_INDEX)
+#define PIC_XGS_1_IRQ		PIC_INTR_TO_IRQ(PIC_IRT_XGS1_INDEX)
+#define PIC_HYPER_FATAL_IRQ	PIC_INTR_TO_IRQ(PIC_IRT_HYPER_FATAL_INDEX)
+#define PIC_PCIX_FATAL_IRQ	PIC_INTR_TO_IRQ(PIC_IRT_PCIX_FATAL_INDEX)
+#define PIC_BRIDGE_AERR_IRQ	PIC_INTR_TO_IRQ(PIC_IRT_BRIDGE_AERR_INDEX)
+#define PIC_BRIDGE_BERR_IRQ	PIC_INTR_TO_IRQ(PIC_IRT_BRIDGE_BERR_INDEX)
+#define PIC_BRIDGE_TB_XLR_IRQ	PIC_INTR_TO_IRQ(PIC_IRT_BRIDGE_TB_XLR_INDEX)
+#define PIC_BRIDGE_AERR_NMI_IRQ	PIC_INTR_TO_IRQ(PIC_IRT_BRIDGE_AERR_NMI_INDEX)
+/* XLS defines */
+#define PIC_GMAC_4_IRQ		PIC_INTR_TO_IRQ(PIC_IRT_GMAC4_INDEX)
+#define PIC_GMAC_5_IRQ		PIC_INTR_TO_IRQ(PIC_IRT_GMAC5_INDEX)
+#define PIC_GMAC_6_IRQ		PIC_INTR_TO_IRQ(PIC_IRT_GMAC6_INDEX)
+#define PIC_GMAC_7_IRQ		PIC_INTR_TO_IRQ(PIC_IRT_GMAC7_INDEX)
+#define PIC_BRIDGE_ERR_IRQ	PIC_INTR_TO_IRQ(PIC_IRT_BRIDGE_ERR_INDEX)
+#define PIC_PCIE_LINK0_IRQ	PIC_INTR_TO_IRQ(PIC_IRT_PCIE_LINK0_INDEX)
+#define PIC_PCIE_LINK1_IRQ	PIC_INTR_TO_IRQ(PIC_IRT_PCIE_LINK1_INDEX)
+#define PIC_PCIE_LINK2_IRQ	PIC_INTR_TO_IRQ(PIC_IRT_PCIE_LINK2_INDEX)
+#define PIC_PCIE_LINK3_IRQ	PIC_INTR_TO_IRQ(PIC_IRT_PCIE_LINK3_INDEX)
+#define PIC_PCIE_XLSB0_LINK2_IRQ PIC_INTR_TO_IRQ(PIC_IRT_PCIE_XLSB0_LINK2_INDEX)
+#define PIC_PCIE_XLSB0_LINK3_IRQ PIC_INTR_TO_IRQ(PIC_IRT_PCIE_XLSB0_LINK3_INDEX)
+#define PIC_SRIO_LINK0_IRQ	PIC_INTR_TO_IRQ(PIC_IRT_SRIO_LINK0_INDEX)
+#define PIC_SRIO_LINK1_IRQ	PIC_INTR_TO_IRQ(PIC_IRT_SRIO_LINK1_INDEX)
+#define PIC_SRIO_LINK2_IRQ	PIC_INTR_TO_IRQ(PIC_IRT_SRIO_LINK2_INDEX)
+#define PIC_SRIO_LINK3_IRQ	PIC_INTR_TO_IRQ(PIC_IRT_SRIO_LINK3_INDEX)
+#define PIC_PCIE_INT_IRQ	PIC_INTR_TO_IRQ(PIC_IRT_PCIE_INT__INDEX)
+#define PIC_PCIE_FATAL_IRQ	PIC_INTR_TO_IRQ(PIC_IRT_PCIE_FATAL_INDEX)
+#define PIC_GPIO_B_IRQ		PIC_INTR_TO_IRQ(PIC_IRT_GPIO_B_INDEX)
+#define PIC_USB_IRQ		PIC_INTR_TO_IRQ(PIC_IRT_USB_INDEX)
+#define PIC_IRT_LAST_IRQ	PIC_USB_IRQ
+/* end XLS */
+
+#ifndef __ASSEMBLY__
+static inline void pic_send_ipi(u32 ipi)
+{
+	nlm_reg_t *mmio = netlogic_io_mmio(NETLOGIC_IO_PIC_OFFSET);
+
+	netlogic_write_reg(mmio, PIC_IPI, ipi);
+}
+
+static inline u32 pic_read_control(void)
+{
+	nlm_reg_t *mmio = netlogic_io_mmio(NETLOGIC_IO_PIC_OFFSET);
+
+	return netlogic_read_reg(mmio, PIC_CTRL);
+}
+
+static inline void pic_write_control(u32 control)
+{
+	nlm_reg_t *mmio = netlogic_io_mmio(NETLOGIC_IO_PIC_OFFSET);
+
+	netlogic_write_reg(mmio, PIC_CTRL, control);
+}
+
+static inline void pic_update_control(u32 control)
+{
+	nlm_reg_t *mmio = netlogic_io_mmio(NETLOGIC_IO_PIC_OFFSET);
+
+	netlogic_write_reg(mmio, PIC_CTRL,
+		(control | netlogic_read_reg(mmio, PIC_CTRL)));
+}
+
+#define PIC_IRQ_IS_EDGE_TRIGGERED(irq)	(((irq) >= PIC_TIMER_0_IRQ) && \
+					((irq) <= PIC_TIMER_7_IRQ))
+#define PIC_IRQ_IS_IRT(irq)		(((irq) >= PIC_IRT_FIRST_IRQ) && \
+					((irq) <= PIC_IRT_LAST_IRQ))
+#endif
+
+#endif /* _ASM_NLM_XLR_PIC_H */
diff --git a/arch/mips/include/asm/netlogic/xlr/xlr.h b/arch/mips/include/asm/netlogic/xlr/xlr.h
new file mode 100644
index 0000000..174bbdd
--- /dev/null
+++ b/arch/mips/include/asm/netlogic/xlr/xlr.h
@@ -0,0 +1,20 @@
+#ifndef _ASM_NLM_XLR_H
+#define _ASM_NLM_XLR_H
+
+/* Platform UART functions */
+struct uart_port;
+unsigned int nlm_xlr_uart_in(struct uart_port *, int);
+void nlm_xlr_uart_out(struct uart_port *, int, int);
+
+/* SMP support functions */
+void nlm_smp_function_ipi_handler(unsigned int irq, struct irq_desc *desc);
+void nlm_smp_resched_ipi_handler(unsigned int irq, struct irq_desc *desc);
+int nlm_wakeup_secondary_cpus(u32 wakeup_mask);
+void nlm_smp_irq_init(void);
+void nlm_boot_smp_nmi(void);
+void prom_pre_boot_secondary_cpus(void);
+
+extern struct plat_smp_ops nlm_smp_ops;
+extern unsigned long nlm_common_ebase;
+
+#endif /* _ASM_NLM_XLR_H */
diff --git a/arch/mips/netlogic/xlr/irq.c b/arch/mips/netlogic/xlr/irq.c
new file mode 100644
index 0000000..a979efe
--- /dev/null
+++ b/arch/mips/netlogic/xlr/irq.c
@@ -0,0 +1,251 @@
+/*
+ * Copyright 2003-2011 Netlogic Microsystems (Netlogic). All rights
+ * reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are
+ * met:
+ *
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in
+ *    the documentation and/or other materials provided with the
+ *    distribution.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Netlogic Microsystems ``AS IS'' AND
+ * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
+ * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL NETLOGIC OR CONTRIBUTORS BE
+ * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
+ * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
+ * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
+ * THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/linkage.h>
+#include <linux/interrupt.h>
+#include <linux/spinlock.h>
+#include <linux/mm.h>
+
+#include <asm/mipsregs.h>
+
+#include <asm/netlogic/xlr/iomap.h>
+#include <asm/netlogic/xlr/pic.h>
+#include <asm/netlogic/xlr/xlr.h>
+
+#include <asm/netlogic/interrupt.h>
+#include <asm/netlogic/mips-extns.h>
+
+static u64 nlm_irq_mask;
+static DEFINE_SPINLOCK(nlm_pic_lock);
+
+static void pic_unmask(unsigned int irq)
+{
+	nlm_reg_t *mmio = netlogic_io_mmio(NETLOGIC_IO_PIC_OFFSET);
+	unsigned long flags;
+	nlm_reg_t reg;
+
+	if (!PIC_IRQ_IS_IRT(irq))
+		return;
+
+	spin_lock_irqsave(&nlm_pic_lock, flags);
+	reg = netlogic_read_reg(mmio, PIC_IRT_1_BASE + irq - PIC_IRQ_BASE);
+	netlogic_write_reg(mmio, PIC_IRT_1_BASE + irq - PIC_IRQ_BASE,
+			  reg | (1 << 6) | (1 << 30) | (1 << 31));
+	spin_unlock_irqrestore(&nlm_pic_lock, flags);
+
+	return;
+}
+
+static void pic_ack(unsigned int irq)
+{
+	unsigned long flags;
+	nlm_reg_t *mmio;
+
+	if (!PIC_IRQ_IS_IRT(irq))
+		return;
+
+	mmio = netlogic_io_mmio(NETLOGIC_IO_PIC_OFFSET);
+	spin_lock_irqsave(&nlm_pic_lock, flags);
+	netlogic_write_reg(mmio, PIC_INT_ACK, (1 << (irq - PIC_IRQ_BASE)));
+	spin_unlock_irqrestore(&nlm_pic_lock, flags);
+}
+
+static void pic_end(unsigned int irq)
+{
+	unsigned long flags;
+	nlm_reg_t *mmio;
+
+	if (!PIC_IRQ_IS_IRT(irq))
+		return;
+
+	if (PIC_IRQ_IS_EDGE_TRIGGERED(irq))
+		return;
+
+	/* If level triggered, ack it after the device condition is cleared */
+	mmio = netlogic_io_mmio(NETLOGIC_IO_PIC_OFFSET);
+	spin_lock_irqsave(&nlm_pic_lock, flags);
+	netlogic_write_reg(mmio, PIC_INT_ACK, (1 << (irq - PIC_IRQ_BASE)));
+	spin_unlock_irqrestore(&nlm_pic_lock, flags);
+}
+
+static void pic_shutdown(unsigned int irq)
+{
+	nlm_reg_t *mmio;
+	unsigned long flags;
+	nlm_reg_t reg;
+
+	if (!PIC_IRQ_IS_IRT(irq))
+		return;
+
+	mmio = netlogic_io_mmio(NETLOGIC_IO_PIC_OFFSET);
+	spin_lock_irqsave(&nlm_pic_lock, flags);
+	reg = netlogic_read_reg(mmio, PIC_IRT_1_BASE + irq - PIC_IRQ_BASE);
+	netlogic_write_reg(mmio, PIC_IRT_1_BASE + irq - PIC_IRQ_BASE,
+			  (reg & ~(1 << 31)));
+	spin_unlock_irqrestore(&nlm_pic_lock, flags);
+}
+
+static int pic_set_affinity(unsigned int irq, const struct cpumask *mask)
+{
+	nlm_reg_t *mmio;
+	unsigned long flags;
+
+	if (!PIC_IRQ_IS_IRT(irq))
+		return -1;
+
+	mmio = netlogic_io_mmio(NETLOGIC_IO_PIC_OFFSET);
+	spin_lock_irqsave(&nlm_pic_lock, flags);
+	netlogic_write_reg(mmio, PIC_IRT_0_BASE + irq - PIC_IRQ_BASE,
+			  (uint32_t)(mask->bits[0]));
+	spin_unlock_irqrestore(&nlm_pic_lock, flags);
+
+	return 0;
+}
+
+static struct irq_chip xlr_pic = {
+	.name	= "XLR-PIC",
+	.unmask = pic_unmask,
+	.mask	= pic_shutdown,
+	.ack	= pic_ack,
+	.end	= pic_end,
+	.set_affinity = pic_set_affinity
+};
+
+static void rsvd_pic_handler_1(unsigned int irq)
+{
+	WARN_ON(irq >= PIC_IRQ_BASE);
+	return;
+}
+
+static int rsvd_pic_handler_2(unsigned int irq, const struct cpumask *mask)
+{
+	if (irq < PIC_IRQ_BASE)
+		return -1;
+
+	BUG();
+	return 0;
+}
+
+struct irq_chip nlm_rsvd_pic = {
+	.name   = "XLR-RSVD-PIC",
+	.unmask = rsvd_pic_handler_1,
+	.mask   = rsvd_pic_handler_1,
+	.ack    = rsvd_pic_handler_1,
+	.end    = rsvd_pic_handler_1,
+	.set_affinity =	rsvd_pic_handler_2
+};
+
+void __init init_xlr_irqs(void)
+{
+	nlm_reg_t *mmio = netlogic_io_mmio(NETLOGIC_IO_PIC_OFFSET);
+	uint32_t thread_mask = 1;
+	int level, i;
+
+	pr_info("Interrupt thread mask [%x]\n", thread_mask);
+	for (i = 0; i < PIC_NUM_IRTS; i++) {
+		level = PIC_IRQ_IS_EDGE_TRIGGERED(i);
+
+		/* Bind all PIC irqs to boot cpu */
+		netlogic_write_reg(mmio, PIC_IRT_0_BASE + i, thread_mask);
+
+		/*
+		 * Use local scheduling and high polarity for all IRTs
+		 * Invalidate all IRTs, by default
+		 */
+		netlogic_write_reg(mmio, PIC_IRT_1_BASE + i,
+				(level << 30) | (1 << 6) | (PIC_IRQ_BASE + i));
+	}
+
+	/* Make all IRQs as level triggered by default */
+	for (i = 0; i < NR_IRQS; i++)
+		set_irq_chip_and_handler(i, &xlr_pic, handle_level_irq);
+
+#ifdef CONFIG_SMP
+	set_irq_chip_and_handler(IRQ_IPI_SMP_FUNCTION, &nlm_rsvd_pic,
+			 nlm_smp_function_ipi_handler);
+	set_irq_chip_and_handler(IRQ_IPI_SMP_RESCHEDULE, &nlm_rsvd_pic,
+			 nlm_smp_resched_ipi_handler);
+	nlm_irq_mask |=
+	    ((1ULL << IRQ_IPI_SMP_FUNCTION) | (1ULL << IRQ_IPI_SMP_RESCHEDULE));
+#endif
+
+	/* unmask all PIC related interrupts. If no handler is installed by the
+	 * drivers, it'll just ack the interrupt and return
+	 */
+	for (i = PIC_IRT_FIRST_IRQ; i <= PIC_IRT_LAST_IRQ; i++)
+		nlm_irq_mask |= (1ULL << i);
+
+	nlm_irq_mask |= (1ULL << IRQ_TIMER);
+}
+
+void __init arch_init_irq(void)
+{
+	/* Initialize the irq descriptors */
+	init_xlr_irqs();
+	write_c0_eimr(nlm_irq_mask);
+}
+
+void __cpuinit nlm_smp_irq_init(void)
+{
+	/* set interrupt mask for non-zero cpus */
+	write_c0_eimr(nlm_irq_mask);
+}
+
+asmlinkage void plat_irq_dispatch(void)
+{
+	uint64_t eirr;
+	int i;
+
+	eirr = read_c0_eirr() & read_c0_eimr();
+	if (!eirr)
+		return;
+
+	/* no need of EIRR here, writing compare clears interrupt */
+	if (eirr & (1 << IRQ_TIMER)) {
+		do_IRQ(IRQ_TIMER);
+		return;
+	}
+
+	/* TODO use dcltz: optimize below code */
+	for (i = 63; i != -1; i--) {
+		if (eirr & (1ULL << i))
+			break;
+	}
+	if (i == -1) {
+		pr_err("no interrupt !!\n");
+		return;
+	}
+
+	/* Ack eirr */
+	write_c0_eirr(1ULL << i);
+
+	do_IRQ(i);
+	return;
+}
diff --git a/arch/mips/netlogic/xlr/platform.c b/arch/mips/netlogic/xlr/platform.c
new file mode 100644
index 0000000..09d484d
--- /dev/null
+++ b/arch/mips/netlogic/xlr/platform.c
@@ -0,0 +1,99 @@
+/*
+ * Copyright 2011, Netlogic Microsystems.
+ * Copyright 2004, Matt Porter <mporter@kernel.crashing.org>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/resource.h>
+#include <linux/serial_8250.h>
+#include <linux/serial_reg.h>
+
+#include <asm/netlogic/xlr/iomap.h>
+#include <asm/netlogic/xlr/pic.h>
+#include <asm/netlogic/xlr/xlr.h>
+
+unsigned int nlm_xlr_uart_in(struct uart_port *p, int offset)
+{
+	nlm_reg_t *mmio;
+	unsigned int value;
+
+	/* XLR uart does not need any mapping of regs */
+	mmio = (nlm_reg_t *)(p->membase + (offset << p->regshift));
+	value = netlogic_read_reg(mmio, 0);
+
+	/* See XLR/XLS errata */
+	if (offset == UART_MSR)
+		value ^= 0xF0;
+	else if (offset == UART_MCR)
+		value ^= 0x3;
+
+	return value;
+}
+
+void nlm_xlr_uart_out(struct uart_port *p, int offset, int value)
+{
+	nlm_reg_t *mmio;
+
+	/* XLR uart does not need any mapping of regs */
+	mmio = (nlm_reg_t *)(p->membase + (offset << p->regshift));
+
+	/* See XLR/XLS errata */
+	if (offset == UART_MSR)
+		value ^= 0xF0;
+	else if (offset == UART_MCR)
+		value ^= 0x3;
+
+	netlogic_write_reg(mmio, 0, value);
+}
+
+#define PORT(_irq)					\
+	{						\
+		.irq		= _irq,			\
+		.regshift	= 2,			\
+		.iotype		= UPIO_MEM32,		\
+		.flags		= (UPF_SKIP_TEST |	\
+			 UPF_FIXED_TYPE | UPF_BOOT_AUTOCONF),\
+		.uartclk	= PIC_CLKS_PER_SEC,	\
+		.type		= PORT_16550A,		\
+		.serial_in	= nlm_xlr_uart_in,	\
+		.serial_out	= nlm_xlr_uart_out,	\
+	}
+
+static struct plat_serial8250_port xlr_uart_data[] = {
+	PORT(PIC_UART_0_IRQ),
+	PORT(PIC_UART_1_IRQ),
+	{},
+};
+
+static struct platform_device uart_device = {
+	.name		= "serial8250",
+	.id		= PLAT8250_DEV_PLATFORM,
+	.dev = {
+		.platform_data = xlr_uart_data,
+	},
+};
+
+static int __init nlm_uart_init(void)
+{
+	nlm_reg_t *mmio;
+
+	mmio = netlogic_io_mmio(NETLOGIC_IO_UART_0_OFFSET);
+	xlr_uart_data[0].iobase = (unsigned long)mmio;
+	xlr_uart_data[0].membase = (void __iomem *)mmio;
+	xlr_uart_data[0].mapbase = (unsigned long)mmio;
+
+	mmio = netlogic_io_mmio(NETLOGIC_IO_UART_1_OFFSET);
+	xlr_uart_data[1].iobase = (unsigned long)mmio;
+	xlr_uart_data[1].membase = (void __iomem *)mmio;
+	xlr_uart_data[1].mapbase = (unsigned long)mmio;
+
+	return platform_device_register(&uart_device);
+}
+
+arch_initcall(nlm_uart_init);
diff --git a/arch/mips/netlogic/xlr/setup.c b/arch/mips/netlogic/xlr/setup.c
new file mode 100644
index 0000000..f3ca52a
--- /dev/null
+++ b/arch/mips/netlogic/xlr/setup.c
@@ -0,0 +1,182 @@
+/*
+ * Copyright 2003-2011 Netlogic Microsystems (Netlogic). All rights
+ * reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are
+ * met:
+ *
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in
+ *    the documentation and/or other materials provided with the
+ *    distribution.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Netlogic Microsystems ``AS IS'' AND
+ * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
+ * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL NETLOGIC OR CONTRIBUTORS BE
+ * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
+ * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
+ * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
+ * THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#include <linux/kernel.h>
+#include <linux/serial_8250.h>
+#include <linux/pm.h>
+
+#include <asm/reboot.h>
+#include <asm/time.h>
+#include <asm/bootinfo.h>
+#include <asm/smp-ops.h>
+
+#include <asm/netlogic/interrupt.h>
+#include <asm/netlogic/psb-bootinfo.h>
+
+#include <asm/netlogic/xlr/xlr.h>
+#include <asm/netlogic/xlr/iomap.h>
+#include <asm/netlogic/xlr/pic.h>
+#include <asm/netlogic/xlr/gpio.h>
+
+unsigned long netlogic_io_base = (unsigned long)(DEFAULT_NETLOGIC_IO_BASE);
+unsigned long nlm_common_ebase = 0x0;
+struct psb_info nlm_prom_info;
+
+static void nlm_early_serial_setup(void)
+{
+	struct uart_port s;
+	nlm_reg_t *uart_base;
+
+	uart_base = netlogic_io_mmio(NETLOGIC_IO_UART_0_OFFSET);
+	memset(&s, 0, sizeof(s));
+	s.flags		= ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST;
+	s.iotype	= UPIO_MEM32;
+	s.regshift	= 2;
+	s.irq		= PIC_UART_0_IRQ;
+	s.uartclk	= PIC_CLKS_PER_SEC;
+	s.serial_in	= nlm_xlr_uart_in;
+	s.serial_out	= nlm_xlr_uart_out;
+	s.mapbase	= (unsigned long)uart_base;
+	s.membase	= (unsigned char __iomem *)uart_base;
+	early_serial_setup(&s);
+}
+
+static void nlm_linux_exit(void)
+{
+	nlm_reg_t *mmio;
+
+	mmio = netlogic_io_mmio(NETLOGIC_IO_GPIO_OFFSET);
+	/* trigger a chip reset by writing 1 to GPIO_SWRESET_REG */
+	netlogic_write_reg(mmio, NETLOGIC_GPIO_SWRESET_REG, 1);
+	for ( ; ; )
+		cpu_wait();
+}
+
+void __init plat_mem_setup(void)
+{
+	panic_timeout	= 5;
+	_machine_restart = (void (*)(char *))nlm_linux_exit;
+	_machine_halt	= nlm_linux_exit;
+	pm_power_off	= nlm_linux_exit;
+}
+
+const char *get_system_type(void)
+{
+	return "Netlogic XLR/XLS Series";
+}
+
+void __init prom_free_prom_memory(void)
+{
+	/* Nothing yet */
+}
+
+static void build_arcs_cmdline(int *argv)
+{
+	int i, remain, len;
+	char *arg;
+
+	remain = sizeof(arcs_cmdline) - 1;
+	arcs_cmdline[0] = '\0';
+	for (i = 0; argv[i] != 0; i++) {
+		arg = (char *)(long)argv[i];
+		len = strlen(arg);
+		if (len + 1 > remain)
+			break;
+		strcat(arcs_cmdline, arg);
+		strcat(arcs_cmdline, " ");
+		remain -=  len + 1;
+	}
+
+	/* Add the default options here */
+	if ((strstr(arcs_cmdline, "console=")) == NULL) {
+		arg = "console=ttyS0,38400 ";
+		len = strlen(arg);
+		if (len > remain)
+			goto fail;
+		strcat(arcs_cmdline, arg);
+		remain -= len;
+	}
+#ifdef CONFIG_BLK_DEV_INITRD
+	if ((strstr(arcs_cmdline, "rdinit=")) == NULL) {
+		arg = "rdinit=/sbin/init ";
+		len = strlen(arg);
+		if (len > remain)
+			goto fail;
+		strcat(arcs_cmdline, arg);
+		remain -= len;
+	}
+#endif
+	return;
+fail:
+	panic("Cannot add %s, command line too big!", arg);
+}
+
+static void prom_add_memory(void)
+{
+	struct nlm_boot_mem_map *bootm;
+	u64 start, size;
+	u64 pref_backup = 512;  /* avoid pref walking beyond end */
+	int i;
+
+	bootm = (void *)(long)nlm_prom_info.psb_mem_map;
+	for (i = 0; i < bootm->nr_map; i++) {
+		if (bootm->map[i].type != BOOT_MEM_RAM)
+			continue;
+		start = bootm->map[i].addr;
+		size   = bootm->map[i].size;
+
+		/* Work around for using bootloader mem */
+		if (i == 0 && start == 0 && size == 0x0c000000)
+			size = 0x0ff00000;
+
+		add_memory_region(start, size - pref_backup, BOOT_MEM_RAM);
+	}
+}
+
+void __init prom_init(void)
+{
+	int *argv, *envp;		/* passed as 32 bit ptrs */
+	struct psb_info *prom_infop;
+
+	/* truncate to 32 bit and sign extend all args */
+	argv = (int *)(long)(int)fw_arg1;
+	envp = (int *)(long)(int)fw_arg2;
+	prom_infop = (struct psb_info *)(long)(int)fw_arg3;
+
+	nlm_prom_info = *prom_infop;
+
+	nlm_early_serial_setup();
+	build_arcs_cmdline(argv);
+	nlm_common_ebase = read_c0_ebase() & (~((1 << 12) - 1));
+	prom_add_memory();
+
+#ifdef CONFIG_SMP
+	nlm_wakeup_secondary_cpus(nlm_prom_info.online_cpu_map);
+	register_smp_ops(&nlm_smp_ops);
+#endif
+}
diff --git a/arch/mips/netlogic/xlr/smp.c b/arch/mips/netlogic/xlr/smp.c
new file mode 100644
index 0000000..0c3b6d0
--- /dev/null
+++ b/arch/mips/netlogic/xlr/smp.c
@@ -0,0 +1,219 @@
+/*
+ * Copyright 2003-2011 Netlogic Microsystems (Netlogic). All rights
+ * reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are
+ * met:
+ *
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in
+ *    the documentation and/or other materials provided with the
+ *    distribution.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Netlogic Microsystems ``AS IS'' AND
+ * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
+ * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL NETLOGIC OR CONTRIBUTORS BE
+ * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
+ * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
+ * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
+ * THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/smp.h>
+#include <linux/irq.h>
+
+#include <asm/mmu_context.h>
+
+#include <asm/netlogic/interrupt.h>
+#include <asm/netlogic/mips-extns.h>
+
+#include <asm/netlogic/xlr/iomap.h>
+#include <asm/netlogic/xlr/pic.h>
+#include <asm/netlogic/xlr/xlr.h>
+
+void core_send_ipi(int logical_cpu, unsigned int action)
+{
+	int cpu = cpu_logical_map(logical_cpu);
+	u32 tid = cpu & 0x3;
+	u32 pid = (cpu >> 2) & 0x07;
+	u32 ipi = (tid << 16) | (pid << 20);
+
+	if (action & SMP_CALL_FUNCTION)
+		ipi |= IRQ_IPI_SMP_FUNCTION;
+	else if (action & SMP_RESCHEDULE_YOURSELF)
+		ipi |= IRQ_IPI_SMP_RESCHEDULE;
+	else
+		return;
+
+	pic_send_ipi(ipi);
+}
+
+void nlm_send_ipi_single(int cpu, unsigned int action)
+{
+	core_send_ipi(cpu, action);
+}
+
+void nlm_send_ipi_mask(const struct cpumask *mask, unsigned int action)
+{
+	int cpu;
+
+	for_each_cpu(cpu, mask) {
+		core_send_ipi(cpu, action);
+	}
+}
+
+/* IRQ_IPI_SMP_FUNCTION Handler */
+void nlm_smp_function_ipi_handler(unsigned int irq, struct irq_desc *desc)
+{
+	smp_call_function_interrupt();
+}
+
+/* IRQ_IPI_SMP_RESCHEDULE  handler */
+void nlm_smp_resched_ipi_handler(unsigned int irq, struct irq_desc *desc)
+{
+	set_need_resched();
+}
+
+void nlm_common_ipi_handler(int irq, struct pt_regs *regs)
+{
+	if (irq == IRQ_IPI_SMP_FUNCTION) {
+		smp_call_function_interrupt();
+	} else {
+		/* Announce that we are for reschduling */
+		set_need_resched();
+	}
+}
+
+/*
+ * Called before going into mips code, early cpu init
+ */
+void nlm_early_init_secondary(void)
+{
+	write_c0_ebase((uint32_t)nlm_common_ebase);
+	/* TLB partition here later */
+}
+
+/*
+ * Code to run on secondary just after probing the CPU
+ */
+static void __cpuinit nlm_init_secondary(void)
+{
+	nlm_smp_irq_init();
+}
+
+void nlm_smp_finish(void)
+{
+#ifdef notyet
+	nlm_common_msgring_cpu_init();
+#endif
+}
+
+void nlm_cpus_done(void)
+{
+}
+
+/*
+ * Boot all other cpus in the system, initialize them, and bring them into
+ * the boot function
+ */
+int nlm_cpu_unblock[NR_CPUS];
+int nlm_cpu_ready[NR_CPUS];
+unsigned long nlm_next_gp;
+unsigned long nlm_next_sp;
+cpumask_t phys_cpu_present_map;
+
+void nlm_boot_secondary(int logical_cpu, struct task_struct *idle)
+{
+	unsigned long gp = (unsigned long)task_thread_info(idle);
+	unsigned long sp = (unsigned long)__KSTK_TOS(idle);
+	int cpu = cpu_logical_map(logical_cpu);
+
+	nlm_next_sp = sp;
+	nlm_next_gp = gp;
+
+	/* barrier */
+	__sync();
+	nlm_cpu_unblock[cpu] = 1;
+}
+
+void __init nlm_smp_setup(void)
+{
+	unsigned int boot_cpu;
+	int num_cpus, i;
+
+	boot_cpu = hard_smp_processor_id();
+	cpus_clear(phys_cpu_present_map);
+
+	cpu_set(boot_cpu, phys_cpu_present_map);
+	__cpu_number_map[boot_cpu] = 0;
+	__cpu_logical_map[0] = boot_cpu;
+	cpu_set(0, cpu_possible_map);
+
+	num_cpus = 1;
+	for (i = 0; i < NR_CPUS; i++) {
+		if (nlm_cpu_ready[i]) {
+			cpu_set(i, phys_cpu_present_map);
+			__cpu_number_map[i] = num_cpus;
+			__cpu_logical_map[num_cpus] = i;
+			cpu_set(num_cpus, cpu_possible_map);
+			++num_cpus;
+		}
+	}
+
+	pr_info("Phys CPU present map: %lx, possible map %lx\n",
+		(unsigned long)phys_cpu_present_map.bits[0],
+		(unsigned long)cpu_possible_map.bits[0]);
+
+	pr_info("Detected %i Slave CPU(s)\n", num_cpus);
+}
+
+void nlm_prepare_cpus(unsigned int max_cpus)
+{
+}
+
+struct plat_smp_ops nlm_smp_ops = {
+	.send_ipi_single	= nlm_send_ipi_single,
+	.send_ipi_mask		= nlm_send_ipi_mask,
+	.init_secondary		= nlm_init_secondary,
+	.smp_finish		= nlm_smp_finish,
+	.cpus_done		= nlm_cpus_done,
+	.boot_secondary		= nlm_boot_secondary,
+	.smp_setup		= nlm_smp_setup,
+	.prepare_cpus		= nlm_prepare_cpus,
+};
+
+unsigned long secondary_entry_point;
+
+int nlm_wakeup_secondary_cpus(u32 wakeup_mask)
+{
+	unsigned int tid, pid, ipi, i, boot_cpu;
+	void *reset_vec;
+
+	secondary_entry_point = (unsigned long)prom_pre_boot_secondary_cpus;
+	reset_vec = (void *)CKSEG1ADDR(0x1fc00000);
+	memcpy(reset_vec, nlm_boot_smp_nmi, 0x80);
+	boot_cpu = hard_smp_processor_id();
+
+	for (i = 0; i < NR_CPUS; i++) {
+		if (i == boot_cpu)
+			continue;
+		if (wakeup_mask & (1u << i)) {
+			tid = i & 0x3;
+			pid = (i >> 2) & 0x7;
+			ipi = (tid << 16) | (pid << 20) | (1 << 8);
+			pic_send_ipi(ipi);
+		}
+	}
+
+	return 0;
+}
diff --git a/arch/mips/netlogic/xlr/smpboot.S b/arch/mips/netlogic/xlr/smpboot.S
new file mode 100644
index 0000000..0ccbc75
--- /dev/null
+++ b/arch/mips/netlogic/xlr/smpboot.S
@@ -0,0 +1,88 @@
+/*
+ * Copyright 2003-2011 Netlogic Microsystems (Netlogic). All rights
+ * reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are
+ * met:
+ *
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in
+ *    the documentation and/or other materials provided with the
+ *    distribution.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Netlogic Microsystems ``AS IS'' AND
+ * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
+ * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL NETLOGIC OR CONTRIBUTORS BE
+ * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
+ * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
+ * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
+ * THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#include <asm/asm.h>
+#include <asm/asm-offsets.h>
+#include <asm/regdef.h>
+#include <asm/mipsregs.h>
+
+
+/* Don't jump to linux function from Bootloader stack. Change it
+ * here. Kernel might allocate bootloader memory before all the CPUs are
+ * brought up (eg: Inode cache region) and we better don't overwrite this
+ * memory
+ */
+NESTED(prom_pre_boot_secondary_cpus, 16, sp)
+	.set	mips64
+	mfc0	t0, $15, 1	# read ebase
+	andi	t0, 0x1f	# t0 has the processor_id()
+	sll	t0, 2		# offset in cpu array
+
+	PTR_LA	t1, nlm_cpu_ready # mark CPU ready
+	PTR_ADDU t1, t0
+	li	t2, 1
+	sw	t2, 0(t1)
+
+	PTR_LA	t1, nlm_cpu_unblock
+	PTR_ADDU t1, t0
+1:	lw	t2, 0(t1)	# wait till unblocked
+	beqz	t2, 1b
+	nop
+
+	PTR_LA	t1, nlm_next_sp
+	PTR_L	sp, 0(t1)
+	PTR_LA	t1, nlm_next_gp
+	PTR_L	gp, 0(t1)
+
+	PTR_LA	t0, nlm_early_init_secondary
+	jalr	t0
+	nop
+
+	PTR_LA	t0, smp_bootstrap
+	jr	t0
+	nop
+END(prom_pre_boot_secondary_cpus)
+
+NESTED(nlm_boot_smp_nmi, 0, sp)
+	.set push
+	.set noat
+	.set mips64
+	.set noreorder
+
+	/* Clear the  NMI and BEV bits */
+	MFC0	k0, CP0_STATUS
+	li 	k1, 0xffb7ffff
+	and	k0, k0, k1
+	MTC0	k0, CP0_STATUS
+
+	PTR_LA  k1, secondary_entry_point
+	PTR_L	k0, 0(k1)
+	jr	k0
+	nop
+	.set pop
+END(nlm_boot_smp_nmi)
diff --git a/arch/mips/netlogic/xlr/time.c b/arch/mips/netlogic/xlr/time.c
new file mode 100644
index 0000000..896b398
--- /dev/null
+++ b/arch/mips/netlogic/xlr/time.c
@@ -0,0 +1,45 @@
+/*
+ * Copyright 2003-2011 Netlogic Microsystems (Netlogic). All rights
+ * reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are
+ * met:
+ *
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in
+ *    the documentation and/or other materials provided with the
+ *    distribution.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Netlogic Microsystems ``AS IS'' AND
+ * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
+ * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL NETLOGIC OR CONTRIBUTORS BE
+ * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
+ * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
+ * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
+ * THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#include <linux/init.h>
+
+#include <asm/time.h>
+#include <asm/netlogic/interrupt.h>
+#include <asm/netlogic/psb-bootinfo.h>
+
+unsigned int __cpuinit get_c0_compare_int(void)
+{
+	return IRQ_TIMER;
+}
+
+void __init plat_time_init(void)
+{
+	mips_hpt_frequency = nlm_prom_info.cpu_frequency;
+	pr_info("MIPS counter frequency [%ld]\n",
+		(unsigned long)mips_hpt_frequency);
+}
diff --git a/arch/mips/netlogic/xlr/xlr_console.c b/arch/mips/netlogic/xlr/xlr_console.c
new file mode 100644
index 0000000..cf8e128
--- /dev/null
+++ b/arch/mips/netlogic/xlr/xlr_console.c
@@ -0,0 +1,40 @@
+/*
+ * Copyright 2003-2011 Netlogic Microsystems (Netlogic). All rights
+ * reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are
+ * met:
+ *
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in
+ *    the documentation and/or other materials provided with the
+ *    distribution.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Netlogic Microsystems ``AS IS'' AND
+ * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
+ * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL NETLOGIC OR CONTRIBUTORS BE
+ * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
+ * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
+ * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
+ * THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#include <linux/types.h>
+#include <asm/netlogic/xlr/iomap.h>
+
+void prom_putchar(char c)
+{
+	nlm_reg_t *mmio;
+
+	mmio = netlogic_io_mmio(NETLOGIC_IO_UART_0_OFFSET);
+	while (netlogic_read_reg(mmio, 0x5) == 0)
+		;
+	netlogic_write_reg(mmio, 0x0, c);
+}
-- 
1.7.1


-- 
Jayachandran C.
jayachandranc@netlogicmicro.com                  (Netlogic Microsystems)
jchandra@freebsd.org                               (The FreeBSD Project)
