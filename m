Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Jun 2017 07:47:30 +0200 (CEST)
Received: from mail-pf0-x22b.google.com ([IPv6:2607:f8b0:400e:c00::22b]:35222
        "EHLO mail-pf0-x22b.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990924AbdF3FrHT69pm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Jun 2017 07:47:07 +0200
Received: by mail-pf0-x22b.google.com with SMTP id c73so61637802pfk.2
        for <linux-mips@linux-mips.org>; Thu, 29 Jun 2017 22:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bgszaRMUw+BG3bVg4C/VGEvC3vNAqyCaaxSzx06C97I=;
        b=eTOLPzk0CY8BwxoTPfUiCQcQvKt4JU6aKMpV5Jxk2rq2TjpR26gieiaB/8V1Gkm2co
         a7Pm2sgJCQSRy97HV8Y56dzYXw1Q/vvpSIIGfPJG7keAJHdOVcSOsNrscmwcgMWzOSsu
         vVvtUeOO6vn5jFVQdIyfmyx0Z7UMuX22Mgxqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bgszaRMUw+BG3bVg4C/VGEvC3vNAqyCaaxSzx06C97I=;
        b=JDp5R5/rEKjAmj0NMAAVv5ZD3u3Z/0iAPMl3zulTRxaFJJ1UUMSzNqGFchBQOW7nne
         illfJkEeh4XRCdH6tk2Auiq3T5dmA1EF4yCBDeZuS2e4lrPD0eygKnncT0E2bFAKXXpE
         HHxAAq3Ht7yahVvRzrLJrZ5z6mycOjSBpoK7mT75Yy57X9fexZV9ChVTCh+9+ri2yoze
         WtD9Vnj75zD9SQqCyiWaVRxHVARQ8kXfxdTomnK0xa8tb0WO/VOHupW9hKQAC1EavFRH
         B5E5au0FEROFfBArQ6r9eg9qeuf9QBTV0wdc8asq5rz2Nwgoxh3XmyTAcHvUQ65bU6I4
         PI8w==
X-Gm-Message-State: AKS2vOxT4H6OjjmUx8pBqiq0Vdhe+3VHrtzo4Ow2GvyJygQY3/hsstDD
        nMtJuQkkfZD3QzP/
X-Received: by 10.84.212.1 with SMTP id d1mr21967624pli.26.1498801621374;
        Thu, 29 Jun 2017 22:47:01 -0700 (PDT)
Received: from localhost.localdomain ([106.51.129.233])
        by smtp.gmail.com with ESMTPSA id a187sm11405550pgc.37.2017.06.29.22.46.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 29 Jun 2017 22:47:00 -0700 (PDT)
From:   Amit Pundir <amit.pundir@linaro.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Stable <stable@vger.kernel.org>, John Crispin <blogic@openwrt.org>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH for-4.4 05/16] MIPS: ralink: MT7688 pinmux fixes
Date:   Fri, 30 Jun 2017 11:16:29 +0530
Message-Id: <1498801600-20896-6-git-send-email-amit.pundir@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1498801600-20896-1-git-send-email-amit.pundir@linaro.org>
References: <1498801600-20896-1-git-send-email-amit.pundir@linaro.org>
Return-Path: <amit.pundir@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58933
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: amit.pundir@linaro.org
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

From: John Crispin <blogic@openwrt.org>

commit e906a5f67e5a3337d696ec848e9c28fc68b39aa3 upstream.

A few fixes to the pinmux data, 2 new muxes and a minor whitespace
cleanup.

Signed-off-by: John Crispin <blogic@openwrt.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/11991/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
---
 arch/mips/ralink/mt7620.c | 80 +++++++++++++++++++++++++++++------------------
 1 file changed, 50 insertions(+), 30 deletions(-)

diff --git a/arch/mips/ralink/mt7620.c b/arch/mips/ralink/mt7620.c
index dfb04fcedb04..733768e9877c 100644
--- a/arch/mips/ralink/mt7620.c
+++ b/arch/mips/ralink/mt7620.c
@@ -107,31 +107,31 @@ static struct rt2880_pmx_group mt7620a_pinmux_data[] = {
 };
 
 static struct rt2880_pmx_func pwm1_grp_mt7628[] = {
-	FUNC("sdcx", 3, 19, 1),
+	FUNC("sdxc d6", 3, 19, 1),
 	FUNC("utif", 2, 19, 1),
 	FUNC("gpio", 1, 19, 1),
-	FUNC("pwm", 0, 19, 1),
+	FUNC("pwm1", 0, 19, 1),
 };
 
 static struct rt2880_pmx_func pwm0_grp_mt7628[] = {
-	FUNC("sdcx", 3, 18, 1),
+	FUNC("sdxc d7", 3, 18, 1),
 	FUNC("utif", 2, 18, 1),
 	FUNC("gpio", 1, 18, 1),
-	FUNC("pwm", 0, 18, 1),
+	FUNC("pwm0", 0, 18, 1),
 };
 
 static struct rt2880_pmx_func uart2_grp_mt7628[] = {
-	FUNC("sdcx", 3, 20, 2),
+	FUNC("sdxc d5 d4", 3, 20, 2),
 	FUNC("pwm", 2, 20, 2),
 	FUNC("gpio", 1, 20, 2),
-	FUNC("uart", 0, 20, 2),
+	FUNC("uart2", 0, 20, 2),
 };
 
 static struct rt2880_pmx_func uart1_grp_mt7628[] = {
-	FUNC("sdcx", 3, 45, 2),
+	FUNC("sw_r", 3, 45, 2),
 	FUNC("pwm", 2, 45, 2),
 	FUNC("gpio", 1, 45, 2),
-	FUNC("uart", 0, 45, 2),
+	FUNC("uart1", 0, 45, 2),
 };
 
 static struct rt2880_pmx_func i2c_grp_mt7628[] = {
@@ -143,21 +143,21 @@ static struct rt2880_pmx_func i2c_grp_mt7628[] = {
 
 static struct rt2880_pmx_func refclk_grp_mt7628[] = { FUNC("reclk", 0, 36, 1) };
 static struct rt2880_pmx_func perst_grp_mt7628[] = { FUNC("perst", 0, 37, 1) };
-static struct rt2880_pmx_func wdt_grp_mt7628[] = { FUNC("wdt", 0, 15, 38) };
+static struct rt2880_pmx_func wdt_grp_mt7628[] = { FUNC("wdt", 0, 38, 1) };
 static struct rt2880_pmx_func spi_grp_mt7628[] = { FUNC("spi", 0, 7, 4) };
 
 static struct rt2880_pmx_func sd_mode_grp_mt7628[] = {
 	FUNC("jtag", 3, 22, 8),
 	FUNC("utif", 2, 22, 8),
 	FUNC("gpio", 1, 22, 8),
-	FUNC("sdcx", 0, 22, 8),
+	FUNC("sdxc", 0, 22, 8),
 };
 
 static struct rt2880_pmx_func uart0_grp_mt7628[] = {
 	FUNC("-", 3, 12, 2),
 	FUNC("-", 2, 12, 2),
 	FUNC("gpio", 1, 12, 2),
-	FUNC("uart", 0, 12, 2),
+	FUNC("uart0", 0, 12, 2),
 };
 
 static struct rt2880_pmx_func i2s_grp_mt7628[] = {
@@ -171,7 +171,7 @@ static struct rt2880_pmx_func spi_cs1_grp_mt7628[] = {
 	FUNC("-", 3, 6, 1),
 	FUNC("refclk", 2, 6, 1),
 	FUNC("gpio", 1, 6, 1),
-	FUNC("spi", 0, 6, 1),
+	FUNC("spi cs1", 0, 6, 1),
 };
 
 static struct rt2880_pmx_func spis_grp_mt7628[] = {
@@ -188,28 +188,44 @@ static struct rt2880_pmx_func gpio_grp_mt7628[] = {
 	FUNC("gpio", 0, 11, 1),
 };
 
-#define MT7628_GPIO_MODE_MASK	0x3
-
-#define MT7628_GPIO_MODE_PWM1	30
-#define MT7628_GPIO_MODE_PWM0	28
-#define MT7628_GPIO_MODE_UART2	26
-#define MT7628_GPIO_MODE_UART1	24
-#define MT7628_GPIO_MODE_I2C	20
-#define MT7628_GPIO_MODE_REFCLK	18
-#define MT7628_GPIO_MODE_PERST	16
-#define MT7628_GPIO_MODE_WDT	14
-#define MT7628_GPIO_MODE_SPI	12
-#define MT7628_GPIO_MODE_SDMODE	10
-#define MT7628_GPIO_MODE_UART0	8
-#define MT7628_GPIO_MODE_I2S	6
-#define MT7628_GPIO_MODE_CS1	4
-#define MT7628_GPIO_MODE_SPIS	2
-#define MT7628_GPIO_MODE_GPIO	0
+static struct rt2880_pmx_func wled_kn_grp_mt7628[] = {
+	FUNC("rsvd", 3, 35, 1),
+	FUNC("rsvd", 2, 35, 1),
+	FUNC("gpio", 1, 35, 1),
+	FUNC("wled_kn", 0, 35, 1),
+};
+
+static struct rt2880_pmx_func wled_an_grp_mt7628[] = {
+	FUNC("rsvd", 3, 35, 1),
+	FUNC("rsvd", 2, 35, 1),
+	FUNC("gpio", 1, 35, 1),
+	FUNC("wled_an", 0, 35, 1),
+};
+
+#define MT7628_GPIO_MODE_MASK		0x3
+
+#define MT7628_GPIO_MODE_WLED_KN	48
+#define MT7628_GPIO_MODE_WLED_AN	32
+#define MT7628_GPIO_MODE_PWM1		30
+#define MT7628_GPIO_MODE_PWM0		28
+#define MT7628_GPIO_MODE_UART2		26
+#define MT7628_GPIO_MODE_UART1		24
+#define MT7628_GPIO_MODE_I2C		20
+#define MT7628_GPIO_MODE_REFCLK		18
+#define MT7628_GPIO_MODE_PERST		16
+#define MT7628_GPIO_MODE_WDT		14
+#define MT7628_GPIO_MODE_SPI		12
+#define MT7628_GPIO_MODE_SDMODE		10
+#define MT7628_GPIO_MODE_UART0		8
+#define MT7628_GPIO_MODE_I2S		6
+#define MT7628_GPIO_MODE_CS1		4
+#define MT7628_GPIO_MODE_SPIS		2
+#define MT7628_GPIO_MODE_GPIO		0
 
 static struct rt2880_pmx_group mt7628an_pinmux_data[] = {
 	GRP_G("pmw1", pwm1_grp_mt7628, MT7628_GPIO_MODE_MASK,
 				1, MT7628_GPIO_MODE_PWM1),
-	GRP_G("pmw1", pwm0_grp_mt7628, MT7628_GPIO_MODE_MASK,
+	GRP_G("pmw0", pwm0_grp_mt7628, MT7628_GPIO_MODE_MASK,
 				1, MT7628_GPIO_MODE_PWM0),
 	GRP_G("uart2", uart2_grp_mt7628, MT7628_GPIO_MODE_MASK,
 				1, MT7628_GPIO_MODE_UART2),
@@ -233,6 +249,10 @@ static struct rt2880_pmx_group mt7628an_pinmux_data[] = {
 				1, MT7628_GPIO_MODE_SPIS),
 	GRP_G("gpio", gpio_grp_mt7628, MT7628_GPIO_MODE_MASK,
 				1, MT7628_GPIO_MODE_GPIO),
+	GRP_G("wled_an", wled_an_grp_mt7628, MT7628_GPIO_MODE_MASK,
+				1, MT7628_GPIO_MODE_WLED_AN),
+	GRP_G("wled_kn", wled_kn_grp_mt7628, MT7628_GPIO_MODE_MASK,
+				1, MT7628_GPIO_MODE_WLED_KN),
 	{ 0 }
 };
 
-- 
2.7.4
