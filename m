Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Dec 2016 10:33:50 +0100 (CET)
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33913 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992907AbcLIJcecBnCt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Dec 2016 10:32:34 +0100
Received: by mail-wm0-f65.google.com with SMTP id g23so2774005wme.1
        for <linux-mips@linux-mips.org>; Fri, 09 Dec 2016 01:32:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=N4AA2IKA8HSK/SJIxOng8UvSMBdAC+IXrTPk+G88VcE=;
        b=JKrjrmEJPOmNtoSt1TCamu2r70bQPWXFxwvEpkRE1Nq4IPDbXM8mCmSo6nNGzAwhvr
         qz3ch42MYL+DhSA+SF5XeIRvgv0HYcKVI+tCK4Pvt8eUk5pbPh5fKiuHqeNJs34/dO4s
         IR3RprqwW/UGjG8nmWP9uXxr0BDUYT7eqnxfq5ZmeMmzbGqmVKRWUPw2HubCacoxZYWc
         iYtkB6o16sZXG3qOqzXJVA4P5YiMgF9FA30b5HbAYETC1Aq82nRNS/ydjSAoKoJkKL4q
         GzegW0/Egcn8A1G2zcLMhLSQAD9YFkREmJY1To5ZC8g83oQkEiFqxdWdU1WJQrvpuFuZ
         On5A==
X-Gm-Message-State: AKaTC00Vhald152MkcOGpQ/koF6FrdrN5KcMt8fQoM68pY24184EWsI9QXNm0fwR/mKCGg==
X-Received: by 10.28.173.131 with SMTP id w125mr5731407wme.0.1481275948944;
        Fri, 09 Dec 2016 01:32:28 -0800 (PST)
Received: from localhost.localdomain (HSI-KBW-046-005-206-247.hsi8.kabel-badenwuerttemberg.de. [46.5.206.247])
        by smtp.gmail.com with ESMTPSA id k11sm19529619wmf.24.2016.12.09.01.32.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Dec 2016 01:32:28 -0800 (PST)
From:   Jan Glauber <jglauber@cavium.com>
To:     Wolfram Sang <wsa-dev@sang-engineering.com>
Cc:     Paul Burton <paul.burton@imgtec.com>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        linux-i2c@vger.kernel.org, linux-mips@linux-mips.org,
        David Daney <david.daney@cavium.com>,
        Jan Glauber <jglauber@cavium.com>
Subject: [PATCH 3/4] i2c: octeon: thunderx: Limit register access retries
Date:   Fri,  9 Dec 2016 10:31:57 +0100
Message-Id: <20161209093158.3161-4-jglauber@cavium.com>
X-Mailer: git-send-email 2.9.0.rc0.21.g7777322
In-Reply-To: <20161209093158.3161-1-jglauber@cavium.com>
References: <20161209093158.3161-1-jglauber@cavium.com>
Return-Path: <jan.glauber@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55985
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jglauber@cavium.com
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

Do not infinitely retry register readq and writeq operations
in order to not lock up the CPU in case the TWSI gets stuck.

Return -EIO in case of a failed data read. For all other
cases just return so subsequent operations will fail
and trigger the recovery.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/i2c/busses/i2c-octeon-core.c |  4 +++-
 drivers/i2c/busses/i2c-octeon-core.h | 21 ++++++++++++++++-----
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-octeon-core.c b/drivers/i2c/busses/i2c-octeon-core.c
index 3d10f1a..1d8775799 100644
--- a/drivers/i2c/busses/i2c-octeon-core.c
+++ b/drivers/i2c/busses/i2c-octeon-core.c
@@ -342,7 +342,9 @@ static int octeon_i2c_read(struct octeon_i2c *i2c, int target,
 		if (result)
 			return result;
 
-		data[i] = octeon_i2c_data_read(i2c);
+		data[i] = octeon_i2c_data_read(i2c, &result);
+		if (result)
+			return result;
 		if (recv_len && i == 0) {
 			if (data[i] > I2C_SMBUS_BLOCK_MAX + 1)
 				return -EPROTO;
diff --git a/drivers/i2c/busses/i2c-octeon-core.h b/drivers/i2c/busses/i2c-octeon-core.h
index 87151ea..e160f83 100644
--- a/drivers/i2c/busses/i2c-octeon-core.h
+++ b/drivers/i2c/busses/i2c-octeon-core.h
@@ -141,11 +141,14 @@ static inline void octeon_i2c_writeq_flush(u64 val, void __iomem *addr)
  */
 static inline void octeon_i2c_reg_write(struct octeon_i2c *i2c, u64 eop_reg, u8 data)
 {
+	int tries = 1000;
 	u64 tmp;
 
 	__raw_writeq(SW_TWSI_V | eop_reg | data, i2c->twsi_base + SW_TWSI(i2c));
 	do {
 		tmp = __raw_readq(i2c->twsi_base + SW_TWSI(i2c));
+		if (--tries < 0)
+			return;
 	} while ((tmp & SW_TWSI_V) != 0);
 }
 
@@ -163,24 +166,32 @@ static inline void octeon_i2c_reg_write(struct octeon_i2c *i2c, u64 eop_reg, u8
  *
  * The I2C core registers are accessed indirectly via the SW_TWSI CSR.
  */
-static inline u8 octeon_i2c_reg_read(struct octeon_i2c *i2c, u64 eop_reg)
+static inline int octeon_i2c_reg_read(struct octeon_i2c *i2c, u64 eop_reg,
+				      int *error)
 {
+	int tries = 1000;
 	u64 tmp;
 
 	__raw_writeq(SW_TWSI_V | eop_reg | SW_TWSI_R, i2c->twsi_base + SW_TWSI(i2c));
 	do {
 		tmp = __raw_readq(i2c->twsi_base + SW_TWSI(i2c));
+		if (--tries < 0) {
+			/* signal that the returned data is invalid */
+			if (error)
+				*error = -EIO;
+			return 0;
+		}
 	} while ((tmp & SW_TWSI_V) != 0);
 
 	return tmp & 0xFF;
 }
 
 #define octeon_i2c_ctl_read(i2c)					\
-	octeon_i2c_reg_read(i2c, SW_TWSI_EOP_TWSI_CTL)
-#define octeon_i2c_data_read(i2c)					\
-	octeon_i2c_reg_read(i2c, SW_TWSI_EOP_TWSI_DATA)
+	octeon_i2c_reg_read(i2c, SW_TWSI_EOP_TWSI_CTL, NULL)
+#define octeon_i2c_data_read(i2c, error)				\
+	octeon_i2c_reg_read(i2c, SW_TWSI_EOP_TWSI_DATA, error)
 #define octeon_i2c_stat_read(i2c)					\
-	octeon_i2c_reg_read(i2c, SW_TWSI_EOP_TWSI_STAT)
+	octeon_i2c_reg_read(i2c, SW_TWSI_EOP_TWSI_STAT, NULL)
 
 /**
  * octeon_i2c_read_int - read the TWSI_INT register
-- 
2.9.0.rc0.21.g7777322
