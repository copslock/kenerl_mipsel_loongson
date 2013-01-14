Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Jan 2013 17:11:20 +0100 (CET)
Received: from mms3.broadcom.com ([216.31.210.19]:2056 "EHLO mms3.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6831950Ab3ANQKSZ4GtZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 Jan 2013 17:10:18 +0100
Received: from [10.9.200.131] by mms3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Mon, 14 Jan 2013 08:04:50 -0800
X-Server-Uuid: B86B6450-0931-4310-942E-F00ED04CA7AF
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB01.corp.ad.broadcom.com (10.9.200.131) with Microsoft SMTP
 Server id 8.2.247.2; Mon, 14 Jan 2013 08:09:34 -0800
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 93C0C40FE5; Mon, 14
 Jan 2013 08:09:33 -0800 (PST)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 05/10] MIPS: Netlogic: Use PIC timer as a clocksource
Date:   Mon, 14 Jan 2013 21:41:57 +0530
Message-ID: <1358179922-26663-6-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1358179922-26663-1-git-send-email-jchandra@broadcom.com>
References: <1358179922-26663-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7CEAF3283Q42009767-13-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 35422
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

The XLR/XLS/XLP PIC has a 8 countdown timers which run at the PIC
frequencey. One of these can be used as a clocksource to provide
timestamps that is common across cores. This can be used in place
of the count/compare clocksource which is per-CPU.

On XLR/XLS PIC registers are 32-bit, so we just use the lower 32-bits
of the PIC counter. On XLP, the whole 64-bit can be used.

Provide common macros and functions for PIC timer registers on XLR/XLS
and XLP, and use them to register a PIC clocksource.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/include/asm/netlogic/xlp-hal/pic.h |   12 +++++-
 arch/mips/include/asm/netlogic/xlr/pic.h     |   48 ++++++++++++++++++++++--
 arch/mips/netlogic/common/irq.c              |    2 +-
 arch/mips/netlogic/common/time.c             |   52 ++++++++++++++++++++++++++
 arch/mips/netlogic/xlr/platform.c            |    2 +-
 arch/mips/netlogic/xlr/setup.c               |    2 +-
 6 files changed, 110 insertions(+), 8 deletions(-)

diff --git a/arch/mips/include/asm/netlogic/xlp-hal/pic.h b/arch/mips/include/asm/netlogic/xlp-hal/pic.h
index b2e53a5..ea6768c 100644
--- a/arch/mips/include/asm/netlogic/xlp-hal/pic.h
+++ b/arch/mips/include/asm/netlogic/xlp-hal/pic.h
@@ -261,6 +261,8 @@
 #define PIC_LOCAL_SCHEDULING		1
 #define PIC_GLOBAL_SCHEDULING		0
 
+#define PIC_CLK_HZ			133333333
+
 #define nlm_read_pic_reg(b, r)	nlm_read_reg64(b, r)
 #define nlm_write_pic_reg(b, r, v) nlm_write_reg64(b, r, v)
 #define nlm_get_pic_pcibase(node) nlm_pcicfg_base(XLP_IO_PIC_OFFSET(node))
@@ -315,6 +317,12 @@ nlm_pic_read_timer(uint64_t base, int timer)
 	return nlm_read_pic_reg(base, PIC_TIMER_COUNT(timer));
 }
 
+static inline uint32_t
+nlm_pic_read_timer32(uint64_t base, int timer)
+{
+	return (uint32_t)nlm_read_pic_reg(base, PIC_TIMER_COUNT(timer));
+}
+
 static inline void
 nlm_pic_write_timer(uint64_t base, int timer, uint64_t value)
 {
@@ -376,9 +384,9 @@ nlm_pic_ack(uint64_t base, int irt_num)
 }
 
 static inline void
-nlm_pic_init_irt(uint64_t base, int irt, int irq, int hwt)
+nlm_pic_init_irt(uint64_t base, int irt, int irq, int hwt, int en)
 {
-	nlm_pic_write_irt_direct(base, irt, 0, 0, 0, irq, hwt);
+	nlm_pic_write_irt_direct(base, irt, en, 0, 0, irq, hwt);
 }
 
 int nlm_irq_to_irt(int irq);
diff --git a/arch/mips/include/asm/netlogic/xlr/pic.h b/arch/mips/include/asm/netlogic/xlr/pic.h
index 9a691b1..effa337 100644
--- a/arch/mips/include/asm/netlogic/xlr/pic.h
+++ b/arch/mips/include/asm/netlogic/xlr/pic.h
@@ -35,10 +35,11 @@
 #ifndef _ASM_NLM_XLR_PIC_H
 #define _ASM_NLM_XLR_PIC_H
 
-#define PIC_CLKS_PER_SEC		66666666ULL
+#define PIC_CLK_HZ			66666666
 /* PIC hardware interrupt numbers */
 #define PIC_IRT_WD_INDEX		0
 #define PIC_IRT_TIMER_0_INDEX		1
+#define PIC_IRT_TIMER_INDEX(i)		((i) + PIC_IRT_TIMER_0_INDEX)
 #define PIC_IRT_TIMER_1_INDEX		2
 #define PIC_IRT_TIMER_2_INDEX		3
 #define PIC_IRT_TIMER_3_INDEX		4
@@ -99,6 +100,7 @@
 
 /* PIC Registers */
 #define PIC_CTRL			0x00
+#define PIC_CTRL_STE			8	/* timer enable start bit */
 #define PIC_IPI				0x04
 #define PIC_INT_ACK			0x06
 
@@ -251,12 +253,52 @@ nlm_pic_ack(uint64_t base, int irt)
 }
 
 static inline void
-nlm_pic_init_irt(uint64_t base, int irt, int irq, int hwt)
+nlm_pic_init_irt(uint64_t base, int irt, int irq, int hwt, int en)
 {
 	nlm_write_reg(base, PIC_IRT_0(irt), (1u << hwt));
 	/* local scheduling, invalid, level by default */
 	nlm_write_reg(base, PIC_IRT_1(irt),
-		(1 << 30) | (1 << 6) | irq);
+		(en << 30) | (1 << 6) | irq);
+}
+
+static inline uint64_t
+nlm_pic_read_timer(uint64_t base, int timer)
+{
+	uint32_t up1, up2, low;
+
+	up1 = nlm_read_reg(base, PIC_TIMER_COUNT_1(timer));
+	low = nlm_read_reg(base, PIC_TIMER_COUNT_0(timer));
+	up2 = nlm_read_reg(base, PIC_TIMER_COUNT_1(timer));
+
+	if (up1 != up2) /* wrapped, get the new low */
+		low = nlm_read_reg(base, PIC_TIMER_COUNT_0(timer));
+	return ((uint64_t)up2 << 32) | low;
+
+}
+
+static inline uint32_t
+nlm_pic_read_timer32(uint64_t base, int timer)
+{
+	return nlm_read_reg(base, PIC_TIMER_COUNT_0(timer));
+}
+
+static inline void
+nlm_pic_set_timer(uint64_t base, int timer, uint64_t value, int irq, int cpu)
+{
+	uint32_t up, low;
+	uint64_t pic_ctrl = nlm_read_reg(base, PIC_CTRL);
+	int en;
+
+	en = (irq > 0);
+	up = value >> 32;
+	low = value & 0xFFFFFFFF;
+	nlm_write_reg(base, PIC_TIMER_MAXVAL_0(timer), low);
+	nlm_write_reg(base, PIC_TIMER_MAXVAL_1(timer), up);
+	nlm_pic_init_irt(base, PIC_IRT_TIMER_INDEX(timer), irq, cpu, 0);
+
+	/* enable the timer */
+	pic_ctrl |= (1 << (PIC_CTRL_STE + timer));
+	nlm_write_reg(base, PIC_CTRL, pic_ctrl);
 }
 #endif
 #endif /* _ASM_NLM_XLR_PIC_H */
diff --git a/arch/mips/netlogic/common/irq.c b/arch/mips/netlogic/common/irq.c
index d42cd1a..642f1e4 100644
--- a/arch/mips/netlogic/common/irq.c
+++ b/arch/mips/netlogic/common/irq.c
@@ -217,7 +217,7 @@ static void nlm_init_node_irqs(int node)
 		nlm_setup_pic_irq(node, i, i, irt);
 		/* set interrupts to first cpu in node */
 		nlm_pic_init_irt(nodep->picbase, irt, i,
-					node * NLM_CPUS_PER_NODE);
+					node * NLM_CPUS_PER_NODE, 0);
 		irqmask |= (1ull << i);
 	}
 	nodep->irqmask = irqmask;
diff --git a/arch/mips/netlogic/common/time.c b/arch/mips/netlogic/common/time.c
index bd3e498..20f89bc 100644
--- a/arch/mips/netlogic/common/time.c
+++ b/arch/mips/netlogic/common/time.c
@@ -35,16 +35,68 @@
 #include <linux/init.h>
 
 #include <asm/time.h>
+#include <asm/cpu-features.h>
+
 #include <asm/netlogic/interrupt.h>
 #include <asm/netlogic/common.h>
+#include <asm/netlogic/haldefs.h>
+#include <asm/netlogic/common.h>
+
+#if defined(CONFIG_CPU_XLP)
+#include <asm/netlogic/xlp-hal/iomap.h>
+#include <asm/netlogic/xlp-hal/xlp.h>
+#include <asm/netlogic/xlp-hal/pic.h>
+#elif defined(CONFIG_CPU_XLR)
+#include <asm/netlogic/xlr/iomap.h>
+#include <asm/netlogic/xlr/pic.h>
+#include <asm/netlogic/xlr/xlr.h>
+#else
+#error "Unknown CPU"
+#endif
 
 unsigned int __cpuinit get_c0_compare_int(void)
 {
 	return IRQ_TIMER;
 }
 
+static cycle_t nlm_get_pic_timer(struct clocksource *cs)
+{
+	uint64_t picbase = nlm_get_node(0)->picbase;
+
+	return ~nlm_pic_read_timer(picbase, PIC_CLOCK_TIMER);
+}
+
+static cycle_t nlm_get_pic_timer32(struct clocksource *cs)
+{
+	uint64_t picbase = nlm_get_node(0)->picbase;
+
+	return ~nlm_pic_read_timer32(picbase, PIC_CLOCK_TIMER);
+}
+
+static struct clocksource csrc_pic = {
+	.name		= "PIC",
+	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
+};
+
+static void nlm_init_pic_timer(void)
+{
+	uint64_t picbase = nlm_get_node(0)->picbase;
+
+	nlm_pic_set_timer(picbase, PIC_CLOCK_TIMER, ~0ULL, 0, 0);
+	if (current_cpu_data.cputype == CPU_XLR) {
+		csrc_pic.mask	= CLOCKSOURCE_MASK(32);
+		csrc_pic.read	= nlm_get_pic_timer32;
+	} else {
+		csrc_pic.mask	= CLOCKSOURCE_MASK(64);
+		csrc_pic.read	= nlm_get_pic_timer;
+	}
+	csrc_pic.rating = 1000;
+	clocksource_register_hz(&csrc_pic, PIC_CLK_HZ);
+}
+
 void __init plat_time_init(void)
 {
+	nlm_init_pic_timer();
 	mips_hpt_frequency = nlm_get_cpu_frequency();
 	pr_info("MIPS counter frequency [%ld]\n",
 			(unsigned long)mips_hpt_frequency);
diff --git a/arch/mips/netlogic/xlr/platform.c b/arch/mips/netlogic/xlr/platform.c
index 507230e..ce838f9 100644
--- a/arch/mips/netlogic/xlr/platform.c
+++ b/arch/mips/netlogic/xlr/platform.c
@@ -64,7 +64,7 @@ void nlm_xlr_uart_out(struct uart_port *p, int offset, int value)
 		.iotype		= UPIO_MEM32,		\
 		.flags		= (UPF_SKIP_TEST |	\
 			 UPF_FIXED_TYPE | UPF_BOOT_AUTOCONF),\
-		.uartclk	= PIC_CLKS_PER_SEC,	\
+		.uartclk	= PIC_CLK_HZ,		\
 		.type		= PORT_16550A,		\
 		.serial_in	= nlm_xlr_uart_in,	\
 		.serial_out	= nlm_xlr_uart_out,	\
diff --git a/arch/mips/netlogic/xlr/setup.c b/arch/mips/netlogic/xlr/setup.c
index 4e7f49d..f72f92e 100644
--- a/arch/mips/netlogic/xlr/setup.c
+++ b/arch/mips/netlogic/xlr/setup.c
@@ -70,7 +70,7 @@ static void __init nlm_early_serial_setup(void)
 	s.iotype	= UPIO_MEM32;
 	s.regshift	= 2;
 	s.irq		= PIC_UART_0_IRQ;
-	s.uartclk	= PIC_CLKS_PER_SEC;
+	s.uartclk	= PIC_CLK_HZ;
 	s.serial_in	= nlm_xlr_uart_in;
 	s.serial_out	= nlm_xlr_uart_out;
 	s.mapbase	= uart_base;
-- 
1.7.9.5
