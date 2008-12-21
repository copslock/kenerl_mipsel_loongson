Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Dec 2008 08:30:28 +0000 (GMT)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:46279 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S24172356AbYLUI0b (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 21 Dec 2008 08:26:31 +0000
Received: (qmail 3983 invoked from network); 21 Dec 2008 09:24:59 +0100
Received: from scarran.roarinelk.net (HELO localhost.localdomain) (192.168.0.242)
  by 192.168.0.1 with SMTP; 21 Dec 2008 09:24:59 +0100
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: [PATCH 12/14] Alchemy: Fix up PM code on Au1550/Au1200
Date:	Sun, 21 Dec 2008 09:26:25 +0100
Message-Id: <b7b8752b8d9421eb381c93f945d6c0f53b2f74cd.1229846415.git.mano@roarinelk.homelinux.net>
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <a64458ed8315e19b979f72236e0b73ed5ab2891d.1229846414.git.mano@roarinelk.homelinux.net>
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
 <a64458ed8315e19b979f72236e0b73ed5ab2891d.1229846414.git.mano@roarinelk.homelinux.net>
In-Reply-To: <cover.1229846410.git.mano@roarinelk.homelinux.net>
References: <cover.1229846410.git.mano@roarinelk.homelinux.net>
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21646
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Au1550/Au1200 have a different memory controller which requires additi-
onal code to properly put memory to sleep (code taken from AMD/RMI's
Linux-2.6.11 source package).

Also fix up the remaining pm-related paths to compile on Au1200/Au1550
platforms.

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 arch/mips/alchemy/common/power.c           |  266 ++++++++++++++++------------
 arch/mips/alchemy/common/reset.c           |    2 -
 arch/mips/alchemy/common/sleeper.S         |  118 +++++++-----
 arch/mips/include/asm/mach-au1x00/au1000.h |    6 +
 4 files changed, 225 insertions(+), 167 deletions(-)

diff --git a/arch/mips/alchemy/common/power.c b/arch/mips/alchemy/common/power.c
index 997dd56..f08312b 100644
--- a/arch/mips/alchemy/common/power.c
+++ b/arch/mips/alchemy/common/power.c
@@ -35,7 +35,6 @@
 #include <linux/jiffies.h>
 
 #include <asm/uaccess.h>
-#include <asm/cacheflush.h>
 #include <asm/mach-au1x00/au1000.h>
 
 #ifdef CONFIG_PM
@@ -47,8 +46,6 @@
 #define DPRINTK(fmt, args...)
 #endif
 
-static void au1000_calibrate_delay(void);
-
 extern unsigned long save_local_and_disable(int controller);
 extern void restore_local_and_enable(int controller, unsigned long mask);
 
@@ -64,17 +61,15 @@ static DEFINE_SPINLOCK(pm_lock);
  * We only have to save/restore registers that aren't otherwise
  * done as part of a driver pm_* function.
  */
-static unsigned int	sleep_aux_pll_cntrl;
-static unsigned int	sleep_cpu_pll_cntrl;
-static unsigned int	sleep_pin_function;
-static unsigned int	sleep_uart0_inten;
-static unsigned int	sleep_uart0_fifoctl;
-static unsigned int	sleep_uart0_linectl;
-static unsigned int	sleep_uart0_clkdiv;
-static unsigned int	sleep_uart0_enable;
-static unsigned int	sleep_usbhost_enable;
-static unsigned int	sleep_usbdev_enable;
-static unsigned int	sleep_static_memctlr[4][3];
+static unsigned int sleep_uart0_inten;
+static unsigned int sleep_uart0_fifoctl;
+static unsigned int sleep_uart0_linectl;
+static unsigned int sleep_uart0_clkdiv;
+static unsigned int sleep_uart0_enable;
+static unsigned int sleep_usb[2];
+static unsigned int sleep_sys_clocks[5];
+static unsigned int sleep_sys_pinfunc;
+static unsigned int sleep_static_memctlr[4][3];
 
 /*
  * Define this to cause the value you write to /proc/sys/pm/sleep to
@@ -108,31 +103,45 @@ static void save_core_regs(void)
 	sleep_uart0_linectl = au_readl(UART0_ADDR + UART_LCR);
 	sleep_uart0_clkdiv = au_readl(UART0_ADDR + UART_CLK);
 	sleep_uart0_enable = au_readl(UART0_ADDR + UART_MOD_CNTRL);
+	au_sync();
 
+#ifndef CONFIG_SOC_AU1200
 	/* Shutdown USB host/device. */
-	sleep_usbhost_enable = au_readl(USB_HOST_CONFIG);
+	sleep_usb[0] = au_readl(USB_HOST_CONFIG);
 
 	/* There appears to be some undocumented reset register.... */
-	au_writel(0, 0xb0100004); au_sync();
-	au_writel(0, USB_HOST_CONFIG); au_sync();
+	au_writel(0, 0xb0100004);
+	au_sync();
+	au_writel(0, USB_HOST_CONFIG);
+	au_sync();
+
+	sleep_usb[1] = au_readl(USBD_ENABLE);
+	au_writel(0, USBD_ENABLE);
+	au_sync();
+
+#else	/* AU1200 */
 
-	sleep_usbdev_enable = au_readl(USBD_ENABLE);
-	au_writel(0, USBD_ENABLE); au_sync();
+	/* enable access to OTG mmio so we can save OTG CAP/MUX.
+	 * FIXME: write an OTG driver and move this stuff there!
+	 */
+	au_writel(au_readl(USB_MSR_BASE + 4) | (1 << 6), USB_MSR_BASE + 4);
+	au_sync();
+	sleep_usb[0] = au_readl(0xb4020020);	/* OTG_CAP */
+	sleep_usb[1] = au_readl(0xb4020024);	/* OTG_MUX */
+#endif
 
 	/* Save interrupt controller state. */
 	save_au1xxx_intctl();
 
 	/* Clocks and PLLs. */
-	sleep_aux_pll_cntrl = au_readl(SYS_AUXPLL);
+	sleep_sys_clocks[0] = au_readl(SYS_FREQCTRL0);
+	sleep_sys_clocks[1] = au_readl(SYS_FREQCTRL1);
+	sleep_sys_clocks[2] = au_readl(SYS_CLKSRC);
+	sleep_sys_clocks[3] = au_readl(SYS_CPUPLL);
+	sleep_sys_clocks[4] = au_readl(SYS_AUXPLL);
 
-	/*
-	 * We don't really need to do this one, but unless we
-	 * write it again it won't have a valid value if we
-	 * happen to read it.
-	 */
-	sleep_cpu_pll_cntrl = au_readl(SYS_CPUPLL);
-
-	sleep_pin_function = au_readl(SYS_PINFUNC);
+	/* pin mux config */
+	sleep_sys_pinfunc = au_readl(SYS_PINFUNC);
 
 	/* Save the static memory controller configuration. */
 	sleep_static_memctlr[0][0] = au_readl(MEM_STCFG0);
@@ -151,12 +160,37 @@ static void save_core_regs(void)
 
 static void restore_core_regs(void)
 {
-	extern void restore_au1xxx_intctl(void);
-	extern void wakeup_counter0_adjust(void);
+	/* restore clock configuration.  Writing CPUPLL last will
+	 * stall a bit and stabilize other clocks (unless this is
+	 * one of those Au1000 with a write-only PLL, where we dont
+	 * have a valid value)
+	 */
+	au_writel(sleep_sys_clocks[0], SYS_FREQCTRL0);
+	au_writel(sleep_sys_clocks[1], SYS_FREQCTRL1);
+	au_writel(sleep_sys_clocks[2], SYS_CLKSRC);
+	au_writel(sleep_sys_clocks[4], SYS_AUXPLL);
+	if (!au1xxx_cpu_has_pll_wo())
+		au_writel(sleep_sys_clocks[3], SYS_CPUPLL);
+	au_sync();
+
+	au_writel(sleep_sys_pinfunc, SYS_PINFUNC);
+	au_sync();
+
+#ifndef CONFIG_SOC_AU1200
+	au_writel(sleep_usb[0], USB_HOST_CONFIG);
+	au_writel(sleep_usb[1], USBD_ENABLE);
+	au_sync();
+#else
+	/* enable accces to OTG memory */
+	au_writel(au_readl(USB_MSR_BASE + 4) | (1 << 6), USB_MSR_BASE + 4);
+	au_sync();
 
-	au_writel(sleep_aux_pll_cntrl, SYS_AUXPLL); au_sync();
-	au_writel(sleep_cpu_pll_cntrl, SYS_CPUPLL); au_sync();
-	au_writel(sleep_pin_function, SYS_PINFUNC); au_sync();
+	/* restore OTG caps and port mux. */
+	au_writel(sleep_usb[0], 0xb4020020 + 0);	/* OTG_CAP */
+	au_sync();
+	au_writel(sleep_usb[1], 0xb4020020 + 4);	/* OTG_MUX */
+	au_sync();
+#endif
 
 	/* Restore the static memory controller configuration. */
 	au_writel(sleep_static_memctlr[0][0], MEM_STCFG0);
@@ -196,16 +230,45 @@ void wakeup_from_suspend(void)
 	suspend_mode = 0;
 }
 
-int au_sleep(void)
+void au_sleep(void)
+{
+	save_core_regs();
+	au1xxx_save_and_sleep();
+	restore_core_regs();
+}
+
+static int pm_do_sleep(ctl_table *ctl, int write, struct file *file,
+		       void __user *buffer, size_t *len, loff_t *ppos)
 {
 	unsigned long wakeup, flags;
-	extern void save_and_sleep(void);
+	int ret;
+#ifdef SLEEP_TEST_TIMEOUT
+#define TMPBUFLEN2 16
+	char buf[TMPBUFLEN2], *p;
+#endif
 
 	spin_lock_irqsave(&pm_lock, flags);
 
-	save_core_regs();
+	if (!write) {
+		*len = 0;
+		ret = 0;
+		goto out_unlock;
+	};
 
-	flush_cache_all();
+#ifdef SLEEP_TEST_TIMEOUT
+	if (*len > TMPBUFLEN2 - 1) {
+		ret = -EFAULT;
+		goto out_unlock;
+	}
+	if (copy_from_user(buf, buffer, *len)) {
+		return -EFAULT;
+		goto out_unlock;
+	}
+	buf[*len] = 0;
+	p = buf;
+	sleep_ticks = simple_strtoul(p, &p, 0);
+	wakeup_counter0_set(sleep_ticks);
+#endif
 
 	/**
 	 ** The code below is all system dependent and we should probably
@@ -223,9 +286,6 @@ int au_sleep(void)
 	wakeup |= 1 << 6;	/* turn on  GPIO  6 wakeup */
 #else
 	/* For testing, allow match20 to wake us up. */
-#ifdef SLEEP_TEST_TIMEOUT
-	wakeup_counter0_set(sleep_ticks);
-#endif
 	wakeup = 1 << 8;	/* turn on match20 wakeup   */
 	wakeup = 0;
 #endif
@@ -234,41 +294,62 @@ int au_sleep(void)
 	au_writel(wakeup, SYS_WAKEMSK);
 	au_sync();
 
-	save_and_sleep();
+	au_sleep();
+	ret = 0;
 
-	/*
-	 * After a wakeup, the cpu vectors back to 0x1fc00000, so
-	 * it's up to the boot code to get us back here.
-	 */
-	restore_core_regs();
+out_unlock:
 	spin_unlock_irqrestore(&pm_lock, flags);
-	return 0;
+	return ret;
 }
 
-static int pm_do_sleep(ctl_table *ctl, int write, struct file *file,
-		       void __user *buffer, size_t *len, loff_t *ppos)
+#if !defined(CONFIG_SOC_AU1200) && !defined(CONFIG_SOC_AU1550)
+
+/*
+ * This is right out of init/main.c
+ */
+
+/*
+ * This is the number of bits of precision for the loops_per_jiffy.
+ * Each bit takes on average 1.5/HZ seconds.  This (like the original)
+ * is a little better than 1%.
+ */
+#define LPS_PREC 8
+
+static void au1000_calibrate_delay(void)
 {
-#ifdef SLEEP_TEST_TIMEOUT
-#define TMPBUFLEN2 16
-	char buf[TMPBUFLEN2], *p;
-#endif
+	unsigned long ticks, loopbit;
+	int lps_precision = LPS_PREC;
 
-	if (!write)
-		*len = 0;
-	else {
-#ifdef SLEEP_TEST_TIMEOUT
-		if (*len > TMPBUFLEN2 - 1)
-			return -EFAULT;
-		if (copy_from_user(buf, buffer, *len))
-			return -EFAULT;
-		buf[*len] = 0;
-		p = buf;
-		sleep_ticks = simple_strtoul(p, &p, 0);
-#endif
+	loops_per_jiffy = 1 << 12;
 
-		au_sleep();
+	while (loops_per_jiffy <<= 1) {
+		/* Wait for "start of" clock tick */
+		ticks = jiffies;
+		while (ticks == jiffies)
+			/* nothing */ ;
+		/* Go ... */
+		ticks = jiffies;
+		__delay(loops_per_jiffy);
+		ticks = jiffies - ticks;
+		if (ticks)
+			break;
+	}
+
+	/*
+	 * Do a binary approximation to get loops_per_jiffy set to be equal
+	 * one clock (up to lps_precision bits)
+	 */
+	loops_per_jiffy >>= 1;
+	loopbit = loops_per_jiffy;
+	while (lps_precision-- && (loopbit >>= 1)) {
+		loops_per_jiffy |= loopbit;
+		ticks = jiffies;
+		while (ticks == jiffies);
+		ticks = jiffies;
+		__delay(loops_per_jiffy);
+		if (jiffies != ticks)	/* longer than 1 tick */
+			loops_per_jiffy &= ~loopbit;
 	}
-	return 0;
 }
 
 static int pm_do_freq(ctl_table *ctl, int write, struct file *file,
@@ -377,7 +458,7 @@ static int pm_do_freq(ctl_table *ctl, int write, struct file *file,
 
 	return retval;
 }
-
+#endif
 
 static struct ctl_table pm_table[] = {
 	{
@@ -388,6 +469,7 @@ static struct ctl_table pm_table[] = {
 		.mode		= 0600,
 		.proc_handler	= &pm_do_sleep
 	},
+#if !defined(CONFIG_SOC_AU1200) && !defined(CONFIG_SOC_AU1550)
 	{
 		.ctl_name	= CTL_UNNUMBERED,
 		.procname	= "freq",
@@ -396,6 +478,7 @@ static struct ctl_table pm_table[] = {
 		.mode		= 0600,
 		.proc_handler	= &pm_do_freq
 	},
+#endif
 	{}
 };
 
@@ -429,51 +512,4 @@ static int __init pm_init(void)
 
 __initcall(pm_init);
 
-/*
- * This is right out of init/main.c
- */
-
-/*
- * This is the number of bits of precision for the loops_per_jiffy.
- * Each bit takes on average 1.5/HZ seconds.  This (like the original)
- * is a little better than 1%.
- */
-#define LPS_PREC 8
-
-static void au1000_calibrate_delay(void)
-{
-	unsigned long ticks, loopbit;
-	int lps_precision = LPS_PREC;
-
-	loops_per_jiffy = 1 << 12;
-
-	while (loops_per_jiffy <<= 1) {
-		/* Wait for "start of" clock tick */
-		ticks = jiffies;
-		while (ticks == jiffies)
-			/* nothing */ ;
-		/* Go ... */
-		ticks = jiffies;
-		__delay(loops_per_jiffy);
-		ticks = jiffies - ticks;
-		if (ticks)
-			break;
-	}
-
-	/*
-	 * Do a binary approximation to get loops_per_jiffy set to be equal
-	 * one clock (up to lps_precision bits)
-	 */
-	loops_per_jiffy >>= 1;
-	loopbit = loops_per_jiffy;
-	while (lps_precision-- && (loopbit >>= 1)) {
-		loops_per_jiffy |= loopbit;
-		ticks = jiffies;
-		while (ticks == jiffies);
-		ticks = jiffies;
-		__delay(loops_per_jiffy);
-		if (jiffies != ticks)	/* longer than 1 tick */
-			loops_per_jiffy &= ~loopbit;
-	}
-}
 #endif	/* CONFIG_PM */
diff --git a/arch/mips/alchemy/common/reset.c b/arch/mips/alchemy/common/reset.c
index d555429..0191c93 100644
--- a/arch/mips/alchemy/common/reset.c
+++ b/arch/mips/alchemy/common/reset.c
@@ -31,8 +31,6 @@
 
 #include <asm/mach-au1x00/au1000.h>
 
-extern int au_sleep(void);
-
 void au1000_restart(char *command)
 {
 	/* Set all integrated peripherals to disabled states */
diff --git a/arch/mips/alchemy/common/sleeper.S b/arch/mips/alchemy/common/sleeper.S
index 3006e27..4f4b167 100644
--- a/arch/mips/alchemy/common/sleeper.S
+++ b/arch/mips/alchemy/common/sleeper.S
@@ -15,16 +15,17 @@
 #include <asm/regdef.h>
 #include <asm/stackframe.h>
 
+	.extern __flush_cache_all
+
 	.text
-	.set	macro
-	.set	noat
+	.set noreorder
+	.set noat
 	.align	5
 
 /* Save all of the processor general registers and go to sleep.
  * A wakeup condition will get us back here to restore the registers.
  */
-LEAF(save_and_sleep)
-
+LEAF(au1xxx_save_and_sleep)
 	subu	sp, PT_SIZE
 	sw	$1, PT_R1(sp)
 	sw	$2, PT_R2(sp)
@@ -33,14 +34,6 @@ LEAF(save_and_sleep)
 	sw	$5, PT_R5(sp)
 	sw	$6, PT_R6(sp)
 	sw	$7, PT_R7(sp)
-	sw	$8, PT_R8(sp)
-	sw	$9, PT_R9(sp)
-	sw	$10, PT_R10(sp)
-	sw	$11, PT_R11(sp)
-	sw	$12, PT_R12(sp)
-	sw	$13, PT_R13(sp)
-	sw	$14, PT_R14(sp)
-	sw	$15, PT_R15(sp)
 	sw	$16, PT_R16(sp)
 	sw	$17, PT_R17(sp)
 	sw	$18, PT_R18(sp)
@@ -49,12 +42,9 @@ LEAF(save_and_sleep)
 	sw	$21, PT_R21(sp)
 	sw	$22, PT_R22(sp)
 	sw	$23, PT_R23(sp)
-	sw	$24, PT_R24(sp)
-	sw	$25, PT_R25(sp)
 	sw	$26, PT_R26(sp)
 	sw	$27, PT_R27(sp)
 	sw	$28, PT_R28(sp)
-	sw	$29, PT_R29(sp)
 	sw	$30, PT_R30(sp)
 	sw	$31, PT_R31(sp)
 	mfc0	k0, CP0_STATUS
@@ -66,20 +56,26 @@ LEAF(save_and_sleep)
 	mfc0	k0, CP0_CONFIG
 	sw	k0, 0x14(sp)
 
+	/* flush caches to make sure context is in memory */
+	la	t1, __flush_cache_all
+	lw	t0, 0(t1)
+	jalr	t0
+	 nop
+
 	/* Now set up the scratch registers so the boot rom will
 	 * return to this point upon wakeup.
+	 * sys_scratch0 : SP
+	 * sys_scratch1 : RA
 	 */
-	la	k0, 1f
-	lui	k1, 0xb190
-	ori	k1, 0x18
-	sw	sp, 0(k1)
-	ori 	k1, 0x1c
-	sw	k0, 0(k1)
+	lui	t3, 0xb190		/* sys_xxx */
+	sw	sp, 0x0018(t3)
+	la	k0, 3f			/* resume path */
+	sw	k0, 0x001c(t3)
 
-/* Put SDRAM into self refresh.  Preload instructions into cache,
- * issue a precharge, then auto refresh, then sleep commands to it.
- */
-	la	t0, sdsleep
+	/* Put SDRAM into self refresh:  Preload instructions into cache,
+	 * issue a precharge, auto/self refresh, then sleep commands to it.
+	 */
+	la	t0, 1f
 	.set	mips3
 	cache	0x14, 0(t0)
 	cache	0x14, 32(t0)
@@ -87,24 +83,57 @@ LEAF(save_and_sleep)
 	cache	0x14, 96(t0)
 	.set	mips0
 
-sdsleep:
-	lui 	k0, 0xb400
-	sw	zero, 0x001c(k0)	/* Precharge */
-	sw	zero, 0x0020(k0)	/* Auto refresh */
-	sw	zero, 0x0030(k0)	/* SDRAM sleep */
+1:	lui 	a0, 0xb400		/* mem_xxx */
+#if defined(CONFIG_SOC_AU1000) || defined(CONFIG_SOC_AU1100) ||	\
+    defined(CONFIG_SOC_AU1500)
+	sw	zero, 0x001c(a0) 	/* Precharge */
+	sync
+	sw	zero, 0x0020(a0)	/* Auto Refresh */
+	sync
+	sw	zero, 0x0030(a0)  	/* Sleep */
+	sync
+#endif
+
+#if defined(CONFIG_SOC_AU1550) || defined(CONFIG_SOC_AU1200)
+	sw	zero, 0x08c0(a0) 	/* Precharge */
 	sync
+	sw	zero, 0x08d0(a0)	/* Self Refresh */
+	sync
+
+	/* wait for sdram to enter self-refresh mode */
+	lui 	t0, 0x0100
+2:	lw 	t1, 0x0850(a0)		/* mem_sdstat */
+	and	t2, t1, t0
+	beq	t2, zero, 2b
+	 nop
 
-	lui 	k1, 0xb190
-	sw	zero, 0x0078(k1)	/* get ready  to sleep */
+	/* disable SDRAM clocks */
+	lui	t0, 0xcfff
+	ori	t0, t0, 0xffff
+	lw 	t1, 0x0840(a0)		/* mem_sdconfiga */
+	and 	t1, t0, t1		/* clear CE[1:0] */
+	sw 	t1, 0x0840(a0)		/* mem_sdconfiga */
 	sync
-	sw	zero, 0x007c(k1)	/* Put processor to sleep */
+#endif
+
+	/* put power supply and processor to sleep */
+	sw	zero, 0x0078(t3)	/* sys_slppwr */
+	sync
+	sw	zero, 0x007c(t3)	/* sys_sleep */
 	sync
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
 
 	/* This is where we return upon wakeup.
 	 * Reload all of the registers and return.
 	 */
-1:	nop
-	lw	k0, 0x20(sp)
+3:	lw	k0, 0x20(sp)
 	mtc0	k0, CP0_STATUS
 	lw	k0, 0x1c(sp)
 	mtc0	k0, CP0_CONTEXT
@@ -113,10 +142,11 @@ sdsleep:
 	lw	k0, 0x14(sp)
 	mtc0	k0, CP0_CONFIG
 
-	/* We need to catch the ealry Alchemy SOCs with
+	/* We need to catch the early Alchemy SOCs with
 	 * the write-only Config[OD] bit and set it back to one...
 	 */
 	jal	au1x00_fixup_config_od
+	 nop
 	lw	$1, PT_R1(sp)
 	lw	$2, PT_R2(sp)
 	lw	$3, PT_R3(sp)
@@ -124,14 +154,6 @@ sdsleep:
 	lw	$5, PT_R5(sp)
 	lw	$6, PT_R6(sp)
 	lw	$7, PT_R7(sp)
-	lw	$8, PT_R8(sp)
-	lw	$9, PT_R9(sp)
-	lw	$10, PT_R10(sp)
-	lw	$11, PT_R11(sp)
-	lw	$12, PT_R12(sp)
-	lw	$13, PT_R13(sp)
-	lw	$14, PT_R14(sp)
-	lw	$15, PT_R15(sp)
 	lw	$16, PT_R16(sp)
 	lw	$17, PT_R17(sp)
 	lw	$18, PT_R18(sp)
@@ -140,15 +162,11 @@ sdsleep:
 	lw	$21, PT_R21(sp)
 	lw	$22, PT_R22(sp)
 	lw	$23, PT_R23(sp)
-	lw	$24, PT_R24(sp)
-	lw	$25, PT_R25(sp)
 	lw	$26, PT_R26(sp)
 	lw	$27, PT_R27(sp)
 	lw	$28, PT_R28(sp)
-	lw	$29, PT_R29(sp)
 	lw	$30, PT_R30(sp)
 	lw	$31, PT_R31(sp)
-	addiu	sp, PT_SIZE
-
 	jr	ra
-END(save_and_sleep)
+	 addiu	sp, PT_SIZE
+END(au1xxx_save_and_sleep)
diff --git a/arch/mips/include/asm/mach-au1x00/au1000.h b/arch/mips/include/asm/mach-au1x00/au1000.h
index 2b88c29..515373c 100644
--- a/arch/mips/include/asm/mach-au1x00/au1000.h
+++ b/arch/mips/include/asm/mach-au1x00/au1000.h
@@ -137,6 +137,12 @@ extern void set_au1x00_uart_baud_base(unsigned long new_baud_base);
 extern unsigned long get_au1x00_uart_baud_base(void);
 extern unsigned long au1xxx_calc_clock(void);
 
+/* PM: arch/mips/alchemy/common/sleeper.S, power.c, irq.c */
+void au1xxx_save_and_sleep(void);
+void au_sleep(void);
+void save_au1xxx_intctl(void);
+void restore_au1xxx_intctl(void);
+
 /*
  * Every board describes its IRQ mapping with this table.
  */
-- 
1.6.0.4
