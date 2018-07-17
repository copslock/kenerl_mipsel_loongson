Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jul 2018 13:48:52 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:44072 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992482AbeGQLsquM1jT (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 17 Jul 2018 13:48:46 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 3357120876; Tue, 17 Jul 2018 13:48:41 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 08E2620765;
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
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 1/5] i2c: designware: factorize setting SDA hold time
Date:   Tue, 17 Jul 2018 13:48:33 +0200
Message-Id: <20180717114837.21839-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180717114837.21839-1-alexandre.belloni@bootlin.com>
References: <20180717114837.21839-1-alexandre.belloni@bootlin.com>
Return-Path: <alexandre.belloni@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64872
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

Factorize setting the SDA hold time in a new function
i2c_dw_set_sda_hold_time() that is used for both master and slave mode.

This conveniently pulls the fix for the spurious warning from commit
7a20e707aae2 ("i2c: designware: suppress unneeded SDA hold time warnings")
in slave mode.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/i2c/busses/i2c-designware-common.c | 27 ++++++++++++++++++++++
 drivers/i2c/busses/i2c-designware-core.h   |  1 +
 drivers/i2c/busses/i2c-designware-master.c | 22 +-----------------
 drivers/i2c/busses/i2c-designware-slave.c  | 22 +-----------------
 4 files changed, 30 insertions(+), 42 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-common.c b/drivers/i2c/busses/i2c-designware-common.c
index 48914dfc8ce8..9afc3e075b33 100644
--- a/drivers/i2c/busses/i2c-designware-common.c
+++ b/drivers/i2c/busses/i2c-designware-common.c
@@ -293,5 +293,32 @@ u32 i2c_dw_read_comp_param(struct dw_i2c_dev *dev)
 }
 EXPORT_SYMBOL_GPL(i2c_dw_read_comp_param);
 
+void i2c_dw_set_sda_hold_time(struct dw_i2c_dev *dev)
+{
+	u32 reg;
+
+	/* Configure SDA Hold Time if required. */
+	reg = dw_readl(dev, DW_IC_COMP_VERSION);
+	if (reg >= DW_IC_SDA_HOLD_MIN_VERS) {
+		if (!dev->sda_hold_time) {
+			/* Keep previous hold time setting if no one set it. */
+			dev->sda_hold_time = dw_readl(dev, DW_IC_SDA_HOLD);
+		}
+		/*
+		 * Workaround for avoiding TX arbitration lost in case I2C
+		 * slave pulls SDA down "too quickly" after falling egde of
+		 * SCL by enabling non-zero SDA RX hold. Specification says it
+		 * extends incoming SDA low to high transition while SCL is
+		 * high but it apprears to help also above issue.
+		 */
+		if (!(dev->sda_hold_time & DW_IC_SDA_HOLD_RX_MASK))
+			dev->sda_hold_time |= 1 << DW_IC_SDA_HOLD_RX_SHIFT;
+		dw_writel(dev, dev->sda_hold_time, DW_IC_SDA_HOLD);
+	} else if (dev->sda_hold_time) {
+		dev_warn(dev->dev,
+			 "Hardware too old to adjust SDA hold time.\n");
+	}
+}
+
 MODULE_DESCRIPTION("Synopsys DesignWare I2C bus adapter core");
 MODULE_LICENSE("GPL");
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index d690e648bc01..bc43fb9ac1cf 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -306,6 +306,7 @@ int i2c_dw_handle_tx_abort(struct dw_i2c_dev *dev);
 u32 i2c_dw_func(struct i2c_adapter *adap);
 void i2c_dw_disable(struct dw_i2c_dev *dev);
 void i2c_dw_disable_int(struct dw_i2c_dev *dev);
+void i2c_dw_set_sda_hold_time(struct dw_i2c_dev *dev);
 
 static inline void __i2c_dw_enable(struct dw_i2c_dev *dev)
 {
diff --git a/drivers/i2c/busses/i2c-designware-master.c b/drivers/i2c/busses/i2c-designware-master.c
index 27436a937492..826329f8e30b 100644
--- a/drivers/i2c/busses/i2c-designware-master.c
+++ b/drivers/i2c/busses/i2c-designware-master.c
@@ -146,27 +146,7 @@ static int i2c_dw_init_master(struct dw_i2c_dev *dev)
 		}
 	}
 
-	/* Configure SDA Hold Time if required */
-	reg = dw_readl(dev, DW_IC_COMP_VERSION);
-	if (reg >= DW_IC_SDA_HOLD_MIN_VERS) {
-		if (!dev->sda_hold_time) {
-			/* Keep previous hold time setting if no one set it */
-			dev->sda_hold_time = dw_readl(dev, DW_IC_SDA_HOLD);
-		}
-		/*
-		 * Workaround for avoiding TX arbitration lost in case I2C
-		 * slave pulls SDA down "too quickly" after falling egde of
-		 * SCL by enabling non-zero SDA RX hold. Specification says it
-		 * extends incoming SDA low to high transition while SCL is
-		 * high but it apprears to help also above issue.
-		 */
-		if (!(dev->sda_hold_time & DW_IC_SDA_HOLD_RX_MASK))
-			dev->sda_hold_time |= 1 << DW_IC_SDA_HOLD_RX_SHIFT;
-		dw_writel(dev, dev->sda_hold_time, DW_IC_SDA_HOLD);
-	} else if (dev->sda_hold_time) {
-		dev_warn(dev->dev,
-			"Hardware too old to adjust SDA hold time.\n");
-	}
+	i2c_dw_set_sda_hold_time(dev);
 
 	i2c_dw_configure_fifo_master(dev);
 	i2c_dw_release_lock(dev);
diff --git a/drivers/i2c/busses/i2c-designware-slave.c b/drivers/i2c/busses/i2c-designware-slave.c
index 8ce2cd368477..150e5edb064c 100644
--- a/drivers/i2c/busses/i2c-designware-slave.c
+++ b/drivers/i2c/busses/i2c-designware-slave.c
@@ -77,27 +77,7 @@ static int i2c_dw_init_slave(struct dw_i2c_dev *dev)
 	/* Disable the adapter. */
 	__i2c_dw_disable(dev);
 
-	/* Configure SDA Hold Time if required. */
-	reg = dw_readl(dev, DW_IC_COMP_VERSION);
-	if (reg >= DW_IC_SDA_HOLD_MIN_VERS) {
-		if (!dev->sda_hold_time) {
-			/* Keep previous hold time setting if no one set it. */
-			dev->sda_hold_time = dw_readl(dev, DW_IC_SDA_HOLD);
-		}
-		/*
-		 * Workaround for avoiding TX arbitration lost in case I2C
-		 * slave pulls SDA down "too quickly" after falling egde of
-		 * SCL by enabling non-zero SDA RX hold. Specification says it
-		 * extends incoming SDA low to high transition while SCL is
-		 * high but it apprears to help also above issue.
-		 */
-		if (!(dev->sda_hold_time & DW_IC_SDA_HOLD_RX_MASK))
-			dev->sda_hold_time |= 1 << DW_IC_SDA_HOLD_RX_SHIFT;
-		dw_writel(dev, dev->sda_hold_time, DW_IC_SDA_HOLD);
-	} else {
-		dev_warn(dev->dev,
-			 "Hardware too old to adjust SDA hold time.\n");
-	}
+	i2c_dw_set_sda_hold_time(dev);
 
 	i2c_dw_configure_fifo_slave(dev);
 	i2c_dw_release_lock(dev);
-- 
2.18.0
