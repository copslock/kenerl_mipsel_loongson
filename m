Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Sep 2018 10:17:07 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:58136 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994240AbeINIQq6iQRY (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 14 Sep 2018 10:16:46 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 03682208F4; Fri, 14 Sep 2018 10:16:41 +0200 (CEST)
Received: from localhost.localdomain (AAubervilliers-681-1-99-10.w90-88.abo.wanadoo.fr [90.88.4.10])
        by mail.bootlin.com (Postfix) with ESMTPSA id 9CC4A20731;
        Fri, 14 Sep 2018 10:16:30 +0200 (CEST)
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, davem@davemloft.net, kishon@ti.com,
        andrew@lunn.ch, f.fainelli@gmail.com
Cc:     allan.nielsen@microchip.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com,
        Quentin Schulz <quentin.schulz@bootlin.com>
Subject: [PATCH net-next v3 01/11] MIPS: mscc: ocelot: make HSIO registers address range a syscon
Date:   Fri, 14 Sep 2018 10:15:59 +0200
Message-Id: <e437fd6ffded6cfeeab967b343e6ec73597fe82f.1536912834.git-series.quentin.schulz@bootlin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.ff40d591b548a6da31716e6e600f11a303e0e643.1536912834.git-series.quentin.schulz@bootlin.com>
References: <cover.ff40d591b548a6da31716e6e600f11a303e0e643.1536912834.git-series.quentin.schulz@bootlin.com>
In-Reply-To: <cover.ff40d591b548a6da31716e6e600f11a303e0e643.1536912834.git-series.quentin.schulz@bootlin.com>
References: <cover.ff40d591b548a6da31716e6e600f11a303e0e643.1536912834.git-series.quentin.schulz@bootlin.com>
Return-Path: <quentin.schulz@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66226
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quentin.schulz@bootlin.com
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

HSIO contains registers for PLL5 configuration, SerDes/switch port
muxing and a thermal sensor, hence we can't keep it in the switch DT
node.

Acked-by: Paul Burton <paul.burton@mips.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
---
 arch/mips/boot/dts/mscc/ocelot.dtsi | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/mips/boot/dts/mscc/ocelot.dtsi b/arch/mips/boot/dts/mscc/ocelot.dtsi
index f7eb612..149b1a7 100644
--- a/arch/mips/boot/dts/mscc/ocelot.dtsi
+++ b/arch/mips/boot/dts/mscc/ocelot.dtsi
@@ -107,7 +107,6 @@
 			reg = <0x1010000 0x10000>,
 			      <0x1030000 0x10000>,
 			      <0x1080000 0x100>,
-			      <0x10d0000 0x10000>,
 			      <0x11e0000 0x100>,
 			      <0x11f0000 0x100>,
 			      <0x1200000 0x100>,
@@ -121,10 +120,10 @@
 			      <0x1280000 0x100>,
 			      <0x1800000 0x80000>,
 			      <0x1880000 0x10000>;
-			reg-names = "sys", "rew", "qs", "hsio", "port0",
-				    "port1", "port2", "port3", "port4", "port5",
-				    "port6", "port7", "port8", "port9", "port10",
-				    "qsys", "ana";
+			reg-names = "sys", "rew", "qs", "port0", "port1",
+				    "port2", "port3", "port4", "port5", "port6",
+				    "port7", "port8", "port9", "port10", "qsys",
+				    "ana";
 			interrupts = <21 22>;
 			interrupt-names = "xtr", "inj";
 
@@ -231,5 +230,10 @@
 			pinctrl-0 = <&miim1>;
 			status = "disabled";
 		};
+
+		hsio: syscon@10d0000 {
+			compatible = "mscc,ocelot-hsio", "syscon", "simple-mfd";
+			reg = <0x10d0000 0x10000>;
+		};
 	};
 };
-- 
git-series 0.9.1
