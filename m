Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Aug 2016 13:04:40 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:38699 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991104AbcHSLEeMHmay (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Aug 2016 13:04:34 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id B3A678C1DD648;
        Fri, 19 Aug 2016 12:04:14 +0100 (IST)
Received: from leopard.hh.imgtec.org (192.168.167.31) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 19 Aug 2016 12:04:17 +0100
From:   James Hartley <james.hartley@imgtec.com>
To:     <linus.walleij@linaro.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <abrestic@chromium.org>, <Damien.Horsley@imgtec.com>,
        <linux-mips@linux-mips.org>,
        James Hartley <james.hartley@imgtec.com>,
        "# 4 . 4 . x-" <stable@vger.kernel.org>
Subject: [PATCH] pinctrl: pistachio: fix mfio pll_lock pinmux
Date:   Fri, 19 Aug 2016 12:03:23 +0100
Message-ID: <1471604603-23221-1-git-send-email-james.hartley@imgtec.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.167.31]
Return-Path: <James.Hartley@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54682
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hartley@imgtec.com
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

A previous patch attempted to fix the pinmuxes for mfio 84 - 89, but it
omitted a change to pistachio_pin_group pistachio_groups, which results
in incorrect pll_lock signals being routed.

Apply the correct mux settings throughout the driver.

fixes: cefc03e5995e ("pinctrl: Add Pistachio SoC pin control driver")
fixes: e9adb336d0bf ("pinctrl: pistachio: fix mfio84-89 function description and pinmux.")

Cc: <stable@vger.kernel.org> # 4.4.x-

Signed-off-by: James Hartley <james.hartley@imgtec.com>
Reviewed-by: Sifan Naeem <Sifan.Naeem@imgtec.com>

diff --git a/drivers/pinctrl/pinctrl-pistachio.c b/drivers/pinctrl/pinctrl-pistachio.c
index 7bad200..55375b1 100644
--- a/drivers/pinctrl/pinctrl-pistachio.c
+++ b/drivers/pinctrl/pinctrl-pistachio.c
@@ -809,17 +809,17 @@ static const struct pistachio_pin_group pistachio_groups[] = {
 			   PADS_FUNCTION_SELECT2, 12, 0x3),
 	MFIO_MUX_PIN_GROUP(83, MIPS_PLL_LOCK, MIPS_TRACE_DATA, USB_DEBUG,
 			   PADS_FUNCTION_SELECT2, 14, 0x3),
-	MFIO_MUX_PIN_GROUP(84, SYS_PLL_LOCK, MIPS_TRACE_DATA, USB_DEBUG,
+	MFIO_MUX_PIN_GROUP(84, AUDIO_PLL_LOCK, MIPS_TRACE_DATA, USB_DEBUG,
 			   PADS_FUNCTION_SELECT2, 16, 0x3),
-	MFIO_MUX_PIN_GROUP(85, WIFI_PLL_LOCK, MIPS_TRACE_DATA, SDHOST_DEBUG,
+	MFIO_MUX_PIN_GROUP(85, RPU_V_PLL_LOCK, MIPS_TRACE_DATA, SDHOST_DEBUG,
 			   PADS_FUNCTION_SELECT2, 18, 0x3),
-	MFIO_MUX_PIN_GROUP(86, BT_PLL_LOCK, MIPS_TRACE_DATA, SDHOST_DEBUG,
+	MFIO_MUX_PIN_GROUP(86, RPU_L_PLL_LOCK, MIPS_TRACE_DATA, SDHOST_DEBUG,
 			   PADS_FUNCTION_SELECT2, 20, 0x3),
-	MFIO_MUX_PIN_GROUP(87, RPU_V_PLL_LOCK, DREQ2, SOCIF_DEBUG,
+	MFIO_MUX_PIN_GROUP(87, SYS_PLL_LOCK, DREQ2, SOCIF_DEBUG,
 			   PADS_FUNCTION_SELECT2, 22, 0x3),
-	MFIO_MUX_PIN_GROUP(88, RPU_L_PLL_LOCK, DREQ3, SOCIF_DEBUG,
+	MFIO_MUX_PIN_GROUP(88, WIFI_PLL_LOCK, DREQ3, SOCIF_DEBUG,
 			   PADS_FUNCTION_SELECT2, 24, 0x3),
-	MFIO_MUX_PIN_GROUP(89, AUDIO_PLL_LOCK, DREQ4, DREQ5,
+	MFIO_MUX_PIN_GROUP(89, BT_PLL_LOCK, DREQ4, DREQ5,
 			   PADS_FUNCTION_SELECT2, 26, 0x3),
 	PIN_GROUP(TCK, "tck"),
 	PIN_GROUP(TRSTN, "trstn"),
-- 
2.7.4
