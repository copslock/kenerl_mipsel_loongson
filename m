Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Apr 2017 21:34:22 +0200 (CEST)
Received: from hauke-m.de ([IPv6:2001:41d0:8:b27b::1]:55332 "EHLO
        mail.hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993886AbdDQTaGfejS8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Apr 2017 21:30:06 +0200
Received: from hauke-desktop.lan (p200300862804440050AB64DAC865B1E7.dip0.t-ipconnect.de [IPv6:2003:86:2804:4400:50ab:64da:c865:b1e7])
        by mail.hauke-m.de (Postfix) with ESMTPSA id 7BD52100324;
        Mon, 17 Apr 2017 21:30:05 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, linux-mtd@lists.infradead.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        martin.blumenstingl@googlemail.com, john@phrozen.org,
        linux-spi@vger.kernel.org, hauke.mehrtens@intel.com,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 12/13] Documentation: DT: MIPS: lantiq: Add docs for the RCU bindings
Date:   Mon, 17 Apr 2017 21:29:41 +0200
Message-Id: <20170417192942.32219-13-hauke@hauke-m.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170417192942.32219-1-hauke@hauke-m.de>
References: <20170417192942.32219-1-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57719
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

This adds the initial documentation for the RCU module (a MFD device
which provides USB PHYs, reset controllers and more).

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../devicetree/bindings/mips/lantiq/rcu.txt        | 82 ++++++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mips/lantiq/rcu.txt

diff --git a/Documentation/devicetree/bindings/mips/lantiq/rcu.txt b/Documentation/devicetree/bindings/mips/lantiq/rcu.txt
new file mode 100644
index 000000000000..9e5b1e7493e4
--- /dev/null
+++ b/Documentation/devicetree/bindings/mips/lantiq/rcu.txt
@@ -0,0 +1,82 @@
+Lantiq XWAY SoC RCU binding
+===========================
+
+This binding describes the RCU (reset controller unit) multifunction device,
+where each sub-device has it's own set of registers.
+
+
+-------------------------------------------------------------------------------
+Required properties:
+- compatible	: The first and second values must be: "simple-mfd", "syscon"
+- reg		: The address and length of the system control registers
+
+
+-------------------------------------------------------------------------------
+Example of the RCU bindings on a xRX200 SoC:
+	rcu0: rcu@203000 {
+		compatible = "simple-mfd", "syscon";
+		reg = <0x203000 0x100>;
+		big-endian;
+
+		gphy0: rcu_gphy@0 {
+			compatible = "lantiq,xrx200a2x-rcu-gphy";
+			lantiq,rcu-syscon = <&rcu0 0x20>;
+			resets = <&rcu_reset0 31>;
+			reset-names = "gphy";
+			lantiq,gphy-mode = <GPHY_MODE_GE>;
+			clocks = <&pmu0 XRX200_PMU_GATE_GPHY>;
+			clock-names = "gphy";
+		};
+
+		gphy1: rcu_gphy@1 {
+			compatible = "lantiq,xrx200a2x-rcu-gphy";
+			lantiq,rcu-syscon = <&rcu0 0x68>;
+			resets = <&rcu_reset0 29>;
+			reset-names = "gphy";
+			lantiq,gphy-mode = <GPHY_MODE_FE>;
+			clocks = <&pmu0 XRX200_PMU_GATE_GPHY>;
+			clock-names = "gphy";
+		};
+
+		rcu_reset0: rcu_reset@0 {
+			compatible = "lantiq,rcu-reset";
+			lantiq,rcu-syscon = <&rcu0 0x10 0x14>;
+			#reset-cells = <1>;
+			reset-request = <31>, <29>, <21>, <19>, <16>, <12>;
+			reset-status  = <30>, <28>, <16>, <25>, <5>,  <24>;
+		};
+
+		rcu_reset1: rcu_reset@1 {
+			compatible = "lantiq,rcu-reset";
+			lantiq,rcu-syscon = <&rcu0 0x48 0x24>;
+			#reset-cells = <1>;
+		};
+
+		usb_phys0: rcu-usb2-phy@0 {
+			compatible = "lantiq,xrx200-rcu-usb2-phy";
+
+			lantiq,rcu-syscon = <&rcu0 0x18 0x38>;
+			resets = <&rcu_reset1 4>, <&rcu_reset0 4>;
+			reset-names = "phy", "ctrl";
+			#phy-cells = <0>;
+		};
+
+		usb_phys1: rcu-usb2-phy@1 {
+			compatible = "lantiq,xrx200-rcu-usb2-phy";
+
+			lantiq,rcu-syscon = <&rcu0 0x34 0x3C>;
+			resets = <&rcu_reset1 5>, <&rcu_reset0 4>;
+			reset-names = "phy", "ctrl";
+			#phy-cells = <0>;
+		};
+
+		reboot {
+			compatible = "syscon-reboot";
+			regmap = <&rcu0>;
+			offset = <0x10>;
+			mask = <0x40000000>;
+		};
+
+		/* more sub-device nodes (USB PHY, etc.) */
+	};
+
-- 
2.11.0
