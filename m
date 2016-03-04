Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Mar 2016 16:28:33 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:10840 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013282AbcCDP2cR4rLK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Mar 2016 16:28:32 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 490A85E91B323;
        Fri,  4 Mar 2016 15:28:23 +0000 (GMT)
Received: from govindraj.kl.imgtec.org (192.168.167.98) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Fri, 4 Mar 2016 15:28:25 +0000
From:   Govindraj Raja <Govindraj.Raja@imgtec.com>
To:     <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     Govindraj Raja <Govindraj.Raja@imgtec.com>,
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        <linux-mips@linux-mips.org>,
        James Hartley <James.Hartley@imgtec.com>,
        <stable@vger.kernel.org>
Subject: [PATCH] pinctrl: pistachio: fix mfio84-89 function description and pinmux.
Date:   Fri, 4 Mar 2016 15:28:22 +0000
Message-ID: <1457105302-15070-1-git-send-email-Govindraj.Raja@imgtec.com>
X-Mailer: git-send-email 2.5.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.167.98]
Return-Path: <Govindraj.Raja@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52450
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Govindraj.Raja@imgtec.com
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

mfio 84 to 89 are described wrongly, fix it to describe
the right pin and add them to right pin-mux group.

The correct order is:
	pll1_lock => mips_pll	-- MFIO_83
	pll2_lock => audio_pll	-- MFIO_84
	pll3_lock => rpu_v_pll	-- MFIO_85
	pll4_lock => rpu_l_pll	-- MFIO_86
	pll5_lock => sys_pll	-- MFIO_87
	pll6_lock => wifi_pll	-- MFIO_88
	pll7_lock => bt_pll	-- MFIO_89

Fixes: cefc03e5995e("pinctrl: Add Pistachio SoC pin control driver")
Signed-off-by: Govindraj Raja <Govindraj.Raja@imgtec.com>
Cc: linux-gpio@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Andrew Bresticker <abrestic@chromium.org>
Cc: linux-mips@linux-mips.org
Cc: James Hartley <James.Hartley@imgtec.com>
Cc: <stable@vger.kernel.org> # v4.2+
---
Do I need to split this patch into dt & pinctrl?
Or can it be picked up through pinctrl subsystem with dt maintainers Ack?

 .../bindings/pinctrl/img,pistachio-pinctrl.txt     | 12 +++++------
 drivers/pinctrl/pinctrl-pistachio.c                | 24 +++++++++++-----------
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/img,pistachio-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/img,pistachio-pinctrl.txt
index 08a4a32..0326154 100644
--- a/Documentation/devicetree/bindings/pinctrl/img,pistachio-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/img,pistachio-pinctrl.txt
@@ -134,12 +134,12 @@ mfio80		ddr_debug, mips_trace_data, mips_debug
 mfio81		dreq0, mips_trace_data, eth_debug
 mfio82		dreq1, mips_trace_data, eth_debug
 mfio83		mips_pll_lock, mips_trace_data, usb_debug
-mfio84		sys_pll_lock, mips_trace_data, usb_debug
-mfio85		wifi_pll_lock, mips_trace_data, sdhost_debug
-mfio86		bt_pll_lock, mips_trace_data, sdhost_debug
-mfio87		rpu_v_pll_lock, dreq2, socif_debug
-mfio88		rpu_l_pll_lock, dreq3, socif_debug
-mfio89		audio_pll_lock, dreq4, dreq5
+mfio84		audio_pll_lock, mips_trace_data, usb_debug
+mfio85		rpu_v_pll_lock, mips_trace_data, sdhost_debug
+mfio86		rpu_l_pll_lock, mips_trace_data, sdhost_debug
+mfio87		sys_pll_lock, dreq2, socif_debug
+mfio88		wifi_pll_lock, dreq3, socif_debug
+mfio89		bt_pll_lock, dreq4, dreq5
 tck
 trstn
 tdi
diff --git a/drivers/pinctrl/pinctrl-pistachio.c b/drivers/pinctrl/pinctrl-pistachio.c
index 856f736..2673cd9 100644
--- a/drivers/pinctrl/pinctrl-pistachio.c
+++ b/drivers/pinctrl/pinctrl-pistachio.c
@@ -469,27 +469,27 @@ static const char * const pistachio_mips_pll_lock_groups[] = {
 	"mfio83",
 };
 
-static const char * const pistachio_sys_pll_lock_groups[] = {
+static const char * const pistachio_audio_pll_lock_groups[] = {
 	"mfio84",
 };
 
-static const char * const pistachio_wifi_pll_lock_groups[] = {
+static const char * const pistachio_rpu_v_pll_lock_groups[] = {
 	"mfio85",
 };
 
-static const char * const pistachio_bt_pll_lock_groups[] = {
+static const char * const pistachio_rpu_l_pll_lock_groups[] = {
 	"mfio86",
 };
 
-static const char * const pistachio_rpu_v_pll_lock_groups[] = {
+static const char * const pistachio_sys_pll_lock_groups[] = {
 	"mfio87",
 };
 
-static const char * const pistachio_rpu_l_pll_lock_groups[] = {
+static const char * const pistachio_wifi_pll_lock_groups[] = {
 	"mfio88",
 };
 
-static const char * const pistachio_audio_pll_lock_groups[] = {
+static const char * const pistachio_bt_pll_lock_groups[] = {
 	"mfio89",
 };
 
@@ -559,12 +559,12 @@ enum pistachio_mux_option {
 	PISTACHIO_FUNCTION_DREQ4,
 	PISTACHIO_FUNCTION_DREQ5,
 	PISTACHIO_FUNCTION_MIPS_PLL_LOCK,
+	PISTACHIO_FUNCTION_AUDIO_PLL_LOCK,
+	PISTACHIO_FUNCTION_RPU_V_PLL_LOCK,
+	PISTACHIO_FUNCTION_RPU_L_PLL_LOCK,
 	PISTACHIO_FUNCTION_SYS_PLL_LOCK,
 	PISTACHIO_FUNCTION_WIFI_PLL_LOCK,
 	PISTACHIO_FUNCTION_BT_PLL_LOCK,
-	PISTACHIO_FUNCTION_RPU_V_PLL_LOCK,
-	PISTACHIO_FUNCTION_RPU_L_PLL_LOCK,
-	PISTACHIO_FUNCTION_AUDIO_PLL_LOCK,
 	PISTACHIO_FUNCTION_DEBUG_RAW_CCA_IND,
 	PISTACHIO_FUNCTION_DEBUG_ED_SEC20_CCA_IND,
 	PISTACHIO_FUNCTION_DEBUG_ED_SEC40_CCA_IND,
@@ -620,12 +620,12 @@ static const struct pistachio_function pistachio_functions[] = {
 	FUNCTION(dreq4),
 	FUNCTION(dreq5),
 	FUNCTION(mips_pll_lock),
+	FUNCTION(audio_pll_lock),
+	FUNCTION(rpu_v_pll_lock),
+	FUNCTION(rpu_l_pll_lock),
 	FUNCTION(sys_pll_lock),
 	FUNCTION(wifi_pll_lock),
 	FUNCTION(bt_pll_lock),
-	FUNCTION(rpu_v_pll_lock),
-	FUNCTION(rpu_l_pll_lock),
-	FUNCTION(audio_pll_lock),
 	FUNCTION(debug_raw_cca_ind),
 	FUNCTION(debug_ed_sec20_cca_ind),
 	FUNCTION(debug_ed_sec40_cca_ind),
-- 
2.5.0
