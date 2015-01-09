Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Jan 2015 18:24:18 +0100 (CET)
Received: from sauhun.de ([89.238.76.85]:53153 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010654AbbAIRW2jS5VV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 9 Jan 2015 18:22:28 +0100
Received: from p4fe257be.dip0.t-ipconnect.de ([79.226.87.190]:48236 helo=localhost)
        by pokefinder.org with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <wsa@the-dreams.de>)
        id 1Y9dGP-0000Ml-MH; Fri, 09 Jan 2015 18:22:21 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     linux-i2c@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-mips@linux-mips.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ludovic Desroches <ludovic.desroches@atmel.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Jochen Friedrich <jochen@scram.de>,
        linux-kernel@vger.kernel.org
Subject: [RFC 06/11] i2c: cpm: make use of the new infrastructure for quirks
Date:   Fri,  9 Jan 2015 18:21:36 +0100
Message-Id: <1420824103-24169-7-git-send-email-wsa@the-dreams.de>
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1420824103-24169-1-git-send-email-wsa@the-dreams.de>
References: <1420824103-24169-1-git-send-email-wsa@the-dreams.de>
Return-Path: <wsa@the-dreams.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45031
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
 drivers/i2c/busses/i2c-cpm.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cpm.c b/drivers/i2c/busses/i2c-cpm.c
index 2d466538b2e2..714bdc837769 100644
--- a/drivers/i2c/busses/i2c-cpm.c
+++ b/drivers/i2c/busses/i2c-cpm.c
@@ -308,22 +308,12 @@ static int cpm_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 	struct i2c_reg __iomem *i2c_reg = cpm->i2c_reg;
 	struct i2c_ram __iomem *i2c_ram = cpm->i2c_ram;
 	struct i2c_msg *pmsg;
-	int ret, i;
+	int ret;
 	int tptr;
 	int rptr;
 	cbd_t __iomem *tbdf;
 	cbd_t __iomem *rbdf;
 
-	if (num > CPM_MAXBD)
-		return -EINVAL;
-
-	/* Check if we have any oversized READ requests */
-	for (i = 0; i < num; i++) {
-		pmsg = &msgs[i];
-		if (pmsg->len >= CPM_MAX_READ)
-			return -EINVAL;
-	}
-
 	/* Reset to use first buffer */
 	out_be16(&i2c_ram->rbptr, in_be16(&i2c_ram->rbase));
 	out_be16(&i2c_ram->tbptr, in_be16(&i2c_ram->tbase));
@@ -424,10 +414,18 @@ static const struct i2c_algorithm cpm_i2c_algo = {
 	.functionality = cpm_i2c_func,
 };
 
+/* CPM_MAX_READ is also limiting writes according to the code! */
+static struct i2c_adapter_quirks cpm_i2c_quirks = {
+	.max_num_msgs = CPM_MAXBD,
+	.max_read_len = CPM_MAX_READ,
+	.max_write_len = CPM_MAX_READ,
+};
+
 static const struct i2c_adapter cpm_ops = {
 	.owner		= THIS_MODULE,
 	.name		= "i2c-cpm",
 	.algo		= &cpm_i2c_algo,
+	.quirks		= &cpm_i2c_quirks,
 };
 
 static int cpm_i2c_setup(struct cpm_i2c *cpm)
-- 
2.1.3
