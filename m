Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Oct 2009 07:30:27 +0200 (CEST)
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:43005 "EHLO
	tyo201.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1492121AbZJOFaT (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 15 Oct 2009 07:30:19 +0200
Received: from relay31.aps.necel.com ([10.29.19.54])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id n9F5Thvl022726;
	Thu, 15 Oct 2009 14:29:43 +0900 (JST)
Received: from realmbox31.aps.necel.com ([10.29.19.32] [10.29.19.32]) by relay31.aps.necel.com with ESMTP; Thu, 15 Oct 2009 14:29:43 +0900
Received: from [10.114.180.134] ([10.114.180.134] [10.114.180.134]) by mbox02.aps.necel.com with ESMTP; Thu, 15 Oct 2009 14:29:43 +0900
Message-ID: <4AD6B347.7010906@necel.com>
Date:	Thu, 15 Oct 2009 14:29:43 +0900
From:	Shinya Kuribayashi <shinya.kuribayashi@necel.com>
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
MIME-Version: 1.0
To:	baruch@tkos.co.il, linux-i2c@vger.kernel.org
CC:	ben-linux@fluff.org, linux-mips@linux-mips.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 15/16] i2c-designware: i2c_dw_xfer_msg: Mark as completed
 on an error
References: <4AD3E974.8080200@necel.com> <4AD3EBC4.6030705@necel.com>
In-Reply-To: <4AD3EBC4.6030705@necel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <shinya.kuribayashi@necel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24335
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: shinya.kuribayashi@necel.com
Precedence: bulk
X-list: linux-mips

Shinya Kuribayashi wrote:
> As wait_for_completion_interruptible_timeout() will be invoked after
> the first call to i2c_dw_xfer_msg() is made whether or not an error is
> detected in it, we need to mark ->cmd_complete as completed to avoid a
> needless HZ timeout.

> diff --git a/drivers/i2c/busses/i2c-designware.c b/drivers/i2c/busses/i2c-designware.c
> index f7ea032..6f85e28 100644
> --- a/drivers/i2c/busses/i2c-designware.c
> +++ b/drivers/i2c/busses/i2c-designware.c
> @@ -376,6 +376,7 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
>  			dev_err(dev->dev,
>  				"%s: invalid message length\n", __func__);
>  			dev->msg_err = -EINVAL;
> +			complete(&dev->cmd_complete);
>  			return;
>  		}

It turned out to be incomplete, I confimred with I2C_FUNC_SMBUS_QUICK
flag for testing.

In [PATCH 10/16] (Do dw_i2c_pump_msg's jobs in the interrutp handler),
I deleted the following line from the interrupt handler,
>-	writel(0, dev->base + DW_IC_INTR_MASK);	/* disable interrupts */

so some interrupt bits, namely RX_FULL and somtimes TX_EMPTY, are now
kept _opened_ by default.  In error handling procedures, we need to
disable them or shutdown DW I2C core properly, otherwise those
interrupts continue to be asserted.

In addition, I noticed that we need similar treatments in target addr
inconsistency checking path.

Here's problematic parts.  I'll sort out these bits, later.
---
 drivers/i2c/busses/i2c-designware.c |   18 ++++++++++++++++--
 1 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware.c b/drivers/i2c/busses/i2c-designware.c
index 060f2dd..70aaaec 100644
--- a/drivers/i2c/busses/i2c-designware.c
+++ b/drivers/i2c/busses/i2c-designware.c
@@ -370,13 +370,21 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
 		 * reprogram the target address in the i2c
 		 * adapter when we are done with this transfer
 		 */
-		if (msgs[dev->msg_write_idx].addr != addr)
+		if (msgs[dev->msg_write_idx].addr != addr) {
+			dev_err(dev->dev,
+				"%s: invalid message address\n", __func__);
+			dev->msg_err = -EINVAL;
+			writel(0, dev->base + DW_IC_ENABLE);
+			complete(&dev->cmd_complete);
 			return;
+		}
 
 		if (msgs[dev->msg_write_idx].len == 0) {
 			dev_err(dev->dev,
 				"%s: invalid message length\n", __func__);
 			dev->msg_err = -EINVAL;
+			writel(0, dev->base + DW_IC_ENABLE);
+			complete(&dev->cmd_complete);
 			return;
 		}
 
@@ -430,8 +438,14 @@ i2c_dw_read(struct dw_i2c_dev *dev)
 			continue;
 
 		/* different i2c client, reprogram the i2c adapter */
-		if (msgs[dev->msg_read_idx].addr != addr)
+		if (msgs[dev->msg_read_idx].addr != addr) {
+			dev_err(dev->dev,
+				"%s: invalid message address\n", __func__);
+			dev->msg_err = -EINVAL;
+			writel(0, dev->base + DW_IC_ENABLE);
+			complete(&dev->cmd_complete);
 			return;
+		}
 
 		if (!(dev->status & STATUS_READ_IN_PROGRESS)) {
 			len = msgs[dev->msg_read_idx].len;
-- 
Shinya Kuribayashi
NEC Electronics
