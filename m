Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 23 May 2010 16:01:00 +0200 (CEST)
Received: from mail-pv0-f177.google.com ([74.125.83.177]:48634 "EHLO
        mail-pv0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491904Ab0EWN65 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 23 May 2010 15:58:57 +0200
Received: by mail-pv0-f177.google.com with SMTP id 11so1163083pvg.36
        for <multiple recipients>; Sun, 23 May 2010 06:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=MGhSOIQkR45XLrn/ZDyRiDd0LSlvziP0jDz4TSOv4Cs=;
        b=XBLJt8/ZD6SlG0OCC8jXkkCjsdnx1slMn9CD3FqGmTa/d4l8Zc/BV9QrqgwSk6EfmD
         nc+8dTAKL2sx/AWEzdENuz48AhESpa6E4cyInd36jXKmnFhEC2oyFI6+ittlHowFg33N
         2Myz4TcfvTI7+bPNnJQsbVcYbu1VVyYN/0v/c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=qH8IRzFy9EpER5VL5iEJqY9uWNIIsLllqbKxkc6D/RzuGS6bb8hffMyujwdbRrt879
         QoVmAHNOpdaIDSr+Ymr50ohDoSIrBuIQ1RMWXlhGxGmYfqo49WlW1qQJctbX3cjS9K1p
         7IQagUCAQ/vAb5Sy2EPf1F+SRNtw6eqKthjAI=
Received: by 10.115.64.32 with SMTP id r32mr3696301wak.15.1274623135833;
        Sun, 23 May 2010 06:58:55 -0700 (PDT)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id r20sm29067398wam.17.2010.05.23.06.58.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 23 May 2010 06:58:54 -0700 (PDT)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH 7/9] Loongson: YeeLoong: add input/hotkey driver
Date:   Sun, 23 May 2010 21:58:02 +0800
Message-Id: <4902378cca6c73ec6549d6f142c34752ff695e0d.1274622624.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <cover.1274622624.git.wuzhangjin@gmail.com>
References: <cover.1274622624.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1274622624.git.wuzhangjin@gmail.com>
References: <cover.1274622624.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26803
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Changes from v10 8/8:

  o Split the EC related code out into the next patch.

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
 drivers/platform/mips/Kconfig           |    2 +
 drivers/platform/mips/yeeloong_laptop.c |  385 +++++++++++++++++++++++++++++++
 2 files changed, 387 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/mips/Kconfig b/drivers/platform/mips/Kconfig
index e1285f7..01560b0 100644
--- a/drivers/platform/mips/Kconfig
+++ b/drivers/platform/mips/Kconfig
@@ -20,6 +20,8 @@ config LEMOTE_YEELOONG2F
 	select BACKLIGHT_CLASS_DEVICE
 	select HWMON
 	select VIDEO_OUTPUT_CONTROL
+	select INPUT_SPARSEKMAP
+	depends on INPUT
 	help
 	  YeeLoong netbook is a mini laptop made by Lemote, which is basically
 	  compatible to FuLoong2F mini PC, but it has an extra Embedded
diff --git a/drivers/platform/mips/yeeloong_laptop.c b/drivers/platform/mips/yeeloong_laptop.c
index 16e34e8..817e8fc 100644
--- a/drivers/platform/mips/yeeloong_laptop.c
+++ b/drivers/platform/mips/yeeloong_laptop.c
@@ -15,6 +15,12 @@
 #include <linux/hwmon.h>	/* for hwmon subdriver */
 #include <linux/hwmon-sysfs.h>
 #include <linux/video_output.h>	/* for video output subdriver */
+#include <linux/input.h>	/* for hotkey subdriver */
+#include <linux/input/sparse-keymap.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+
+#include <cs5536/cs5536.h>
 
 #include <ec_kb3310b.h>
 
@@ -454,6 +460,377 @@ static void yeeloong_vo_exit(void)
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
+	{KE_KEY, EVENT_DISPLAYTOGGLE, { KEY_DISPLAYTOGGLE } }, /* Fn + F2 */
+	{KE_KEY, EVENT_SWITCHVIDEOMODE, { KEY_SWITCHVIDEOMODE } }, /* Fn + F3 */
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
+static int displaytoggle_handler(int status)
+{
+	yeeloong_lcd_vo_set(status);
+
+	return status;
+}
+
+static int switchvideomode_handler(int status)
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
+	case EVENT_SWITCHVIDEOMODE:
+		handler = switchvideomode_handler;
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
+	case EVENT_DISPLAYTOGGLE:
+		reg = REG_DISPLAY_LCD;
+		handler = displaytoggle_handler;
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
@@ -540,11 +917,19 @@ static int __init yeeloong_init(void)
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
 	yeeloong_backlight_exit();
-- 
1.7.0.4
