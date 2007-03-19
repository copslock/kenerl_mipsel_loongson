Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Mar 2007 00:23:19 +0000 (GMT)
Received: from phoenix.bawue.net ([193.7.176.60]:38093 "EHLO mail.bawue.net")
	by ftp.linux-mips.org with ESMTP id S20022914AbXCSAXR (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 19 Mar 2007 00:23:17 +0000
Received: from lagash (88-106-169-123.dynamic.dsl.as9105.com [88.106.169.123])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.bawue.net (Postfix) with ESMTP id 980BEBB52C;
	Mon, 19 Mar 2007 01:13:22 +0100 (CET)
Received: from ths by lagash with local (Exim 4.63)
	(envelope-from <ths@networkno.de>)
	id 1HT5VJ-0006ne-Jz; Mon, 19 Mar 2007 00:13:37 +0000
Date:	Mon, 19 Mar 2007 00:13:37 +0000
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Cleanup for plat_irq_dispatch functions
Message-ID: <20070319001337.GB7744@networkno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14534
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Hello All,

the appended patch
 - adds missing ST0_IM masks, which caused the logging of valid
   interrupts as spurious
 - stops pnx8550 to log every interrupt as spurious
 - adds cause register masks for ip22/ip32, which caused handling
   of masked interrupts
 - removes some superfluous parentheses in the SNI interrupt code


Thiemo


Signed-Off-By: Thiemo Seufer <ths@networkno.de>

diff --git a/arch/mips/ddb5xxx/ddb5477/irq.c b/arch/mips/ddb5xxx/ddb5477/irq.c
index 2b23234..faa4a50 100644
--- a/arch/mips/ddb5xxx/ddb5477/irq.c
+++ b/arch/mips/ddb5xxx/ddb5477/irq.c
@@ -194,7 +194,7 @@ static void vrc5477_irq_dispatch(void)
 
 asmlinkage void plat_irq_dispatch(void)
 {
-	unsigned int pending = read_c0_cause() & read_c0_status();
+	unsigned int pending = read_c0_cause() & read_c0_status() & ST0_IM;
 
 	if (pending & STATUSF_IP7)
 		do_IRQ(CPU_IRQ_BASE + 7);
diff --git a/arch/mips/emma2rh/markeins/irq.c b/arch/mips/emma2rh/markeins/irq.c
index e266300..6bcf6a0 100644
--- a/arch/mips/emma2rh/markeins/irq.c
+++ b/arch/mips/emma2rh/markeins/irq.c
@@ -115,7 +115,7 @@ void __init arch_init_irq(void)
 
 asmlinkage void plat_irq_dispatch(void)
 {
-        unsigned int pending = read_c0_status() & read_c0_cause();
+        unsigned int pending = read_c0_status() & read_c0_cause() & ST0_IM;
 
 	if (pending & STATUSF_IP7)
 		do_IRQ(CPU_IRQ_BASE + 7);
diff --git a/arch/mips/gt64120/ev64120/irq.c b/arch/mips/gt64120/ev64120/irq.c
index 04572b9..64e4c80 100644
--- a/arch/mips/gt64120/ev64120/irq.c
+++ b/arch/mips/gt64120/ev64120/irq.c
@@ -48,7 +48,7 @@
 
 asmlinkage void plat_irq_dispatch(void)
 {
-	unsigned int pending = read_c0_status() & read_c0_cause();
+	unsigned int pending = read_c0_status() & read_c0_cause() & ST0_IM;
 
 	if (pending & STATUSF_IP4)		/* int2 hardware line (timer) */
 		do_IRQ(4);
diff --git a/arch/mips/gt64120/wrppmc/irq.c b/arch/mips/gt64120/wrppmc/irq.c
index d3d9659..06177bf 100644
--- a/arch/mips/gt64120/wrppmc/irq.c
+++ b/arch/mips/gt64120/wrppmc/irq.c
@@ -32,7 +32,7 @@
 
 asmlinkage void plat_irq_dispatch(void)
 {
-	unsigned int pending = read_c0_status() & read_c0_cause();
+	unsigned int pending = read_c0_status() & read_c0_cause() & ST0_IM;
 
 	if (pending & STATUSF_IP7)
 		do_IRQ(WRPPMC_MIPS_TIMER_IRQ);	/* CPU Compare/Count internal timer */
diff --git a/arch/mips/jazz/irq.c b/arch/mips/jazz/irq.c
index 295892e..015cf4b 100644
--- a/arch/mips/jazz/irq.c
+++ b/arch/mips/jazz/irq.c
@@ -122,7 +122,7 @@ static void ll_local_dev(void)
 
 asmlinkage void plat_irq_dispatch(void)
 {
-	unsigned int pending = read_c0_cause() & read_c0_status() & ST0_IM;
+	unsigned int pending = read_c0_cause() & read_c0_status();
 
 	if (pending & IE_IRQ5)
 		write_c0_compare(0);
diff --git a/arch/mips/momentum/ocelot_c/irq.c b/arch/mips/momentum/ocelot_c/irq.c
index 40472f7..844d566 100644
--- a/arch/mips/momentum/ocelot_c/irq.c
+++ b/arch/mips/momentum/ocelot_c/irq.c
@@ -64,7 +64,7 @@ extern void ll_cpci_irq(void);
 
 asmlinkage void plat_irq_dispatch(void)
 {
-	unsigned int pending = read_c0_cause() & read_c0_status();
+	unsigned int pending = read_c0_cause() & read_c0_status() & ST0_IM;
 
 	if (pending & STATUSF_IP0)
 		do_IRQ(0);
diff --git a/arch/mips/philips/pnx8550/common/int.c b/arch/mips/philips/pnx8550/common/int.c
index b1c4805..aad0342 100644
--- a/arch/mips/philips/pnx8550/common/int.c
+++ b/arch/mips/philips/pnx8550/common/int.c
@@ -83,16 +83,15 @@ static void timer_irqdispatch(int irq)
 
 asmlinkage void plat_irq_dispatch(void)
 {
-	unsigned int pending = read_c0_status() & read_c0_cause();
+	unsigned int pending = read_c0_status() & read_c0_cause() & ST0_IM;
 
 	if (pending & STATUSF_IP2)
 		hw0_irqdispatch(2);
 	else if (pending & STATUSF_IP7) {
 		if (read_c0_config7() & 0x01c0)
 			timer_irqdispatch(7);
-	}
-
-	spurious_interrupt();
+	} else
+		spurious_interrupt();
 }
 
 static inline void modify_cp0_intmask(unsigned clr_mask, unsigned set_mask)
diff --git a/arch/mips/sgi-ip22/ip22-int.c b/arch/mips/sgi-ip22/ip22-int.c
index b454924..1834832 100644
--- a/arch/mips/sgi-ip22/ip22-int.c
+++ b/arch/mips/sgi-ip22/ip22-int.c
@@ -237,7 +237,7 @@ extern void indy_8254timer_irq(void);
 
 asmlinkage void plat_irq_dispatch(void)
 {
-	unsigned int pending = read_c0_cause();
+	unsigned int pending = read_c0_status() & read_c0_cause();
 
 	/*
 	 * First we check for r4k counter/timer IRQ.
diff --git a/arch/mips/sgi-ip32/ip32-irq.c b/arch/mips/sgi-ip32/ip32-irq.c
index 8c450d9..fb9da9a 100644
--- a/arch/mips/sgi-ip32/ip32-irq.c
+++ b/arch/mips/sgi-ip32/ip32-irq.c
@@ -454,7 +454,7 @@ static void ip32_irq5(void)
 
 asmlinkage void plat_irq_dispatch(void)
 {
-	unsigned int pending = read_c0_cause();
+	unsigned int pending = read_c0_status() & read_c0_cause();
 
 	if (likely(pending & IE_IRQ0))
 		ip32_irq0();
diff --git a/arch/mips/sibyte/sb1250/irq.c b/arch/mips/sibyte/sb1250/irq.c
index 1482394..0e6a13c 100644
--- a/arch/mips/sibyte/sb1250/irq.c
+++ b/arch/mips/sibyte/sb1250/irq.c
@@ -421,7 +421,7 @@ asmlinkage void plat_irq_dispatch(void)
 	 * blasting the high 32 bits.
 	 */
 
-	pending = read_c0_cause() & read_c0_status();
+	pending = read_c0_cause() & read_c0_status() & ST0_IM;
 
 #ifdef CONFIG_SIBYTE_SB1250_PROF
 	if (pending & CAUSEF_IP7) /* Cpu performance counter interrupt */
diff --git a/arch/mips/sni/pcimt.c b/arch/mips/sni/pcimt.c
index 39e5b4a..8e8593b 100644
--- a/arch/mips/sni/pcimt.c
+++ b/arch/mips/sni/pcimt.c
@@ -333,7 +333,7 @@ static void pcimt_hwint3(void)
 
 static void sni_pcimt_hwint(void)
 {
-	u32 pending = (read_c0_cause() & read_c0_status());
+	u32 pending = read_c0_cause() & read_c0_status();
 
 	if (pending & C_IRQ5)
 		do_IRQ (MIPS_CPU_IRQ_BASE + 7);
diff --git a/arch/mips/sni/pcit.c b/arch/mips/sni/pcit.c
index 8d6b3d5..1dfc3f0 100644
--- a/arch/mips/sni/pcit.c
+++ b/arch/mips/sni/pcit.c
@@ -271,7 +271,7 @@ static void pcit_hwint0(void)
 
 static void sni_pcit_hwint(void)
 {
-	u32 pending = (read_c0_cause() & read_c0_status());
+	u32 pending = read_c0_cause() & read_c0_status();
 
 	if (pending & C_IRQ1)
 		pcit_hwint1();
@@ -285,7 +285,7 @@ static void sni_pcit_hwint(void)
 
 static void sni_pcit_hwint_cplus(void)
 {
-	u32 pending = (read_c0_cause() & read_c0_status());
+	u32 pending = read_c0_cause() & read_c0_status();
 
 	if (pending & C_IRQ0)
 		pcit_hwint0();
diff --git a/arch/mips/tx4927/common/tx4927_irq.c b/arch/mips/tx4927/common/tx4927_irq.c
index e7f3e5b..3d25d01 100644
--- a/arch/mips/tx4927/common/tx4927_irq.c
+++ b/arch/mips/tx4927/common/tx4927_irq.c
@@ -416,7 +416,7 @@ static int tx4927_irq_nested(void)
 
 asmlinkage void plat_irq_dispatch(void)
 {
-	unsigned int pending = read_c0_status() & read_c0_cause();
+	unsigned int pending = read_c0_status() & read_c0_cause() & ST0_IM;
 
 	if (pending & STATUSF_IP7)			/* cpu timer */
 		do_IRQ(TX4927_IRQ_CPU_TIMER);
