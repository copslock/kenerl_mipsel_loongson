Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Oct 2009 04:50:58 +0200 (CEST)
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:48136 "EHLO
	tyo202.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1491849AbZJMCuc (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 13 Oct 2009 04:50:32 +0200
Received: from relay11.aps.necel.com ([10.29.19.46])
	by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id n9D2oKts023976;
	Tue, 13 Oct 2009 11:50:20 +0900 (JST)
Received: from realmbox31.aps.necel.com ([10.29.19.36] [10.29.19.36]) by relay11.aps.necel.com with ESMTP; Tue, 13 Oct 2009 11:50:20 +0900
Received: from [10.114.180.134] ([10.114.180.134] [10.114.180.134]) by mbox02.aps.necel.com with ESMTP; Tue, 13 Oct 2009 11:50:20 +0900
Message-ID: <4AD3EAF4.1000500@necel.com>
Date:	Tue, 13 Oct 2009 11:50:28 +0900
From:	Shinya Kuribayashi <shinya.kuribayashi@necel.com>
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
MIME-Version: 1.0
To:	baruch@tkos.co.il, linux-i2c@vger.kernel.org
CC:	ben-linux@fluff.org, linux-mips@linux-mips.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 06/16] i2c-designware: Remove an useless local variable "num"
References: <4AD3E974.8080200@necel.com>
In-Reply-To: <4AD3E974.8080200@necel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <shinya.kuribayashi@necel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24253
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: shinya.kuribayashi@necel.com
Precedence: bulk
X-list: linux-mips

We couldn't know the original intent for this variable, but at this
point it's useless.

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi@necel.com>
---
 drivers/i2c/busses/i2c-designware.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware.c b/drivers/i2c/busses/i2c-designware.c
index 205f691..9d81775 100644
--- a/drivers/i2c/busses/i2c-designware.c
+++ b/drivers/i2c/busses/i2c-designware.c
@@ -257,7 +257,6 @@ static void
 i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
 {
 	struct i2c_msg *msgs = dev->msgs;
-	int num = dev->msgs_num;
 	u32 ic_con, intr_mask;
 	int tx_limit = dev->tx_fifo_depth - readl(dev->base + DW_IC_TXFLR);
 	int rx_limit = dev->rx_fifo_depth - readl(dev->base + DW_IC_RXFLR);
@@ -283,7 +282,7 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
 		writel(1, dev->base + DW_IC_ENABLE);
 	}
 
-	for (; dev->msg_write_idx < num; dev->msg_write_idx++) {
+	for (; dev->msg_write_idx < dev->msgs_num; dev->msg_write_idx++) {
 		/* if target address has changed, we need to
 		 * reprogram the target address in the i2c
 		 * adapter when we are done with this transfer
@@ -330,11 +329,10 @@ static void
 i2c_dw_read(struct dw_i2c_dev *dev)
 {
 	struct i2c_msg *msgs = dev->msgs;
-	int num = dev->msgs_num;
 	u32 addr = msgs[dev->msg_read_idx].addr;
 	int rx_valid = readl(dev->base + DW_IC_RXFLR);
 
-	for (; dev->msg_read_idx < num; dev->msg_read_idx++) {
+	for (; dev->msg_read_idx < dev->msgs_num; dev->msg_read_idx++) {
 		u32 len;
 		u8 *buf;
 
-- 
1.6.5
