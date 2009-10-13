Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Oct 2009 04:52:15 +0200 (CEST)
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:44636 "EHLO
	tyo201.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1491948AbZJMCvu (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 13 Oct 2009 04:51:50 +0200
Received: from relay21.aps.necel.com ([10.29.19.50])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id n9D2owhD009121;
	Tue, 13 Oct 2009 11:51:30 +0900 (JST)
Received: from realmbox31.aps.necel.com ([10.29.19.28] [10.29.19.28]) by relay21.aps.necel.com with ESMTP; Tue, 13 Oct 2009 11:51:29 +0900
Received: from [10.114.180.134] ([10.114.180.134] [10.114.180.134]) by mbox02.aps.necel.com with ESMTP; Tue, 13 Oct 2009 11:51:29 +0900
Message-ID: <4AD3EB39.1020300@necel.com>
Date:	Tue, 13 Oct 2009 11:51:37 +0900
From:	Shinya Kuribayashi <shinya.kuribayashi@necel.com>
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
MIME-Version: 1.0
To:	baruch@tkos.co.il, linux-i2c@vger.kernel.org
CC:	ben-linux@fluff.org, linux-mips@linux-mips.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 09/16] i2c-designware: i2c_dw_xfer_msg: Fix an i2c_msg search
 bug
References: <4AD3E974.8080200@necel.com>
In-Reply-To: <4AD3E974.8080200@necel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <shinya.kuribayashi@necel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24256
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: shinya.kuribayashi@necel.com
Precedence: bulk
X-list: linux-mips

In case an i2c_msg, which is currently work-in-progress, has more bytes
to be written, we need to set STATUS_WRITE_IN_PROGRESS _and_ exit from
the msg_write_idx-search loop.  Otherwise, we'll overtake the current
index without waiting for transmission completed.

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi@necel.com>
---
 drivers/i2c/busses/i2c-designware.c |   17 +++++++++++------
 1 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware.c b/drivers/i2c/busses/i2c-designware.c
index 26efd3a..6bfdc5f 100644
--- a/drivers/i2c/busses/i2c-designware.c
+++ b/drivers/i2c/busses/i2c-designware.c
@@ -386,17 +386,22 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
 						dev->base + DW_IC_DATA_CMD);
 			tx_limit--; buf_len--;
 		}
+
+		dev->tx_buf_len = buf_len;
+
+		/* more bytes to be written? */
+		if (buf_len > 0) {
+			dev->status |= STATUS_WRITE_IN_PROGRESS;
+			break;
+		} else {
+			dev->status &= ~STATUS_WRITE_IN_PROGRESS;
+		}
 	}
 
 	intr_mask = DW_IC_INTR_STOP_DET | DW_IC_INTR_TX_ABRT;
-	if (buf_len > 0) { /* more bytes to be written */
+	if (buf_len > 0)
 		intr_mask |= DW_IC_INTR_TX_EMPTY;
-		dev->status |= STATUS_WRITE_IN_PROGRESS;
-	} else
-		dev->status &= ~STATUS_WRITE_IN_PROGRESS;
 	writel(intr_mask, dev->base + DW_IC_INTR_MASK);
-
-	dev->tx_buf_len = buf_len;
 }
 
 static void
-- 
1.6.5
