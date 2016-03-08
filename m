Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Mar 2016 22:32:40 +0100 (CET)
Received: from emh01.mail.saunalahti.fi ([62.142.5.107]:43681 "EHLO
        emh01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008587AbcCHVciTgHn3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Mar 2016 22:32:38 +0100
Received: from localhost.localdomain (85-76-14-12-nat.elisa-mobile.fi [85.76.14.12])
        by emh01.mail.saunalahti.fi (Postfix) with ESMTP id E9F86900B1;
        Tue,  8 Mar 2016 23:32:37 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org
Cc:     devicetree@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 2/2] MIPS: OCTEON: add DTS for EdgeRouter Lite
Date:   Tue,  8 Mar 2016 23:32:27 +0200
Message-Id: <1457472747-9339-2-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1457472747-9339-1-git-send-email-aaro.koskinen@iki.fi>
References: <1457472747-9339-1-git-send-email-aaro.koskinen@iki.fi>
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52556
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

Add DTS for EdgeRouter Lite that is usable as is without any "pruning"
with APPENDED_DTB.

Compared to builtin generic DTB, we can avoid errors and delays from
probing non-existent I2C devices.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/mips/boot/dts/cavium-octeon/ubnt_e100.dts | 59 ++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 arch/mips/boot/dts/cavium-octeon/ubnt_e100.dts

diff --git a/arch/mips/boot/dts/cavium-octeon/ubnt_e100.dts b/arch/mips/boot/dts/cavium-octeon/ubnt_e100.dts
new file mode 100644
index 0000000..243e5dc
--- /dev/null
+++ b/arch/mips/boot/dts/cavium-octeon/ubnt_e100.dts
@@ -0,0 +1,59 @@
+/*
+ * Device tree source for EdgeRouter Lite.
+ *
+ * Written by: Aaro Koskinen <aaro.koskinen@iki.fi>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/include/ "octeon_3xxx.dtsi"
+
+/ {
+	model = "ubnt,e100";
+
+	soc@0 {
+		smi0: mdio@1180000001800 {
+			phy5: ethernet-phy@5 {
+				reg = <5>;
+				compatible = "ethernet-phy-ieee802.3-c22";
+			};
+			phy6: ethernet-phy@6 {
+				reg = <6>;
+				compatible = "ethernet-phy-ieee802.3-c22";
+			};
+			phy7: ethernet-phy@7 {
+				reg = <7>;
+				compatible = "ethernet-phy-ieee802.3-c22";
+			};
+		};
+
+		pip: pip@11800a0000000 {
+			interface@0 {
+				ethernet@0 {
+					phy-handle = <&phy7>;
+				};
+				ethernet@1 {
+					phy-handle = <&phy6>;
+				};
+				ethernet@2 {
+					phy-handle = <&phy5>;
+				};
+			};
+		};
+
+		uart0: serial@1180000000800 {
+			clock-frequency = <500000000>;
+		};
+
+		usbn: usbn@1180068000000 {
+			refclk-frequency = <12000000>;
+			refclk-type = "crystal";
+		};
+	};
+
+	aliases {
+		pip = &pip;
+	};
+};
-- 
2.4.0
