Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Apr 2016 22:53:27 +0200 (CEST)
Received: from youngberry.canonical.com ([91.189.89.112]:34455 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026111AbcDLUxV5EqUq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 Apr 2016 22:53:21 +0200
Received: from 1.general.kamal.us.vpn ([10.172.68.52] helo=fourier)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kamal@canonical.com>)
        id 1aq5JI-0000TX-Qi; Tue, 12 Apr 2016 20:53:21 +0000
Received: from kamal by fourier with local (Exim 4.86_2)
        (envelope-from <kamal@whence.com>)
        id 1aq5JG-0007rt-47; Tue, 12 Apr 2016 13:53:18 -0700
From:   Kamal Mostafa <kamal@canonical.com>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel-team@lists.ubuntu.com
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org,
        James Hartley <James.Hartley@imgtec.com>,
        Govindraj Raja <Govindraj.Raja@imgtec.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Kamal Mostafa <kamal@canonical.com>
Subject: [PATCH 4.2.y-ckt 14/70] pinctrl: pistachio: fix mfio84-89 function description and pinmux.
Date:   Tue, 12 Apr 2016 13:51:59 -0700
Message-Id: <1460494375-30070-15-git-send-email-kamal@canonical.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1460494375-30070-1-git-send-email-kamal@canonical.com>
References: <1460494375-30070-1-git-send-email-kamal@canonical.com>
X-Extended-Stable: 4.2
Return-Path: <kamal@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52966
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kamal@canonical.com
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

4.2.8-ckt8 -stable review patch.  If anyone has any objections, please let me know.

---8<------------------------------------------------------------

From: Govindraj Raja <Govindraj.Raja@imgtec.com>

commit e9adb336d0bf391be23e820975ca5cd12c31d781 upstream.

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

Cc: linux-gpio@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: James Hartley <James.Hartley@imgtec.com>
Fixes: cefc03e5995e("pinctrl: Add Pistachio SoC pin control driver")
Signed-off-by: Govindraj Raja <Govindraj.Raja@imgtec.com>
Acked-by: Andrew Bresticker <abrestic@chromium.org>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
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
index 63100be..8a5bc77 100644
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
2.7.4
