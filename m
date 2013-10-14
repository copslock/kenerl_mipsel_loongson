Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Oct 2013 15:22:30 +0200 (CEST)
Received: from mms3.broadcom.com ([216.31.210.19]:3662 "EHLO mms3.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6853541Ab3JNNT4AynLl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 Oct 2013 15:19:56 +0200
Received: from [10.9.208.57] by mms3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Mon, 14 Oct 2013 06:15:13 -0700
X-Server-Uuid: B86B6450-0931-4310-942E-F00ED04CA7AF
Received: from IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Mon, 14 Oct 2013 06:15:23 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) with Microsoft SMTP
 Server id 14.1.438.0; Mon, 14 Oct 2013 06:15:23 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 9C0C7246A5; Mon, 14
 Oct 2013 06:15:22 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>, ralf@linux-mips.org
Subject: [PATCH 10/18] MIPS: Netlogic: XLP9XX PIC updates
Date:   Mon, 14 Oct 2013 18:51:06 +0530
Message-ID: <1381756874-22616-11-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1381756874-22616-1-git-send-email-jchandra@broadcom.com>
References: <1381756874-22616-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7E4531EB2E41366914-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38340
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

Functions for the XLP9XX interrupt table entry format and other PIC
register changes.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/include/asm/netlogic/xlp-hal/pic.h |   72 +++++++++++++++++---------
 arch/mips/netlogic/xlp/nlm_hal.c             |   15 ++++++
 arch/mips/netlogic/xlp/wakeup.c              |    2 +-
 arch/mips/pci/pci-xlp.c                      |    2 +-
 4 files changed, 65 insertions(+), 26 deletions(-)

diff --git a/arch/mips/include/asm/netlogic/xlp-hal/pic.h b/arch/mips/include/asm/netlogic/xlp-hal/pic.h
index 3fcbe74..f10bf3b 100644
--- a/arch/mips/include/asm/netlogic/xlp-hal/pic.h
+++ b/arch/mips/include/asm/netlogic/xlp-hal/pic.h
@@ -150,12 +150,19 @@
 #define PIC_IRT0		0x74
 #define PIC_IRT(i)		(PIC_IRT0 + ((i) * 2))
 
-#define TIMER_CYCLES_MAXVAL	0xffffffffffffffffULL
+#define PIC_9XX_PENDING_0	0x6
+#define PIC_9XX_PENDING_1	0x8
+#define PIC_9XX_PENDING_2	0xa
+#define PIC_9XX_PENDING_3	0xc
+
+#define PIC_9XX_IRT0		0x1c0
+#define PIC_9XX_IRT(i)		(PIC_9XX_IRT0 + ((i) * 2))
 
 /*
  *    IRT Map
  */
 #define PIC_NUM_IRTS		160
+#define PIC_9XX_NUM_IRTS	256
 
 #define PIC_IRT_WD_0_INDEX	0
 #define PIC_IRT_WD_1_INDEX	1
@@ -205,30 +212,26 @@
 
 #define nlm_read_pic_reg(b, r)	nlm_read_reg64(b, r)
 #define nlm_write_pic_reg(b, r, v) nlm_write_reg64(b, r, v)
-#define nlm_get_pic_pcibase(node) nlm_pcicfg_base(XLP_IO_PIC_OFFSET(node))
+#define nlm_get_pic_pcibase(node)	nlm_pcicfg_base(cpu_is_xlp9xx() ? \
+		XLP9XX_IO_PIC_OFFSET(node) : XLP_IO_PIC_OFFSET(node))
 #define nlm_get_pic_regbase(node) (nlm_get_pic_pcibase(node) + XLP_IO_PCI_HDRSZ)
 
 /* We use PIC on node 0 as a timer */
 #define pic_timer_freq()		nlm_get_pic_frequency(0)
 
 /* IRT and h/w interrupt routines */
-static inline int
-nlm_pic_read_irt(uint64_t base, int irt_index)
-{
-	return nlm_read_pic_reg(base, PIC_IRT(irt_index));
-}
-
 static inline void
-nlm_set_irt_to_cpu(uint64_t base, int irt, int cpu)
+nlm_9xx_pic_write_irt(uint64_t base, int irt_num, int en, int nmi,
+	int sch, int vec, int dt, int db, int cpu)
 {
 	uint64_t val;
 
-	val = nlm_read_pic_reg(base, PIC_IRT(irt));
-	/* clear cpuset and mask */
-	val &= ~((0x7ull << 16) | 0xffff);
-	/* set DB, cpuset and cpumask */
-	val |= (1 << 19) | ((cpu >> 4) << 16) | (1 << (cpu & 0xf));
-	nlm_write_pic_reg(base, PIC_IRT(irt), val);
+	val = (((uint64_t)en & 0x1) << 22) | ((nmi & 0x1) << 23) |
+			((0 /*mc*/) << 20) | ((vec & 0x3f) << 24) |
+			((dt & 0x1) << 21) | (0 /*ptr*/ << 16) |
+			(cpu & 0x3ff);
+
+	nlm_write_pic_reg(base, PIC_9XX_IRT(irt_num), val);
 }
 
 static inline void
@@ -249,9 +252,13 @@ static inline void
 nlm_pic_write_irt_direct(uint64_t base, int irt_num, int en, int nmi,
 	int sch, int vec, int cpu)
 {
-	nlm_pic_write_irt(base, irt_num, en, nmi, sch, vec, 1,
-		(cpu >> 4),		/* thread group */
-		1 << (cpu & 0xf));	/* thread mask */
+	if (cpu_is_xlp9xx())
+		nlm_9xx_pic_write_irt(base, irt_num, en, nmi, sch, vec,
+							1, 0, cpu);
+	else
+		nlm_pic_write_irt(base, irt_num, en, nmi, sch, vec, 1,
+			(cpu >> 4),		/* thread group */
+			1 << (cpu & 0xf));	/* thread mask */
 }
 
 static inline uint64_t
@@ -293,8 +300,13 @@ nlm_pic_enable_irt(uint64_t base, int irt)
 {
 	uint64_t reg;
 
-	reg = nlm_read_pic_reg(base, PIC_IRT(irt));
-	nlm_write_pic_reg(base, PIC_IRT(irt), reg | (1u << 31));
+	if (cpu_is_xlp9xx()) {
+		reg = nlm_read_pic_reg(base, PIC_9XX_IRT(irt));
+		nlm_write_pic_reg(base, PIC_9XX_IRT(irt), reg | (1 << 22));
+	} else {
+		reg = nlm_read_pic_reg(base, PIC_IRT(irt));
+		nlm_write_pic_reg(base, PIC_IRT(irt), reg | (1u << 31));
+	}
 }
 
 static inline void
@@ -302,8 +314,15 @@ nlm_pic_disable_irt(uint64_t base, int irt)
 {
 	uint64_t reg;
 
-	reg = nlm_read_pic_reg(base, PIC_IRT(irt));
-	nlm_write_pic_reg(base, PIC_IRT(irt), reg & ~((uint64_t)1 << 31));
+	if (cpu_is_xlp9xx()) {
+		reg = nlm_read_pic_reg(base, PIC_9XX_IRT(irt));
+		reg &= ~((uint64_t)1 << 22);
+		nlm_write_pic_reg(base, PIC_9XX_IRT(irt), reg);
+	} else {
+		reg = nlm_read_pic_reg(base, PIC_IRT(irt));
+		reg &= ~((uint64_t)1 << 31);
+		nlm_write_pic_reg(base, PIC_IRT(irt), reg);
+	}
 }
 
 static inline void
@@ -311,8 +330,13 @@ nlm_pic_send_ipi(uint64_t base, int hwt, int irq, int nmi)
 {
 	uint64_t ipi;
 
-	ipi = ((uint64_t)nmi << 31) | (irq << 20);
-	ipi |= ((hwt >> 4) << 16) | (1 << (hwt & 0xf)); /* cpuset and mask */
+	if (cpu_is_xlp9xx())
+		ipi = (nmi << 23) | (irq << 24) |
+			(0/*mcm*/ << 20) | (0/*ptr*/ << 16) | hwt;
+	else
+		ipi = ((uint64_t)nmi << 31) | (irq << 20) |
+			((hwt >> 4) << 16) | (1 << (hwt & 0xf));
+
 	nlm_write_pic_reg(base, PIC_IPI_CTL, ipi);
 }
 
diff --git a/arch/mips/netlogic/xlp/nlm_hal.c b/arch/mips/netlogic/xlp/nlm_hal.c
index 5f191f5..2d31cf1 100644
--- a/arch/mips/netlogic/xlp/nlm_hal.c
+++ b/arch/mips/netlogic/xlp/nlm_hal.c
@@ -69,6 +69,17 @@ int nlm_irq_to_irt(int irq)
 	uint64_t pcibase;
 	int devoff, irt;
 
+	/* bypass for 9xx */
+	if (cpu_is_xlp9xx()) {
+		switch (irq) {
+		case PIC_UART_0_IRQ:
+			return 133;
+		case PIC_UART_1_IRQ:
+			return 134;
+		}
+		return -1;
+	}
+
 	devoff = 0;
 	switch (irq) {
 	case PIC_UART_0_IRQ:
@@ -277,6 +288,10 @@ static unsigned int nlm_2xx_get_pic_frequency(int node)
 
 unsigned int nlm_get_pic_frequency(int node)
 {
+	/* TODO Has to calculate freq as like 2xx */
+	if (cpu_is_xlp9xx())
+		return 250000000;
+
 	if (cpu_is_xlpii())
 		return nlm_2xx_get_pic_frequency(node);
 	else
diff --git a/arch/mips/netlogic/xlp/wakeup.c b/arch/mips/netlogic/xlp/wakeup.c
index 055dc17..5337ff4 100644
--- a/arch/mips/netlogic/xlp/wakeup.c
+++ b/arch/mips/netlogic/xlp/wakeup.c
@@ -47,8 +47,8 @@
 #include <asm/netlogic/mips-extns.h>
 
 #include <asm/netlogic/xlp-hal/iomap.h>
-#include <asm/netlogic/xlp-hal/pic.h>
 #include <asm/netlogic/xlp-hal/xlp.h>
+#include <asm/netlogic/xlp-hal/pic.h>
 #include <asm/netlogic/xlp-hal/sys.h>
 
 static int xlp_wakeup_core(uint64_t sysbase, int node, int core)
diff --git a/arch/mips/pci/pci-xlp.c b/arch/mips/pci/pci-xlp.c
index da7a37a..f390aa9 100644
--- a/arch/mips/pci/pci-xlp.c
+++ b/arch/mips/pci/pci-xlp.c
@@ -50,8 +50,8 @@
 #include <asm/netlogic/mips-extns.h>
 
 #include <asm/netlogic/xlp-hal/iomap.h>
-#include <asm/netlogic/xlp-hal/pic.h>
 #include <asm/netlogic/xlp-hal/xlp.h>
+#include <asm/netlogic/xlp-hal/pic.h>
 #include <asm/netlogic/xlp-hal/pcibus.h>
 #include <asm/netlogic/xlp-hal/bridge.h>
 
-- 
1.7.9.5
