Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 23 Mar 2003 21:24:11 +0000 (GMT)
Received: from honk1.physik.uni-konstanz.de ([IPv6:::ffff:134.34.140.224]:51848
	"EHLO honk1.physik.uni-konstanz.de") by linux-mips.org with ESMTP
	id <S8225195AbTCWVYK>; Sun, 23 Mar 2003 21:24:10 +0000
Received: from localhost (localhost [127.0.0.1])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP id 7296A2BC31
	for <linux-mips@linux-mips.org>; Sun, 23 Mar 2003 22:24:03 +0100 (CET)
Received: from honk1.physik.uni-konstanz.de ([127.0.0.1])
 by localhost (honk [127.0.0.1:10024]) (amavisd-new) with ESMTP id 21943-04
 for <linux-mips@linux-mips.org>; Sun, 23 Mar 2003 22:24:02 +0100 (CET)
Received: from bogon.sigxcpu.org (kons-d9bb5426.pool.mediaWays.net [217.187.84.38])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP id 6BDD42BC2D
	for <linux-mips@linux-mips.org>; Sun, 23 Mar 2003 22:24:01 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
	id C94411735C; Sun, 23 Mar 2003 22:21:44 +0100 (CET)
Date: Sun, 23 Mar 2003 19:43:17 +0100
From: Guido Guenther <agx@debian.org>
To: linux-mips@linux-mips.org
Cc: ralf@linux-mips.org, vivien.chappelier@linux-mips.org
Subject: [PATCH 2.5]: IP32 enable power button
Message-ID: <20030323184317.GE26796@bogon.ms20.nix>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="RhUH2Ysw6aD5utA4"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Resent-From: agx@sigxcpu.org
Resent-Date: Sun, 23 Mar 2003 22:21:44 +0100
Resent-To: linux-mips@linux-mips.org
Resent-Message-Id: <20030323212144.C94411735C@bogon.sigxcpu.org>
Return-Path: <agx@sigxcpu.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1794
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: agx@sigxcpu.org
Precedence: bulk
X-list: linux-mips


--RhUH2Ysw6aD5utA4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
the attached patch enables the power button on IP32 and adds definitions
for the extra registers of the ds1728[57]. Please apply.
Regards,
 -- Guido

--RhUH2Ysw6aD5utA4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ip32-pwr-button.diff"

Index: arch/mips/sgi-ip32/ip32-reset.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/sgi-ip32/ip32-reset.c,v
retrieving revision 1.1
diff -u -p -r1.1 ip32-reset.c
--- arch/mips/sgi-ip32/ip32-reset.c	25 Jul 2002 19:10:08 -0000	1.1
+++ arch/mips/sgi-ip32/ip32-reset.c	23 Mar 2003 18:27:34 -0000
@@ -5,30 +5,186 @@
  *
  * Copyright (C) 2001 Keith M Wesolowski
  * Copyright (C) 2001 Paul Mundt
+ * Copyright (C) 2003 Guido Guenther <agx@sigxcpu.org>
+ *
+ * based on sgi-ip22/ip22-reset.c
  */
+
 #include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/notifier.h>
+#include <linux/ds17287rtc.h>
 
+#include <asm/irq.h>
 #include <asm/reboot.h>
 #include <asm/sgialib.h>
+#include <asm/addrspace.h>
+#include <asm/types.h>
+#include <asm/system.h>
+#include <asm/ip32/ip32_ints.h>
+
+#define POWERDOWN_TIMEOUT	120
+/*
+ * Blink frequency during reboot grace period and when paniced.
+ */
+#define POWERDOWN_FREQ		(HZ / 4)
+#define PANIC_FREQ		(HZ / 8)
+
+static struct timer_list power_timer, blink_timer, debounce_timer;
+static int shuting_down = 0, has_paniced = 0;
+
+static void ip32_machine_restart(char *command) __attribute__((noreturn));
+static void ip32_machine_halt(void) __attribute__((noreturn));
+static void ip32_machine_power_off(void) __attribute__((noreturn));
 
 static void ip32_machine_restart(char *cmd)
 {
+	if (shuting_down)
+		ip32_machine_power_off();
 	ArcReboot();
 }
 
 static inline void ip32_machine_halt(void)
 {
+	if (shuting_down)
+		ip32_machine_power_off();
 	ArcEnterInteractiveMode();
 }
 
 static void ip32_machine_power_off(void)
 {
-	ip32_machine_halt();
+	volatile unsigned char reg_a, xctrl_a, xctrl_b;
+
+	reg_a = CMOS_READ(RTC_REG_A);
+
+	/* setup for kickstart & wake-up (DS12287 Ref. Man. p. 19) */
+	reg_a &= ~DS_REGA_DV2;
+	reg_a |= DS_REGA_DV1 | DS_REGA_DV0;
+	CMOS_WRITE(reg_a, RTC_REG_A);
+
+	while(1) {
+		xctrl_a = CMOS_READ(DS_B1_XCTRL4A) 
+				& ~(DS_XCTRL4A_WF | DS_XCTRL4A_KF);
+		xctrl_a = DS_XCTRL4A_PAB; /* power off flag */
+		xctrl_b = CMOS_READ(DS_B1_XCTRL4B) 
+				| DS_XCTRL4B_WFE | DS_XCTRL4B_KFE;
+		CMOS_WRITE(xctrl_b, DS_B1_XCTRL4B);
+		CMOS_WRITE(xctrl_a, DS_B1_XCTRL4A);
+	}
+}
+
+static void power_timeout(unsigned long data)
+{
+	ip32_machine_power_off();
 }
 
-void __init ip32_reboot_setup(void)
+static void blink_timeout(unsigned long data)
+{
+	u64 mc_led =  mace_read_64(MACEISA_FLASH_NIC_REG);
+
+	mc_led ^= MACEISA_LED_RED;
+	if(has_paniced) 
+		mc_led &= ~MACEISA_LED_GREEN;
+	mace_write_64(MACEISA_FLASH_NIC_REG, mc_led);
+	mod_timer(&blink_timer, jiffies+data);
+}
+
+static void debounce(unsigned long data)
+{
+	volatile unsigned char reg_a,reg_c,xctrl_a;
+
+	reg_c = CMOS_READ(RTC_INTR_FLAGS);
+	reg_a = CMOS_READ(RTC_REG_A);
+	CMOS_WRITE(reg_a | DS_REGA_DV0, RTC_REG_A);
+	xctrl_a = CMOS_READ(DS_B1_XCTRL4A);
+	if( xctrl_a & DS_XCTRL4A_KF || reg_c & RTC_IRQF ) {
+		/* Interrupt still being sent. */
+		debounce_timer.expires = jiffies + 5; /* 0.05s  */
+		add_timer(&debounce_timer);
+
+		/* clear interrupt source */
+		CMOS_WRITE( xctrl_a & ~(DS_XCTRL4A_KF|DS_XCTRL4A_WF|DS_XCTRL4A_RF),
+			    DS_B1_XCTRL4A);
+		CMOS_WRITE(reg_a & ~DS_REGA_DV0, RTC_REG_A);
+		return;
+	}
+	CMOS_WRITE(reg_a & ~DS_REGA_DV0, RTC_REG_A);
+
+	if (has_paniced)
+		ArcReboot();
+
+	enable_irq(MACEISA_RTC_IRQ);
+}
+
+static inline void ip32_power_button(void)
+{
+	if (has_paniced)
+		return;
+
+	if (shuting_down || kill_proc(1, SIGINT, 1)) {
+		/* No init process or button pressed twice.  */
+		ip32_machine_power_off();
+	}
+
+	shuting_down = 1;
+	blink_timer.data = POWERDOWN_FREQ;
+	blink_timeout(POWERDOWN_FREQ);
+
+	init_timer(&power_timer);
+	power_timer.function = power_timeout;
+	power_timer.expires = jiffies + POWERDOWN_TIMEOUT * HZ;
+	add_timer(&power_timer);
+}
+
+static void ip32_rtc_int(int irq, void *dev_id, struct pt_regs *regs)
+{
+	volatile unsigned char reg_c;
+
+	reg_c = CMOS_READ(RTC_INTR_FLAGS);
+	if( reg_c & RTC_IRQF ) {
+		/* Wait until interrupt goes away */
+		disable_irq(MACEISA_RTC_IRQ);
+		init_timer(&debounce_timer);
+		debounce_timer.function = debounce;
+		debounce_timer.expires = jiffies + 5;
+		add_timer(&debounce_timer);
+	} else
+		printk(KERN_WARNING 
+			"%s: RTC IRQ without RTC_IRQF\n", __FUNCTION__);
+
+	printk(KERN_DEBUG "Power button pressed\n");
+	ip32_power_button();
+}
+
+static int panic_event(struct notifier_block *this, unsigned long event,
+                      void *ptr)
+{
+	if (has_paniced)
+		return NOTIFY_DONE;
+	has_paniced = 1;
+
+	blink_timer.data = PANIC_FREQ;
+	blink_timeout(PANIC_FREQ);
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block panic_block = {
+	.notifier_call	= panic_event,
+};
+
+static __init int ip32_reboot_setup(void)
 {
 	_machine_restart = ip32_machine_restart;
 	_machine_halt = ip32_machine_halt;
 	_machine_power_off = ip32_machine_power_off;
+	request_irq(MACEISA_RTC_IRQ, ip32_rtc_int, 0, "rtc", NULL);
+	init_timer(&blink_timer);
+	blink_timer.function = blink_timeout;
+	notifier_chain_register(&panic_notifier_list, &panic_block);
+
+	return 0;
 }
+
+subsys_initcall(ip32_reboot_setup);
Index: arch/mips/sgi-ip32/ip32-setup.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/sgi-ip32/ip32-setup.c,v
retrieving revision 1.2
diff -u -p -r1.2 ip32-setup.c
--- arch/mips/sgi-ip32/ip32-setup.c	21 Sep 2002 21:21:18 -0000	1.2
+++ arch/mips/sgi-ip32/ip32-setup.c	23 Mar 2003 18:27:34 -0000
@@ -89,8 +105,6 @@ void __init ip32_setup(void)
 #ifdef CONFIG_VT
 	conswitchp = &dummy_con;
 #endif
-
-	ip32_reboot_setup();
 
 	rtc_ops = &ip32_rtc_ops;
 	board_time_init = ip32_time_init;
--- /dev/null	Sat Mar 16 18:32:44 2002
+++ include/linux/ds17287rtc.h	Sun Mar 23 17:58:47 2003
@@ -0,0 +1,64 @@
+/* 
+ * ds17287rtc.h - register definitions for the ds1728[57] RTC / CMOS RAM
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ * 
+ * (C) 2003 Guido Guenther <agx@sigxcpu.org>
+ *
+ */
+
+#ifndef _DS17287RTC_H
+#define _DS17287RTC_H
+
+#include <asm/io.h>
+#include <linux/rtc.h>			/* get the user-level API */
+#include <linux/spinlock.h>		/* spinlock_t */
+#include <linux/mc146818rtc.h>
+
+/* register A */
+#define DS_REGA_DV2 0x40		/* countdown chain */
+#define DS_REGA_DV1 0x20		/* oscillator enable */
+#define DS_REGA_DV0 0x10		/* bank select */
+
+/* bank 1 registers */
+#define DS_B1_MODEL	 0x40		/* model number byte */
+#define DS_B1_SN1 	 0x41		/* serial number byte 1 */
+#define DS_B1_SN2 	 0x42		/* serial number byte 2 */
+#define DS_B1_SN3 	 0x43		/* serial number byte 3 */
+#define DS_B1_SN4 	 0x44		/* serial number byte 4 */
+#define DS_B1_SN5 	 0x45		/* serial number byte 5 */
+#define DS_B1_SN6 	 0x46		/* serial number byte 6 */
+#define DS_B1_CRC 	 0x47		/* CRC byte */
+#define DS_B1_CENTURY 	 0x48		/* Century byte */
+#define DS_B1_DALARM 	 0x49		/* date alarm */
+#define DS_B1_XCTRL4A	 0x4a		/* extendec control register 4a */
+#define DS_B1_XCTRL4B	 0x4b		/* extendec control register 4b */
+#define DS_B1_RTCADDR2 	 0x4e		/* rtc address 2 */
+#define DS_B1_RTCADDR3 	 0x4f		/* rtc address 2 */
+#define DS_B1_RAMLSB	 0x50		/* extended ram LSB */
+#define DS_B1_RAMMSB	 0x51		/* extended ram MSB */
+#define DS_B1_RAMDPORT	 0x53		/* extended ram data port */
+
+/* register details */
+/* extended control register 4a */
+#define DS_XCTRL4A_VRT2  0x80 		/* valid ram and time */
+#define DS_XCTRL4A_INCR  0x40		/* increment progress status */
+#define DS_XCTRL4A_BME   0x20		/* burst mode enable */
+#define DS_XCTRL4A_PAB   0x08		/* power active bar ctrl */
+#define DS_XCTRL4A_RF    0x04		/* ram clear flag */
+#define DS_XCTRL4A_WF    0x02		/* wake up alarm flag */
+#define DS_XCTRL4A_KF    0x01		/* kickstart flag */
+
+/* extended control register 4b */
+#define DS_XCTRL4B_ABE   0x80 		/* auxiliary battery enable */
+#define DS_XCTRL4B_E32K	 0x40		/* enable 32.768 kHz Output */
+#define DS_XCTRL4B_CS    0x20		/* crystal select */
+#define DS_XCTRL4B_RCE   0x10		/* ram clear enable */
+#define DS_XCTRL4B_PRS   0x08		/* PAB resec select */
+#define DS_XCTRL4B_RIE   0x04		/* ram clear interrupt enable */
+#define DS_XCTRL4B_WFE   0x02		/* wake up alarm interrupt enable */
+#define DS_XCTRL4B_KFE   0x01		/* kickstart interrupt enable */
+
+#endif /* _DS17287RTC_H */

--RhUH2Ysw6aD5utA4--
