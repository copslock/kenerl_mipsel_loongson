Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Jun 2014 07:57:50 +0200 (CEST)
Received: from mail-wi0-f180.google.com ([209.85.212.180]:62611 "EHLO
        mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6859942AbaFTF443I1Qd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 Jun 2014 07:56:56 +0200
Received: by mail-wi0-f180.google.com with SMTP id hi2so179729wib.1
        for <multiple recipients>; Thu, 19 Jun 2014 22:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=20I1StT2cPvvWCSyDWbVWZy6rcpJNsqpJSIqHTV48Sc=;
        b=R0TbM8AUwMU2OT8F/DfqxRZ315PuGEUDrd3Lz5lm/2dqdj8f174xKcohDdsyiYqw2I
         CMcqHPNwvCinhgy+zlMRV7pBBMGgmcA1PsL4CMih/3wgfOl/5lZWwMCAiW+FymgiHtN8
         d2V3FgnTSlcEs58LH9zpRqZb0DY0U/eBGNyk0DBUATxB78ekV1a5LUGNhEL2ka0xPYQt
         ymvAgV8PgbLwwe2NY7Pu8ZaEtyttm+IPxHcKuFIUbbBIRW+yhvoF8o7nydIRuRbNWZ25
         jtn9tj2OwkFgGErkoy8XOnkK2hBrTwb91fnq8liBMvK7D/Q6ckXi70dnauHqpAXNBcgr
         ETgQ==
X-Received: by 10.194.174.168 with SMTP id bt8mr1528967wjc.72.1403243811151;
        Thu, 19 Jun 2014 22:56:51 -0700 (PDT)
Received: from linux-tdhb.lan (static-91-227-21-4.devs.futuro.pl. [91.227.21.4])
        by mx.google.com with ESMTPSA id ge17sm1574298wic.0.2014.06.19.22.56.49
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jun 2014 22:56:50 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        Catalin Patulea <cat@vv.carleton.ca>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [3.17][PATCH 2/2] MIPS: BCM47XX: Fix LEDs on WRT54GS V1.0
Date:   Fri, 20 Jun 2014 07:56:40 +0200
Message-Id: <1403243800-7849-2-git-send-email-zajec5@gmail.com>
X-Mailer: git-send-email 1.8.4.5
In-Reply-To: <1403243800-7849-1-git-send-email-zajec5@gmail.com>
References: <1403243800-7849-1-git-send-email-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40642
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

Reported-by: Catalin Patulea <cat@vv.carleton.ca>
Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
---
 arch/mips/bcm47xx/leds.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/mips/bcm47xx/leds.c b/arch/mips/bcm47xx/leds.c
index 909e00f..23324e3 100644
--- a/arch/mips/bcm47xx/leds.c
+++ b/arch/mips/bcm47xx/leds.c
@@ -306,6 +306,14 @@ bcm47xx_leds_linksys_wrt54g3gv2[] __initconst = {
 	BCM47XX_GPIO_LED(3, "blue", "3g", 0, LEDS_GPIO_DEFSTATE_OFF),
 };
 
+/* Verified on: WRT54GS V1.0 */
+static const struct gpio_led
+bcm47xx_leds_linksys_wrt54g_type_0101[] __initconst = {
+	BCM47XX_GPIO_LED(0, "green", "wlan", 0, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(1, "green", "power", 0, LEDS_GPIO_DEFSTATE_ON),
+	BCM47XX_GPIO_LED(7, "green", "dmz", 1, LEDS_GPIO_DEFSTATE_OFF),
+};
+
 static const struct gpio_led
 bcm47xx_leds_linksys_wrt610nv1[] __initconst = {
 	BCM47XX_GPIO_LED(0, "unk", "usb",  1, LEDS_GPIO_DEFSTATE_OFF),
@@ -542,6 +550,8 @@ void __init bcm47xx_leds_register(void)
 		bcm47xx_set_pdata(bcm47xx_leds_linksys_wrt54g3gv2);
 		break;
 	case BCM47XX_BOARD_LINKSYS_WRT54G_TYPE_0101:
+		bcm47xx_set_pdata(bcm47xx_leds_linksys_wrt54g_type_0101);
+		break;
 	case BCM47XX_BOARD_LINKSYS_WRT54G_TYPE_0467:
 	case BCM47XX_BOARD_LINKSYS_WRT54G_TYPE_0708:
 		bcm47xx_set_pdata(bcm47xx_leds_linksys_wrt54g_generic);
-- 
1.8.4.5
