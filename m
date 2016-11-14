Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Nov 2016 19:52:01 +0100 (CET)
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35999 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993045AbcKNSvbjuFV7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Nov 2016 19:51:31 +0100
Received: by mail-wm0-f67.google.com with SMTP id m203so17848503wma.3
        for <linux-mips@linux-mips.org>; Mon, 14 Nov 2016 10:51:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=q3YPVGNn5ZTRNzoxJF8yLW5uIdidAN9YZGTOWZSShyA=;
        b=G3BtipTv9tGJIGWkIn7bpWfyW/AXRWEs3yH0xhuO+S5Zplp60iNpsf5FDsSRulMsDv
         nreFVkqqmaZqhgGgPLGSBAwL58snurP7cf51a4gSR+wIe2UVZL6621VatHxpL3qE5hBr
         kkht5irnXHliNgmilwPSa6SUv3k2pxcQiwWnOz0R10NgedLRS6xnUQXSz2Q2h1oYg/vQ
         eesKgTmsf00oPjGY5zgISxnqJRpLEDloroeOK1YL6y0/54R4knUeXh++XU2o7dFLCHAb
         OeFSnF5LOEaeoEqrVtunLkM8qQYsY46A82GbjmNVsHMp+kDoVa7PlKMPuFx4gLWYR4Rz
         e0UA==
X-Gm-Message-State: ABUngvfu4pBkARrCiGiH5/PdLFGIp7wD8nXmpZoANz7a29/EDlRLnUV4Z/d2rRobR1gt2A==
X-Received: by 10.28.52.201 with SMTP id b192mr11299933wma.118.1479149486304;
        Mon, 14 Nov 2016 10:51:26 -0800 (PST)
Received: from wintermute.fritz.box (HSI-KBW-109-193-043-099.hsi7.kabel-badenwuerttemberg.de. [109.193.43.99])
        by smtp.gmail.com with ESMTPSA id k74sm30942198wmd.18.2016.11.14.10.51.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 Nov 2016 10:51:25 -0800 (PST)
From:   Jan Glauber <jglauber@cavium.com>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-i2c@vger.kernel.org, linux-mips@linux-mips.org,
        Paul Burton <paul.burton@imgtec.com>,
        David Daney <david.daney@cavium.com>,
        Jan Glauber <jglauber@cavium.com>
Subject: [PATCH v2 1/3] Revert "i2c: octeon: thunderx: Limit register access retries"
Date:   Mon, 14 Nov 2016 19:50:43 +0100
Message-Id: <1479149445-4663-2-git-send-email-jglauber@cavium.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1479149445-4663-1-git-send-email-jglauber@cavium.com>
References: <1479149445-4663-1-git-send-email-jglauber@cavium.com>
Return-Path: <jan.glauber@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55819
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

This reverts commit 70121f7f3725 ("i2c: octeon: thunderx: Limit register access retries").
Using readq_poll_timeout instead of __raw_readq triggers the following
debug warning:

[   78.871568] ipmi_ssif: Trying hotmod-specified SSIF interface at i2c address 0x12, adapter Cavium ThunderX i2c adapter at 0000:01:09.4, slave address 0x0
[   78.886107] do not call blocking ops when !TASK_RUNNING; state=2 set at [<fffffc00080e0088>] prepare_to_wait_event+0x58/0x10c
[   78.897436] ------------[ cut here ]------------
[   78.902050] WARNING: CPU: 6 PID: 2235 at kernel/sched/core.c:7718 __might_sleep+0x80/0x88

[...]

[   79.133553] [<fffffc00080c3aac>] __might_sleep+0x80/0x88
[   79.138862] [<fffffc0000e30138>] octeon_i2c_test_iflg+0x4c/0xbc [i2c_thunderx]
[   79.146077] [<fffffc0000e30958>] octeon_i2c_test_ready+0x18/0x70 [i2c_thunderx]
[   79.153379] [<fffffc0000e30b04>] octeon_i2c_wait+0x154/0x1a4 [i2c_thunderx]
[   79.160334] [<fffffc0000e310bc>] octeon_i2c_xfer+0xf4/0xf60 [i2c_thunderx]

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/i2c/busses/i2c-octeon-core.c |  4 +---
 drivers/i2c/busses/i2c-octeon-core.h | 27 +++++++++++----------------
 2 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/i2c/busses/i2c-octeon-core.c b/drivers/i2c/busses/i2c-octeon-core.c
index 419b54b..5e63b17 100644
--- a/drivers/i2c/busses/i2c-octeon-core.c
+++ b/drivers/i2c/busses/i2c-octeon-core.c
@@ -381,9 +381,7 @@ static int octeon_i2c_read(struct octeon_i2c *i2c, int target,
 		if (result)
 			return result;
 
-		data[i] = octeon_i2c_data_read(i2c, &result);
-		if (result)
-			return result;
+		data[i] = octeon_i2c_data_read(i2c);
 		if (recv_len && i == 0) {
 			if (data[i] > I2C_SMBUS_BLOCK_MAX + 1)
 				return -EPROTO;
diff --git a/drivers/i2c/busses/i2c-octeon-core.h b/drivers/i2c/busses/i2c-octeon-core.h
index 1db7c83..87151ea 100644
--- a/drivers/i2c/busses/i2c-octeon-core.h
+++ b/drivers/i2c/busses/i2c-octeon-core.h
@@ -5,7 +5,6 @@
 #include <linux/i2c.h>
 #include <linux/i2c-smbus.h>
 #include <linux/io.h>
-#include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/pci.h>
 
@@ -145,9 +144,9 @@ static inline void octeon_i2c_reg_write(struct octeon_i2c *i2c, u64 eop_reg, u8
 	u64 tmp;
 
 	__raw_writeq(SW_TWSI_V | eop_reg | data, i2c->twsi_base + SW_TWSI(i2c));
-
-	readq_poll_timeout(i2c->twsi_base + SW_TWSI(i2c), tmp, tmp & SW_TWSI_V,
-			   I2C_OCTEON_EVENT_WAIT, i2c->adap.timeout);
+	do {
+		tmp = __raw_readq(i2c->twsi_base + SW_TWSI(i2c));
+	} while ((tmp & SW_TWSI_V) != 0);
 }
 
 #define octeon_i2c_ctl_write(i2c, val)					\
@@ -164,28 +163,24 @@ static inline void octeon_i2c_reg_write(struct octeon_i2c *i2c, u64 eop_reg, u8
  *
  * The I2C core registers are accessed indirectly via the SW_TWSI CSR.
  */
-static inline int octeon_i2c_reg_read(struct octeon_i2c *i2c, u64 eop_reg,
-				      int *error)
+static inline u8 octeon_i2c_reg_read(struct octeon_i2c *i2c, u64 eop_reg)
 {
 	u64 tmp;
-	int ret;
 
 	__raw_writeq(SW_TWSI_V | eop_reg | SW_TWSI_R, i2c->twsi_base + SW_TWSI(i2c));
+	do {
+		tmp = __raw_readq(i2c->twsi_base + SW_TWSI(i2c));
+	} while ((tmp & SW_TWSI_V) != 0);
 
-	ret = readq_poll_timeout(i2c->twsi_base + SW_TWSI(i2c), tmp,
-				 tmp & SW_TWSI_V, I2C_OCTEON_EVENT_WAIT,
-				 i2c->adap.timeout);
-	if (error)
-		*error = ret;
 	return tmp & 0xFF;
 }
 
 #define octeon_i2c_ctl_read(i2c)					\
-	octeon_i2c_reg_read(i2c, SW_TWSI_EOP_TWSI_CTL, NULL)
-#define octeon_i2c_data_read(i2c, error)				\
-	octeon_i2c_reg_read(i2c, SW_TWSI_EOP_TWSI_DATA, error)
+	octeon_i2c_reg_read(i2c, SW_TWSI_EOP_TWSI_CTL)
+#define octeon_i2c_data_read(i2c)					\
+	octeon_i2c_reg_read(i2c, SW_TWSI_EOP_TWSI_DATA)
 #define octeon_i2c_stat_read(i2c)					\
-	octeon_i2c_reg_read(i2c, SW_TWSI_EOP_TWSI_STAT, NULL)
+	octeon_i2c_reg_read(i2c, SW_TWSI_EOP_TWSI_STAT)
 
 /**
  * octeon_i2c_read_int - read the TWSI_INT register
-- 
1.9.1
