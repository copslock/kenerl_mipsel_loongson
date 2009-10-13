Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Oct 2009 04:49:35 +0200 (CEST)
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:43706 "EHLO
	tyo201.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1491799AbZJMCtY (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 13 Oct 2009 04:49:24 +0200
Received: from relay31.aps.necel.com ([10.29.19.54])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id n9D2mp4A007181;
	Tue, 13 Oct 2009 11:49:10 +0900 (JST)
Received: from realmbox31.aps.necel.com ([10.29.19.28] [10.29.19.28]) by relay31.aps.necel.com with ESMTP; Tue, 13 Oct 2009 11:49:10 +0900
Received: from [10.114.180.134] ([10.114.180.134] [10.114.180.134]) by mbox02.aps.necel.com with ESMTP; Tue, 13 Oct 2009 11:49:10 +0900
Message-ID: <4AD3EAAE.7070505@necel.com>
Date:	Tue, 13 Oct 2009 11:49:18 +0900
From:	Shinya Kuribayashi <shinya.kuribayashi@necel.com>
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
MIME-Version: 1.0
To:	baruch@tkos.co.il, linux-i2c@vger.kernel.org
CC:	ben-linux@fluff.org, linux-mips@linux-mips.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 03/16] i2c-designware: Use platform_get_irq helper
References: <4AD3E974.8080200@necel.com>
In-Reply-To: <4AD3E974.8080200@necel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <shinya.kuribayashi@necel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24250
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: shinya.kuribayashi@necel.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi@necel.com>
---
 drivers/i2c/busses/i2c-designware.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware.c b/drivers/i2c/busses/i2c-designware.c
index efddae1..0164092 100644
--- a/drivers/i2c/busses/i2c-designware.c
+++ b/drivers/i2c/busses/i2c-designware.c
@@ -543,8 +543,8 @@ static int __devinit dw_i2c_probe(struct platform_device *pdev)
 {
 	struct dw_i2c_dev *dev;
 	struct i2c_adapter *adap;
-	struct resource *mem, *irq, *ioarea;
-	int r;
+	struct resource *mem, *ioarea;
+	int irq, r;
 
 	/* NOTE: driver uses the static register mapping */
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -553,10 +553,10 @@ static int __devinit dw_i2c_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!irq) {
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
 		dev_err(&pdev->dev, "no irq resource?\n");
-		return -EINVAL;
+		return irq; /* -ENXIO */
 	}
 
 	ioarea = request_mem_region(mem->start, resource_size(mem),
@@ -576,7 +576,7 @@ static int __devinit dw_i2c_probe(struct platform_device *pdev)
 	tasklet_init(&dev->pump_msg, dw_i2c_pump_msg, (unsigned long) dev);
 	mutex_init(&dev->lock);
 	dev->dev = get_device(&pdev->dev);
-	dev->irq = irq->start;
+	dev->irq = irq;
 	platform_set_drvdata(pdev, dev);
 
 	dev->clk = clk_get(&pdev->dev, NULL);
-- 
1.6.5
