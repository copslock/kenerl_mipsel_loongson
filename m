Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jul 2008 18:52:55 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:62637 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20029899AbYGWRwx (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 23 Jul 2008 18:52:53 +0100
Received: (qmail 6218 invoked by uid 1000); 23 Jul 2008 19:52:52 +0200
Date:	Wed, 23 Jul 2008 19:52:52 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	linux-mips@linux-mips.org
Subject: [PATCH 5/8] Alchemy: move calc_clock function
Message-ID: <20080723175252.GF5986@roarinelk.homelinux.net>
References: <20080723174557.GA5986@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080723174557.GA5986@roarinelk.homelinux.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19937
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Now that nothing in time.c depends on calc_clock (and vice versa),
it can be moved to clocks.c where it belongs.
While at it, give it a better non-generic name and call it
as soon as possible in plat_mem_init.

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 arch/mips/au1000/common/clocks.c |   54 ++++++++++++++++++++++++++++++++++++++
 arch/mips/au1000/common/dbg_io.c |    4 +-
 arch/mips/au1000/common/setup.c  |    9 ++++++
 arch/mips/au1000/common/time.c   |   54 --------------------------------------
 4 files changed, 65 insertions(+), 56 deletions(-)

diff --git a/arch/mips/au1000/common/clocks.c b/arch/mips/au1000/common/clocks.c
index a8170fd..d899185 100644
--- a/arch/mips/au1000/common/clocks.c
+++ b/arch/mips/au1000/common/clocks.c
@@ -27,11 +27,21 @@
  */
 
 #include <linux/module.h>
+#include <linux/spinlock.h>
+#include <asm/time.h>
 #include <asm/mach-au1x00/au1000.h>
 
+/*
+ * I haven't found anyone that doesn't use a 12 MHz source clock,
+ * but just in case.....
+ */
+#define AU1000_SRC_CLK	12000000
+
 static unsigned int au1x00_clock; /*  Hz */
 static unsigned long uart_baud_base;
 
+static DEFINE_SPINLOCK(time_lock);
+
 /*
  * Set the au1000_clock
  */
@@ -60,3 +70,47 @@ void set_au1x00_uart_baud_base(unsigned long new_baud_base)
 {
 	uart_baud_base = new_baud_base;
 }
+
+/*
+ * We read the real processor speed from the PLL.  This is important
+ * because it is more accurate than computing it from the 32 KHz
+ * counter, if it exists.  If we don't have an accurate processor
+ * speed, all of the peripherals that derive their clocks based on
+ * this advertised speed will introduce error and sometimes not work
+ * properly.  This function is futher convoluted to still allow configurations
+ * to do that in case they have really, really old silicon with a
+ * write-only PLL register.			-- Dan
+ */
+unsigned long au1xxx_calc_clock(void)
+{
+	unsigned long cpu_speed;
+	unsigned long flags;
+
+	spin_lock_irqsave(&time_lock, flags);
+
+	/*
+	 * On early Au1000, sys_cpupll was write-only. Since these
+	 * silicon versions of Au1000 are not sold by AMD, we don't bend
+	 * over backwards trying to determine the frequency.
+	 */
+	if (au1xxx_cpu_has_pll_wo())
+#ifdef CONFIG_SOC_AU1000_FREQUENCY
+		cpu_speed = CONFIG_SOC_AU1000_FREQUENCY;
+#else
+		cpu_speed = 396000000;
+#endif
+	else
+		cpu_speed = (au_readl(SYS_CPUPLL) & 0x0000003f) * AU1000_SRC_CLK;
+
+	/* On Alchemy CPU:counter ratio is 1:1 */
+	mips_hpt_frequency = cpu_speed;
+	/* Equation: Baudrate = CPU / (SD * 2 * CLKDIV * 16) */
+	set_au1x00_uart_baud_base(cpu_speed / (2 * ((int)(au_readl(SYS_POWERCTRL)
+							  & 0x03) + 2) * 16));
+
+	spin_unlock_irqrestore(&time_lock, flags);
+
+	set_au1x00_speed(cpu_speed);
+
+	return cpu_speed;
+}
diff --git a/arch/mips/au1000/common/dbg_io.c b/arch/mips/au1000/common/dbg_io.c
index af5be7d..72abb67 100644
--- a/arch/mips/au1000/common/dbg_io.c
+++ b/arch/mips/au1000/common/dbg_io.c
@@ -49,13 +49,13 @@
 #define UART16550_READ(y)     (au_readl(DEBUG_BASE + y) & 0xff)
 #define UART16550_WRITE(y, z) (au_writel(z & 0xff, DEBUG_BASE + y))
 
-extern unsigned long calc_clock(void);
+extern unsigned long au1xxx_calc_clock(void);
 
 void debugInit(u32 baud, u8 data, u8 parity, u8 stop)
 {
 	if (UART16550_READ(UART_MOD_CNTRL) != 0x3)
 		UART16550_WRITE(UART_MOD_CNTRL, 3);
-	calc_clock();
+	au1xxx_calc_clock();
 
 	/* disable interrupts */
 	UART16550_WRITE(UART_IER, 0);
diff --git a/arch/mips/au1000/common/setup.c b/arch/mips/au1000/common/setup.c
index b6242c6..c5bd251 100644
--- a/arch/mips/au1000/common/setup.c
+++ b/arch/mips/au1000/common/setup.c
@@ -41,10 +41,19 @@ extern void __init board_setup(void);
 extern void au1000_restart(char *);
 extern void au1000_halt(void);
 extern void au1000_power_off(void);
+extern unsigned long au1xxx_calc_clock(void);
 
 void __init plat_mem_setup(void)
 {
 	char *argptr;
+	unsigned long est_freq;
+
+	/* determine core clock */
+	est_freq = au1xxx_calc_clock();
+	est_freq += 5000;    /* round */
+	est_freq -= est_freq % 10000;
+	printk(KERN_INFO "(PRId %08x) @ %lu.%02lu MHz\n", read_c0_prid(),
+	       est_freq / 1000000, ((est_freq % 1000000) * 100) / 1000000);
 
 	board_setup();  /* board specific setup */
 
diff --git a/arch/mips/au1000/common/time.c b/arch/mips/au1000/common/time.c
index 00b7d3f..b907241 100644
--- a/arch/mips/au1000/common/time.c
+++ b/arch/mips/au1000/common/time.c
@@ -47,53 +47,6 @@
 
 extern int allow_au1k_wait; /* default off for CP0 Counter */
 
-static DEFINE_SPINLOCK(time_lock);
-
-/*
- * I haven't found anyone that doesn't use a 12 MHz source clock,
- * but just in case.....
- */
-#define AU1000_SRC_CLK	12000000
-
-/*
- * We read the real processor speed from the PLL.  This is important
- * because it is more accurate than computing it from the 32 KHz
- * counter, if it exists.  If we don't have an accurate processor
- * speed, all of the peripherals that derive their clocks based on
- * this advertised speed will introduce error and sometimes not work
- * properly.  This function is futher convoluted to still allow configurations
- * to do that in case they have really, really old silicon with a
- * write-only PLL register.			-- Dan
- */
-unsigned long calc_clock(void)
-{
-	unsigned long cpu_speed;
-	unsigned long flags;
-
-	spin_lock_irqsave(&time_lock, flags);
-
-	/*
-	 * On early Au1000, sys_cpupll was write-only. Since these
-	 * silicon versions of Au1000 are not sold by AMD, we don't bend
-	 * over backwards trying to determine the frequency.
-	 */
-	if (au1xxx_cpu_has_pll_wo())
-#ifdef CONFIG_SOC_AU1000_FREQUENCY
-		cpu_speed = CONFIG_SOC_AU1000_FREQUENCY;
-#else
-		cpu_speed = 396000000;
-#endif
-	else
-		cpu_speed = (au_readl(SYS_CPUPLL) & 0x0000003f) * AU1000_SRC_CLK;
-	/* On Alchemy CPU:counter ratio is 1:1 */
-	mips_hpt_frequency = cpu_speed;
-	/* Equation: Baudrate = CPU / (SD * 2 * CLKDIV * 16) */
-	set_au1x00_uart_baud_base(cpu_speed / (2 * ((int)(au_readl(SYS_POWERCTRL)
-							  & 0x03) + 2) * 16));
-	spin_unlock_irqrestore(&time_lock, flags);
-	return cpu_speed;
-}
-
 static cycle_t au1x_counter1_read(void)
 {
 	return au_readl(SYS_RTCREAD);
@@ -147,13 +100,6 @@ void __init plat_time_init(void)
 {
 	struct clock_event_device *cd = &au1x_rtcmatch2_clockdev;
 	unsigned long t;
-	unsigned int est_freq = calc_clock();
-
-	est_freq += 5000;    /* round */
-	est_freq -= est_freq%10000;
-	printk(KERN_INFO "(PRId %08x) @ %u.%02u MHz\n", read_c0_prid(),
-	       est_freq / 1000000, ((est_freq % 1000000) * 100) / 1000000);
-	set_au1x00_speed(est_freq);
 
 	/* Check if firmware (YAMON, ...) has enabled 32kHz and clock
 	 * has been detected.  If so install the rtcmatch2 clocksource,
-- 
1.5.6.3
