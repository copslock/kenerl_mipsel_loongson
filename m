Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Feb 2015 17:05:58 +0100 (CET)
Received: from sauhun.de ([89.238.76.85]:33520 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007339AbbBYQDEpQGJp (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 25 Feb 2015 17:03:04 +0100
Received: from p4fe256bb.dip0.t-ipconnect.de ([79.226.86.187]:42012 helo=localhost)
        by pokefinder.org with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <wsa@the-dreams.de>)
        id 1YQeQN-0001ya-1Z; Wed, 25 Feb 2015 17:02:59 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     linux-i2c@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-mips@linux-mips.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ludovic Desroches <ludovic.desroches@atmel.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Wolfram Sang <wsa@the-dreams.de>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
Subject: [RFC V2 12/12] i2c: bcm-iproc: make use of the new infrastructure for quirks
Date:   Wed, 25 Feb 2015 17:02:03 +0100
Message-Id: <1424880126-15047-13-git-send-email-wsa@the-dreams.de>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1424880126-15047-1-git-send-email-wsa@the-dreams.de>
References: <1424880126-15047-1-git-send-email-wsa@the-dreams.de>
Return-Path: <wsa@the-dreams.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45972
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wsa@the-dreams.de
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

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-bcm-iproc.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bcm-iproc.c b/drivers/i2c/busses/i2c-bcm-iproc.c
index d3c89157b33774..f9f2c2082151e2 100644
--- a/drivers/i2c/busses/i2c-bcm-iproc.c
+++ b/drivers/i2c/busses/i2c-bcm-iproc.c
@@ -160,14 +160,6 @@ static int bcm_iproc_i2c_xfer_single_msg(struct bcm_iproc_i2c_dev *iproc_i2c,
 	u32 val;
 	unsigned long time_left = msecs_to_jiffies(I2C_TIMEOUT_MESC);
 
-	/* need to reserve one byte in the FIFO for the slave address */
-	if (msg->len > M_TX_RX_FIFO_SIZE - 1) {
-		dev_err(iproc_i2c->device,
-			"only support data length up to %u bytes\n",
-			M_TX_RX_FIFO_SIZE - 1);
-		return -EOPNOTSUPP;
-	}
-
 	/* check if bus is busy */
 	if (!!(readl(iproc_i2c->base + M_CMD_OFFSET) &
 	       BIT(M_CMD_START_BUSY_SHIFT))) {
@@ -287,6 +279,12 @@ static const struct i2c_algorithm bcm_iproc_algo = {
 	.functionality = bcm_iproc_i2c_functionality,
 };
 
+static struct i2c_adapter_quirks bcm_iproc_i2c_quirks = {
+	/* need to reserve one byte in the FIFO for the slave address */
+	.max_read_len = M_TX_RX_FIFO_SIZE - 1,
+	.max_write_len = M_TX_RX_FIFO_SIZE - 1,
+};
+
 static int bcm_iproc_i2c_cfg_speed(struct bcm_iproc_i2c_dev *iproc_i2c)
 {
 	unsigned int bus_speed;
@@ -413,6 +411,7 @@ static int bcm_iproc_i2c_probe(struct platform_device *pdev)
 	i2c_set_adapdata(adap, iproc_i2c);
 	strlcpy(adap->name, "Broadcom iProc I2C adapter", sizeof(adap->name));
 	adap->algo = &bcm_iproc_algo;
+	adap->quirks = &bcm_iproc_i2c_quirks;
 	adap->dev.parent = &pdev->dev;
 	adap->dev.of_node = pdev->dev.of_node;
 
-- 
2.1.4
