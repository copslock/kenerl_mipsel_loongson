Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Dec 2008 08:30:08 +0000 (GMT)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:15845 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S24162966AbYLUI0b (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 21 Dec 2008 08:26:31 +0000
Received: (qmail 3979 invoked from network); 21 Dec 2008 09:24:59 +0100
Received: from scarran.roarinelk.net (HELO localhost.localdomain) (192.168.0.242)
  by 192.168.0.1 with SMTP; 21 Dec 2008 09:24:59 +0100
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: [PATCH 11/14] Alchemy: move calc_clock function.
Date:	Sun, 21 Dec 2008 09:26:24 +0100
Message-Id: <a64458ed8315e19b979f72236e0b73ed5ab2891d.1229846414.git.mano@roarinelk.homelinux.net>
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <cc0520393daa157516ae4f2cc6a69bc7b60a2a39.1229846414.git.mano@roarinelk.homelinux.net>
References: <cover.1229846410.git.mano@roarinelk.homelinux.net>
 <caebb02f97491d8e5830438e1a746b0e02fa2c7c.1229846411.git.mano@roarinelk.homelinux.net>
 <80cf5c7a0db39a7230bae7766264acbfc68d200e.1229846412.git.mano@roarinelk.homelinux.net>
 <e6862a9acc480a4f00d0b7ae738e8a355a7e4810.1229846412.git.mano@roarinelk.homelinux.net>
 <ac2064c64b746420a21008fa4e9e7c4ecf048d7a.1229846413.git.mano@roarinelk.homelinux.net>
 <dc79b2a4d9da426f867de084c75940109eff1287.1229846413.git.mano@roarinelk.homelinux.net>
 <535458cb8c8f570089b2712a1e73ca7314d5b7c7.1229846413.git.mano@roarinelk.homelinux.net>
 <ad6889e72585d9fa5bedeb080d6d78d91c9e23c9.1229846414.git.mano@roarinelk.homelinux.net>
 <f701f25036ff0e654e2bad646e0103b32cb83d34.1229846414.git.mano@roarinelk.homelinux.net>
 <45ced0b4c4d707995c92fc9c56bb71e2d383b3f2.1229846414.git.mano@roarinelk.homelinux.net>
 <cc0520393daa157516ae4f2cc6a69bc7b60a2a39.1229846414.git.mano@roarinelk.homelinux.net>
In-Reply-To: <cover.1229846410.git.mano@roarinelk.homelinux.net>
References: <cover.1229846410.git.mano@roarinelk.homelinux.net>
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21645
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Now that nothing in time.c depends on calc_clock, it can
be moved to clocks.c where it belongs.
While at it, give it a better non-generic name and call it
as soon as possible in plat_mem_init.

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 arch/mips/alchemy/common/clocks.c          |   54 ++++++++++++++++++++++++++++
 arch/mips/alchemy/common/setup.c           |    9 +++++
 arch/mips/alchemy/common/time.c            |   54 ----------------------------
 arch/mips/include/asm/mach-au1x00/au1000.h |    1 +
 4 files changed, 64 insertions(+), 54 deletions(-)

diff --git a/arch/mips/alchemy/common/clocks.c b/arch/mips/alchemy/common/clocks.c
index a8170fd..d899185 100644
--- a/arch/mips/alchemy/common/clocks.c
+++ b/arch/mips/alchemy/common/clocks.c
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
diff --git a/arch/mips/alchemy/common/setup.c b/arch/mips/alchemy/common/setup.c
index 8ad453a..3f036b3 100644
--- a/arch/mips/alchemy/common/setup.c
+++ b/arch/mips/alchemy/common/setup.c
@@ -44,6 +44,15 @@ extern void set_cpuspec(void);
 
 void __init plat_mem_setup(void)
 {
+	unsigned long est_freq;
+
+	/* determine core clock */
+	est_freq = au1xxx_calc_clock();
+	est_freq += 5000;    /* round */
+	est_freq -= est_freq % 10000;
+	printk(KERN_INFO "(PRId %08x) @ %lu.%02lu MHz\n", read_c0_prid(),
+	       est_freq / 1000000, ((est_freq % 1000000) * 100) / 1000000);
+
 	_machine_restart = au1000_restart;
 	_machine_halt = au1000_halt;
 	pm_power_off = au1000_power_off;
diff --git a/arch/mips/alchemy/common/time.c b/arch/mips/alchemy/common/time.c
index 57f0aec..3288014 100644
--- a/arch/mips/alchemy/common/time.c
+++ b/arch/mips/alchemy/common/time.c
@@ -44,53 +44,6 @@
 
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
@@ -150,13 +103,6 @@ void __init plat_time_init(void)
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
diff --git a/arch/mips/include/asm/mach-au1x00/au1000.h b/arch/mips/include/asm/mach-au1x00/au1000.h
index 5db26e6..2b88c29 100644
--- a/arch/mips/include/asm/mach-au1x00/au1000.h
+++ b/arch/mips/include/asm/mach-au1x00/au1000.h
@@ -135,6 +135,7 @@ extern void set_au1x00_speed(unsigned int new_freq);
 extern unsigned int get_au1x00_speed(void);
 extern void set_au1x00_uart_baud_base(unsigned long new_baud_base);
 extern unsigned long get_au1x00_uart_baud_base(void);
+extern unsigned long au1xxx_calc_clock(void);
 
 /*
  * Every board describes its IRQ mapping with this table.
-- 
1.6.0.4
