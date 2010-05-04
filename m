Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 May 2010 11:57:08 +0200 (CEST)
Received: from mail-qy0-f192.google.com ([209.85.221.192]:62054 "EHLO
        mail-qy0-f192.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492321Ab0EDJzR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 May 2010 11:55:17 +0200
Received: by mail-qy0-f192.google.com with SMTP id 30so5119599qyk.16
        for <linux-mips@linux-mips.org>; Tue, 04 May 2010 02:55:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.224.100.144 with SMTP id y16mr2235278qan.332.1272966917065; 
        Tue, 04 May 2010 02:55:17 -0700 (PDT)
Received: by 10.229.212.206 with HTTP; Tue, 4 May 2010 02:55:16 -0700 (PDT)
Date:   Tue, 4 May 2010 17:55:16 +0800
Message-ID: <g2p180e2c241005040255od41a237lca9de41d32e38af7@mail.gmail.com>
Subject: [PATCH 5/12] add sm501 pwm support.
From:   yajin <yajinzhou@vm-kernel.org>
To:     linux-mips@linux-mips.org,
        loongson-dev <loongson-dev@googlegroups.com>,
        wuzhangjin@gmail.com, apatard@mandriva.com, ben@simtec.co.uk,
        vince@simtec.co.uk
Content-Type: text/plain; charset=UTF-8
Return-Path: <yajinzhou@vm-kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26562
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yajinzhou@vm-kernel.org
Precedence: bulk
X-list: linux-mips

Gdium uses sm501 PWM for LCD backlight adjust. So we need to add the
PWM support into sm501.

Signed-off-by: yajin <yajin@vm-kernel.org>
---
 drivers/mfd/sm501.c   |   16 ++++++++++++++++
 include/linux/sm501.h |    1 +
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/drivers/mfd/sm501.c b/drivers/mfd/sm501.c
index bc9275c..ab560fe 100644
--- a/drivers/mfd/sm501.c
+++ b/drivers/mfd/sm501.c
@@ -1219,6 +1219,20 @@ static int sm501_register_gpio_i2c(struct
sm501_devdata *sm,
 	return 0;
 }

+/* register sm501 PWM device */
+static int sm501_register_pwm(struct sm501_devdata *sm)
+{
+	struct platform_device *pdev;
+
+	pdev = sm501_create_subdev(sm, "sm501-pwm", 2, 0);
+	if (!pdev)
+		return -ENOMEM;
+	sm501_create_subio(sm, &pdev->resource[0], 0x10020, 0xC);
+	sm501_create_irq(sm, &pdev->resource[1]);
+
+	return sm501_register_device(sm, pdev);
+}
+
 /* sm501_dbg_regs
  *
  * Debug attribute to attach to parent device to show core registers
@@ -1377,6 +1391,8 @@ static int __devinit sm501_init_dev(struct
sm501_devdata *sm)
 			sm501_register_uart(sm, idata->devices);
 		if (idata->devices & SM501_USE_GPIO)
 			sm501_register_gpio(sm);
+		if (idata->devices & SM501_USE_PWM)
+			sm501_register_pwm(sm);
 	}

 	if (pdata->gpio_i2c != NULL && pdata->gpio_i2c_nr > 0) {
diff --git a/include/linux/sm501.h b/include/linux/sm501.h
index 214f932..0a4287e 100644
--- a/include/linux/sm501.h
+++ b/include/linux/sm501.h
@@ -122,6 +122,7 @@ struct sm501_reg_init {
 #define SM501_USE_AC97		(1<<7)
 #define SM501_USE_I2S		(1<<8)
 #define SM501_USE_GPIO		(1<<9)
+#define SM501_USE_PWM		(1<<10)

 #define SM501_USE_ALL		(0xffffffff)

-- 
1.5.6.5
