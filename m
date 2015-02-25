Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Feb 2015 17:05:24 +0100 (CET)
Received: from sauhun.de ([89.238.76.85]:33508 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007337AbbBYQC5AI8Ol (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 25 Feb 2015 17:02:57 +0100
Received: from p4fe256bb.dip0.t-ipconnect.de ([79.226.86.187]:42010 helo=localhost)
        by pokefinder.org with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <wsa@the-dreams.de>)
        id 1YQeQF-0001xf-4Y; Wed, 25 Feb 2015 17:02:51 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     linux-i2c@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-mips@linux-mips.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ludovic Desroches <ludovic.desroches@atmel.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org
Subject: [RFC V2 10/12] i2c: viperboard: make use of the new infrastructure for quirks
Date:   Wed, 25 Feb 2015 17:02:01 +0100
Message-Id: <1424880126-15047-11-git-send-email-wsa@the-dreams.de>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1424880126-15047-1-git-send-email-wsa@the-dreams.de>
References: <1424880126-15047-1-git-send-email-wsa@the-dreams.de>
Return-Path: <wsa@the-dreams.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45970
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
 drivers/i2c/busses/i2c-viperboard.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-viperboard.c b/drivers/i2c/busses/i2c-viperboard.c
index 7533fa34d73711..47e88adf2011e1 100644
--- a/drivers/i2c/busses/i2c-viperboard.c
+++ b/drivers/i2c/busses/i2c-viperboard.c
@@ -288,10 +288,6 @@ static int vprbrd_i2c_xfer(struct i2c_adapter *i2c, struct i2c_msg *msgs,
 			i, pmsg->flags & I2C_M_RD ? "read" : "write",
 			pmsg->flags, pmsg->len, pmsg->addr);
 
-		/* msgs longer than 2048 bytes are not supported by adapter */
-		if (pmsg->len > 2048)
-			return -EINVAL;
-
 		mutex_lock(&vb->lock);
 		/* directly send the message */
 		if (pmsg->flags & I2C_M_RD) {
@@ -358,6 +354,11 @@ static const struct i2c_algorithm vprbrd_algorithm = {
 	.functionality	= vprbrd_i2c_func,
 };
 
+static struct i2c_adapter_quirks vprbrd_quirks = {
+	.max_read_len = 2048,
+	.max_write_len = 2048,
+};
+
 static int vprbrd_i2c_probe(struct platform_device *pdev)
 {
 	struct vprbrd *vb = dev_get_drvdata(pdev->dev.parent);
@@ -373,6 +374,7 @@ static int vprbrd_i2c_probe(struct platform_device *pdev)
 	vb_i2c->i2c.owner = THIS_MODULE;
 	vb_i2c->i2c.class = I2C_CLASS_HWMON;
 	vb_i2c->i2c.algo = &vprbrd_algorithm;
+	vb_i2c->i2c.quirks = &vprbrd_quirks;
 	vb_i2c->i2c.algo_data = vb;
 	/* save the param in usb capabable memory */
 	vb_i2c->bus_freq_param = i2c_bus_param;
-- 
2.1.4
