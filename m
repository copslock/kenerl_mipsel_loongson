Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Apr 2015 16:19:59 +0200 (CEST)
Received: from smtp6-g21.free.fr ([212.27.42.6]:10836 "EHLO smtp6-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27026073AbbDXOTzVQWdW (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 24 Apr 2015 16:19:55 +0200
Received: from localhost.localdomain (unknown [85.177.202.128])
        (Authenticated sender: albeu)
        by smtp6-g21.free.fr (Postfix) with ESMTPA id 9149D822DE;
        Fri, 24 Apr 2015 16:17:22 +0200 (CEST)
From:   Alban Bedel <albeu@free.fr>
To:     linux-spi@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Mark Brown <broonie@kernel.org>, Alban Bedel <albeu@free.fr>,
        Gabor Juhos <juhosg@openwrt.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH 1/4] devicetree: add binding documentation for the AR7100 SPI controller
Date:   Fri, 24 Apr 2015 16:19:21 +0200
Message-Id: <1429885164-28501-2-git-send-email-albeu@free.fr>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1429885164-28501-1-git-send-email-albeu@free.fr>
References: <1429885164-28501-1-git-send-email-albeu@free.fr>
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47073
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: albeu@free.fr
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

Signed-off-by: Alban Bedel <albeu@free.fr>
---
 .../devicetree/bindings/spi/spi-ath79.txt          | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-ath79.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-ath79.txt b/Documentation/devicetree/bindings/spi/spi-ath79.txt
new file mode 100644
index 0000000..f1ad9c3
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-ath79.txt
@@ -0,0 +1,24 @@
+Binding for Qualcomm Atheros AR7xxx/AR9xxx SPI controller
+
+Required properties:
+- compatible: has to be "qca,<soc-type>-spi", "qca,ar7100-spi" as fallback.
+- reg: Base address and size of the controllers memory area
+- clocks: phandle to the AHB clock.
+- clock-names: has to be "ahb".
+- #address-cells: <1>, as required by generic SPI binding.
+- #size-cells: <0>, also as required by generic SPI binding.
+
+Child nodes as per the generic SPI binding.
+
+Example:
+
+	spi@1F000000 {
+		compatible = "qca,ar9132-spi", "qca,ar7100-spi";
+		reg = <0x1F000000 0x10>;
+
+		clocks = <&pll 2>;
+		clock-names = "ahb";
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
-- 
2.0.0
