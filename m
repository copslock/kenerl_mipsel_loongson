From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Date: Fri, 27 Jul 2018 21:53:54 +0200
Subject: [PATCH] spi: dw: export dw_spi_set_cs
Message-ID: <20180727195354.6QvzrnQiyig7GOV-FkpTjVRUSaQwTLwYXMwZXQsgt_k@z>

Export dw_spi_set_cs so it can be used from the various IP integration
modules.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-dw.c | 3 ++-
 drivers/spi/spi-dw.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 0d8ccb8be5ec..683a4f137a25 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -133,7 +133,7 @@ static inline void dw_spi_debugfs_remove(struct dw_spi *dws)
 }
 #endif /* CONFIG_DEBUG_FS */
 
-static void dw_spi_set_cs(struct spi_device *spi, bool enable)
+void dw_spi_set_cs(struct spi_device *spi, bool enable)
 {
 	struct dw_spi *dws = spi_controller_get_devdata(spi->controller);
 	struct chip_data *chip = spi_get_ctldata(spi);
@@ -145,6 +145,7 @@ static void dw_spi_set_cs(struct spi_device *spi, bool enable)
 	if (!enable)
 		dw_writel(dws, DW_SPI_SER, BIT(spi->chip_select));
 }
+EXPORT_SYMBOL_GPL(dw_spi_set_cs);
 
 /* Return the max entries we can fill into tx fifo */
 static inline u32 tx_max(struct dw_spi *dws)
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 446013022849..0168b08364d5 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -245,6 +245,7 @@ struct dw_spi_chip {
 	void (*cs_control)(u32 command);
 };
 
+extern void dw_spi_set_cs(struct spi_device *spi, bool enable);
 extern int dw_spi_add_host(struct device *dev, struct dw_spi *dws);
 extern void dw_spi_remove_host(struct dw_spi *dws);
 extern int dw_spi_suspend_host(struct dw_spi *dws);
-- 
2.18.0
