Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jul 2018 13:49:31 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:44100 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993029AbeGQLsr2YQJT (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 17 Jul 2018 13:48:47 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id CB4522091A; Tue, 17 Jul 2018 13:48:41 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 96AAF20884;
        Tue, 17 Jul 2018 13:48:41 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Wolfram Sang <wsa@the-dreams.de>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        James Hogan <jhogan@kernel.org>
Cc:     Paul Burton <paul.burton@mips.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 3/5] i2c: designware: add MSCC Ocelot support
Date:   Tue, 17 Jul 2018 13:48:35 +0200
Message-Id: <20180717114837.21839-4-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180717114837.21839-1-alexandre.belloni@bootlin.com>
References: <20180717114837.21839-1-alexandre.belloni@bootlin.com>
Return-Path: <alexandre.belloni@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64875
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexandre.belloni@bootlin.com
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

The Microsemi Ocelot I2C controller is a designware IP. It also has a
second set of registers to allow tweaking SDA hold time and spike
filtering.

Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 .../bindings/i2c/i2c-designware.txt           |  5 ++++-
 drivers/i2c/busses/i2c-designware-core.h      |  1 +
 drivers/i2c/busses/i2c-designware-platdrv.c   | 20 +++++++++++++++++++
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-designware.txt b/Documentation/devicetree/bindings/i2c/i2c-designware.txt
index fbb0a6d8b964..7af4176da4af 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-designware.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-designware.txt
@@ -2,7 +2,7 @@
 
 Required properties :
 
- - compatible : should be "snps,designware-i2c"
+ - compatible : should be "snps,designware-i2c" or "mscc,ocelot-i2c"
  - reg : Offset and length of the register set for the device
  - interrupts : <IRQ> where IRQ is the interrupt number.
 
@@ -11,6 +11,9 @@ Recommended properties :
  - clock-frequency : desired I2C bus clock frequency in Hz.
 
 Optional properties :
+ - reg : for "mscc,ocelot-i2c", a second register set to configure the SDA hold
+   time, named ICPU_CFG:TWI_DELAY in the datasheet.
+
  - i2c-sda-hold-time-ns : should contain the SDA hold time in nanoseconds.
    This option is only supported in hardware blocks version 1.11a or newer.
 
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index b2778b6d8aca..37f63d084c1d 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -237,6 +237,7 @@
 struct dw_i2c_dev {
 	struct device		*dev;
 	void __iomem		*base;
+	void __iomem		*base_ext;
 	struct completion	cmd_complete;
 	struct clk		*clk;
 	struct reset_control	*rst;
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 5660daf6c92e..1a476a6e3551 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -204,6 +204,18 @@ static void i2c_dw_configure_slave(struct dw_i2c_dev *dev)
 	dev->mode = DW_IC_SLAVE;
 }
 
+#define MSCC_ICPU_CFG_TWI_DELAY		0x0
+#define MSCC_ICPU_CFG_TWI_DELAY_ENABLE	BIT(0)
+#define MSCC_ICPU_CFG_TWI_SPIKE_FILTER	0x4
+
+static int mscc_twi_set_sda_hold_time(struct dw_i2c_dev *dev)
+{
+	writel((dev->sda_hold_time << 1) | MSCC_ICPU_CFG_TWI_DELAY_ENABLE,
+	       dev->base_ext + MSCC_ICPU_CFG_TWI_DELAY);
+
+	return 0;
+}
+
 static void dw_i2c_set_fifo_size(struct dw_i2c_dev *dev, int id)
 {
 	u32 param, tx_fifo_depth, rx_fifo_depth;
@@ -342,6 +354,13 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 				1000000);
 	}
 
+	if (of_device_is_compatible(pdev->dev.of_node, "mscc,ocelot-i2c")) {
+		mem = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+		dev->base_ext = devm_ioremap_resource(&pdev->dev, mem);
+		if (!IS_ERR(dev->base_ext))
+			dev->set_sda_hold_time = mscc_twi_set_sda_hold_time;
+	}
+
 	dw_i2c_set_fifo_size(dev, pdev->id);
 
 	adap = &dev->adapter;
@@ -410,6 +429,7 @@ static int dw_i2c_plat_remove(struct platform_device *pdev)
 #ifdef CONFIG_OF
 static const struct of_device_id dw_i2c_of_match[] = {
 	{ .compatible = "snps,designware-i2c", },
+	{ .compatible = "mscc,ocelot-i2c", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, dw_i2c_of_match);
-- 
2.18.0
