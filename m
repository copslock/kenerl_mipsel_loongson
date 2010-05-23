Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 23 May 2010 16:01:26 +0200 (CEST)
Received: from mail-pv0-f177.google.com ([74.125.83.177]:48634 "EHLO
        mail-pv0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491905Ab0EWN7B (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 23 May 2010 15:59:01 +0200
Received: by mail-pv0-f177.google.com with SMTP id 11so1163083pvg.36
        for <multiple recipients>; Sun, 23 May 2010 06:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=72rWVU6+h5aoP/oBuwlnB552wWR0hlljOo+W9DIbLK0=;
        b=C+Mi3kgcOhlGLTmI6I9fqaV4GrkxV9vDsWkLV1Viei/WWRqzpjcey19aM9ISnfGTcN
         7ClOSPETo4gl4OIh7mh5iqURuFNClnVvqh0FyzAdaGpU+OyTUKsmzR8Z/kxqAhgtAF7U
         cfVoVWSsikR2vGaS4GP5l8kv9TKNPKv5y7Vzw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=S6LdbPv5JIpXaS527zjmO2eeQ+V3gNspinEVrUdgPbm6vDm5ayMBvYNCrr/YWMo9p+
         D8+HEmTLJ9jNpVZn4UqS07miL7zEtt+cUgiSDEX1AGFO6HfmipAQ9Rd/C5XI9bvtmNw5
         Ym7tvGhncp0YqzkddC3iRH9FdW/wmZwz4KXlY=
Received: by 10.115.134.13 with SMTP id l13mr3667195wan.200.1274623140228;
        Sun, 23 May 2010 06:59:00 -0700 (PDT)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id r20sm29067398wam.17.2010.05.23.06.58.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 23 May 2010 06:58:58 -0700 (PDT)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Wu Zhangjin <wuzhangjin@gmail.com>,
        Liu Shiwei <liushiwei@gmail.com>
Subject: [PATCH 8/9] Loongson: YeeLoong: add power_supply based battery driver
Date:   Sun, 23 May 2010 21:58:03 +0800
Message-Id: <41a5ef4e3f7574835b187d4e8225bc0eae23cd7e.1274622624.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <cover.1274622624.git.wuzhangjin@gmail.com>
References: <cover.1274622624.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1274622624.git.wuzhangjin@gmail.com>
References: <cover.1274622624.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26804
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Changes from old revision:

  o Fixes the bugs
  In the old driver, it didn't show the current charging status and reported
  the wrong full charge and voltage value.

    Capacity = Charge_full_last (Dynamic) / Charge_full_design (Fixed)
    Percentage Charge = Charge_now (Dyn-Dynamic) / Charge_full_last (Dynamic)

Based on the old emulated APM battery driver and the power_supply class,
this patch adds a new battery driver.

References:
1. Documentation/power/power_supply_class.txt
2. drivers/power/

Signed-off-by: Liu Shiwei <liushiwei@gmail.com>
Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 drivers/platform/mips/Kconfig           |    1 +
 drivers/platform/mips/yeeloong_laptop.c |  228 +++++++++++++++++++++++++++++++
 2 files changed, 229 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/mips/Kconfig b/drivers/platform/mips/Kconfig
index 01560b0..cdfccea 100644
--- a/drivers/platform/mips/Kconfig
+++ b/drivers/platform/mips/Kconfig
@@ -21,6 +21,7 @@ config LEMOTE_YEELOONG2F
 	select HWMON
 	select VIDEO_OUTPUT_CONTROL
 	select INPUT_SPARSEKMAP
+	select POWER_SUPPLY
 	depends on INPUT
 	help
 	  YeeLoong netbook is a mini laptop made by Lemote, which is basically
diff --git a/drivers/platform/mips/yeeloong_laptop.c b/drivers/platform/mips/yeeloong_laptop.c
index 817e8fc..e321c58 100644
--- a/drivers/platform/mips/yeeloong_laptop.c
+++ b/drivers/platform/mips/yeeloong_laptop.c
@@ -19,6 +19,7 @@
 #include <linux/input/sparse-keymap.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
+#include <linux/power_supply.h>	/* for AC & Battery subdriver */
 
 #include <cs5536/cs5536.h>
 
@@ -330,6 +331,213 @@ static void yeeloong_hwmon_exit(void)
 	}
 }
 
+/* AC & Battery subdriver */
+
+static struct power_supply yeeloong_ac, yeeloong_bat;
+
+#define AC_OFFLINE          0
+#define AC_ONLINE           1
+
+static int yeeloong_get_ac_props(struct power_supply *psy,
+				enum power_supply_property psp,
+				union power_supply_propval *val)
+{
+	switch (psp) {
+	case POWER_SUPPLY_PROP_ONLINE:
+		val->intval = ((ec_read(REG_BAT_POWER)) & BIT_BAT_POWER_ACIN) ?
+			AC_ONLINE : AC_OFFLINE;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static enum power_supply_property yeeloong_ac_props[] = {
+	POWER_SUPPLY_PROP_ONLINE,
+};
+
+static struct power_supply yeeloong_ac = {
+	.name = "yeeloong-ac",
+	.type = POWER_SUPPLY_TYPE_MAINS,
+	.properties = yeeloong_ac_props,
+	.num_properties = ARRAY_SIZE(yeeloong_ac_props),
+	.get_property = yeeloong_get_ac_props,
+};
+
+#define BAT_CAP_CRITICAL 5
+#define BAT_CAP_HIGH     99
+
+static int yeeloong_bat_get_ex_property(enum power_supply_property psp,
+				     union power_supply_propval *val)
+{
+	int bat_in, curr_cap, cap_level, status, charge, health;
+
+	status = ec_read(REG_BAT_STATUS);
+	bat_in = status & BIT_BAT_STATUS_IN;
+	curr_cap = get_bat_info(RELATIVE_CAP);
+	if (status & BIT_BAT_STATUS_FULL)
+		curr_cap = 100;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_PRESENT:
+		val->intval = bat_in;
+		break;
+	case POWER_SUPPLY_PROP_CAPACITY:
+		val->intval = curr_cap;
+		break;
+	case POWER_SUPPLY_PROP_CAPACITY_LEVEL:
+		cap_level = POWER_SUPPLY_CAPACITY_LEVEL_NORMAL;
+		if (status & BIT_BAT_STATUS_LOW) {
+			cap_level = POWER_SUPPLY_CAPACITY_LEVEL_LOW;
+			if (curr_cap <= BAT_CAP_CRITICAL)
+				cap_level =
+					POWER_SUPPLY_CAPACITY_LEVEL_CRITICAL;
+		} else if (status & BIT_BAT_STATUS_FULL) {
+			cap_level = POWER_SUPPLY_CAPACITY_LEVEL_FULL;
+			if (curr_cap >= BAT_CAP_HIGH)
+				cap_level = POWER_SUPPLY_CAPACITY_LEVEL_HIGH;
+		} else if (status & BIT_BAT_STATUS_DESTROY)
+			cap_level = POWER_SUPPLY_CAPACITY_LEVEL_UNKNOWN;
+		val->intval = cap_level;
+		break;
+	case POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW:
+		/* seconds */
+		val->intval = bat_in ? (curr_cap - 3) * 54 + 142 : 0;
+		break;
+	case POWER_SUPPLY_PROP_STATUS:
+		if (!bat_in)
+			charge = POWER_SUPPLY_STATUS_UNKNOWN;
+		else {
+			if (status & BIT_BAT_STATUS_FULL) {
+				val->intval = POWER_SUPPLY_STATUS_FULL;
+				break;
+			}
+
+			charge = ec_read(REG_BAT_CHARGE);
+			if (charge & FLAG_BAT_CHARGE_DISCHARGE)
+				charge = POWER_SUPPLY_STATUS_DISCHARGING;
+			else if (charge & FLAG_BAT_CHARGE_CHARGE)
+				charge = POWER_SUPPLY_STATUS_CHARGING;
+			else
+				charge = POWER_SUPPLY_STATUS_NOT_CHARGING;
+		}
+		val->intval = charge;
+		break;
+	case POWER_SUPPLY_PROP_HEALTH:
+		if (!bat_in) /* no battery present */
+			health = POWER_SUPPLY_HEALTH_UNKNOWN;
+		else { /* Assume it is good */
+			health = POWER_SUPPLY_HEALTH_GOOD;
+			if (status &
+				(BIT_BAT_STATUS_DESTROY | BIT_BAT_STATUS_LOW))
+				health = POWER_SUPPLY_HEALTH_DEAD;
+			if (ec_read(REG_BAT_CHARGE_STATUS) &
+				BIT_BAT_CHARGE_STATUS_OVERTEMP)
+				health = POWER_SUPPLY_HEALTH_OVERHEAT;
+		}
+		val->intval = health;
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_NOW:	/* 1/100(%)*1000 µAh */
+		val->intval = curr_cap * get_bat_info(FULLCHG_CAP) * 10;
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int yeeloong_get_bat_props(struct power_supply *psy,
+				     enum power_supply_property psp,
+				     union power_supply_propval *val)
+{
+	switch (psp) {
+	/* Fixed information */
+	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
+		val->intval = get_bat_info(DESIGN_VOL) * 1000;	/* mV -> µV */
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
+		val->intval = get_bat_info(DESIGN_CAP) * 1000;	/*mAh -> µAh*/
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_FULL:
+		val->intval = get_bat_info(FULLCHG_CAP) * 1000;	/* µAh */
+		break;
+	case POWER_SUPPLY_PROP_MANUFACTURER:
+		val->strval =
+			(ec_read(REG_BAT_VENDOR) == FLAG_BAT_VENDOR_SANYO) ?
+			"SANYO" : "SIMPLO";
+		break;
+	/* Dynamic information */
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		val->intval = get_battery_current() * 1000;	/* mA -> µA */
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		val->intval = get_battery_voltage() * 1000;	/* mV -> µV */
+		break;
+	case POWER_SUPPLY_PROP_TEMP:
+		val->intval = get_battery_temp();	/* Celcius */
+		break;
+	/* Dynamic but relative information */
+	default:
+		return yeeloong_bat_get_ex_property(psp, val);
+	}
+
+	return 0;
+}
+
+static enum power_supply_property yeeloong_bat_props[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN,
+	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
+	POWER_SUPPLY_PROP_CHARGE_FULL,
+	POWER_SUPPLY_PROP_CHARGE_NOW,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_HEALTH,
+	POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW,
+	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_CAPACITY_LEVEL,
+	POWER_SUPPLY_PROP_TEMP,
+	POWER_SUPPLY_PROP_MANUFACTURER,
+};
+
+static struct power_supply yeeloong_bat = {
+	.name = "yeeloong-bat",
+	.type = POWER_SUPPLY_TYPE_BATTERY,
+	.properties = yeeloong_bat_props,
+	.num_properties = ARRAY_SIZE(yeeloong_bat_props),
+	.get_property = yeeloong_get_bat_props,
+};
+
+static int ac_bat_initialized;
+
+static int yeeloong_bat_init(void)
+{
+	int ret;
+
+	ret = power_supply_register(NULL, &yeeloong_ac);
+	if (ret)
+		return ret;
+	ret = power_supply_register(NULL, &yeeloong_bat);
+	if (ret) {
+		power_supply_unregister(&yeeloong_ac);
+		return ret;
+	}
+	ac_bat_initialized = 1;
+
+	return 0;
+}
+
+static void yeeloong_bat_exit(void)
+{
+	ac_bat_initialized = 0;
+
+	power_supply_unregister(&yeeloong_ac);
+	power_supply_unregister(&yeeloong_bat);
+}
+
 /* video output subdriver */
 
 static int lcd_video_output_get(struct output_device *od)
@@ -602,6 +810,15 @@ static int usb0_handler(int status)
 	return status;
 }
 
+static int ac_bat_handler(int status)
+{
+	if (ac_bat_initialized) {
+		power_supply_changed(&yeeloong_ac);
+		power_supply_changed(&yeeloong_bat);
+	}
+	return status;
+}
+
 static void do_event_action(int event)
 {
 	sci_handler handler;
@@ -647,6 +864,9 @@ static void do_event_action(int event)
 	case EVENT_AUDIO_VOLUME:
 		reg = REG_AUDIO_VOLUME;
 		break;
+	case EVENT_AC_BAT:
+		handler = ac_bat_handler;
+		break;
 	default:
 		break;
 	}
@@ -903,6 +1123,13 @@ static int __init yeeloong_init(void)
 		return ret;
 	}
 
+	ret = yeeloong_bat_init();
+	if (ret) {
+		pr_err("Fail to register yeeloong battery driver.\n");
+		yeeloong_bat_exit();
+		return ret;
+	}
+
 	ret = yeeloong_hwmon_init();
 	if (ret) {
 		pr_err("Fail to register yeeloong hwmon driver.\n");
@@ -932,6 +1159,7 @@ static void __exit yeeloong_exit(void)
 	yeeloong_hotkey_exit();
 	yeeloong_vo_exit();
 	yeeloong_hwmon_exit();
+	yeeloong_bat_exit();
 	yeeloong_backlight_exit();
 	platform_driver_unregister(&platform_driver);
 
-- 
1.7.0.4
