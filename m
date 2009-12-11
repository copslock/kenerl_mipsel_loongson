Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Dec 2009 04:32:43 +0100 (CET)
Received: from mail-yw0-f182.google.com ([209.85.211.182]:52448 "EHLO
        mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491779AbZLKDcj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 Dec 2009 04:32:39 +0100
Received: by ywh12 with SMTP id 12so518390ywh.21
        for <multiple recipients>; Thu, 10 Dec 2009 19:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=H3EF29TeL3ORd9YdU6SvdOuxzCOCcfjcla6tm7/ZL+M=;
        b=wQivLh8LrtK97alnuHYMG1kY4x32loHL36ykdlNaNbcflB9a/N2A2szv1ikFyw9lfd
         CtXAIWN4qgCrYhSRGBtkM69ykwymq4H2cTc/0aJg+T6Tn+C0ESzj8C4un9lxxbLz78jk
         ann0H09APfn34Dej9LZu5/f3iRAT1gVw2X/Zg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=w6P5w3pqylYGsQbd9xhdl+QoL2AEy0/ko3tW9lauW2S2WG3x5W5pN0/neg4m7GbV/K
         NQR6hgK0WqzuTNLz9e+6owkH4xKW3H0kMCzYK2d+3hyeUF45FgLO1iWjhWQB/VZ3EztR
         w163oDeNf33ENuffhAQHPwO0qMOvXODdlG2dc=
Received: by 10.150.245.31 with SMTP id s31mr1620399ybh.128.1260502349977;
        Thu, 10 Dec 2009 19:32:29 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 4sm571044ywg.43.2009.12.10.19.32.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 10 Dec 2009 19:32:29 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Rafael J . Wysocki" <rjw@sisk.pl>, zhangfx@lemote.com,
        linux-laptop@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Pavel Machek <pavel@ucw.cz>, akpm@linux-foundation.org,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH v10 8/8] Loongson: YeeLoong: add input/hotkey driver
Date:   Fri, 11 Dec 2009 11:32:16 +0800
Message-Id: <ff3ecb65fc73cd8b813a009605b58c0d3fb976c7.1260502163.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25392
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

Changes from v9 8/8:

  o Remove the wifi related actions

  With the standard rfkill support(/sys/class/rfkill/) in the wifi
  driver, there is no need to handle the wifi related actions except
  reporting the KEY_WLAN event to user-space. the related applications
  will response this event and do corresponding actions(access the
  rfkill interfaces).

------------------

This patch adds Hotkey Driver, which will do related actions for The
hotkey event(/sys/class/input) and report the corresponding input keys
to the user-space applications.

(This patch is based on the sparse keymap library in:

git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input next

of Dmitry Torokhov. that sparse keymap support is also queued for
2.6.33. Before the above branch is pulled by linus, this patch is not
appliable.)

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/include/asm/mach-loongson/loongson.h |    6 +
 arch/mips/loongson/common/cmdline.c            |    8 +
 drivers/platform/mips/Kconfig                  |    2 +
 drivers/platform/mips/yeeloong_laptop.c        |  402 ++++++++++++++++++++++++
 4 files changed, 418 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/mach-loongson/loongson.h b/arch/mips/include/asm/mach-loongson/loongson.h
index ee8bc83..13e208e 100644
--- a/arch/mips/include/asm/mach-loongson/loongson.h
+++ b/arch/mips/include/asm/mach-loongson/loongson.h
@@ -43,6 +43,12 @@ static inline void prom_init_uart_base(void)
 #endif
 }
 
+/*
+ * Copy kernel command line from arcs_cmdline
+ */
+#include <asm/setup.h>
+extern char loongson_cmdline[COMMAND_LINE_SIZE];
+
 /* irq operation functions */
 extern void bonito_irqdispatch(void);
 extern void __init bonito_irq_init(void);
diff --git a/arch/mips/loongson/common/cmdline.c b/arch/mips/loongson/common/cmdline.c
index 7ad47f2..617faee 100644
--- a/arch/mips/loongson/common/cmdline.c
+++ b/arch/mips/loongson/common/cmdline.c
@@ -17,6 +17,7 @@
  * Free Software Foundation;  either version 2 of the  License, or (at your
  * option) any later version.
  */
+#include <linux/module.h>
 #include <asm/bootinfo.h>
 
 #include <loongson.h>
@@ -25,6 +26,10 @@ int prom_argc;
 /* pmon passes arguments in 32bit pointers */
 int *_prom_argv;
 
+/* the kernel command line copied from arcs_cmdline */
+char loongson_cmdline[COMMAND_LINE_SIZE];
+EXPORT_SYMBOL(loongson_cmdline);
+
 void __init prom_init_cmdline(void)
 {
 	int i;
@@ -51,4 +56,7 @@ void __init prom_init_cmdline(void)
 		strcat(arcs_cmdline, " root=/dev/hda1");
 
 	prom_init_machtype();
+
+	/* copy arcs_cmdline into loongson_cmdline */
+	strncpy(loongson_cmdline, arcs_cmdline, COMMAND_LINE_SIZE);
 }
diff --git a/drivers/platform/mips/Kconfig b/drivers/platform/mips/Kconfig
index e2dbe28..8262dff 100644
--- a/drivers/platform/mips/Kconfig
+++ b/drivers/platform/mips/Kconfig
@@ -22,6 +22,8 @@ config LEMOTE_YEELOONG2F
 	select APM_EMULATION
 	select HWMON
 	select VIDEO_OUTPUT_CONTROL
+	select INPUT_SPARSEKMAP
+	depends on INPUT
 	help
 	  YeeLoong netbook is a mini laptop made by Lemote, which is basically
 	  compatible to FuLoong2F mini PC, but it has an extra Embedded
diff --git a/drivers/platform/mips/yeeloong_laptop.c b/drivers/platform/mips/yeeloong_laptop.c
index baf3e81..ba34344 100644
--- a/drivers/platform/mips/yeeloong_laptop.c
+++ b/drivers/platform/mips/yeeloong_laptop.c
@@ -17,7 +17,14 @@
 #include <linux/hwmon.h>	/* for hwmon subdriver */
 #include <linux/hwmon-sysfs.h>
 #include <linux/video_output.h>	/* for video output subdriver */
+#include <linux/input.h>	/* for hotkey subdriver */
+#include <linux/input/sparse-keymap.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
 
+#include <cs5536/cs5536.h>
+
+#include <loongson.h>		/* for loongson_cmdline */
 #include <ec_kb3310b.h>
 
 /* backlight subdriver */
@@ -512,6 +519,393 @@ static void yeeloong_vo_exit(void)
 	}
 }
 
+/* hotkey subdriver */
+
+static struct input_dev *yeeloong_hotkey_dev;
+
+static const struct key_entry yeeloong_keymap[] = {
+	{KE_SW, EVENT_LID, { SW_LID } },
+	{KE_KEY, EVENT_CAMERA, { KEY_CAMERA } }, /* Fn + ESC */
+	{KE_KEY, EVENT_SLEEP, { KEY_SLEEP } }, /* Fn + F1 */
+	{KE_KEY, EVENT_DISPLAY_TOGGLE, { KEY_SWITCHVIDEOMODE } }, /* Fn + F3 */
+	{KE_KEY, EVENT_AUDIO_MUTE, { KEY_MUTE } }, /* Fn + F4 */
+	{KE_KEY, EVENT_WLAN, { KEY_WLAN } }, /* Fn + F5 */
+	{KE_KEY, EVENT_DISPLAY_BRIGHTNESS, { KEY_BRIGHTNESSUP } }, /* Fn + up */
+	{KE_KEY, EVENT_DISPLAY_BRIGHTNESS, { KEY_BRIGHTNESSDOWN } }, /* Fn + down */
+	{KE_KEY, EVENT_AUDIO_VOLUME, { KEY_VOLUMEUP } }, /* Fn + right */
+	{KE_KEY, EVENT_AUDIO_VOLUME, { KEY_VOLUMEDOWN } }, /* Fn + left */
+	{KE_END, 0}
+};
+
+static struct key_entry *get_event_key_entry(int event, int status)
+{
+	struct key_entry *ke;
+	static int old_brightness_status = -1;
+	static int old_volume_status = -1;
+
+	ke = sparse_keymap_entry_from_scancode(yeeloong_hotkey_dev, event);
+	if (!ke)
+		return NULL;
+
+	switch (event) {
+	case EVENT_DISPLAY_BRIGHTNESS:
+		/* current status > old one, means up */
+		if ((status < old_brightness_status) || (0 == status))
+			ke++;
+		old_brightness_status = status;
+		break;
+	case EVENT_AUDIO_VOLUME:
+		if ((status < old_volume_status) || (0 == status))
+			ke++;
+		old_volume_status = status;
+		break;
+	default:
+		break;
+	}
+
+	return ke;
+}
+
+static int report_lid_switch(int status)
+{
+	input_report_switch(yeeloong_hotkey_dev, SW_LID, !status);
+	input_sync(yeeloong_hotkey_dev);
+
+	return status;
+}
+
+static int crt_detect_handler(int status)
+{
+	if (status) {
+		yeeloong_crt_vo_set(BIT_CRT_DETECT_PLUG);
+		yeeloong_lcd_vo_set(BIT_DISPLAY_LCD_OFF);
+	} else {
+		yeeloong_lcd_vo_set(BIT_DISPLAY_LCD_ON);
+		yeeloong_crt_vo_set(BIT_CRT_DETECT_UNPLUG);
+	}
+	return status;
+}
+
+#define EC_VER_LEN 64
+
+static int black_screen_handler(int status)
+{
+	char *p, ec_ver[EC_VER_LEN];
+
+	p = strstr(loongson_cmdline, "EC_VER=");
+	if (!p)
+		memset(ec_ver, 0, EC_VER_LEN);
+	else {
+		strncpy(ec_ver, p, EC_VER_LEN);
+		p = strstr(ec_ver, " ");
+		if (p)
+			*p = '\0';
+	}
+
+	/* Seems EC(>=PQ1D26) does this job for us, we can not do it again,
+	 * otherwise, the brightness will not resume to the normal level! */
+	if (strncasecmp(ec_ver, "EC_VER=PQ1D26", 64) < 0)
+		yeeloong_lcd_vo_set(status);
+
+	return status;
+}
+
+static int display_toggle_handler(int status)
+{
+	static int video_output_status;
+
+	/* Only enable switch video output button
+	 * when CRT is connected */
+	if (ec_read(REG_CRT_DETECT) == BIT_CRT_DETECT_UNPLUG)
+		return 0;
+	/* 0. no CRT connected: LCD on, CRT off
+	 * 1. BOTH on
+	 * 2. LCD off, CRT on
+	 * 3. BOTH off
+	 * 4. LCD on, CRT off
+	 */
+	video_output_status++;
+	if (video_output_status > 4)
+		video_output_status = 1;
+
+	switch (video_output_status) {
+	case 1:
+		yeeloong_lcd_vo_set(BIT_DISPLAY_LCD_ON);
+		yeeloong_crt_vo_set(BIT_CRT_DETECT_PLUG);
+		break;
+	case 2:
+		yeeloong_lcd_vo_set(BIT_DISPLAY_LCD_OFF);
+		yeeloong_crt_vo_set(BIT_CRT_DETECT_PLUG);
+		break;
+	case 3:
+		yeeloong_lcd_vo_set(BIT_DISPLAY_LCD_OFF);
+		yeeloong_crt_vo_set(BIT_CRT_DETECT_UNPLUG);
+		break;
+	case 4:
+		yeeloong_lcd_vo_set(BIT_DISPLAY_LCD_ON);
+		yeeloong_crt_vo_set(BIT_CRT_DETECT_UNPLUG);
+		break;
+	default:
+		/* Ensure LCD is on */
+		yeeloong_lcd_vo_set(BIT_DISPLAY_LCD_ON);
+		break;
+	}
+	return video_output_status;
+}
+
+static int camera_handler(int status)
+{
+	int value;
+
+	value = ec_read(REG_CAMERA_CONTROL);
+	ec_write(REG_CAMERA_CONTROL, value | (1 << 1));
+
+	return status;
+}
+
+static int usb2_handler(int status)
+{
+	pr_emerg("USB2 Over Current occurred\n");
+
+	return status;
+}
+
+static int usb0_handler(int status)
+{
+	pr_emerg("USB0 Over Current occurred\n");
+
+	return status;
+}
+
+static void do_event_action(int event)
+{
+	sci_handler handler;
+	int reg, status;
+	struct key_entry *ke;
+
+	reg = 0;
+	handler = NULL;
+
+	switch (event) {
+	case EVENT_LID:
+		reg = REG_LID_DETECT;
+		break;
+	case EVENT_DISPLAY_TOGGLE:
+		handler = display_toggle_handler;
+		break;
+	case EVENT_CRT_DETECT:
+		reg = REG_CRT_DETECT;
+		handler = crt_detect_handler;
+		break;
+	case EVENT_CAMERA:
+		reg = REG_CAMERA_STATUS;
+		handler = camera_handler;
+		break;
+	case EVENT_USB_OC2:
+		reg = REG_USB2_FLAG;
+		handler = usb2_handler;
+		break;
+	case EVENT_USB_OC0:
+		reg = REG_USB0_FLAG;
+		handler = usb0_handler;
+		break;
+	case EVENT_BLACK_SCREEN:
+		reg = REG_DISPLAY_LCD;
+		handler = black_screen_handler;
+		break;
+	case EVENT_AUDIO_MUTE:
+		reg = REG_AUDIO_MUTE;
+		break;
+	case EVENT_DISPLAY_BRIGHTNESS:
+		reg = REG_DISPLAY_BRIGHTNESS;
+		break;
+	case EVENT_AUDIO_VOLUME:
+		reg = REG_AUDIO_VOLUME;
+		break;
+	default:
+		break;
+	}
+
+	if (reg != 0)
+		status = ec_read(reg);
+
+	if (handler != NULL)
+		status = handler(status);
+
+	pr_info("%s: event: %d status: %d\n", __func__, event, status);
+
+	/* Report current key to user-space */
+	ke = get_event_key_entry(event, status);
+	if (ke) {
+		if (ke->keycode == SW_LID)
+			report_lid_switch(status);
+		else
+			sparse_keymap_report_entry(yeeloong_hotkey_dev, ke, 1,
+					true);
+	}
+}
+
+/*
+ * SCI(system control interrupt) main interrupt routine
+ *
+ * We will do the query and get event number together so the interrupt routine
+ * should be longer than 120us now at least 3ms elpase for it.
+ */
+static irqreturn_t sci_irq_handler(int irq, void *dev_id)
+{
+	int ret, event;
+
+	if (SCI_IRQ_NUM != irq)
+		return IRQ_NONE;
+
+	/* Query the event number */
+	ret = ec_query_event_num();
+	if (ret < 0)
+		return IRQ_NONE;
+
+	event = ec_get_event_num();
+	if (event < EVENT_START || event > EVENT_END)
+		return IRQ_NONE;
+
+	/* Execute corresponding actions */
+	do_event_action(event);
+
+	return IRQ_HANDLED;
+}
+
+/*
+ * Config and init some msr and gpio register properly.
+ */
+static int sci_irq_init(void)
+{
+	u32 hi, lo;
+	u32 gpio_base;
+	unsigned long flags;
+	int ret;
+
+	/* Get gpio base */
+	_rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_GPIO), &hi, &lo);
+	gpio_base = lo & 0xff00;
+
+	/* Filter the former kb3310 interrupt for security */
+	ret = ec_query_event_num();
+	if (ret)
+		return ret;
+
+	/* For filtering next number interrupt */
+	udelay(10000);
+
+	/* Set gpio native registers and msrs for GPIO27 SCI EVENT PIN
+	 * gpio :
+	 *      input, pull-up, no-invert, event-count and value 0,
+	 *      no-filter, no edge mode
+	 *      gpio27 map to Virtual gpio0
+	 * msr :
+	 *      no primary and lpc
+	 *      Unrestricted Z input to IG10 from Virtual gpio 0.
+	 */
+	local_irq_save(flags);
+	_rdmsr(0x80000024, &hi, &lo);
+	lo &= ~(1 << 10);
+	_wrmsr(0x80000024, hi, lo);
+	_rdmsr(0x80000025, &hi, &lo);
+	lo &= ~(1 << 10);
+	_wrmsr(0x80000025, hi, lo);
+	_rdmsr(0x80000023, &hi, &lo);
+	lo |= (0x0a << 0);
+	_wrmsr(0x80000023, hi, lo);
+	local_irq_restore(flags);
+
+	/* Set gpio27 as sci interrupt
+	 *
+	 * input, pull-up, no-fliter, no-negedge, invert
+	 * the sci event is just about 120us
+	 */
+	asm(".set noreorder\n");
+	/*  input enable */
+	outl(0x00000800, (gpio_base | 0xA0));
+	/*  revert the input */
+	outl(0x00000800, (gpio_base | 0xA4));
+	/*  event-int enable */
+	outl(0x00000800, (gpio_base | 0xB8));
+	asm(".set reorder\n");
+
+	return 0;
+}
+
+static struct irqaction sci_irqaction = {
+	.handler = sci_irq_handler,
+	.name = "sci",
+	.flags = IRQF_SHARED,
+};
+
+static int yeeloong_hotkey_init(void)
+{
+	int ret;
+
+	ret = sci_irq_init();
+	if (ret)
+		return -EFAULT;
+
+	ret = setup_irq(SCI_IRQ_NUM, &sci_irqaction);
+	if (ret)
+		return -EFAULT;
+
+	yeeloong_hotkey_dev = input_allocate_device();
+
+	if (!yeeloong_hotkey_dev) {
+		remove_irq(SCI_IRQ_NUM, &sci_irqaction);
+		return -ENOMEM;
+	}
+
+	yeeloong_hotkey_dev->name = "HotKeys";
+	yeeloong_hotkey_dev->phys = "button/input0";
+	yeeloong_hotkey_dev->id.bustype = BUS_HOST;
+	yeeloong_hotkey_dev->dev.parent = NULL;
+
+	ret = sparse_keymap_setup(yeeloong_hotkey_dev, yeeloong_keymap, NULL);
+	if (ret) {
+		pr_err("Fail to setup input device keymap\n");
+		input_free_device(yeeloong_hotkey_dev);
+		return ret;
+	}
+
+	ret = input_register_device(yeeloong_hotkey_dev);
+	if (ret) {
+		sparse_keymap_free(yeeloong_hotkey_dev);
+		input_free_device(yeeloong_hotkey_dev);
+		return ret;
+	}
+
+	/* Update the current status of LID */
+	report_lid_switch(BIT_LID_DETECT_ON);
+
+#ifdef CONFIG_LOONGSON_SUSPEND
+	/* Install the real yeeloong_report_lid_status for pm.c */
+	yeeloong_report_lid_status = report_lid_switch;
+#endif
+
+	return 0;
+}
+
+static void yeeloong_hotkey_exit(void)
+{
+	/* Free irq */
+	remove_irq(SCI_IRQ_NUM, &sci_irqaction);
+
+#ifdef CONFIG_LOONGSON_SUSPEND
+	/* Uninstall yeeloong_report_lid_status for pm.c */
+	if (yeeloong_report_lid_status == report_lid_switch)
+		yeeloong_report_lid_status = NULL;
+#endif
+
+	if (yeeloong_hotkey_dev) {
+		sparse_keymap_free(yeeloong_hotkey_dev);
+		input_unregister_device(yeeloong_hotkey_dev);
+		yeeloong_hotkey_dev = NULL;
+	}
+}
+
 #ifdef CONFIG_PM
 static void usb_ports_set(int status)
 {
@@ -601,11 +995,19 @@ static int __init yeeloong_init(void)
 		return ret;
 	}
 
+	ret = yeeloong_hotkey_init();
+	if (ret) {
+		pr_err("Fail to register yeeloong hotkey driver.\n");
+		yeeloong_hotkey_exit();
+		return ret;
+	}
+
 	return 0;
 }
 
 static void __exit yeeloong_exit(void)
 {
+	yeeloong_hotkey_exit();
 	yeeloong_vo_exit();
 	yeeloong_hwmon_exit();
 	yeeloong_battery_exit();
-- 
1.6.2.1
