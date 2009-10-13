Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Oct 2009 04:54:30 +0200 (CEST)
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:45459 "EHLO
	tyo201.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1492012AbZJMCxo (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 13 Oct 2009 04:53:44 +0200
Received: from relay21.aps.necel.com ([10.29.19.50])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id n9D2rRhZ011976;
	Tue, 13 Oct 2009 11:53:27 +0900 (JST)
Received: from realmbox31.aps.necel.com ([10.29.19.36] [10.29.19.36]) by relay21.aps.necel.com with ESMTP; Tue, 13 Oct 2009 11:53:27 +0900
Received: from [10.114.180.134] ([10.114.180.134] [10.114.180.134]) by mbox02.aps.necel.com with ESMTP; Tue, 13 Oct 2009 11:53:27 +0900
Message-ID: <4AD3EBAF.2040903@necel.com>
Date:	Tue, 13 Oct 2009 11:53:35 +0900
From:	Shinya Kuribayashi <shinya.kuribayashi@necel.com>
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
MIME-Version: 1.0
To:	baruch@tkos.co.il, linux-i2c@vger.kernel.org
CC:	ben-linux@fluff.org, linux-mips@linux-mips.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 14/16] i2c-designware: Deferred FIFO-data-counting variables
 initialization
References: <4AD3E974.8080200@necel.com>
In-Reply-To: <4AD3E974.8080200@necel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <shinya.kuribayashi@necel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24261
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: shinya.kuribayashi@necel.com
Precedence: bulk
X-list: linux-mips

As the driver and hardware always process the given data in parallel,
it would be better to initialize those {tx,rx}_limit or rx_valid
variables just prior to be used.

This will help to send/receive data as much as possible.

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi@necel.com>
---
 drivers/i2c/busses/i2c-designware.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware.c b/drivers/i2c/busses/i2c-designware.c
index b3152c2..f7ea032 100644
--- a/drivers/i2c/busses/i2c-designware.c
+++ b/drivers/i2c/busses/i2c-designware.c
@@ -359,8 +359,7 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
 {
 	struct i2c_msg *msgs = dev->msgs;
 	u32 intr_mask;
-	int tx_limit = dev->tx_fifo_depth - readl(dev->base + DW_IC_TXFLR);
-	int rx_limit = dev->rx_fifo_depth - readl(dev->base + DW_IC_RXFLR);
+	int tx_limit, rx_limit;
 	u32 addr = msgs[dev->msg_write_idx].addr;
 	u32 buf_len = dev->tx_buf_len;
 	u8 *buf = dev->tx_buf;;
@@ -386,6 +385,9 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
 			buf_len = msgs[dev->msg_write_idx].len;
 		}
 
+		tx_limit = dev->tx_fifo_depth - readl(dev->base + DW_IC_TXFLR);
+		rx_limit = dev->rx_fifo_depth - readl(dev->base + DW_IC_RXFLR);
+
 		while (buf_len > 0 && tx_limit > 0 && rx_limit > 0) {
 			if (msgs[dev->msg_write_idx].flags & I2C_M_RD) {
 				writel(0x100, dev->base + DW_IC_DATA_CMD);
@@ -418,7 +420,7 @@ i2c_dw_read(struct dw_i2c_dev *dev)
 {
 	struct i2c_msg *msgs = dev->msgs;
 	u32 addr = msgs[dev->msg_read_idx].addr;
-	int rx_valid = readl(dev->base + DW_IC_RXFLR);
+	int rx_valid;
 
 	for (; dev->msg_read_idx < dev->msgs_num; dev->msg_read_idx++) {
 		u32 len;
@@ -439,6 +441,8 @@ i2c_dw_read(struct dw_i2c_dev *dev)
 			buf = dev->rx_buf;
 		}
 
+		rx_valid = readl(dev->base + DW_IC_RXFLR);
+
 		for (; len > 0 && rx_valid > 0; len--, rx_valid--)
 			*buf++ = readl(dev->base + DW_IC_DATA_CMD);
 
-- 
1.6.5
