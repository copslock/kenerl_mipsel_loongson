From: Jaedon Shin <jaedon.shin@gmail.com>
Date: Fri, 30 Dec 2016 15:30:00 +0900
Subject: [PATCH] spi: bcm-qspi: Enable the driver on BMIPS_GENERIC
Message-ID: <20161230063000.UF-vuZJw7CQ6qN99Od7vteH0JZV9tGpvgdp3Z0eqsfY@z>

The Broadcom BCM7XXX ARM and MIPS based SoCs share a similar hardware
block for SPI.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index ec4aa252d6e8..c982a01022ba 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -162,7 +162,8 @@ config SPI_BCM63XX_HSSPI
 
 config SPI_BCM_QSPI
 	tristate "Broadcom BSPI and MSPI controller support"
-	depends on ARCH_BRCMSTB || ARCH_BCM || ARCH_BCM_IPROC || COMPILE_TEST
+	depends on ARCH_BRCMSTB || ARCH_BCM || ARCH_BCM_IPROC || \
+			BMIPS_GENERIC || COMPILE_TEST
 	default ARCH_BCM_IPROC
 	help
 	  Enables support for the Broadcom SPI flash and MSPI controller.
-- 
2.11.0
