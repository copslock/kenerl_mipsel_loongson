Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Oct 2009 04:53:06 +0200 (CEST)
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:48847 "EHLO
	tyo202.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1492026AbZJMCw3 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 13 Oct 2009 04:52:29 +0200
Received: from relay11.aps.necel.com ([10.29.19.46])
	by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id n9D2qGB7025887;
	Tue, 13 Oct 2009 11:52:17 +0900 (JST)
Received: from realmbox31.aps.necel.com ([10.29.19.36] [10.29.19.36]) by relay11.aps.necel.com with ESMTP; Tue, 13 Oct 2009 11:52:17 +0900
Received: from [10.114.180.134] ([10.114.180.134] [10.114.180.134]) by mbox02.aps.necel.com with ESMTP; Tue, 13 Oct 2009 11:52:17 +0900
Message-ID: <4AD3EB68.7090806@necel.com>
Date:	Tue, 13 Oct 2009 11:52:24 +0900
From:	Shinya Kuribayashi <shinya.kuribayashi@necel.com>
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
MIME-Version: 1.0
To:	baruch@tkos.co.il, linux-i2c@vger.kernel.org
CC:	ben-linux@fluff.org, linux-mips@linux-mips.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 11/16] i2c-designware: Set Tx/Rx FIFO threshold levels
References: <4AD3E974.8080200@necel.com>
In-Reply-To: <4AD3E974.8080200@necel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <shinya.kuribayashi@necel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24258
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: shinya.kuribayashi@necel.com
Precedence: bulk
X-list: linux-mips

As a hardware feature, DesignWare I2C core emits a STOP condition
whenever Tx FIFO becomes empty (strictly speaking, whenever the last
byte in the Tx FIFO has been sent out), even if we have more bytes to
be written.

In other words, we must never make "Tx FIFO underrun" happen during
a transaction, except for the last byte.  For the safety's sake, we'd
make TX_EMPTY interrupt get triggered every time one byte is processed.

Rx FIFO threshold needs to be set as well according to such tx policy.
In addition, this patch also modifies the interrupt settings properly
(enable RX_FULL mask, and hook it in the handler)

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi@necel.com>
---
 drivers/i2c/busses/i2c-designware.c |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware.c b/drivers/i2c/busses/i2c-designware.c
index 52a69a2..d9b5790 100644
--- a/drivers/i2c/busses/i2c-designware.c
+++ b/drivers/i2c/busses/i2c-designware.c
@@ -50,6 +50,8 @@
 #define DW_IC_INTR_STAT		0x2c
 #define DW_IC_INTR_MASK		0x30
 #define DW_IC_RAW_INTR_STAT	0x34
+#define DW_IC_RX_TL		0x38
+#define DW_IC_TX_TL		0x3c
 #define DW_IC_CLR_INTR		0x40
 #define DW_IC_CLR_RX_UNDER	0x44
 #define DW_IC_CLR_RX_OVER	0x48
@@ -294,6 +296,10 @@ static void i2c_dw_init(struct dw_i2c_dev *dev)
 	writel(lcnt, dev->base + DW_IC_FS_SCL_LCNT);
 	dev_dbg(dev->dev, "Fast-mode HCNT:LCNT = %d:%d\n", hcnt, lcnt);
 
+	/* Configure Tx/Rx FIFO threshold levels */
+	writel(dev->tx_fifo_depth - 1, dev->base + DW_IC_TX_TL);
+	writel(0, dev->base + DW_IC_RX_TL);
+
 	/* configure the i2c master */
 	ic_con = DW_IC_CON_MASTER | DW_IC_CON_SLAVE_DISABLE |
 		DW_IC_CON_RESTART_EN | DW_IC_CON_SPEED_FAST;
@@ -396,7 +402,7 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
 		}
 	}
 
-	intr_mask = DW_IC_INTR_STOP_DET | DW_IC_INTR_TX_ABRT;
+	intr_mask = DW_IC_INTR_STOP_DET | DW_IC_INTR_TX_ABRT | DW_IC_INTR_RX_FULL;
 	if (buf_len > 0)
 		intr_mask |= DW_IC_INTR_TX_EMPTY;
 	writel(intr_mask, dev->base + DW_IC_INTR_MASK);
@@ -582,11 +588,12 @@ static irqreturn_t i2c_dw_isr(int this_irq, void *dev_id)
 		dev->status = STATUS_IDLE;
 	}
 
-	if (stat & DW_IC_INTR_TX_EMPTY) {
-		/* Allocate room for data reception prior to xfer_msg() */
+	/* Allocate room for data reception prior to i2c_dw_xfer_msg(). */
+	if (stat & DW_IC_INTR_RX_FULL)
 		i2c_dw_read(dev);
+
+	if (stat & DW_IC_INTR_TX_EMPTY)
 		i2c_dw_xfer_msg(dev);
-	}
 
 	/*
 	 * No need to modify or disable the interrupt mask here, as
-- 
1.6.5
