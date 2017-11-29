Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Nov 2017 21:59:03 +0100 (CET)
Received: from smtp3-g21.free.fr ([IPv6:2a01:e0c:1:1599::12]:56712 "EHLO
        smtp3-g21.free.fr" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990482AbdK2U6zI2ng8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Nov 2017 21:58:55 +0100
Received: from macbookpro.malat.net (unknown [78.225.226.121])
        by smtp3-g21.free.fr (Postfix) with ESMTP id 3141913F8CC;
        Wed, 29 Nov 2017 21:58:53 +0100 (CET)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id BB53210C08D1; Wed, 29 Nov 2017 21:58:52 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Marco Franchi <marco.franchi@nxp.com>,
        linux-mips@linux-mips.org, Mathieu Malaterre <malat@debian.org>
Subject: [PATCH] dt-bindings: Remove leading 0x from bindings notation
Date:   Wed, 29 Nov 2017 21:55:15 +0100
Message-Id: <20171129205515.9009-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
Return-Path: <mathieu@macbookpro.malat.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61226
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: malat@debian.org
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

Improve the binding example by removing all the leading 0x to fix the
following dtc warnings:

Warning (unit_address_format): Node /XXX unit name should not have leading "0x"

Converted using the following command:

find Documentation/devicetree/bindings -name "*.txt" -exec sed -i -e 's/([^ ])\@0x([0-9a-f])/$1\@$2/g' {} +

This is a follow up to commit 48c926cd3414

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
I've also checked using the original perl command that I did not introduce:

Warning (unit_address_format): Node /XXX unit name should not have leading 0s

 Documentation/devicetree/bindings/arm/ccn.txt                |  2 +-
 Documentation/devicetree/bindings/arm/omap/crossbar.txt      |  2 +-
 .../devicetree/bindings/arm/tegra/nvidia,tegra20-mc.txt      |  2 +-
 Documentation/devicetree/bindings/clock/axi-clkgen.txt       |  2 +-
 .../devicetree/bindings/clock/brcm,bcm2835-aux-clock.txt     |  2 +-
 Documentation/devicetree/bindings/clock/exynos4-clock.txt    |  2 +-
 Documentation/devicetree/bindings/clock/exynos5250-clock.txt |  2 +-
 Documentation/devicetree/bindings/clock/exynos5410-clock.txt |  2 +-
 Documentation/devicetree/bindings/clock/exynos5420-clock.txt |  2 +-
 Documentation/devicetree/bindings/clock/exynos5440-clock.txt |  2 +-
 .../devicetree/bindings/clock/ti-keystone-pllctrl.txt        |  2 +-
 Documentation/devicetree/bindings/clock/zx296702-clk.txt     |  4 ++--
 Documentation/devicetree/bindings/crypto/fsl-sec4.txt        |  4 ++--
 .../devicetree/bindings/devfreq/event/rockchip-dfi.txt       |  2 +-
 Documentation/devicetree/bindings/display/atmel,lcdc.txt     |  4 ++--
 Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt    |  4 ++--
 Documentation/devicetree/bindings/dma/zxdma.txt              |  2 +-
 Documentation/devicetree/bindings/gpio/gpio-altera.txt       |  2 +-
 Documentation/devicetree/bindings/i2c/i2c-jz4780.txt         |  2 +-
 Documentation/devicetree/bindings/iio/pressure/hp03.txt      |  2 +-
 .../devicetree/bindings/input/touchscreen/bu21013.txt        |  2 +-
 .../devicetree/bindings/interrupt-controller/arm,gic.txt     |  4 ++--
 .../bindings/interrupt-controller/img,meta-intc.txt          |  2 +-
 .../bindings/interrupt-controller/img,pdc-intc.txt           |  2 +-
 .../bindings/interrupt-controller/st,spear3xx-shirq.txt      |  2 +-
 Documentation/devicetree/bindings/mailbox/altera-mailbox.txt |  6 +++---
 .../devicetree/bindings/mailbox/brcm,iproc-pdc-mbox.txt      |  2 +-
 Documentation/devicetree/bindings/media/exynos5-gsc.txt      |  2 +-
 Documentation/devicetree/bindings/media/mediatek-vcodec.txt  |  2 +-
 Documentation/devicetree/bindings/media/rcar_vin.txt         |  2 +-
 Documentation/devicetree/bindings/media/samsung-fimc.txt     |  2 +-
 Documentation/devicetree/bindings/media/sh_mobile_ceu.txt    |  2 +-
 Documentation/devicetree/bindings/media/video-interfaces.txt | 10 +++++-----
 .../devicetree/bindings/memory-controllers/ti/emif.txt       |  2 +-
 .../devicetree/bindings/mfd/ti-keystone-devctrl.txt          |  2 +-
 Documentation/devicetree/bindings/misc/brcm,kona-smc.txt     |  2 +-
 Documentation/devicetree/bindings/mmc/brcm,kona-sdhci.txt    |  2 +-
 Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt   |  2 +-
 Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt      |  4 ++--
 Documentation/devicetree/bindings/mtd/gpmc-nor.txt           |  6 +++---
 Documentation/devicetree/bindings/mtd/mtk-nand.txt           |  2 +-
 Documentation/devicetree/bindings/net/altera_tse.txt         |  4 ++--
 Documentation/devicetree/bindings/net/mdio.txt               |  2 +-
 Documentation/devicetree/bindings/net/socfpga-dwmac.txt      |  2 +-
 Documentation/devicetree/bindings/nios2/nios2.txt            |  2 +-
 Documentation/devicetree/bindings/pci/altera-pcie.txt        |  2 +-
 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt     |  2 +-
 Documentation/devicetree/bindings/pci/hisilicon-pcie.txt     |  2 +-
 Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt      |  2 +-
 .../devicetree/bindings/pinctrl/brcm,cygnus-pinmux.txt       |  2 +-
 Documentation/devicetree/bindings/pinctrl/pinctrl-atlas7.txt |  4 ++--
 Documentation/devicetree/bindings/pinctrl/pinctrl-sirf.txt   |  2 +-
 .../devicetree/bindings/pinctrl/rockchip,pinctrl.txt         |  4 ++--
 Documentation/devicetree/bindings/regulator/regulator.txt    |  2 +-
 Documentation/devicetree/bindings/serial/efm32-uart.txt      |  2 +-
 .../devicetree/bindings/serio/allwinner,sun4i-ps2.txt        |  2 +-
 .../devicetree/bindings/soc/ti/keystone-navigator-qmss.txt   |  2 +-
 Documentation/devicetree/bindings/sound/adi,axi-i2s.txt      |  2 +-
 Documentation/devicetree/bindings/sound/adi,axi-spdif-tx.txt |  2 +-
 Documentation/devicetree/bindings/sound/ak4613.txt           |  2 +-
 Documentation/devicetree/bindings/sound/ak4642.txt           |  2 +-
 Documentation/devicetree/bindings/sound/max98371.txt         |  2 +-
 Documentation/devicetree/bindings/sound/max9867.txt          |  2 +-
 Documentation/devicetree/bindings/sound/renesas,fsi.txt      |  2 +-
 Documentation/devicetree/bindings/sound/rockchip-spdif.txt   |  2 +-
 Documentation/devicetree/bindings/sound/st,sti-asoc-card.txt |  8 ++++----
 Documentation/devicetree/bindings/spi/efm32-spi.txt          |  2 +-
 Documentation/devicetree/bindings/thermal/thermal.txt        | 12 ++++++------
 Documentation/devicetree/bindings/ufs/ufs-qcom.txt           |  4 ++--
 Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt      |  2 +-
 Documentation/devicetree/bindings/usb/ehci-st.txt            |  2 +-
 Documentation/devicetree/bindings/usb/ohci-st.txt            |  2 +-
 .../devicetree/bindings/watchdog/ingenic,jz4740-wdt.txt      |  2 +-
 73 files changed, 99 insertions(+), 99 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/ccn.txt b/Documentation/devicetree/bindings/arm/ccn.txt
index 29801456c9ee..43b5a71a5a9d 100644
--- a/Documentation/devicetree/bindings/arm/ccn.txt
+++ b/Documentation/devicetree/bindings/arm/ccn.txt
@@ -15,7 +15,7 @@ Required properties:
 
 Example:
 
-	ccn@0x2000000000 {
+	ccn@2000000000 {
 		compatible = "arm,ccn-504";
 		reg = <0x20 0x00000000 0 0x1000000>;
 		interrupts = <0 181 4>;
diff --git a/Documentation/devicetree/bindings/arm/omap/crossbar.txt b/Documentation/devicetree/bindings/arm/omap/crossbar.txt
index bb5727ae004a..ecb360ed0e33 100644
--- a/Documentation/devicetree/bindings/arm/omap/crossbar.txt
+++ b/Documentation/devicetree/bindings/arm/omap/crossbar.txt
@@ -49,7 +49,7 @@ An interrupt consumer on an SoC using crossbar will use:
 	interrupts = <GIC_SPI request_number interrupt_level>
 
 Example:
-	device_x@0x4a023000 {
+	device_x@4a023000 {
 		/* Crossbar 8 used */
 		interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
 		...
diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-mc.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-mc.txt
index 866d93421eba..f9632bacbd04 100644
--- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-mc.txt
+++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-mc.txt
@@ -8,7 +8,7 @@ Required properties:
 - interrupts : Should contain MC General interrupt.
 
 Example:
-	memory-controller@0x7000f000 {
+	memory-controller@7000f000 {
 		compatible = "nvidia,tegra20-mc";
 		reg = <0x7000f000 0x024
 		       0x7000f03c 0x3c4>;
diff --git a/Documentation/devicetree/bindings/clock/axi-clkgen.txt b/Documentation/devicetree/bindings/clock/axi-clkgen.txt
index fb40da303d25..aca94fe9416f 100644
--- a/Documentation/devicetree/bindings/clock/axi-clkgen.txt
+++ b/Documentation/devicetree/bindings/clock/axi-clkgen.txt
@@ -17,7 +17,7 @@ Optional properties:
 - clock-output-names : From common clock binding.
 
 Example:
-	clock@0xff000000 {
+	clock@ff000000 {
 		compatible = "adi,axi-clkgen";
 		#clock-cells = <0>;
 		reg = <0xff000000 0x1000>;
diff --git a/Documentation/devicetree/bindings/clock/brcm,bcm2835-aux-clock.txt b/Documentation/devicetree/bindings/clock/brcm,bcm2835-aux-clock.txt
index 7a837d2182ac..4acfc8f641b6 100644
--- a/Documentation/devicetree/bindings/clock/brcm,bcm2835-aux-clock.txt
+++ b/Documentation/devicetree/bindings/clock/brcm,bcm2835-aux-clock.txt
@@ -23,7 +23,7 @@ Example:
 		clocks = <&clk_osc>;
 	};
 
-	aux: aux@0x7e215004 {
+	aux: aux@7e215004 {
 		compatible = "brcm,bcm2835-aux";
 		#clock-cells = <1>;
 		reg = <0x7e215000 0x8>;
diff --git a/Documentation/devicetree/bindings/clock/exynos4-clock.txt b/Documentation/devicetree/bindings/clock/exynos4-clock.txt
index bc61c952cb0b..17bb11365354 100644
--- a/Documentation/devicetree/bindings/clock/exynos4-clock.txt
+++ b/Documentation/devicetree/bindings/clock/exynos4-clock.txt
@@ -24,7 +24,7 @@ tree sources.
 
 Example 1: An example of a clock controller node is listed below.
 
-	clock: clock-controller@0x10030000 {
+	clock: clock-controller@10030000 {
 		compatible = "samsung,exynos4210-clock";
 		reg = <0x10030000 0x20000>;
 		#clock-cells = <1>;
diff --git a/Documentation/devicetree/bindings/clock/exynos5250-clock.txt b/Documentation/devicetree/bindings/clock/exynos5250-clock.txt
index 536eacd1063f..aff266a12eeb 100644
--- a/Documentation/devicetree/bindings/clock/exynos5250-clock.txt
+++ b/Documentation/devicetree/bindings/clock/exynos5250-clock.txt
@@ -22,7 +22,7 @@ tree sources.
 
 Example 1: An example of a clock controller node is listed below.
 
-	clock: clock-controller@0x10010000 {
+	clock: clock-controller@10010000 {
 		compatible = "samsung,exynos5250-clock";
 		reg = <0x10010000 0x30000>;
 		#clock-cells = <1>;
diff --git a/Documentation/devicetree/bindings/clock/exynos5410-clock.txt b/Documentation/devicetree/bindings/clock/exynos5410-clock.txt
index 4527de3ea205..c68b0d29b3d0 100644
--- a/Documentation/devicetree/bindings/clock/exynos5410-clock.txt
+++ b/Documentation/devicetree/bindings/clock/exynos5410-clock.txt
@@ -30,7 +30,7 @@ Example 1: An example of a clock controller node is listed below.
 		#clock-cells = <0>;
 	};
 
-	clock: clock-controller@0x10010000 {
+	clock: clock-controller@10010000 {
 		compatible = "samsung,exynos5410-clock";
 		reg = <0x10010000 0x30000>;
 		#clock-cells = <1>;
diff --git a/Documentation/devicetree/bindings/clock/exynos5420-clock.txt b/Documentation/devicetree/bindings/clock/exynos5420-clock.txt
index d54f42cf0440..717a7b1531c7 100644
--- a/Documentation/devicetree/bindings/clock/exynos5420-clock.txt
+++ b/Documentation/devicetree/bindings/clock/exynos5420-clock.txt
@@ -23,7 +23,7 @@ tree sources.
 
 Example 1: An example of a clock controller node is listed below.
 
-	clock: clock-controller@0x10010000 {
+	clock: clock-controller@10010000 {
 		compatible = "samsung,exynos5420-clock";
 		reg = <0x10010000 0x30000>;
 		#clock-cells = <1>;
diff --git a/Documentation/devicetree/bindings/clock/exynos5440-clock.txt b/Documentation/devicetree/bindings/clock/exynos5440-clock.txt
index 5f7005f73058..c7d227c31e95 100644
--- a/Documentation/devicetree/bindings/clock/exynos5440-clock.txt
+++ b/Documentation/devicetree/bindings/clock/exynos5440-clock.txt
@@ -21,7 +21,7 @@ tree sources.
 
 Example: An example of a clock controller node is listed below.
 
-	clock: clock-controller@0x10010000 {
+	clock: clock-controller@10010000 {
 		compatible = "samsung,exynos5440-clock";
 		reg = <0x160000 0x10000>;
 		#clock-cells = <1>;
diff --git a/Documentation/devicetree/bindings/clock/ti-keystone-pllctrl.txt b/Documentation/devicetree/bindings/clock/ti-keystone-pllctrl.txt
index 3e6a81e99804..c35cb6c4af4d 100644
--- a/Documentation/devicetree/bindings/clock/ti-keystone-pllctrl.txt
+++ b/Documentation/devicetree/bindings/clock/ti-keystone-pllctrl.txt
@@ -14,7 +14,7 @@ Required properties:
 
 Example:
 
-pllctrl: pll-controller@0x02310000 {
+pllctrl: pll-controller@02310000 {
 	compatible = "ti,keystone-pllctrl", "syscon";
 	reg = <0x02310000 0x200>;
 };
diff --git a/Documentation/devicetree/bindings/clock/zx296702-clk.txt b/Documentation/devicetree/bindings/clock/zx296702-clk.txt
index e85ecb510d56..5c91c9e4f1be 100644
--- a/Documentation/devicetree/bindings/clock/zx296702-clk.txt
+++ b/Documentation/devicetree/bindings/clock/zx296702-clk.txt
@@ -20,13 +20,13 @@ ID in its "clocks" phandle cell. See include/dt-bindings/clock/zx296702-clock.h
 for the full list of zx296702 clock IDs.
 
 
-topclk: topcrm@0x09800000 {
+topclk: topcrm@09800000 {
         compatible = "zte,zx296702-topcrm-clk";
         reg = <0x09800000 0x1000>;
         #clock-cells = <1>;
 };
 
-uart0: serial@0x09405000 {
+uart0: serial@09405000 {
         compatible = "zte,zx296702-uart";
         reg = <0x09405000 0x1000>;
         interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/Documentation/devicetree/bindings/crypto/fsl-sec4.txt b/Documentation/devicetree/bindings/crypto/fsl-sec4.txt
index 7aef0eae58d4..76aec8a3724d 100644
--- a/Documentation/devicetree/bindings/crypto/fsl-sec4.txt
+++ b/Documentation/devicetree/bindings/crypto/fsl-sec4.txt
@@ -456,7 +456,7 @@ System ON/OFF key driver
       Definition: this is phandle to the register map node.
 
 EXAMPLE:
-	snvs-pwrkey@0x020cc000 {
+	snvs-pwrkey@020cc000 {
 		compatible = "fsl,sec-v4.0-pwrkey";
 		regmap = <&snvs>;
 		interrupts = <0 4 0x4>
@@ -545,7 +545,7 @@ FULL EXAMPLE
 			interrupts = <93 2>;
 		};
 
-		snvs-pwrkey@0x020cc000 {
+		snvs-pwrkey@020cc000 {
 			compatible = "fsl,sec-v4.0-pwrkey";
 			regmap = <&sec_mon>;
 			interrupts = <0 4 0x4>;
diff --git a/Documentation/devicetree/bindings/devfreq/event/rockchip-dfi.txt b/Documentation/devicetree/bindings/devfreq/event/rockchip-dfi.txt
index 001dd63979a9..148191b0fc15 100644
--- a/Documentation/devicetree/bindings/devfreq/event/rockchip-dfi.txt
+++ b/Documentation/devicetree/bindings/devfreq/event/rockchip-dfi.txt
@@ -9,7 +9,7 @@ Required properties:
 - clock-names : the name of clock used by the DFI, must be "pclk_ddr_mon";
 
 Example:
-	dfi: dfi@0xff630000 {
+	dfi: dfi@ff630000 {
 		compatible = "rockchip,rk3399-dfi";
 		reg = <0x00 0xff630000 0x00 0x4000>;
 		rockchip,pmu = <&pmugrf>;
diff --git a/Documentation/devicetree/bindings/display/atmel,lcdc.txt b/Documentation/devicetree/bindings/display/atmel,lcdc.txt
index 1a21202778ee..acb5a0132127 100644
--- a/Documentation/devicetree/bindings/display/atmel,lcdc.txt
+++ b/Documentation/devicetree/bindings/display/atmel,lcdc.txt
@@ -27,7 +27,7 @@ Optional properties:
 
 Example:
 
-	fb0: fb@0x00500000 {
+	fb0: fb@00500000 {
 		compatible = "atmel,at91sam9g45-lcdc";
 		reg = <0x00500000 0x1000>;
 		interrupts = <23 3 0>;
@@ -41,7 +41,7 @@ Example:
 
 Example for fixed framebuffer memory:
 
-	fb0: fb@0x00500000 {
+	fb0: fb@00500000 {
 		compatible = "atmel,at91sam9263-lcdc";
 		reg = <0x00700000 0x1000 0x70000000 0x200000>;
 		[...]
diff --git a/Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt b/Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt
index 55492c264d17..b3408cc57be6 100644
--- a/Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt
+++ b/Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt
@@ -73,7 +73,7 @@ Hypervisor OS configuration:
 		max-read-transactions = <31>;
 		channel-reset-timeout-cycles = <0x500>;
 
-		hidma_24: dma-controller@0x5c050000 {
+		hidma_24: dma-controller@5c050000 {
 			compatible = "qcom,hidma-1.0";
 			reg = <0 0x5c050000 0x0 0x1000>,
 			      <0 0x5c0b0000 0x0 0x1000>;
@@ -85,7 +85,7 @@ Hypervisor OS configuration:
 
 Guest OS configuration:
 
-	hidma_24: dma-controller@0x5c050000 {
+	hidma_24: dma-controller@5c050000 {
 		compatible = "qcom,hidma-1.0";
 		reg = <0 0x5c050000 0x0 0x1000>,
 		      <0 0x5c0b0000 0x0 0x1000>;
diff --git a/Documentation/devicetree/bindings/dma/zxdma.txt b/Documentation/devicetree/bindings/dma/zxdma.txt
index abec59f35fde..0ab80f69e566 100644
--- a/Documentation/devicetree/bindings/dma/zxdma.txt
+++ b/Documentation/devicetree/bindings/dma/zxdma.txt
@@ -13,7 +13,7 @@ Required properties:
 Example:
 
 Controller:
-	dma: dma-controller@0x09c00000{
+	dma: dma-controller@09c00000{
 		compatible = "zte,zx296702-dma";
 		reg = <0x09c00000 0x1000>;
 		clocks = <&topclk ZX296702_DMA_ACLK>;
diff --git a/Documentation/devicetree/bindings/gpio/gpio-altera.txt b/Documentation/devicetree/bindings/gpio/gpio-altera.txt
index 826a7208ca93..146e554b3c67 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-altera.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio-altera.txt
@@ -30,7 +30,7 @@ Optional properties:
 
 Example:
 
-gpio_altr: gpio@0xff200000 {
+gpio_altr: gpio@ff200000 {
 	compatible = "altr,pio-1.0";
 	reg = <0xff200000 0x10>;
 	interrupts = <0 45 4>;
diff --git a/Documentation/devicetree/bindings/i2c/i2c-jz4780.txt b/Documentation/devicetree/bindings/i2c/i2c-jz4780.txt
index 231e4cc4008c..d4a082acf92f 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-jz4780.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-jz4780.txt
@@ -18,7 +18,7 @@ Optional properties:
 Example
 
 / {
-	i2c4: i2c4@0x10054000 {
+	i2c4: i2c4@10054000 {
 		compatible = "ingenic,jz4780-i2c";
 		reg = <0x10054000 0x1000>;
 
diff --git a/Documentation/devicetree/bindings/iio/pressure/hp03.txt b/Documentation/devicetree/bindings/iio/pressure/hp03.txt
index 54e7e70bcea5..831dbee7a5c3 100644
--- a/Documentation/devicetree/bindings/iio/pressure/hp03.txt
+++ b/Documentation/devicetree/bindings/iio/pressure/hp03.txt
@@ -10,7 +10,7 @@ Required properties:
 
 Example:
 
-hp03@0x77 {
+hp03@77 {
 	compatible = "hoperf,hp03";
 	reg = <0x77>;
 	xclr-gpio = <&portc 0 0x0>;
diff --git a/Documentation/devicetree/bindings/input/touchscreen/bu21013.txt b/Documentation/devicetree/bindings/input/touchscreen/bu21013.txt
index ca5a2c86480c..56d835242af2 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/bu21013.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/bu21013.txt
@@ -15,7 +15,7 @@ Optional properties:
 Example:
 
 	i2c@80110000 {
-		bu21013_tp@0x5c {
+		bu21013_tp@5c {
 			compatible = "rohm,bu21013_tp";
 			reg = <0x5c>;
 			touch-gpio = <&gpio2 20 0x4>;
diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,gic.txt b/Documentation/devicetree/bindings/interrupt-controller/arm,gic.txt
index 560d8a727b8f..2f3244648646 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/arm,gic.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/arm,gic.txt
@@ -155,7 +155,7 @@ Example:
 		      <0x0 0xe112f000 0 0x02000>,
 		      <0x0 0xe1140000 0 0x10000>,
 		      <0x0 0xe1160000 0 0x10000>;
-		v2m0: v2m@0x8000 {
+		v2m0: v2m@8000 {
 			compatible = "arm,gic-v2m-frame";
 			msi-controller;
 			reg = <0x0 0x80000 0 0x1000>;
@@ -163,7 +163,7 @@ Example:
 
 		....
 
-		v2mN: v2m@0x9000 {
+		v2mN: v2m@9000 {
 			compatible = "arm,gic-v2m-frame";
 			msi-controller;
 			reg = <0x0 0x90000 0 0x1000>;
diff --git a/Documentation/devicetree/bindings/interrupt-controller/img,meta-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/img,meta-intc.txt
index 80994adab392..42431f44697f 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/img,meta-intc.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/img,meta-intc.txt
@@ -71,7 +71,7 @@ Example 2:
 	 * An interrupt generating device that is wired to a Meta external
 	 * trigger block.
 	 */
-	uart1: uart@0x02004c00 {
+	uart1: uart@02004c00 {
 		// Interrupt source '5' that is level-sensitive.
 		// Note that there are only two cells as specified in the
 		// interrupt parent's '#interrupt-cells' property.
diff --git a/Documentation/devicetree/bindings/interrupt-controller/img,pdc-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/img,pdc-intc.txt
index a69118550344..5dc2a55ad811 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/img,pdc-intc.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/img,pdc-intc.txt
@@ -51,7 +51,7 @@ Example 1:
 	/*
 	 * TZ1090 PDC block
 	 */
-	pdc: pdc@0x02006000 {
+	pdc: pdc@02006000 {
 		// This is an interrupt controller node.
 		interrupt-controller;
 
diff --git a/Documentation/devicetree/bindings/interrupt-controller/st,spear3xx-shirq.txt b/Documentation/devicetree/bindings/interrupt-controller/st,spear3xx-shirq.txt
index 715a013ed4bd..2ab0ea39867b 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/st,spear3xx-shirq.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/st,spear3xx-shirq.txt
@@ -39,7 +39,7 @@ Example:
 
 The following is an example from the SPEAr320 SoC dtsi file.
 
-shirq: interrupt-controller@0xb3000000 {
+shirq: interrupt-controller@b3000000 {
 	compatible = "st,spear320-shirq";
 	reg = <0xb3000000 0x1000>;
 	interrupts = <28 29 30 1>;
diff --git a/Documentation/devicetree/bindings/mailbox/altera-mailbox.txt b/Documentation/devicetree/bindings/mailbox/altera-mailbox.txt
index c2619797ce0c..49cfc8c337c4 100644
--- a/Documentation/devicetree/bindings/mailbox/altera-mailbox.txt
+++ b/Documentation/devicetree/bindings/mailbox/altera-mailbox.txt
@@ -14,7 +14,7 @@ Optional properties:
 			depends on the interrupt controller parent.
 
 Example:
-	mbox_tx: mailbox@0x100 {
+	mbox_tx: mailbox@100 {
 		compatible = "altr,mailbox-1.0";
 		reg = <0x100 0x8>;
 		interrupt-parent = < &gic_0 >;
@@ -22,7 +22,7 @@ Example:
 		#mbox-cells = <1>;
 	};
 
-	mbox_rx: mailbox@0x200 {
+	mbox_rx: mailbox@200 {
 		compatible = "altr,mailbox-1.0";
 		reg = <0x200 0x8>;
 		interrupt-parent = < &gic_0 >;
@@ -40,7 +40,7 @@ support only one channel).The equivalent "mbox-names" property value can be
 used to give a name to the communication channel to be used by the client user.
 
 Example:
-	mclient0: mclient0@0x400 {
+	mclient0: mclient0@400 {
 		compatible = "client-1.0";
 		reg = <0x400 0x10>;
 		mbox-names = "mbox-tx", "mbox-rx";
diff --git a/Documentation/devicetree/bindings/mailbox/brcm,iproc-pdc-mbox.txt b/Documentation/devicetree/bindings/mailbox/brcm,iproc-pdc-mbox.txt
index 0f3ee81d92c2..9bcdf2087625 100644
--- a/Documentation/devicetree/bindings/mailbox/brcm,iproc-pdc-mbox.txt
+++ b/Documentation/devicetree/bindings/mailbox/brcm,iproc-pdc-mbox.txt
@@ -15,7 +15,7 @@ Optional properties:
 - brcm,use-bcm-hdr:  present if a BCM header precedes each frame.
 
 Example:
-	pdc0: iproc-pdc0@0x612c0000 {
+	pdc0: iproc-pdc0@612c0000 {
 		compatible = "brcm,iproc-pdc-mbox";
 		reg = <0 0x612c0000 0 0x445>;  /* PDC FS0 regs */
 		interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/Documentation/devicetree/bindings/media/exynos5-gsc.txt b/Documentation/devicetree/bindings/media/exynos5-gsc.txt
index 0d4fdaedc6f1..bc963a6d305a 100644
--- a/Documentation/devicetree/bindings/media/exynos5-gsc.txt
+++ b/Documentation/devicetree/bindings/media/exynos5-gsc.txt
@@ -17,7 +17,7 @@ Optional properties:
 
 Example:
 
-gsc_0:  gsc@0x13e00000 {
+gsc_0:  gsc@13e00000 {
 	compatible = "samsung,exynos5250-gsc";
 	reg = <0x13e00000 0x1000>;
 	interrupts = <0 85 0>;
diff --git a/Documentation/devicetree/bindings/media/mediatek-vcodec.txt b/Documentation/devicetree/bindings/media/mediatek-vcodec.txt
index 46c15c54175d..2a615d84a682 100644
--- a/Documentation/devicetree/bindings/media/mediatek-vcodec.txt
+++ b/Documentation/devicetree/bindings/media/mediatek-vcodec.txt
@@ -68,7 +68,7 @@ vcodec_dec: vcodec@16000000 {
                   "vdec_bus_clk_src";
   };
 
-  vcodec_enc: vcodec@0x18002000 {
+  vcodec_enc: vcodec@18002000 {
     compatible = "mediatek,mt8173-vcodec-enc";
     reg = <0 0x18002000 0 0x1000>,    /*VENC_SYS*/
           <0 0x19002000 0 0x1000>;    /*VENC_LT_SYS*/
diff --git a/Documentation/devicetree/bindings/media/rcar_vin.txt b/Documentation/devicetree/bindings/media/rcar_vin.txt
index 6e4ef8caf759..19357d0bbe65 100644
--- a/Documentation/devicetree/bindings/media/rcar_vin.txt
+++ b/Documentation/devicetree/bindings/media/rcar_vin.txt
@@ -44,7 +44,7 @@ Device node example
 	       vin0 = &vin0;
 	};
 
-        vin0: vin@0xe6ef0000 {
+        vin0: vin@e6ef0000 {
                 compatible = "renesas,vin-r8a7790", "renesas,rcar-gen2-vin";
                 clocks = <&mstp8_clks R8A7790_CLK_VIN0>;
                 reg = <0 0xe6ef0000 0 0x1000>;
diff --git a/Documentation/devicetree/bindings/media/samsung-fimc.txt b/Documentation/devicetree/bindings/media/samsung-fimc.txt
index e4e15d8d7521..48c599dacbdf 100644
--- a/Documentation/devicetree/bindings/media/samsung-fimc.txt
+++ b/Documentation/devicetree/bindings/media/samsung-fimc.txt
@@ -138,7 +138,7 @@ Example:
 		};
 
 		/* MIPI CSI-2 bus IF sensor */
-		s5c73m3: sensor@0x1a {
+		s5c73m3: sensor@1a {
 			compatible = "samsung,s5c73m3";
 			reg = <0x1a>;
 			vddio-supply = <...>;
diff --git a/Documentation/devicetree/bindings/media/sh_mobile_ceu.txt b/Documentation/devicetree/bindings/media/sh_mobile_ceu.txt
index 1ce4e46bcbb7..17a8e81ca0cc 100644
--- a/Documentation/devicetree/bindings/media/sh_mobile_ceu.txt
+++ b/Documentation/devicetree/bindings/media/sh_mobile_ceu.txt
@@ -8,7 +8,7 @@ Bindings, specific for the sh_mobile_ceu_camera.c driver:
 
 Example:
 
-ceu0: ceu@0xfe910000 {
+ceu0: ceu@fe910000 {
 	compatible = "renesas,sh-mobile-ceu";
 	reg = <0xfe910000 0xa0>;
 	interrupt-parent = <&intcs>;
diff --git a/Documentation/devicetree/bindings/media/video-interfaces.txt b/Documentation/devicetree/bindings/media/video-interfaces.txt
index 3994b0143dd1..258b8dfddf48 100644
--- a/Documentation/devicetree/bindings/media/video-interfaces.txt
+++ b/Documentation/devicetree/bindings/media/video-interfaces.txt
@@ -154,7 +154,7 @@ imx074 is linked to ceu0 through the MIPI CSI-2 receiver (csi2). ceu0 has a
 'port' node which may indicate that at any time only one of the following data
 pipelines can be active: ov772x -> ceu0 or imx074 -> csi2 -> ceu0.
 
-	ceu0: ceu@0xfe910000 {
+	ceu0: ceu@fe910000 {
 		compatible = "renesas,sh-mobile-ceu";
 		reg = <0xfe910000 0xa0>;
 		interrupts = <0x880>;
@@ -193,9 +193,9 @@ pipelines can be active: ov772x -> ceu0 or imx074 -> csi2 -> ceu0.
 		};
 	};
 
-	i2c0: i2c@0xfff20000 {
+	i2c0: i2c@fff20000 {
 		...
-		ov772x_1: camera@0x21 {
+		ov772x_1: camera@21 {
 			compatible = "ovti,ov772x";
 			reg = <0x21>;
 			vddio-supply = <&regulator1>;
@@ -219,7 +219,7 @@ pipelines can be active: ov772x -> ceu0 or imx074 -> csi2 -> ceu0.
 			};
 		};
 
-		imx074: camera@0x1a {
+		imx074: camera@1a {
 			compatible = "sony,imx074";
 			reg = <0x1a>;
 			vddio-supply = <&regulator1>;
@@ -239,7 +239,7 @@ pipelines can be active: ov772x -> ceu0 or imx074 -> csi2 -> ceu0.
 		};
 	};
 
-	csi2: csi2@0xffc90000 {
+	csi2: csi2@ffc90000 {
 		compatible = "renesas,sh-mobile-csi2";
 		reg = <0xffc90000 0x1000>;
 		interrupts = <0x17a0>;
diff --git a/Documentation/devicetree/bindings/memory-controllers/ti/emif.txt b/Documentation/devicetree/bindings/memory-controllers/ti/emif.txt
index fd823d6091b2..152eeccbde1c 100644
--- a/Documentation/devicetree/bindings/memory-controllers/ti/emif.txt
+++ b/Documentation/devicetree/bindings/memory-controllers/ti/emif.txt
@@ -46,7 +46,7 @@ Optional properties:
 
 Example:
 
-emif1: emif@0x4c000000 {
+emif1: emif@4c000000 {
 	compatible	= "ti,emif-4d";
 	ti,hwmods	= "emif2";
 	phy-type	= <1>;
diff --git a/Documentation/devicetree/bindings/mfd/ti-keystone-devctrl.txt b/Documentation/devicetree/bindings/mfd/ti-keystone-devctrl.txt
index 20963c76b4bc..71a1f5963936 100644
--- a/Documentation/devicetree/bindings/mfd/ti-keystone-devctrl.txt
+++ b/Documentation/devicetree/bindings/mfd/ti-keystone-devctrl.txt
@@ -13,7 +13,7 @@ Required properties:
 
 Example:
 
-devctrl: device-state-control@0x02620000 {
+devctrl: device-state-control@02620000 {
 	compatible = "ti,keystone-devctrl", "syscon";
 	reg = <0x02620000 0x1000>;
 };
diff --git a/Documentation/devicetree/bindings/misc/brcm,kona-smc.txt b/Documentation/devicetree/bindings/misc/brcm,kona-smc.txt
index 6c9f176f3571..05b47232ed9e 100644
--- a/Documentation/devicetree/bindings/misc/brcm,kona-smc.txt
+++ b/Documentation/devicetree/bindings/misc/brcm,kona-smc.txt
@@ -9,7 +9,7 @@ Required properties:
 - reg : Location and size of bounce buffer
 
 Example:
-	smc@0x3404c000 {
+	smc@3404c000 {
 		compatible = "brcm,bcm11351-smc", "brcm,kona-smc";
 		reg = <0x3404c000 0x400>; //1 KiB in SRAM
 	};
diff --git a/Documentation/devicetree/bindings/mmc/brcm,kona-sdhci.txt b/Documentation/devicetree/bindings/mmc/brcm,kona-sdhci.txt
index aaba2483b4ff..7f5dd83f5bd9 100644
--- a/Documentation/devicetree/bindings/mmc/brcm,kona-sdhci.txt
+++ b/Documentation/devicetree/bindings/mmc/brcm,kona-sdhci.txt
@@ -12,7 +12,7 @@ Refer to clocks/clock-bindings.txt for generic clock consumer properties.
 
 Example:
 
-sdio2: sdio@0x3f1a0000 {
+sdio2: sdio@3f1a0000 {
 	compatible = "brcm,kona-sdhci";
 	reg = <0x3f1a0000 0x10000>;
 	clocks = <&sdio3_clk>;
diff --git a/Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt b/Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt
index 954561d09a8e..fa90d253dc7e 100644
--- a/Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt
+++ b/Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt
@@ -24,7 +24,7 @@ Optional properties:
 
 Example:
 
-sdhci0: sdhci@0x18041000 {
+sdhci0: sdhci@18041000 {
 	compatible = "brcm,sdhci-iproc-cygnus";
 	reg = <0x18041000 0x100>;
 	interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
index 3a4ac401e6f9..19f5508a7569 100644
--- a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
+++ b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
@@ -55,7 +55,7 @@ Examples:
 
 [hwmod populated DMA resources]
 
-	mmc1: mmc@0x4809c000 {
+	mmc1: mmc@4809c000 {
 		compatible = "ti,omap4-hsmmc";
 		reg = <0x4809c000 0x400>;
 		ti,hwmods = "mmc1";
@@ -67,7 +67,7 @@ Examples:
 
 [generic DMA request binding]
 
-	mmc1: mmc@0x4809c000 {
+	mmc1: mmc@4809c000 {
 		compatible = "ti,omap4-hsmmc";
 		reg = <0x4809c000 0x400>;
 		ti,hwmods = "mmc1";
diff --git a/Documentation/devicetree/bindings/mtd/gpmc-nor.txt b/Documentation/devicetree/bindings/mtd/gpmc-nor.txt
index 131d3a74d0bd..c8567b40fe13 100644
--- a/Documentation/devicetree/bindings/mtd/gpmc-nor.txt
+++ b/Documentation/devicetree/bindings/mtd/gpmc-nor.txt
@@ -82,15 +82,15 @@ gpmc: gpmc@6e000000 {
 			label = "bootloader-nor";
 			reg = <0 0x40000>;
 		};
-		partition@0x40000 {
+		partition@40000 {
 			label = "params-nor";
 			reg = <0x40000 0x40000>;
 		};
-		partition@0x80000 {
+		partition@80000 {
 			label = "kernel-nor";
 			reg = <0x80000 0x200000>;
 		};
-		partition@0x280000 {
+		partition@280000 {
 			label = "filesystem-nor";
 			reg = <0x240000 0x7d80000>;
 		};
diff --git a/Documentation/devicetree/bindings/mtd/mtk-nand.txt b/Documentation/devicetree/bindings/mtd/mtk-nand.txt
index dbf9e054c11c..0431841de781 100644
--- a/Documentation/devicetree/bindings/mtd/mtk-nand.txt
+++ b/Documentation/devicetree/bindings/mtd/mtk-nand.txt
@@ -131,7 +131,7 @@ Example:
 				read-only;
 				reg = <0x00000000 0x00400000>;
 			};
-			android@0x00400000 {
+			android@00400000 {
 				label = "android";
 				reg = <0x00400000 0x12c00000>;
 			};
diff --git a/Documentation/devicetree/bindings/net/altera_tse.txt b/Documentation/devicetree/bindings/net/altera_tse.txt
index a706297998e9..0e21df94a53f 100644
--- a/Documentation/devicetree/bindings/net/altera_tse.txt
+++ b/Documentation/devicetree/bindings/net/altera_tse.txt
@@ -52,7 +52,7 @@ Optional properties:
 
 Example:
 
-	tse_sub_0_eth_tse_0: ethernet@0x1,00000000 {
+	tse_sub_0_eth_tse_0: ethernet@1,00000000 {
 		compatible = "altr,tse-msgdma-1.0";
 		reg =	<0x00000001 0x00000000 0x00000400>,
 			<0x00000001 0x00000460 0x00000020>,
@@ -90,7 +90,7 @@ Example:
 		};
 	};
 
-	tse_sub_1_eth_tse_0: ethernet@0x1,00001000 {
+	tse_sub_1_eth_tse_0: ethernet@1,00001000 {
 		compatible = "altr,tse-msgdma-1.0";
 		reg = 	<0x00000001 0x00001000 0x00000400>,
 			<0x00000001 0x00001460 0x00000020>,
diff --git a/Documentation/devicetree/bindings/net/mdio.txt b/Documentation/devicetree/bindings/net/mdio.txt
index 96a53f89aa6e..e3e1603f256c 100644
--- a/Documentation/devicetree/bindings/net/mdio.txt
+++ b/Documentation/devicetree/bindings/net/mdio.txt
@@ -18,7 +18,7 @@ Example :
 This example shows these optional properties, plus other properties
 required for the TI Davinci MDIO driver.
 
-	davinci_mdio: ethernet@0x5c030000 {
+	davinci_mdio: ethernet@5c030000 {
 		compatible = "ti,davinci_mdio";
 		reg = <0x5c030000 0x1000>;
 		#address-cells = <1>;
diff --git a/Documentation/devicetree/bindings/net/socfpga-dwmac.txt b/Documentation/devicetree/bindings/net/socfpga-dwmac.txt
index b30d04b54ee9..17d6819669c8 100644
--- a/Documentation/devicetree/bindings/net/socfpga-dwmac.txt
+++ b/Documentation/devicetree/bindings/net/socfpga-dwmac.txt
@@ -28,7 +28,7 @@ Required properties:
 
 Example:
 
-gmii_to_sgmii_converter: phy@0x100000240 {
+gmii_to_sgmii_converter: phy@100000240 {
 	compatible = "altr,gmii-to-sgmii-2.0";
 	reg = <0x00000001 0x00000240 0x00000008>,
 		<0x00000001 0x00000200 0x00000040>;
diff --git a/Documentation/devicetree/bindings/nios2/nios2.txt b/Documentation/devicetree/bindings/nios2/nios2.txt
index d6d0a94cb3bb..b95e831bcba3 100644
--- a/Documentation/devicetree/bindings/nios2/nios2.txt
+++ b/Documentation/devicetree/bindings/nios2/nios2.txt
@@ -36,7 +36,7 @@ Optional properties:
 
 Example:
 
-cpu@0x0 {
+cpu@0 {
 	device_type = "cpu";
 	compatible = "altr,nios2-1.0";
 	reg = <0>;
diff --git a/Documentation/devicetree/bindings/pci/altera-pcie.txt b/Documentation/devicetree/bindings/pci/altera-pcie.txt
index 495880193adc..a1dc9366a8fc 100644
--- a/Documentation/devicetree/bindings/pci/altera-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/altera-pcie.txt
@@ -25,7 +25,7 @@ Optional properties:
 - bus-range:	PCI bus numbers covered
 
 Example
-	pcie_0: pcie@0xc00000000 {
+	pcie_0: pcie@c00000000 {
 		compatible = "altr,pcie-root-port-1.0";
 		reg = <0xc0000000 0x20000000>,
 			<0xff220000 0x00004000>;
diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
index 7b1e48bf172b..149d8f7f86b0 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
@@ -52,7 +52,7 @@ Additional required properties for imx7d-pcie:
 
 Example:
 
-	pcie@0x01000000 {
+	pcie@01000000 {
 		compatible = "fsl,imx6q-pcie", "snps,dw-pcie";
 		reg = <0x01ffc000 0x04000>,
 		      <0x01f00000 0x80000>;
diff --git a/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt b/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
index bdb7ab39d2d7..7bf9df047a1e 100644
--- a/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
@@ -21,7 +21,7 @@ Optional properties:
 - dma-coherent: Present if DMA operations are coherent.
 
 Hip05 Example (note that Hip06 is the same except compatible):
-	pcie@0xb0080000 {
+	pcie@b0080000 {
 		compatible = "hisilicon,hip05-pcie", "snps,dw-pcie";
 		reg = <0 0xb0080000 0 0x10000>, <0x220 0x00000000 0 0x2000>;
 		reg-names = "rc_dbi", "config";
diff --git a/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt b/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt
index cbc7847dbf6c..c1ce5a0a652e 100644
--- a/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt
+++ b/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt
@@ -45,7 +45,7 @@ Optional properties:
 - usb3_vbus-supply : regulator phandle for controller usb3 vbus
 
 Example:
-	usbphy: phy@0x01c13400 {
+	usbphy: phy@01c13400 {
 		#phy-cells = <1>;
 		compatible = "allwinner,sun4i-a10-usb-phy";
 		/* phy base regs, phy1 pmu reg, phy2 pmu reg */
diff --git a/Documentation/devicetree/bindings/pinctrl/brcm,cygnus-pinmux.txt b/Documentation/devicetree/bindings/pinctrl/brcm,cygnus-pinmux.txt
index 3600d5c6c4d7..3914529a3214 100644
--- a/Documentation/devicetree/bindings/pinctrl/brcm,cygnus-pinmux.txt
+++ b/Documentation/devicetree/bindings/pinctrl/brcm,cygnus-pinmux.txt
@@ -25,7 +25,7 @@ Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
 
 For example:
 
-	pinmux: pinmux@0x0301d0c8 {
+	pinmux: pinmux@0301d0c8 {
 		compatible = "brcm,cygnus-pinmux";
 		reg = <0x0301d0c8 0x1b0>;
 
diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-atlas7.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-atlas7.txt
index eecf028ff485..bf9b07016c87 100644
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-atlas7.txt
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-atlas7.txt
@@ -96,14 +96,14 @@ For example, pinctrl might have subnodes like the following:
 
 For a specific board, if it wants to use sd1,
 it can add the following to its board-specific .dts file.
-sd1: sd@0x12340000 {
+sd1: sd@12340000 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&sd1_pmx0>;
 }
 
 or
 
-sd1: sd@0x12340000 {
+sd1: sd@12340000 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&sd1_pmx1>;
 }
diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-sirf.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-sirf.txt
index 5f55be59d914..f8420520e14b 100644
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-sirf.txt
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-sirf.txt
@@ -41,7 +41,7 @@ For example, pinctrl might have subnodes like the following:
 
 For a specific board, if it wants to use uart2 without hardware flow control,
 it can add the following to its board-specific .dts file.
-uart2: uart@0xb0070000 {
+uart2: uart@b0070000 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart2_noflow_pins_a>;
 }
diff --git a/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.txt
index 4864e3a74de3..a01a3b8a2363 100644
--- a/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.txt
@@ -136,7 +136,7 @@ Example for rk3188:
 		#size-cells = <1>;
 		ranges;
 
-		gpio0: gpio0@0x2000a000 {
+		gpio0: gpio0@2000a000 {
 			compatible = "rockchip,rk3188-gpio-bank0";
 			reg = <0x2000a000 0x100>;
 			interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
@@ -149,7 +149,7 @@ Example for rk3188:
 			#interrupt-cells = <2>;
 		};
 
-		gpio1: gpio1@0x2003c000 {
+		gpio1: gpio1@2003c000 {
 			compatible = "rockchip,gpio-bank";
 			reg = <0x2003c000 0x100>;
 			interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/Documentation/devicetree/bindings/regulator/regulator.txt b/Documentation/devicetree/bindings/regulator/regulator.txt
index 378f6dc8b8bd..3cbf56ce66ea 100644
--- a/Documentation/devicetree/bindings/regulator/regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/regulator.txt
@@ -107,7 +107,7 @@ regulators (twl_reg1 and twl_reg2),
 		...
 	};
 
-	mmc: mmc@0x0 {
+	mmc: mmc@0 {
 		...
 		...
 		vmmc-supply = <&twl_reg1>;
diff --git a/Documentation/devicetree/bindings/serial/efm32-uart.txt b/Documentation/devicetree/bindings/serial/efm32-uart.txt
index 8adbab268ca3..4f8d8fde0c1c 100644
--- a/Documentation/devicetree/bindings/serial/efm32-uart.txt
+++ b/Documentation/devicetree/bindings/serial/efm32-uart.txt
@@ -12,7 +12,7 @@ Optional properties:
 
 Example:
 
-uart@0x4000c400 {
+uart@4000c400 {
 	compatible = "energymicro,efm32-uart";
 	reg = <0x4000c400 0x400>;
 	interrupts = <15>;
diff --git a/Documentation/devicetree/bindings/serio/allwinner,sun4i-ps2.txt b/Documentation/devicetree/bindings/serio/allwinner,sun4i-ps2.txt
index f311472990a7..75996b6111bb 100644
--- a/Documentation/devicetree/bindings/serio/allwinner,sun4i-ps2.txt
+++ b/Documentation/devicetree/bindings/serio/allwinner,sun4i-ps2.txt
@@ -14,7 +14,7 @@ Required properties:
 
 
 Example:
-	ps20: ps2@0x01c2a000 {
+	ps20: ps2@01c2a000 {
 		compatible = "allwinner,sun4i-a10-ps2";
 		reg = <0x01c2a000 0x400>;
 		interrupts = <0 62 4>;
diff --git a/Documentation/devicetree/bindings/soc/ti/keystone-navigator-qmss.txt b/Documentation/devicetree/bindings/soc/ti/keystone-navigator-qmss.txt
index 64c66a5644e7..77cd42cc5f54 100644
--- a/Documentation/devicetree/bindings/soc/ti/keystone-navigator-qmss.txt
+++ b/Documentation/devicetree/bindings/soc/ti/keystone-navigator-qmss.txt
@@ -220,7 +220,7 @@ qmss: qmss@2a40000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges;
-		pdsp0@0x2a10000 {
+		pdsp0@2a10000 {
 			reg = <0x2a10000 0x1000>,
 			      <0x2a0f000 0x100>,
 			      <0x2a0c000 0x3c8>,
diff --git a/Documentation/devicetree/bindings/sound/adi,axi-i2s.txt b/Documentation/devicetree/bindings/sound/adi,axi-i2s.txt
index 5875ca459ed1..4248b662deff 100644
--- a/Documentation/devicetree/bindings/sound/adi,axi-i2s.txt
+++ b/Documentation/devicetree/bindings/sound/adi,axi-i2s.txt
@@ -21,7 +21,7 @@ please check:
 
 Example:
 
-	i2s: i2s@0x77600000 {
+	i2s: i2s@77600000 {
 		compatible = "adi,axi-i2s-1.00.a";
 		reg = <0x77600000 0x1000>;
 		clocks = <&clk 15>, <&audio_clock>;
diff --git a/Documentation/devicetree/bindings/sound/adi,axi-spdif-tx.txt b/Documentation/devicetree/bindings/sound/adi,axi-spdif-tx.txt
index 4eb7997674a0..7b664e7cb4ae 100644
--- a/Documentation/devicetree/bindings/sound/adi,axi-spdif-tx.txt
+++ b/Documentation/devicetree/bindings/sound/adi,axi-spdif-tx.txt
@@ -20,7 +20,7 @@ please check:
 
 Example:
 
-	spdif: spdif@0x77400000 {
+	spdif: spdif@77400000 {
 		compatible = "adi,axi-spdif-tx-1.00.a";
 		reg = <0x77600000 0x1000>;
 		clocks = <&clk 15>, <&audio_clock>;
diff --git a/Documentation/devicetree/bindings/sound/ak4613.txt b/Documentation/devicetree/bindings/sound/ak4613.txt
index 1783f9ef0930..49a2e74fd9cb 100644
--- a/Documentation/devicetree/bindings/sound/ak4613.txt
+++ b/Documentation/devicetree/bindings/sound/ak4613.txt
@@ -20,7 +20,7 @@ Optional properties:
 Example:
 
 &i2c {
-	ak4613: ak4613@0x10 {
+	ak4613: ak4613@10 {
 		compatible = "asahi-kasei,ak4613";
 		reg = <0x10>;
 	};
diff --git a/Documentation/devicetree/bindings/sound/ak4642.txt b/Documentation/devicetree/bindings/sound/ak4642.txt
index 340784db6808..58e48ee97175 100644
--- a/Documentation/devicetree/bindings/sound/ak4642.txt
+++ b/Documentation/devicetree/bindings/sound/ak4642.txt
@@ -17,7 +17,7 @@ Optional properties:
 Example 1:
 
 &i2c {
-	ak4648: ak4648@0x12 {
+	ak4648: ak4648@12 {
 		compatible = "asahi-kasei,ak4642";
 		reg = <0x12>;
 	};
diff --git a/Documentation/devicetree/bindings/sound/max98371.txt b/Documentation/devicetree/bindings/sound/max98371.txt
index 6c285235e64b..8b2b2704b574 100644
--- a/Documentation/devicetree/bindings/sound/max98371.txt
+++ b/Documentation/devicetree/bindings/sound/max98371.txt
@@ -10,7 +10,7 @@ Required properties:
 Example:
 
 &i2c {
-	max98371: max98371@0x31 {
+	max98371: max98371@31 {
 		compatible = "maxim,max98371";
 		reg = <0x31>;
 	};
diff --git a/Documentation/devicetree/bindings/sound/max9867.txt b/Documentation/devicetree/bindings/sound/max9867.txt
index 394cd4eb17ec..b8bd914ee697 100644
--- a/Documentation/devicetree/bindings/sound/max9867.txt
+++ b/Documentation/devicetree/bindings/sound/max9867.txt
@@ -10,7 +10,7 @@ Required properties:
 Example:
 
 &i2c {
-	max9867: max9867@0x18 {
+	max9867: max9867@18 {
 		compatible = "maxim,max9867";
 		reg = <0x18>;
 	};
diff --git a/Documentation/devicetree/bindings/sound/renesas,fsi.txt b/Documentation/devicetree/bindings/sound/renesas,fsi.txt
index 0d0ab51105b0..0cf0f819b823 100644
--- a/Documentation/devicetree/bindings/sound/renesas,fsi.txt
+++ b/Documentation/devicetree/bindings/sound/renesas,fsi.txt
@@ -20,7 +20,7 @@ Required properties:
 
 Example:
 
-sh_fsi2: sh_fsi2@0xec230000 {
+sh_fsi2: sh_fsi2@ec230000 {
 	compatible = "renesas,sh_fsi2";
 	reg = <0xec230000 0x400>;
 	interrupts = <0 146 0x4>;
diff --git a/Documentation/devicetree/bindings/sound/rockchip-spdif.txt b/Documentation/devicetree/bindings/sound/rockchip-spdif.txt
index 0a1dc4e1815c..ec20c1271e92 100644
--- a/Documentation/devicetree/bindings/sound/rockchip-spdif.txt
+++ b/Documentation/devicetree/bindings/sound/rockchip-spdif.txt
@@ -33,7 +33,7 @@ Required properties on RK3288:
 
 Example for the rk3188 SPDIF controller:
 
-spdif: spdif@0x1011e000 {
+spdif: spdif@1011e000 {
 	compatible = "rockchip,rk3188-spdif", "rockchip,rk3066-spdif";
 	reg = <0x1011e000 0x2000>;
 	interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/Documentation/devicetree/bindings/sound/st,sti-asoc-card.txt b/Documentation/devicetree/bindings/sound/st,sti-asoc-card.txt
index 40068ec0e9a5..9c1ee52fed5b 100644
--- a/Documentation/devicetree/bindings/sound/st,sti-asoc-card.txt
+++ b/Documentation/devicetree/bindings/sound/st,sti-asoc-card.txt
@@ -51,7 +51,7 @@ Optional properties:
 
 Example:
 
-	sti_uni_player1: sti-uni-player@0x8D81000 {
+	sti_uni_player1: sti-uni-player@8D81000 {
 		compatible = "st,stih407-uni-player-hdmi";
 		#sound-dai-cells = <0>;
 		st,syscfg = <&syscfg_core>;
@@ -63,7 +63,7 @@ Example:
 		st,tdm-mode = <1>;
 	};
 
-	sti_uni_player2: sti-uni-player@0x8D82000 {
+	sti_uni_player2: sti-uni-player@8D82000 {
 		compatible = "st,stih407-uni-player-pcm-out";
 		#sound-dai-cells = <0>;
 		st,syscfg = <&syscfg_core>;
@@ -74,7 +74,7 @@ Example:
 		dma-names = "tx";
 	};
 
-	sti_uni_player3: sti-uni-player@0x8D85000 {
+	sti_uni_player3: sti-uni-player@8D85000 {
 		compatible = "st,stih407-uni-player-spdif";
 		#sound-dai-cells = <0>;
 		st,syscfg = <&syscfg_core>;
@@ -85,7 +85,7 @@ Example:
 		dma-names = "tx";
 	};
 
-	sti_uni_reader1: sti-uni-reader@0x8D84000 {
+	sti_uni_reader1: sti-uni-reader@8D84000 {
 		compatible = "st,stih407-uni-reader-hdmi";
 		#sound-dai-cells = <0>;
 		st,syscfg = <&syscfg_core>;
diff --git a/Documentation/devicetree/bindings/spi/efm32-spi.txt b/Documentation/devicetree/bindings/spi/efm32-spi.txt
index 2c1e6a43930b..e0fa61a1be0c 100644
--- a/Documentation/devicetree/bindings/spi/efm32-spi.txt
+++ b/Documentation/devicetree/bindings/spi/efm32-spi.txt
@@ -19,7 +19,7 @@ Recommended properties :
 
 Example:
 
-spi1: spi@0x4000c400 { /* USART1 */
+spi1: spi@4000c400 { /* USART1 */
 	#address-cells = <1>;
 	#size-cells = <0>;
 	compatible = "energymicro,efm32-spi";
diff --git a/Documentation/devicetree/bindings/thermal/thermal.txt b/Documentation/devicetree/bindings/thermal/thermal.txt
index 88b6ea1ad290..44d7cb2cb2c0 100644
--- a/Documentation/devicetree/bindings/thermal/thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/thermal.txt
@@ -239,7 +239,7 @@ cpus {
 	 * A simple fan controller which supports 10 speeds of operation
 	 * (represented as 0-9).
 	 */
-	fan0: fan@0x48 {
+	fan0: fan@48 {
 		...
 		cooling-min-level = <0>;
 		cooling-max-level = <9>;
@@ -252,7 +252,7 @@ ocp {
 	/*
 	 * A simple IC with a single bandgap temperature sensor.
 	 */
-	bandgap0: bandgap@0x0000ED00 {
+	bandgap0: bandgap@0000ED00 {
 		...
 		#thermal-sensor-cells = <0>;
 	};
@@ -330,7 +330,7 @@ ocp {
 	/*
 	 * A simple IC with several bandgap temperature sensors.
 	 */
-	bandgap0: bandgap@0x0000ED00 {
+	bandgap0: bandgap@0000ED00 {
 		...
 		#thermal-sensor-cells = <1>;
 	};
@@ -447,7 +447,7 @@ one thermal zone.
 	/*
 	 * A simple IC with a single temperature sensor.
 	 */
-	adc: sensor@0x49 {
+	adc: sensor@49 {
 		...
 		#thermal-sensor-cells = <0>;
 	};
@@ -458,7 +458,7 @@ ocp {
 	/*
 	 * A simple IC with a single bandgap temperature sensor.
 	 */
-	bandgap0: bandgap@0x0000ED00 {
+	bandgap0: bandgap@0000ED00 {
 		...
 		#thermal-sensor-cells = <0>;
 	};
@@ -516,7 +516,7 @@ with many sensors and many cooling devices.
 	/*
 	 * An IC with several temperature sensor.
 	 */
-	adc_dummy: sensor@0x50 {
+	adc_dummy: sensor@50 {
 		...
 		#thermal-sensor-cells = <1>; /* sensor internal ID */
 	};
diff --git a/Documentation/devicetree/bindings/ufs/ufs-qcom.txt b/Documentation/devicetree/bindings/ufs/ufs-qcom.txt
index 1f69ee1a61ea..21d9a93db2e9 100644
--- a/Documentation/devicetree/bindings/ufs/ufs-qcom.txt
+++ b/Documentation/devicetree/bindings/ufs/ufs-qcom.txt
@@ -32,7 +32,7 @@ Optional properties:
 
 Example:
 
-	ufsphy1: ufsphy@0xfc597000 {
+	ufsphy1: ufsphy@fc597000 {
 		compatible = "qcom,ufs-phy-qmp-20nm";
 		reg = <0xfc597000 0x800>;
 		reg-names = "phy_mem";
@@ -53,7 +53,7 @@ Example:
 			<&clock_gcc clk_gcc_ufs_rx_cfg_clk>;
 	};
 
-	ufshc@0xfc598000 {
+	ufshc@fc598000 {
 		...
 		phys = <&ufsphy1>;
 		phy-names = "ufsphy";
diff --git a/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt b/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
index a99ed5565b26..c39dfef76a18 100644
--- a/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
+++ b/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
@@ -46,7 +46,7 @@ Note: If above properties are not defined it can be assumed that the supply
 regulators or clocks are always on.
 
 Example:
-	ufshc@0xfc598000 {
+	ufshc@fc598000 {
 		compatible = "jedec,ufs-1.1";
 		reg = <0xfc598000 0x800>;
 		interrupts = <0 28 0>;
diff --git a/Documentation/devicetree/bindings/usb/ehci-st.txt b/Documentation/devicetree/bindings/usb/ehci-st.txt
index 9feea6c3e4d9..065c91d955ad 100644
--- a/Documentation/devicetree/bindings/usb/ehci-st.txt
+++ b/Documentation/devicetree/bindings/usb/ehci-st.txt
@@ -22,7 +22,7 @@ See: Documentation/devicetree/bindings/reset/reset.txt
 
 Example:
 
-	ehci1: usb@0xfe203e00 {
+	ehci1: usb@fe203e00 {
 		compatible = "st,st-ehci-300x";
 		reg = <0xfe203e00 0x100>;
 		interrupts = <GIC_SPI 148 IRQ_TYPE_NONE>;
diff --git a/Documentation/devicetree/bindings/usb/ohci-st.txt b/Documentation/devicetree/bindings/usb/ohci-st.txt
index d893ec9131c3..44c998c16f85 100644
--- a/Documentation/devicetree/bindings/usb/ohci-st.txt
+++ b/Documentation/devicetree/bindings/usb/ohci-st.txt
@@ -20,7 +20,7 @@ See: Documentation/devicetree/bindings/reset/reset.txt
 
 Example:
 
-	ohci0: usb@0xfe1ffc00 {
+	ohci0: usb@fe1ffc00 {
 		compatible = "st,st-ohci-300x";
 		reg = <0xfe1ffc00 0x100>;
 		interrupts = <GIC_SPI 149 IRQ_TYPE_NONE>;
diff --git a/Documentation/devicetree/bindings/watchdog/ingenic,jz4740-wdt.txt b/Documentation/devicetree/bindings/watchdog/ingenic,jz4740-wdt.txt
index e27763ef0049..3c7a1cd13b10 100644
--- a/Documentation/devicetree/bindings/watchdog/ingenic,jz4740-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/ingenic,jz4740-wdt.txt
@@ -6,7 +6,7 @@ reg: Register address and length for watchdog registers
 
 Example:
 
-watchdog: jz4740-watchdog@0x10002000 {
+watchdog: jz4740-watchdog@10002000 {
 	compatible = "ingenic,jz4740-watchdog";
 	reg = <0x10002000 0x100>;
 };
-- 
2.11.0
