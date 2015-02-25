Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Feb 2015 17:03:09 +0100 (CET)
Received: from sauhun.de ([89.238.76.85]:33441 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007055AbbBYQCeZ6fQh (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 25 Feb 2015 17:02:34 +0100
Received: from p4fe256bb.dip0.t-ipconnect.de ([79.226.86.187]:42004 helo=localhost)
        by pokefinder.org with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <wsa@the-dreams.de>)
        id 1YQePs-0001vt-96; Wed, 25 Feb 2015 17:02:28 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     linux-i2c@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-mips@linux-mips.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ludovic Desroches <ludovic.desroches@atmel.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org
Subject: [RFC V2 04/12] i2c: opal: make use of the new infrastructure for quirks
Date:   Wed, 25 Feb 2015 17:01:55 +0100
Message-Id: <1424880126-15047-5-git-send-email-wsa@the-dreams.de>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1424880126-15047-1-git-send-email-wsa@the-dreams.de>
References: <1424880126-15047-1-git-send-email-wsa@the-dreams.de>
Return-Path: <wsa@the-dreams.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45962
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
 drivers/i2c/busses/i2c-opal.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/i2c/busses/i2c-opal.c b/drivers/i2c/busses/i2c-opal.c
index 16f90b1a750894..b2788ecad5b3cb 100644
--- a/drivers/i2c/busses/i2c-opal.c
+++ b/drivers/i2c/busses/i2c-opal.c
@@ -104,17 +104,6 @@ static int i2c_opal_master_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 		req.buffer_ra = cpu_to_be64(__pa(msgs[0].buf));
 		break;
 	case 2:
-		/* For two messages, we basically support only simple
-		 * smbus transactions of a write plus a read. We might
-		 * want to allow also two writes but we'd have to bounce
-		 * the data into a single buffer.
-		 */
-		if ((msgs[0].flags & I2C_M_RD) || !(msgs[1].flags & I2C_M_RD))
-			return -EOPNOTSUPP;
-		if (msgs[0].len > 4)
-			return -EOPNOTSUPP;
-		if (msgs[0].addr != msgs[1].addr)
-			return -EOPNOTSUPP;
 		req.type = OPAL_I2C_SM_READ;
 		req.addr = cpu_to_be16(msgs[0].addr);
 		req.subaddr_sz = msgs[0].len;
@@ -210,6 +199,16 @@ static const struct i2c_algorithm i2c_opal_algo = {
 	.functionality	= i2c_opal_func,
 };
 
+/* For two messages, we basically support only simple
+ * smbus transactions of a write plus a read. We might
+ * want to allow also two writes but we'd have to bounce
+ * the data into a single buffer.
+ */
+static struct i2c_adapter_quirks i2c_opal_quirks = {
+	.flags = I2C_AQ_COMB_WRITE_THEN_READ,
+	.max_comb_1st_msg_len = 4,
+};
+
 static int i2c_opal_probe(struct platform_device *pdev)
 {
 	struct i2c_adapter	*adapter;
@@ -232,6 +231,7 @@ static int i2c_opal_probe(struct platform_device *pdev)
 
 	adapter->algo = &i2c_opal_algo;
 	adapter->algo_data = (void *)(unsigned long)opal_id;
+	adapter->quirks = &i2c_opal_quirks;
 	adapter->dev.parent = &pdev->dev;
 	adapter->dev.of_node = of_node_get(pdev->dev.of_node);
 	pname = of_get_property(pdev->dev.of_node, "ibm,port-name", NULL);
-- 
2.1.4
