Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Feb 2015 03:24:17 +0100 (CET)
Received: from resqmta-ch2-12v.sys.comcast.net ([69.252.207.44]:51835 "EHLO
        resqmta-ch2-12v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007553AbbB0CYOHXlMw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Feb 2015 03:24:14 +0100
Received: from resomta-ch2-18v.sys.comcast.net ([69.252.207.114])
        by resqmta-ch2-12v.sys.comcast.net with comcast
        id xEQ71p0012Udklx01EQ7Ng; Fri, 27 Feb 2015 02:24:07 +0000
Received: from [192.168.1.13] ([69.250.160.75])
        by resomta-ch2-18v.sys.comcast.net with comcast
        id xEQ51p00E1duFqV01EQ54P; Fri, 27 Feb 2015 02:24:07 +0000
Message-ID: <54EFD536.2080508@gentoo.org>
Date:   Thu, 26 Feb 2015 21:23:50 -0500
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Alessandro Zummo <a.zummo@towertech.it>,
        Linux/MIPS <linux-mips@linux-mips.org>,
        rtc-linux@googlegroups.com, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] MIPS: IP32: Add platform data hooks to use DS1685 driver
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1425003847;
        bh=sh+qNXqF4P+Pz7d8fT8UocvNYW6bk1rpD035v8nx22o=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=WmLZSrEHeZbNFZrfRyt6S1ug+9wKqcF23kTzG07cjUW7G8u1KvUesn+kuIGebh8wY
         nZw4+4COo3I2e7CCrlAkRXi+//2w7C8FaV7MojESr9IrHwt2Mx+SB6Vx1k5lte37ID
         KUKLGOS1OS7wkb/bP8XYgdNAFsJww27W51XL+W3a+xCh0DfdLH/onjR0l1tFdI1393
         e2oPSFLSvBgx3fd4Q3S10pEdjSjaGzwkzveYdos0POEBdPavOHVBBjfUkvBCNSrPvv
         Yzn7ej6IqhWj1iXqIqIyZ8V8XVD85bUsX60pLC7T3JGCyExLQpPjbpkfxo45INsK0M
         pBcVp1QNvZnBQ==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46031
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

From: Joshua Kinard <kumba@gentoo.org>

This modifies the IP32 (SGI O2) platform and reset code to utilize the new
rtc-ds1685 driver.  The old mc146818rtc.h header is removed and ip32_defconfig
is updated as well.

Signed-off-by: Joshua Kinard <kumba@gentoo.org>
---
 arch/mips/configs/ip32_defconfig              |    3
 arch/mips/include/asm/mach-ip32/mc146818rtc.h |   36 ----
 arch/mips/sgi-ip32/ip32-platform.c            |   52 +++++-
 arch/mips/sgi-ip32/ip32-reset.c               |  132 ++++------------
 4 files changed, 85 insertions(+), 138 deletions(-)

Ralf,
  This is a re-spin due to the recent commit efc46d13 in ip32-reset.c ("Use
__noreturn instead of open coded attributes in declarations.").  Those
declarations are removed by this patch, since the poweroff mechanism of the
rtc-ds1685 driver is used instead on SGI O2.  rtc-ds1685 is in linux-next now,
so this one can be added at your convenience.

linux-mips-ip32-use-rtc-ds1685.patch
diff --git a/arch/mips/configs/ip32_defconfig b/arch/mips/configs/ip32_defconfig
index 70ffe9b..fe48220 100644
--- a/arch/mips/configs/ip32_defconfig
+++ b/arch/mips/configs/ip32_defconfig
@@ -105,7 +105,8 @@ CONFIG_RTC_CLASS=y
 # CONFIG_RTC_HCTOSYS is not set
 # CONFIG_RTC_INTF_SYSFS is not set
 # CONFIG_RTC_INTF_PROC is not set
-CONFIG_RTC_DRV_CMOS=y
+CONFIG_RTC_DRV_DS1685_FAMILY=y
+CONFIG_RTC_DRV_DS1685=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
diff --git a/arch/mips/include/asm/mach-ip32/mc146818rtc.h b/arch/mips/include/asm/mach-ip32/mc146818rtc.h
deleted file mode 100644
index 6b6bab4..0000000
--- a/arch/mips/include/asm/mach-ip32/mc146818rtc.h
+++ /dev/null
@@ -1,36 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 1998, 2001, 03 by Ralf Baechle
- * Copyright (C) 2000 Harald Koerfgen
- *
- * RTC routines for IP32 style attached Dallas chip.
- */
-#ifndef __ASM_MACH_IP32_MC146818RTC_H
-#define __ASM_MACH_IP32_MC146818RTC_H
-
-#include <asm/ip32/mace.h>
-
-#define RTC_PORT(x)	(0x70 + (x))
-
-static unsigned char CMOS_READ(unsigned long addr)
-{
-	return mace->isa.rtc[addr << 8];
-}
-
-static inline void CMOS_WRITE(unsigned char data, unsigned long addr)
-{
-	mace->isa.rtc[addr << 8] = data;
-}
-
-/*
- * FIXME: Do it right. For now just assume that no one lives in 20th century
- * and no O2 user in 22th century ;-)
- */
-#define mc146818_decode_year(year) ((year) + 2000)
-
-#define RTC_ALWAYS_BCD	0
-
-#endif /* __ASM_MACH_IP32_MC146818RTC_H */
diff --git a/arch/mips/sgi-ip32/ip32-platform.c b/arch/mips/sgi-ip32/ip32-platform.c
index 511e9ff..ec9eb7f 100644
--- a/arch/mips/sgi-ip32/ip32-platform.c
+++ b/arch/mips/sgi-ip32/ip32-platform.c
@@ -9,10 +9,13 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/serial_8250.h>
+#include <linux/rtc/ds1685.h>
 
 #include <asm/ip32/mace.h>
 #include <asm/ip32/ip32_ints.h>
 
+extern void ip32_prepare_poweroff(void);
+
 #define MACEISA_SERIAL1_OFFS   offsetof(struct sgi_mace, isa.serial1)
 #define MACEISA_SERIAL2_OFFS   offsetof(struct sgi_mace, isa.serial2)
 
@@ -90,22 +93,53 @@ static __init int sgio2btns_devinit(void)
 
 device_initcall(sgio2btns_devinit);
 
-static struct resource sgio2_cmos_rsrc[] = {
+#define MACE_RTC_RES_START (MACE_BASE + offsetof(struct sgi_mace, isa.rtc))
+#define MACE_RTC_RES_END (MACE_RTC_RES_START + 32767)
+
+static struct resource ip32_rtc_resources[] = {
 	{
-		.start = 0x70,
-		.end   = 0x71,
-		.flags = IORESOURCE_IO
+		.start	= MACEISA_RTC_IRQ,
+		.end	= MACEISA_RTC_IRQ,
+		.flags	= IORESOURCE_IRQ
+	}, {
+		.start	= MACE_RTC_RES_START,
+		.end	= MACE_RTC_RES_END,
+		.flags	= IORESOURCE_MEM,
 	}
 };
 
-static __init int sgio2_cmos_devinit(void)
+
+/* RTC registers on IP32 are each padded by 256 bytes (0x100). */
+static struct ds1685_rtc_platform_data
+ip32_rtc_platform_data[] = {
+	{
+		.regstep = 0x100,
+		.bcd_mode = true,
+		.no_irq = false,
+		.uie_unsupported = false,
+		.alloc_io_resources = true,
+		.plat_prepare_poweroff = ip32_prepare_poweroff,
+	},
+};
+
+struct platform_device ip32_rtc_device = {
+	.name			= "rtc-ds1685",
+	.id			= -1,
+	.dev			= {
+		.platform_data	= ip32_rtc_platform_data,
+	},
+	.num_resources		= ARRAY_SIZE(ip32_rtc_resources),
+	.resource		= ip32_rtc_resources,
+};
+
+static int __init sgio2_rtc_devinit(void)
 {
-	return IS_ERR(platform_device_register_simple("rtc_cmos", -1,
-						      sgio2_cmos_rsrc, 1));
+	return platform_device_register(&ip32_rtc_device);
+
 }
 
-device_initcall(sgio2_cmos_devinit);
+device_initcall(sgio2_rtc_devinit);
 
 MODULE_AUTHOR("Ralf Baechle <ralf@linux-mips.org>");
 MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("8250 UART probe driver for SGI IP32 aka O2");
+MODULE_DESCRIPTION("IP32 platform setup for SGI IP32 aka O2");
diff --git a/arch/mips/sgi-ip32/ip32-reset.c b/arch/mips/sgi-ip32/ip32-reset.c
index 44b3470..ef21706 100644
--- a/arch/mips/sgi-ip32/ip32-reset.c
+++ b/arch/mips/sgi-ip32/ip32-reset.c
@@ -11,10 +11,11 @@
 #include <linux/compiler.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/sched.h>
 #include <linux/notifier.h>
 #include <linux/delay.h>
-#include <linux/ds17287rtc.h>
+#include <linux/rtc/ds1685.h>
 #include <linux/interrupt.h>
 #include <linux/pm.h>
 
@@ -33,53 +34,41 @@
 #define POWERDOWN_FREQ		(HZ / 4)
 #define PANIC_FREQ		(HZ / 8)
 
-static struct timer_list power_timer, blink_timer, debounce_timer;
-static int has_panicked, shuting_down;
+extern struct platform_device ip32_rtc_device;
 
-static void ip32_machine_restart(char *command) __noreturn;
-static void ip32_machine_halt(void) __noreturn;
-static void ip32_machine_power_off(void) __noreturn;
+static struct timer_list power_timer, blink_timer;
+static int has_panicked, shutting_down;
 
-static void ip32_machine_restart(char *cmd)
+static __noreturn void ip32_poweroff(void *data)
 {
-	crime->control = CRIME_CONTROL_HARD_RESET;
-	while (1);
-}
+	void (*poweroff_func)(struct platform_device *) =
+		symbol_get(ds1685_rtc_poweroff);
+
+#ifdef CONFIG_MODULES
+	/* If the first __symbol_get failed, our module wasn't loaded. */
+	if (!poweroff_func) {
+		request_module("rtc-ds1685");
+		poweroff_func = symbol_get(ds1685_rtc_poweroff);
+	}
+#endif
 
-static inline void ip32_machine_halt(void)
-{
-	ip32_machine_power_off();
-}
+	if (!poweroff_func)
+		pr_emerg("RTC not available for power-off.  Spinning forever ...\n");
+	else {
+		(*poweroff_func)((struct platform_device *)data);
+		symbol_put(ds1685_rtc_poweroff);
+	}
 
-static void ip32_machine_power_off(void)
-{
-	unsigned char reg_a, xctrl_a, xctrl_b;
-
-	disable_irq(MACEISA_RTC_IRQ);
-	reg_a = CMOS_READ(RTC_REG_A);
-
-	/* setup for kickstart & wake-up (DS12287 Ref. Man. p. 19) */
-	reg_a &= ~DS_REGA_DV2;
-	reg_a |= DS_REGA_DV1;
-
-	CMOS_WRITE(reg_a | DS_REGA_DV0, RTC_REG_A);
-	wbflush();
-	xctrl_b = CMOS_READ(DS_B1_XCTRL4B)
-		   | DS_XCTRL4B_ABE | DS_XCTRL4B_KFE;
-	CMOS_WRITE(xctrl_b, DS_B1_XCTRL4B);
-	xctrl_a = CMOS_READ(DS_B1_XCTRL4A) & ~DS_XCTRL4A_IFS;
-	CMOS_WRITE(xctrl_a, DS_B1_XCTRL4A);
-	wbflush();
-	/* adios amigos... */
-	CMOS_WRITE(xctrl_a | DS_XCTRL4A_PAB, DS_B1_XCTRL4A);
-	CMOS_WRITE(reg_a, RTC_REG_A);
-	wbflush();
-	while (1);
+	unreachable();
 }
 
-static void power_timeout(unsigned long data)
+
+static void ip32_machine_restart(char *cmd) __noreturn;
+static void ip32_machine_restart(char *cmd)
 {
-	ip32_machine_power_off();
+	msleep(20);
+	crime->control = CRIME_CONTROL_HARD_RESET;
+	unreachable();
 }
 
 static void blink_timeout(unsigned long data)
@@ -89,44 +78,27 @@ static void blink_timeout(unsigned long data)
 	mod_timer(&blink_timer, jiffies + data);
 }
 
-static void debounce(unsigned long data)
+static void ip32_machine_halt(void)
 {
-	unsigned char reg_a, reg_c, xctrl_a;
-
-	reg_c = CMOS_READ(RTC_INTR_FLAGS);
-	reg_a = CMOS_READ(RTC_REG_A);
-	CMOS_WRITE(reg_a | DS_REGA_DV0, RTC_REG_A);
-	wbflush();
-	xctrl_a = CMOS_READ(DS_B1_XCTRL4A);
-	if ((xctrl_a & DS_XCTRL4A_IFS) || (reg_c & RTC_IRQF )) {
-		/* Interrupt still being sent. */
-		debounce_timer.expires = jiffies + 50;
-		add_timer(&debounce_timer);
-
-		/* clear interrupt source */
-		CMOS_WRITE(xctrl_a & ~DS_XCTRL4A_IFS, DS_B1_XCTRL4A);
-		CMOS_WRITE(reg_a & ~DS_REGA_DV0, RTC_REG_A);
-		return;
-	}
-	CMOS_WRITE(reg_a & ~DS_REGA_DV0, RTC_REG_A);
-
-	if (has_panicked)
-		ip32_machine_restart(NULL);
+	ip32_poweroff(&ip32_rtc_device);
+}
 
-	enable_irq(MACEISA_RTC_IRQ);
+static void power_timeout(unsigned long data)
+{
+	ip32_poweroff(&ip32_rtc_device);
 }
 
-static inline void ip32_power_button(void)
+void ip32_prepare_poweroff(void)
 {
 	if (has_panicked)
 		return;
 
-	if (shuting_down || kill_cad_pid(SIGINT, 1)) {
+	if (shutting_down || kill_cad_pid(SIGINT, 1)) {
 		/* No init process or button pressed twice.  */
-		ip32_machine_power_off();
+		ip32_poweroff(&ip32_rtc_device);
 	}
 
-	shuting_down = 1;
+	shutting_down = 1;
 	blink_timer.data = POWERDOWN_FREQ;
 	blink_timeout(POWERDOWN_FREQ);
 
@@ -136,27 +108,6 @@ static inline void ip32_power_button(void)
 	add_timer(&power_timer);
 }
 
-static irqreturn_t ip32_rtc_int(int irq, void *dev_id)
-{
-	unsigned char reg_c;
-
-	reg_c = CMOS_READ(RTC_INTR_FLAGS);
-	if (!(reg_c & RTC_IRQF)) {
-		printk(KERN_WARNING
-			"%s: RTC IRQ without RTC_IRQF\n", __func__);
-	}
-	/* Wait until interrupt goes away */
-	disable_irq_nosync(MACEISA_RTC_IRQ);
-	init_timer(&debounce_timer);
-	debounce_timer.function = debounce;
-	debounce_timer.expires = jiffies + 50;
-	add_timer(&debounce_timer);
-
-	printk(KERN_DEBUG "Power button pressed\n");
-	ip32_power_button();
-	return IRQ_HANDLED;
-}
-
 static int panic_event(struct notifier_block *this, unsigned long event,
 		       void *ptr)
 {
@@ -190,15 +141,12 @@ static __init int ip32_reboot_setup(void)
 
 	_machine_restart = ip32_machine_restart;
 	_machine_halt = ip32_machine_halt;
-	pm_power_off = ip32_machine_power_off;
+	pm_power_off = ip32_machine_halt;
 
 	init_timer(&blink_timer);
 	blink_timer.function = blink_timeout;
 	atomic_notifier_chain_register(&panic_notifier_list, &panic_block);
 
-	if (request_irq(MACEISA_RTC_IRQ, ip32_rtc_int, 0, "rtc", NULL))
-		panic("Can't allocate MACEISA RTC IRQ");
-
 	return 0;
 }
 
