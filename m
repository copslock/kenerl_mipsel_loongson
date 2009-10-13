Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Oct 2009 04:55:21 +0200 (CEST)
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:45685 "EHLO
	tyo201.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1492076AbZJMCy0 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 13 Oct 2009 04:54:26 +0200
Received: from relay21.aps.necel.com ([10.29.19.50])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id n9D2sEdq012578;
	Tue, 13 Oct 2009 11:54:14 +0900 (JST)
Received: from realmbox31.aps.necel.com ([10.29.19.28] [10.29.19.28]) by relay21.aps.necel.com with ESMTP; Tue, 13 Oct 2009 11:54:14 +0900
Received: from [10.114.180.134] ([10.114.180.134] [10.114.180.134]) by mbox02.aps.necel.com with ESMTP; Tue, 13 Oct 2009 11:54:13 +0900
Message-ID: <4AD3EBDD.50105@necel.com>
Date:	Tue, 13 Oct 2009 11:54:21 +0900
From:	Shinya Kuribayashi <shinya.kuribayashi@necel.com>
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
MIME-Version: 1.0
To:	baruch@tkos.co.il, linux-i2c@vger.kernel.org
CC:	ben-linux@fluff.org, linux-mips@linux-mips.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 16/16] i2c-designware: Add I2C_FUNC_SMBUS_* bits
References: <4AD3E974.8080200@necel.com>
In-Reply-To: <4AD3E974.8080200@necel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <shinya.kuribayashi@necel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24263
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: shinya.kuribayashi@necel.com
Precedence: bulk
X-list: linux-mips

This will ease our testing a bit with i2c-tools.  Note that DW I2C core
doesn't support I2C_FUNC_SMBUS_QUICK, as it's not capable of slave-
addressing-only I2C transactions.

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi@necel.com>
---
 drivers/i2c/busses/i2c-designware.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware.c b/drivers/i2c/busses/i2c-designware.c
index 6f85e28..80c8b8a 100644
--- a/drivers/i2c/busses/i2c-designware.c
+++ b/drivers/i2c/busses/i2c-designware.c
@@ -529,7 +529,14 @@ done:
 
 static u32 i2c_dw_func(struct i2c_adapter *adap)
 {
-	return I2C_FUNC_I2C | I2C_FUNC_10BIT_ADDR;
+	return	I2C_FUNC_I2C |
+		I2C_FUNC_10BIT_ADDR |
+		I2C_FUNC_SMBUS_BYTE |
+		I2C_FUNC_SMBUS_BYTE_DATA |
+		I2C_FUNC_SMBUS_WORD_DATA |
+		I2C_FUNC_SMBUS_BLOCK_DATA |
+		I2C_FUNC_SMBUS_I2C_BLOCK |
+		I2C_FUNC_SMBUS_I2C_BLOCK_2;
 }
 
 static u32 i2c_dw_read_clear_intrbits(struct dw_i2c_dev *dev)
-- 
1.6.5
