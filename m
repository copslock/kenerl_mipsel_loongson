Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Oct 2009 04:54:56 +0200 (CEST)
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:45535 "EHLO
	tyo201.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1491812AbZJMCx6 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 13 Oct 2009 04:53:58 +0200
Received: from relay21.aps.necel.com ([10.29.19.50])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id n9D2rjrc012208;
	Tue, 13 Oct 2009 11:53:48 +0900 (JST)
Received: from realmbox31.aps.necel.com ([10.29.19.36] [10.29.19.36]) by relay21.aps.necel.com with ESMTP; Tue, 13 Oct 2009 11:53:48 +0900
Received: from [10.114.180.134] ([10.114.180.134] [10.114.180.134]) by mbox02.aps.necel.com with ESMTP; Tue, 13 Oct 2009 11:53:48 +0900
Message-ID: <4AD3EBC4.6030705@necel.com>
Date:	Tue, 13 Oct 2009 11:53:56 +0900
From:	Shinya Kuribayashi <shinya.kuribayashi@necel.com>
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
MIME-Version: 1.0
To:	baruch@tkos.co.il, linux-i2c@vger.kernel.org
CC:	ben-linux@fluff.org, linux-mips@linux-mips.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 15/16] i2c-designware: i2c_dw_xfer_msg: Mark as completed
 on an error
References: <4AD3E974.8080200@necel.com>
In-Reply-To: <4AD3E974.8080200@necel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <shinya.kuribayashi@necel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24262
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: shinya.kuribayashi@necel.com
Precedence: bulk
X-list: linux-mips

As wait_for_completion_interruptible_timeout() will be invoked after
the first call to i2c_dw_xfer_msg() is made whether or not an error is
detected in it, we need to mark ->cmd_complete as completed to avoid a
needless HZ timeout.

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi@necel.com>
---

 Or we could change the i2c_dw_xfer_msg() prototype from "void" to
 "int".  Which is preffered?

 drivers/i2c/busses/i2c-designware.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware.c b/drivers/i2c/busses/i2c-designware.c
index f7ea032..6f85e28 100644
--- a/drivers/i2c/busses/i2c-designware.c
+++ b/drivers/i2c/busses/i2c-designware.c
@@ -376,6 +376,7 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
 			dev_err(dev->dev,
 				"%s: invalid message length\n", __func__);
 			dev->msg_err = -EINVAL;
+			complete(&dev->cmd_complete);
 			return;
 		}
 
-- 
1.6.5
