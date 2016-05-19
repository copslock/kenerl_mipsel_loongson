Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 May 2016 22:08:15 +0200 (CEST)
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34227 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27031198AbcESUHkXh4Be (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 May 2016 22:07:40 +0200
Received: by mail-wm0-f67.google.com with SMTP id n129so23964454wmn.1;
        Thu, 19 May 2016 13:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X4j7f0xHaXH5ElFU+QYGH+rBaSUEruE2m+889ep4wDg=;
        b=DqzutZeH2F/0MB5HNvOuqBEr6uz5xmLezKykeTQoE73b2TYc+OBZZFEPTZkaXN51kV
         XOZSJPhKPL0F5T94x+UDNOQXJ3VdhITer2mvUz2nXOOR4mHWQ6pDJxipNS6oa4vyeL/2
         8rX+M7pttt2WCUsY1KXXACqfBZW9FoKUO5NbcomDDRenKlmgPhriLjX5oeZ1Xuykxz5D
         ULD0dmew+4SU9gGyKwu3v5Wyh91SLrhK7knc7esKFyBhjVyj4Ls1vioIbknBPge6X7cp
         mZ5tQqIN7K+gtyozeJ3ZUlj6H4jGS4AlZv7kF0VA+LHh7FBTrwtTkw0eKKKYglKSSED+
         yPNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X4j7f0xHaXH5ElFU+QYGH+rBaSUEruE2m+889ep4wDg=;
        b=OKmO8QLWt+ACQZMZAulLf6R6S/xYS/LiSi+uM9Xl+SxxmDcZFew4qJmmt9dn047t2z
         SpAS7nGyO0/qI65vwZkWXBPL5/1y56rc8hkP3+A5StitGM+IgOVw5FsrRpp3euoq/m6T
         t8cpIqD9ZLw8Ua9nXoL4JUjzFZIIqZtmEbAiSnS9VKWpajwUkqp8+z4IPEQeJ9KHN++D
         TRF4cPAHM6SI5rZgwtbIq0QadejacEvfbyScW8z00NhFccBG72mBs6o3GFv7k7STmHkc
         cnNwBrh7EJzDvf9Dab7o6baMOHZYKIbmIyJuTuvb2jQT0z3s8kMOjVwpyJ282AsPJGY6
         Nzbw==
X-Gm-Message-State: AOPr4FXAbU+wad75sVDIXFDHYNjoO3s6hUlzXSabXaMmGp88BUeBgmUuVBwJ9eQZt9camg==
X-Received: by 10.28.8.193 with SMTP id 184mr16164464wmi.56.1463688455160;
        Thu, 19 May 2016 13:07:35 -0700 (PDT)
Received: from localhost.localdomain (145.red-88-15-142.dynamicip.rima-tde.net. [88.15.142.145])
        by smtp.gmail.com with ESMTPSA id az2sm16111423wjc.6.2016.05.19.13.07.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 May 2016 13:07:34 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        ralf@linux-mips.org, john@phrozen.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH 3/3] MIPS: ralink: add MT7628 EPHY LEDs pinmux support
Date:   Thu, 19 May 2016 22:07:36 +0200
Message-Id: <1463688456-23795-3-git-send-email-noltari@gmail.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <noltari@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53549
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: noltari@gmail.com
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

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 arch/mips/ralink/mt7620.c | 100 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/arch/mips/ralink/mt7620.c b/arch/mips/ralink/mt7620.c
index 9f80492..251c165 100644
--- a/arch/mips/ralink/mt7620.c
+++ b/arch/mips/ralink/mt7620.c
@@ -188,6 +188,41 @@ static struct rt2880_pmx_func gpio_grp_mt7628[] = {
 	FUNC("gpio", 0, 11, 1),
 };
 
+static struct rt2880_pmx_func p4led_kn_grp_mt7628[] = {
+	FUNC("jtag", 3, 30, 1),
+	FUNC("util", 2, 30, 1),
+	FUNC("gpio", 1, 30, 1),
+	FUNC("p4led_kn", 0, 30, 1),
+};
+
+static struct rt2880_pmx_func p3led_kn_grp_mt7628[] = {
+	FUNC("jtag", 3, 31, 1),
+	FUNC("util", 2, 31, 1),
+	FUNC("gpio", 1, 31, 1),
+	FUNC("p3led_kn", 0, 31, 1),
+};
+
+static struct rt2880_pmx_func p2led_kn_grp_mt7628[] = {
+	FUNC("jtag", 3, 32, 1),
+	FUNC("util", 2, 32, 1),
+	FUNC("gpio", 1, 32, 1),
+	FUNC("p2led_kn", 0, 32, 1),
+};
+
+static struct rt2880_pmx_func p1led_kn_grp_mt7628[] = {
+	FUNC("jtag", 3, 33, 1),
+	FUNC("util", 2, 33, 1),
+	FUNC("gpio", 1, 33, 1),
+	FUNC("p1led_kn", 0, 33, 1),
+};
+
+static struct rt2880_pmx_func p0led_kn_grp_mt7628[] = {
+	FUNC("jtag", 3, 34, 1),
+	FUNC("rsvd", 2, 34, 1),
+	FUNC("gpio", 1, 34, 1),
+	FUNC("p0led_kn", 0, 34, 1),
+};
+
 static struct rt2880_pmx_func wled_kn_grp_mt7628[] = {
 	FUNC("rsvd", 3, 35, 1),
 	FUNC("rsvd", 2, 35, 1),
@@ -195,6 +230,41 @@ static struct rt2880_pmx_func wled_kn_grp_mt7628[] = {
 	FUNC("wled_kn", 0, 35, 1),
 };
 
+static struct rt2880_pmx_func p4led_an_grp_mt7628[] = {
+	FUNC("jtag", 3, 39, 1),
+	FUNC("util", 2, 39, 1),
+	FUNC("gpio", 1, 39, 1),
+	FUNC("p4led_an", 0, 39, 1),
+};
+
+static struct rt2880_pmx_func p3led_an_grp_mt7628[] = {
+	FUNC("jtag", 3, 40, 1),
+	FUNC("util", 2, 40, 1),
+	FUNC("gpio", 1, 40, 1),
+	FUNC("p3led_an", 0, 40, 1),
+};
+
+static struct rt2880_pmx_func p2led_an_grp_mt7628[] = {
+	FUNC("jtag", 3, 41, 1),
+	FUNC("util", 2, 41, 1),
+	FUNC("gpio", 1, 41, 1),
+	FUNC("p2led_an", 0, 41, 1),
+};
+
+static struct rt2880_pmx_func p1led_an_grp_mt7628[] = {
+	FUNC("jtag", 3, 42, 1),
+	FUNC("util", 2, 42, 1),
+	FUNC("gpio", 1, 42, 1),
+	FUNC("p1led_an", 0, 42, 1),
+};
+
+static struct rt2880_pmx_func p0led_an_grp_mt7628[] = {
+	FUNC("jtag", 3, 43, 1),
+	FUNC("rsvd", 2, 43, 1),
+	FUNC("gpio", 1, 43, 1),
+	FUNC("p0led_an", 0, 43, 1),
+};
+
 static struct rt2880_pmx_func wled_an_grp_mt7628[] = {
 	FUNC("rsvd", 3, 44, 1),
 	FUNC("rsvd", 2, 44, 1),
@@ -204,7 +274,17 @@ static struct rt2880_pmx_func wled_an_grp_mt7628[] = {
 
 #define MT7628_GPIO_MODE_MASK		0x3
 
+#define MT7628_GPIO_MODE_P4LED_KN	58
+#define MT7628_GPIO_MODE_P3LED_KN	56
+#define MT7628_GPIO_MODE_P2LED_KN	54
+#define MT7628_GPIO_MODE_P1LED_KN	52
+#define MT7628_GPIO_MODE_P0LED_KN	50
 #define MT7628_GPIO_MODE_WLED_KN	48
+#define MT7628_GPIO_MODE_P4LED_AN	42
+#define MT7628_GPIO_MODE_P3LED_AN	40
+#define MT7628_GPIO_MODE_P2LED_AN	38
+#define MT7628_GPIO_MODE_P1LED_AN	36
+#define MT7628_GPIO_MODE_P0LED_AN	34
 #define MT7628_GPIO_MODE_WLED_AN	32
 #define MT7628_GPIO_MODE_PWM1		30
 #define MT7628_GPIO_MODE_PWM0		28
@@ -251,8 +331,28 @@ static struct rt2880_pmx_group mt7628an_pinmux_data[] = {
 				1, MT7628_GPIO_MODE_GPIO),
 	GRP_G("wled_an", wled_an_grp_mt7628, MT7628_GPIO_MODE_MASK,
 				1, MT7628_GPIO_MODE_WLED_AN),
+	GRP_G("p0led_an", p0led_an_grp_mt7628, MT7628_GPIO_MODE_MASK,
+				1, MT7628_GPIO_MODE_P0LED_AN),
+	GRP_G("p1led_an", p1led_an_grp_mt7628, MT7628_GPIO_MODE_MASK,
+				1, MT7628_GPIO_MODE_P1LED_AN),
+	GRP_G("p2led_an", p2led_an_grp_mt7628, MT7628_GPIO_MODE_MASK,
+				1, MT7628_GPIO_MODE_P2LED_AN),
+	GRP_G("p3led_an", p3led_an_grp_mt7628, MT7628_GPIO_MODE_MASK,
+				1, MT7628_GPIO_MODE_P3LED_AN),
+	GRP_G("p4led_an", p4led_an_grp_mt7628, MT7628_GPIO_MODE_MASK,
+				1, MT7628_GPIO_MODE_P4LED_AN),
 	GRP_G("wled_kn", wled_kn_grp_mt7628, MT7628_GPIO_MODE_MASK,
 				1, MT7628_GPIO_MODE_WLED_KN),
+	GRP_G("p0led_kn", p0led_kn_grp_mt7628, MT7628_GPIO_MODE_MASK,
+				1, MT7628_GPIO_MODE_P0LED_KN),
+	GRP_G("p1led_kn", p1led_kn_grp_mt7628, MT7628_GPIO_MODE_MASK,
+				1, MT7628_GPIO_MODE_P1LED_KN),
+	GRP_G("p2led_kn", p2led_kn_grp_mt7628, MT7628_GPIO_MODE_MASK,
+				1, MT7628_GPIO_MODE_P2LED_KN),
+	GRP_G("p3led_kn", p3led_kn_grp_mt7628, MT7628_GPIO_MODE_MASK,
+				1, MT7628_GPIO_MODE_P3LED_KN),
+	GRP_G("p4led_kn", p4led_kn_grp_mt7628, MT7628_GPIO_MODE_MASK,
+				1, MT7628_GPIO_MODE_P4LED_KN),
 	{ 0 }
 };
 
-- 
2.1.4
