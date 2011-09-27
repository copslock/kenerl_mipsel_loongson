Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Sep 2011 10:30:37 +0200 (CEST)
Received: from mx1.netlogicmicro.com ([12.203.210.36]:2771 "EHLO
        orion5.netlogicmicro.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491803Ab1I0IaU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Sep 2011 10:30:20 +0200
X-TM-IMSS-Message-ID: <3264210b00001095@netlogicmicro.com>
Received: from hqcas01.netlogicmicro.com ([10.10.50.14]) by netlogicmicro.com ([10.10.16.19]) with ESMTP (TREND IMSS SMTP Service 7.0; TLS: TLSv1/SSLv3,128bits,AES128-SHA) id 3264210b00001095 ; Tue, 27 Sep 2011 01:30:11 -0700
Received: from orion8.netlogicmicro.com (10.10.16.60) by
 hqcas01.netlogicmicro.com (10.10.50.14) with Microsoft SMTP Server id
 14.1.339.1; Tue, 27 Sep 2011 01:30:11 -0700
Received: from jayachandranc.netlogicmicro.com ([10.7.0.77]) by
 orion8.netlogicmicro.com with Microsoft SMTPSVC(6.0.3790.3959);         Tue, 27 Sep
 2011 01:29:52 -0700
Date:   Tue, 27 Sep 2011 14:08:42 +0530
From:   Jayachandran C <jayachandranc@netlogicmicro.com>
To:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>
Subject: [PATCH 4/9] MIPS: Netlogic: Move code common with XLP to common/
Message-ID: <ba9ff6cf818f20e451f5028be316486e9c464566.1317111127.git.jayachandranc@netlogicmicro.com>
References: <cover.1317111127.git.jayachandranc@netlogicmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1317111127.git.jayachandranc@netlogicmicro.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-OriginalArrivalTime: 27 Sep 2011 08:29:52.0638 (UTC) FILETIME=[A0F599E0:01CC7CEF]
X-archive-position: 31175
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 15276

- Move code that can be shared with XLP (irq.c, smp.c, time.c and
  xlr_console.c) to arch/mips/netlogic/common
- Add asm/netlogic/haldefs.h and asm/netlogic/common.h for common and
  io functions shared with XLP
- remove type 'nlm_reg_t *' and use uint64_t for mmio offsets
- Move XLR specific code in smp.c to xlr/wakeup.c
- Move XLR specific PCI code from irq.c to mips/pci/pci-xlr.c
- Provide API for pic functions called from common/irq.c

Signed-off-by: Jayachandran C <jayachandranc@netlogicmicro.com>
---
 arch/mips/include/asm/netlogic/common.h    |   56 +++++
 arch/mips/include/asm/netlogic/haldefs.h   |  142 +++++++++++++
 arch/mips/include/asm/netlogic/xlr/iomap.h |   22 --
 arch/mips/include/asm/netlogic/xlr/pic.h   |   69 +++++--
 arch/mips/include/asm/netlogic/xlr/xlr.h   |   11 -
 arch/mips/netlogic/Makefile                |    2 +
 arch/mips/netlogic/Platform                |    2 +-
 arch/mips/netlogic/common/Makefile         |    3 +
 arch/mips/netlogic/common/earlycons.c      |   51 +++++
 arch/mips/netlogic/common/irq.c            |  230 +++++++++++++++++++++
 arch/mips/netlogic/common/smp.c            |  184 +++++++++++++++++
 arch/mips/netlogic/common/time.c           |   51 +++++
 arch/mips/netlogic/xlr/Makefile            |    5 +-
 arch/mips/netlogic/xlr/irq.c               |  305 ----------------------------
 arch/mips/netlogic/xlr/platform.c          |   31 ++--
 arch/mips/netlogic/xlr/setup.c             |   24 ++-
 arch/mips/netlogic/xlr/smp.c               |  216 --------------------
 arch/mips/netlogic/xlr/smpboot.S           |    6 +-
 arch/mips/netlogic/xlr/time.c              |   51 -----
 arch/mips/netlogic/xlr/wakeup.c            |   71 +++++++
 arch/mips/netlogic/xlr/xlr_console.c       |   46 ----
 arch/mips/pci/pci-xlr.c                    |   77 +++++++
 22 files changed, 956 insertions(+), 699 deletions(-)
 create mode 100644 arch/mips/include/asm/netlogic/common.h
 create mode 100644 arch/mips/include/asm/netlogic/haldefs.h
 create mode 100644 arch/mips/netlogic/Makefile
 create mode 100644 arch/mips/netlogic/common/Makefile
 create mode 100644 arch/mips/netlogic/common/earlycons.c
 create mode 100644 arch/mips/netlogic/common/irq.c
 create mode 100644 arch/mips/netlogic/common/smp.c
 create mode 100644 arch/mips/netlogic/common/time.c
 delete mode 100644 arch/mips/netlogic/xlr/irq.c
 delete mode 100644 arch/mips/netlogic/xlr/smp.c
 delete mode 100644 arch/mips/netlogic/xlr/time.c
 create mode 100644 arch/mips/netlogic/xlr/wakeup.c
 delete mode 100644 arch/mips/netlogic/xlr/xlr_console.c

diff --git a/arch/mips/include/asm/netlogic/common.h b/arch/mips/include/asm/netlogic/common.h
new file mode 100644
index 0000000..e5bdf8c
--- /dev/null
+++ b/arch/mips/include/asm/netlogic/common.h
@@ -0,0 +1,56 @@
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
+#ifndef _NETLOGIC_COMMON_H_
+#define _NETLOGIC_COMMON_H_
+
+/*
+ * Common SMP definitions
+ */
+struct irq_desc;
+extern struct plat_smp_ops nlm_smp_ops;
+extern char nlm_reset_entry[], nlm_reset_entry_end[];
+void nlm_smp_function_ipi_handler(unsigned int irq, struct irq_desc *desc);
+void nlm_smp_resched_ipi_handler(unsigned int irq, struct irq_desc *desc);
+void nlm_smp_irq_init(void);
+void prom_pre_boot_secondary_cpus(void);
+int nlm_wakeup_secondary_cpus(u32 wakeup_mask);
+void nlm_boot_smp_nmi(void);
+
+/*
+ * Misc.
+ */
+extern unsigned long nlm_common_ebase;
+unsigned int	 nlm_get_cpu_frequency(void);
+#endif /* _NETLOGIC_COMMON_H_ */
diff --git a/arch/mips/include/asm/netlogic/haldefs.h b/arch/mips/include/asm/netlogic/haldefs.h
new file mode 100644
index 0000000..e3264c1
--- /dev/null
+++ b/arch/mips/include/asm/netlogic/haldefs.h
@@ -0,0 +1,142 @@
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
+extern uint64_t nlm_io_base;
+
+static inline uint64_t
+nlm_mmio_base(uint32_t devoffset)
+{
+	return nlm_io_base + devoffset;
+}
+
+#endif
diff --git a/arch/mips/include/asm/netlogic/xlr/iomap.h b/arch/mips/include/asm/netlogic/xlr/iomap.h
index 2e3a4dd..2e768f0 100644
--- a/arch/mips/include/asm/netlogic/xlr/iomap.h
+++ b/arch/mips/include/asm/netlogic/xlr/iomap.h
@@ -106,26 +106,4 @@
 #define DEFAULT_HT_TYPE0_CFG_BASE       0x16000000
 #define DEFAULT_HT_TYPE1_CFG_BASE       0x17000000
 
-#ifndef __ASSEMBLY__
-#include <linux/types.h>
-#include <asm/byteorder.h>
-
-typedef volatile __u32 nlm_reg_t;
-extern unsigned long netlogic_io_base;
-
-/* FIXME read once in write_reg */
-#ifdef CONFIG_CPU_LITTLE_ENDIAN
-#define netlogic_read_reg(base, offset)		((base)[(offset)])
-#define netlogic_write_reg(base, offset, value)	((base)[(offset)] = (value))
-#else
-#define netlogic_read_reg(base, offset)		(be32_to_cpu((base)[(offset)]))
-#define netlogic_write_reg(base, offset, value) \
-				((base)[(offset)] = cpu_to_be32((value)))
-#endif
-
-#define netlogic_read_reg_le32(base, offset) (le32_to_cpu((base)[(offset)]))
-#define netlogic_write_reg_le32(base, offset, value) \
-				((base)[(offset)] = cpu_to_le32((value)))
-#define netlogic_io_mmio(offset) ((nlm_reg_t *)(netlogic_io_base+(offset)))
-#endif /* __ASSEMBLY__ */
 #endif
diff --git a/arch/mips/include/asm/netlogic/xlr/pic.h b/arch/mips/include/asm/netlogic/xlr/pic.h
index 5cceb74..868013e 100644
--- a/arch/mips/include/asm/netlogic/xlr/pic.h
+++ b/arch/mips/include/asm/netlogic/xlr/pic.h
@@ -193,39 +193,72 @@
 /* end XLS */
 
 #ifndef __ASSEMBLY__
-static inline void pic_send_ipi(u32 ipi)
+
+#define PIC_IRQ_IS_EDGE_TRIGGERED(irq)	(((irq) >= PIC_TIMER_0_IRQ) && \
+					((irq) <= PIC_TIMER_7_IRQ))
+#define PIC_IRQ_IS_IRT(irq)		(((irq) >= PIC_IRT_FIRST_IRQ) && \
+					((irq) <= PIC_IRT_LAST_IRQ))
+
+static inline int
+nlm_irq_to_irt(int irq)
 {
-	nlm_reg_t *mmio = netlogic_io_mmio(NETLOGIC_IO_PIC_OFFSET);
+	if (PIC_IRQ_IS_IRT(irq) == 0)
+		return -1;
 
-	netlogic_write_reg(mmio, PIC_IPI, ipi);
+	return PIC_IRQ_TO_INTR(irq);
 }
 
-static inline u32 pic_read_control(void)
+static inline int
+nlm_irt_to_irq(int irt)
 {
-	nlm_reg_t *mmio = netlogic_io_mmio(NETLOGIC_IO_PIC_OFFSET);
 
-	return netlogic_read_reg(mmio, PIC_CTRL);
+	return PIC_INTR_TO_IRQ(irt);
 }
 
-static inline void pic_write_control(u32 control)
+static inline void
+nlm_pic_enable_irt(uint64_t base, int irt)
 {
-	nlm_reg_t *mmio = netlogic_io_mmio(NETLOGIC_IO_PIC_OFFSET);
+	uint32_t reg;
 
-	netlogic_write_reg(mmio, PIC_CTRL, control);
+	reg = nlm_read_reg(base, PIC_IRT_1(irt));
+	nlm_write_reg(base, PIC_IRT_1(irt), reg | (1u << 31));
 }
 
-static inline void pic_update_control(u32 control)
+static inline void
+nlm_pic_disable_irt(uint64_t base, int irt)
 {
-	nlm_reg_t *mmio = netlogic_io_mmio(NETLOGIC_IO_PIC_OFFSET);
+	uint32_t reg;
 
-	netlogic_write_reg(mmio, PIC_CTRL,
-		(control | netlogic_read_reg(mmio, PIC_CTRL)));
+	reg = nlm_read_reg(base, PIC_IRT_1(irt));
+	nlm_write_reg(base, PIC_IRT_1(irt), reg & ~(1u << 31));
 }
 
-#define PIC_IRQ_IS_EDGE_TRIGGERED(irq)	(((irq) >= PIC_TIMER_0_IRQ) && \
-					((irq) <= PIC_TIMER_7_IRQ))
-#define PIC_IRQ_IS_IRT(irq)		(((irq) >= PIC_IRT_FIRST_IRQ) && \
-					((irq) <= PIC_IRT_LAST_IRQ))
-#endif
+static inline void
+nlm_pic_send_ipi(uint64_t base, int hwt, int irq, int nmi)
+{
+	unsigned int tid, pid;
+
+	tid = hwt & 0x3;
+	pid = (hwt >> 2) & 0x07;
+	nlm_write_reg(base, PIC_IPI,
+		(pid << 20) | (tid << 16) | (nmi << 8) | irq);
+}
+
+static inline void
+nlm_pic_ack(uint64_t base, int irt)
+{
+	nlm_write_reg(base, PIC_INT_ACK, 1u << irt);
+}
 
+static inline void
+nlm_pic_init_irt(uint64_t base, int irt, int irq, int hwt)
+{
+	nlm_write_reg(base, PIC_IRT_0(irt), (1u << hwt));
+	/* local scheduling, invalid, level by default */
+	nlm_write_reg(base, PIC_IRT_1(irt),
+		(1 << 30) | (1 << 6) | irq);
+}
+
+extern uint64_t nlm_pic_base;
+#endif
 #endif /* _ASM_NLM_XLR_PIC_H */
diff --git a/arch/mips/include/asm/netlogic/xlr/xlr.h b/arch/mips/include/asm/netlogic/xlr/xlr.h
index 3e63726..f4d3f7c 100644
--- a/arch/mips/include/asm/netlogic/xlr/xlr.h
+++ b/arch/mips/include/asm/netlogic/xlr/xlr.h
@@ -40,17 +40,6 @@ struct uart_port;
 unsigned int nlm_xlr_uart_in(struct uart_port *, int);
 void nlm_xlr_uart_out(struct uart_port *, int, int);
 
-/* SMP support functions */
-struct irq_desc;
-void nlm_smp_function_ipi_handler(unsigned int irq, struct irq_desc *desc);
-void nlm_smp_resched_ipi_handler(unsigned int irq, struct irq_desc *desc);
-int nlm_wakeup_secondary_cpus(u32 wakeup_mask);
-void nlm_smp_irq_init(void);
-void nlm_boot_smp_nmi(void);
-void prom_pre_boot_secondary_cpus(void);
-
-extern struct plat_smp_ops nlm_smp_ops;
-extern unsigned long nlm_common_ebase;
 
 /* XLS B silicon "Rook" */
 static inline unsigned int nlm_chip_is_xls_b(void)
diff --git a/arch/mips/netlogic/Makefile b/arch/mips/netlogic/Makefile
new file mode 100644
index 0000000..797326d
--- /dev/null
+++ b/arch/mips/netlogic/Makefile
@@ -0,0 +1,2 @@
+obj-$(CONFIG_NLM_COMMON)	+=	common/
+obj-$(CONFIG_CPU_XLR)		+=	xlr/
diff --git a/arch/mips/netlogic/Platform b/arch/mips/netlogic/Platform
index 18aaf43..7811b10 100644
--- a/arch/mips/netlogic/Platform
+++ b/arch/mips/netlogic/Platform
@@ -12,5 +12,5 @@ cflags-$(CONFIG_CPU_XLR)	+= $(call cc-option,-march=xlr,-march=mips64)
 #
 # NETLOGIC processor support
 #
-platform-$(CONFIG_CPU_XLR)  	+= netlogic/xlr
+platform-$(CONFIG_NLM_COMMON)  	+= netlogic/
 load-$(CONFIG_NLM_COMMON)  	+= 0xffffffff80100000
diff --git a/arch/mips/netlogic/common/Makefile b/arch/mips/netlogic/common/Makefile
new file mode 100644
index 0000000..d421578
--- /dev/null
+++ b/arch/mips/netlogic/common/Makefile
@@ -0,0 +1,3 @@
+obj-y				+= irq.o time.o
+obj-$(CONFIG_SMP)		+= smp.o
+obj-$(CONFIG_EARLY_PRINTK)	+= earlycons.o
diff --git a/arch/mips/netlogic/common/earlycons.c b/arch/mips/netlogic/common/earlycons.c
new file mode 100644
index 0000000..28c8fa7
--- /dev/null
+++ b/arch/mips/netlogic/common/earlycons.c
@@ -0,0 +1,51 @@
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
+#include <linux/serial_reg.h>
+
+#include <asm/mipsregs.h>
+#include <asm/netlogic/haldefs.h>
+
+#include <asm/netlogic/xlr/iomap.h>
+
+void prom_putchar(char c)
+{
+	uint64_t uartbase;
+
+	uartbase = nlm_mmio_base(NETLOGIC_IO_UART_0_OFFSET);
+	while (nlm_read_reg(uartbase, UART_LSR) == 0)
+		;
+	nlm_write_reg(uartbase, UART_TX, c);
+}
diff --git a/arch/mips/netlogic/common/irq.c b/arch/mips/netlogic/common/irq.c
new file mode 100644
index 0000000..dd0dd62
--- /dev/null
+++ b/arch/mips/netlogic/common/irq.c
@@ -0,0 +1,230 @@
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
+#include <asm/netlogic/haldefs.h>
+#include <asm/netlogic/common.h>
+
+#include <asm/netlogic/xlr/iomap.h>
+#include <asm/netlogic/xlr/pic.h>
+/*
+ * These are the routines that handle all the low level interrupt stuff.
+ * Actions handled here are: initialization of the interrupt map, requesting of
+ * interrupt lines by handlers, dispatching if interrupts to handlers, probing
+ * for interrupt lines
+ */
+
+/* Globals */
+static uint64_t nlm_irq_mask;
+static DEFINE_SPINLOCK(nlm_pic_lock);
+
+static void xlp_pic_enable(struct irq_data *d)
+{
+	unsigned long flags;
+	int irt;
+
+	irt = nlm_irq_to_irt(d->irq);
+	if (irt == -1)
+		return;
+	spin_lock_irqsave(&nlm_pic_lock, flags);
+	nlm_pic_enable_irt(nlm_pic_base, irt);
+	spin_unlock_irqrestore(&nlm_pic_lock, flags);
+}
+
+static void xlp_pic_disable(struct irq_data *d)
+{
+	unsigned long flags;
+	int irt;
+
+	irt = nlm_irq_to_irt(d->irq);
+	if (irt == -1)
+		return;
+	spin_lock_irqsave(&nlm_pic_lock, flags);
+	nlm_pic_disable_irt(nlm_pic_base, irt);
+	spin_unlock_irqrestore(&nlm_pic_lock, flags);
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
+	void *hd = irq_data_get_irq_handler_data(d);
+	int irt;
+
+	irt = nlm_irq_to_irt(d->irq);
+	if (irt == -1)
+		return;
+
+	if (hd) {
+		void (*extra_ack)(void *) = hd;
+		extra_ack(d);
+	}
+	/* Ack is a single write, no need to lock */
+	nlm_pic_ack(nlm_pic_base, irt);
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
+	nlm_irq_mask |=
+	    ((1ULL << IRQ_IPI_SMP_FUNCTION) | (1ULL << IRQ_IPI_SMP_RESCHEDULE));
+#endif
+
+	for (irq = PIC_IRT_FIRST_IRQ; irq <= PIC_IRT_LAST_IRQ; irq++) {
+		irt = nlm_irq_to_irt(irq);
+		if (irt == -1)
+			continue;
+		nlm_irq_mask |= (1ULL << irq);
+		nlm_pic_init_irt(nlm_pic_base, irt, irq, 0);
+	}
+
+	nlm_irq_mask |= (1ULL << IRQ_TIMER);
+}
+
+void __init arch_init_irq(void)
+{
+	/* Initialize the irq descriptors */
+	init_nlm_common_irqs();
+
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
diff --git a/arch/mips/netlogic/common/smp.c b/arch/mips/netlogic/common/smp.c
new file mode 100644
index 0000000..68171fe
--- /dev/null
+++ b/arch/mips/netlogic/common/smp.c
@@ -0,0 +1,184 @@
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
+#include <asm/netlogic/haldefs.h>
+#include <asm/netlogic/common.h>
+
+#include <asm/netlogic/xlr/iomap.h>
+#include <asm/netlogic/xlr/pic.h>
+
+void nlm_send_ipi_single(int logical_cpu, unsigned int action)
+{
+	int cpu = cpu_logical_map(logical_cpu);
+
+	if (action & SMP_CALL_FUNCTION)
+		nlm_pic_send_ipi(nlm_pic_base, cpu, IRQ_IPI_SMP_FUNCTION, 0);
+	if (action & SMP_RESCHEDULE_YOURSELF)
+		nlm_pic_send_ipi(nlm_pic_base, cpu, IRQ_IPI_SMP_RESCHEDULE, 0);
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
+#ifdef NLM_XLP
+	if (cpu % 4 == 0)
+		xlp_mmu_init();
+#endif
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
diff --git a/arch/mips/netlogic/common/time.c b/arch/mips/netlogic/common/time.c
new file mode 100644
index 0000000..bd3e498
--- /dev/null
+++ b/arch/mips/netlogic/common/time.c
@@ -0,0 +1,51 @@
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
+#include <asm/time.h>
+#include <asm/netlogic/interrupt.h>
+#include <asm/netlogic/common.h>
+
+unsigned int __cpuinit get_c0_compare_int(void)
+{
+	return IRQ_TIMER;
+}
+
+void __init plat_time_init(void)
+{
+	mips_hpt_frequency = nlm_get_cpu_frequency();
+	pr_info("MIPS counter frequency [%ld]\n",
+			(unsigned long)mips_hpt_frequency);
+}
diff --git a/arch/mips/netlogic/xlr/Makefile b/arch/mips/netlogic/xlr/Makefile
index 29f1fd5..df245c6 100644
--- a/arch/mips/netlogic/xlr/Makefile
+++ b/arch/mips/netlogic/xlr/Makefile
@@ -1,3 +1,2 @@
-obj-y				+= setup.o platform.o irq.o setup.o time.o
-obj-$(CONFIG_SMP)		+= smp.o smpboot.o
-obj-$(CONFIG_EARLY_PRINTK)	+= xlr_console.o
+obj-y				+= setup.o platform.o
+obj-$(CONFIG_SMP)		+= smpboot.o wakeup.o
diff --git a/arch/mips/netlogic/xlr/irq.c b/arch/mips/netlogic/xlr/irq.c
deleted file mode 100644
index fc822c8..0000000
--- a/arch/mips/netlogic/xlr/irq.c
+++ /dev/null
@@ -1,305 +0,0 @@
-/*
- * Copyright 2003-2011 NetLogic Microsystems, Inc. (NetLogic). All rights
- * reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the NetLogic
- * license below:
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- *
- * 1. Redistributions of source code must retain the above copyright
- *    notice, this list of conditions and the following disclaimer.
- * 2. Redistributions in binary form must reproduce the above copyright
- *    notice, this list of conditions and the following disclaimer in
- *    the documentation and/or other materials provided with the
- *    distribution.
- *
- * THIS SOFTWARE IS PROVIDED BY NETLOGIC ``AS IS'' AND ANY EXPRESS OR
- * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
- * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
- * ARE DISCLAIMED. IN NO EVENT SHALL NETLOGIC OR CONTRIBUTORS BE LIABLE
- * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
- * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
- * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
- * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
- * IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/linkage.h>
-#include <linux/interrupt.h>
-#include <linux/spinlock.h>
-#include <linux/mm.h>
-#include <linux/msi.h>
-#include <linux/irq.h>
-#include <linux/irqdesc.h>
-#include <linux/pci.h>
-
-#include <asm/mipsregs.h>
-
-#include <asm/netlogic/xlr/msidef.h>
-#include <asm/netlogic/xlr/iomap.h>
-#include <asm/netlogic/xlr/pic.h>
-#include <asm/netlogic/xlr/xlr.h>
-
-#include <asm/netlogic/interrupt.h>
-#include <asm/netlogic/mips-extns.h>
-
-static u64 nlm_irq_mask;
-static DEFINE_SPINLOCK(nlm_pic_lock);
-
-static void xlr_pic_enable(struct irq_data *d)
-{
-	nlm_reg_t *mmio = netlogic_io_mmio(NETLOGIC_IO_PIC_OFFSET);
-	unsigned long flags;
-	nlm_reg_t reg;
-	int irq = d->irq;
-
-	WARN(!PIC_IRQ_IS_IRT(irq), "Bad irq %d", irq);
-
-	spin_lock_irqsave(&nlm_pic_lock, flags);
-	reg = netlogic_read_reg(mmio, PIC_IRT_1_BASE + irq - PIC_IRQ_BASE);
-	netlogic_write_reg(mmio, PIC_IRT_1_BASE + irq - PIC_IRQ_BASE,
-			  reg | (1 << 6) | (1 << 30) | (1 << 31));
-	spin_unlock_irqrestore(&nlm_pic_lock, flags);
-}
-
-static void xlr_pic_mask(struct irq_data *d)
-{
-	nlm_reg_t *mmio = netlogic_io_mmio(NETLOGIC_IO_PIC_OFFSET);
-	unsigned long flags;
-	nlm_reg_t reg;
-	int irq = d->irq;
-
-	WARN(!PIC_IRQ_IS_IRT(irq), "Bad irq %d", irq);
-
-	spin_lock_irqsave(&nlm_pic_lock, flags);
-	reg = netlogic_read_reg(mmio, PIC_IRT_1_BASE + irq - PIC_IRQ_BASE);
-	netlogic_write_reg(mmio, PIC_IRT_1_BASE + irq - PIC_IRQ_BASE,
-			  reg | (1 << 6) | (1 << 30) | (0 << 31));
-	spin_unlock_irqrestore(&nlm_pic_lock, flags);
-}
-
-#ifdef CONFIG_PCI
-/* Extra ACK needed for XLR on chip PCI controller */
-static void xlr_pci_ack(struct irq_data *d)
-{
-	nlm_reg_t *pci_mmio = netlogic_io_mmio(NETLOGIC_IO_PCIX_OFFSET);
-
-	netlogic_read_reg(pci_mmio, (0x140 >> 2));
-}
-
-/* Extra ACK needed for XLS on chip PCIe controller */
-static void xls_pcie_ack(struct irq_data *d)
-{
-	nlm_reg_t *pcie_mmio_le = netlogic_io_mmio(NETLOGIC_IO_PCIE_1_OFFSET);
-
-	switch (d->irq) {
-	case PIC_PCIE_LINK0_IRQ:
-		netlogic_write_reg(pcie_mmio_le, (0x90 >> 2), 0xffffffff);
-		break;
-	case PIC_PCIE_LINK1_IRQ:
-		netlogic_write_reg(pcie_mmio_le, (0x94 >> 2), 0xffffffff);
-		break;
-	case PIC_PCIE_LINK2_IRQ:
-		netlogic_write_reg(pcie_mmio_le, (0x190 >> 2), 0xffffffff);
-		break;
-	case PIC_PCIE_LINK3_IRQ:
-		netlogic_write_reg(pcie_mmio_le, (0x194 >> 2), 0xffffffff);
-		break;
-	}
-}
-
-/* For XLS B silicon, the 3,4 PCI interrupts are different */
-static void xls_pcie_ack_b(struct irq_data *d)
-{
-	nlm_reg_t *pcie_mmio_le = netlogic_io_mmio(NETLOGIC_IO_PCIE_1_OFFSET);
-
-	switch (d->irq) {
-	case PIC_PCIE_LINK0_IRQ:
-		netlogic_write_reg(pcie_mmio_le, (0x90 >> 2), 0xffffffff);
-		break;
-	case PIC_PCIE_LINK1_IRQ:
-		netlogic_write_reg(pcie_mmio_le, (0x94 >> 2), 0xffffffff);
-		break;
-	case PIC_PCIE_XLSB0_LINK2_IRQ:
-		netlogic_write_reg(pcie_mmio_le, (0x190 >> 2), 0xffffffff);
-		break;
-	case PIC_PCIE_XLSB0_LINK3_IRQ:
-		netlogic_write_reg(pcie_mmio_le, (0x194 >> 2), 0xffffffff);
-		break;
-	}
-}
-#endif
-
-static void xlr_pic_ack(struct irq_data *d)
-{
-	unsigned long flags;
-	nlm_reg_t *mmio;
-	int irq = d->irq;
-	void *hd = irq_data_get_irq_handler_data(d);
-
-	WARN(!PIC_IRQ_IS_IRT(irq), "Bad irq %d", irq);
-
-	if (hd) {
-		void (*extra_ack)(void *) = hd;
-		extra_ack(d);
-	}
-	mmio = netlogic_io_mmio(NETLOGIC_IO_PIC_OFFSET);
-	spin_lock_irqsave(&nlm_pic_lock, flags);
-	netlogic_write_reg(mmio, PIC_INT_ACK, (1 << (irq - PIC_IRQ_BASE)));
-	spin_unlock_irqrestore(&nlm_pic_lock, flags);
-}
-
-/*
- * This chip definition handles interrupts routed thru the XLR
- * hardware PIC, currently IRQs 8-39 are mapped to hardware intr
- * 0-31 wired the XLR PIC
- */
-static struct irq_chip xlr_pic = {
-	.name		= "XLR-PIC",
-	.irq_enable	= xlr_pic_enable,
-	.irq_mask	= xlr_pic_mask,
-	.irq_ack	= xlr_pic_ack,
-};
-
-static void rsvd_irq_handler(struct irq_data *d)
-{
-	WARN(d->irq >= PIC_IRQ_BASE, "Bad irq %d", d->irq);
-}
-
-/*
- * Chip definition for CPU originated interrupts(timer, msg) and
- * IPIs
- */
-struct irq_chip nlm_cpu_intr = {
-	.name		= "XLR-CPU-INTR",
-	.irq_enable	= rsvd_irq_handler,
-	.irq_mask	= rsvd_irq_handler,
-	.irq_ack	= rsvd_irq_handler,
-};
-
-void __init init_xlr_irqs(void)
-{
-	nlm_reg_t *mmio = netlogic_io_mmio(NETLOGIC_IO_PIC_OFFSET);
-	uint32_t thread_mask = 1;
-	int level, i;
-
-	pr_info("Interrupt thread mask [%x]\n", thread_mask);
-	for (i = 0; i < PIC_NUM_IRTS; i++) {
-		level = PIC_IRQ_IS_EDGE_TRIGGERED(i);
-
-		/* Bind all PIC irqs to boot cpu */
-		netlogic_write_reg(mmio, PIC_IRT_0_BASE + i, thread_mask);
-
-		/*
-		 * Use local scheduling and high polarity for all IRTs
-		 * Invalidate all IRTs, by default
-		 */
-		netlogic_write_reg(mmio, PIC_IRT_1_BASE + i,
-				(level << 30) | (1 << 6) | (PIC_IRQ_BASE + i));
-	}
-
-	/* Make all IRQs as level triggered by default */
-	for (i = 0; i < NR_IRQS; i++) {
-		if (PIC_IRQ_IS_IRT(i))
-			irq_set_chip_and_handler(i, &xlr_pic, handle_level_irq);
-		else
-			irq_set_chip_and_handler(i, &nlm_cpu_intr,
-						handle_percpu_irq);
-	}
-#ifdef CONFIG_SMP
-	irq_set_chip_and_handler(IRQ_IPI_SMP_FUNCTION, &nlm_cpu_intr,
-			 nlm_smp_function_ipi_handler);
-	irq_set_chip_and_handler(IRQ_IPI_SMP_RESCHEDULE, &nlm_cpu_intr,
-			 nlm_smp_resched_ipi_handler);
-	nlm_irq_mask |=
-	    ((1ULL << IRQ_IPI_SMP_FUNCTION) | (1ULL << IRQ_IPI_SMP_RESCHEDULE));
-#endif
-
-#ifdef CONFIG_PCI
-	/*
-	 * For PCI interrupts, we need to ack the PIC controller too, overload
-	 * irq handler data to do this
-	 */
-	if (nlm_chip_is_xls()) {
-		if (nlm_chip_is_xls_b()) {
-			irq_set_handler_data(PIC_PCIE_LINK0_IRQ,
-							xls_pcie_ack_b);
-			irq_set_handler_data(PIC_PCIE_LINK1_IRQ,
-							xls_pcie_ack_b);
-			irq_set_handler_data(PIC_PCIE_XLSB0_LINK2_IRQ,
-							xls_pcie_ack_b);
-			irq_set_handler_data(PIC_PCIE_XLSB0_LINK3_IRQ,
-							xls_pcie_ack_b);
-		} else {
-			irq_set_handler_data(PIC_PCIE_LINK0_IRQ, xls_pcie_ack);
-			irq_set_handler_data(PIC_PCIE_LINK1_IRQ, xls_pcie_ack);
-			irq_set_handler_data(PIC_PCIE_LINK2_IRQ, xls_pcie_ack);
-			irq_set_handler_data(PIC_PCIE_LINK3_IRQ, xls_pcie_ack);
-		}
-	} else {
-		/* XLR PCI controller ACK */
-		irq_set_handler_data(PIC_PCIE_XLSB0_LINK3_IRQ, xlr_pci_ack);
-	}
-#endif
-	/* unmask all PIC related interrupts. If no handler is installed by the
-	 * drivers, it'll just ack the interrupt and return
-	 */
-	for (i = PIC_IRT_FIRST_IRQ; i <= PIC_IRT_LAST_IRQ; i++)
-		nlm_irq_mask |= (1ULL << i);
-
-	nlm_irq_mask |= (1ULL << IRQ_TIMER);
-}
-
-void __init arch_init_irq(void)
-{
-	/* Initialize the irq descriptors */
-	init_xlr_irqs();
-	write_c0_eimr(nlm_irq_mask);
-}
-
-void __cpuinit nlm_smp_irq_init(void)
-{
-	/* set interrupt mask for non-zero cpus */
-	write_c0_eimr(nlm_irq_mask);
-}
-
-asmlinkage void plat_irq_dispatch(void)
-{
-	uint64_t eirr;
-	int i;
-
-	eirr = read_c0_eirr() & read_c0_eimr();
-	if (!eirr)
-		return;
-
-	/* no need of EIRR here, writing compare clears interrupt */
-	if (eirr & (1 << IRQ_TIMER)) {
-		do_IRQ(IRQ_TIMER);
-		return;
-	}
-
-	/* use dcltz: optimize below code */
-	for (i = 63; i != -1; i--) {
-		if (eirr & (1ULL << i))
-			break;
-	}
-	if (i == -1) {
-		pr_err("no interrupt !!\n");
-		return;
-	}
-
-	/* Ack eirr */
-	write_c0_eirr(1ULL << i);
-
-	do_IRQ(i);
-}
diff --git a/arch/mips/netlogic/xlr/platform.c b/arch/mips/netlogic/xlr/platform.c
index 609ec25..eab64b4 100644
--- a/arch/mips/netlogic/xlr/platform.c
+++ b/arch/mips/netlogic/xlr/platform.c
@@ -15,18 +15,19 @@
 #include <linux/serial_8250.h>
 #include <linux/serial_reg.h>
 
+#include <asm/netlogic/haldefs.h>
 #include <asm/netlogic/xlr/iomap.h>
 #include <asm/netlogic/xlr/pic.h>
 #include <asm/netlogic/xlr/xlr.h>
 
 unsigned int nlm_xlr_uart_in(struct uart_port *p, int offset)
 {
-	nlm_reg_t *mmio;
+	uint64_t uartbase;
 	unsigned int value;
 
-	/* XLR uart does not need any mapping of regs */
-	mmio = (nlm_reg_t *)(p->membase + (offset << p->regshift));
-	value = netlogic_read_reg(mmio, 0);
+	/* sign extend to 64 bits, if needed */
+	uartbase = (uint64_t)(long)p->membase;
+	value = nlm_read_reg(uartbase, offset);
 
 	/* See XLR/XLS errata */
 	if (offset == UART_MSR)
@@ -39,10 +40,10 @@ unsigned int nlm_xlr_uart_in(struct uart_port *p, int offset)
 
 void nlm_xlr_uart_out(struct uart_port *p, int offset, int value)
 {
-	nlm_reg_t *mmio;
+	uint64_t uartbase;
 
-	/* XLR uart does not need any mapping of regs */
-	mmio = (nlm_reg_t *)(p->membase + (offset << p->regshift));
+	/* sign extend to 64 bits, if needed */
+	uartbase = (uint64_t)(long)p->membase;
 
 	/* See XLR/XLS errata */
 	if (offset == UART_MSR)
@@ -50,7 +51,7 @@ void nlm_xlr_uart_out(struct uart_port *p, int offset, int value)
 	else if (offset == UART_MCR)
 		value ^= 0x3;
 
-	netlogic_write_reg(mmio, 0, value);
+	nlm_write_reg(uartbase, offset, value);
 }
 
 #define PORT(_irq)					\
@@ -82,15 +83,15 @@ static struct platform_device uart_device = {
 
 static int __init nlm_uart_init(void)
 {
-	nlm_reg_t *mmio;
+	unsigned long uartbase;
 
-	mmio = netlogic_io_mmio(NETLOGIC_IO_UART_0_OFFSET);
-	xlr_uart_data[0].membase = (void __iomem *)mmio;
-	xlr_uart_data[0].mapbase = CPHYSADDR((unsigned long)mmio);
+	uartbase = (unsigned long)nlm_mmio_base(NETLOGIC_IO_UART_0_OFFSET);
+	xlr_uart_data[0].membase = (void __iomem *)uartbase;
+	xlr_uart_data[0].mapbase = CPHYSADDR(uartbase);
 
-	mmio = netlogic_io_mmio(NETLOGIC_IO_UART_1_OFFSET);
-	xlr_uart_data[1].membase = (void __iomem *)mmio;
-	xlr_uart_data[1].mapbase = CPHYSADDR((unsigned long)mmio);
+	uartbase = (unsigned long)nlm_mmio_base(NETLOGIC_IO_UART_1_OFFSET);
+	xlr_uart_data[1].membase = (void __iomem *)uartbase;
+	xlr_uart_data[1].mapbase = CPHYSADDR(uartbase);
 
 	return platform_device_register(&uart_device);
 }
diff --git a/arch/mips/netlogic/xlr/setup.c b/arch/mips/netlogic/xlr/setup.c
index cee25dd..20c280a 100644
--- a/arch/mips/netlogic/xlr/setup.c
+++ b/arch/mips/netlogic/xlr/setup.c
@@ -39,26 +39,28 @@
 #include <asm/reboot.h>
 #include <asm/time.h>
 #include <asm/bootinfo.h>
-#include <asm/smp-ops.h>
 
 #include <asm/netlogic/interrupt.h>
 #include <asm/netlogic/psb-bootinfo.h>
+#include <asm/netlogic/haldefs.h>
+#include <asm/netlogic/common.h>
 
 #include <asm/netlogic/xlr/xlr.h>
 #include <asm/netlogic/xlr/iomap.h>
 #include <asm/netlogic/xlr/pic.h>
 #include <asm/netlogic/xlr/gpio.h>
 
-unsigned long netlogic_io_base = (unsigned long)(DEFAULT_NETLOGIC_IO_BASE);
+uint64_t nlm_io_base = DEFAULT_NETLOGIC_IO_BASE;
+uint64_t nlm_pic_base;
 unsigned long nlm_common_ebase = 0x0;
 struct psb_info nlm_prom_info;
 
 static void __init nlm_early_serial_setup(void)
 {
 	struct uart_port s;
-	nlm_reg_t *uart_base;
+	unsigned long uart_base;
 
-	uart_base = netlogic_io_mmio(NETLOGIC_IO_UART_0_OFFSET);
+	uart_base = (unsigned long)nlm_mmio_base(NETLOGIC_IO_UART_0_OFFSET);
 	memset(&s, 0, sizeof(s));
 	s.flags		= ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST;
 	s.iotype	= UPIO_MEM32;
@@ -67,18 +69,18 @@ static void __init nlm_early_serial_setup(void)
 	s.uartclk	= PIC_CLKS_PER_SEC;
 	s.serial_in	= nlm_xlr_uart_in;
 	s.serial_out	= nlm_xlr_uart_out;
-	s.mapbase	= (unsigned long)uart_base;
+	s.mapbase	= uart_base;
 	s.membase	= (unsigned char __iomem *)uart_base;
 	early_serial_setup(&s);
 }
 
 static void nlm_linux_exit(void)
 {
-	nlm_reg_t *mmio;
+	uint64_t gpiobase;
 
-	mmio = netlogic_io_mmio(NETLOGIC_IO_GPIO_OFFSET);
+	gpiobase = nlm_mmio_base(NETLOGIC_IO_GPIO_OFFSET);
 	/* trigger a chip reset by writing 1 to GPIO_SWRESET_REG */
-	netlogic_write_reg(mmio, NETLOGIC_GPIO_SWRESET_REG, 1);
+	nlm_write_reg(gpiobase, NETLOGIC_GPIO_SWRESET_REG, 1);
 	for ( ; ; )
 		cpu_wait();
 }
@@ -96,6 +98,11 @@ const char *get_system_type(void)
 	return "Netlogic XLR/XLS Series";
 }
 
+unsigned int nlm_get_cpu_frequency(void)
+{
+	return (unsigned int)nlm_prom_info.cpu_frequency;
+}
+
 void __init prom_free_prom_memory(void)
 {
 	/* Nothing yet */
@@ -175,6 +182,7 @@ void __init prom_init(void)
 	prom_infop = (struct psb_info *)(long)(int)fw_arg3;
 
 	nlm_prom_info = *prom_infop;
+	nlm_pic_base = nlm_mmio_base(NETLOGIC_IO_PIC_OFFSET);
 
 	nlm_early_serial_setup();
 	build_arcs_cmdline(argv);
diff --git a/arch/mips/netlogic/xlr/smp.c b/arch/mips/netlogic/xlr/smp.c
deleted file mode 100644
index e237212..0000000
--- a/arch/mips/netlogic/xlr/smp.c
+++ /dev/null
@@ -1,216 +0,0 @@
-/*
- * Copyright 2003-2011 NetLogic Microsystems, Inc. (NetLogic). All rights
- * reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the NetLogic
- * license below:
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- *
- * 1. Redistributions of source code must retain the above copyright
- *    notice, this list of conditions and the following disclaimer.
- * 2. Redistributions in binary form must reproduce the above copyright
- *    notice, this list of conditions and the following disclaimer in
- *    the documentation and/or other materials provided with the
- *    distribution.
- *
- * THIS SOFTWARE IS PROVIDED BY NETLOGIC ``AS IS'' AND ANY EXPRESS OR
- * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
- * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
- * ARE DISCLAIMED. IN NO EVENT SHALL NETLOGIC OR CONTRIBUTORS BE LIABLE
- * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
- * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
- * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
- * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
- * IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- */
-
-#include <linux/kernel.h>
-#include <linux/delay.h>
-#include <linux/init.h>
-#include <linux/smp.h>
-#include <linux/irq.h>
-
-#include <asm/mmu_context.h>
-
-#include <asm/netlogic/interrupt.h>
-#include <asm/netlogic/mips-extns.h>
-
-#include <asm/netlogic/xlr/iomap.h>
-#include <asm/netlogic/xlr/pic.h>
-#include <asm/netlogic/xlr/xlr.h>
-
-void core_send_ipi(int logical_cpu, unsigned int action)
-{
-	int cpu = cpu_logical_map(logical_cpu);
-	u32 tid = cpu & 0x3;
-	u32 pid = (cpu >> 2) & 0x07;
-	u32 ipi = (tid << 16) | (pid << 20);
-
-	if (action & SMP_CALL_FUNCTION)
-		ipi |= IRQ_IPI_SMP_FUNCTION;
-	else if (action & SMP_RESCHEDULE_YOURSELF)
-		ipi |= IRQ_IPI_SMP_RESCHEDULE;
-	else
-		return;
-
-	pic_send_ipi(ipi);
-}
-
-void nlm_send_ipi_single(int cpu, unsigned int action)
-{
-	core_send_ipi(cpu, action);
-}
-
-void nlm_send_ipi_mask(const struct cpumask *mask, unsigned int action)
-{
-	int cpu;
-
-	for_each_cpu(cpu, mask) {
-		core_send_ipi(cpu, action);
-	}
-}
-
-/* IRQ_IPI_SMP_FUNCTION Handler */
-void nlm_smp_function_ipi_handler(unsigned int irq, struct irq_desc *desc)
-{
-	smp_call_function_interrupt();
-}
-
-/* IRQ_IPI_SMP_RESCHEDULE  handler */
-void nlm_smp_resched_ipi_handler(unsigned int irq, struct irq_desc *desc)
-{
-	scheduler_ipi();
-}
-
-/*
- * Called before going into mips code, early cpu init
- */
-void nlm_early_init_secondary(void)
-{
-	write_c0_ebase((uint32_t)nlm_common_ebase);
-	/* TLB partition here later */
-}
-
-/*
- * Code to run on secondary just after probing the CPU
- */
-static void __cpuinit nlm_init_secondary(void)
-{
-	nlm_smp_irq_init();
-}
-
-void nlm_smp_finish(void)
-{
-#ifdef notyet
-	nlm_common_msgring_cpu_init();
-#endif
-	local_irq_enable();
-}
-
-void nlm_cpus_done(void)
-{
-}
-
-/*
- * Boot all other cpus in the system, initialize them, and bring them into
- * the boot function
- */
-int nlm_cpu_unblock[NR_CPUS];
-int nlm_cpu_ready[NR_CPUS];
-unsigned long nlm_next_gp;
-unsigned long nlm_next_sp;
-cpumask_t phys_cpu_present_map;
-
-void nlm_boot_secondary(int logical_cpu, struct task_struct *idle)
-{
-	unsigned long gp = (unsigned long)task_thread_info(idle);
-	unsigned long sp = (unsigned long)__KSTK_TOS(idle);
-	int cpu = cpu_logical_map(logical_cpu);
-
-	nlm_next_sp = sp;
-	nlm_next_gp = gp;
-
-	/* barrier */
-	__sync();
-	nlm_cpu_unblock[cpu] = 1;
-}
-
-void __init nlm_smp_setup(void)
-{
-	unsigned int boot_cpu;
-	int num_cpus, i;
-
-	boot_cpu = hard_smp_processor_id();
-	cpus_clear(phys_cpu_present_map);
-
-	cpu_set(boot_cpu, phys_cpu_present_map);
-	__cpu_number_map[boot_cpu] = 0;
-	__cpu_logical_map[0] = boot_cpu;
-	cpu_set(0, cpu_possible_map);
-
-	num_cpus = 1;
-	for (i = 0; i < NR_CPUS; i++) {
-		if (nlm_cpu_ready[i]) {
-			cpu_set(i, phys_cpu_present_map);
-			__cpu_number_map[i] = num_cpus;
-			__cpu_logical_map[num_cpus] = i;
-			cpu_set(num_cpus, cpu_possible_map);
-			++num_cpus;
-		}
-	}
-
-	pr_info("Phys CPU present map: %lx, possible map %lx\n",
-		(unsigned long)phys_cpu_present_map.bits[0],
-		(unsigned long)cpu_possible_map.bits[0]);
-
-	pr_info("Detected %i Slave CPU(s)\n", num_cpus);
-}
-
-void nlm_prepare_cpus(unsigned int max_cpus)
-{
-}
-
-struct plat_smp_ops nlm_smp_ops = {
-	.send_ipi_single	= nlm_send_ipi_single,
-	.send_ipi_mask		= nlm_send_ipi_mask,
-	.init_secondary		= nlm_init_secondary,
-	.smp_finish		= nlm_smp_finish,
-	.cpus_done		= nlm_cpus_done,
-	.boot_secondary		= nlm_boot_secondary,
-	.smp_setup		= nlm_smp_setup,
-	.prepare_cpus		= nlm_prepare_cpus,
-};
-
-unsigned long secondary_entry_point;
-
-int __cpuinit nlm_wakeup_secondary_cpus(u32 wakeup_mask)
-{
-	unsigned int tid, pid, ipi, i, boot_cpu;
-	void *reset_vec;
-
-	secondary_entry_point = (unsigned long)prom_pre_boot_secondary_cpus;
-	reset_vec = (void *)CKSEG1ADDR(0x1fc00000);
-	memcpy(reset_vec, nlm_boot_smp_nmi, 0x80);
-	boot_cpu = hard_smp_processor_id();
-
-	for (i = 0; i < NR_CPUS; i++) {
-		if (i == boot_cpu)
-			continue;
-		if (wakeup_mask & (1u << i)) {
-			tid = i & 0x3;
-			pid = (i >> 2) & 0x7;
-			ipi = (tid << 16) | (pid << 20) | (1 << 8);
-			pic_send_ipi(ipi);
-		}
-	}
-
-	return 0;
-}
diff --git a/arch/mips/netlogic/xlr/smpboot.S b/arch/mips/netlogic/xlr/smpboot.S
index 8cb7889..7f1f6e6 100644
--- a/arch/mips/netlogic/xlr/smpboot.S
+++ b/arch/mips/netlogic/xlr/smpboot.S
@@ -75,12 +75,11 @@ NESTED(prom_pre_boot_secondary_cpus, 16, sp)
 	jr	t0
 	nop
 END(prom_pre_boot_secondary_cpus)
-	__FINIT
 
 /*
  * NMI code, used for CPU wakeup, copied to reset entry
  */
-NESTED(nlm_boot_smp_nmi, 0, sp)
+EXPORT(nlm_reset_entry)
 	.set push
 	.set noat
 	.set mips64
@@ -97,4 +96,5 @@ NESTED(nlm_boot_smp_nmi, 0, sp)
 	jr	k0
 	nop
 	.set pop
-END(nlm_boot_smp_nmi)
+EXPORT(nlm_reset_entry_end)
+	__FINIT
diff --git a/arch/mips/netlogic/xlr/time.c b/arch/mips/netlogic/xlr/time.c
deleted file mode 100644
index 0d81b26..0000000
--- a/arch/mips/netlogic/xlr/time.c
+++ /dev/null
@@ -1,51 +0,0 @@
-/*
- * Copyright 2003-2011 NetLogic Microsystems, Inc. (NetLogic). All rights
- * reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the NetLogic
- * license below:
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- *
- * 1. Redistributions of source code must retain the above copyright
- *    notice, this list of conditions and the following disclaimer.
- * 2. Redistributions in binary form must reproduce the above copyright
- *    notice, this list of conditions and the following disclaimer in
- *    the documentation and/or other materials provided with the
- *    distribution.
- *
- * THIS SOFTWARE IS PROVIDED BY NETLOGIC ``AS IS'' AND ANY EXPRESS OR
- * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
- * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
- * ARE DISCLAIMED. IN NO EVENT SHALL NETLOGIC OR CONTRIBUTORS BE LIABLE
- * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
- * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
- * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
- * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
- * IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- */
-
-#include <linux/init.h>
-
-#include <asm/time.h>
-#include <asm/netlogic/interrupt.h>
-#include <asm/netlogic/psb-bootinfo.h>
-
-unsigned int __cpuinit get_c0_compare_int(void)
-{
-	return IRQ_TIMER;
-}
-
-void __init plat_time_init(void)
-{
-	mips_hpt_frequency = nlm_prom_info.cpu_frequency;
-	pr_info("MIPS counter frequency [%ld]\n",
-		(unsigned long)mips_hpt_frequency);
-}
diff --git a/arch/mips/netlogic/xlr/wakeup.c b/arch/mips/netlogic/xlr/wakeup.c
new file mode 100644
index 0000000..69143bb
--- /dev/null
+++ b/arch/mips/netlogic/xlr/wakeup.c
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
+#include <linux/init.h>
+#include <linux/threads.h>
+
+#include <asm/asm.h>
+#include <asm/asm-offsets.h>
+#include <asm/mipsregs.h>
+#include <asm/addrspace.h>
+#include <asm/string.h>
+
+#include <asm/netlogic/haldefs.h>
+#include <asm/netlogic/common.h>
+#include <asm/netlogic/mips-extns.h>
+
+#include <asm/netlogic/xlr/iomap.h>
+#include <asm/netlogic/xlr/pic.h>
+
+unsigned long secondary_entry_point;
+
+int __cpuinit nlm_wakeup_secondary_cpus(u32 wakeup_mask)
+{
+	unsigned int i, boot_cpu;
+	void *reset_vec;
+
+	secondary_entry_point = (unsigned long)prom_pre_boot_secondary_cpus;
+	reset_vec = (void *)CKSEG1ADDR(0x1fc00000);
+	memcpy(reset_vec, (void *)nlm_reset_entry,
+			(nlm_reset_entry_end - nlm_reset_entry));
+	boot_cpu = hard_smp_processor_id();
+
+	for (i = 0; i < NR_CPUS; i++) {
+		if (i == boot_cpu || (wakeup_mask & (1u << i)) == 0)
+			continue;
+		nlm_pic_send_ipi(nlm_pic_base, i, 1, 1); /* send NMI */
+	}
+
+	return 0;
+}
diff --git a/arch/mips/netlogic/xlr/xlr_console.c b/arch/mips/netlogic/xlr/xlr_console.c
deleted file mode 100644
index 759df06..0000000
--- a/arch/mips/netlogic/xlr/xlr_console.c
+++ /dev/null
@@ -1,46 +0,0 @@
-/*
- * Copyright 2003-2011 NetLogic Microsystems, Inc. (NetLogic). All rights
- * reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the NetLogic
- * license below:
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- *
- * 1. Redistributions of source code must retain the above copyright
- *    notice, this list of conditions and the following disclaimer.
- * 2. Redistributions in binary form must reproduce the above copyright
- *    notice, this list of conditions and the following disclaimer in
- *    the documentation and/or other materials provided with the
- *    distribution.
- *
- * THIS SOFTWARE IS PROVIDED BY NETLOGIC ``AS IS'' AND ANY EXPRESS OR
- * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
- * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
- * ARE DISCLAIMED. IN NO EVENT SHALL NETLOGIC OR CONTRIBUTORS BE LIABLE
- * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
- * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
- * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
- * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
- * IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- */
-
-#include <linux/types.h>
-#include <asm/netlogic/xlr/iomap.h>
-
-void prom_putchar(char c)
-{
-	nlm_reg_t *mmio;
-
-	mmio = netlogic_io_mmio(NETLOGIC_IO_UART_0_OFFSET);
-	while (netlogic_read_reg(mmio, 0x5) == 0)
-		;
-	netlogic_write_reg(mmio, 0x0, c);
-}
diff --git a/arch/mips/pci/pci-xlr.c b/arch/mips/pci/pci-xlr.c
index 87404d0..3d701a9 100644
--- a/arch/mips/pci/pci-xlr.c
+++ b/arch/mips/pci/pci-xlr.c
@@ -45,6 +45,8 @@
 #include <asm/io.h>
 
 #include <asm/netlogic/interrupt.h>
+#include <asm/netlogic/haldefs.h>
+
 #include <asm/netlogic/xlr/msidef.h>
 #include <asm/netlogic/xlr/iomap.h>
 #include <asm/netlogic/xlr/pic.h>
@@ -226,6 +228,56 @@ int arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
 }
 #endif
 
+/* Extra ACK needed for XLR on chip PCI controller */
+static void xlr_pci_ack(struct irq_data *d)
+{
+	uint64_t pcibase = nlm_mmio_base(NETLOGIC_IO_PCIX_OFFSET);
+
+	nlm_read_reg(pcibase, (0x140 >> 2));
+}
+
+/* Extra ACK needed for XLS on chip PCIe controller */
+static void xls_pcie_ack(struct irq_data *d)
+{
+	uint64_t pciebase_le = nlm_mmio_base(NETLOGIC_IO_PCIE_1_OFFSET);
+
+	switch (d->irq) {
+	case PIC_PCIE_LINK0_IRQ:
+		nlm_write_reg(pciebase_le, (0x90 >> 2), 0xffffffff);
+		break;
+	case PIC_PCIE_LINK1_IRQ:
+		nlm_write_reg(pciebase_le, (0x94 >> 2), 0xffffffff);
+		break;
+	case PIC_PCIE_LINK2_IRQ:
+		nlm_write_reg(pciebase_le, (0x190 >> 2), 0xffffffff);
+		break;
+	case PIC_PCIE_LINK3_IRQ:
+		nlm_write_reg(pciebase_le, (0x194 >> 2), 0xffffffff);
+		break;
+	}
+}
+
+/* For XLS B silicon, the 3,4 PCI interrupts are different */
+static void xls_pcie_ack_b(struct irq_data *d)
+{
+	uint64_t pciebase_le = nlm_mmio_base(NETLOGIC_IO_PCIE_1_OFFSET);
+
+	switch (d->irq) {
+	case PIC_PCIE_LINK0_IRQ:
+		nlm_write_reg(pciebase_le, (0x90 >> 2), 0xffffffff);
+		break;
+	case PIC_PCIE_LINK1_IRQ:
+		nlm_write_reg(pciebase_le, (0x94 >> 2), 0xffffffff);
+		break;
+	case PIC_PCIE_XLSB0_LINK2_IRQ:
+		nlm_write_reg(pciebase_le, (0x190 >> 2), 0xffffffff);
+		break;
+	case PIC_PCIE_XLSB0_LINK3_IRQ:
+		nlm_write_reg(pciebase_le, (0x194 >> 2), 0xffffffff);
+		break;
+	}
+}
+
 int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	return get_irq_vector(dev);
@@ -253,6 +305,31 @@ static int __init pcibios_init(void)
 	pr_info("Registering XLR/XLS PCIX/PCIE Controller.\n");
 	register_pci_controller(&nlm_pci_controller);
 
+	/*
+	 * For PCI interrupts, we need to ack the PCI controller too, overload
+	 * irq handler data to do this
+	 */
+	if (nlm_chip_is_xls()) {
+		if (nlm_chip_is_xls_b()) {
+			irq_set_handler_data(PIC_PCIE_LINK0_IRQ,
+							xls_pcie_ack_b);
+			irq_set_handler_data(PIC_PCIE_LINK1_IRQ,
+							xls_pcie_ack_b);
+			irq_set_handler_data(PIC_PCIE_XLSB0_LINK2_IRQ,
+							xls_pcie_ack_b);
+			irq_set_handler_data(PIC_PCIE_XLSB0_LINK3_IRQ,
+							xls_pcie_ack_b);
+		} else {
+			irq_set_handler_data(PIC_PCIE_LINK0_IRQ, xls_pcie_ack);
+			irq_set_handler_data(PIC_PCIE_LINK1_IRQ, xls_pcie_ack);
+			irq_set_handler_data(PIC_PCIE_LINK2_IRQ, xls_pcie_ack);
+			irq_set_handler_data(PIC_PCIE_LINK3_IRQ, xls_pcie_ack);
+		}
+	} else {
+		/* XLR PCI controller ACK */
+		irq_set_handler_data(PIC_PCIE_XLSB0_LINK3_IRQ, xlr_pci_ack);
+	}
+
 	return 0;
 }
 
-- 
1.7.4.1
