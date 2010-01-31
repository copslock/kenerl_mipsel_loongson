Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 31 Jan 2010 13:25:23 +0100 (CET)
Received: from mail-pz0-f203.google.com ([209.85.222.203]:41162 "EHLO
        mail-pz0-f203.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492272Ab0AaMWe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 31 Jan 2010 13:22:34 +0100
Received: by mail-pz0-f203.google.com with SMTP id 41so5404501pzk.0
        for <multiple recipients>; Sun, 31 Jan 2010 04:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=YKMQ0Uw1T8aeivbl2Qtd11L4KehfgP+6S3unp4KGFFU=;
        b=jDPimB9i6cBKRPvDQ6uKulZwQ2ZsfXDhBqamN8geSoNoTjejjPilu0UEAq/akjLyHk
         42I8UkMxAQQJsd3QS9vfYY3ha3HXnhHtYtsi/LwolmiN/Jm+WrraQq1l6/gYH1MsEGZN
         khteJdyQkCB6OJ96qDwNwvwxYcc50rC0xZ0zQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=w0qCe222jih4n4wWNFXIcD97VWou/vKfM2DQ3a+2vpFqT4LwNBSh8rV6trvRgnXPL6
         90/465b0pPV8hNaU5t5Xz97CgHXKNX3ctR5hnC+NhXdwlZ7iDtw70hxotTxnuLL4Qdc/
         4O23DugLJg1+3pRvPR0hFbfWq21EuD3pyVpjs=
Received: by 10.114.28.7 with SMTP id b7mr2143708wab.229.1264940553342;
        Sun, 31 Jan 2010 04:22:33 -0800 (PST)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id 21sm3552209pzk.3.2010.01.31.04.22.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 31 Jan 2010 04:22:32 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Wu Zhangjin <wuzhangjin@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>,
        linux-mips@linux-mips.org, zhangfx@lemote.com
Subject: [PATCH v11 7/9] Loongson: YeeLoong: add input/hotkey driver
Date:   Sun, 31 Jan 2010 20:15:53 +0800
Message-Id: <f4976b3269dc1092ce495f82b4a65062f8a61bda.1264940063.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.6
In-Reply-To: <c9b93c006f7dd475b3781e4917ada1f441edcaa9.1264940063.git.wuzhangjin@gmail.com>
References: <cover.1264940063.git.wuzhangjin@gmail.com>
 <b25d80b0d15f92b93fa3cb70c97c39cfb0d79c16.1264940063.git.wuzhangjin@gmail.com>
 <b1305e7c601d017d8c612c985cc20bb1003620f4.1264940063.git.wuzhangjin@gmail.com>
 <edfa13e4c6c10f97ba984f0fa5b65404a9468cec.1264940063.git.wuzhangjin@gmail.com>
 <d83f0e8948c0552fe26998537d984bf47ef691ae.1264940063.git.wuzhangjin@gmail.com>
 <a3f00c700de6209c22d3e526ef6869814b1483fc.1264940063.git.wuzhangjin@gmail.com>
 <c9b93c006f7dd475b3781e4917ada1f441edcaa9.1264940063.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1264940063.git.wuzhangjin@gmail.com>
References: <cover.1264940063.git.wuzhangjin@gmail.com>
X-archive-position: 25784
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 19723

From: Wu Zhangjin <wuzhangjin@gmail.com>

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
 drivers/platform/mips/yeeloong_laptop.c |  384 +++++++++++++++++++++++++++++++
 2 files changed, 386 insertions(+), 0 deletions(-)

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
index 8abe88d..4008a3f 100644
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
 
@@ -452,6 +458,376 @@ static void yeeloong_vo_exit(void)
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
+static int black_screen_handler(int status)
+{
+	yeeloong_lcd_vo_set(status);
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
@@ -538,11 +914,19 @@ static int __init yeeloong_init(void)
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
1.6.6
