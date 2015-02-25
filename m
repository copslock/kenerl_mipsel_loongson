Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Feb 2015 17:04:00 +0100 (CET)
Received: from sauhun.de ([89.238.76.85]:33453 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007280AbbBYQCh70JdA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 25 Feb 2015 17:02:37 +0100
Received: from p4fe256bb.dip0.t-ipconnect.de ([79.226.86.187]:42005 helo=localhost)
        by pokefinder.org with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <wsa@the-dreams.de>)
        id 1YQePv-0001w2-Sm; Wed, 25 Feb 2015 17:02:32 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     linux-i2c@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-mips@linux-mips.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ludovic Desroches <ludovic.desroches@atmel.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org
Subject: [RFC V2 05/12] i2c: qup: make use of the new infrastructure for quirks
Date:   Wed, 25 Feb 2015 17:01:56 +0100
Message-Id: <1424880126-15047-6-git-send-email-wsa@the-dreams.de>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1424880126-15047-1-git-send-email-wsa@the-dreams.de>
References: <1424880126-15047-1-git-send-email-wsa@the-dreams.de>
Return-Path: <wsa@the-dreams.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45965
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
 drivers/i2c/busses/i2c-qup.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
index 4dad23bdffbe90..fdcbdab808e9fc 100644
--- a/drivers/i2c/busses/i2c-qup.c
+++ b/drivers/i2c/busses/i2c-qup.c
@@ -412,17 +412,6 @@ static int qup_i2c_read_one(struct qup_i2c_dev *qup, struct i2c_msg *msg)
 	unsigned long left;
 	int ret;
 
-	/*
-	 * The QUP block will issue a NACK and STOP on the bus when reaching
-	 * the end of the read, the length of the read is specified as one byte
-	 * which limits the possible read to 256 (QUP_READ_LIMIT) bytes.
-	 */
-	if (msg->len > QUP_READ_LIMIT) {
-		dev_err(qup->dev, "HW not capable of reads over %d bytes\n",
-			QUP_READ_LIMIT);
-		return -EINVAL;
-	}
-
 	qup->msg = msg;
 	qup->pos  = 0;
 
@@ -534,6 +523,15 @@ static const struct i2c_algorithm qup_i2c_algo = {
 	.functionality	= qup_i2c_func,
 };
 
+/*
+ * The QUP block will issue a NACK and STOP on the bus when reaching
+ * the end of the read, the length of the read is specified as one byte
+ * which limits the possible read to 256 (QUP_READ_LIMIT) bytes.
+ */
+static struct i2c_adapter_quirks qup_i2c_quirks = {
+	.max_read_len = QUP_READ_LIMIT,
+};
+
 static void qup_i2c_enable_clocks(struct qup_i2c_dev *qup)
 {
 	clk_prepare_enable(qup->clk);
@@ -670,6 +668,7 @@ static int qup_i2c_probe(struct platform_device *pdev)
 
 	i2c_set_adapdata(&qup->adap, qup);
 	qup->adap.algo = &qup_i2c_algo;
+	qup->adap.quirks = &qup_i2c_quirks;
 	qup->adap.dev.parent = qup->dev;
 	qup->adap.dev.of_node = pdev->dev.of_node;
 	strlcpy(qup->adap.name, "QUP I2C adapter", sizeof(qup->adap.name));
-- 
2.1.4
