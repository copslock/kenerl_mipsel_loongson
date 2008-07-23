Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jul 2008 18:57:55 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:7627 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S28573978AbYGWR5x (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 23 Jul 2008 18:57:53 +0100
Received: (qmail 6278 invoked by uid 1000); 23 Jul 2008 19:57:52 +0200
Date:	Wed, 23 Jul 2008 19:57:52 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	linux-mips@linux-mips.org
Subject: [PATCH 8/8] Alchemy: Fix PM code for Au1200/Au1550.
Message-ID: <20080723175752.GI5986@roarinelk.homelinux.net>
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
X-archive-position: 19940
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Alchemy PM code doesn't compile on Au1200.
Copy the Au1200/Au1550 sleep code over from 2.4.

Tested on Au1200.

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 arch/mips/au1000/common/platform.c |    5 +-
 arch/mips/au1000/common/power.c    |  111 +++++++++++++++++++++------------
 arch/mips/au1000/common/sleeper.S  |  121 ++++++++++++++++++++++--------------
 3 files changed, 150 insertions(+), 87 deletions(-)

diff --git a/arch/mips/au1000/common/platform.c b/arch/mips/au1000/common/platform.c
index 0874593..7c00f5a 100644
--- a/arch/mips/au1000/common/platform.c
+++ b/arch/mips/au1000/common/platform.c
@@ -420,6 +420,7 @@ static int pm_do_sleep(ctl_table *ctl, int write, struct file *file,
 	return 0;
 }
 
+#if !defined(CONFIG_SOC_AU1200) && !defined(CONFIG_SOC_AU1550)
 /*
  * This is the number of bits of precision for the loops_per_jiffy.
  * Each bit takes on average 1.5/HZ seconds.  This (like the original)
@@ -567,7 +568,7 @@ static int pm_do_freq(ctl_table *ctl, int write, struct file *file,
 
 	return retval;
 }
-
+#endif
 
 static struct ctl_table pm_table[] = {
 	{
@@ -578,6 +579,7 @@ static struct ctl_table pm_table[] = {
 		.mode		= 0600,
 		.proc_handler	= &pm_do_sleep
 	},
+#if !defined(CONFIG_SOC_AU1200) && !defined(CONFIG_SOC_AU1550)
 	{
 		.ctl_name	= CTL_UNNUMBERED,
 		.procname	= "freq",
@@ -586,6 +588,7 @@ static struct ctl_table pm_table[] = {
 		.mode		= 0600,
 		.proc_handler	= &pm_do_freq
 	},
+#endif
 	{}
 };
 
diff --git a/arch/mips/au1000/common/power.c b/arch/mips/au1000/common/power.c
index 4b0f6a1..ba4c946 100644
--- a/arch/mips/au1000/common/power.c
+++ b/arch/mips/au1000/common/power.c
@@ -26,13 +26,13 @@
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#include <linux/init.h>
-#include <asm/cacheflush.h>
-#include <asm/mach-au1x00/au1000.h>
-
 #ifdef CONFIG_PM
 
+#include <asm/mach-au1x00/au1000.h>
+
 extern void save_and_sleep(void);
+extern void save_au1xxx_intctl(void);
+extern void restore_au1xxx_intctl(void);
 
 /*
  * We need to save/restore a bunch of core registers that are
@@ -44,23 +44,18 @@ extern void save_and_sleep(void);
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
 
 static void save_core_regs(void)
 {
-	extern void save_au1xxx_intctl(void);
-	extern void pm_eth0_shutdown(void);
-
 	/*
 	 * Do the serial ports.....these really should be a pm_*
 	 * registered function by the driver......but of course the
@@ -72,31 +67,45 @@ static void save_core_regs(void)
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
 
-	sleep_usbdev_enable = au_readl(USBD_ENABLE);
-	au_writel(0, USBD_ENABLE); au_sync();
+#else	/* AU1200 */
+
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
-
-	/*
-	 * We don't really need to do this one, but unless we
-	 * write it again it won't have a valid value if we
-	 * happen to read it.
-	 */
-	sleep_cpu_pll_cntrl = au_readl(SYS_CPUPLL);
+	sleep_sys_clocks[0] = au_readl(SYS_FREQCTRL0);
+	sleep_sys_clocks[1] = au_readl(SYS_FREQCTRL1);
+	sleep_sys_clocks[2] = au_readl(SYS_CLKSRC);
+	sleep_sys_clocks[3] = au_readl(SYS_CPUPLL);
+	sleep_sys_clocks[4] = au_readl(SYS_AUXPLL);
 
-	sleep_pin_function = au_readl(SYS_PINFUNC);
+	/* pin mux config */
+	sleep_sys_pinfunc = au_readl(SYS_PINFUNC);
 
 	/* Save the static memory controller configuration. */
 	sleep_static_memctlr[0][0] = au_readl(MEM_STCFG0);
@@ -115,12 +124,37 @@ static void save_core_regs(void)
 
 static void restore_core_regs(void)
 {
-	extern void restore_au1xxx_intctl(void);
-	extern void wakeup_counter0_adjust(void);
-
-	au_writel(sleep_aux_pll_cntrl, SYS_AUXPLL); au_sync();
-	au_writel(sleep_cpu_pll_cntrl, SYS_CPUPLL); au_sync();
-	au_writel(sleep_pin_function, SYS_PINFUNC); au_sync();
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
+
+	/* restore OTG caps and port mux. */
+	au_writel(sleep_usb[0], 0xb4020020 + 0);	/* OTG_CAP */
+	au_sync();
+	au_writel(sleep_usb[1], 0xb4020020 + 4);	/* OTG_MUX */
+	au_sync();
+#endif
 
 	/* Restore the static memory controller configuration. */
 	au_writel(sleep_static_memctlr[0][0], MEM_STCFG0);
@@ -156,7 +190,6 @@ static void restore_core_regs(void)
 void au_sleep(void)
 {
 	save_core_regs();
-	flush_cache_all();
 	save_and_sleep();
 	restore_core_regs();
 }
diff --git a/arch/mips/au1000/common/sleeper.S b/arch/mips/au1000/common/sleeper.S
index 4b3cf02..76506aa 100644
--- a/arch/mips/au1000/common/sleeper.S
+++ b/arch/mips/au1000/common/sleeper.S
@@ -15,9 +15,11 @@
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
@@ -33,14 +35,6 @@ LEAF(save_and_sleep)
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
@@ -49,12 +43,9 @@ LEAF(save_and_sleep)
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
@@ -66,44 +57,89 @@ LEAF(save_and_sleep)
 	mfc0	k0, CP0_CONFIG
 	sw	k0, 0x14(sp)
 
+	/* flush caches to make sure context is in memory */
+	la	t1, __flush_cache_all
+	lw	t0, 0(t1)
+	jal	t0
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
-
-/* Put SDRAM into self refresh.  Preload instructions into cache,
- * issue a precharge, then auto refresh, then sleep commands to it.
- */
- 	la	t0, sdsleep
+	li	t3, 0xb1900000		/* sys_xxx */
+	sw	sp, 0x0018(t3)
+	la	k0, resume_from_sleep
+	sw	k0, 0x001c(t3)
+
+	/* Put SDRAM into self refresh.  Preload instructions into cache,
+	 * issue a precharge, then auto refresh, then sleep commands to it.
+	 */
+	la	t0, sdsleep
 	.set	mips3
- 	cache	0x14, 0(t0)
- 	cache	0x14, 32(t0)
- 	cache	0x14, 64(t0)
- 	cache	0x14, 96(t0)
+	cache	0x14, 0(t0)
+	cache	0x14, 32(t0)
+	cache	0x14, 64(t0)
+	cache	0x14, 96(t0)
 	.set	mips0
 
 sdsleep:
-	lui 	k0, 0xb400
-	sw	zero, 0x001c(k0)	/* Precharge */
-	sw	zero, 0x0020(k0)	/* Auto refresh */
-	sw	zero, 0x0030(k0)	/* SDRAM sleep */
+	li 	a0, 0xb4000000		/* mem_xxx */
+#if defined(CONFIG_SOC_AU1000) || defined(CONFIG_SOC_AU1100) ||	\
+    defined(CONFIG_SOC_AU1500)
+	sw	zero, 0x001c(a0) 	/* Precharge */
+	sync
+	sw	zero, 0x0020(a0)	/* Auto Refresh */
+	sync
+	sw	zero, 0x0030(a0)  	/* Sleep */
 	sync
+#endif
 
-	lui 	k1, 0xb190
-	sw	zero, 0x0078(k1)	/* get ready  to sleep */
+#if defined(CONFIG_SOC_AU1550) || defined(CONFIG_SOC_AU1200)
+	sw	zero, 0x08c0(a0) 	/* Precharge */
 	sync
-	sw	zero, 0x007c(k1)	/* Put processor to sleep */
+	sw	zero, 0x08d0(a0)	/* Self Refresh */
 	sync
 
+	/* wait for sdram to enter self-refresh mode */
+	li 	t0, 0x01000000
+sref_wait_loop:
+	lw 	t1, 0x0850(a0)		/* mem_sdstat */
+	and	t2, t1, t0
+	beq	t2, zero, sref_wait_loop
+	 nop
+
+	/* Disable SDRAM clocks */
+	li	t0, ~0x30000000
+	lw 	t1, 0x0840(a0)		/* mem_sdconfiga */
+	and 	t1, t0, t1		/* clear CE[1:0] */
+	sw 	t1, 0x0840(a0)		/* mem_sdconfiga */
+	sync
+#endif
+
+	/* put power supply and processor to sleep */
+	sw	zero, 0x0078(t3)	/* sys_slppwr */
+	sync
+	sw	zero, 0x007c(t3)	/* sys_sleep */
+	sync
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+
 	/* This is where we return upon wakeup.
 	 * Reload all of the registers and return.
 	 */
-1:	nop
+resume_from_sleep:
+	nop
+	.set nomacro
+	.set noat
+
 	lw	k0, 0x20(sp)
 	mtc0	k0, CP0_STATUS
 	lw	k0, 0x1c(sp)
@@ -117,6 +153,7 @@ sdsleep:
 	 * the write-only Config[OD] bit and set it back to one...
 	 */
 	jal	au1x00_fixup_config_od
+	 nop
 	lw	$1, PT_R1(sp)
 	lw	$2, PT_R2(sp)
 	lw	$3, PT_R3(sp)
@@ -124,14 +161,6 @@ sdsleep:
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
@@ -140,15 +169,13 @@ sdsleep:
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
 	addiu	sp, PT_SIZE
 
 	jr	ra
+	 nop
 END(save_and_sleep)
-- 
1.5.6.3
