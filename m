Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Aug 2017 00:56:23 +0200 (CEST)
Received: from mx1.mailbox.org ([80.241.60.212]:54124 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23995170AbdHHWxcIMvNu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 9 Aug 2017 00:53:32 +0200
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id A510445FD0;
        Wed,  9 Aug 2017 00:53:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id LQVByIAFR0aM; Wed,  9 Aug 2017 00:53:25 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, linux-mtd@lists.infradead.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        martin.blumenstingl@googlemail.com, john@phrozen.org,
        linux-spi@vger.kernel.org, hauke.mehrtens@intel.com,
        robh@kernel.org, andy.shevchenko@gmail.com, p.zabel@pengutronix.de,
        kishon@ti.com, mark.rutland@arm.com,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v9 07/16] Documentation: DT: MIPS: lantiq: Add docs for the RCU bindings
Date:   Wed,  9 Aug 2017 00:52:38 +0200
Message-Id: <20170808225247.32266-8-hauke@hauke-m.de>
In-Reply-To: <20170808225247.32266-1-hauke@hauke-m.de>
References: <20170808225247.32266-1-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59439
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

The RCU register range is used for multiple purposes. Mostly one device
uses one or multiple register exclusively, but for some registers some
bits are for one driver and some other bits are for a different driver.
With this patch all accesses to the RCU registers will go through
syscon.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/mips/lantiq/rcu.txt        | 90 ++++++++++++++++++++++
 1 file changed, 90 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mips/lantiq/rcu.txt

diff --git a/Documentation/devicetree/bindings/mips/lantiq/rcu.txt b/Documentation/devicetree/bindings/mips/lantiq/rcu.txt
new file mode 100644
index 000000000000..7b9be2d13c53
--- /dev/null
+++ b/Documentation/devicetree/bindings/mips/lantiq/rcu.txt
@@ -0,0 +1,90 @@
+Lantiq XWAY SoC RCU binding
+===========================
+
+This binding describes the RCU (reset controller unit) multifunction device,
+where each sub-device has it's own set of registers.
+
+The RCU register range is used for multiple purposes. Mostly one device
+uses one or multiple register exclusively, but for some registers some
+bits are for one driver and some other bits are for a different driver.
+With this patch all accesses to the RCU registers will go through
+syscon.
+
+
+-------------------------------------------------------------------------------
+Required properties:
+- compatible	: The first and second values must be:
+		  "lantiq,xrx200-rcu", "simple-mfd", "syscon"
+- reg		: The address and length of the system control registers
+
+
+-------------------------------------------------------------------------------
+Example of the RCU bindings on a xRX200 SoC:
+	rcu0: rcu@203000 {
+		compatible = "lantiq,xrx200-rcu", "simple-mfd", "syscon";
+		reg = <0x203000 0x100>;
+		ranges = <0x0 0x203000 0x100>;
+		big-endian;
+
+		gphy0: gphy@20 {
+			compatible = "lantiq,xrx200a2x-gphy";
+			reg = <0x20 0x4>;
+
+			resets = <&reset0 31 30>, <&reset1 7 7>;
+			reset-names = "gphy", "gphy2";
+			lantiq,gphy-mode = <GPHY_MODE_GE>;
+		};
+
+		gphy1: gphy@68 {
+			compatible = "lantiq,xrx200a2x-gphy";
+			reg = <0x68 0x4>;
+
+			resets = <&reset0 29 28>, <&reset1 6 6>;
+			reset-names = "gphy", "gphy2";
+			lantiq,gphy-mode = <GPHY_MODE_GE>;
+		};
+
+		reset0: reset-controller@10 {
+			compatible = "lantiq,xrx200-reset";
+			reg = <0x10 4>, <0x14 4>;
+
+			#reset-cells = <2>;
+		};
+
+		reset1: reset-controller@48 {
+			compatible = "lantiq,xrx200-reset";
+			reg = <0x48 4>, <0x24 4>;
+
+			#reset-cells = <2>;
+		};
+
+		usb_phy0: usb2-phy@18 {
+			compatible = "lantiq,xrx200-usb2-phy";
+			reg = <0x18 4>, <0x38 4>;
+			status = "disabled";
+
+			resets = <&reset1 4 4>, <&reset0 4 4>;
+			reset-names = "phy", "ctrl";
+			#phy-cells = <0>;
+		};
+
+		usb_phy1: usb2-phy@34 {
+			compatible = "lantiq,xrx200-usb2-phy";
+			reg = <0x34 4>, <0x3C 4>;
+			status = "disabled";
+
+			resets = <&reset1 5 4>, <&reset0 4 4>;
+			reset-names = "phy", "ctrl";
+			#phy-cells = <0>;
+		};
+
+		reboot@10 {
+			compatible = "syscon-reboot";
+			reg = <0x10 4>;
+
+			regmap = <&rcu0>;
+			offset = <0x10>;
+			mask = <0x40000000>;
+		};
+	};
+
-- 
2.11.0
