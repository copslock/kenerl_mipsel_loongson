Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Oct 2007 17:26:06 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:3033 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20044808AbXJSQZ5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 19 Oct 2007 17:25:57 +0100
Received: from localhost (p3184-ipad306funabasi.chiba.ocn.ne.jp [123.217.173.184])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 108559EE9; Sat, 20 Oct 2007 01:24:36 +0900 (JST)
Date:	Sat, 20 Oct 2007 01:26:25 +0900 (JST)
Message-Id: <20071020.012625.63132084.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Kill duplicated setup_irq() for cp0 timer
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17133
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Also many plat_timer_setup() can be killed too.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/bcm47xx/time.c                           |    7 -------
 arch/mips/emma2rh/markeins/setup.c                 |    6 ------
 arch/mips/lemote/lm2e/setup.c                      |    5 -----
 arch/mips/pmc-sierra/msp71xx/msp_time.c            |    3 ---
 arch/mips/pmc-sierra/yosemite/setup.c              |    5 -----
 arch/mips/sni/time.c                               |   18 ------------------
 arch/mips/tx4927/common/tx4927_setup.c             |   16 ----------------
 .../toshiba_rbtx4927/toshiba_rbtx4927_setup.c      |   10 ----------
 arch/mips/tx4938/common/setup.c                    |    5 -----
 arch/mips/vr41xx/common/init.c                     |    5 -----
 include/asm-mips/sni.h                             |    2 --
 11 files changed, 0 insertions(+), 82 deletions(-)

diff --git a/arch/mips/bcm47xx/time.c b/arch/mips/bcm47xx/time.c
index 0ab4676..0c6f47b 100644
--- a/arch/mips/bcm47xx/time.c
+++ b/arch/mips/bcm47xx/time.c
@@ -46,10 +46,3 @@ void __init plat_time_init(void)
 	/* Set MIPS counter frequency for fixed_rate_gettimeoffset() */
 	mips_hpt_frequency = hz;
 }
-
-void __init
-plat_timer_setup(struct irqaction *irq)
-{
-	/* Enable the timer interrupt */
-	setup_irq(7, irq);
-}
diff --git a/arch/mips/emma2rh/markeins/setup.c b/arch/mips/emma2rh/markeins/setup.c
index 5e1da53..82f9e90 100644
--- a/arch/mips/emma2rh/markeins/setup.c
+++ b/arch/mips/emma2rh/markeins/setup.c
@@ -104,12 +104,6 @@ void __init plat_time_init(void)
 	mips_hpt_frequency = (bus_frequency * (4 + reg)) / 4 / 2;
 }
 
-void __init plat_timer_setup(struct irqaction *irq)
-{
-	/* we are using the cpu counter for timer interrupts */
-	setup_irq(CPU_IRQ_BASE + 7, irq);
-}
-
 static void markeins_board_init(void);
 extern void markeins_irq_setup(void);
 
diff --git a/arch/mips/lemote/lm2e/setup.c b/arch/mips/lemote/lm2e/setup.c
index 09314a2..2cc6745 100644
--- a/arch/mips/lemote/lm2e/setup.c
+++ b/arch/mips/lemote/lm2e/setup.c
@@ -53,11 +53,6 @@ unsigned long bus_clock;
 unsigned int memsize;
 unsigned int highmemsize = 0;
 
-void __init plat_timer_setup(struct irqaction *irq)
-{
-	setup_irq(MIPS_CPU_IRQ_BASE + 7, irq);
-}
-
 void __init plat_time_init(void)
 {
 	/* setup mips r4k timer */
diff --git a/arch/mips/pmc-sierra/msp71xx/msp_time.c b/arch/mips/pmc-sierra/msp71xx/msp_time.c
index f221d47..7cfeda5 100644
--- a/arch/mips/pmc-sierra/msp71xx/msp_time.c
+++ b/arch/mips/pmc-sierra/msp71xx/msp_time.c
@@ -86,8 +86,5 @@ void __init plat_timer_setup(struct irqaction *irq)
 #ifdef CONFIG_IRQ_MSP_CIC
 	/* we are using the vpe0 counter for timer interrupts */
 	setup_irq(MSP_INT_VPE0_TIMER, irq);
-#else
-	/* we are using the mips counter for timer interrupts */
-	setup_irq(MSP_INT_TIMER, irq);
 #endif
 }
diff --git a/arch/mips/pmc-sierra/yosemite/setup.c b/arch/mips/pmc-sierra/yosemite/setup.c
index 015fcc3..855977c 100644
--- a/arch/mips/pmc-sierra/yosemite/setup.c
+++ b/arch/mips/pmc-sierra/yosemite/setup.c
@@ -137,11 +137,6 @@ int rtc_mips_set_time(unsigned long tim)
 	return 0;
 }
 
-void __init plat_timer_setup(struct irqaction *irq)
-{
-	setup_irq(7, irq);
-}
-
 void __init plat_time_init(void)
 {
 	mips_hpt_frequency = cpu_clock_freq / 2;
diff --git a/arch/mips/sni/time.c b/arch/mips/sni/time.c
index b808773..0910b35 100644
--- a/arch/mips/sni/time.c
+++ b/arch/mips/sni/time.c
@@ -121,15 +121,6 @@ void __init plat_time_init(void)
 	setup_pit_timer();
 }
 
-/*
- * R4k counter based timer interrupt. Works on RM200-225 and possibly
- * others but not on RM400
- */
-static void __init sni_cpu_timer_setup(struct irqaction *irq)
-{
-        setup_irq(SNI_MIPS_IRQ_CPU_TIMER, irq);
-}
-
 void __init plat_timer_setup(struct irqaction *irq)
 {
 	switch (sni_brd_type) {
@@ -139,15 +130,6 @@ void __init plat_timer_setup(struct irqaction *irq)
 	case SNI_BRD_MINITOWER:
 	        sni_a20r_timer_setup(irq);
 	        break;
-
-	case SNI_BRD_PCI_TOWER:
-	case SNI_BRD_RM200:
-	case SNI_BRD_PCI_MTOWER:
-	case SNI_BRD_PCI_DESKTOP:
-	case SNI_BRD_PCI_TOWER_CPLUS:
-	case SNI_BRD_PCI_MTOWER_CPLUS:
-	        sni_cpu_timer_setup(irq);
-	        break;
 	}
 }
 
diff --git a/arch/mips/tx4927/common/tx4927_setup.c b/arch/mips/tx4927/common/tx4927_setup.c
index 8ce0989..36c5f20 100644
--- a/arch/mips/tx4927/common/tx4927_setup.c
+++ b/arch/mips/tx4927/common/tx4927_setup.c
@@ -72,22 +72,6 @@ void __init plat_time_init(void)
 #endif
 }
 
-void __init plat_timer_setup(struct irqaction *irq)
-{
-	setup_irq(TX4927_IRQ_CPU_TIMER, irq);
-
-#ifdef CONFIG_TOSHIBA_RBTX4927
-	{
-		extern void toshiba_rbtx4927_timer_setup(struct irqaction
-							 *irq);
-		toshiba_rbtx4927_timer_setup(irq);
-	}
-#endif
-
-	return;
-}
-
-
 #ifdef DEBUG
 void print_cp0(char *key, int num, char *name, u32 val)
 {
diff --git a/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c b/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c
index b97102a..c7470fb 100644
--- a/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c
+++ b/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c
@@ -94,7 +94,6 @@
 #define TOSHIBA_RBTX4927_SETUP_EFWFU       ( 1 <<  3 )
 #define TOSHIBA_RBTX4927_SETUP_SETUP       ( 1 <<  4 )
 #define TOSHIBA_RBTX4927_SETUP_TIME_INIT   ( 1 <<  5 )
-#define TOSHIBA_RBTX4927_SETUP_TIMER_SETUP ( 1 <<  6 )
 #define TOSHIBA_RBTX4927_SETUP_PCIBIOS     ( 1 <<  7 )
 #define TOSHIBA_RBTX4927_SETUP_PCI1        ( 1 <<  8 )
 #define TOSHIBA_RBTX4927_SETUP_PCI2        ( 1 <<  9 )
@@ -108,7 +107,6 @@ static const u32 toshiba_rbtx4927_setup_debug_flag =
     (TOSHIBA_RBTX4927_SETUP_NONE | TOSHIBA_RBTX4927_SETUP_INFO |
      TOSHIBA_RBTX4927_SETUP_WARN | TOSHIBA_RBTX4927_SETUP_EROR |
      TOSHIBA_RBTX4927_SETUP_EFWFU | TOSHIBA_RBTX4927_SETUP_SETUP |
-     TOSHIBA_RBTX4927_SETUP_TIME_INIT | TOSHIBA_RBTX4927_SETUP_TIMER_SETUP
      | TOSHIBA_RBTX4927_SETUP_PCIBIOS | TOSHIBA_RBTX4927_SETUP_PCI1 |
      TOSHIBA_RBTX4927_SETUP_PCI2 | TOSHIBA_RBTX4927_SETUP_PCI66);
 #endif
@@ -947,14 +945,6 @@ toshiba_rbtx4927_time_init(void)
 
 }
 
-void __init toshiba_rbtx4927_timer_setup(struct irqaction *irq)
-{
-	TOSHIBA_RBTX4927_SETUP_DPRINTK(TOSHIBA_RBTX4927_SETUP_TIMER_SETUP,
-				       "-\n");
-	TOSHIBA_RBTX4927_SETUP_DPRINTK(TOSHIBA_RBTX4927_SETUP_TIMER_SETUP,
-				       "+\n");
-}
-
 static int __init toshiba_rbtx4927_rtc_init(void)
 {
 	static struct resource __initdata res = {
diff --git a/arch/mips/tx4938/common/setup.c b/arch/mips/tx4938/common/setup.c
index ab40822..be3b88d 100644
--- a/arch/mips/tx4938/common/setup.c
+++ b/arch/mips/tx4938/common/setup.c
@@ -43,8 +43,3 @@ plat_mem_setup(void)
 {
 	toshiba_rbtx4938_setup();
 }
-
-void __init plat_timer_setup(struct irqaction *irq)
-{
-	setup_irq(TX4938_IRQ_CPU_TIMER, irq);
-}
diff --git a/arch/mips/vr41xx/common/init.c b/arch/mips/vr41xx/common/init.c
index 407cec2..8d760df 100644
--- a/arch/mips/vr41xx/common/init.c
+++ b/arch/mips/vr41xx/common/init.c
@@ -48,11 +48,6 @@ void __init plat_time_init(void)
 		mips_hpt_frequency = tclock / 4;
 }
 
-void __init plat_timer_setup(struct irqaction *irq)
-{
-	setup_irq(TIMER_IRQ, irq);
-}
-
 void __init plat_mem_setup(void)
 {
 	vr41xx_calculate_clock_frequency();
diff --git a/include/asm-mips/sni.h b/include/asm-mips/sni.h
index 4d43dbb..af08145 100644
--- a/include/asm-mips/sni.h
+++ b/include/asm-mips/sni.h
@@ -141,8 +141,6 @@ extern unsigned int sni_brd_type;
 #define A20R_PT_TIM0_ACK        0xbc050000
 #define A20R_PT_TIM1_ACK        0xbc060000
 
-#define SNI_MIPS_IRQ_CPU_TIMER  (MIPS_CPU_IRQ_BASE+7)
-
 #define SNI_A20R_IRQ_BASE       MIPS_CPU_IRQ_BASE
 #define SNI_A20R_IRQ_TIMER      (SNI_A20R_IRQ_BASE+5)
 
