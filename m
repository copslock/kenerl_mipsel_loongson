Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Nov 2009 12:40:42 +0100 (CET)
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:45148 "EHLO
	tyo202.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1492803AbZKPLkf (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 16 Nov 2009 12:40:35 +0100
Received: from relay11.aps.necel.com ([10.29.19.46])
	by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id nAGBeEMl018401;
	Mon, 16 Nov 2009 20:40:14 +0900 (JST)
Received: from realmbox31.aps.necel.com ([10.29.19.28] [10.29.19.28]) by relay11.aps.necel.com with ESMTP; Mon, 16 Nov 2009 20:40:14 +0900
Received: from [10.114.181.128] ([10.114.181.128] [10.114.181.128]) by mbox02.aps.necel.com with ESMTP; Mon, 16 Nov 2009 20:40:14 +0900
Message-ID: <4B013A1E.2050206@necel.com>
Date:	Mon, 16 Nov 2009 20:40:14 +0900
From:	Shinya Kuribayashi <shinya.kuribayashi@necel.com>
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
MIME-Version: 1.0
To:	baruch@tkos.co.il, ben-linux@fluff.org, linux-i2c@vger.kernel.org
CC:	linux-mips@linux-mips.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 23/22] i2c-designware: i2c_dw_handle_tx_abort: Use dev_dbg()
 for NOACK cases
References: <4AF419B6.1000802@necel.com>
In-Reply-To: <4AF419B6.1000802@necel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <shinya.kuribayashi@necel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24908
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: shinya.kuribayashi@necel.com
Precedence: bulk
X-list: linux-mips

In the case of no-ACKs, we don't want to see dev_err() messages in the
console, because some utilities like i2c-tools are capable of printing
decorated console output.  This patch will ease such situations.

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi@necel.com>
---

Hi Ben,

 This patch can be applied on the top of the v2 patchset (as 23/22).
 I've tested the patch with both no-ACK cases and arbitration case.
 As for errors other than NOACKs, it's worth doing dev_err().

 drivers/i2c/busses/i2c-designware.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware.c b/drivers/i2c/busses/i2c-designware.c
index 4534d45..9e18ef9 100644
--- a/drivers/i2c/busses/i2c-designware.c
+++ b/drivers/i2c/busses/i2c-designware.c
@@ -496,13 +496,18 @@ static int i2c_dw_handle_tx_abort(struct dw_i2c_dev *dev)
 	unsigned long abort_source = dev->abort_source;
 	int i;
 
+	if (abort_source & DW_IC_TX_ABRT_NOACK) {
+		for_each_bit(i, &abort_source, ARRAY_SIZE(abort_sources))
+			dev_dbg(dev->dev,
+				"%s: %s\n", __func__, abort_sources[i]);
+		return -EREMOTEIO;
+	}
+
 	for_each_bit(i, &abort_source, ARRAY_SIZE(abort_sources))
 		dev_err(dev->dev, "%s: %s\n", __func__, abort_sources[i]);
 
 	if (abort_source & DW_IC_TX_ARB_LOST)
 		return -EAGAIN;
-	else if (abort_source & DW_IC_TX_ABRT_NOACK)
-		return -EREMOTEIO;
 	else if (abort_source & DW_IC_TX_ABRT_GCALL_READ)
 		return -EINVAL; /* wrong msgs[] data */
 	else
-- 
1.6.5.2
