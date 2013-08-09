Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Aug 2013 21:00:24 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:50212 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6865311Ab3HIS7JGshhL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 9 Aug 2013 20:59:09 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     John Crispin <blogic@openwrt.org>, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH 1/2] DT: Add documentation for spi-rt2880
Date:   Fri,  9 Aug 2013 20:51:26 +0200
Message-Id: <1376074288-29302-1-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37501
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

Describe the SPI master found on the MIPS based Ralink SoC.

Signed-off-by: John Crispin <blogic@openwrt.org>
Cc: devicetree@vger.kernel.org
Cc: linux-spi@vger.kernel.org
Cc: linux-mips@linux-mips.org
---
 .../devicetree/bindings/spi/spi-rt2880.txt         |   26 ++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-rt2880.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-rt2880.txt b/Documentation/devicetree/bindings/spi/spi-rt2880.txt
new file mode 100644
index 0000000..d946626
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-rt2880.txt
@@ -0,0 +1,26 @@
+Ralink SoC RT2880 and famile SPI master controller.
+
+Required properties:
+- compatible : "ralink,rt2880-spi"
+- reg : The register base for the controller.
+- #address-cells : <1>, as required by generic SPI binding.
+- #size-cells : <0>, also as required by generic SPI binding.
+
+Child nodes as per the generic SPI binding.
+
+Example:
+
+	spi@b00 {
+		compatible = "ralink,rt2880-spi";
+		reg = <0xb00 0x100>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		m25p80@0 {
+			compatible = "m25p80";
+			reg = <0>;
+			spi-max-frequency = <10000000>;
+		};
+	};
+
-- 
1.7.10.4
