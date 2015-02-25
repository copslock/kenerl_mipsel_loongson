Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Feb 2015 17:02:51 +0100 (CET)
Received: from sauhun.de ([89.238.76.85]:33445 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007274AbbBYQCe0ZEWL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 25 Feb 2015 17:02:34 +0100
Received: from p4fe256bb.dip0.t-ipconnect.de ([79.226.86.187]:42002 helo=localhost)
        by pokefinder.org with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <wsa@the-dreams.de>)
        id 1YQePk-0001vW-W4; Wed, 25 Feb 2015 17:02:21 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     linux-i2c@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-mips@linux-mips.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ludovic Desroches <ludovic.desroches@atmel.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org
Subject: [RFC V2 02/12] i2c: add quirk checks to core
Date:   Wed, 25 Feb 2015 17:01:53 +0100
Message-Id: <1424880126-15047-3-git-send-email-wsa@the-dreams.de>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1424880126-15047-1-git-send-email-wsa@the-dreams.de>
References: <1424880126-15047-1-git-send-email-wsa@the-dreams.de>
Return-Path: <wsa@the-dreams.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45961
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

Let the core do the checks if HW quirks prevent a transfer. Saves code
from drivers and adds consistency.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/i2c-core.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 210cf4874cb7ea..c5ca0e4006edb7 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -1929,6 +1929,65 @@ module_exit(i2c_exit);
  * ----------------------------------------------------
  */
 
+/* Check if val is exceeding the quirk IFF quirk is non 0 */
+#define i2c_quirk_exceeded(val, quirk) ((quirk) && ((val) > (quirk)))
+
+static int i2c_quirk_error(struct i2c_adapter *adap, struct i2c_msg *msg, char *err_msg)
+{
+	dev_err_ratelimited(&adap->dev, "quirk: %s (addr 0x%04x, size %u, %s)\n",
+			    err_msg, msg->addr, msg->len,
+			    msg->flags & I2C_M_RD ? "read" : "write");
+	return -EOPNOTSUPP;
+}
+
+static int i2c_check_for_quirks(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
+{
+	const struct i2c_adapter_quirks *q = adap->quirks;
+	int max_num = q->max_num_msgs, i;
+	bool do_len_check = true;
+
+	if (q->flags & I2C_AQ_COMB) {
+		max_num = 2;
+
+		/* special checks for combined messages */
+		if (num == 2) {
+			if (q->flags & I2C_AQ_COMB_WRITE_FIRST && msgs[0].flags & I2C_M_RD)
+				return i2c_quirk_error(adap, &msgs[0], "1st comb msg not write");
+
+			if (q->flags & I2C_AQ_COMB_READ_SECOND && !(msgs[1].flags & I2C_M_RD))
+				return i2c_quirk_error(adap, &msgs[1], "2nd comb msg not read");
+
+			if (q->flags & I2C_AQ_COMB_SAME_ADDR && msgs[0].addr != msgs[1].addr)
+				return i2c_quirk_error(adap, &msgs[0], "addresses do not match");
+
+			if (i2c_quirk_exceeded(msgs[0].len, q->max_comb_1st_msg_len))
+				return i2c_quirk_error(adap, &msgs[0], "msg too long");
+
+			if (i2c_quirk_exceeded(msgs[1].len, q->max_comb_2nd_msg_len))
+				return i2c_quirk_error(adap, &msgs[1], "msg too long");
+
+			do_len_check = false;
+		}
+	}
+
+	if (i2c_quirk_exceeded(num, max_num))
+		return i2c_quirk_error(adap, &msgs[0], "too many messages");
+
+	for (i = 0; i < num; i++) {
+		u16 len = msgs[i].len;
+
+		if (msgs[i].flags & I2C_M_RD) {
+			if (do_len_check && i2c_quirk_exceeded(len, q->max_read_len))
+				return i2c_quirk_error(adap, &msgs[i], "msg too long");
+		} else {
+			if (do_len_check && i2c_quirk_exceeded(len, q->max_write_len))
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
@@ -1946,6 +2005,9 @@ int __i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 	unsigned long orig_jiffies;
 	int ret, try;
 
+	if (adap->quirks && i2c_check_for_quirks(adap, msgs, num))
+		return -EOPNOTSUPP;
+
 	/* i2c_trace_msg gets enabled when tracepoint i2c_transfer gets
 	 * enabled.  This is an efficient way of keeping the for-loop from
 	 * being executed when not needed.
-- 
2.1.4
