Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Sep 2016 23:12:35 +0200 (CEST)
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:55973 "EHLO
        emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992087AbcIBVLmC6rrg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Sep 2016 23:11:42 +0200
Received: from localhost.localdomain (85-76-72-196-nat.elisa-mobile.fi [85.76.72.196])
        by emh07.mail.saunalahti.fi (Postfix) with ESMTP id 81D3D40B6;
        Sat,  3 Sep 2016 00:11:41 +0300 (EEST)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 2/3] MIPS: OCTEON: add DTS for D-Link DSR-500N
Date:   Sat,  3 Sep 2016 00:11:35 +0300
Message-Id: <20160902211136.8610-3-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.9.2
In-Reply-To: <20160902211136.8610-1-aaro.koskinen@iki.fi>
References: <20160902211136.8610-1-aaro.koskinen@iki.fi>
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55028
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

Add DTS for D-Link DSR-500N.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 .../mips/boot/dts/cavium-octeon/dlink_dsr-500n.dts | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 arch/mips/boot/dts/cavium-octeon/dlink_dsr-500n.dts

diff --git a/arch/mips/boot/dts/cavium-octeon/dlink_dsr-500n.dts b/arch/mips/boot/dts/cavium-octeon/dlink_dsr-500n.dts
new file mode 100644
index 0000000..6cacabb
--- /dev/null
+++ b/arch/mips/boot/dts/cavium-octeon/dlink_dsr-500n.dts
@@ -0,0 +1,42 @@
+/*
+ * Device tree source for D-Link DSR-500N.
+ *
+ * Written by: Aaro Koskinen <aaro.koskinen@iki.fi>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/include/ "dlink_dsr-500n-1000n.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	model = "dlink,dsr-500n";
+	compatible = "dlink,dsr-500n", "cavium,octeon-3860";
+
+	soc@0 {
+		uart0: serial@1180000000800 {
+			clock-frequency = <300000000>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		usb {
+			label = "usb";
+			gpios = <&gpio 9 GPIO_ACTIVE_LOW>;
+		};
+
+		wps {
+			label = "wps";
+			gpios = <&gpio 11 GPIO_ACTIVE_LOW>;
+		};
+
+		wireless {
+			label = "2.4g";
+			gpios = <&gpio 18 GPIO_ACTIVE_LOW>;
+		};
+	};
+};
-- 
2.9.2
