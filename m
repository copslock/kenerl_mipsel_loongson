Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Feb 2015 17:03:43 +0100 (CET)
Received: from sauhun.de ([89.238.76.85]:33444 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007275AbbBYQCe2AEBC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 25 Feb 2015 17:02:34 +0100
Received: from p4fe256bb.dip0.t-ipconnect.de ([79.226.86.187]:42003 helo=localhost)
        by pokefinder.org with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <wsa@the-dreams.de>)
        id 1YQePo-0001vc-Jq; Wed, 25 Feb 2015 17:02:24 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     linux-i2c@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-mips@linux-mips.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ludovic Desroches <ludovic.desroches@atmel.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org
Subject: [RFC V2 03/12] i2c: at91: make use of the new infrastructure for quirks
Date:   Wed, 25 Feb 2015 17:01:54 +0100
Message-Id: <1424880126-15047-4-git-send-email-wsa@the-dreams.de>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1424880126-15047-1-git-send-email-wsa@the-dreams.de>
References: <1424880126-15047-1-git-send-email-wsa@the-dreams.de>
Return-Path: <wsa@the-dreams.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45964
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
 drivers/i2c/busses/i2c-at91.c | 32 +++++++++++---------------------
 1 file changed, 11 insertions(+), 21 deletions(-)

diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
index 636fd2efad8850..b3a70e8fc653c5 100644
--- a/drivers/i2c/busses/i2c-at91.c
+++ b/drivers/i2c/busses/i2c-at91.c
@@ -487,30 +487,10 @@ static int at91_twi_xfer(struct i2c_adapter *adap, struct i2c_msg *msg, int num)
 	if (ret < 0)
 		goto out;
 
-	/*
-	 * The hardware can handle at most two messages concatenated by a
-	 * repeated start via it's internal address feature.
-	 */
-	if (num > 2) {
-		dev_err(dev->dev,
-			"cannot handle more than two concatenated messages.\n");
-		ret = 0;
-		goto out;
-	} else if (num == 2) {
+	if (num == 2) {
 		int internal_address = 0;
 		int i;
 
-		if (msg->flags & I2C_M_RD) {
-			dev_err(dev->dev, "first transfer must be write.\n");
-			ret = -EINVAL;
-			goto out;
-		}
-		if (msg->len > 3) {
-			dev_err(dev->dev, "first message size must be <= 3.\n");
-			ret = -EINVAL;
-			goto out;
-		}
-
 		/* 1st msg is put into the internal address, start with 2nd */
 		m_start = &msg[1];
 		for (i = 0; i < msg->len; ++i) {
@@ -540,6 +520,15 @@ out:
 	return ret;
 }
 
+/*
+ * The hardware can handle at most two messages concatenated by a
+ * repeated start via it's internal address feature.
+ */
+static struct i2c_adapter_quirks at91_twi_quirks = {
+	.flags = I2C_AQ_COMB | I2C_AQ_COMB_WRITE_FIRST | I2C_AQ_COMB_SAME_ADDR,
+	.max_comb_1st_msg_len = 3,
+};
+
 static u32 at91_twi_func(struct i2c_adapter *adapter)
 {
 	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL
@@ -777,6 +766,7 @@ static int at91_twi_probe(struct platform_device *pdev)
 	dev->adapter.owner = THIS_MODULE;
 	dev->adapter.class = I2C_CLASS_DEPRECATED;
 	dev->adapter.algo = &at91_twi_algorithm;
+	dev->adapter.quirks = &at91_twi_quirks;
 	dev->adapter.dev.parent = dev->dev;
 	dev->adapter.nr = pdev->id;
 	dev->adapter.timeout = AT91_I2C_TIMEOUT;
-- 
2.1.4
