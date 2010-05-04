Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 May 2010 11:57:33 +0200 (CEST)
Received: from mail-qy0-f192.google.com ([209.85.221.192]:46335 "EHLO
        mail-qy0-f192.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491822Ab0EDJzW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 May 2010 11:55:22 +0200
Received: by mail-qy0-f192.google.com with SMTP id 30so5119707qyk.16
        for <linux-mips@linux-mips.org>; Tue, 04 May 2010 02:55:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.224.27.202 with SMTP id j10mr4195362qac.260.1272966921333; 
        Tue, 04 May 2010 02:55:21 -0700 (PDT)
Received: by 10.229.212.206 with HTTP; Tue, 4 May 2010 02:55:21 -0700 (PDT)
Date:   Tue, 4 May 2010 17:55:21 +0800
Message-ID: <g2g180e2c241005040255t7c41837erb5fed15e88e41f97@mail.gmail.com>
Subject: [PATCH 6/12] add sm501_configure_gpio function
From:   yajin <yajinzhou@vm-kernel.org>
To:     linux-mips@linux-mips.org,
        loongson-dev <loongson-dev@googlegroups.com>,
        wuzhangjin@gmail.com, apatard@mandriva.com
Cc:     vince@simtec.co.uk, ben@simtec.co.uk
Content-Type: text/plain; charset=UTF-8
Return-Path: <yajinzhou@vm-kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26563
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yajinzhou@vm-kernel.org
Precedence: bulk
X-list: linux-mips

Add this function to allow other modules to configure the GPIO
interface of SM501

Signed-off-by: yajin <yajin@vm-kernel.org>
---
 drivers/mfd/sm501.c   |   28 ++++++++++++++++++++++++++++
 include/linux/sm501.h |    3 +++
 2 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/drivers/mfd/sm501.c b/drivers/mfd/sm501.c
index ab560fe..ce5dfce 100644
--- a/drivers/mfd/sm501.c
+++ b/drivers/mfd/sm501.c
@@ -1145,6 +1145,27 @@ static inline int
sm501_gpio_isregistered(struct sm501_devdata *sm)
 {
 	return sm->gpio.registered;
 }
+
+int sm501_configure_gpio(struct device *dev, unsigned int gpio,
+			 unsigned char mode)
+{
+	int reg, offset, set;
+
+	offset = 0;
+	set = 0;
+
+	if (offset >= 32) {
+		reg = SM501_GPIO63_32_CONTROL;
+		offset = gpio - 32;
+	} else
+		reg = SM501_GPIO31_0_CONTROL;
+
+	if (mode)
+		set = 1<<offset;
+
+	sm501_modify_reg(dev, reg, set, 1<<offset);
+	return 0;
+}
 #else
 static inline int sm501_register_gpio(struct sm501_devdata *sm)
 {
@@ -1164,7 +1185,14 @@ static inline int
sm501_gpio_isregistered(struct sm501_devdata *sm)
 {
 	return 0;
 }
+
+int sm501_configure_gpio(struct device *dev, unsigned int gpio,
+			 unsigned char mode)
+{
+	return -1;
+}
 #endif
+EXPORT_SYMBOL_GPL(sm501_configure_gpio);

 static int sm501_register_gpio_i2c_instance(struct sm501_devdata *sm,
 					    struct sm501_platdata_gpio_i2c *iic)
diff --git a/include/linux/sm501.h b/include/linux/sm501.h
index 0a4287e..c33b3b3 100644
--- a/include/linux/sm501.h
+++ b/include/linux/sm501.h
@@ -27,6 +27,9 @@ extern unsigned long sm501_set_clock(struct device *dev,
 extern unsigned long sm501_find_clock(struct device *dev,
 				      int clksrc, unsigned long req_freq);

+extern int sm501_configure_gpio(struct device *dev,
+				unsigned int gpio, unsigned char mode);
+
 /* sm501_misc_control
  *
  * Modify the SM501's MISC_CONTROL register
-- 
1.5.6.5
