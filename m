From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Date: Tue, 17 Jul 2018 16:23:11 +0200
Subject: [PATCH] spi: dw: allow providing own set_cs callback
Message-ID: <20180717142311.HR1vlmvApxvEpo5ALrkyo4Hso-A6byPT913zU83as9g@z>

Allow platform specific drivers to provide their own set_cs callback when
the IP integration requires it.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-dw.c | 3 +++
 drivers/spi/spi-dw.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index f693bfe95ab9..0d8ccb8be5ec 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -505,6 +505,9 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 	master->dev.of_node = dev->of_node;
 	master->flags = SPI_MASTER_GPIO_SS;
 
+	if (dws->set_cs)
+		master->set_cs = dws->set_cs;
+
 	/* Basic HW init */
 	spi_hw_init(dev, dws);
 
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 2cde2473b3e9..446013022849 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -112,6 +112,7 @@ struct dw_spi {
 	u32			reg_io_width;	/* DR I/O width in bytes */
 	u16			bus_num;
 	u16			num_cs;		/* supported slave numbers */
+	void (*set_cs)(struct spi_device *spi, bool enable);
 
 	/* Current message transfer state info */
 	size_t			len;
-- 
2.18.0
