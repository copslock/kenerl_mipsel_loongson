Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jan 2014 12:33:12 +0100 (CET)
Received: from mail-ee0-f49.google.com ([74.125.83.49]:37725 "EHLO
        mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823075AbaABLdII3TWT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Jan 2014 12:33:08 +0100
Received: by mail-ee0-f49.google.com with SMTP id c41so6180105eek.22
        for <multiple recipients>; Thu, 02 Jan 2014 03:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=kMAoHIidDE54OWvQcO2aDHJXJAcRktTqLyO8Hi6FIjs=;
        b=L6YYT2EDhpjAIndYUNorWWeywvqXyOxEnekzSkVLreOs469tNMucrUvVuL5RI2QhAw
         WKBZEKEALNA/OWepxY3Ipzg0yQKRAho3BMymfXHCv1GfRXz7UegHrLHcyV+jTV/0KhnQ
         JrIOggA+ugRDJC4NluL1xj9ZzaGlKrnIVfHtW+l/UgRMp6YQAEVBD9bNI5HZdEk0ed0J
         3RM1MbrIZC7OG5vrrEUkzeQvKMxhhQ6Bh6+lBPUn3GYERVuul6zhjH49Yew90rYMINJH
         xW8xcQhCHTzcktgmEDkBd+YBFedWtvGfFFrUqH7tRPPl4bO7n05c7+RNDrSWSWE4yD3p
         Pa4g==
X-Received: by 10.14.87.195 with SMTP id y43mr14908759eee.32.1388662382772;
        Thu, 02 Jan 2014 03:33:02 -0800 (PST)
Received: from linux-samsung700g7a.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by mx.google.com with ESMTPSA id g47sm135219461eeo.19.2014.01.02.03.33.01
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jan 2014 03:33:02 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH] MIPS: BCM47XX: Import LEDs database from OpenWrt
Date:   Thu,  2 Jan 2014 12:32:57 +0100
Message-Id: <1388662377-14450-1-git-send-email-zajec5@gmail.com>
X-Mailer: git-send-email 1.7.10.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38831
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
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


Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
---
 arch/mips/bcm47xx/leds.c |  494 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 494 insertions(+)

diff --git a/arch/mips/bcm47xx/leds.c b/arch/mips/bcm47xx/leds.c
index 6a49d4c..cc141c1 100644
--- a/arch/mips/bcm47xx/leds.c
+++ b/arch/mips/bcm47xx/leds.c
@@ -3,6 +3,334 @@
 #include <linux/leds.h>
 #include <bcm47xx_board.h>
 
+/**************************************************
+ * Database
+ **************************************************/
+
+#define BCM47XX_GPIO_LED(_gpio, _color, _function, _active_low,		\
+			 _default_state)				\
+	{								\
+		.name		= "bcm47xx:" _color ":" _function,	\
+		.gpio		= _gpio,				\
+		.active_low	= _active_low,				\
+		.default_state	= _default_state,			\
+	}
+
+/* Asus */
+
+static const struct gpio_led
+bcm47xx_leds_asus_rtn12[] __initconst = {
+	BCM47XX_GPIO_LED(2, "unk", "power", 1, LEDS_GPIO_DEFSTATE_ON),
+	BCM47XX_GPIO_LED(7, "unk", "wlan", 0, LEDS_GPIO_DEFSTATE_OFF),
+};
+
+static const struct gpio_led
+bcm47xx_leds_asus_rtn16[] __initconst = {
+	BCM47XX_GPIO_LED(1, "blue", "power", 1, LEDS_GPIO_DEFSTATE_ON),
+	BCM47XX_GPIO_LED(7, "blue", "wlan", 0, LEDS_GPIO_DEFSTATE_OFF),
+};
+
+static const struct gpio_led
+bcm47xx_leds_asus_rtn66u[] __initconst = {
+	BCM47XX_GPIO_LED(12, "unk", "power", 1, LEDS_GPIO_DEFSTATE_ON),
+	BCM47XX_GPIO_LED(15, "unk", "usb", 1, LEDS_GPIO_DEFSTATE_OFF),
+};
+
+static const struct gpio_led
+bcm47xx_leds_asus_wl300g[] __initconst = {
+	BCM47XX_GPIO_LED(0, "unk", "power", 1, LEDS_GPIO_DEFSTATE_ON),
+};
+
+static const struct gpio_led
+bcm47xx_leds_asus_wl320ge[] __initconst = {
+	BCM47XX_GPIO_LED(0, "unk", "wlan", 1, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(2, "unk", "power", 1, LEDS_GPIO_DEFSTATE_ON),
+	BCM47XX_GPIO_LED(11, "unk", "link", 1, LEDS_GPIO_DEFSTATE_OFF),
+};
+
+static const struct gpio_led
+bcm47xx_leds_asus_wl330ge[] __initconst = {
+	BCM47XX_GPIO_LED(0, "unk", "power", 1, LEDS_GPIO_DEFSTATE_ON),
+};
+
+static const struct gpio_led
+bcm47xx_leds_asus_wl500gd[] __initconst = {
+	BCM47XX_GPIO_LED(0, "unk", "power", 1, LEDS_GPIO_DEFSTATE_ON),
+};
+
+static const struct gpio_led
+bcm47xx_leds_asus_wl500gpv1[] __initconst = {
+	BCM47XX_GPIO_LED(1, "unk", "power", 1, LEDS_GPIO_DEFSTATE_ON),
+};
+
+static const struct gpio_led
+bcm47xx_leds_asus_wl500gpv2[] __initconst = {
+	BCM47XX_GPIO_LED(0, "unk", "power", 1, LEDS_GPIO_DEFSTATE_ON),
+	BCM47XX_GPIO_LED(1, "unk", "wlan", 1, LEDS_GPIO_DEFSTATE_OFF),
+};
+
+static const struct gpio_led
+bcm47xx_leds_asus_wl500w[] __initconst = {
+	BCM47XX_GPIO_LED(5, "unk", "power", 1, LEDS_GPIO_DEFSTATE_ON),
+};
+
+static const struct gpio_led
+bcm47xx_leds_asus_wl520gc[] __initconst = {
+	BCM47XX_GPIO_LED(0, "unk", "power", 1, LEDS_GPIO_DEFSTATE_ON),
+	BCM47XX_GPIO_LED(1, "unk", "wlan", 1, LEDS_GPIO_DEFSTATE_OFF),
+};
+
+static const struct gpio_led
+bcm47xx_leds_asus_wl520gu[] __initconst = {
+	BCM47XX_GPIO_LED(0, "unk", "power", 1, LEDS_GPIO_DEFSTATE_ON),
+	BCM47XX_GPIO_LED(1, "unk", "wlan", 1, LEDS_GPIO_DEFSTATE_OFF),
+};
+
+static const struct gpio_led
+bcm47xx_leds_asus_wl700ge[] __initconst = {
+	BCM47XX_GPIO_LED(1, "unk", "power", 1, LEDS_GPIO_DEFSTATE_ON), /* Labeled "READY" (there is no "power" LED). Originally ON, flashing on USB activity. */
+};
+
+static const struct gpio_led
+bcm47xx_leds_asus_wlhdd[] __initconst = {
+	BCM47XX_GPIO_LED(0, "unk", "power", 1, LEDS_GPIO_DEFSTATE_ON),
+	BCM47XX_GPIO_LED(2, "unk", "usb", 1, LEDS_GPIO_DEFSTATE_OFF),
+};
+
+/* Belkin */
+
+static const struct gpio_led
+bcm47xx_leds_belkin_f7d4301[] __initconst = {
+	BCM47XX_GPIO_LED(10, "green", "power", 1, LEDS_GPIO_DEFSTATE_ON),
+	BCM47XX_GPIO_LED(11, "amber", "power", 1, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(12, "unk", "wps", 1, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(13, "unk", "wlan", 1, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(14, "unk", "usb0", 1, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(15, "unk", "usb1", 1, LEDS_GPIO_DEFSTATE_OFF),
+};
+
+/* Buffalo */
+
+static const struct gpio_led
+bcm47xx_leds_buffalo_whr2_a54g54[] __initconst = {
+	BCM47XX_GPIO_LED(7, "unk", "diag", 1, LEDS_GPIO_DEFSTATE_OFF),
+};
+
+static const struct gpio_led
+bcm47xx_leds_buffalo_whr_g125[] __initconst = {
+	BCM47XX_GPIO_LED(1, "unk", "bridge", 1, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(2, "unk", "wlan", 1, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(3, "unk", "internal", 1, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(6, "unk", "wps", 1, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(7, "unk", "diag", 1, LEDS_GPIO_DEFSTATE_OFF),
+};
+
+static const struct gpio_led
+bcm47xx_leds_buffalo_whr_g54s[] __initconst = {
+	BCM47XX_GPIO_LED(1, "unk", "bridge", 1, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(2, "unk", "wlan", 1, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(3, "unk", "internal", 1, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(6, "unk", "wps", 1, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(7, "unk", "diag", 1, LEDS_GPIO_DEFSTATE_OFF),
+};
+
+static const struct gpio_led
+bcm47xx_leds_buffalo_whr_hp_g54[] __initconst = {
+	BCM47XX_GPIO_LED(1, "unk", "bridge", 1, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(2, "unk", "wlan", 1, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(3, "unk", "internal", 1, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(6, "unk", "wps", 1, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(7, "unk", "diag", 1, LEDS_GPIO_DEFSTATE_OFF),
+};
+
+static const struct gpio_led
+bcm47xx_leds_buffalo_wzr_g300n[] __initconst = {
+	BCM47XX_GPIO_LED(1, "unk", "bridge", 1, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(6, "unk", "wps", 1, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(7, "unk", "diag", 1, LEDS_GPIO_DEFSTATE_OFF),
+};
+
+static const struct gpio_led
+bcm47xx_leds_buffalo_wzr_rs_g54[] __initconst = {
+	BCM47XX_GPIO_LED(6, "unk", "wps", 1, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(1, "unk", "vpn", 1, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(7, "unk", "diag", 1, LEDS_GPIO_DEFSTATE_OFF),
+};
+
+static const struct gpio_led
+bcm47xx_leds_buffalo_wzr_rs_g54hp[] __initconst = {
+	BCM47XX_GPIO_LED(6, "unk", "wps", 1, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(1, "unk", "vpn", 1, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(7, "unk", "diag", 1, LEDS_GPIO_DEFSTATE_OFF),
+};
+
+/* Dell */
+
+static const struct gpio_led
+bcm47xx_leds_dell_tm2300[] __initconst = {
+	BCM47XX_GPIO_LED(6, "unk", "wlan", 1, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(7, "unk", "power", 1, LEDS_GPIO_DEFSTATE_ON),
+};
+
+/* D-Link */
+
+static const struct gpio_led
+bcm47xx_leds_dlink_dir130[] __initconst = {
+	BCM47XX_GPIO_LED(0, "green", "status", 1, LEDS_GPIO_DEFSTATE_OFF), /* Originally blinking when device is ready, separated from "power" LED */
+	BCM47XX_GPIO_LED(6, "blue", "unk", 1, LEDS_GPIO_DEFSTATE_OFF),
+};
+
+static const struct gpio_led
+bcm47xx_leds_dlink_dir330[] __initconst = {
+	BCM47XX_GPIO_LED(0, "green", "status", 1, LEDS_GPIO_DEFSTATE_OFF), /* Originally blinking when device is ready, separated from "power" LED */
+	BCM47XX_GPIO_LED(4, "unk", "usb", 1, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(6, "blue", "unk", 1, LEDS_GPIO_DEFSTATE_OFF),
+};
+
+/* Huawei */
+
+static const struct gpio_led
+bcm47xx_leds_huawei_e970[] __initconst = {
+	BCM47XX_GPIO_LED(0, "unk", "wlan", 0, LEDS_GPIO_DEFSTATE_OFF),
+};
+
+/* Linksys */
+
+static const struct gpio_led
+bcm47xx_leds_linksys_e1000v1[] __initconst = {
+	BCM47XX_GPIO_LED(0, "blue", "wlan", 0, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(1, "blue", "power", 0, LEDS_GPIO_DEFSTATE_ON),
+	BCM47XX_GPIO_LED(2, "amber", "wps", 1, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(4, "blue", "wps", 1, LEDS_GPIO_DEFSTATE_OFF),
+};
+
+static const struct gpio_led
+bcm47xx_leds_linksys_e1000v21[] __initconst = {
+	BCM47XX_GPIO_LED(5, "unk", "wlan", 0, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(6, "unk", "power", 1, LEDS_GPIO_DEFSTATE_ON),
+	BCM47XX_GPIO_LED(7, "amber", "wps", 0, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(8, "blue", "wps", 0, LEDS_GPIO_DEFSTATE_OFF),
+};
+
+static const struct gpio_led
+bcm47xx_leds_linksys_e2000v1[] __initconst = {
+	BCM47XX_GPIO_LED(1, "blue", "wlan", 0, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(2, "blue", "power", 0, LEDS_GPIO_DEFSTATE_ON),
+	BCM47XX_GPIO_LED(3, "blue", "wps", 1, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(4, "amber", "wps", 1, LEDS_GPIO_DEFSTATE_OFF),
+};
+
+static const struct gpio_led
+bcm47xx_leds_linksys_e3000v1[] __initconst = {
+	BCM47XX_GPIO_LED(0, "amber", "wps", 1, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(1, "unk", "wlan", 0, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(3, "blue", "wps", 1, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(5, "unk", "power", 0, LEDS_GPIO_DEFSTATE_ON),
+	BCM47XX_GPIO_LED(7, "unk", "usb", 0, LEDS_GPIO_DEFSTATE_OFF),
+};
+
+static const struct gpio_led
+bcm47xx_leds_linksys_e3200v1[] __initconst = {
+	BCM47XX_GPIO_LED(3, "green", "power", 1, LEDS_GPIO_DEFSTATE_ON),
+};
+
+static const struct gpio_led
+bcm47xx_leds_linksys_e4200v1[] __initconst = {
+	BCM47XX_GPIO_LED(5, "white", "power", 1, LEDS_GPIO_DEFSTATE_ON),
+};
+
+static const struct gpio_led
+bcm47xx_leds_linksys_wrt150nv1[] __initconst = {
+	BCM47XX_GPIO_LED(1, "unk", "power", 0, LEDS_GPIO_DEFSTATE_ON),
+	BCM47XX_GPIO_LED(3, "amber", "wps", 1, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(5, "green", "wps", 1, LEDS_GPIO_DEFSTATE_OFF),
+};
+
+static const struct gpio_led
+bcm47xx_leds_linksys_wrt150nv11[] __initconst = {
+	BCM47XX_GPIO_LED(1, "unk", "power", 0, LEDS_GPIO_DEFSTATE_ON),
+	BCM47XX_GPIO_LED(3, "amber", "wps", 1, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(5, "green", "wps", 1, LEDS_GPIO_DEFSTATE_OFF),
+};
+
+static const struct gpio_led
+bcm47xx_leds_linksys_wrt160nv1[] __initconst = {
+	BCM47XX_GPIO_LED(1, "unk", "power", 0, LEDS_GPIO_DEFSTATE_ON),
+	BCM47XX_GPIO_LED(3, "amber", "wps", 1, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(5, "blue", "wps", 1, LEDS_GPIO_DEFSTATE_OFF),
+};
+
+static const struct gpio_led
+bcm47xx_leds_linksys_wrt160nv3[] __initconst = {
+	BCM47XX_GPIO_LED(1, "unk", "power", 0, LEDS_GPIO_DEFSTATE_ON),
+	BCM47XX_GPIO_LED(2, "amber", "wps", 1, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(4, "blue", "wps", 1, LEDS_GPIO_DEFSTATE_OFF),
+};
+
+static const struct gpio_led
+bcm47xx_leds_linksys_wrt300nv11[] __initconst = {
+	BCM47XX_GPIO_LED(1, "unk", "power", 0, LEDS_GPIO_DEFSTATE_ON),
+	BCM47XX_GPIO_LED(3, "amber", "wps", 1, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(5, "green", "wps", 1, LEDS_GPIO_DEFSTATE_OFF),
+};
+
+static const struct gpio_led
+bcm47xx_leds_linksys_wrt310nv1[] __initconst = {
+	BCM47XX_GPIO_LED(1, "blue", "power", 0, LEDS_GPIO_DEFSTATE_ON),
+	BCM47XX_GPIO_LED(3, "amber", "wps", 1, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(9, "blue", "wps", 1, LEDS_GPIO_DEFSTATE_OFF),
+};
+
+static const struct gpio_led
+bcm47xx_leds_linksys_wrt610nv1[] __initconst = {
+	BCM47XX_GPIO_LED(0, "unk", "usb",  1, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(1, "unk", "power",  0, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(3, "amber", "wps",  1, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(9, "blue", "wps",  1, LEDS_GPIO_DEFSTATE_OFF),
+};
+
+static const struct gpio_led
+bcm47xx_leds_linksys_wrt610nv2[] __initconst = {
+	BCM47XX_GPIO_LED(0, "amber", "wps", 1, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(1, "unk", "wlan", 0, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(3, "blue", "wps", 1, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(5, "unk", "power", 0, LEDS_GPIO_DEFSTATE_ON),
+	BCM47XX_GPIO_LED(7, "unk", "usb", 0, LEDS_GPIO_DEFSTATE_OFF),
+};
+
+/* Motorola */
+
+static const struct gpio_led
+bcm47xx_leds_motorola_we800g[] __initconst = {
+	BCM47XX_GPIO_LED(1, "amber", "wlan", 0, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(2, "unk", "unk", 1, LEDS_GPIO_DEFSTATE_OFF), /* There are only 3 LEDs: Power, Wireless and Device (ethernet) */
+	BCM47XX_GPIO_LED(4, "green", "power", 0, LEDS_GPIO_DEFSTATE_ON),
+};
+
+static const struct gpio_led
+bcm47xx_leds_motorola_wr850gp[] __initconst = {
+	BCM47XX_GPIO_LED(0, "unk", "wlan", 1, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(1, "unk", "power", 0, LEDS_GPIO_DEFSTATE_ON),
+	BCM47XX_GPIO_LED(6, "unk", "dmz", 1, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(7, "unk", "diag", 1, LEDS_GPIO_DEFSTATE_OFF),
+};
+
+static const struct gpio_led
+bcm47xx_leds_motorola_wr850gv2v3[] __initconst = {
+	BCM47XX_GPIO_LED(0, "unk", "wlan", 1, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(1, "unk", "power", 0, LEDS_GPIO_DEFSTATE_ON),
+	BCM47XX_GPIO_LED(7, "unk", "diag", 1, LEDS_GPIO_DEFSTATE_OFF),
+};
+
+/* Netgear */
+
+static const struct gpio_led
+bcm47xx_leds_netgear_wndr3400v1[] __initconst = {
+	BCM47XX_GPIO_LED(2, "green", "usb", 1, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(3, "green", "power", 0, LEDS_GPIO_DEFSTATE_ON),
+	BCM47XX_GPIO_LED(7, "amber", "power", 0, LEDS_GPIO_DEFSTATE_OFF),
+};
+
 static const struct gpio_led
 bcm47xx_leds_netgear_wndr4500_v1_leds[] __initconst = {
 	{
@@ -49,6 +377,24 @@ bcm47xx_leds_netgear_wndr4500_v1_leds[] __initconst = {
 	},
 };
 
+static const struct gpio_led
+bcm47xx_leds_netgear_wnr834bv2[] __initconst = {
+	BCM47XX_GPIO_LED(2, "green", "power", 0, LEDS_GPIO_DEFSTATE_ON),
+	BCM47XX_GPIO_LED(3, "amber", "power", 0, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(7, "unk", "connected", 0, LEDS_GPIO_DEFSTATE_OFF),
+};
+
+/* SimpleTech */
+
+static const struct gpio_led
+bcm47xx_leds_simpletech_simpleshare[] __initconst = {
+	BCM47XX_GPIO_LED(1, "unk", "status", 1, LEDS_GPIO_DEFSTATE_OFF), /* "Ready" LED */
+};
+
+/**************************************************
+ * Init
+ **************************************************/
+
 static struct gpio_led_platform_data bcm47xx_leds_pdata;
 
 #define bcm47xx_set_pdata(dev_leds) do {				\
@@ -61,9 +407,157 @@ void __init bcm47xx_leds_register(void)
 	enum bcm47xx_board board = bcm47xx_board_get();
 
 	switch (board) {
+	case BCM47XX_BOARD_ASUS_RTN12:
+		bcm47xx_set_pdata(bcm47xx_leds_asus_rtn12);
+		break;
+	case BCM47XX_BOARD_ASUS_RTN16:
+		bcm47xx_set_pdata(bcm47xx_leds_asus_rtn16);
+		break;
+	case BCM47XX_BOARD_ASUS_RTN66U:
+		bcm47xx_set_pdata(bcm47xx_leds_asus_rtn66u);
+		break;
+	case BCM47XX_BOARD_ASUS_WL300G:
+		bcm47xx_set_pdata(bcm47xx_leds_asus_wl300g);
+		break;
+	case BCM47XX_BOARD_ASUS_WL320GE:
+		bcm47xx_set_pdata(bcm47xx_leds_asus_wl320ge);
+		break;
+	case BCM47XX_BOARD_ASUS_WL330GE:
+		bcm47xx_set_pdata(bcm47xx_leds_asus_wl330ge);
+		break;
+	case BCM47XX_BOARD_ASUS_WL500GD:
+		bcm47xx_set_pdata(bcm47xx_leds_asus_wl500gd);
+		break;
+	case BCM47XX_BOARD_ASUS_WL500GPV1:
+		bcm47xx_set_pdata(bcm47xx_leds_asus_wl500gpv1);
+		break;
+	case BCM47XX_BOARD_ASUS_WL500GPV2:
+		bcm47xx_set_pdata(bcm47xx_leds_asus_wl500gpv2);
+		break;
+	case BCM47XX_BOARD_ASUS_WL500W:
+		bcm47xx_set_pdata(bcm47xx_leds_asus_wl500w);
+		break;
+	case BCM47XX_BOARD_ASUS_WL520GC:
+		bcm47xx_set_pdata(bcm47xx_leds_asus_wl520gc);
+		break;
+	case BCM47XX_BOARD_ASUS_WL520GU:
+		bcm47xx_set_pdata(bcm47xx_leds_asus_wl520gu);
+		break;
+	case BCM47XX_BOARD_ASUS_WL700GE:
+		bcm47xx_set_pdata(bcm47xx_leds_asus_wl700ge);
+		break;
+	case BCM47XX_BOARD_ASUS_WLHDD:
+		bcm47xx_set_pdata(bcm47xx_leds_asus_wlhdd);
+		break;
+
+	case BCM47XX_BOARD_BELKIN_F7D4301:
+		bcm47xx_set_pdata(bcm47xx_leds_belkin_f7d4301);
+		break;
+
+	case BCM47XX_BOARD_BUFFALO_WHR2_A54G54:
+		bcm47xx_set_pdata(bcm47xx_leds_buffalo_whr2_a54g54);
+		break;
+	case BCM47XX_BOARD_BUFFALO_WHR_G125:
+		bcm47xx_set_pdata(bcm47xx_leds_buffalo_whr_g125);
+		break;
+	case BCM47XX_BOARD_BUFFALO_WHR_G54S:
+		bcm47xx_set_pdata(bcm47xx_leds_buffalo_whr_g54s);
+		break;
+	case BCM47XX_BOARD_BUFFALO_WHR_HP_G54:
+		bcm47xx_set_pdata(bcm47xx_leds_buffalo_whr_hp_g54);
+		break;
+	case BCM47XX_BOARD_BUFFALO_WZR_G300N:
+		bcm47xx_set_pdata(bcm47xx_leds_buffalo_wzr_g300n);
+		break;
+	case BCM47XX_BOARD_BUFFALO_WZR_RS_G54:
+		bcm47xx_set_pdata(bcm47xx_leds_buffalo_wzr_rs_g54);
+		break;
+	case BCM47XX_BOARD_BUFFALO_WZR_RS_G54HP:
+		bcm47xx_set_pdata(bcm47xx_leds_buffalo_wzr_rs_g54hp);
+		break;
+
+	case BCM47XX_BOARD_DELL_TM2300:
+		bcm47xx_set_pdata(bcm47xx_leds_dell_tm2300);
+		break;
+
+	case BCM47XX_BOARD_DLINK_DIR130:
+		bcm47xx_set_pdata(bcm47xx_leds_dlink_dir130);
+		break;
+	case BCM47XX_BOARD_DLINK_DIR330:
+		bcm47xx_set_pdata(bcm47xx_leds_dlink_dir330);
+		break;
+
+	case BCM47XX_BOARD_HUAWEI_E970:
+		bcm47xx_set_pdata(bcm47xx_leds_huawei_e970);
+		break;
+
+	case BCM47XX_BOARD_LINKSYS_E1000V1:
+		bcm47xx_set_pdata(bcm47xx_leds_linksys_e1000v1);
+		break;
+	case BCM47XX_BOARD_LINKSYS_E1000V21:
+		bcm47xx_set_pdata(bcm47xx_leds_linksys_e1000v21);
+		break;
+	case BCM47XX_BOARD_LINKSYS_E2000V1:
+		bcm47xx_set_pdata(bcm47xx_leds_linksys_e2000v1);
+		break;
+	case BCM47XX_BOARD_LINKSYS_E3000V1:
+		bcm47xx_set_pdata(bcm47xx_leds_linksys_e3000v1);
+		break;
+	case BCM47XX_BOARD_LINKSYS_E3200V1:
+		bcm47xx_set_pdata(bcm47xx_leds_linksys_e3200v1);
+		break;
+	case BCM47XX_BOARD_LINKSYS_E4200V1:
+		bcm47xx_set_pdata(bcm47xx_leds_linksys_e4200v1);
+		break;
+	case BCM47XX_BOARD_LINKSYS_WRT150NV1:
+		bcm47xx_set_pdata(bcm47xx_leds_linksys_wrt150nv1);
+		break;
+	case BCM47XX_BOARD_LINKSYS_WRT150NV11:
+		bcm47xx_set_pdata(bcm47xx_leds_linksys_wrt150nv11);
+		break;
+	case BCM47XX_BOARD_LINKSYS_WRT160NV1:
+		bcm47xx_set_pdata(bcm47xx_leds_linksys_wrt160nv1);
+		break;
+	case BCM47XX_BOARD_LINKSYS_WRT160NV3:
+		bcm47xx_set_pdata(bcm47xx_leds_linksys_wrt160nv3);
+		break;
+	case BCM47XX_BOARD_LINKSYS_WRT300NV11:
+		bcm47xx_set_pdata(bcm47xx_leds_linksys_wrt300nv11);
+		break;
+	case BCM47XX_BOARD_LINKSYS_WRT310NV1:
+		bcm47xx_set_pdata(bcm47xx_leds_linksys_wrt310nv1);
+		break;
+	case BCM47XX_BOARD_LINKSYS_WRT610NV1:
+		bcm47xx_set_pdata(bcm47xx_leds_linksys_wrt610nv1);
+		break;
+	case BCM47XX_BOARD_LINKSYS_WRT610NV2:
+		bcm47xx_set_pdata(bcm47xx_leds_linksys_wrt610nv2);
+		break;
+
+	case BCM47XX_BOARD_MOTOROLA_WE800G:
+		bcm47xx_set_pdata(bcm47xx_leds_motorola_we800g);
+		break;
+	case BCM47XX_BOARD_MOTOROLA_WR850GP:
+		bcm47xx_set_pdata(bcm47xx_leds_motorola_wr850gp);
+		break;
+	case BCM47XX_BOARD_MOTOROLA_WR850GV2V3:
+		bcm47xx_set_pdata(bcm47xx_leds_motorola_wr850gv2v3);
+		break;
+
+	case BCM47XX_BOARD_NETGEAR_WNDR3400V1:
+		bcm47xx_set_pdata(bcm47xx_leds_netgear_wndr3400v1);
+		break;
 	case BCM47XX_BOARD_NETGEAR_WNDR4500V1:
 		bcm47xx_set_pdata(bcm47xx_leds_netgear_wndr4500_v1_leds);
 		break;
+	case BCM47XX_BOARD_NETGEAR_WNR834BV2:
+		bcm47xx_set_pdata(bcm47xx_leds_netgear_wnr834bv2);
+		break;
+
+	case BCM47XX_BOARD_SIMPLETECH_SIMPLESHARE:
+		bcm47xx_set_pdata(bcm47xx_leds_simpletech_simpleshare);
+		break;
+
 	default:
 		pr_debug("No LEDs configuration found for this device\n");
 		return;
-- 
1.7.10.4
