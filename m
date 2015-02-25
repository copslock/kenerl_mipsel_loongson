Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Feb 2015 17:05:40 +0100 (CET)
Received: from sauhun.de ([89.238.76.85]:33515 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007338AbbBYQDAbmmAB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 25 Feb 2015 17:03:00 +0100
Received: from p4fe256bb.dip0.t-ipconnect.de ([79.226.86.187]:42011 helo=localhost)
        by pokefinder.org with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <wsa@the-dreams.de>)
        id 1YQeQI-0001xx-Id; Wed, 25 Feb 2015 17:02:54 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     linux-i2c@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-mips@linux-mips.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ludovic Desroches <ludovic.desroches@atmel.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org
Subject: [RFC V2 11/12] i2c: pmcmsp: make use of the new infrastructure for quirks
Date:   Wed, 25 Feb 2015 17:02:02 +0100
Message-Id: <1424880126-15047-12-git-send-email-wsa@the-dreams.de>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1424880126-15047-1-git-send-email-wsa@the-dreams.de>
References: <1424880126-15047-1-git-send-email-wsa@the-dreams.de>
Return-Path: <wsa@the-dreams.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45971
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
 drivers/i2c/busses/i2c-pmcmsp.c | 42 ++++++++++++++++-------------------------
 1 file changed, 16 insertions(+), 26 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pmcmsp.c b/drivers/i2c/busses/i2c-pmcmsp.c
index d37d9db6681e7b..2c40edbf6224eb 100644
--- a/drivers/i2c/busses/i2c-pmcmsp.c
+++ b/drivers/i2c/busses/i2c-pmcmsp.c
@@ -456,14 +456,6 @@ static enum pmcmsptwi_xfer_result pmcmsptwi_xfer_cmd(
 		return -EINVAL;
 	}
 
-	if (cmd->read_len > MSP_MAX_BYTES_PER_RW ||
-	    cmd->write_len > MSP_MAX_BYTES_PER_RW) {
-		dev_err(&pmcmsptwi_adapter.dev,
-			"%s: Cannot transfer more than %d bytes\n",
-			__func__, MSP_MAX_BYTES_PER_RW);
-		return -EINVAL;
-	}
-
 	mutex_lock(&data->lock);
 	dev_dbg(&pmcmsptwi_adapter.dev,
 		"Setting address to 0x%04x\n", cmd->addr);
@@ -520,25 +512,14 @@ static int pmcmsptwi_master_xfer(struct i2c_adapter *adap,
 	struct pmcmsptwi_cfg oldcfg, newcfg;
 	int ret;
 
-	if (num > 2) {
-		dev_dbg(&adap->dev, "%d messages unsupported\n", num);
-		return -EINVAL;
-	} else if (num == 2) {
-		/* Check for a dual write-then-read command */
+	if (num == 2) {
 		struct i2c_msg *nextmsg = msg + 1;
-		if (!(msg->flags & I2C_M_RD) &&
-		    (nextmsg->flags & I2C_M_RD) &&
-		    msg->addr == nextmsg->addr) {
-			cmd.type = MSP_TWI_CMD_WRITE_READ;
-			cmd.write_len = msg->len;
-			cmd.write_data = msg->buf;
-			cmd.read_len = nextmsg->len;
-			cmd.read_data = nextmsg->buf;
-		} else {
-			dev_dbg(&adap->dev,
-				"Non write-read dual messages unsupported\n");
-			return -EINVAL;
-		}
+
+		cmd.type = MSP_TWI_CMD_WRITE_READ;
+		cmd.write_len = msg->len;
+		cmd.write_data = msg->buf;
+		cmd.read_len = nextmsg->len;
+		cmd.read_data = nextmsg->buf;
 	} else if (msg->flags & I2C_M_RD) {
 		cmd.type = MSP_TWI_CMD_READ;
 		cmd.read_len = msg->len;
@@ -598,6 +579,14 @@ static u32 pmcmsptwi_i2c_func(struct i2c_adapter *adapter)
 		I2C_FUNC_SMBUS_WORD_DATA | I2C_FUNC_SMBUS_PROC_CALL;
 }
 
+static struct i2c_adapter_quirks pmcmsptwi_i2c_quirks = {
+	.flags = I2C_AQ_COMB_WRITE_THEN_READ,
+	.max_write_len = MSP_MAX_BYTES_PER_RW,
+	.max_read_len = MSP_MAX_BYTES_PER_RW,
+	.max_comb_1st_msg_len = MSP_MAX_BYTES_PER_RW,
+	.max_comb_2nd_msg_len = MSP_MAX_BYTES_PER_RW,
+};
+
 /* -- Initialization -- */
 
 static struct i2c_algorithm pmcmsptwi_algo = {
@@ -609,6 +598,7 @@ static struct i2c_adapter pmcmsptwi_adapter = {
 	.owner		= THIS_MODULE,
 	.class		= I2C_CLASS_HWMON | I2C_CLASS_SPD,
 	.algo		= &pmcmsptwi_algo,
+	.quirks		= &pmcmsptwi_i2c_quirks,
 	.name		= DRV_NAME,
 };
 
-- 
2.1.4
