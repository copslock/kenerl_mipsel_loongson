Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Oct 2009 04:54:06 +0200 (CEST)
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:45256 "EHLO
	tyo201.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1492076AbZJMCxP (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 13 Oct 2009 04:53:15 +0200
Received: from relay21.aps.necel.com ([10.29.19.50])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id n9D2r1Qe011534;
	Tue, 13 Oct 2009 11:53:03 +0900 (JST)
Received: from realmbox31.aps.necel.com ([10.29.19.36] [10.29.19.36]) by relay21.aps.necel.com with ESMTP; Tue, 13 Oct 2009 11:53:03 +0900
Received: from [10.114.180.134] ([10.114.180.134] [10.114.180.134]) by mbox02.aps.necel.com with ESMTP; Tue, 13 Oct 2009 11:53:03 +0900
Message-ID: <4AD3EB97.9060406@necel.com>
Date:	Tue, 13 Oct 2009 11:53:11 +0900
From:	Shinya Kuribayashi <shinya.kuribayashi@necel.com>
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
MIME-Version: 1.0
To:	baruch@tkos.co.il, linux-i2c@vger.kernel.org
CC:	ben-linux@fluff.org, linux-mips@linux-mips.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 13/16] i2c-designware: i2c_dw_xfer_msg: Introduce a local
 "buf" pointer
References: <4AD3E974.8080200@necel.com>
In-Reply-To: <4AD3E974.8080200@necel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <shinya.kuribayashi@necel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24260
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: shinya.kuribayashi@necel.com
Precedence: bulk
X-list: linux-mips

While we have "buf_len" local variable for dev->tx_buf_len, we don't
have such local variable for dev->tx_buf pointer.  While "buf_len" is
restored at first then updated when we're going to process a new i2c_msg
(in WRITE_IN_PROGRESS case), ->tx_buf is never done so.

Such inconsistency makes the code slightly hard to follow.

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi@necel.com>
---

 Furthermore, even with this change, i2c_dw_xfer_msg() is still
 inconsistent with i2c_dw_read().  I don't have preference around
 here, but would like to sort out.  Any suggestions are welcome.

 drivers/i2c/busses/i2c-designware.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware.c b/drivers/i2c/busses/i2c-designware.c
index de006f0..b3152c2 100644
--- a/drivers/i2c/busses/i2c-designware.c
+++ b/drivers/i2c/busses/i2c-designware.c
@@ -363,6 +363,7 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
 	int rx_limit = dev->rx_fifo_depth - readl(dev->base + DW_IC_RXFLR);
 	u32 addr = msgs[dev->msg_write_idx].addr;
 	u32 buf_len = dev->tx_buf_len;
+	u8 *buf = dev->tx_buf;;
 
 	for (; dev->msg_write_idx < dev->msgs_num; dev->msg_write_idx++) {
 		/* if target address has changed, we need to
@@ -381,7 +382,7 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
 
 		if (!(dev->status & STATUS_WRITE_IN_PROGRESS)) {
 			/* new i2c_msg */
-			dev->tx_buf = msgs[dev->msg_write_idx].buf;
+			buf	= msgs[dev->msg_write_idx].buf;
 			buf_len = msgs[dev->msg_write_idx].len;
 		}
 
@@ -390,12 +391,12 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
 				writel(0x100, dev->base + DW_IC_DATA_CMD);
 				rx_limit--;
 			} else
-				writel(*(dev->tx_buf++),
-						dev->base + DW_IC_DATA_CMD);
+				writel(*buf++, dev->base + DW_IC_DATA_CMD);
 			tx_limit--; buf_len--;
 		}
 
 		dev->tx_buf_len = buf_len;
+		dev->tx_buf = buf;
 
 		/* more bytes to be written? */
 		if (buf_len > 0) {
-- 
1.6.5
