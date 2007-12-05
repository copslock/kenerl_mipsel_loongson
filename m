Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Dec 2007 16:09:04 +0000 (GMT)
Received: from rtsoft3.corbina.net ([85.21.88.6]:7196 "EHLO
	buildserver.ru.mvista.com") by ftp.linux-mips.org with ESMTP
	id S20025684AbXLEQIi (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 5 Dec 2007 16:08:38 +0000
Received: from wasted.dev.rtsoft.ru (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP
	id 7AA968816; Wed,  5 Dec 2007 21:08:07 +0400 (SAMT)
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
To:	ralf@linux-mips.org
Subject: [PATCH 2/2] Alchemy: fix IRQ bases
Date:	Wed, 5 Dec 2007 19:08:26 +0300
User-Agent: KMail/1.5
Cc:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200712051908.26703.sshtylyov@ru.mvista.com>
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17702
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Do what the commits commits f3e8d1da389fe2e514e31f6e93c690c8e1243849 and
9d360ab4a7568a8d177280f651a8a772ae52b9b9 failed to achieve -- actually
convert the Alchemy code to irq_cpu.

 arch/mips/au1000/common/irq.c         |    8 ++++----
 include/asm-mips/mach-au1x00/au1000.h |   21 +++++++++++----------
 2 files changed, 15 insertions(+), 14 deletions(-)

Index: linux-2.6/arch/mips/au1000/common/irq.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/common/irq.c
+++ linux-2.6/arch/mips/au1000/common/irq.c
@@ -464,7 +464,7 @@ static void intc0_req0_irqdispatch(void)
 #endif
 	bit = __ffs(intc0_req0);
 	intc0_req0 &= ~(1 << bit);
-	do_IRQ(MIPS_CPU_IRQ_BASE + bit);
+	do_IRQ(AU1000_INTC0_INT_BASE + bit);
 }
 
 
@@ -480,7 +480,7 @@ static void intc0_req1_irqdispatch(void)
 
 	bit = __ffs(intc0_req1);
 	intc0_req1 &= ~(1 << bit);
-	do_IRQ(bit);
+	do_IRQ(AU1000_INTC0_INT_BASE + bit);
 }
 
 
@@ -500,7 +500,7 @@ static void intc1_req0_irqdispatch(void)
 
 	bit = __ffs(intc1_req0);
 	intc1_req0 &= ~(1 << bit);
-	do_IRQ(MIPS_CPU_IRQ_BASE + 32 + bit);
+	do_IRQ(AU1000_INTC1_INT_BASE + bit);
 }
 
 
@@ -516,7 +516,7 @@ static void intc1_req1_irqdispatch(void)
 
 	bit = __ffs(intc1_req1);
 	intc1_req1 &= ~(1 << bit);
-	do_IRQ(MIPS_CPU_IRQ_BASE + 32 + bit);
+	do_IRQ(AU1000_INTC1_INT_BASE + bit);
 }
 
 asmlinkage void plat_irq_dispatch(void)
Index: linux-2.6/include/asm-mips/mach-au1x00/au1000.h
===================================================================
--- linux-2.6.orig/include/asm-mips/mach-au1x00/au1000.h
+++ linux-2.6/include/asm-mips/mach-au1x00/au1000.h
@@ -526,7 +526,7 @@ extern struct au1xxx_irqmap au1xxx_irq_m
 /* Au1000 */
 #ifdef CONFIG_SOC_AU1000
 enum soc_au1000_ints {
-	AU1000_FIRST_INT	= MIPS_CPU_IRQ_BASE,
+	AU1000_FIRST_INT	= MIPS_CPU_IRQ_BASE + 8,
 	AU1000_UART0_INT	= AU1000_FIRST_INT,
 	AU1000_UART1_INT,				/* au1000 */
 	AU1000_UART2_INT,				/* au1000 */
@@ -605,7 +605,7 @@ enum soc_au1000_ints {
 /* Au1500 */
 #ifdef CONFIG_SOC_AU1500
 enum soc_au1500_ints {
-	AU1500_FIRST_INT	= MIPS_CPU_IRQ_BASE,
+	AU1500_FIRST_INT	= MIPS_CPU_IRQ_BASE + 8,
 	AU1500_UART0_INT	= AU1500_FIRST_INT,
 	AU1000_PCI_INTA,				/* au1500 */
 	AU1000_PCI_INTB,				/* au1500 */
@@ -686,7 +686,7 @@ enum soc_au1500_ints {
 /* Au1100 */
 #ifdef CONFIG_SOC_AU1100
 enum soc_au1100_ints {
-	AU1100_FIRST_INT	= MIPS_CPU_IRQ_BASE,
+	AU1100_FIRST_INT	= MIPS_CPU_IRQ_BASE + 8,
 	AU1100_UART0_INT,
 	AU1100_UART1_INT,
 	AU1100_SD_INT,
@@ -761,7 +761,7 @@ enum soc_au1100_ints {
 
 #ifdef CONFIG_SOC_AU1550
 enum soc_au1550_ints {
-	AU1550_FIRST_INT	= MIPS_CPU_IRQ_BASE,
+	AU1550_FIRST_INT	= MIPS_CPU_IRQ_BASE + 8,
 	AU1550_UART0_INT	= AU1550_FIRST_INT,
 	AU1550_PCI_INTA,
 	AU1550_PCI_INTB,
@@ -851,7 +851,7 @@ enum soc_au1550_ints {
 
 #ifdef CONFIG_SOC_AU1200
 enum soc_au1200_ints {
-	AU1200_FIRST_INT	= MIPS_CPU_IRQ_BASE,
+	AU1200_FIRST_INT	= MIPS_CPU_IRQ_BASE + 8,
 	AU1200_UART0_INT	= AU1200_FIRST_INT,
 	AU1200_SWT_INT,
 	AU1200_SD_INT,
@@ -948,11 +948,12 @@ enum soc_au1200_ints {
 
 #endif /* CONFIG_SOC_AU1200 */
 
-#define AU1000_INTC0_INT_BASE	(MIPS_CPU_IRQ_BASE + 0)
-#define AU1000_INTC0_INT_LAST	(MIPS_CPU_IRQ_BASE + 31)
-#define AU1000_INTC1_INT_BASE	(MIPS_CPU_IRQ_BASE + 32)
-#define AU1000_INTC1_INT_LAST	(MIPS_CPU_IRQ_BASE + 63)
-#define AU1000_MAX_INTR		(MIPS_CPU_IRQ_BASE + 63)
+#define AU1000_INTC0_INT_BASE	(MIPS_CPU_IRQ_BASE + 8)
+#define AU1000_INTC0_INT_LAST	(AU1000_INTC0_INT_BASE + 31)
+#define AU1000_INTC1_INT_BASE	(AU1000_INTC0_INT_BASE + 32)
+#define AU1000_INTC1_INT_LAST	(AU1000_INTC1_INT_BASE + 31)
+
+#define AU1000_MAX_INTR 	AU1000_INTC1_INT_LAST
 #define INTX			0xFF			/* not valid */
 
 /* Programmable Counters 0 and 1 */
