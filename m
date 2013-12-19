Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Dec 2013 16:04:47 +0100 (CET)
Received: from mail-ea0-f173.google.com ([209.85.215.173]:53662 "EHLO
        mail-ea0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816676Ab3LSPEkKFJnf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Dec 2013 16:04:40 +0100
Received: by mail-ea0-f173.google.com with SMTP id o10so539136eaj.32
        for <multiple recipients>; Thu, 19 Dec 2013 07:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gBjf120On0BvUVDQdgDZ3GNc/xifXTXd/1c1GQpqW/U=;
        b=fLCDwB2mAzWzveO5DIV64uSOiUAq15yoTu7ZVCHNyPIDJcfuTa9FdczkeBhOU0gfgd
         zq28iz2UljFKexWKvlTTBKkp1JyTh9XErtys71CYIlyXoGeLw28Rar1mE/dMfFu7IQnh
         VEYe96kgCnP1kszzDuZol73zH/EPp6V+7urMLZZdimlryvLVVE6/nS15DSiUGp0tzJw1
         QnJrBDtK3Z4D/WuwIdwPSDej5KduYUK4fbysXm3WEuJ3EoUkaE4BOCCF5toC/74AWF6C
         a1xGxEIwDJHN7oruJfbVbAtRvokEX81UxNyVanLKMx3bQ9G3LSqoVt/aTzf3ke4/kUj6
         tsug==
X-Received: by 10.15.74.200 with SMTP id j48mr134126eey.102.1387465474588;
        Thu, 19 Dec 2013 07:04:34 -0800 (PST)
Received: from localhost.tiszanet.hu (mail.mediaweb.hu. [62.201.96.214])
        by mx.google.com with ESMTPSA id h48sm10102799eev.3.2013.12.19.07.04.32
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Dec 2013 07:04:33 -0800 (PST)
From:   Levente Kurusa <levex@linux.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Levente Kurusa <levex@linux.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Markos Chandras <markos.chandras@imgtec.com>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org
Subject: [PATCH 14/38] mips: txx9: add missing put_device call
Date:   Thu, 19 Dec 2013 16:03:25 +0100
Message-Id: <1387465429-3568-15-git-send-email-levex@linux.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1387465429-3568-2-git-send-email-levex@linux.com>
References: <1387465429-3568-2-git-send-email-levex@linux.com>
Return-Path: <ilevex.linux@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38758
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: levex@linux.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

This is required so that we give up the last reference to the device.

Also, rework error path so that it is easier to read.

Signed-off-by: Levente Kurusa <levex@linux.com>
---
 arch/mips/txx9/generic/setup.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
index 2b0b83c..24332f5 100644
--- a/arch/mips/txx9/generic/setup.c
+++ b/arch/mips/txx9/generic/setup.c
@@ -937,6 +937,12 @@ static ssize_t txx9_sram_write(struct file *filp, struct kobject *kobj,
 	return size;
 }
 
+void txx9_device_release(struct device *dev) {
+	struct txx9_sramc_dev *sramc_dev;
+	txx9_sramc_dev = container_of(dev, struct txx9_sramc_dev, dev);
+	kfree(txx9_sramc_dev);
+}
+
 void __init txx9_sramc_init(struct resource *r)
 {
 	struct txx9_sramc_dev *dev;
@@ -951,8 +957,11 @@ void __init txx9_sramc_init(struct resource *r)
 		return;
 	size = resource_size(r);
 	dev->base = ioremap(r->start, size);
-	if (!dev->base)
-		goto exit;
+	if (!dev->base) {
+		kfree(dev);
+		return;
+	}
+	dev->dev.release = &txx9_device_release;
 	dev->dev.bus = &txx9_sramc_subsys;
 	sysfs_bin_attr_init(&dev->bindata_attr);
 	dev->bindata_attr.attr.name = "bindata";
@@ -963,17 +972,15 @@ void __init txx9_sramc_init(struct resource *r)
 	dev->bindata_attr.private = dev;
 	err = device_register(&dev->dev);
 	if (err)
-		goto exit;
+		goto exit_put;
 	err = sysfs_create_bin_file(&dev->dev.kobj, &dev->bindata_attr);
 	if (err) {
 		device_unregister(&dev->dev);
-		goto exit;
-	}
-	return;
-exit:
-	if (dev) {
-		if (dev->base)
-			iounmap(dev->base);
+		iounmap(dev->base);
 		kfree(dev);
 	}
+	return;
+exit_put:
+	put_device(&dev->dev);
+	return;
 }
-- 
1.8.3.1
