From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Date: Tue, 31 Jul 2018 16:38:53 +0200
Subject: [PATCH] spi: dw: document Microsemi integration
Message-ID: <20180731143853.knvAEMtIheYTOKXoJE2iux6UJiBXrPAYxkxFG_qDlLk@z>

The integration of the Designware SPI controller on Microsemi SoCs requires
an extra register set to be able to give the IP control of the SPI
interface.

Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
index 204b311e0400..642d3fb1ef85 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
@@ -1,8 +1,10 @@
 Synopsys DesignWare AMBA 2.0 Synchronous Serial Interface.
 
 Required properties:
-- compatible : "snps,dw-apb-ssi"
-- reg : The register base for the controller.
+- compatible : "snps,dw-apb-ssi" or "mscc,<soc>-spi", where soc is "ocelot" or
+  "jaguar2"
+- reg : The register base for the controller. For "mscc,<soc>-spi", a second
+  register set is required (named ICPU_CFG:SPI_MST)
 - interrupts : One interrupt, used by the controller.
 - #address-cells : <1>, as required by generic SPI binding.
 - #size-cells : <0>, also as required by generic SPI binding.
-- 
2.18.0
