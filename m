Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Jan 2015 18:25:08 +0100 (CET)
Received: from sauhun.de ([89.238.76.85]:53173 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010849AbbAIRWbw8OVI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 9 Jan 2015 18:22:31 +0100
Received: from p4fe257be.dip0.t-ipconnect.de ([79.226.87.190]:48239 helo=localhost)
        by pokefinder.org with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <wsa@the-dreams.de>)
        id 1Y9dGT-0000NL-Uj; Fri, 09 Jan 2015 18:22:26 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     linux-i2c@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-mips@linux-mips.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ludovic Desroches <ludovic.desroches@atmel.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org
Subject: [RFC 09/11] i2c: powermac: make use of the new infrastructure for quirks
Date:   Fri,  9 Jan 2015 18:21:39 +0100
Message-Id: <1420824103-24169-10-git-send-email-wsa@the-dreams.de>
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1420824103-24169-1-git-send-email-wsa@the-dreams.de>
References: <1420824103-24169-1-git-send-email-wsa@the-dreams.de>
Return-Path: <wsa@the-dreams.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45034
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
 drivers/i2c/busses/i2c-powermac.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-powermac.c b/drivers/i2c/busses/i2c-powermac.c
index 60a53c169ed2..6abcf696e359 100644
--- a/drivers/i2c/busses/i2c-powermac.c
+++ b/drivers/i2c/busses/i2c-powermac.c
@@ -153,12 +153,6 @@ static int i2c_powermac_master_xfer(	struct i2c_adapter *adap,
 	int			read;
 	int			addrdir;
 
-	if (num != 1) {
-		dev_err(&adap->dev,
-			"Multi-message I2C transactions not supported\n");
-		return -EOPNOTSUPP;
-	}
-
 	if (msgs->flags & I2C_M_TEN)
 		return -EINVAL;
 	read = (msgs->flags & I2C_M_RD) != 0;
@@ -205,6 +199,9 @@ static const struct i2c_algorithm i2c_powermac_algorithm = {
 	.functionality	= i2c_powermac_func,
 };
 
+static struct i2c_adapter_quirks i2c_powermac_quirks = {
+	.max_num_msgs = 1,
+};
 
 static int i2c_powermac_remove(struct platform_device *dev)
 {
@@ -434,6 +431,7 @@ static int i2c_powermac_probe(struct platform_device *dev)
 
 	platform_set_drvdata(dev, adapter);
 	adapter->algo = &i2c_powermac_algorithm;
+	adapter->quirks = &i2c_powermac_quirks;
 	i2c_set_adapdata(adapter, bus);
 	adapter->dev.parent = &dev->dev;
 
-- 
2.1.3
