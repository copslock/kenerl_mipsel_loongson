Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Jan 2015 18:24:51 +0100 (CET)
Received: from sauhun.de ([89.238.76.85]:53165 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011009AbbAIRWakuHUA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 9 Jan 2015 18:22:30 +0100
Received: from p4fe257be.dip0.t-ipconnect.de ([79.226.87.190]:48238 helo=localhost)
        by pokefinder.org with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <wsa@the-dreams.de>)
        id 1Y9dGS-0000NB-GB; Fri, 09 Jan 2015 18:22:24 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     linux-i2c@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-mips@linux-mips.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ludovic Desroches <ludovic.desroches@atmel.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org
Subject: [RFC 08/11] i2c: dln2: make use of the new infrastructure for quirks
Date:   Fri,  9 Jan 2015 18:21:38 +0100
Message-Id: <1420824103-24169-9-git-send-email-wsa@the-dreams.de>
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1420824103-24169-1-git-send-email-wsa@the-dreams.de>
References: <1420824103-24169-1-git-send-email-wsa@the-dreams.de>
Return-Path: <wsa@the-dreams.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45033
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

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/busses/i2c-dln2.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-dln2.c b/drivers/i2c/busses/i2c-dln2.c
index b3fb86af4cbb..b6f9ba7eb175 100644
--- a/drivers/i2c/busses/i2c-dln2.c
+++ b/drivers/i2c/busses/i2c-dln2.c
@@ -144,7 +144,6 @@ static int dln2_i2c_xfer(struct i2c_adapter *adapter,
 {
 	struct dln2_i2c *dln2 = i2c_get_adapdata(adapter);
 	struct i2c_msg *pmsg;
-	struct device *dev = &dln2->adapter.dev;
 	int i;
 
 	for (i = 0; i < num; i++) {
@@ -152,11 +151,6 @@ static int dln2_i2c_xfer(struct i2c_adapter *adapter,
 
 		pmsg = &msgs[i];
 
-		if (pmsg->len > DLN2_I2C_MAX_XFER_SIZE) {
-			dev_warn(dev, "maximum transfer size exceeded\n");
-			return -EOPNOTSUPP;
-		}
-
 		if (pmsg->flags & I2C_M_RD) {
 			ret = dln2_i2c_read(dln2, pmsg->addr, pmsg->buf,
 					    pmsg->len);
@@ -187,6 +181,11 @@ static const struct i2c_algorithm dln2_i2c_usb_algorithm = {
 	.functionality = dln2_i2c_func,
 };
 
+static struct i2c_adapter_quirks dln2_i2c_quirks = {
+	.max_read_len = DLN2_I2C_MAX_XFER_SIZE,
+	.max_write_len = DLN2_I2C_MAX_XFER_SIZE,
+};
+
 static int dln2_i2c_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -209,6 +208,7 @@ static int dln2_i2c_probe(struct platform_device *pdev)
 	dln2->adapter.owner = THIS_MODULE;
 	dln2->adapter.class = I2C_CLASS_HWMON;
 	dln2->adapter.algo = &dln2_i2c_usb_algorithm;
+	dln2->adapter.quirks = &dln2_i2c_quirks;
 	dln2->adapter.dev.parent = dev;
 	i2c_set_adapdata(&dln2->adapter, dln2);
 	snprintf(dln2->adapter.name, sizeof(dln2->adapter.name), "%s-%s-%d",
-- 
2.1.3
