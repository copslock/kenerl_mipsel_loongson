Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Feb 2015 17:03:25 +0100 (CET)
Received: from sauhun.de ([89.238.76.85]:33443 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007100AbbBYQCeZ0XZR (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 25 Feb 2015 17:02:34 +0100
Received: from p4fe256bb.dip0.t-ipconnect.de ([79.226.86.187]:42001 helo=localhost)
        by pokefinder.org with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <wsa@the-dreams.de>)
        id 1YQePh-0001vP-5p; Wed, 25 Feb 2015 17:02:17 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     linux-i2c@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-mips@linux-mips.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ludovic Desroches <ludovic.desroches@atmel.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org
Subject: [RFC V2 01/12] i2c: add quirk structure to describe adapter flaws
Date:   Wed, 25 Feb 2015 17:01:52 +0100
Message-Id: <1424880126-15047-2-git-send-email-wsa@the-dreams.de>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1424880126-15047-1-git-send-email-wsa@the-dreams.de>
References: <1424880126-15047-1-git-send-email-wsa@the-dreams.de>
Return-Path: <wsa@the-dreams.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45963
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

The number of I2C adapters which are not fully I2C compatible is rising,
sadly. Drivers usually do handle the flaws, still the user receives only
some errno for a transfer which normally can be expected to work. This
patch introduces a formal description of flaws. One advantage is that
the core can check before the actual transfer if the messages could be
transferred at all. This is done in the next patch. Another advantage is
that we can pass this information to the user so the restrictions are
exactly known and further actions can be based on that. This will be
done later after some stabilization period for this description.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 include/linux/i2c.h | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index f17da50402a4da..243d1a1d78b248 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -449,6 +449,48 @@ int i2c_recover_bus(struct i2c_adapter *adap);
 int i2c_generic_gpio_recovery(struct i2c_adapter *adap);
 int i2c_generic_scl_recovery(struct i2c_adapter *adap);
 
+/**
+ * struct i2c_adapter_quirks - describe flaws of an i2c adapter
+ * @flags: see I2C_AQ_* for possible flags and read below
+ * @max_num_msgs: maximum number of messages per transfer
+ * @max_write_len: maximum length of a write message
+ * @max_read_len: maximum length of a read message
+ * @max_comb_1st_msg_len: maximum length of the first msg in a combined message
+ * @max_comb_2nd_msg_len: maximum length of the second msg in a combined message
+ *
+ * Note about combined messages: Some I2C controllers can only send one message
+ * per transfer, plus something called combined message or write-then-read.
+ * This is (usually) a small write message followed by a read message and
+ * barely enough to access register based devices like EEPROMs. There is a flag
+ * to support this mode. It implies max_num_msg = 2 and does the length checks
+ * with max_comb_*_len because combined message mode usually has its own
+ * limitations. Because of HW implementations, some controllers can actually do
+ * write-then-anything or other variants. To support that, write-then-read has
+ * been broken out into smaller bits like write-first and read-second which can
+ * be combined as needed.
+ */
+
+struct i2c_adapter_quirks {
+	u64 flags;
+	int max_num_msgs;
+	u16 max_write_len;
+	u16 max_read_len;
+	u16 max_comb_1st_msg_len;
+	u16 max_comb_2nd_msg_len;
+};
+
+/* enforce max_num_msgs = 2 and use max_comb_*_len for length checks */
+#define I2C_AQ_COMB			BIT(0)
+/* first combined message must be write */
+#define I2C_AQ_COMB_WRITE_FIRST		BIT(1)
+/* second combined message must be read */
+#define I2C_AQ_COMB_READ_SECOND		BIT(2)
+/* both combined messages must have the same target address */
+#define I2C_AQ_COMB_SAME_ADDR		BIT(3)
+/* convenience macro for typical write-then read case */
+#define I2C_AQ_COMB_WRITE_THEN_READ	(I2C_AQ_COMB | I2C_AQ_COMB_WRITE_FIRST | \
+					 I2C_AQ_COMB_READ_SECOND | I2C_AQ_COMB_SAME_ADDR)
+
 /*
  * i2c_adapter is the structure used to identify a physical i2c bus along
  * with the access algorithms necessary to access it.
@@ -474,6 +516,7 @@ struct i2c_adapter {
 	struct list_head userspace_clients;
 
 	struct i2c_bus_recovery_info *bus_recovery_info;
+	const struct i2c_adapter_quirks *quirks;
 };
 #define to_i2c_adapter(d) container_of(d, struct i2c_adapter, dev)
 
-- 
2.1.4
