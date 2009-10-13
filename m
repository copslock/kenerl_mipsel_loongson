Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Oct 2009 04:51:24 +0200 (CEST)
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:48341 "EHLO
	tyo202.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1491948AbZJMCvA (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 13 Oct 2009 04:51:00 +0200
Received: from relay11.aps.necel.com ([10.29.19.46])
	by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id n9D2ogfr024302;
	Tue, 13 Oct 2009 11:50:42 +0900 (JST)
Received: from realmbox31.aps.necel.com ([10.29.19.32] [10.29.19.32]) by relay11.aps.necel.com with ESMTP; Tue, 13 Oct 2009 11:50:42 +0900
Received: from [10.114.180.134] ([10.114.180.134] [10.114.180.134]) by mbox02.aps.necel.com with ESMTP; Tue, 13 Oct 2009 11:50:42 +0900
Message-ID: <4AD3EB09.8050304@necel.com>
Date:	Tue, 13 Oct 2009 11:50:49 +0900
From:	Shinya Kuribayashi <shinya.kuribayashi@necel.com>
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
MIME-Version: 1.0
To:	baruch@tkos.co.il, linux-i2c@vger.kernel.org
CC:	ben-linux@fluff.org, linux-mips@linux-mips.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 07/16] i2c-designware: Set a clock name to DesignWare I2C
 clock source
References: <4AD3E974.8080200@necel.com>
In-Reply-To: <4AD3E974.8080200@necel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <shinya.kuribayashi@necel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24254
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: shinya.kuribayashi@necel.com
Precedence: bulk
X-list: linux-mips

This driver is originally prepared for the ARM kernel where rich and
well-maintained "clkdev" clock framework is available, and clock name
might not be strictly required.  ARM's clkdev does slightly fuzzy
matching where it basically gives preference to "struct device" mathing
over "clock id".  As long as used for ARM machines, there's no problem.

However, all users of this driver necessarily don't have the same clk
framework with ARM's, as the clk I/F implementation varies depending on
ARCHs and machines.

This patch adds a clock name so that other users with simple/minimum/
limited clk support could make use of the driver.

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi@necel.com>
---
 drivers/i2c/busses/i2c-designware.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware.c b/drivers/i2c/busses/i2c-designware.c
index 9d81775..0f8bd4c 100644
--- a/drivers/i2c/busses/i2c-designware.c
+++ b/drivers/i2c/busses/i2c-designware.c
@@ -575,7 +575,7 @@ static int __devinit dw_i2c_probe(struct platform_device *pdev)
 	dev->irq = irq;
 	platform_set_drvdata(pdev, dev);
 
-	dev->clk = clk_get(&pdev->dev, NULL);
+	dev->clk = clk_get(&pdev->dev, "dw_i2c_clk");
 	if (IS_ERR(dev->clk)) {
 		r = -ENODEV;
 		goto err_free_mem;
-- 
1.6.5
