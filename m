Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Jan 2015 18:22:46 +0100 (CET)
Received: from sauhun.de ([89.238.76.85]:53137 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010978AbbAIRW0vRuEf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 9 Jan 2015 18:22:26 +0100
Received: from p4fe257be.dip0.t-ipconnect.de ([79.226.87.190]:48232 helo=localhost)
        by pokefinder.org with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <wsa@the-dreams.de>)
        id 1Y9dGJ-0000M1-9A; Fri, 09 Jan 2015 18:22:15 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     linux-i2c@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-mips@linux-mips.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ludovic Desroches <ludovic.desroches@atmel.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org
Subject: [RFC 02/11] i2c: add quirk checks to core
Date:   Fri,  9 Jan 2015 18:21:32 +0100
Message-Id: <1420824103-24169-3-git-send-email-wsa@the-dreams.de>
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1420824103-24169-1-git-send-email-wsa@the-dreams.de>
References: <1420824103-24169-1-git-send-email-wsa@the-dreams.de>
Return-Path: <wsa@the-dreams.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45026
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

Let the core do the checks if HW quirks prevent a transfer. Saves code
from drivers and adds consistency.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/i2c-core.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 39d25a8cb1ad..7b10a19abf5b 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -2063,6 +2063,56 @@ module_exit(i2c_exit);
  * ----------------------------------------------------
  */
 
+/* Check if val is exceeding the quirk IFF quirk is non 0 */
+#define i2c_quirk_exceeded(val, quirk) ((quirk) && ((val) > (quirk)))
+
+static int i2c_quirk_error(struct i2c_adapter *adap, struct i2c_msg *msg, char *err_msg)
+{
+	dev_err(&adap->dev, "quirk: %s (addr 0x%04x, size %u)\n", err_msg, msg->addr, msg->len);
+	return -EOPNOTSUPP;
+}
+
+static int i2c_check_for_quirks(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
+{
+	struct i2c_adapter_quirks *q = adap->quirks;
+	u16 max_read = q->max_read_len, max_write = q->max_write_len;
+	int max_num = q->max_num_msgs, i;
+
+	if (q->flags & I2C_ADAPTER_QUIRK_COMB_WRITE_THEN_READ)
+		max_num = 2;
+
+	if (i2c_quirk_exceeded(num, max_num))
+		return i2c_quirk_error(adap, &msgs[0], "too many messages");
+
+	if (num == 2 && q->flags & I2C_ADAPTER_QUIRK_COMB_WRITE_FIRST) {
+		if (msgs[0].flags & I2C_M_RD)
+			return i2c_quirk_error(adap, &msgs[0], "invalid first write msg");
+
+		max_write = q->max_comb_write_len;
+	}
+
+	if (num == 2 && q->flags & I2C_ADAPTER_QUIRK_COMB_READ_SECOND) {
+		if (!(msgs[1].flags & I2C_M_RD) || msgs[0].addr != msgs[1].addr)
+			return i2c_quirk_error(adap, &msgs[1], "invalid second read msg");
+
+		max_read = q->max_comb_read_len;
+	}
+
+	for (i = 0; i < num; i++) {
+		u16 len = msgs[i].len;
+
+		if (msgs[i].flags & I2C_M_RD) {
+			if (i2c_quirk_exceeded(len, max_read))
+				return i2c_quirk_error(adap, &msgs[i], "msg too long");
+		} else {
+			if (i2c_quirk_exceeded(len, max_write))
+				return i2c_quirk_error(adap, &msgs[i], "msg too long");
+		}
+	}
+
+	return 0;
+}
+
 /**
  * __i2c_transfer - unlocked flavor of i2c_transfer
  * @adap: Handle to I2C bus
@@ -2080,6 +2130,9 @@ int __i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 	unsigned long orig_jiffies;
 	int ret, try;
 
+	if (adap->quirks && i2c_check_for_quirks(adap, msgs, num))
+		return -EOPNOTSUPP;
+
 	/* i2c_trace_msg gets enabled when tracepoint i2c_transfer gets
 	 * enabled.  This is an efficient way of keeping the for-loop from
 	 * being executed when not needed.
-- 
2.1.3
