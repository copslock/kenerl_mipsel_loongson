Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jan 2014 13:38:11 +0100 (CET)
Received: from mail-ee0-f47.google.com ([74.125.83.47]:60122 "EHLO
        mail-ee0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6824805AbaABMiHc0uYY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Jan 2014 13:38:07 +0100
Received: by mail-ee0-f47.google.com with SMTP id e51so5353057eek.34
        for <multiple recipients>; Thu, 02 Jan 2014 04:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=zejkoUAhG0PbTy90NRTLWfo5LJM9cwGwEPabFbR3SJQ=;
        b=jsmpBf0QgKd6+xvstLol14fQbBjixppgqdJUWVH787AxUmC3Wk0ZlVZkpnXYdJ7qBq
         zjeaKEQ6z9zab7Af17NaB2ACPSL2fItaG3Y7uPvnK7sI9l/JwLmOeuvsbgthNQwBHgKA
         KpVByBFOhDx6qtA5gNiGTrYdkqkUx03Cl1RCBmfM9mpjfN/o948xoD92p9R48REgTWVe
         YkBotT7CteRHARFBhaSts2ea5DNKOwd60yJZe1gKkVbThowIGjVXAG8wztT+JF193+DP
         gNC81QtDkkdfxDtN7DjKQ2umSWEdJ6sdI0MKz3nrceeVQmO+5ZAh71RM6xk1VeM5+g2c
         QRlg==
X-Received: by 10.14.199.197 with SMTP id x45mr68644328een.8.1388666282230;
        Thu, 02 Jan 2014 04:38:02 -0800 (PST)
Received: from linux-samsung700g7a.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by mx.google.com with ESMTPSA id g7sm135706323eet.12.2014.01.02.04.38.00
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jan 2014 04:38:01 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH V2] MIPS: BCM47XX: Import buttons database from OpenWrt
Date:   Thu,  2 Jan 2014 13:37:56 +0100
Message-Id: <1388666276-12927-1-git-send-email-zajec5@gmail.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1388595739-14872-1-git-send-email-zajec5@gmail.com>
References: <1388595739-14872-1-git-send-email-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38834
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

This includes all devices from OpenWrt's "diag" that we support in arch
code (we have entries for in enum bcm47xx_board).

Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
---
V2: Use "const" for every "__initconst"
    Rebase on top of [PATCH V4] MIPS: BCM47XX: Prepare support for GPIO buttons
---
 arch/mips/bcm47xx/buttons.c |  456 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 456 insertions(+)

diff --git a/arch/mips/bcm47xx/buttons.c b/arch/mips/bcm47xx/buttons.c
index d93711b..13f8e41 100644
--- a/arch/mips/bcm47xx/buttons.c
+++ b/arch/mips/bcm47xx/buttons.c
@@ -11,6 +11,299 @@
  * Database
  **************************************************/
 
+#define BCM47XX_GPIO_KEY(_gpio, _code)					\
+	{								\
+		.code		= _code,				\
+		.gpio		= _gpio,				\
+		.active_low	= 1,					\
+	}
+
+/* Asus */
+
+static const struct gpio_keys_button
+bcm47xx_buttons_asus_rtn12[] __initconst = {
+	BCM47XX_GPIO_KEY(0, KEY_WPS_BUTTON),
+	BCM47XX_GPIO_KEY(1, KEY_RESTART),
+	BCM47XX_GPIO_KEY(4, BTN_0), /* Router mode */
+	BCM47XX_GPIO_KEY(5, BTN_1), /* Repeater mode */
+	BCM47XX_GPIO_KEY(6, BTN_2), /* AP mode */
+};
+
+static const struct gpio_keys_button
+bcm47xx_buttons_asus_rtn16[] __initconst = {
+	BCM47XX_GPIO_KEY(6, KEY_WPS_BUTTON),
+	BCM47XX_GPIO_KEY(8, KEY_RESTART),
+};
+
+static const struct gpio_keys_button
+bcm47xx_buttons_asus_rtn66u[] __initconst = {
+	BCM47XX_GPIO_KEY(4, KEY_WPS_BUTTON),
+	BCM47XX_GPIO_KEY(9, KEY_RESTART),
+};
+
+static const struct gpio_keys_button
+bcm47xx_buttons_asus_wl300g[] __initconst = {
+	BCM47XX_GPIO_KEY(6, KEY_RESTART),
+};
+
+static const struct gpio_keys_button
+bcm47xx_buttons_asus_wl320ge[] __initconst = {
+	BCM47XX_GPIO_KEY(6, KEY_RESTART),
+};
+
+static const struct gpio_keys_button
+bcm47xx_buttons_asus_wl330ge[] __initconst = {
+	BCM47XX_GPIO_KEY(2, KEY_RESTART),
+};
+
+static const struct gpio_keys_button
+bcm47xx_buttons_asus_wl500gd[] __initconst = {
+	BCM47XX_GPIO_KEY(6, KEY_RESTART),
+};
+
+static const struct gpio_keys_button
+bcm47xx_buttons_asus_wl500gpv1[] __initconst = {
+	BCM47XX_GPIO_KEY(0, KEY_RESTART),
+	BCM47XX_GPIO_KEY(4, KEY_WPS_BUTTON),
+};
+
+static const struct gpio_keys_button
+bcm47xx_buttons_asus_wl500gpv2[] __initconst = {
+	BCM47XX_GPIO_KEY(2, KEY_RESTART),
+	BCM47XX_GPIO_KEY(3, KEY_WPS_BUTTON),
+};
+
+static const struct gpio_keys_button
+bcm47xx_buttons_asus_wl500w[] __initconst = {
+	BCM47XX_GPIO_KEY(6, KEY_RESTART),
+	BCM47XX_GPIO_KEY(7, KEY_WPS_BUTTON),
+};
+
+static const struct gpio_keys_button
+bcm47xx_buttons_asus_wl520gc[] __initconst = {
+	BCM47XX_GPIO_KEY(2, KEY_RESTART),
+	BCM47XX_GPIO_KEY(3, KEY_WPS_BUTTON),
+};
+
+static const struct gpio_keys_button
+bcm47xx_buttons_asus_wl520gu[] __initconst = {
+	BCM47XX_GPIO_KEY(2, KEY_RESTART),
+	BCM47XX_GPIO_KEY(3, KEY_WPS_BUTTON),
+};
+
+static const struct gpio_keys_button
+bcm47xx_buttons_asus_wl700ge[] __initconst = {
+	BCM47XX_GPIO_KEY(0, KEY_POWER), /* Hard disk power switch */
+	BCM47XX_GPIO_KEY(4, KEY_WPS_BUTTON), /* EZSetup */
+	BCM47XX_GPIO_KEY(6, KEY_COPY), /* Copy data from USB to internal disk */
+	BCM47XX_GPIO_KEY(7, KEY_RESTART), /* Hard reset */
+};
+
+static const struct gpio_keys_button
+bcm47xx_buttons_asus_wlhdd[] __initconst = {
+	BCM47XX_GPIO_KEY(6, KEY_RESTART),
+};
+
+/* Huawei */
+
+static const struct gpio_keys_button
+bcm47xx_buttons_huawei_e970[] __initconst = {
+	BCM47XX_GPIO_KEY(6, KEY_RESTART),
+};
+
+/* Belkin */
+
+static const struct gpio_keys_button
+bcm47xx_buttons_belkin_f7d4301[] __initconst = {
+	BCM47XX_GPIO_KEY(6, KEY_RESTART),
+	BCM47XX_GPIO_KEY(8, KEY_WPS_BUTTON),
+};
+
+/* Buffalo */
+
+static const struct gpio_keys_button
+bcm47xx_buttons_buffalo_whr2_a54g54[] __initconst = {
+	BCM47XX_GPIO_KEY(4, KEY_RESTART),
+};
+
+static const struct gpio_keys_button
+bcm47xx_buttons_buffalo_whr_g125[] __initconst = {
+	BCM47XX_GPIO_KEY(0, KEY_WPS_BUTTON),
+	BCM47XX_GPIO_KEY(4, KEY_RESTART),
+	BCM47XX_GPIO_KEY(5, BTN_0), /* Router / AP mode swtich */
+};
+
+static const struct gpio_keys_button
+bcm47xx_buttons_buffalo_whr_g54s[] __initconst = {
+	BCM47XX_GPIO_KEY(0, KEY_WPS_BUTTON),
+	BCM47XX_GPIO_KEY(4, KEY_RESTART),
+	BCM47XX_GPIO_KEY(5, BTN_0), /* Router / AP mode swtich */
+};
+
+static const struct gpio_keys_button
+bcm47xx_buttons_buffalo_whr_hp_g54[] __initconst = {
+	BCM47XX_GPIO_KEY(0, KEY_WPS_BUTTON),
+	BCM47XX_GPIO_KEY(4, KEY_RESTART),
+	BCM47XX_GPIO_KEY(5, BTN_0), /* Router / AP mode swtich */
+};
+
+static const struct gpio_keys_button
+bcm47xx_buttons_buffalo_wzr_g300n[] __initconst = {
+	BCM47XX_GPIO_KEY(4, KEY_RESTART),
+};
+
+static const struct gpio_keys_button
+bcm47xx_buttons_buffalo_wzr_rs_g54[] __initconst = {
+	BCM47XX_GPIO_KEY(0, KEY_WPS_BUTTON),
+	BCM47XX_GPIO_KEY(4, KEY_RESTART),
+};
+
+static const struct gpio_keys_button
+bcm47xx_buttons_buffalo_wzr_rs_g54hp[] __initconst = {
+	BCM47XX_GPIO_KEY(0, KEY_WPS_BUTTON),
+	BCM47XX_GPIO_KEY(4, KEY_RESTART),
+};
+
+/* Dell */
+
+static const struct gpio_keys_button
+bcm47xx_buttons_dell_tm2300[] __initconst = {
+	BCM47XX_GPIO_KEY(0, KEY_RESTART),
+};
+
+/* D-Link */
+
+static const struct gpio_keys_button
+bcm47xx_buttons_dlink_dir130[] __initconst = {
+	BCM47XX_GPIO_KEY(3, KEY_RESTART),
+	BCM47XX_GPIO_KEY(7, KEY_UNKNOWN),
+};
+
+static const struct gpio_keys_button
+bcm47xx_buttons_dlink_dir330[] __initconst = {
+	BCM47XX_GPIO_KEY(3, KEY_RESTART),
+	BCM47XX_GPIO_KEY(7, KEY_UNKNOWN),
+};
+
+/* Linksys */
+
+static const struct gpio_keys_button
+bcm47xx_buttons_linksys_e1000v1[] __initconst = {
+	BCM47XX_GPIO_KEY(5, KEY_WPS_BUTTON),
+	BCM47XX_GPIO_KEY(6, KEY_RESTART),
+};
+
+static const struct gpio_keys_button
+bcm47xx_buttons_linksys_e1000v21[] __initconst = {
+	BCM47XX_GPIO_KEY(9, KEY_WPS_BUTTON),
+	BCM47XX_GPIO_KEY(10, KEY_RESTART),
+};
+
+static const struct gpio_keys_button
+bcm47xx_buttons_linksys_e2000v1[] __initconst = {
+	BCM47XX_GPIO_KEY(5, KEY_WPS_BUTTON),
+	BCM47XX_GPIO_KEY(8, KEY_RESTART),
+};
+
+static const struct gpio_keys_button
+bcm47xx_buttons_linksys_e3000v1[] __initconst = {
+	BCM47XX_GPIO_KEY(4, KEY_WPS_BUTTON),
+	BCM47XX_GPIO_KEY(6, KEY_RESTART),
+};
+
+static const struct gpio_keys_button
+bcm47xx_buttons_linksys_e3200v1[] __initconst = {
+	BCM47XX_GPIO_KEY(5, KEY_RESTART),
+	BCM47XX_GPIO_KEY(8, KEY_WPS_BUTTON),
+};
+
+static const struct gpio_keys_button
+bcm47xx_buttons_linksys_e4200v1[] __initconst = {
+	BCM47XX_GPIO_KEY(4, KEY_WPS_BUTTON),
+	BCM47XX_GPIO_KEY(6, KEY_RESTART),
+};
+
+static const struct gpio_keys_button
+bcm47xx_buttons_linksys_wrt150nv1[] __initconst = {
+	BCM47XX_GPIO_KEY(4, KEY_WPS_BUTTON),
+	BCM47XX_GPIO_KEY(6, KEY_RESTART),
+};
+
+static const struct gpio_keys_button
+bcm47xx_buttons_linksys_wrt150nv11[] __initconst = {
+	BCM47XX_GPIO_KEY(4, KEY_WPS_BUTTON),
+	BCM47XX_GPIO_KEY(6, KEY_RESTART),
+};
+
+static const struct gpio_keys_button
+bcm47xx_buttons_linksys_wrt160nv1[] __initconst = {
+	BCM47XX_GPIO_KEY(4, KEY_WPS_BUTTON),
+	BCM47XX_GPIO_KEY(6, KEY_RESTART),
+};
+
+static const struct gpio_keys_button
+bcm47xx_buttons_linksys_wrt160nv3[] __initconst = {
+	BCM47XX_GPIO_KEY(5, KEY_WPS_BUTTON),
+	BCM47XX_GPIO_KEY(6, KEY_RESTART),
+};
+
+static const struct gpio_keys_button
+bcm47xx_buttons_linksys_wrt300nv11[] __initconst = {
+	BCM47XX_GPIO_KEY(4, KEY_UNKNOWN),
+	BCM47XX_GPIO_KEY(6, KEY_RESTART),
+};
+
+static const struct gpio_keys_button
+bcm47xx_buttons_linksys_wrt310nv1[] __initconst = {
+	BCM47XX_GPIO_KEY(6, KEY_RESTART),
+	BCM47XX_GPIO_KEY(8, KEY_UNKNOWN),
+};
+
+static const struct gpio_keys_button
+bcm47xx_buttons_linksys_wrt610nv1[] __initconst = {
+	BCM47XX_GPIO_KEY(6, KEY_RESTART),
+	BCM47XX_GPIO_KEY(8, KEY_WPS_BUTTON),
+};
+
+static const struct gpio_keys_button
+bcm47xx_buttons_linksys_wrt610nv2[] __initconst = {
+	BCM47XX_GPIO_KEY(4, KEY_WPS_BUTTON),
+	BCM47XX_GPIO_KEY(6, KEY_RESTART),
+};
+
+/* Motorola */
+
+static const struct gpio_keys_button
+bcm47xx_buttons_motorola_we800g[] __initconst = {
+	BCM47XX_GPIO_KEY(0, KEY_RESTART),
+};
+
+static const struct gpio_keys_button
+bcm47xx_buttons_motorola_wr850gp[] __initconst = {
+	BCM47XX_GPIO_KEY(5, KEY_RESTART),
+};
+
+static const struct gpio_keys_button
+bcm47xx_buttons_motorola_wr850gv2v3[] __initconst = {
+	BCM47XX_GPIO_KEY(5, KEY_RESTART),
+};
+
+/* Netgear */
+
+static const struct gpio_keys_button
+bcm47xx_buttons_netgear_wndr3400v1[] __initconst = {
+	BCM47XX_GPIO_KEY(4, KEY_RESTART),
+	BCM47XX_GPIO_KEY(6, KEY_WPS_BUTTON),
+	BCM47XX_GPIO_KEY(8, KEY_RFKILL),
+};
+
+static const struct gpio_keys_button
+bcm47xx_buttons_netgear_wndr3700v3[] __initconst = {
+	BCM47XX_GPIO_KEY(2, KEY_RFKILL),
+	BCM47XX_GPIO_KEY(3, KEY_RESTART),
+	BCM47XX_GPIO_KEY(4, KEY_WPS_BUTTON),
+};
+
 static const struct gpio_keys_button
 bcm47xx_buttons_netgear_wndr4500_v1[] __initconst = {
 	{
@@ -30,6 +323,18 @@ bcm47xx_buttons_netgear_wndr4500_v1[] __initconst = {
 	},
 };
 
+static const struct gpio_keys_button
+bcm47xx_buttons_netgear_wnr834bv2[] __initconst = {
+	BCM47XX_GPIO_KEY(6, KEY_RESTART),
+};
+
+/* SimpleTech */
+
+static const struct gpio_keys_button
+bcm47xx_buttons_simpletech_simpleshare[] __initconst = {
+	BCM47XX_GPIO_KEY(0, KEY_RESTART),
+};
+
 /**************************************************
  * Init
  **************************************************/
@@ -74,9 +379,160 @@ int __init bcm47xx_buttons_register(void)
 #endif
 
 	switch (board) {
+	case BCM47XX_BOARD_ASUS_RTN12:
+		err = bcm47xx_copy_bdata(bcm47xx_buttons_asus_rtn12);
+		break;
+	case BCM47XX_BOARD_ASUS_RTN16:
+		err = bcm47xx_copy_bdata(bcm47xx_buttons_asus_rtn16);
+		break;
+	case BCM47XX_BOARD_ASUS_RTN66U:
+		err = bcm47xx_copy_bdata(bcm47xx_buttons_asus_rtn66u);
+		break;
+	case BCM47XX_BOARD_ASUS_WL300G:
+		err = bcm47xx_copy_bdata(bcm47xx_buttons_asus_wl300g);
+		break;
+	case BCM47XX_BOARD_ASUS_WL320GE:
+		err = bcm47xx_copy_bdata(bcm47xx_buttons_asus_wl320ge);
+		break;
+	case BCM47XX_BOARD_ASUS_WL330GE:
+		err = bcm47xx_copy_bdata(bcm47xx_buttons_asus_wl330ge);
+		break;
+	case BCM47XX_BOARD_ASUS_WL500GD:
+		err = bcm47xx_copy_bdata(bcm47xx_buttons_asus_wl500gd);
+		break;
+	case BCM47XX_BOARD_ASUS_WL500GPV1:
+		err = bcm47xx_copy_bdata(bcm47xx_buttons_asus_wl500gpv1);
+		break;
+	case BCM47XX_BOARD_ASUS_WL500GPV2:
+		err = bcm47xx_copy_bdata(bcm47xx_buttons_asus_wl500gpv2);
+		break;
+	case BCM47XX_BOARD_ASUS_WL500W:
+		err = bcm47xx_copy_bdata(bcm47xx_buttons_asus_wl500w);
+		break;
+	case BCM47XX_BOARD_ASUS_WL520GC:
+		err = bcm47xx_copy_bdata(bcm47xx_buttons_asus_wl520gc);
+		break;
+	case BCM47XX_BOARD_ASUS_WL520GU:
+		err = bcm47xx_copy_bdata(bcm47xx_buttons_asus_wl520gu);
+		break;
+	case BCM47XX_BOARD_ASUS_WL700GE:
+		err = bcm47xx_copy_bdata(bcm47xx_buttons_asus_wl700ge);
+		break;
+	case BCM47XX_BOARD_ASUS_WLHDD:
+		err = bcm47xx_copy_bdata(bcm47xx_buttons_asus_wlhdd);
+		break;
+
+	case BCM47XX_BOARD_BELKIN_F7D4301:
+		err = bcm47xx_copy_bdata(bcm47xx_buttons_belkin_f7d4301);
+		break;
+
+	case BCM47XX_BOARD_BUFFALO_WHR2_A54G54:
+		err = bcm47xx_copy_bdata(bcm47xx_buttons_buffalo_whr2_a54g54);
+		break;
+	case BCM47XX_BOARD_BUFFALO_WHR_G125:
+		err = bcm47xx_copy_bdata(bcm47xx_buttons_buffalo_whr_g125);
+		break;
+	case BCM47XX_BOARD_BUFFALO_WHR_G54S:
+		err = bcm47xx_copy_bdata(bcm47xx_buttons_buffalo_whr_g54s);
+		break;
+	case BCM47XX_BOARD_BUFFALO_WHR_HP_G54:
+		err = bcm47xx_copy_bdata(bcm47xx_buttons_buffalo_whr_hp_g54);
+		break;
+	case BCM47XX_BOARD_BUFFALO_WZR_G300N:
+		err = bcm47xx_copy_bdata(bcm47xx_buttons_buffalo_wzr_g300n);
+		break;
+	case BCM47XX_BOARD_BUFFALO_WZR_RS_G54:
+		err = bcm47xx_copy_bdata(bcm47xx_buttons_buffalo_wzr_rs_g54);
+		break;
+	case BCM47XX_BOARD_BUFFALO_WZR_RS_G54HP:
+		err = bcm47xx_copy_bdata(bcm47xx_buttons_buffalo_wzr_rs_g54hp);
+		break;
+
+	case BCM47XX_BOARD_DELL_TM2300:
+		err = bcm47xx_copy_bdata(bcm47xx_buttons_dell_tm2300);
+		break;
+
+	case BCM47XX_BOARD_DLINK_DIR130:
+		err = bcm47xx_copy_bdata(bcm47xx_buttons_dlink_dir130);
+		break;
+	case BCM47XX_BOARD_DLINK_DIR330:
+		err = bcm47xx_copy_bdata(bcm47xx_buttons_dlink_dir330);
+		break;
+
+	case BCM47XX_BOARD_HUAWEI_E970:
+		err = bcm47xx_copy_bdata(bcm47xx_buttons_huawei_e970);
+		break;
+
+	case BCM47XX_BOARD_LINKSYS_E1000V1:
+		err = bcm47xx_copy_bdata(bcm47xx_buttons_linksys_e1000v1);
+		break;
+	case BCM47XX_BOARD_LINKSYS_E1000V21:
+		err = bcm47xx_copy_bdata(bcm47xx_buttons_linksys_e1000v21);
+		break;
+	case BCM47XX_BOARD_LINKSYS_E2000V1:
+		err = bcm47xx_copy_bdata(bcm47xx_buttons_linksys_e2000v1);
+		break;
+	case BCM47XX_BOARD_LINKSYS_E3000V1:
+		err = bcm47xx_copy_bdata(bcm47xx_buttons_linksys_e3000v1);
+		break;
+	case BCM47XX_BOARD_LINKSYS_E3200V1:
+		err = bcm47xx_copy_bdata(bcm47xx_buttons_linksys_e3200v1);
+		break;
+	case BCM47XX_BOARD_LINKSYS_E4200V1:
+		err = bcm47xx_copy_bdata(bcm47xx_buttons_linksys_e4200v1);
+		break;
+	case BCM47XX_BOARD_LINKSYS_WRT150NV1:
+		err = bcm47xx_copy_bdata(bcm47xx_buttons_linksys_wrt150nv1);
+		break;
+	case BCM47XX_BOARD_LINKSYS_WRT150NV11:
+		err = bcm47xx_copy_bdata(bcm47xx_buttons_linksys_wrt150nv11);
+		break;
+	case BCM47XX_BOARD_LINKSYS_WRT160NV1:
+		err = bcm47xx_copy_bdata(bcm47xx_buttons_linksys_wrt160nv1);
+		break;
+	case BCM47XX_BOARD_LINKSYS_WRT160NV3:
+		err = bcm47xx_copy_bdata(bcm47xx_buttons_linksys_wrt160nv3);
+		break;
+	case BCM47XX_BOARD_LINKSYS_WRT300NV11:
+		err = bcm47xx_copy_bdata(bcm47xx_buttons_linksys_wrt300nv11);
+		break;
+	case BCM47XX_BOARD_LINKSYS_WRT310NV1:
+		err = bcm47xx_copy_bdata(bcm47xx_buttons_linksys_wrt310nv1);
+		break;
+	case BCM47XX_BOARD_LINKSYS_WRT610NV1:
+		err = bcm47xx_copy_bdata(bcm47xx_buttons_linksys_wrt610nv1);
+		break;
+	case BCM47XX_BOARD_LINKSYS_WRT610NV2:
+		err = bcm47xx_copy_bdata(bcm47xx_buttons_linksys_wrt610nv2);
+		break;
+
+	case BCM47XX_BOARD_MOTOROLA_WE800G:
+		err = bcm47xx_copy_bdata(bcm47xx_buttons_motorola_we800g);
+		break;
+	case BCM47XX_BOARD_MOTOROLA_WR850GP:
+		err = bcm47xx_copy_bdata(bcm47xx_buttons_motorola_wr850gp);
+		break;
+	case BCM47XX_BOARD_MOTOROLA_WR850GV2V3:
+		err = bcm47xx_copy_bdata(bcm47xx_buttons_motorola_wr850gv2v3);
+		break;
+
+	case BCM47XX_BOARD_NETGEAR_WNDR3400V1:
+		err = bcm47xx_copy_bdata(bcm47xx_buttons_netgear_wndr3400v1);
+		break;
+	case BCM47XX_BOARD_NETGEAR_WNDR3700V3:
+		err = bcm47xx_copy_bdata(bcm47xx_buttons_netgear_wndr3700v3);
+		break;
 	case BCM47XX_BOARD_NETGEAR_WNDR4500V1:
 		err = bcm47xx_copy_bdata(bcm47xx_buttons_netgear_wndr4500_v1);
 		break;
+	case BCM47XX_BOARD_NETGEAR_WNR834BV2:
+		err = bcm47xx_copy_bdata(bcm47xx_buttons_netgear_wnr834bv2);
+		break;
+
+	case BCM47XX_BOARD_SIMPLETECH_SIMPLESHARE:
+		err = bcm47xx_copy_bdata(bcm47xx_buttons_simpletech_simpleshare);
+		break;
+
 	default:
 		pr_debug("No buttons configuration found for this device\n");
 		return -ENOTSUPP;
-- 
1.7.10.4
