Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Jan 2015 18:24:00 +0100 (CET)
Received: from sauhun.de ([89.238.76.85]:53136 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010989AbbAIRW05acNN (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 9 Jan 2015 18:22:26 +0100
Received: from p4fe257be.dip0.t-ipconnect.de ([79.226.87.190]:48231 helo=localhost)
        by pokefinder.org with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <wsa@the-dreams.de>)
        id 1Y9dGH-0000Lv-QJ; Fri, 09 Jan 2015 18:22:14 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     linux-i2c@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-mips@linux-mips.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ludovic Desroches <ludovic.desroches@atmel.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org
Subject: [RFC 01/11] i2c: add quirk structure to describe adapter flaws
Date:   Fri,  9 Jan 2015 18:21:31 +0100
Message-Id: <1420824103-24169-2-git-send-email-wsa@the-dreams.de>
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1420824103-24169-1-git-send-email-wsa@the-dreams.de>
References: <1420824103-24169-1-git-send-email-wsa@the-dreams.de>
Return-Path: <wsa@the-dreams.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45030
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

The number of I2C adapters which are not fully I2C compatible is rising,
sadly. Drivers usually do handle the flaws, still the user receives only
some errno for a transfer which normally can be expected to work. This
patch introduces a formal description of flaws. One advantage is that
the core can check before the actual transfer if the messages could be
transferred at all. This is done in the next patch. Another advantage is
that we can pass this information to the user so the restrictions are
exactly known and further actions can be based on that. This will be
done later after some stabilization period for this description.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 include/linux/i2c.h | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index e3a1721c8354..f8a642713706 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -447,6 +447,40 @@ int i2c_recover_bus(struct i2c_adapter *adap);
 int i2c_generic_gpio_recovery(struct i2c_adapter *adap);
 int i2c_generic_scl_recovery(struct i2c_adapter *adap);
 
+/**
+ * struct i2c_adapter_quirks - describe flaws of an i2c adapter
+ * @flags: see I2C_ADAPTER_QUIRK_* for possible flags
+ * @max_num_msgs: maximum number of messages per transfer
+ * @max_write_len: maximum length of a write message
+ * @max_read_len: maximum length of a read message
+ * @max_comb_write_len: maximum length of a write in a combined message
+ * @max_comb_read_len: maximum length of a read in a combined message
+ *
+ * Note about combined messages: Some I2C controllers can only send one
+ * message per transfer, plus something called combined message or
+ * write-then-read. This is a (usually) small write message followed by
+ * a read message and barely enough to access register based slaves like
+ * EEPROMs. There is a flag to support this mode. It implies max_num_msg = 2
+ * and does the length checks with max_comb_*_len because combined message mode
+ * usually has its own limitations. Read/write flags of the messages are also
+ * checked to be proper. Because of HW implementation, some controllers can
+ * actually do write-then-anything. To support that, write-then-read has been
+ * broken out into write-first and read-second.
+ */
+struct i2c_adapter_quirks {
+	u64 flags;
+	int max_num_msgs;
+	u16 max_write_len;
+	u16 max_read_len;
+	u16 max_comb_write_len;
+	u16 max_comb_read_len;
+};
+
+#define I2C_ADAPTER_QUIRK_COMB_WRITE_FIRST	BIT(0)
+#define I2C_ADAPTER_QUIRK_COMB_READ_SECOND	BIT(1)
+#define I2C_ADAPTER_QUIRK_COMB_WRITE_THEN_READ	(I2C_ADAPTER_QUIRK_COMB_WRITE_FIRST | \
+						I2C_ADAPTER_QUIRK_COMB_READ_SECOND)
+
 /*
  * i2c_adapter is the structure used to identify a physical i2c bus along
  * with the access algorithms necessary to access it.
@@ -472,6 +506,7 @@ struct i2c_adapter {
 	struct list_head userspace_clients;
 
 	struct i2c_bus_recovery_info *bus_recovery_info;
+	struct i2c_adapter_quirks *quirks;
 };
 #define to_i2c_adapter(d) container_of(d, struct i2c_adapter, dev)
 
-- 
2.1.3
