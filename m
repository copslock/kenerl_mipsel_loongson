Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Aug 2011 13:14:30 +0200 (CEST)
Received: from alius.ayous.org ([78.46.213.165]:57661 "EHLO alius.ayous.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491091Ab1H1LOY (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 28 Aug 2011 13:14:24 +0200
Received: from aba by alius.turmzimmer.net with local (Exim 4.72)
        (envelope-from <aba@not.so.argh.org>)
        id 1QxdJZ-0008LH-Ez; Sun, 28 Aug 2011 11:14:09 +0000
Message-Id: <E1QxdJZ-0008LH-Ez@alius.turmzimmer.net>
From:   Andreas Barth <aba@not.so.argh.org>
Date:   Sun, 28 Aug 2011 09:37:45 +0000
Subject: [PATCH] mips/loongson: unify reset.c and move ec_kb3310b.c
To:     linux-mips@linux-mips.org, debian-mips@lists.debian.org
X-archive-position: 31005
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aba@not.so.argh.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 20785

This patch merges the different reset.c codes into common/reset.c.
For that, also ec_kb3310b is moved into common. To be able to
build ec_kb3310b only when needed a new config flag LOONGSON_KB3310B
is added and automatically enabled with the lemote-2f maschines.

Signed-off-by: Andreas Barth <aba@not.so.argh.org>
---
 arch/mips/loongson/Kconfig                |    5 +
 arch/mips/loongson/common/Makefile        |    5 +
 arch/mips/loongson/common/ec_kb3310b.c    |  128 ++++++++++++++++++++
 arch/mips/loongson/common/ec_kb3310b.h    |  188 +++++++++++++++++++++++++++++
 arch/mips/loongson/common/reset.c         |  165 +++++++++++++++++++++++++
 arch/mips/loongson/fuloong-2e/Makefile    |    2 +-
 arch/mips/loongson/fuloong-2e/reset.c     |   23 ----
 arch/mips/loongson/lemote-2f/Makefile     |    2 +-
 arch/mips/loongson/lemote-2f/ec_kb3310b.c |  128 --------------------
 arch/mips/loongson/lemote-2f/ec_kb3310b.h |  188 -----------------------------
 arch/mips/loongson/lemote-2f/pm.c         |    2 +-
 arch/mips/loongson/lemote-2f/reset.c      |  159 ------------------------
 12 files changed, 494 insertions(+), 501 deletions(-)
 create mode 100644 arch/mips/loongson/common/ec_kb3310b.c
 create mode 100644 arch/mips/loongson/common/ec_kb3310b.h
 delete mode 100644 arch/mips/loongson/fuloong-2e/reset.c
 delete mode 100644 arch/mips/loongson/lemote-2f/ec_kb3310b.c
 delete mode 100644 arch/mips/loongson/lemote-2f/ec_kb3310b.h
 delete mode 100644 arch/mips/loongson/lemote-2f/reset.c

diff --git a/arch/mips/loongson/Kconfig b/arch/mips/loongson/Kconfig
index aca93ee..28ce0a6 100644
--- a/arch/mips/loongson/Kconfig
+++ b/arch/mips/loongson/Kconfig
@@ -52,6 +52,7 @@ config LEMOTE_MACH2F
 	select SYS_SUPPORTS_HIGHMEM
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select LOONGSON_MC146818
+	select LOONGSON_KB3310B
 	help
 	  Lemote Loongson 2F family machines utilize the 2F revision of
 	  Loongson processor and the AMD CS5536 south bridge.
@@ -89,4 +90,8 @@ config LOONGSON_MC146818
 	bool
 	default n
 
+config LOONGSON_KB3310B
+	bool
+	default n
+
 endif # MACH_LOONGSON
diff --git a/arch/mips/loongson/common/Makefile b/arch/mips/loongson/common/Makefile
index e526488..e33efd9 100644
--- a/arch/mips/loongson/common/Makefile
+++ b/arch/mips/loongson/common/Makefile
@@ -25,3 +25,8 @@ obj-$(CONFIG_CS5536) += cs5536/
 #
 
 obj-$(CONFIG_LOONGSON_SUSPEND) += pm.o
+
+#
+# Support for kb3310b
+#
+obj-$(CONFIG_LOONGSON_KB3310B) += ec_kb3310b.o
diff --git a/arch/mips/loongson/common/ec_kb3310b.c b/arch/mips/loongson/common/ec_kb3310b.c
new file mode 100644
index 0000000..2b666d3
--- /dev/null
+++ b/arch/mips/loongson/common/ec_kb3310b.c
@@ -0,0 +1,128 @@
+/*
+ * Basic KB3310B Embedded Controller support for the YeeLoong 2F netbook
+ *
+ *  Copyright (C) 2008 Lemote Inc.
+ *  Author: liujl <liujl@lemote.com>, 2008-04-20
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/spinlock.h>
+#include <linux/delay.h>
+
+#include "ec_kb3310b.h"
+
+static DEFINE_SPINLOCK(index_access_lock);
+static DEFINE_SPINLOCK(port_access_lock);
+
+unsigned char ec_read(unsigned short addr)
+{
+	unsigned char value;
+	unsigned long flags;
+
+	spin_lock_irqsave(&index_access_lock, flags);
+	outb((addr & 0xff00) >> 8, EC_IO_PORT_HIGH);
+	outb((addr & 0x00ff), EC_IO_PORT_LOW);
+	value = inb(EC_IO_PORT_DATA);
+	spin_unlock_irqrestore(&index_access_lock, flags);
+
+	return value;
+}
+EXPORT_SYMBOL_GPL(ec_read);
+
+void ec_write(unsigned short addr, unsigned char val)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&index_access_lock, flags);
+	outb((addr & 0xff00) >> 8, EC_IO_PORT_HIGH);
+	outb((addr & 0x00ff), EC_IO_PORT_LOW);
+	outb(val, EC_IO_PORT_DATA);
+	/*  flush the write action */
+	inb(EC_IO_PORT_DATA);
+	spin_unlock_irqrestore(&index_access_lock, flags);
+}
+EXPORT_SYMBOL_GPL(ec_write);
+
+/*
+ * This function is used for EC command writes and corresponding status queries.
+ */
+int ec_query_seq(unsigned char cmd)
+{
+	int timeout;
+	unsigned char status;
+	unsigned long flags;
+	int ret = 0;
+
+	spin_lock_irqsave(&port_access_lock, flags);
+
+	/* make chip goto reset mode */
+	udelay(EC_REG_DELAY);
+	outb(cmd, EC_CMD_PORT);
+	udelay(EC_REG_DELAY);
+
+	/* check if the command is received by ec */
+	timeout = EC_CMD_TIMEOUT;
+	status = inb(EC_STS_PORT);
+	while (timeout-- && (status & (1 << 1))) {
+		status = inb(EC_STS_PORT);
+		udelay(EC_REG_DELAY);
+	}
+
+	spin_unlock_irqrestore(&port_access_lock, flags);
+
+	if (timeout <= 0) {
+		printk(KERN_ERR "%s: deadable error : timeout...\n", __func__);
+		ret = -EINVAL;
+	} else
+		printk(KERN_INFO
+			   "(%x/%d)ec issued command %d status : 0x%x\n",
+			   timeout, EC_CMD_TIMEOUT - timeout, cmd, status);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(ec_query_seq);
+
+/*
+ * Send query command to EC to get the proper event number
+ */
+int ec_query_event_num(void)
+{
+	return ec_query_seq(CMD_GET_EVENT_NUM);
+}
+EXPORT_SYMBOL(ec_query_event_num);
+
+/*
+ * Get event number from EC
+ *
+ * NOTE: This routine must follow the query_event_num function in the
+ * interrupt.
+ */
+int ec_get_event_num(void)
+{
+	int timeout = 100;
+	unsigned char value;
+	unsigned char status;
+
+	udelay(EC_REG_DELAY);
+	status = inb(EC_STS_PORT);
+	udelay(EC_REG_DELAY);
+	while (timeout-- && !(status & (1 << 0))) {
+		status = inb(EC_STS_PORT);
+		udelay(EC_REG_DELAY);
+	}
+	if (timeout <= 0) {
+		pr_info("%s: get event number timeout.\n", __func__);
+
+		return -EINVAL;
+	}
+	value = inb(EC_DAT_PORT);
+	udelay(EC_REG_DELAY);
+
+	return value;
+}
+EXPORT_SYMBOL(ec_get_event_num);
diff --git a/arch/mips/loongson/common/ec_kb3310b.h b/arch/mips/loongson/common/ec_kb3310b.h
new file mode 100644
index 0000000..1595a21
--- /dev/null
+++ b/arch/mips/loongson/common/ec_kb3310b.h
@@ -0,0 +1,188 @@
+/*
+ * KB3310B Embedded Controller
+ *
+ *  Copyright (C) 2008 Lemote Inc.
+ *  Author: liujl <liujl@lemote.com>, 2008-03-14
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef _EC_KB3310B_H
+#define _EC_KB3310B_H
+
+extern unsigned char ec_read(unsigned short addr);
+extern void ec_write(unsigned short addr, unsigned char val);
+extern int ec_query_seq(unsigned char cmd);
+extern int ec_query_event_num(void);
+extern int ec_get_event_num(void);
+
+typedef int (*sci_handler) (int status);
+extern sci_handler yeeloong_report_lid_status;
+
+#define SCI_IRQ_NUM 0x0A
+
+/*
+ * The following registers are determined by the EC index configuration.
+ * 1, fill the PORT_HIGH as EC register high part.
+ * 2, fill the PORT_LOW as EC register low part.
+ * 3, fill the PORT_DATA as EC register write data or get the data from it.
+ */
+#define	EC_IO_PORT_HIGH	0x0381
+#define	EC_IO_PORT_LOW	0x0382
+#define	EC_IO_PORT_DATA	0x0383
+
+/*
+ * EC delay time is 500us for register and status access
+ */
+#define	EC_REG_DELAY	500	/* unit : us */
+#define	EC_CMD_TIMEOUT	0x1000
+
+/*
+ * EC access port for SCI communication
+ */
+#define	EC_CMD_PORT		0x66
+#define	EC_STS_PORT		0x66
+#define	EC_DAT_PORT		0x62
+#define	CMD_INIT_IDLE_MODE	0xdd
+#define	CMD_EXIT_IDLE_MODE	0xdf
+#define	CMD_INIT_RESET_MODE	0xd8
+#define	CMD_REBOOT_SYSTEM	0x8c
+#define	CMD_GET_EVENT_NUM	0x84
+#define	CMD_PROGRAM_PIECE	0xda
+
+/* temperature & fan registers */
+#define	REG_TEMPERATURE_VALUE	0xF458
+#define	REG_FAN_AUTO_MAN_SWITCH 0xF459
+#define	BIT_FAN_AUTO		0
+#define	BIT_FAN_MANUAL		1
+#define	REG_FAN_CONTROL		0xF4D2
+#define	BIT_FAN_CONTROL_ON	(1 << 0)
+#define	BIT_FAN_CONTROL_OFF	(0 << 0)
+#define	REG_FAN_STATUS		0xF4DA
+#define	BIT_FAN_STATUS_ON	(1 << 0)
+#define	BIT_FAN_STATUS_OFF	(0 << 0)
+#define	REG_FAN_SPEED_HIGH	0xFE22
+#define	REG_FAN_SPEED_LOW	0xFE23
+#define	REG_FAN_SPEED_LEVEL	0xF4CC
+/* fan speed divider */
+#define	FAN_SPEED_DIVIDER	480000	/* (60*1000*1000/62.5/2)*/
+
+/* battery registers */
+#define	REG_BAT_DESIGN_CAP_HIGH		0xF77D
+#define	REG_BAT_DESIGN_CAP_LOW		0xF77E
+#define	REG_BAT_FULLCHG_CAP_HIGH	0xF780
+#define	REG_BAT_FULLCHG_CAP_LOW		0xF781
+#define	REG_BAT_DESIGN_VOL_HIGH		0xF782
+#define	REG_BAT_DESIGN_VOL_LOW		0xF783
+#define	REG_BAT_CURRENT_HIGH		0xF784
+#define	REG_BAT_CURRENT_LOW		0xF785
+#define	REG_BAT_VOLTAGE_HIGH		0xF786
+#define	REG_BAT_VOLTAGE_LOW		0xF787
+#define	REG_BAT_TEMPERATURE_HIGH	0xF788
+#define	REG_BAT_TEMPERATURE_LOW		0xF789
+#define	REG_BAT_RELATIVE_CAP_HIGH	0xF492
+#define	REG_BAT_RELATIVE_CAP_LOW	0xF493
+#define	REG_BAT_VENDOR			0xF4C4
+#define	FLAG_BAT_VENDOR_SANYO		0x01
+#define	FLAG_BAT_VENDOR_SIMPLO		0x02
+#define	REG_BAT_CELL_COUNT		0xF4C6
+#define	FLAG_BAT_CELL_3S1P		0x03
+#define	FLAG_BAT_CELL_3S2P		0x06
+#define	REG_BAT_CHARGE			0xF4A2
+#define	FLAG_BAT_CHARGE_DISCHARGE	0x01
+#define	FLAG_BAT_CHARGE_CHARGE		0x02
+#define	FLAG_BAT_CHARGE_ACPOWER		0x00
+#define	REG_BAT_STATUS			0xF4B0
+#define	BIT_BAT_STATUS_LOW		(1 << 5)
+#define	BIT_BAT_STATUS_DESTROY		(1 << 2)
+#define	BIT_BAT_STATUS_FULL		(1 << 1)
+#define	BIT_BAT_STATUS_IN		(1 << 0)
+#define	REG_BAT_CHARGE_STATUS		0xF4B1
+#define	BIT_BAT_CHARGE_STATUS_OVERTEMP	(1 << 2)
+#define	BIT_BAT_CHARGE_STATUS_PRECHG	(1 << 1)
+#define	REG_BAT_STATE			0xF482
+#define	BIT_BAT_STATE_CHARGING		(1 << 1)
+#define	BIT_BAT_STATE_DISCHARGING	(1 << 0)
+#define	REG_BAT_POWER			0xF440
+#define	BIT_BAT_POWER_S3		(1 << 2)
+#define	BIT_BAT_POWER_ON		(1 << 1)
+#define	BIT_BAT_POWER_ACIN		(1 << 0)
+
+/* other registers */
+/* Audio: rd/wr */
+#define	REG_AUDIO_VOLUME	0xF46C
+#define	REG_AUDIO_MUTE		0xF4E7
+#define	REG_AUDIO_BEEP		0xF4D0
+/* USB port power or not: rd/wr */
+#define	REG_USB0_FLAG		0xF461
+#define	REG_USB1_FLAG		0xF462
+#define	REG_USB2_FLAG		0xF463
+#define	BIT_USB_FLAG_ON		1
+#define	BIT_USB_FLAG_OFF	0
+/* LID */
+#define	REG_LID_DETECT		0xF4BD
+#define	BIT_LID_DETECT_ON	1
+#define	BIT_LID_DETECT_OFF	0
+/* CRT */
+#define	REG_CRT_DETECT		0xF4AD
+#define	BIT_CRT_DETECT_PLUG	1
+#define	BIT_CRT_DETECT_UNPLUG	0
+/* LCD backlight brightness adjust: 9 levels */
+#define	REG_DISPLAY_BRIGHTNESS	0xF4F5
+/* Black screen Status */
+#define	BIT_DISPLAY_LCD_ON	1
+#define	BIT_DISPLAY_LCD_OFF	0
+/* LCD backlight control: off/restore */
+#define	REG_BACKLIGHT_CTRL	0xF7BD
+#define	BIT_BACKLIGHT_ON	1
+#define	BIT_BACKLIGHT_OFF	0
+/* Reset the machine auto-clear: rd/wr */
+#define	REG_RESET		0xF4EC
+#define	BIT_RESET_ON		1
+/* Light the led: rd/wr */
+#define	REG_LED			0xF4C8
+#define	BIT_LED_RED_POWER	(1 << 0)
+#define	BIT_LED_ORANGE_POWER	(1 << 1)
+#define	BIT_LED_GREEN_CHARGE	(1 << 2)
+#define	BIT_LED_RED_CHARGE	(1 << 3)
+#define	BIT_LED_NUMLOCK		(1 << 4)
+/* Test led mode, all led on/off */
+#define	REG_LED_TEST		0xF4C2
+#define	BIT_LED_TEST_IN		1
+#define	BIT_LED_TEST_OUT	0
+/* Camera on/off */
+#define	REG_CAMERA_STATUS	0xF46A
+#define	BIT_CAMERA_STATUS_ON	1
+#define	BIT_CAMERA_STATUS_OFF	0
+#define	REG_CAMERA_CONTROL	0xF7B7
+#define	BIT_CAMERA_CONTROL_OFF	0
+#define	BIT_CAMERA_CONTROL_ON	1
+/* Wlan Status */
+#define	REG_WLAN		0xF4FA
+#define	BIT_WLAN_ON		1
+#define	BIT_WLAN_OFF		0
+#define	REG_DISPLAY_LCD		0xF79F
+
+/* SCI Event Number from EC */
+enum {
+	EVENT_LID = 0x23,	/*  LID open/close */
+	EVENT_DISPLAY_TOGGLE,	/*  Fn+F3 for display switch */
+	EVENT_SLEEP,		/*  Fn+F1 for entering sleep mode */
+	EVENT_OVERTEMP,		/*  Over-temperature happened */
+	EVENT_CRT_DETECT,	/*  CRT is connected */
+	EVENT_CAMERA,		/*  Camera on/off */
+	EVENT_USB_OC2,		/*  USB2 Over Current occurred */
+	EVENT_USB_OC0,		/*  USB0 Over Current occurred */
+	EVENT_BLACK_SCREEN,	/*  Turn on/off backlight */
+	EVENT_AUDIO_MUTE,	/*  Mute on/off */
+	EVENT_DISPLAY_BRIGHTNESS,/* LCD backlight brightness adjust */
+	EVENT_AC_BAT,		/*  AC & Battery relative issue */
+	EVENT_AUDIO_VOLUME,	/*  Volume adjust */
+	EVENT_WLAN,		/*  Wlan on/off */
+	EVENT_END
+};
+
+#endif /* !_EC_KB3310B_H */
diff --git a/arch/mips/loongson/common/reset.c b/arch/mips/loongson/common/reset.c
index 9e10d62..e0aafa9 100644
--- a/arch/mips/loongson/common/reset.c
+++ b/arch/mips/loongson/common/reset.c
@@ -11,11 +11,21 @@
  */
 #include <linux/init.h>
 #include <linux/pm.h>
+#include <linux/io.h>
+#include <linux/delay.h>
+#include <linux/types.h>
 
 #include <asm/reboot.h>
 
 #include <loongson.h>
 
+#include <asm/bootinfo.h>
+
+#include <cs5536/cs5536.h>
+#ifdef CONFIG_LOONGSON_KB3310B
+#include "ec_kb3310b.h"
+#endif
+
 static inline void loongson_reboot(void)
 {
 #ifndef CONFIG_CPU_JUMP_WORKAROUNDS
@@ -68,3 +78,158 @@ static int __init mips_reboot_setup(void)
 }
 
 arch_initcall(mips_reboot_setup);
+
+
+static void reset_cpu(void)
+{
+	/*
+	 * reset cpu to full speed, this is needed when enabling cpu frequency
+	 * scalling
+	 */
+	switch (mips_machtype) {
+	case MACH_LEMOTE_FL2E:
+		break;
+	default:
+#ifdef CONFIG_CPU_SUPPORTS_CPUFREQ
+		LOONGSON_CHIPCFG0 |= 0x7;
+#endif
+		break;
+	}
+}
+
+/* reset support for fuloong2f */
+
+static void fl2f_reboot(void)
+{
+#ifdef CONFIG_CS5536
+	reset_cpu();
+
+	/* send a reset signal to south bridge.
+	 *
+	 * NOTE: if enable "Power Management" in kernel, rtl8169 will not reset
+	 * normally with this reset operation and it will not work in PMON, but
+	 * you can type halt command and then reboot, seems the hardware reset
+	 * logic not work normally.
+	 */
+	{
+		u32 hi, lo;
+		_rdmsr(DIVIL_MSR_REG(DIVIL_SOFT_RESET), &hi, &lo);
+		lo |= 0x00000001;
+		_wrmsr(DIVIL_MSR_REG(DIVIL_SOFT_RESET), hi, lo);
+	}
+#endif
+}
+
+static void fl2f_shutdown(void)
+{
+#ifdef CONFIG_CS5536
+	u32 hi, lo, val;
+	int gpio_base;
+
+	/* get gpio base */
+	_rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_GPIO), &hi, &lo);
+	gpio_base = lo & 0xff00;
+
+	/* make cs5536 gpio13 output enable */
+	val = inl(gpio_base + GPIOL_OUT_EN);
+	val &= ~(1 << (16 + 13));
+	val |= (1 << 13);
+	outl(val, gpio_base + GPIOL_OUT_EN);
+	mmiowb();
+	/* make cs5536 gpio13 output low level voltage. */
+	val = inl(gpio_base + GPIOL_OUT_VAL) & ~(1 << (13));
+	val |= (1 << (16 + 13));
+	outl(val, gpio_base + GPIOL_OUT_VAL);
+	mmiowb();
+#endif
+}
+
+/* reset support for yeeloong2f and mengloong2f notebook */
+
+void ml2f_reboot(void)
+{
+	reset_cpu();
+
+	/* sending an reset signal to EC(embedded controller) */
+#ifdef CONFIG_LOONGSON_KB3310B
+	ec_write(REG_RESET, BIT_RESET_ON);
+#endif
+}
+
+#define yl2f89_reboot ml2f_reboot
+
+/* menglong(7inches) laptop has different shutdown logic from 8.9inches */
+#define EC_SHUTDOWN_IO_PORT_HIGH 0xff2d
+#define EC_SHUTDOWN_IO_PORT_LOW	 0xff2e
+#define EC_SHUTDOWN_IO_PORT_DATA 0xff2f
+#define REG_SHUTDOWN_HIGH        0xFC
+#define REG_SHUTDOWN_LOW         0x29
+#define BIT_SHUTDOWN_ON          (1 << 1)
+
+static void ml2f_shutdown(void)
+{
+	u8 val;
+	u64 i;
+
+	outb(REG_SHUTDOWN_HIGH, EC_SHUTDOWN_IO_PORT_HIGH);
+	outb(REG_SHUTDOWN_LOW, EC_SHUTDOWN_IO_PORT_LOW);
+	mmiowb();
+	val = inb(EC_SHUTDOWN_IO_PORT_DATA);
+	outb(val & (~BIT_SHUTDOWN_ON), EC_SHUTDOWN_IO_PORT_DATA);
+	mmiowb();
+	/* need enough wait here... how many microseconds needs? */
+	for (i = 0; i < 0x10000; i++)
+		delay();
+	outb(val | BIT_SHUTDOWN_ON, EC_SHUTDOWN_IO_PORT_DATA);
+	mmiowb();
+}
+
+static void yl2f89_shutdown(void)
+{
+	/* cpu-gpio0 output low */
+	LOONGSON_GPIODATA &= ~0x00000001;
+	/* cpu-gpio0 as output */
+	LOONGSON_GPIOIE &= ~0x00000001;
+}
+
+void mach_prepare_reboot(void)
+{
+	switch (mips_machtype) {
+	case MACH_LEMOTE_FL2F:
+	case MACH_LEMOTE_NAS:
+	case MACH_LEMOTE_LL2F:
+		fl2f_reboot();
+		break;
+	case MACH_LEMOTE_ML2F7:
+		ml2f_reboot();
+		break;
+	case MACH_LEMOTE_YL2F89:
+		yl2f89_reboot();
+		break;
+	case MACH_LEMOTE_FL2E:
+		LOONGSON_GENCFG &= ~(1 << 2);
+		LOONGSON_GENCFG |= (1 << 2);
+		break;
+	default:
+		break;
+	}
+}
+
+void mach_prepare_shutdown(void)
+{
+	switch (mips_machtype) {
+	case MACH_LEMOTE_FL2F:
+	case MACH_LEMOTE_NAS:
+	case MACH_LEMOTE_LL2F:
+		fl2f_shutdown();
+		break;
+	case MACH_LEMOTE_ML2F7:
+		ml2f_shutdown();
+		break;
+	case MACH_LEMOTE_YL2F89:
+		yl2f89_shutdown();
+		break;
+	default:
+		break;
+	}
+}
diff --git a/arch/mips/loongson/fuloong-2e/Makefile b/arch/mips/loongson/fuloong-2e/Makefile
index b762272..328d549 100644
--- a/arch/mips/loongson/fuloong-2e/Makefile
+++ b/arch/mips/loongson/fuloong-2e/Makefile
@@ -2,4 +2,4 @@
 # Makefile for Lemote Fuloong2e mini-PC board.
 #
 
-obj-y += irq.o reset.o
+obj-y += irq.o
diff --git a/arch/mips/loongson/fuloong-2e/reset.c b/arch/mips/loongson/fuloong-2e/reset.c
deleted file mode 100644
index bc39ec6..0000000
--- a/arch/mips/loongson/fuloong-2e/reset.c
+++ /dev/null
@@ -1,23 +0,0 @@
-/* Board-specific reboot/shutdown routines
- * Copyright (c) 2009 Philippe Vachon <philippe@cowpig.ca>
- *
- * Copyright (C) 2009 Lemote Inc.
- * Author: Wu Zhangjin, wuzhangjin@gmail.com
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-
-#include <loongson.h>
-
-void mach_prepare_reboot(void)
-{
-	LOONGSON_GENCFG &= ~(1 << 2);
-	LOONGSON_GENCFG |= (1 << 2);
-}
-
-void mach_prepare_shutdown(void)
-{
-}
diff --git a/arch/mips/loongson/lemote-2f/Makefile b/arch/mips/loongson/lemote-2f/Makefile
index 8699a53..22806bd 100644
--- a/arch/mips/loongson/lemote-2f/Makefile
+++ b/arch/mips/loongson/lemote-2f/Makefile
@@ -2,7 +2,7 @@
 # Makefile for lemote loongson2f family machines
 #
 
-obj-y += machtype.o irq.o reset.o ec_kb3310b.o
+obj-y += machtype.o irq.o
 
 #
 # Suspend Support
diff --git a/arch/mips/loongson/lemote-2f/ec_kb3310b.c b/arch/mips/loongson/lemote-2f/ec_kb3310b.c
deleted file mode 100644
index 2b666d3..0000000
--- a/arch/mips/loongson/lemote-2f/ec_kb3310b.c
+++ /dev/null
@@ -1,128 +0,0 @@
-/*
- * Basic KB3310B Embedded Controller support for the YeeLoong 2F netbook
- *
- *  Copyright (C) 2008 Lemote Inc.
- *  Author: liujl <liujl@lemote.com>, 2008-04-20
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
-
-#include <linux/module.h>
-#include <linux/spinlock.h>
-#include <linux/delay.h>
-
-#include "ec_kb3310b.h"
-
-static DEFINE_SPINLOCK(index_access_lock);
-static DEFINE_SPINLOCK(port_access_lock);
-
-unsigned char ec_read(unsigned short addr)
-{
-	unsigned char value;
-	unsigned long flags;
-
-	spin_lock_irqsave(&index_access_lock, flags);
-	outb((addr & 0xff00) >> 8, EC_IO_PORT_HIGH);
-	outb((addr & 0x00ff), EC_IO_PORT_LOW);
-	value = inb(EC_IO_PORT_DATA);
-	spin_unlock_irqrestore(&index_access_lock, flags);
-
-	return value;
-}
-EXPORT_SYMBOL_GPL(ec_read);
-
-void ec_write(unsigned short addr, unsigned char val)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&index_access_lock, flags);
-	outb((addr & 0xff00) >> 8, EC_IO_PORT_HIGH);
-	outb((addr & 0x00ff), EC_IO_PORT_LOW);
-	outb(val, EC_IO_PORT_DATA);
-	/*  flush the write action */
-	inb(EC_IO_PORT_DATA);
-	spin_unlock_irqrestore(&index_access_lock, flags);
-}
-EXPORT_SYMBOL_GPL(ec_write);
-
-/*
- * This function is used for EC command writes and corresponding status queries.
- */
-int ec_query_seq(unsigned char cmd)
-{
-	int timeout;
-	unsigned char status;
-	unsigned long flags;
-	int ret = 0;
-
-	spin_lock_irqsave(&port_access_lock, flags);
-
-	/* make chip goto reset mode */
-	udelay(EC_REG_DELAY);
-	outb(cmd, EC_CMD_PORT);
-	udelay(EC_REG_DELAY);
-
-	/* check if the command is received by ec */
-	timeout = EC_CMD_TIMEOUT;
-	status = inb(EC_STS_PORT);
-	while (timeout-- && (status & (1 << 1))) {
-		status = inb(EC_STS_PORT);
-		udelay(EC_REG_DELAY);
-	}
-
-	spin_unlock_irqrestore(&port_access_lock, flags);
-
-	if (timeout <= 0) {
-		printk(KERN_ERR "%s: deadable error : timeout...\n", __func__);
-		ret = -EINVAL;
-	} else
-		printk(KERN_INFO
-			   "(%x/%d)ec issued command %d status : 0x%x\n",
-			   timeout, EC_CMD_TIMEOUT - timeout, cmd, status);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(ec_query_seq);
-
-/*
- * Send query command to EC to get the proper event number
- */
-int ec_query_event_num(void)
-{
-	return ec_query_seq(CMD_GET_EVENT_NUM);
-}
-EXPORT_SYMBOL(ec_query_event_num);
-
-/*
- * Get event number from EC
- *
- * NOTE: This routine must follow the query_event_num function in the
- * interrupt.
- */
-int ec_get_event_num(void)
-{
-	int timeout = 100;
-	unsigned char value;
-	unsigned char status;
-
-	udelay(EC_REG_DELAY);
-	status = inb(EC_STS_PORT);
-	udelay(EC_REG_DELAY);
-	while (timeout-- && !(status & (1 << 0))) {
-		status = inb(EC_STS_PORT);
-		udelay(EC_REG_DELAY);
-	}
-	if (timeout <= 0) {
-		pr_info("%s: get event number timeout.\n", __func__);
-
-		return -EINVAL;
-	}
-	value = inb(EC_DAT_PORT);
-	udelay(EC_REG_DELAY);
-
-	return value;
-}
-EXPORT_SYMBOL(ec_get_event_num);
diff --git a/arch/mips/loongson/lemote-2f/ec_kb3310b.h b/arch/mips/loongson/lemote-2f/ec_kb3310b.h
deleted file mode 100644
index 1595a21..0000000
--- a/arch/mips/loongson/lemote-2f/ec_kb3310b.h
+++ /dev/null
@@ -1,188 +0,0 @@
-/*
- * KB3310B Embedded Controller
- *
- *  Copyright (C) 2008 Lemote Inc.
- *  Author: liujl <liujl@lemote.com>, 2008-03-14
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
-
-#ifndef _EC_KB3310B_H
-#define _EC_KB3310B_H
-
-extern unsigned char ec_read(unsigned short addr);
-extern void ec_write(unsigned short addr, unsigned char val);
-extern int ec_query_seq(unsigned char cmd);
-extern int ec_query_event_num(void);
-extern int ec_get_event_num(void);
-
-typedef int (*sci_handler) (int status);
-extern sci_handler yeeloong_report_lid_status;
-
-#define SCI_IRQ_NUM 0x0A
-
-/*
- * The following registers are determined by the EC index configuration.
- * 1, fill the PORT_HIGH as EC register high part.
- * 2, fill the PORT_LOW as EC register low part.
- * 3, fill the PORT_DATA as EC register write data or get the data from it.
- */
-#define	EC_IO_PORT_HIGH	0x0381
-#define	EC_IO_PORT_LOW	0x0382
-#define	EC_IO_PORT_DATA	0x0383
-
-/*
- * EC delay time is 500us for register and status access
- */
-#define	EC_REG_DELAY	500	/* unit : us */
-#define	EC_CMD_TIMEOUT	0x1000
-
-/*
- * EC access port for SCI communication
- */
-#define	EC_CMD_PORT		0x66
-#define	EC_STS_PORT		0x66
-#define	EC_DAT_PORT		0x62
-#define	CMD_INIT_IDLE_MODE	0xdd
-#define	CMD_EXIT_IDLE_MODE	0xdf
-#define	CMD_INIT_RESET_MODE	0xd8
-#define	CMD_REBOOT_SYSTEM	0x8c
-#define	CMD_GET_EVENT_NUM	0x84
-#define	CMD_PROGRAM_PIECE	0xda
-
-/* temperature & fan registers */
-#define	REG_TEMPERATURE_VALUE	0xF458
-#define	REG_FAN_AUTO_MAN_SWITCH 0xF459
-#define	BIT_FAN_AUTO		0
-#define	BIT_FAN_MANUAL		1
-#define	REG_FAN_CONTROL		0xF4D2
-#define	BIT_FAN_CONTROL_ON	(1 << 0)
-#define	BIT_FAN_CONTROL_OFF	(0 << 0)
-#define	REG_FAN_STATUS		0xF4DA
-#define	BIT_FAN_STATUS_ON	(1 << 0)
-#define	BIT_FAN_STATUS_OFF	(0 << 0)
-#define	REG_FAN_SPEED_HIGH	0xFE22
-#define	REG_FAN_SPEED_LOW	0xFE23
-#define	REG_FAN_SPEED_LEVEL	0xF4CC
-/* fan speed divider */
-#define	FAN_SPEED_DIVIDER	480000	/* (60*1000*1000/62.5/2)*/
-
-/* battery registers */
-#define	REG_BAT_DESIGN_CAP_HIGH		0xF77D
-#define	REG_BAT_DESIGN_CAP_LOW		0xF77E
-#define	REG_BAT_FULLCHG_CAP_HIGH	0xF780
-#define	REG_BAT_FULLCHG_CAP_LOW		0xF781
-#define	REG_BAT_DESIGN_VOL_HIGH		0xF782
-#define	REG_BAT_DESIGN_VOL_LOW		0xF783
-#define	REG_BAT_CURRENT_HIGH		0xF784
-#define	REG_BAT_CURRENT_LOW		0xF785
-#define	REG_BAT_VOLTAGE_HIGH		0xF786
-#define	REG_BAT_VOLTAGE_LOW		0xF787
-#define	REG_BAT_TEMPERATURE_HIGH	0xF788
-#define	REG_BAT_TEMPERATURE_LOW		0xF789
-#define	REG_BAT_RELATIVE_CAP_HIGH	0xF492
-#define	REG_BAT_RELATIVE_CAP_LOW	0xF493
-#define	REG_BAT_VENDOR			0xF4C4
-#define	FLAG_BAT_VENDOR_SANYO		0x01
-#define	FLAG_BAT_VENDOR_SIMPLO		0x02
-#define	REG_BAT_CELL_COUNT		0xF4C6
-#define	FLAG_BAT_CELL_3S1P		0x03
-#define	FLAG_BAT_CELL_3S2P		0x06
-#define	REG_BAT_CHARGE			0xF4A2
-#define	FLAG_BAT_CHARGE_DISCHARGE	0x01
-#define	FLAG_BAT_CHARGE_CHARGE		0x02
-#define	FLAG_BAT_CHARGE_ACPOWER		0x00
-#define	REG_BAT_STATUS			0xF4B0
-#define	BIT_BAT_STATUS_LOW		(1 << 5)
-#define	BIT_BAT_STATUS_DESTROY		(1 << 2)
-#define	BIT_BAT_STATUS_FULL		(1 << 1)
-#define	BIT_BAT_STATUS_IN		(1 << 0)
-#define	REG_BAT_CHARGE_STATUS		0xF4B1
-#define	BIT_BAT_CHARGE_STATUS_OVERTEMP	(1 << 2)
-#define	BIT_BAT_CHARGE_STATUS_PRECHG	(1 << 1)
-#define	REG_BAT_STATE			0xF482
-#define	BIT_BAT_STATE_CHARGING		(1 << 1)
-#define	BIT_BAT_STATE_DISCHARGING	(1 << 0)
-#define	REG_BAT_POWER			0xF440
-#define	BIT_BAT_POWER_S3		(1 << 2)
-#define	BIT_BAT_POWER_ON		(1 << 1)
-#define	BIT_BAT_POWER_ACIN		(1 << 0)
-
-/* other registers */
-/* Audio: rd/wr */
-#define	REG_AUDIO_VOLUME	0xF46C
-#define	REG_AUDIO_MUTE		0xF4E7
-#define	REG_AUDIO_BEEP		0xF4D0
-/* USB port power or not: rd/wr */
-#define	REG_USB0_FLAG		0xF461
-#define	REG_USB1_FLAG		0xF462
-#define	REG_USB2_FLAG		0xF463
-#define	BIT_USB_FLAG_ON		1
-#define	BIT_USB_FLAG_OFF	0
-/* LID */
-#define	REG_LID_DETECT		0xF4BD
-#define	BIT_LID_DETECT_ON	1
-#define	BIT_LID_DETECT_OFF	0
-/* CRT */
-#define	REG_CRT_DETECT		0xF4AD
-#define	BIT_CRT_DETECT_PLUG	1
-#define	BIT_CRT_DETECT_UNPLUG	0
-/* LCD backlight brightness adjust: 9 levels */
-#define	REG_DISPLAY_BRIGHTNESS	0xF4F5
-/* Black screen Status */
-#define	BIT_DISPLAY_LCD_ON	1
-#define	BIT_DISPLAY_LCD_OFF	0
-/* LCD backlight control: off/restore */
-#define	REG_BACKLIGHT_CTRL	0xF7BD
-#define	BIT_BACKLIGHT_ON	1
-#define	BIT_BACKLIGHT_OFF	0
-/* Reset the machine auto-clear: rd/wr */
-#define	REG_RESET		0xF4EC
-#define	BIT_RESET_ON		1
-/* Light the led: rd/wr */
-#define	REG_LED			0xF4C8
-#define	BIT_LED_RED_POWER	(1 << 0)
-#define	BIT_LED_ORANGE_POWER	(1 << 1)
-#define	BIT_LED_GREEN_CHARGE	(1 << 2)
-#define	BIT_LED_RED_CHARGE	(1 << 3)
-#define	BIT_LED_NUMLOCK		(1 << 4)
-/* Test led mode, all led on/off */
-#define	REG_LED_TEST		0xF4C2
-#define	BIT_LED_TEST_IN		1
-#define	BIT_LED_TEST_OUT	0
-/* Camera on/off */
-#define	REG_CAMERA_STATUS	0xF46A
-#define	BIT_CAMERA_STATUS_ON	1
-#define	BIT_CAMERA_STATUS_OFF	0
-#define	REG_CAMERA_CONTROL	0xF7B7
-#define	BIT_CAMERA_CONTROL_OFF	0
-#define	BIT_CAMERA_CONTROL_ON	1
-/* Wlan Status */
-#define	REG_WLAN		0xF4FA
-#define	BIT_WLAN_ON		1
-#define	BIT_WLAN_OFF		0
-#define	REG_DISPLAY_LCD		0xF79F
-
-/* SCI Event Number from EC */
-enum {
-	EVENT_LID = 0x23,	/*  LID open/close */
-	EVENT_DISPLAY_TOGGLE,	/*  Fn+F3 for display switch */
-	EVENT_SLEEP,		/*  Fn+F1 for entering sleep mode */
-	EVENT_OVERTEMP,		/*  Over-temperature happened */
-	EVENT_CRT_DETECT,	/*  CRT is connected */
-	EVENT_CAMERA,		/*  Camera on/off */
-	EVENT_USB_OC2,		/*  USB2 Over Current occurred */
-	EVENT_USB_OC0,		/*  USB0 Over Current occurred */
-	EVENT_BLACK_SCREEN,	/*  Turn on/off backlight */
-	EVENT_AUDIO_MUTE,	/*  Mute on/off */
-	EVENT_DISPLAY_BRIGHTNESS,/* LCD backlight brightness adjust */
-	EVENT_AC_BAT,		/*  AC & Battery relative issue */
-	EVENT_AUDIO_VOLUME,	/*  Volume adjust */
-	EVENT_WLAN,		/*  Wlan on/off */
-	EVENT_END
-};
-
-#endif /* !_EC_KB3310B_H */
diff --git a/arch/mips/loongson/lemote-2f/pm.c b/arch/mips/loongson/lemote-2f/pm.c
index cac4d38..c48ba65 100644
--- a/arch/mips/loongson/lemote-2f/pm.c
+++ b/arch/mips/loongson/lemote-2f/pm.c
@@ -23,7 +23,7 @@
 #include <loongson.h>
 
 #include <cs5536/cs5536_mfgpt.h>
-#include "ec_kb3310b.h"
+#include "../common/ec_kb3310b.h"
 
 #define I8042_KBD_IRQ		1
 #define I8042_CTR_KBDINT	0x01
diff --git a/arch/mips/loongson/lemote-2f/reset.c b/arch/mips/loongson/lemote-2f/reset.c
deleted file mode 100644
index 36020a0..0000000
--- a/arch/mips/loongson/lemote-2f/reset.c
+++ /dev/null
@@ -1,159 +0,0 @@
-/* Board-specific reboot/shutdown routines
- *
- * Copyright (c) 2009 Philippe Vachon <philippe@cowpig.ca>
- *
- * Copyright (C) 2009 Lemote Inc.
- * Author: Wu Zhangjin, wuzhangjin@gmail.com
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-
-#include <linux/io.h>
-#include <linux/delay.h>
-#include <linux/types.h>
-
-#include <asm/bootinfo.h>
-
-#include <loongson.h>
-
-#include <cs5536/cs5536.h>
-#include "ec_kb3310b.h"
-
-static void reset_cpu(void)
-{
-	/*
-	 * reset cpu to full speed, this is needed when enabling cpu frequency
-	 * scalling
-	 */
-	LOONGSON_CHIPCFG0 |= 0x7;
-}
-
-/* reset support for fuloong2f */
-
-static void fl2f_reboot(void)
-{
-	reset_cpu();
-
-	/* send a reset signal to south bridge.
-	 *
-	 * NOTE: if enable "Power Management" in kernel, rtl8169 will not reset
-	 * normally with this reset operation and it will not work in PMON, but
-	 * you can type halt command and then reboot, seems the hardware reset
-	 * logic not work normally.
-	 */
-	{
-		u32 hi, lo;
-		_rdmsr(DIVIL_MSR_REG(DIVIL_SOFT_RESET), &hi, &lo);
-		lo |= 0x00000001;
-		_wrmsr(DIVIL_MSR_REG(DIVIL_SOFT_RESET), hi, lo);
-	}
-}
-
-static void fl2f_shutdown(void)
-{
-	u32 hi, lo, val;
-	int gpio_base;
-
-	/* get gpio base */
-	_rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_GPIO), &hi, &lo);
-	gpio_base = lo & 0xff00;
-
-	/* make cs5536 gpio13 output enable */
-	val = inl(gpio_base + GPIOL_OUT_EN);
-	val &= ~(1 << (16 + 13));
-	val |= (1 << 13);
-	outl(val, gpio_base + GPIOL_OUT_EN);
-	mmiowb();
-	/* make cs5536 gpio13 output low level voltage. */
-	val = inl(gpio_base + GPIOL_OUT_VAL) & ~(1 << (13));
-	val |= (1 << (16 + 13));
-	outl(val, gpio_base + GPIOL_OUT_VAL);
-	mmiowb();
-}
-
-/* reset support for yeeloong2f and mengloong2f notebook */
-
-void ml2f_reboot(void)
-{
-	reset_cpu();
-
-	/* sending an reset signal to EC(embedded controller) */
-	ec_write(REG_RESET, BIT_RESET_ON);
-}
-
-#define yl2f89_reboot ml2f_reboot
-
-/* menglong(7inches) laptop has different shutdown logic from 8.9inches */
-#define EC_SHUTDOWN_IO_PORT_HIGH 0xff2d
-#define EC_SHUTDOWN_IO_PORT_LOW	 0xff2e
-#define EC_SHUTDOWN_IO_PORT_DATA 0xff2f
-#define REG_SHUTDOWN_HIGH        0xFC
-#define REG_SHUTDOWN_LOW         0x29
-#define BIT_SHUTDOWN_ON          (1 << 1)
-
-static void ml2f_shutdown(void)
-{
-	u8 val;
-	u64 i;
-
-	outb(REG_SHUTDOWN_HIGH, EC_SHUTDOWN_IO_PORT_HIGH);
-	outb(REG_SHUTDOWN_LOW, EC_SHUTDOWN_IO_PORT_LOW);
-	mmiowb();
-	val = inb(EC_SHUTDOWN_IO_PORT_DATA);
-	outb(val & (~BIT_SHUTDOWN_ON), EC_SHUTDOWN_IO_PORT_DATA);
-	mmiowb();
-	/* need enough wait here... how many microseconds needs? */
-	for (i = 0; i < 0x10000; i++)
-		delay();
-	outb(val | BIT_SHUTDOWN_ON, EC_SHUTDOWN_IO_PORT_DATA);
-	mmiowb();
-}
-
-static void yl2f89_shutdown(void)
-{
-	/* cpu-gpio0 output low */
-	LOONGSON_GPIODATA &= ~0x00000001;
-	/* cpu-gpio0 as output */
-	LOONGSON_GPIOIE &= ~0x00000001;
-}
-
-void mach_prepare_reboot(void)
-{
-	switch (mips_machtype) {
-	case MACH_LEMOTE_FL2F:
-	case MACH_LEMOTE_NAS:
-	case MACH_LEMOTE_LL2F:
-		fl2f_reboot();
-		break;
-	case MACH_LEMOTE_ML2F7:
-		ml2f_reboot();
-		break;
-	case MACH_LEMOTE_YL2F89:
-		yl2f89_reboot();
-		break;
-	default:
-		break;
-	}
-}
-
-void mach_prepare_shutdown(void)
-{
-	switch (mips_machtype) {
-	case MACH_LEMOTE_FL2F:
-	case MACH_LEMOTE_NAS:
-	case MACH_LEMOTE_LL2F:
-		fl2f_shutdown();
-		break;
-	case MACH_LEMOTE_ML2F7:
-		ml2f_shutdown();
-		break;
-	case MACH_LEMOTE_YL2F89:
-		yl2f89_shutdown();
-		break;
-	default:
-		break;
-	}
-}
-- 
1.5.6.5
