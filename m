Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 04 Sep 2011 20:07:08 +0200 (CEST)
Received: from mx1.netlogicmicro.com ([12.203.210.36]:1607 "EHLO
        orion5.netlogicmicro.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491066Ab1IDSGd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 4 Sep 2011 20:06:33 +0200
X-TM-IMSS-Message-ID: <9ba7a2d50002dba9@netlogicmicro.com>
Received: from orion8.netlogicmicro.com ([10.10.16.60]) by netlogicmicro.com ([10.10.16.19]) with ESMTP (TREND IMSS SMTP Service 7.0) id 9ba7a2d50002dba9 ; Sun, 4 Sep 2011 11:04:23 -0700
Received: from jayachandranc.netlogicmicro.com ([10.7.0.77]) by orion8.netlogicmicro.com with Microsoft SMTPSVC(6.0.3790.3959);
         Sun, 4 Sep 2011 11:07:23 -0700
Date:   Sun, 4 Sep 2011 23:42:08 +0530
From:   Jayachandran C <jayachandranc@netlogicmicro.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH 2/4] MIPS: Netlogic: Platform files for XLP processors.
Message-ID: <7aed2c03c63291c90b7fadd3f768899159f1657e.1315075195.git.jayachandranc@netlogicmicro.com>
References: <cover.1315075195.git.jayachandranc@netlogicmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1315075195.git.jayachandranc@netlogicmicro.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-OriginalArrivalTime: 04 Sep 2011 18:07:23.0467 (UTC) FILETIME=[7EF641B0:01CC6B2D]
X-archive-position: 31041
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 2161

* Add include/asm/netlogic/xlp-hal/ - hardware access library for XLP
* Add netlogic/xlp - platform files including PIC support, early console and
  FDT based startup

Signed-off-by: Jayachandran C <jayachandranc@netlogicmicro.com>
---
 arch/mips/include/asm/netlogic/xlp-hal/bridge.h    |  187 ++++++++++
 .../mips/include/asm/netlogic/xlp-hal/cpucontrol.h |   83 +++++
 arch/mips/include/asm/netlogic/xlp-hal/haldefs.h   |  154 ++++++++
 arch/mips/include/asm/netlogic/xlp-hal/iomap.h     |  155 ++++++++
 arch/mips/include/asm/netlogic/xlp-hal/pic.h       |  383 ++++++++++++++++++++
 arch/mips/include/asm/netlogic/xlp-hal/sys.h       |  128 +++++++
 arch/mips/include/asm/netlogic/xlp-hal/uart.h      |  191 ++++++++++
 arch/mips/include/asm/netlogic/xlp-hal/xlp.h       |   71 ++++
 arch/mips/netlogic/xlp/Makefile                    |    4 +
 arch/mips/netlogic/xlp/irq.c                       |  240 ++++++++++++
 arch/mips/netlogic/xlp/nlm_hal.c                   |   85 +++++
 arch/mips/netlogic/xlp/platform.c                  |  108 ++++++
 arch/mips/netlogic/xlp/setup.c                     |   98 +++++
 arch/mips/netlogic/xlp/smp.c                       |  285 +++++++++++++++
 arch/mips/netlogic/xlp/smpboot.S                   |  217 +++++++++++
 arch/mips/netlogic/xlp/time.c                      |   74 ++++
 arch/mips/netlogic/xlp/xlp_console.c               |   50 +++
 17 files changed, 2513 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/include/asm/netlogic/xlp-hal/bridge.h
 create mode 100644 arch/mips/include/asm/netlogic/xlp-hal/cpucontrol.h
 create mode 100644 arch/mips/include/asm/netlogic/xlp-hal/haldefs.h
 create mode 100644 arch/mips/include/asm/netlogic/xlp-hal/iomap.h
 create mode 100644 arch/mips/include/asm/netlogic/xlp-hal/pic.h
 create mode 100644 arch/mips/include/asm/netlogic/xlp-hal/sys.h
 create mode 100644 arch/mips/include/asm/netlogic/xlp-hal/uart.h
 create mode 100644 arch/mips/include/asm/netlogic/xlp-hal/xlp.h
 create mode 100644 arch/mips/netlogic/xlp/Makefile
 create mode 100644 arch/mips/netlogic/xlp/irq.c
 create mode 100644 arch/mips/netlogic/xlp/nlm_hal.c
 create mode 100644 arch/mips/netlogic/xlp/platform.c
 create mode 100644 arch/mips/netlogic/xlp/setup.c
 create mode 100644 arch/mips/netlogic/xlp/smp.c
 create mode 100644 arch/mips/netlogic/xlp/smpboot.S
 create mode 100644 arch/mips/netlogic/xlp/time.c
 create mode 100644 arch/mips/netlogic/xlp/xlp_console.c

diff --git a/arch/mips/include/asm/netlogic/xlp-hal/bridge.h b/arch/mips/include/asm/netlogic/xlp-hal/bridge.h
new file mode 100644
index 0000000..ca95133
--- /dev/null
+++ b/arch/mips/include/asm/netlogic/xlp-hal/bridge.h
@@ -0,0 +1,187 @@
+/*
+ * Copyright 2003-2011 NetLogic Microsystems, Inc. (NetLogic). All rights
+ * reserved.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the NetLogic
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
+ * THIS SOFTWARE IS PROVIDED BY NETLOGIC ``AS IS'' AND ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL NETLOGIC OR CONTRIBUTORS BE LIABLE
+ * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
+ * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
+ * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
+ * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
+ * IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#ifndef __NLM_HAL_BRIDGE_H__
+#define __NLM_HAL_BRIDGE_H__
+
+/**
+* @file_name mio.h
+* @author Netlogic Microsystems
+* @brief Basic definitions of XLP memory and io subsystem
+*/
+
+/*
+ * BRIDGE specific registers
+ *
+ * These registers start after the PCIe header, which has 0x40
+ * standard entries
+ */
+#define BRIDGE_MODE			0x00
+#define BRIDGE_PCI_CFG_BASE		0x01
+#define BRIDGE_PCI_CFG_LIMIT		0x02
+#define BRIDGE_PCIE_CFG_BASE		0x03
+#define BRIDGE_PCIE_CFG_LIMIT		0x04
+#define BRIDGE_BUSNUM_BAR0		0x05
+#define BRIDGE_BUSNUM_BAR1		0x06
+#define BRIDGE_BUSNUM_BAR2		0x07
+#define BRIDGE_BUSNUM_BAR3		0x08
+#define BRIDGE_BUSNUM_BAR4		0x09
+#define BRIDGE_BUSNUM_BAR5		0x0a
+#define BRIDGE_BUSNUM_BAR6		0x0b
+#define BRIDGE_FLASH_BAR0		0x0c
+#define BRIDGE_FLASH_BAR1		0x0d
+#define BRIDGE_FLASH_BAR2		0x0e
+#define BRIDGE_FLASH_BAR3		0x0f
+#define BRIDGE_FLASH_LIMIT0		0x10
+#define BRIDGE_FLASH_LIMIT1		0x11
+#define BRIDGE_FLASH_LIMIT2		0x12
+#define BRIDGE_FLASH_LIMIT3		0x13
+
+#define BRIDGE_DRAM_BAR(i)		(0x14 + (i))
+#define BRIDGE_DRAM_BAR0		0x14
+#define BRIDGE_DRAM_BAR1		0x15
+#define BRIDGE_DRAM_BAR2		0x16
+#define BRIDGE_DRAM_BAR3		0x17
+#define BRIDGE_DRAM_BAR4		0x18
+#define BRIDGE_DRAM_BAR5		0x19
+#define BRIDGE_DRAM_BAR6		0x1a
+#define BRIDGE_DRAM_BAR7		0x1b
+
+#define BRIDGE_DRAM_LIMIT(i)		(0x1c + (i))
+#define BRIDGE_DRAM_LIMIT0		0x1c
+#define BRIDGE_DRAM_LIMIT1		0x1d
+#define BRIDGE_DRAM_LIMIT2		0x1e
+#define BRIDGE_DRAM_LIMIT3		0x1f
+#define BRIDGE_DRAM_LIMIT4		0x20
+#define BRIDGE_DRAM_LIMIT5		0x21
+#define BRIDGE_DRAM_LIMIT6		0x22
+#define BRIDGE_DRAM_LIMIT7		0x23
+
+#define BRIDGE_DRAM_NODE_TRANSLN0	0x24
+#define BRIDGE_DRAM_NODE_TRANSLN1	0x25
+#define BRIDGE_DRAM_NODE_TRANSLN2	0x26
+#define BRIDGE_DRAM_NODE_TRANSLN3	0x27
+#define BRIDGE_DRAM_NODE_TRANSLN4	0x28
+#define BRIDGE_DRAM_NODE_TRANSLN5	0x29
+#define BRIDGE_DRAM_NODE_TRANSLN6	0x2a
+#define BRIDGE_DRAM_NODE_TRANSLN7	0x2b
+#define BRIDGE_DRAM_CHNL_TRANSLN0	0x2c
+#define BRIDGE_DRAM_CHNL_TRANSLN1	0x2d
+#define BRIDGE_DRAM_CHNL_TRANSLN2	0x2e
+#define BRIDGE_DRAM_CHNL_TRANSLN3	0x2f
+#define BRIDGE_DRAM_CHNL_TRANSLN4	0x30
+#define BRIDGE_DRAM_CHNL_TRANSLN5	0x31
+#define BRIDGE_DRAM_CHNL_TRANSLN6	0x32
+#define BRIDGE_DRAM_CHNL_TRANSLN7	0x33
+#define BRIDGE_PCIEMEM_BASE0		0x34
+#define BRIDGE_PCIEMEM_BASE1		0x35
+#define BRIDGE_PCIEMEM_BASE2		0x36
+#define BRIDGE_PCIEMEM_BASE3		0x37
+#define BRIDGE_PCIEMEM_LIMIT0		0x38
+#define BRIDGE_PCIEMEM_LIMIT1		0x39
+#define BRIDGE_PCIEMEM_LIMIT2		0x3a
+#define BRIDGE_PCIEMEM_LIMIT3		0x3b
+#define BRIDGE_PCIEIO_BASE0		0x3c
+#define BRIDGE_PCIEIO_BASE1		0x3d
+#define BRIDGE_PCIEIO_BASE2		0x3e
+#define BRIDGE_PCIEIO_BASE3		0x3f
+#define BRIDGE_PCIEIO_LIMIT0		0x40
+#define BRIDGE_PCIEIO_LIMIT1		0x41
+#define BRIDGE_PCIEIO_LIMIT2		0x42
+#define BRIDGE_PCIEIO_LIMIT3		0x43
+#define BRIDGE_PCIEMEM_BASE4		0x44
+#define BRIDGE_PCIEMEM_BASE5		0x45
+#define BRIDGE_PCIEMEM_BASE6		0x46
+#define BRIDGE_PCIEMEM_LIMIT4		0x47
+#define BRIDGE_PCIEMEM_LIMIT5		0x48
+#define BRIDGE_PCIEMEM_LIMIT6		0x49
+#define BRIDGE_PCIEIO_BASE4		0x4a
+#define BRIDGE_PCIEIO_BASE5		0x4b
+#define BRIDGE_PCIEIO_BASE6		0x4c
+#define BRIDGE_PCIEIO_LIMIT4		0x4d
+#define BRIDGE_PCIEIO_LIMIT5		0x4e
+#define BRIDGE_PCIEIO_LIMIT6		0x4f
+#define BRIDGE_NBU_EVENT_CNT_CTL	0x50
+#define BRIDGE_EVNTCTR1_LOW		0x51
+#define BRIDGE_EVNTCTR1_HI		0x52
+#define BRIDGE_EVNT_CNT_CTL2		0x53
+#define BRIDGE_EVNTCTR2_LOW		0x54
+#define BRIDGE_EVNTCTR2_HI		0x55
+#define BRIDGE_TRACEBUF_MATCH0		0x56
+#define BRIDGE_TRACEBUF_MATCH1		0x57
+#define BRIDGE_TRACEBUF_MATCH_LOW	0x58
+#define BRIDGE_TRACEBUF_MATCH_HI	0x59
+#define BRIDGE_TRACEBUF_CTRL		0x5a
+#define BRIDGE_TRACEBUF_INIT		0x5b
+#define BRIDGE_TRACEBUF_ACCESS		0x5c
+#define BRIDGE_TRACEBUF_READ_DATA0	0x5d
+#define BRIDGE_TRACEBUF_READ_DATA1	0x5d
+#define BRIDGE_TRACEBUF_READ_DATA2	0x5f
+#define BRIDGE_TRACEBUF_READ_DATA3	0x60
+#define BRIDGE_TRACEBUF_STATUS		0x61
+#define BRIDGE_ADDRESS_ERROR0		0x62
+#define BRIDGE_ADDRESS_ERROR1		0x63
+#define BRIDGE_ADDRESS_ERROR2		0x64
+#define BRIDGE_TAG_ECC_ADDR_ERROR0	0x65
+#define BRIDGE_TAG_ECC_ADDR_ERROR1	0x66
+#define BRIDGE_TAG_ECC_ADDR_ERROR2	0x67
+#define BRIDGE_LINE_FLUSH0		0x68
+#define BRIDGE_LINE_FLUSH1		0x69
+#define BRIDGE_NODE_ID			0x6a
+#define BRIDGE_ERROR_INTERRUPT_EN	0x6b
+#define BRIDGE_PCIE0_WEIGHT		0x2c0
+#define BRIDGE_PCIE1_WEIGHT		0x2c1
+#define BRIDGE_PCIE2_WEIGHT		0x2c2
+#define BRIDGE_PCIE3_WEIGHT		0x2c3
+#define BRIDGE_USB_WEIGHT		0x2c4
+#define BRIDGE_NET_WEIGHT		0x2c5
+#define BRIDGE_POE_WEIGHT		0x2c6
+#define BRIDGE_CMS_WEIGHT		0x2c7
+#define BRIDGE_DMAENG_WEIGHT		0x2c8
+#define BRIDGE_SEC_WEIGHT		0x2c9
+#define BRIDGE_COMP_WEIGHT		0x2ca
+#define BRIDGE_GIO_WEIGHT		0x2cb
+#define BRIDGE_FLASH_WEIGHT		0x2cc
+
+#ifndef __ASSEMBLY__
+
+#define nlm_read_bridge_reg(b, r)	nlm_read_reg(b, r)
+#define nlm_write_bridge_reg(b, r, v)	nlm_write_reg(b, r, v)
+#define	nlm_get_bridge_pcibase(node)	\
+			nlm_pcicfg_base(XLP_IO_BRIDGE_OFFSET(node))
+#define	nlm_get_bridge_regbase(node)	\
+			(nlm_get_bridge_pcibase(node) + XLP_IO_PCI_HDRSZ)
+
+#endif /* __ASSEMBLY__ */
+#endif /* __NLM_HAL_BRIDGE_H__ */
diff --git a/arch/mips/include/asm/netlogic/xlp-hal/cpucontrol.h b/arch/mips/include/asm/netlogic/xlp-hal/cpucontrol.h
new file mode 100644
index 0000000..bf7d41d
--- /dev/null
+++ b/arch/mips/include/asm/netlogic/xlp-hal/cpucontrol.h
@@ -0,0 +1,83 @@
+/*
+ * Copyright 2003-2011 NetLogic Microsystems, Inc. (NetLogic). All rights
+ * reserved.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the NetLogic
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
+ * THIS SOFTWARE IS PROVIDED BY NETLOGIC ``AS IS'' AND ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL NETLOGIC OR CONTRIBUTORS BE LIABLE
+ * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
+ * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
+ * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
+ * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
+ * IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#ifndef __NLM_HAL_CPUCONTROL_H__
+#define __NLM_HAL_CPUCONTROL_H__
+
+#define CPU_BLOCKID_IFU		0
+#define CPU_BLOCKID_ICU		1
+#define CPU_BLOCKID_IEU		2
+#define CPU_BLOCKID_LSU		3
+#define CPU_BLOCKID_MMU		4
+#define CPU_BLOCKID_PRF		5
+#define CPU_BLOCKID_SCH		7
+#define CPU_BLOCKID_SCU		8
+#define CPU_BLOCKID_FPU		9
+#define CPU_BLOCKID_MAP		10
+
+#define LSU_DEFEATURE		0x304
+#define LSU_CERRLOG_REGID	0x09
+#define SCHED_DEFEATURE		0x700
+
+/* Offsets of interest from the 'MAP' Block */
+#define MAP_THREADMODE			0x00
+#define MAP_EXT_EBASE_ENABLE		0x04
+#define MAP_CCDI_CONFIG			0x08
+#define MAP_THRD0_CCDI_STATUS		0x0c
+#define MAP_THRD1_CCDI_STATUS		0x10
+#define MAP_THRD2_CCDI_STATUS		0x14
+#define MAP_THRD3_CCDI_STATUS		0x18
+#define MAP_THRD0_DEBUG_MODE		0x1c
+#define MAP_THRD1_DEBUG_MODE		0x20
+#define MAP_THRD2_DEBUG_MODE		0x24
+#define MAP_THRD3_DEBUG_MODE		0x28
+#define MAP_MISC_STATE			0x60
+#define MAP_DEBUG_READ_CTL		0x64
+#define MAP_DEBUG_READ_REG0		0x68
+#define MAP_DEBUG_READ_REG1		0x6c
+
+#define MMU_SETUP		0x400
+#define MMU_LFSRSEED		0x401
+#define MMU_HPW_NUM_PAGE_LVL	0x410
+#define MMU_PGWKR_PGDBASE	0x411
+#define MMU_PGWKR_PGDSHFT	0x412
+#define MMU_PGWKR_PGDMASK	0x413
+#define MMU_PGWKR_PUDSHFT	0x414
+#define MMU_PGWKR_PUDMASK	0x415
+#define MMU_PGWKR_PMDSHFT	0x416
+#define MMU_PGWKR_PMDMASK	0x417
+#define MMU_PGWKR_PTESHFT	0x418
+#define MMU_PGWKR_PTEMASK	0x419
+
+#endif /* __NLM_CPUCONTROL_H__ */
diff --git a/arch/mips/include/asm/netlogic/xlp-hal/haldefs.h b/arch/mips/include/asm/netlogic/xlp-hal/haldefs.h
new file mode 100644
index 0000000..642f411
--- /dev/null
+++ b/arch/mips/include/asm/netlogic/xlp-hal/haldefs.h
@@ -0,0 +1,154 @@
+/*
+ * Copyright 2003-2011 NetLogic Microsystems, Inc. (NetLogic). All rights
+ * reserved.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the NetLogic
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
+ * THIS SOFTWARE IS PROVIDED BY NETLOGIC ``AS IS'' AND ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL NETLOGIC OR CONTRIBUTORS BE LIABLE
+ * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
+ * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
+ * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
+ * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
+ * IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#ifndef __NLM_HAL_HALDEFS_H__
+#define __NLM_HAL_HALDEFS_H__
+
+/*
+ * This file contains platform specific memory mapped IO implementation
+ * and will provide a way to read 32/64 bit memory mapped registers in
+ * all ABIs
+ */
+#ifndef CONFIG_64BIT
+#error "o32 compile not supported yet"
+#endif
+/*
+ * For o32 compilation, we have to disable interrupts and enable KX bit to
+ * access 64 bit addresses or data.
+ *
+ * We need to disable interrupts because we save just the lower 32 bits of
+ * registers in  interrupt handling. So if we get hit by an interrupt while
+ * using the upper 32 bits of a register, we lose.
+ */
+static inline uint32_t nlm_save_flags_kx(void)
+{
+	return change_c0_status(ST0_KX | ST0_IE, ST0_KX);
+}
+
+static inline uint32_t nlm_save_flags_cop2(void)
+{
+	return change_c0_status(ST0_CU2 | ST0_IE, ST0_CU2);
+}
+
+static inline void nlm_restore_flags(uint32_t sr)
+{
+	write_c0_status(sr);
+}
+
+/*
+ * The n64 implementations are simple, the o32 implementations when they
+ * are added, will have to disable interrupts and enable KX before doing
+ * 64 bit ops.
+ */
+static inline uint32_t
+nlm_read_reg(uint64_t base, uint32_t reg)
+{
+	volatile uint32_t *addr = (volatile uint32_t *)(long)base + reg;
+
+	return *addr;
+}
+
+static inline void
+nlm_write_reg(uint64_t base, uint32_t reg, uint32_t val)
+{
+	volatile uint32_t *addr = (volatile uint32_t *)(long)base + reg;
+
+	*addr = val;
+}
+
+static inline uint64_t
+nlm_read_reg64(uint64_t base, uint32_t reg)
+{
+	uint64_t addr = base + (reg >> 1) * sizeof(uint64_t);
+	volatile uint64_t *ptr = (volatile uint64_t *)(long)addr;
+
+	return *ptr;
+}
+
+static inline void
+nlm_write_reg64(uint64_t base, uint32_t reg, uint64_t val)
+{
+	uint64_t addr = base + (reg >> 1) * sizeof(uint64_t);
+	volatile uint64_t *ptr = (volatile uint64_t *)(long)addr;
+
+	*ptr = val;
+}
+
+/*
+ * Routines to store 32/64 bit values to 64 bit addresses,
+ * used when going thru XKPHYS to access registers
+ */
+static inline uint32_t
+nlm_read_reg_xkphys(uint64_t base, uint32_t reg)
+{
+	return nlm_read_reg(base, reg);
+}
+
+static inline void
+nlm_write_reg_xkphys(uint64_t base, uint32_t reg, uint32_t val)
+{
+	nlm_write_reg(base, reg, val);
+}
+
+static inline uint64_t
+nlm_read_reg64_xkphys(uint64_t base, uint32_t reg)
+{
+	return nlm_read_reg64(base, reg);
+}
+
+static inline void
+nlm_write_reg64_xkphys(uint64_t base, uint32_t reg, uint64_t val)
+{
+	nlm_write_reg64(base, reg, val);
+}
+
+/* Location where IO base is mapped */
+extern uint64_t xlp_io_base;
+
+static inline uint64_t
+nlm_pcicfg_base(uint32_t devoffset)
+{
+	return xlp_io_base + devoffset;
+}
+
+static inline uint64_t
+nlm_xkphys_map_pcibar0(uint64_t pcibase)
+{
+	uint64_t paddr;
+
+	paddr = nlm_read_reg(pcibase, 0x4) & ~0xfu;
+	return (uint64_t)0x9000000000000000 | paddr;
+}
+
+#endif
diff --git a/arch/mips/include/asm/netlogic/xlp-hal/iomap.h b/arch/mips/include/asm/netlogic/xlp-hal/iomap.h
new file mode 100644
index 0000000..d239f8d
--- /dev/null
+++ b/arch/mips/include/asm/netlogic/xlp-hal/iomap.h
@@ -0,0 +1,155 @@
+/*
+ * Copyright 2003-2011 NetLogic Microsystems, Inc. (NetLogic). All rights
+ * reserved.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the NetLogic
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
+ * THIS SOFTWARE IS PROVIDED BY NETLOGIC ``AS IS'' AND ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL NETLOGIC OR CONTRIBUTORS BE LIABLE
+ * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
+ * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
+ * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
+ * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
+ * IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#ifndef __NLM_HAL_IOMAP_H__
+#define __NLM_HAL_IOMAP_H__
+
+#define XLP_DEFAULT_IO_BASE             0x18000000
+#define NMI_BASE			0xbfc00000
+#define	XLP_IO_CLK			133333333
+
+#define XLP_PCIE_CFG_SIZE		0x1000		/* 4K */
+#define XLP_PCIE_DEV_BLK_SIZE		(8 * XLP_PCIE_CFG_SIZE)
+#define XLP_PCIE_BUS_BLK_SIZE		(256 * XLP_PCIE_DEV_BLK_SIZE)
+#define XLP_IO_SIZE			(64 << 20)	/* ECFG space size */
+#define XLP_IO_PCI_HDRSZ		0x100
+#define XLP_IO_DEV(node, dev)		((dev) + (node) * 8)
+#define XLP_HDR_OFFSET(node, bus, dev, fn)	(((bus) << 20) | \
+				((XLP_IO_DEV(node, dev)) << 15) | ((fn) << 12))
+
+#define XLP_IO_BRIDGE_OFFSET(node)	XLP_HDR_OFFSET(node, 0, 0, 0)
+/* coherent inter chip */
+#define XLP_IO_CIC0_OFFSET(node)	XLP_HDR_OFFSET(node, 0, 0, 1)
+#define XLP_IO_CIC1_OFFSET(node)	XLP_HDR_OFFSET(node, 0, 0, 2)
+#define XLP_IO_CIC2_OFFSET(node)	XLP_HDR_OFFSET(node, 0, 0, 3)
+#define XLP_IO_PIC_OFFSET(node)		XLP_HDR_OFFSET(node, 0, 0, 4)
+
+#define XLP_IO_PCIE_OFFSET(node, i)	XLP_HDR_OFFSET(node, 0, 1, i)
+#define XLP_IO_PCIE0_OFFSET(node)	XLP_HDR_OFFSET(node, 0, 1, 0)
+#define XLP_IO_PCIE1_OFFSET(node)	XLP_HDR_OFFSET(node, 0, 1, 1)
+#define XLP_IO_PCIE2_OFFSET(node)	XLP_HDR_OFFSET(node, 0, 1, 2)
+#define XLP_IO_PCIE3_OFFSET(node)	XLP_HDR_OFFSET(node, 0, 1, 3)
+
+#define XLP_IO_USB_OFFSET(node, i)	XLP_HDR_OFFSET(node, 0, 2, i)
+#define XLP_IO_USB_EHCI0_OFFSET(node)	XLP_HDR_OFFSET(node, 0, 2, 0)
+#define XLP_IO_USB_OHCI0_OFFSET(node)	XLP_HDR_OFFSET(node, 0, 2, 1)
+#define XLP_IO_USB_OHCI1_OFFSET(node)	XLP_HDR_OFFSET(node, 0, 2, 2)
+#define XLP_IO_USB_EHCI1_OFFSET(node)	XLP_HDR_OFFSET(node, 0, 2, 3)
+#define XLP_IO_USB_OHCI2_OFFSET(node)	XLP_HDR_OFFSET(node, 0, 2, 4)
+#define XLP_IO_USB_OHCI3_OFFSET(node)	XLP_HDR_OFFSET(node, 0, 2, 5)
+
+#define XLP_IO_NAE_OFFSET(node)		XLP_HDR_OFFSET(node, 0, 3, 0)
+#define XLP_IO_POE_OFFSET(node)		XLP_HDR_OFFSET(node, 0, 3, 1)
+
+#define XLP_IO_CMS_OFFSET(node)		XLP_HDR_OFFSET(node, 0, 4, 0)
+
+#define XLP_IO_DMA_OFFSET(node)		XLP_HDR_OFFSET(node, 0, 5, 1)
+#define XLP_IO_SEC_OFFSET(node)		XLP_HDR_OFFSET(node, 0, 5, 2)
+#define XLP_IO_CMP_OFFSET(node)		XLP_HDR_OFFSET(node, 0, 5, 3)
+
+#define XLP_IO_UART_OFFSET(node, i)	XLP_HDR_OFFSET(node, 0, 6, i)
+#define XLP_IO_UART0_OFFSET(node)	XLP_HDR_OFFSET(node, 0, 6, 0)
+#define XLP_IO_UART1_OFFSET(node)	XLP_HDR_OFFSET(node, 0, 6, 1)
+#define XLP_IO_I2C_OFFSET(node, i)	XLP_HDR_OFFSET(node, 0, 6, 2 + i)
+#define XLP_IO_I2C0_OFFSET(node)	XLP_HDR_OFFSET(node, 0, 6, 2)
+#define XLP_IO_I2C1_OFFSET(node)	XLP_HDR_OFFSET(node, 0, 6, 3)
+#define XLP_IO_GPIO_OFFSET(node)	XLP_HDR_OFFSET(node, 0, 6, 4)
+/* system management */
+#define XLP_IO_SYS_OFFSET(node)		XLP_HDR_OFFSET(node, 0, 6, 5)
+#define XLP_IO_JTAG_OFFSET(node)	XLP_HDR_OFFSET(node, 0, 6, 6)
+
+#define XLP_IO_NOR_OFFSET(node)		XLP_HDR_OFFSET(node, 0, 7, 0)
+#define XLP_IO_NAND_OFFSET(node)	XLP_HDR_OFFSET(node, 0, 7, 1)
+#define XLP_IO_SPI_OFFSET(node)		XLP_HDR_OFFSET(node, 0, 7, 2)
+/* SD flash */
+#define XLP_IO_SD_OFFSET(node)          XLP_HDR_OFFSET(node, 0, 7, 3)
+#define XLP_IO_MMC_OFFSET(node, slot)   \
+		((XLP_IO_SD_OFFSET(node))+(slot*0x100)+XLP_IO_PCI_HDRSZ)
+
+/* PCI config header register id's */
+#define XLP_PCI_CFGREG0			0x00
+#define XLP_PCI_CFGREG1			0x01
+#define XLP_PCI_CFGREG2			0x02
+#define XLP_PCI_CFGREG3			0x03
+#define XLP_PCI_CFGREG4			0x04
+#define XLP_PCI_CFGREG5			0x05
+#define XLP_PCI_DEVINFO_REG0		0x30
+#define XLP_PCI_DEVINFO_REG1		0x31
+#define XLP_PCI_DEVINFO_REG2		0x32
+#define XLP_PCI_DEVINFO_REG3		0x33
+#define XLP_PCI_DEVINFO_REG4		0x34
+#define XLP_PCI_DEVINFO_REG5		0x35
+#define XLP_PCI_DEVINFO_REG6		0x36
+#define XLP_PCI_DEVINFO_REG7		0x37
+#define XLP_PCI_DEVSCRATCH_REG0		0x38
+#define XLP_PCI_DEVSCRATCH_REG1		0x39
+#define XLP_PCI_DEVSCRATCH_REG2		0x3a
+#define XLP_PCI_DEVSCRATCH_REG3		0x3b
+#define XLP_PCI_MSGSTN_REG		0x3c
+#define XLP_PCI_IRTINFO_REG		0x3d
+#define XLP_PCI_UCODEINFO_REG		0x3e
+#define XLP_PCI_SBB_WT_REG		0x3f
+
+/* PCI IDs for SoC device */
+#define	PCI_VENDOR_NETLOGIC		0x184e
+
+#define	PCI_DEVICE_ID_NLM_ROOT		0x1001
+#define	PCI_DEVICE_ID_NLM_ICI		0x1002
+#define	PCI_DEVICE_ID_NLM_PIC		0x1003
+#define	PCI_DEVICE_ID_NLM_PCIE		0x1004
+#define	PCI_DEVICE_ID_NLM_EHCI		0x1007
+#define	PCI_DEVICE_ID_NLM_ILK		0x1008
+#define	PCI_DEVICE_ID_NLM_NAE		0x1009
+#define	PCI_DEVICE_ID_NLM_POE		0x100A
+#define	PCI_DEVICE_ID_NLM_FMN		0x100B
+#define	PCI_DEVICE_ID_NLM_RAID		0x100D
+#define	PCI_DEVICE_ID_NLM_SAE		0x100D
+#define	PCI_DEVICE_ID_NLM_RSA		0x100E
+#define	PCI_DEVICE_ID_NLM_CMP		0x100F
+#define	PCI_DEVICE_ID_NLM_UART		0x1010
+#define	PCI_DEVICE_ID_NLM_I2C		0x1011
+#define	PCI_DEVICE_ID_NLM_NOR		0x1015
+#define	PCI_DEVICE_ID_NLM_NAND		0x1016
+#define	PCI_DEVICE_ID_NLM_MMC		0x1018
+
+#ifndef __ASSEMBLY__
+
+#define nlm_read_pci_reg(b, r)		nlm_read_reg(b, r)
+#define nlm_write_pci_reg(b, r, v)	nlm_write_reg(b, r, v)
+
+extern uint64_t xlp_sys_base;
+extern uint64_t xlp_pic_base;
+#endif /* !__ASSEMBLY */
+
+#endif /* __NLM_HAL_IOMAP_H__ */
diff --git a/arch/mips/include/asm/netlogic/xlp-hal/pic.h b/arch/mips/include/asm/netlogic/xlp-hal/pic.h
new file mode 100644
index 0000000..ff3f1c7
--- /dev/null
+++ b/arch/mips/include/asm/netlogic/xlp-hal/pic.h
@@ -0,0 +1,383 @@
+/*
+ * Copyright 2003-2011 NetLogic Microsystems, Inc. (NetLogic). All rights
+ * reserved.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the NetLogic
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
+ * THIS SOFTWARE IS PROVIDED BY NETLOGIC ``AS IS'' AND ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL NETLOGIC OR CONTRIBUTORS BE LIABLE
+ * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
+ * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
+ * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
+ * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
+ * IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#ifndef _NLM_HAL_PIC_H
+#define _NLM_HAL_PIC_H
+
+/* PIC Specific registers */
+#define PIC_CTRL                0x00
+
+/* PIC control register defines */
+#define PIC_CTRL_ITV		32 /* interrupt timeout value */
+#define PIC_CTRL_ICI		19 /* ICI interrupt timeout enable */
+#define PIC_CTRL_ITE		18 /* interrupt timeout enable */
+#define PIC_CTRL_STE		10 /* system timer interrupt enable */
+#define PIC_CTRL_WWR1		8  /* watchdog 1 wraparound count for reset */
+#define PIC_CTRL_WWR0		6  /* watchdog 0 wraparound count for reset */
+#define PIC_CTRL_WWN1		4  /* watchdog 1 wraparound count for NMI */
+#define PIC_CTRL_WWN0		2  /* watchdog 0 wraparound count for NMI */
+#define PIC_CTRL_WTE		0  /* watchdog timer enable */
+
+/* PIC Status register defines */
+#define PIC_ICI_STATUS		33 /* ICI interrupt timeout status */
+#define PIC_ITE_STATUS		32 /* interrupt timeout status */
+#define PIC_STS_STATUS		4  /* System timer interrupt status */
+#define PIC_WNS_STATUS		2  /* NMI status for watchdog timers */
+#define PIC_WIS_STATUS		0  /* Interrupt status for watchdog timers */
+
+/* PIC IPI control register offsets */
+#define PIC_IPICTRL_NMI		32
+#define PIC_IPICTRL_RIV		20 /* received interrupt vector */
+#define PIC_IPICTRL_IDB		16 /* interrupt destination base */
+#define PIC_IPICTRL_DTE		 0 /* interrupt destination thread enables */
+
+/* PIC IRT register offsets */
+#define PIC_IRT_ENABLE		31
+#define PIC_IRT_NMI		29
+#define PIC_IRT_SCH		28 /* Scheduling scheme */
+#define PIC_IRT_RVEC		20 /* Interrupt receive vectors */
+#define PIC_IRT_DT		19 /* Destination type */
+#define PIC_IRT_DB		16 /* Destination base */
+#define PIC_IRT_DTE		0  /* Destination thread enables */
+
+#define PIC_BYTESWAP            0x02
+#define PIC_STATUS              0x04
+#define PIC_INTR_TIMEOUT	0x06
+#define PIC_ICI0_INTR_TIMEOUT	0x08
+#define PIC_ICI1_INTR_TIMEOUT	0x0a
+#define PIC_ICI2_INTR_TIMEOUT	0x0c
+#define PIC_IPI_CTL		0x0e
+#define PIC_INT_ACK             0x10
+#define PIC_INT_PENDING0        0x12
+#define PIC_INT_PENDING1        0x14
+#define PIC_INT_PENDING2        0x16
+
+#define PIC_WDOG0_MAXVAL        0x18
+#define PIC_WDOG0_COUNT         0x1a
+#define PIC_WDOG0_ENABLE0       0x1c
+#define PIC_WDOG0_ENABLE1       0x1e
+#define PIC_WDOG0_BEATCMD       0x20
+#define PIC_WDOG0_BEAT0         0x22
+#define PIC_WDOG0_BEAT1         0x24
+
+#define PIC_WDOG1_MAXVAL        0x26
+#define PIC_WDOG1_COUNT         0x28
+#define PIC_WDOG1_ENABLE0       0x2a
+#define PIC_WDOG1_ENABLE1       0x2c
+#define PIC_WDOG1_BEATCMD       0x2e
+#define PIC_WDOG1_BEAT0         0x30
+#define PIC_WDOG1_BEAT1         0x32
+
+#define PIC_WDOG_MAXVAL(i)      (PIC_WDOG0_MAXVAL + ((i) ? 7 : 0))
+#define PIC_WDOG_COUNT(i)       (PIC_WDOG0_COUNT + ((i) ? 7 : 0))
+#define PIC_WDOG_ENABLE0(i)     (PIC_WDOG0_ENABLE0 + ((i) ? 7 : 0))
+#define PIC_WDOG_ENABLE1(i)     (PIC_WDOG0_ENABLE1 + ((i) ? 7 : 0))
+#define PIC_WDOG_BEATCMD(i)     (PIC_WDOG0_BEATCMD + ((i) ? 7 : 0))
+#define PIC_WDOG_BEAT0(i)       (PIC_WDOG0_BEAT0 + ((i) ? 7 : 0))
+#define PIC_WDOG_BEAT1(i)       (PIC_WDOG0_BEAT1 + ((i) ? 7 : 0))
+
+#define PIC_TIMER0_MAXVAL    0x34
+#define PIC_TIMER1_MAXVAL    0x36
+#define PIC_TIMER2_MAXVAL    0x38
+#define PIC_TIMER3_MAXVAL    0x3a
+#define PIC_TIMER4_MAXVAL    0x3c
+#define PIC_TIMER5_MAXVAL    0x3e
+#define PIC_TIMER6_MAXVAL    0x40
+#define PIC_TIMER7_MAXVAL    0x42
+#define PIC_TIMER_MAXVAL(i)  (PIC_TIMER0_MAXVAL + ((i) * 2))
+
+#define PIC_TIMER0_COUNT     0x44
+#define PIC_TIMER1_COUNT     0x46
+#define PIC_TIMER2_COUNT     0x48
+#define PIC_TIMER3_COUNT     0x4a
+#define PIC_TIMER4_COUNT     0x4c
+#define PIC_TIMER5_COUNT     0x4e
+#define PIC_TIMER6_COUNT     0x50
+#define PIC_TIMER7_COUNT     0x52
+#define PIC_TIMER_COUNT(i)   (PIC_TIMER0_COUNT + ((i) * 2))
+
+#define PIC_ITE0_N0_N1          0x54
+#define PIC_ITE1_N0_N1          0x58
+#define PIC_ITE2_N0_N1          0x5c
+#define PIC_ITE3_N0_N1          0x60
+#define PIC_ITE4_N0_N1          0x64
+#define PIC_ITE5_N0_N1          0x68
+#define PIC_ITE6_N0_N1          0x6c
+#define PIC_ITE7_N0_N1          0x70
+#define PIC_ITE_N0_N1(i)        (PIC_ITE0_N0_N1 + ((i) * 4))
+
+#define PIC_ITE0_N2_N3          0x56
+#define PIC_ITE1_N2_N3          0x5a
+#define PIC_ITE2_N2_N3          0x5e
+#define PIC_ITE3_N2_N3          0x62
+#define PIC_ITE4_N2_N3          0x66
+#define PIC_ITE5_N2_N3          0x6a
+#define PIC_ITE6_N2_N3          0x6e
+#define PIC_ITE7_N2_N3          0x72
+#define PIC_ITE_N2_N3(i)        (PIC_ITE0_N2_N3 + ((i) * 4))
+
+#define PIC_IRT0                0x74
+#define PIC_IRT(i)              (PIC_IRT0 + ((i) * 2))
+
+#define TIMER_CYCLES_MAXVAL	0xffffffffffffffffULL
+
+/*
+ *    IRT Map
+ */
+#define PIC_NUM_IRTS		160
+
+#define PIC_IRT_WD_0_INDEX	0
+#define PIC_IRT_WD_1_INDEX	1
+#define PIC_IRT_WD_NMI_0_INDEX	2
+#define PIC_IRT_WD_NMI_1_INDEX	3
+#define PIC_IRT_TIMER_0_INDEX	4
+#define PIC_IRT_TIMER_1_INDEX	5
+#define PIC_IRT_TIMER_2_INDEX	6
+#define PIC_IRT_TIMER_3_INDEX	7
+#define PIC_IRT_TIMER_4_INDEX	8
+#define PIC_IRT_TIMER_5_INDEX	9
+#define PIC_IRT_TIMER_6_INDEX	10
+#define PIC_IRT_TIMER_7_INDEX	11
+#define PIC_IRT_CLOCK_INDEX	PIC_IRT_TIMER_7_INDEX
+#define PIC_IRT_TIMER_INDEX(num)	((num) + PIC_IRT_TIMER_0_INDEX)
+
+
+/* 11 and 12 */
+#define PIC_NUM_MSG_Q_IRTS	32
+#define PIC_IRT_MSG_Q0_INDEX	12
+#define PIC_IRT_MSG_Q_INDEX(qid)	((qid) + PIC_IRT_MSG_Q0_INDEX)
+/* 12 to 43 */
+#define PIC_IRT_MSG_0_INDEX	44
+#define PIC_IRT_MSG_1_INDEX	45
+/* 44 and 45 */
+#define PIC_NUM_PCIE_MSIX_IRTS	32
+#define PIC_IRT_PCIE_MSIX_0_INDEX	46
+#define PIC_IRT_PCIE_MSIX_INDEX(num)	((num) + PIC_IRT_PCIE_MSIX_0_INDEX)
+/* 46 to 77 */
+#define PIC_NUM_PCIE_LINK_IRTS		4
+#define PIC_IRT_PCIE_LINK_0_INDEX	78
+#define PIC_IRT_PCIE_LINK_1_INDEX	79
+#define PIC_IRT_PCIE_LINK_2_INDEX	80
+#define PIC_IRT_PCIE_LINK_3_INDEX	81
+#define PIC_IRT_PCIE_LINK_INDEX(num)	((num) + PIC_IRT_PCIE_LINK_0_INDEX)
+/* 78 to 81 */
+#define PIC_NUM_NA_IRTS			32
+/* 82 to 113 */
+#define PIC_IRT_NA_0_INDEX		82
+#define PIC_IRT_NA_INDEX(num)		((num) + PIC_IRT_NA_0_INDEX)
+#define PIC_IRT_POE_INDEX		114
+
+#define PIC_NUM_USB_IRTS		6
+#define PIC_IRT_USB_0_INDEX		115
+#define PIC_IRT_EHCI_0_INDEX		115
+#define PIC_IRT_EHCI_1_INDEX		118
+#define PIC_IRT_USB_INDEX(num)		((num) + PIC_IRT_USB_0_INDEX)
+/* 115 to 120 */
+#define PIC_IRT_GDX_INDEX		121
+#define PIC_IRT_SEC_INDEX		122
+#define PIC_IRT_RSA_INDEX		123
+
+#define PIC_NUM_COMP_IRTS		4
+#define PIC_IRT_COMP_0_INDEX		124
+#define PIC_IRT_COMP_INDEX(num)		((num) + PIC_IRT_COMP_0_INDEX)
+/* 124 to 127 */
+#define PIC_IRT_GBU_INDEX		128
+#define PIC_IRT_ICC_0_INDEX		129 /* ICC - Inter Chip Coherency */
+#define PIC_IRT_ICC_1_INDEX		130
+#define PIC_IRT_ICC_2_INDEX		131
+#define PIC_IRT_CAM_INDEX		132
+#define PIC_IRT_UART_0_INDEX		133
+#define PIC_IRT_UART_1_INDEX		134
+#define PIC_IRT_I2C_0_INDEX		135
+#define PIC_IRT_I2C_1_INDEX		136
+#define PIC_IRT_SYS_0_INDEX		137
+#define PIC_IRT_SYS_1_INDEX		138
+#define PIC_IRT_JTAG_INDEX		139
+#define PIC_IRT_PIC_INDEX		140
+#define PIC_IRT_NBU_INDEX		141
+#define PIC_IRT_TCU_INDEX		142
+#define PIC_IRT_GCU_INDEX		143 /* GBC - Global Coherency */
+#define PIC_IRT_DMC_0_INDEX		144
+#define PIC_IRT_DMC_1_INDEX		145
+
+#define PIC_NUM_GPIO_IRTS		4
+#define PIC_IRT_GPIO_0_INDEX		146
+#define PIC_IRT_GPIO_INDEX(num)		((num) + PIC_IRT_GPIO_0_INDEX)
+
+/* 146 to 149 */
+#define PIC_IRT_NOR_INDEX		150
+#define PIC_IRT_NAND_INDEX		151
+#define PIC_IRT_SPI_INDEX		152
+#define PIC_IRT_MMC_INDEX		153
+
+#define PIC_CLOCK_TIMER			7
+#define PIC_IRQ_BASE			8
+
+#if !defined(LOCORE) && !defined(__ASSEMBLY__)
+
+#define PIC_IRT_FIRST_IRQ		(PIC_IRQ_BASE)
+#define PIC_IRT_LAST_IRQ		63
+#define PIC_IRQ_IS_IRT(irq)		((irq) >= PIC_IRT_FIRST_IRQ)
+
+/*
+ *   Misc
+ */
+#define PIC_IRT_VALID			1
+#define PIC_LOCAL_SCHEDULING		1
+#define PIC_GLOBAL_SCHEDULING		0
+
+#define nlm_read_pic_reg(b, r)	nlm_read_reg64(b, r)
+#define nlm_write_pic_reg(b, r, v) nlm_write_reg64(b, r, v)
+#define nlm_get_pic_pcibase(node) nlm_pcicfg_base(XLP_IO_PIC_OFFSET(node))
+#define nlm_get_pic_regbase(node) (nlm_get_pic_pcibase(node) + XLP_IO_PCI_HDRSZ)
+
+/* IRT and h/w interrupt routines */
+static inline int
+nlm_pic_read_irt(uint64_t base, int irt_index)
+{
+	return nlm_read_pic_reg(base, PIC_IRT(irt_index));
+}
+
+static inline void
+nlm_pic_send_ipi(uint64_t base, int cpu, int vec, int nmi)
+{
+	uint64_t ipi;
+	int	node, ncpu;
+
+	node = cpu / 32;
+	ncpu = cpu & 0x1f;
+	ipi = ((uint64_t)nmi << 31) | (vec << 20) | (node << 17) |
+		(1 << (cpu & 0xf));
+	if (ncpu > 15)
+		ipi |= 0x10000; /* Setting bit 16 to select cpus 16-31 */
+
+	nlm_write_pic_reg(base, PIC_IPI_CTL, ipi);
+}
+
+static inline uint64_t
+nlm_pic_read_control(uint64_t base)
+{
+	return nlm_read_pic_reg(base, PIC_CTRL);
+}
+
+static inline void
+nlm_pic_write_control(uint64_t base, uint64_t control)
+{
+	nlm_write_pic_reg(base, PIC_CTRL, control);
+}
+
+static inline void
+nlm_pic_update_control(uint64_t base, uint64_t control)
+{
+	uint64_t val;
+
+	val = nlm_read_pic_reg(base, PIC_CTRL);
+	nlm_write_pic_reg(base, PIC_CTRL, control | val);
+}
+
+static inline void
+nlm_pic_ack(uint64_t base, int irt_num)
+{
+	nlm_write_pic_reg(base, PIC_INT_ACK, irt_num);
+
+	/* Ack the Status register for Watchdog & System timers */
+	if (irt_num < 12)
+		nlm_write_pic_reg(base, PIC_STATUS, (1 << irt_num));
+}
+
+static inline void
+nlm_set_irt_to_cpu(uint64_t base, int irt, int cpu)
+{
+	uint64_t val;
+
+	val = nlm_read_pic_reg(base, PIC_IRT(irt));
+	val |= cpu & 0xf;
+	if (cpu > 15)
+		val |= 1 << 16;
+	nlm_write_pic_reg(base, PIC_IRT(irt), val);
+}
+
+static inline void
+nlm_pic_write_irt(uint64_t base, int irt_num, int en, int nmi,
+	int sch, int vec, int dt, int db, int dte)
+{
+	uint64_t val;
+
+	val = (((uint64_t)en & 0x1) << 31) | ((nmi & 0x1) << 29) |
+			((sch & 0x1) << 28) | ((vec & 0x3f) << 20) |
+			((dt & 0x1) << 19) | ((db & 0x7) << 16) |
+			(dte & 0xffff);
+
+	nlm_write_pic_reg(base, PIC_IRT(irt_num), val);
+}
+
+static inline void
+nlm_pic_write_irt_direct(uint64_t base, int irt_num, int en, int nmi,
+	int sch, int vec, int cpu)
+{
+	nlm_pic_write_irt(base, irt_num, en, nmi, sch, vec, 1,
+		(cpu >> 4),		/* thread group */
+		1 << (cpu & 0xf));	/* thread mask */
+}
+
+static inline uint64_t
+nlm_pic_read_timer(uint64_t base, int timer)
+{
+	return nlm_read_pic_reg(base, PIC_TIMER_COUNT(timer));
+}
+
+static inline void
+nlm_pic_write_timer(uint64_t base, int timer, uint64_t value)
+{
+	nlm_write_pic_reg(base, PIC_TIMER_COUNT(timer), value);
+}
+
+static inline void
+nlm_pic_set_timer(uint64_t base, int timer, uint64_t value, int irq, int cpu)
+{
+	uint64_t pic_ctrl = nlm_read_pic_reg(base, PIC_CTRL);
+	int en;
+
+	en = (irq > 0);
+	nlm_write_pic_reg(base, PIC_TIMER_MAXVAL(timer), value);
+	nlm_pic_write_irt_direct(base, PIC_IRT_TIMER_INDEX(timer),
+		en, 0, 0, irq, cpu);
+
+	/* enable the timer */
+	pic_ctrl |= (1 << (PIC_CTRL_STE + timer));
+	nlm_write_pic_reg(base, PIC_CTRL, pic_ctrl);
+}
+
+#endif /* __ASSEMBLY__ */
+#endif /* _NLM_HAL_PIC_H */
diff --git a/arch/mips/include/asm/netlogic/xlp-hal/sys.h b/arch/mips/include/asm/netlogic/xlp-hal/sys.h
new file mode 100644
index 0000000..258e8cc
--- /dev/null
+++ b/arch/mips/include/asm/netlogic/xlp-hal/sys.h
@@ -0,0 +1,128 @@
+/*
+ * Copyright 2003-2011 NetLogic Microsystems, Inc. (NetLogic). All rights
+ * reserved.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the NetLogic
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
+ * THIS SOFTWARE IS PROVIDED BY NETLOGIC ``AS IS'' AND ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL NETLOGIC OR CONTRIBUTORS BE LIABLE
+ * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
+ * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
+ * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
+ * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
+ * IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#ifndef __NLM_HAL_SYS_H__
+#define __NLM_HAL_SYS_H__
+
+/**
+* @file_name sys.h
+* @author Netlogic Microsystems
+* @brief HAL for System configuration registers
+*/
+#define	SYS_CHIP_RESET				0x00
+#define	SYS_POWER_ON_RESET_CFG			0x01
+#define	SYS_EFUSE_DEVICE_CFG_STATUS0		0x02
+#define	SYS_EFUSE_DEVICE_CFG_STATUS1		0x03
+#define	SYS_EFUSE_DEVICE_CFG_STATUS2		0x04
+#define	SYS_EFUSE_DEVICE_CFG3			0x05
+#define	SYS_EFUSE_DEVICE_CFG4			0x06
+#define	SYS_EFUSE_DEVICE_CFG5			0x07
+#define	SYS_EFUSE_DEVICE_CFG6			0x08
+#define	SYS_EFUSE_DEVICE_CFG7			0x09
+#define	SYS_PLL_CTRL				0x0a
+#define	SYS_CPU_RESET				0x0b
+#define	SYS_CPU_NONCOHERENT_MODE		0x0d
+#define	SYS_CORE_DFS_DIS_CTRL			0x0e
+#define	SYS_CORE_DFS_RST_CTRL			0x0f
+#define	SYS_CORE_DFS_BYP_CTRL			0x10
+#define	SYS_CORE_DFS_PHA_CTRL			0x11
+#define	SYS_CORE_DFS_DIV_INC_CTRL		0x12
+#define	SYS_CORE_DFS_DIV_DEC_CTRL		0x13
+#define	SYS_CORE_DFS_DIV_VALUE			0x14
+#define	SYS_RESET				0x15
+#define	SYS_DFS_DIS_CTRL			0x16
+#define	SYS_DFS_RST_CTRL			0x17
+#define	SYS_DFS_BYP_CTRL			0x18
+#define	SYS_DFS_DIV_INC_CTRL			0x19
+#define	SYS_DFS_DIV_DEC_CTRL			0x1a
+#define	SYS_DFS_DIV_VALUE0			0x1b
+#define	SYS_DFS_DIV_VALUE1			0x1c
+#define	SYS_SENSE_AMP_DLY			0x1d
+#define	SYS_SOC_SENSE_AMP_DLY			0x1e
+#define	SYS_CTRL0				0x1f
+#define	SYS_CTRL1				0x20
+#define	SYS_TIMEOUT_BS1				0x21
+#define	SYS_BYTE_SWAP				0x22
+#define	SYS_VRM_VID				0x23
+#define	SYS_PWR_RAM_CMD				0x24
+#define	SYS_PWR_RAM_ADDR			0x25
+#define	SYS_PWR_RAM_DATA0			0x26
+#define	SYS_PWR_RAM_DATA1			0x27
+#define	SYS_PWR_RAM_DATA2			0x28
+#define	SYS_PWR_UCODE				0x29
+#define	SYS_CPU0_PWR_STATUS			0x2a
+#define	SYS_CPU1_PWR_STATUS			0x2b
+#define	SYS_CPU2_PWR_STATUS			0x2c
+#define	SYS_CPU3_PWR_STATUS			0x2d
+#define	SYS_CPU4_PWR_STATUS			0x2e
+#define	SYS_CPU5_PWR_STATUS			0x2f
+#define	SYS_CPU6_PWR_STATUS			0x30
+#define	SYS_CPU7_PWR_STATUS			0x31
+#define	SYS_STATUS				0x32
+#define	SYS_INT_POL				0x33
+#define	SYS_INT_TYPE				0x34
+#define	SYS_INT_STATUS				0x35
+#define	SYS_INT_MASK0				0x36
+#define	SYS_INT_MASK1				0x37
+#define	SYS_UCO_S_ECC				0x38
+#define	SYS_UCO_M_ECC				0x39
+#define	SYS_UCO_ADDR				0x3a
+#define	SYS_UCO_INSTR				0x3b
+#define	SYS_MEM_BIST0				0x3c
+#define	SYS_MEM_BIST1				0x3d
+#define	SYS_MEM_BIST2				0x3e
+#define	SYS_MEM_BIST3				0x3f
+#define	SYS_MEM_BIST4				0x40
+#define	SYS_MEM_BIST5				0x41
+#define	SYS_MEM_BIST6				0x42
+#define	SYS_MEM_BIST7				0x43
+#define	SYS_MEM_BIST8				0x44
+#define	SYS_MEM_BIST9				0x45
+#define	SYS_MEM_BIST10				0x46
+#define	SYS_MEM_BIST11				0x47
+#define	SYS_MEM_BIST12				0x48
+#define	SYS_SCRTCH0				0x49
+#define	SYS_SCRTCH1				0x4a
+#define	SYS_SCRTCH2				0x4b
+#define	SYS_SCRTCH3				0x4c
+
+#ifndef __ASSEMBLY__
+
+#define	nlm_read_sys_reg(b, r)		nlm_read_reg(b, r)
+#define	nlm_write_sys_reg(b, r, v)	nlm_write_reg(b, r, v)
+#define	nlm_get_sys_pcibase(node) nlm_pcicfg_base(XLP_IO_SYS_OFFSET(node))
+#define	nlm_get_sys_regbase(node) (nlm_get_sys_pcibase(node) + XLP_IO_PCI_HDRSZ)
+
+#endif
+#endif
diff --git a/arch/mips/include/asm/netlogic/xlp-hal/uart.h b/arch/mips/include/asm/netlogic/xlp-hal/uart.h
new file mode 100644
index 0000000..6a7046c
--- /dev/null
+++ b/arch/mips/include/asm/netlogic/xlp-hal/uart.h
@@ -0,0 +1,191 @@
+/*
+ * Copyright 2003-2011 NetLogic Microsystems, Inc. (NetLogic). All rights
+ * reserved.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the NetLogic
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
+ * THIS SOFTWARE IS PROVIDED BY NETLOGIC ``AS IS'' AND ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL NETLOGIC OR CONTRIBUTORS BE LIABLE
+ * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
+ * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
+ * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
+ * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
+ * IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#ifndef __XLP_HAL_UART_H__
+#define __XLP_HAL_UART_H__
+
+/* UART Specific registers */
+#define UART_RX_DATA		0x00
+#define UART_TX_DATA		0x00
+
+#define UART_INT_EN		0x01
+#define UART_INT_ID		0x02
+#define UART_FIFO_CTL		0x02
+#define UART_LINE_CTL		0x03
+#define UART_MODEM_CTL		0x04
+#define UART_LINE_STS		0x05
+#define UART_MODEM_STS		0x06
+
+#define UART_DIVISOR0		0x00
+#define UART_DIVISOR1		0x01
+
+#define BASE_BAUD		(XLP_IO_CLK/16)
+#define BAUD_DIVISOR(baud)	(BASE_BAUD / baud)
+
+/* LCR mask values */
+#define LCR_5BITS		0x00
+#define LCR_6BITS		0x01
+#define LCR_7BITS		0x02
+#define LCR_8BITS		0x03
+#define LCR_STOPB		0x04
+#define LCR_PENAB		0x08
+#define LCR_PODD		0x00
+#define LCR_PEVEN		0x10
+#define LCR_PONE		0x20
+#define LCR_PZERO		0x30
+#define LCR_SBREAK		0x40
+#define LCR_EFR_ENABLE		0xbf
+#define LCR_DLAB		0x80
+
+/* MCR mask values */
+#define MCR_DTR			0x01
+#define MCR_RTS			0x02
+#define MCR_DRS			0x04
+#define MCR_IE			0x08
+#define MCR_LOOPBACK		0x10
+
+/* FCR mask values */
+#define FCR_RCV_RST		0x02
+#define FCR_XMT_RST		0x04
+#define FCR_RX_LOW		0x00
+#define FCR_RX_MEDL		0x40
+#define FCR_RX_MEDH		0x80
+#define FCR_RX_HIGH		0xc0
+
+/* IER mask values */
+#define IER_ERXRDY		0x1
+#define IER_ETXRDY		0x2
+#define IER_ERLS		0x4
+#define IER_EMSC		0x8
+
+#if !defined(LOCORE) && !defined(__ASSEMBLY__)
+
+#define	nlm_read_uart_reg(b, r)		nlm_read_reg(b, r)
+#define	nlm_write_uart_reg(b, r, v)	nlm_write_reg(b, r, v)
+#define nlm_get_uart_pcibase(node, inst)	\
+		nlm_pcicfg_base(XLP_IO_UART_OFFSET(node, inst))
+#define nlm_get_uart_regbase(node, inst)	\
+			(nlm_get_uart_pcibase(node, inst) + XLP_IO_PCI_HDRSZ)
+
+static inline void
+nlm_uart_set_baudrate(uint64_t base, int baud)
+{
+	uint32_t lcr;
+
+	lcr = nlm_read_uart_reg(base, UART_LINE_CTL);
+
+	/* enable divisor register, and write baud values */
+	nlm_write_uart_reg(base, UART_LINE_CTL, lcr | (1 << 7));
+	nlm_write_uart_reg(base, UART_DIVISOR0,
+			(BAUD_DIVISOR(baud) & 0xff));
+	nlm_write_uart_reg(base, UART_DIVISOR1,
+			((BAUD_DIVISOR(baud) >> 8) & 0xff));
+
+	/* restore default lcr */
+	nlm_write_uart_reg(base, UART_LINE_CTL, lcr);
+}
+
+static inline void
+nlm_uart_outbyte(uint64_t base, char c)
+{
+	uint32_t lsr;
+
+	for (;;) {
+		lsr = nlm_read_uart_reg(base, UART_LINE_STS);
+		if (lsr & 0x20)
+			break;
+	}
+
+	nlm_write_uart_reg(base, UART_TX_DATA, (int)c);
+}
+
+static inline char
+nlm_uart_inbyte(uint64_t base)
+{
+	int data, lsr;
+
+	for (;;) {
+		lsr = nlm_read_uart_reg(base, UART_LINE_STS);
+		if (lsr & 0x80) { /* parity/frame/break-error - push a zero */
+			data = 0;
+			break;
+		}
+		if (lsr & 0x01) {	/* Rx data */
+			data = nlm_read_uart_reg(base, UART_RX_DATA);
+			break;
+		}
+	}
+
+	return (char)data;
+}
+
+static inline int
+nlm_uart_init(uint64_t base, int baud, int databits, int stopbits,
+	int parity, int int_en, int loopback)
+{
+	uint32_t lcr;
+
+	lcr = 0;
+	if (databits >= 8)
+		lcr |= LCR_8BITS;
+	else if (databits == 7)
+		lcr |= LCR_7BITS;
+	else if (databits == 6)
+		lcr |= LCR_6BITS;
+	else
+		lcr |= LCR_5BITS;
+
+	if (stopbits > 1)
+		lcr |= LCR_STOPB;
+
+	lcr |= parity << 3;
+
+	/* setup default lcr */
+	nlm_write_uart_reg(base, UART_LINE_CTL, lcr);
+
+	/* Reset the FIFOs */
+	nlm_write_uart_reg(base, UART_LINE_CTL, FCR_RCV_RST | FCR_XMT_RST);
+
+	nlm_uart_set_baudrate(base, baud);
+
+	if (loopback)
+		nlm_write_uart_reg(base, UART_MODEM_CTL, 0x1f);
+
+	if (int_en)
+		nlm_write_uart_reg(base, UART_INT_EN, IER_ERXRDY | IER_ETXRDY);
+
+	return 0;
+}
+#endif /* !LOCORE && !__ASSEMBLY__ */
+#endif /* __XLP_HAL_UART_H__ */
diff --git a/arch/mips/include/asm/netlogic/xlp-hal/xlp.h b/arch/mips/include/asm/netlogic/xlp-hal/xlp.h
new file mode 100644
index 0000000..5e44a0e
--- /dev/null
+++ b/arch/mips/include/asm/netlogic/xlp-hal/xlp.h
@@ -0,0 +1,71 @@
+/*
+ * Copyright 2003-2011 NetLogic Microsystems, Inc. (NetLogic). All rights
+ * reserved.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the NetLogic
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
+ * THIS SOFTWARE IS PROVIDED BY NETLOGIC ``AS IS'' AND ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL NETLOGIC OR CONTRIBUTORS BE LIABLE
+ * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
+ * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
+ * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
+ * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
+ * IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#ifndef _NLM_HAL_XLP_H
+#define _NLM_HAL_XLP_H
+
+#define	RESET_VEC_PHYS		0x1fc00000
+#define	RESET_DATA_PHYS		(RESET_VEC_PHYS + (1<<10))
+#define	BOOT_THREAD_MODE	0
+
+#define PIC_UART_0_IRQ           17
+#define PIC_UART_1_IRQ           18
+
+#ifndef __ASSEMBLY__
+/* Platform UART functions */
+struct uart_port;
+unsigned int nlm_xlr_uart_in(struct uart_port *, int);
+void nlm_xlr_uart_out(struct uart_port *, int, int);
+
+/* SMP support functions */
+struct irq_desc;
+void nlm_smp_function_ipi_handler(unsigned int irq, struct irq_desc *desc);
+void nlm_smp_resched_ipi_handler(unsigned int irq, struct irq_desc *desc);
+int nlm_wakeup_secondary_cpus(u32 wakeup_mask);
+void nlm_smp_irq_init(void);
+void nlm_boot_smp_nmi(void);
+void prom_pre_boot_secondary_cpus(void);
+void nlm_boot_core0_siblings(void);
+
+extern struct plat_smp_ops nlm_smp_ops;
+extern unsigned long nlm_common_ebase;
+extern char nlm_reset_entry[], nlm_reset_entry_end[];
+
+void xlp_mmu_init(void);
+void nlm_hal_init(void);
+int nlm_irq_to_irt(int irq);
+int nlm_irt_to_irq(int irt);
+
+#endif /* !__ASSEMBLY__ */
+#endif /* _ASM_NLM_XLP_H */
diff --git a/arch/mips/netlogic/xlp/Makefile b/arch/mips/netlogic/xlp/Makefile
new file mode 100644
index 0000000..d1023e0
--- /dev/null
+++ b/arch/mips/netlogic/xlp/Makefile
@@ -0,0 +1,4 @@
+obj-y		= setup.o platform.o irq.o setup.o time.o nlm_hal.o
+obj-$(CONFIG_EARLY_PRINTK) += xlp_console.o
+
+EXTRA_CFLAGS	+= -Werror
diff --git a/arch/mips/netlogic/xlp/irq.c b/arch/mips/netlogic/xlp/irq.c
new file mode 100644
index 0000000..60096d5
--- /dev/null
+++ b/arch/mips/netlogic/xlp/irq.c
@@ -0,0 +1,240 @@
+/*
+ * Copyright 2003-2011 NetLogic Microsystems, Inc. (NetLogic). All rights
+ * reserved.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the NetLogic
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
+ * THIS SOFTWARE IS PROVIDED BY NETLOGIC ``AS IS'' AND ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL NETLOGIC OR CONTRIBUTORS BE LIABLE
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
+#include <linux/init.h>
+#include <linux/linkage.h>
+#include <linux/interrupt.h>
+#include <linux/spinlock.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/irq.h>
+
+#include <asm/errno.h>
+#include <asm/signal.h>
+#include <asm/system.h>
+#include <asm/ptrace.h>
+#include <asm/mipsregs.h>
+#include <asm/thread_info.h>
+
+#include <asm/netlogic/mips-extns.h>
+#include <asm/netlogic/interrupt.h>
+
+#include <asm/netlogic/xlp-hal/haldefs.h>
+#include <asm/netlogic/xlp-hal/iomap.h>
+#include <asm/netlogic/xlp-hal/xlp.h>
+#include <asm/netlogic/xlp-hal/pic.h>
+/*
+ * These are the routines that handle all the low level interrupt stuff.
+ * Actions handled here are: initialization of the interrupt map, requesting of
+ * interrupt lines by handlers, dispatching if interrupts to handlers, probing
+ * for interrupt lines
+ */
+
+/* Globals */
+static uint64_t nlm_xlp_irq_mask;
+static DEFINE_SPINLOCK(nlm_common_pic_lock);
+
+static void xlp_pic_enable(struct irq_data *d)
+{
+	unsigned long flags;
+	uint64_t reg;
+	int irt, irq;
+
+	irq = d->irq;
+	irt = nlm_irq_to_irt(irq);
+	if (irt == -1)
+		return;
+
+	spin_lock_irqsave(&nlm_common_pic_lock, flags);
+
+	reg = nlm_read_pic_reg(xlp_pic_base, PIC_IRT(irt));
+	nlm_write_pic_reg(xlp_pic_base, PIC_IRT(irt),
+		      reg | (1 << 28) | (1 << 31));
+
+	spin_unlock_irqrestore(&nlm_common_pic_lock, flags);
+}
+
+static void xlp_pic_disable(struct irq_data *d)
+{
+	uint64_t reg;
+	unsigned long flags;
+	int irt, irq;
+
+	irq = d->irq;
+	irt = nlm_irq_to_irt(irq);
+	if (irt == -1)
+		return;
+
+	spin_lock_irqsave(&nlm_common_pic_lock, flags);
+	reg = nlm_read_pic_reg(xlp_pic_base, PIC_IRT(irt));
+	nlm_write_pic_reg(xlp_pic_base, PIC_IRT(irt), (reg & ~(1 << 31)));
+	spin_unlock_irqrestore(&nlm_common_pic_lock, flags);
+}
+
+static void xlp_pic_mask_ack(struct irq_data *d)
+{
+	uint64_t mask = 1ull << d->irq;
+
+	write_c0_eirr(mask);            /* ack by writing EIRR */
+}
+
+static void xlp_pic_unmask(struct irq_data *d)
+{
+	unsigned long flags;
+	int irt, irq;
+
+	irq = d->irq;
+	irt = nlm_irq_to_irt(irq);
+	if (irt == -1)
+		return;
+
+	/* If level triggered, ack it after the device condition is cleared */
+	spin_lock_irqsave(&nlm_common_pic_lock, flags);
+	nlm_pic_ack(xlp_pic_base, irt);
+	spin_unlock_irqrestore(&nlm_common_pic_lock, flags);
+}
+
+static struct irq_chip xlp_pic = {
+	.name		= "XLP-PIC",
+	.irq_enable	= xlp_pic_enable,
+	.irq_disable	= xlp_pic_disable,
+	.irq_mask_ack	= xlp_pic_mask_ack,
+	.irq_unmask	= xlp_pic_unmask,
+};
+
+static void cpuintr_disable(struct irq_data *d)
+{
+	uint64_t eimr;
+	uint64_t mask = 1ull << d->irq;
+
+	eimr = read_c0_eimr();
+	write_c0_eimr(eimr & ~mask);
+}
+
+static void cpuintr_enable(struct irq_data *d)
+{
+	uint64_t eimr;
+	uint64_t mask = 1ull << d->irq;
+
+	eimr = read_c0_eimr();
+	write_c0_eimr(eimr | mask);
+}
+
+static void cpuintr_ack(struct irq_data *d)
+{
+	uint64_t mask = 1ull << d->irq;
+
+	write_c0_eirr(mask);
+}
+
+static void cpuintr_nop(struct irq_data *d)
+{
+	WARN(d->irq >= PIC_IRQ_BASE, "Bad irq %d", d->irq);
+}
+
+/*
+ * Chip definition for CPU originated interrupts(timer, msg) and
+ * IPIs
+ */
+struct irq_chip nlm_cpu_intr = {
+	.name		= "XLP-CPU-INTR",
+	.irq_enable	= cpuintr_enable,
+	.irq_disable	= cpuintr_disable,
+	.irq_mask	= cpuintr_nop,
+	.irq_ack	= cpuintr_nop,
+	.irq_eoi	= cpuintr_ack,
+};
+
+void __init init_nlm_common_irqs(void)
+{
+	int i, irq, irt;
+
+	for (i = 0; i < PIC_IRT_FIRST_IRQ; i++)
+		irq_set_chip_and_handler(i, &nlm_cpu_intr, handle_percpu_irq);
+
+	for (i = PIC_IRT_FIRST_IRQ; i <= PIC_IRT_LAST_IRQ ; i++)
+		irq_set_chip_and_handler(i, &xlp_pic, handle_level_irq);
+
+#ifdef CONFIG_SMP
+	irq_set_chip_and_handler(IRQ_IPI_SMP_FUNCTION, &nlm_cpu_intr,
+			 nlm_smp_function_ipi_handler);
+	irq_set_chip_and_handler(IRQ_IPI_SMP_RESCHEDULE, &nlm_cpu_intr,
+			 nlm_smp_resched_ipi_handler);
+	nlm_xlp_irq_mask |=
+	    ((1ULL << IRQ_IPI_SMP_FUNCTION) | (1ULL << IRQ_IPI_SMP_RESCHEDULE));
+#endif
+
+	for (irq = PIC_IRT_FIRST_IRQ; irq <= PIC_IRT_LAST_IRQ; irq++) {
+		nlm_xlp_irq_mask |= (1ULL << irq);
+		irt = nlm_irq_to_irt(irq);
+		if (irt == -1)
+			continue;
+		nlm_pic_write_irt_direct(xlp_pic_base, irt, 1, 0, 0, irq, 1);
+	}
+
+	nlm_xlp_irq_mask |= (1ULL << IRQ_TIMER);
+}
+
+void __init arch_init_irq(void)
+{
+	/* Initialize the irq descriptors */
+	init_nlm_common_irqs();
+
+	write_c0_eimr(nlm_xlp_irq_mask);
+}
+
+void __cpuinit nlm_smp_irq_init(void)
+{
+	/* set interrupt mask for non-zero cpus */
+	write_c0_eimr(nlm_xlp_irq_mask);
+}
+
+asmlinkage void plat_irq_dispatch(void)
+{
+	uint64_t eirr;
+	int i;
+
+	eirr = read_c0_eirr() & read_c0_eimr();
+	if (eirr & (1 << IRQ_TIMER)) {
+		do_IRQ(IRQ_TIMER);
+		return;
+	}
+
+	i = __ilog2_u64(eirr);
+	if (i == -1)
+		return;
+
+	do_IRQ(i);
+}
diff --git a/arch/mips/netlogic/xlp/nlm_hal.c b/arch/mips/netlogic/xlp/nlm_hal.c
new file mode 100644
index 0000000..8130b60
--- /dev/null
+++ b/arch/mips/netlogic/xlp/nlm_hal.c
@@ -0,0 +1,85 @@
+/*
+ * Copyright 2003-2011 NetLogic Microsystems, Inc. (NetLogic). All rights
+ * reserved.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the NetLogic
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
+ * THIS SOFTWARE IS PROVIDED BY NETLOGIC ``AS IS'' AND ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL NETLOGIC OR CONTRIBUTORS BE LIABLE
+ * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
+ * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
+ * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
+ * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
+ * IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/delay.h>
+
+#include <asm/mipsregs.h>
+#include <asm/netlogic/xlp-hal/haldefs.h>
+#include <asm/netlogic/xlp-hal/iomap.h>
+#include <asm/netlogic/xlp-hal/xlp.h>
+#include <asm/netlogic/xlp-hal/pic.h>
+#include <asm/netlogic/xlp-hal/sys.h>
+
+/* These addresses are computed by the nlm_hal_init() */
+uint64_t xlp_io_base;
+uint64_t xlp_sys_base;
+uint64_t xlp_pic_base;
+
+/* Main initialization */
+void nlm_hal_init(void)
+{
+	xlp_io_base = CKSEG1ADDR(XLP_DEFAULT_IO_BASE);
+	xlp_sys_base = nlm_get_sys_regbase(0);	/* node 0 */
+	xlp_pic_base = nlm_get_pic_regbase(0);	/* node 0 */
+}
+
+int nlm_irq_to_irt(int irq)
+{
+	if (!PIC_IRQ_IS_IRT(irq))
+		return -1;
+
+	switch (irq) {
+	case PIC_UART_0_IRQ:
+		return PIC_IRT_UART_0_INDEX;
+	case PIC_UART_1_IRQ:
+		return PIC_IRT_UART_1_INDEX;
+	default:
+		return -1;
+	}
+}
+
+int nlm_irt_to_irq(int irt)
+{
+	switch (irt) {
+	case PIC_IRT_UART_0_INDEX:
+		return PIC_UART_0_IRQ;
+	case PIC_IRT_UART_1_INDEX:
+		return PIC_UART_1_IRQ;
+	default:
+		return -1;
+	}
+}
diff --git a/arch/mips/netlogic/xlp/platform.c b/arch/mips/netlogic/xlp/platform.c
new file mode 100644
index 0000000..e2e90f6
--- /dev/null
+++ b/arch/mips/netlogic/xlp/platform.c
@@ -0,0 +1,108 @@
+/*
+ * Copyright 2003-2011 NetLogic Microsystems, Inc. (NetLogic). All rights
+ * reserved.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the NetLogic
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
+ * THIS SOFTWARE IS PROVIDED BY NETLOGIC ``AS IS'' AND ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL NETLOGIC OR CONTRIBUTORS BE LIABLE
+ * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
+ * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
+ * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
+ * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
+ * IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#include <linux/dma-mapping.h>
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/serial.h>
+#include <linux/serial_8250.h>
+#include <linux/pci.h>
+#include <linux/serial_reg.h>
+#include <linux/spinlock.h>
+
+#include <asm/time.h>
+#include <asm/addrspace.h>
+#include <asm/netlogic/xlp-hal/haldefs.h>
+#include <asm/netlogic/xlp-hal/iomap.h>
+#include <asm/netlogic/xlp-hal/xlp.h>
+#include <asm/netlogic/xlp-hal/pic.h>
+#include <asm/netlogic/xlp-hal/uart.h>
+
+unsigned int nlm_xlp_uart_in(struct uart_port *p, int offset)
+{
+	 return nlm_read_reg(p->iobase, offset);
+}
+
+void nlm_xlp_uart_out(struct uart_port *p, int offset, int value)
+{
+	nlm_write_reg(p->iobase, offset, value);
+}
+
+#define PORT(_irq)					\
+	{						\
+		.irq		= _irq,			\
+		.regshift	= 2,			\
+		.iotype		= UPIO_MEM32,		\
+		.flags		= (UPF_SKIP_TEST|UPF_FIXED_TYPE|\
+					UPF_BOOT_AUTOCONF),	\
+		.uartclk	= XLP_IO_CLK,		\
+		.type		= PORT_16550A,		\
+		.serial_in	= nlm_xlp_uart_in,	\
+		.serial_out	= nlm_xlp_uart_out,	\
+	}
+
+static struct plat_serial8250_port xlp_uart_data[] = {
+	PORT(PIC_UART_0_IRQ),
+	PORT(PIC_UART_1_IRQ),
+	{},
+};
+
+static struct platform_device uart_device = {
+	.name		= "serial8250",
+	.id		= PLAT8250_DEV_PLATFORM,
+	.dev = {
+		.platform_data = xlp_uart_data,
+	},
+};
+
+static int __init nlm_platform_uart_init(void)
+{
+	unsigned long mmio;
+
+	mmio = (unsigned long)nlm_get_uart_regbase(0, 0);
+	xlp_uart_data[0].iobase = mmio;
+	xlp_uart_data[0].membase = (void __iomem *)mmio;
+	xlp_uart_data[0].mapbase = mmio;
+
+	mmio = (unsigned long)nlm_get_uart_regbase(0, 1);
+	xlp_uart_data[1].iobase = mmio;
+	xlp_uart_data[1].membase = (void __iomem *)mmio;
+	xlp_uart_data[1].mapbase = mmio;
+
+	return platform_device_register(&uart_device);
+}
+
+arch_initcall(nlm_platform_uart_init);
diff --git a/arch/mips/netlogic/xlp/setup.c b/arch/mips/netlogic/xlp/setup.c
new file mode 100644
index 0000000..ecaced7
--- /dev/null
+++ b/arch/mips/netlogic/xlp/setup.c
@@ -0,0 +1,98 @@
+/*
+ * Copyright 2003-2011 NetLogic Microsystems, Inc. (NetLogic). All rights
+ * reserved.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the NetLogic
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
+ * THIS SOFTWARE IS PROVIDED BY NETLOGIC ``AS IS'' AND ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL NETLOGIC OR CONTRIBUTORS BE LIABLE
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
+#include <linux/serial_8250.h>
+#include <linux/pm.h>
+
+#include <asm/reboot.h>
+#include <asm/time.h>
+#include <asm/bootinfo.h>
+
+#include <linux/of_fdt.h>
+#include <asm/netlogic/xlp-hal/haldefs.h>
+#include <asm/netlogic/xlp-hal/iomap.h>
+#include <asm/netlogic/xlp-hal/xlp.h>
+#include <asm/netlogic/xlp-hal/sys.h>
+
+unsigned long nlm_common_ebase = 0x0;
+
+static void nlm_linux_exit(void)
+{
+	nlm_write_sys_reg(xlp_sys_base, SYS_CHIP_RESET, 1);
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
+	return "Netlogic XLP Series";
+}
+
+void __init prom_free_prom_memory(void)
+{
+	/* Nothing yet */
+}
+
+void xlp_mmu_init(void)
+{
+	write_c0_config6(read_c0_config6() | 0x24);
+	current_cpu_data.tlbsize = ((read_c0_config6() >> 16) & 0xffff) + 1;
+	write_c0_config7(PM_DEFAULT_MASK >>
+		(13 + (ffz(PM_DEFAULT_MASK >> 13) / 2)));
+}
+
+void __init prom_init(void)
+{
+	void *fdtp;
+
+	fdtp = (void *)(long)fw_arg0;
+	xlp_mmu_init();
+	nlm_hal_init();
+	early_init_devtree(fdtp);
+
+	nlm_common_ebase = read_c0_ebase() & (~((1 << 12) - 1));
+#ifdef CONFIG_SMP
+	nlm_wakeup_secondary_cpus(0xffffffff);
+	register_smp_ops(&nlm_smp_ops);
+#endif
+}
diff --git a/arch/mips/netlogic/xlp/smp.c b/arch/mips/netlogic/xlp/smp.c
new file mode 100644
index 0000000..5fe02c5
--- /dev/null
+++ b/arch/mips/netlogic/xlp/smp.c
@@ -0,0 +1,285 @@
+/*
+ * Copyright 2003-2011 NetLogic Microsystems, Inc. (NetLogic). All rights
+ * reserved.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the NetLogic
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
+ * THIS SOFTWARE IS PROVIDED BY NETLOGIC ``AS IS'' AND ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL NETLOGIC OR CONTRIBUTORS BE LIABLE
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
+#include <asm/netlogic/xlp-hal/haldefs.h>
+#include <asm/netlogic/xlp-hal/iomap.h>
+#include <asm/netlogic/xlp-hal/xlp.h>
+#include <asm/netlogic/xlp-hal/sys.h>
+#include <asm/netlogic/xlp-hal/pic.h>
+
+void nlm_send_ipi_single(int logical_cpu, unsigned int action)
+{
+	int cpu = cpu_logical_map(logical_cpu);
+	int ipi;
+
+	if (action & SMP_CALL_FUNCTION)
+		ipi = IRQ_IPI_SMP_FUNCTION;
+	else if (action & SMP_RESCHEDULE_YOURSELF)
+		ipi = IRQ_IPI_SMP_RESCHEDULE;
+	else
+		return;
+
+	nlm_pic_send_ipi(xlp_pic_base, cpu, ipi, 0);
+}
+
+void nlm_send_ipi_mask(const struct cpumask *mask, unsigned int action)
+{
+	int cpu;
+
+	for_each_cpu(cpu, mask) {
+		nlm_send_ipi_single(cpu, action);
+	}
+}
+
+/* IRQ_IPI_SMP_FUNCTION Handler */
+void nlm_smp_function_ipi_handler(unsigned int irq, struct irq_desc *desc)
+{
+	smp_call_function_interrupt();
+	write_c0_eirr(1ull << irq);
+}
+
+/* IRQ_IPI_SMP_RESCHEDULE  handler */
+void nlm_smp_resched_ipi_handler(unsigned int irq, struct irq_desc *desc)
+{
+	scheduler_ipi();
+	write_c0_eirr(1ull << irq);
+}
+
+/*
+ * Called before going into mips code, early cpu init
+ */
+void nlm_early_init_secondary(int cpu)
+{
+	write_c0_ebase((uint32_t)nlm_common_ebase);
+	if (cpu % 4 == 0)
+		xlp_mmu_init();
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
+	local_irq_enable();
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
+unsigned long secondary_entry;
+uint32_t nlm_coremask;
+unsigned int nlm_threads_per_core;
+unsigned int nlm_threadmode;
+
+static void nlm_enable_secondary_cores(unsigned int cores_bitmap)
+{
+	uint32_t core, value, coremask;
+
+	for (core = 1; core < 8; core++) {
+		coremask = 1 << core;
+		if ((cores_bitmap & coremask) == 0)
+			continue;
+
+		/* Enable CPU clock */
+		value = nlm_read_sys_reg(xlp_sys_base, SYS_CORE_DFS_DIS_CTRL);
+		value &= ~coremask;
+		nlm_write_sys_reg(xlp_sys_base, SYS_CORE_DFS_DIS_CTRL, value);
+
+		/* Remove CPU Reset */
+		value = nlm_read_sys_reg(xlp_sys_base, SYS_CPU_RESET);
+		value &= ~coremask;
+		nlm_write_sys_reg(xlp_sys_base, SYS_CPU_RESET, value);
+
+		/* Poll for CPU to mark itself coherent */
+		do {
+			value = nlm_read_sys_reg(xlp_sys_base,
+			    SYS_CPU_NONCOHERENT_MODE);
+		} while ((value & coremask) != 0);
+	}
+}
+
+
+static void nlm_parse_cpumask(u32 cpu_mask)
+{
+	uint32_t core0_thr_mask, core_thr_mask;
+	int i;
+
+	core0_thr_mask = cpu_mask & 0xf;
+	switch (core0_thr_mask) {
+	case 1:
+		nlm_threads_per_core = 1;
+		nlm_threadmode = 0;
+		break;
+	case 3:
+		nlm_threads_per_core = 2;
+		nlm_threadmode = 2;
+		break;
+	case 0xf:
+		nlm_threads_per_core = 4;
+		nlm_threadmode = 3;
+		break;
+	default:
+		goto unsupp;
+	}
+
+	/* Verify other cores CPU masks */
+	nlm_coremask = 1;
+	for (i = 1; i < 8; i++) {
+		core_thr_mask = (cpu_mask >> (i * 4)) & 0xf;
+		if (core_thr_mask) {
+			if (core_thr_mask != core0_thr_mask)
+				goto unsupp;
+			nlm_coremask |= 1 << i;
+		}
+	}
+	return;
+
+unsupp:
+	panic("Unsupported CPU mask %x\n", cpu_mask);
+}
+
+int __cpuinit nlm_wakeup_secondary_cpus(u32 wakeup_mask)
+{
+	unsigned long reset_vec;
+	unsigned int *reset_data;
+
+	/* Update reset entry point with CPU init code */
+	reset_vec = CKSEG1ADDR(RESET_VEC_PHYS);
+	memcpy((void *)reset_vec, (void *)nlm_reset_entry,
+			(nlm_reset_entry_end - nlm_reset_entry));
+
+	/* verify the mask and setup core config variables */
+	nlm_parse_cpumask(wakeup_mask);
+
+	/* Setup CPU init parameters */
+	reset_data = (unsigned int *)CKSEG1ADDR(RESET_DATA_PHYS);
+	reset_data[BOOT_THREAD_MODE] = nlm_threadmode;
+
+	/* first wakeup core 0 siblings */
+	nlm_boot_core0_siblings();
+
+	/* enable the reset of the cores */
+	nlm_enable_secondary_cores(nlm_coremask);
+	return 0;
+}
diff --git a/arch/mips/netlogic/xlp/smpboot.S b/arch/mips/netlogic/xlp/smpboot.S
new file mode 100644
index 0000000..7dd3232
--- /dev/null
+++ b/arch/mips/netlogic/xlp/smpboot.S
@@ -0,0 +1,217 @@
+/*
+ * Copyright 2003-2011 NetLogic Microsystems, Inc. (NetLogic). All rights
+ * reserved.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the NetLogic
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
+ * THIS SOFTWARE IS PROVIDED BY NETLOGIC ``AS IS'' AND ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL NETLOGIC OR CONTRIBUTORS BE LIABLE
+ * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
+ * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
+ * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
+ * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
+ * IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#include <linux/init.h>
+
+#include <asm/asm.h>
+#include <asm/asm-offsets.h>
+#include <asm/regdef.h>
+#include <asm/mipsregs.h>
+#include <asm/stackframe.h>
+#include <asm/asmmacro.h>
+#include <asm/addrspace.h>
+
+#include <asm/netlogic/xlp-hal/iomap.h>
+#include <asm/netlogic/xlp-hal/xlp.h>
+#include <asm/netlogic/xlp-hal/sys.h>
+#include <asm/netlogic/xlp-hal/cpucontrol.h>
+
+#define	CP0_EBASE	$15
+#define SYS_CPU_COHERENT_BASE(node)	CKSEG1ADDR(XLP_DEFAULT_IO_BASE) + \
+			XLP_IO_SYS_OFFSET(node) + XLP_IO_PCI_HDRSZ + \
+			SYS_CPU_NONCOHERENT_MODE * 4
+
+.macro __config_lsu
+	li      t0, LSU_DEFEATURE
+	mfcr    t1, t0
+
+	lui     t2, 0x4080  /* Enable Unaligned Access, L2HPE */
+	or      t1, t1, t2
+	li	t2, ~0xe    /* S1RCM */
+	and	t1, t1, t2
+	mtcr    t1, t0
+
+	li      t0, SCHED_DEFEATURE
+	lui     t1, 0x0100  /* Experimental: Disable BRU accepting ALU ops */
+	mtcr    t1, t0
+.endm
+
+	.set	noreorder
+	.set	arch=xlr	/* for mfcr/mtcr, XLR is sufficient */
+
+	__CPUINIT
+EXPORT(nlm_reset_entry)
+	mfc0	t0, CP0_EBASE, 1
+	mfc0	t1, CP0_EBASE, 1
+	srl	t1, 5
+	andi	t1, 0x3			/* t1 <- node */
+	li	t2, 0x40000
+	mul	t3, t2, t1		/* t3 = node * 0x40000 */
+	srl	t0, t0, 2
+	and	t0, t0, 0x7		/* t0 <- core */
+	li	t1, 0x1
+	sll	t0, t1, t0
+	nor	t0, t0, zero		/* t0 <- ~(1 << core) */
+	li	t2, SYS_CPU_COHERENT_BASE(0)
+	add	t2, t2, t3		/* t2 <- SYS offset for node */
+	lw	t1, 0(t2)
+	and     t1, t1, t0
+	sw      t1, 0(t2)
+
+	/* read back to ensure complete */
+	lw      t1, 0(t2)
+	sync
+
+	/* Configure LSU on Non-0 Cores. */
+	__config_lsu
+
+/*
+ * Wake up sibling threads from the initial thread in
+ * a core.
+ */
+EXPORT(nlm_boot_siblings)
+	li	t0, CKSEG1ADDR(RESET_DATA_PHYS)
+	lw	t1, BOOT_THREAD_MODE(t0)	/* t1 <- thread mode */
+	li	t0, ((CPU_BLOCKID_MAP << 8) | MAP_THREADMODE)
+	mfcr	t2, t0
+	or	t2, t2, t1
+	mtcr	t2, t0
+
+	/*
+	 * The new hardware thread starts at the next instruction
+	 * For all the cases other than core 0 thread 0, we will
+         * jump to the secondary wait function.
+         */
+	mfc0	v0, CP0_EBASE, 1
+	andi	v0, 0x7f		/* v0 <- node/core */
+
+#if 1
+	/* A0 errata - Write MMU_SETUP after changing thread mode register. */
+	andi	v1, v0, 0x3		/* v1 <- thread id */
+	bnez	v1, 2f
+	nop
+
+        li	t0, MMU_SETUP
+        li	t1, 0
+        mtcr	t1, t0
+	ehb
+#endif
+
+2:	beqz	v0, 3f
+	nop
+
+	/* setup status reg */
+	mfc0	t1, CP0_STATUS
+	li	t0, ST0_BEV
+	or	t1, t0
+	xor	t1, t0
+#ifdef CONFIG_64BIT
+	ori	t1, ST0_KX
+#endif
+	mtc0	t1, CP0_STATUS
+
+	/* SETUP TLBs for a mapped kernel here */
+	PTR_LA	t0, prom_pre_boot_secondary_cpus
+	jalr	t0
+	nop
+
+	/*
+	 * For the boot CPU, we have to restore registers and
+	 * return
+	 */
+3:	dmfc0	t0, $4, 2       /* restore SP from UserLocal */
+	li	t1, 0xfadebeef
+	dmtc0	t1, $4, 2       /* restore SP from UserLocal */
+	PTR_SUBU sp, t0, PT_SIZE
+	RESTORE_ALL
+	jr   ra
+	nop
+EXPORT(nlm_reset_entry_end)
+
+EXPORT(nlm_boot_core0_siblings)	/* "Master" (n0c0t0) cpu starts from here */
+	__config_lsu
+	dmtc0   sp, $4, 2		/* SP saved in UserLocal */
+	SAVE_ALL
+	sync
+	/* find the location to which nlm_boot_siblings was relocated */
+	li	t0, CKSEG1ADDR(RESET_VEC_PHYS)
+	dla	t1, nlm_reset_entry
+	dla	t2, nlm_boot_siblings
+	dsubu	t2, t1
+	daddu	t2, t0
+	/* call it */
+	jr	t2
+	nop
+	__FINIT
+
+	__CPUINIT
+NESTED(prom_pre_boot_secondary_cpus, 16, sp)
+	.set	mips64
+	mfc0	a0, CP0_EBASE, 1	/* read ebase */
+	andi	a0, 0x3ff		/* a0 has the processor_id() */
+	sll	t0, a0, 2		/* offset in cpu array */
+
+	PTR_LA	t1, nlm_cpu_ready	/* mark CPU ready */
+	PTR_ADDU t1, t0
+	li	t2, 1
+	sw	t2, 0(t1)
+
+	PTR_LA	t1, nlm_cpu_unblock
+	PTR_ADDU t1, t0
+1:	lw	t2, 0(t1)		/* wait till unblocked */
+	bnez	t2, 2f
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	j	1b
+	nop
+
+2:	PTR_LA	t1, nlm_next_sp
+	PTR_L	sp, 0(t1)
+	PTR_LA	t1, nlm_next_gp
+	PTR_L	gp, 0(t1)
+
+	/* a0 has the processor id */
+	PTR_LA	t0, nlm_early_init_secondary
+	jalr	t0
+	nop
+
+	PTR_LA	t0, smp_bootstrap
+	jr	t0
+	nop
+END(prom_pre_boot_secondary_cpus)
+	__FINIT
diff --git a/arch/mips/netlogic/xlp/time.c b/arch/mips/netlogic/xlp/time.c
new file mode 100644
index 0000000..1ccae37
--- /dev/null
+++ b/arch/mips/netlogic/xlp/time.c
@@ -0,0 +1,74 @@
+/*
+ * Copyright 2003-2011 NetLogic Microsystems, Inc. (NetLogic). All rights
+ * reserved.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the NetLogic
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
+ * THIS SOFTWARE IS PROVIDED BY NETLOGIC ``AS IS'' AND ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL NETLOGIC OR CONTRIBUTORS BE LIABLE
+ * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
+ * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
+ * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
+ * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
+ * IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#include <linux/init.h>
+
+#include <asm/div64.h>
+#include <asm/time.h>
+#include <asm/netlogic/interrupt.h>
+#include <asm/netlogic/psb-bootinfo.h>
+
+#include <asm/netlogic/xlp-hal/haldefs.h>
+#include <asm/netlogic/xlp-hal/iomap.h>
+#include <asm/netlogic/xlp-hal/sys.h>
+
+unsigned int __cpuinit get_c0_compare_int(void)
+{
+	return IRQ_TIMER;
+}
+
+static unsigned int xlp_get_cpu_frequency(void)
+{
+	unsigned int pll_divf, pll_divr, dfs_div, denom;
+	unsigned int val;
+	uint64_t num;
+
+	val = nlm_read_sys_reg(xlp_sys_base, SYS_POWER_ON_RESET_CFG);
+	pll_divf = (val >> 10) & 0x7f;
+	pll_divr = (val >> 8)  & 0x3;
+	dfs_div  = (val >> 17) & 0x3;
+
+	num = pll_divf + 1;
+	denom = 3 * (pll_divr + 1) * (1 << (dfs_div + 1));
+	num = num * 800000000ULL;
+	do_div(num, denom);
+	return (unsigned int)num;
+}
+
+void __init plat_time_init(void)
+{
+	mips_hpt_frequency = xlp_get_cpu_frequency();
+	pr_info("MIPS counter frequency [%ld]\n",
+			(unsigned long)mips_hpt_frequency);
+}
diff --git a/arch/mips/netlogic/xlp/xlp_console.c b/arch/mips/netlogic/xlp/xlp_console.c
new file mode 100644
index 0000000..cff97f1
--- /dev/null
+++ b/arch/mips/netlogic/xlp/xlp_console.c
@@ -0,0 +1,50 @@
+/*
+ * Copyright 2003-2011 NetLogic Microsystems, Inc. (NetLogic). All rights
+ * reserved.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the NetLogic
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
+ * THIS SOFTWARE IS PROVIDED BY NETLOGIC ``AS IS'' AND ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL NETLOGIC OR CONTRIBUTORS BE LIABLE
+ * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
+ * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
+ * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
+ * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
+ * IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#include <linux/types.h>
+#include <asm/mipsregs.h>
+
+#include <asm/netlogic/xlp-hal/haldefs.h>
+#include <asm/netlogic/xlp-hal/iomap.h>
+#include <asm/netlogic/xlp-hal/uart.h>
+
+void prom_putchar(char c)
+{
+	uint64_t mmio;
+
+	mmio = nlm_get_uart_regbase(0, 0);
+	while (nlm_read_uart_reg(mmio, UART_LINE_STS) == 0)
+		;
+	nlm_write_reg(mmio, UART_TX_DATA, c);
+}
-- 
1.7.4.1
