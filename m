Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Jan 2015 17:05:15 +0100 (CET)
Received: from smtp-out-127.synserver.de ([212.40.185.127]:1062 "EHLO
        smtp-out-127.synserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011262AbbAKQFMeiHuU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 11 Jan 2015 17:05:12 +0100
Received: (qmail 11314 invoked by uid 0); 11 Jan 2015 16:05:11 -0000
X-SynServer-TrustedSrc: 1
X-SynServer-AuthUser: lars@laprican.de
X-SynServer-PPID: 11264
Received: from ppp-88-217-3-222.dynamic.mnet-online.de (HELO lars-laptop.fritz.box) [88.217.3.222]
  by 217.119.54.87 with SMTP; 11 Jan 2015 16:05:10 -0000
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@linux-mips.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] MIPS: ip22-gio: Remove legacy suspend/resume support
Date:   Sun, 11 Jan 2015 17:06:56 +0100
Message-Id: <1420992417-21294-1-git-send-email-lars@metafoo.de>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <lars@metafoo.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45069
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
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

There are currently no gio device drivers that implement suspend/resume
and this patch removes the bus specific legacy suspend and resume callbacks.
This will allow us to eventually remove struct bus_type legacy suspend and
resume support altogether.

gio device drivers wanting to implement suspend and resume can use dev PM
ops which will work out of the box without further modifications necessary.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 arch/mips/include/asm/gio_device.h |    2 --
 arch/mips/sgi-ip22/ip22-gio.c      |   24 ------------------------
 2 files changed, 26 deletions(-)

diff --git a/arch/mips/include/asm/gio_device.h b/arch/mips/include/asm/gio_device.h
index 4be1a57..71a986e 100644
--- a/arch/mips/include/asm/gio_device.h
+++ b/arch/mips/include/asm/gio_device.h
@@ -25,8 +25,6 @@ struct gio_driver {
 
 	int  (*probe)(struct gio_device *, const struct gio_device_id *);
 	void (*remove)(struct gio_device *);
-	int  (*suspend)(struct gio_device *, pm_message_t);
-	int  (*resume)(struct gio_device *);
 	void (*shutdown)(struct gio_device *);
 
 	struct device_driver driver;
diff --git a/arch/mips/sgi-ip22/ip22-gio.c b/arch/mips/sgi-ip22/ip22-gio.c
index 8f1b86d..cdf1876 100644
--- a/arch/mips/sgi-ip22/ip22-gio.c
+++ b/arch/mips/sgi-ip22/ip22-gio.c
@@ -152,28 +152,6 @@ static int gio_device_remove(struct device *dev)
 	return 0;
 }
 
-static int gio_device_suspend(struct device *dev, pm_message_t state)
-{
-	struct gio_device *gio_dev = to_gio_device(dev);
-	struct gio_driver *drv = to_gio_driver(dev->driver);
-	int error = 0;
-
-	if (dev->driver && drv->suspend)
-		error = drv->suspend(gio_dev, state);
-	return error;
-}
-
-static int gio_device_resume(struct device *dev)
-{
-	struct gio_device *gio_dev = to_gio_device(dev);
-	struct gio_driver *drv = to_gio_driver(dev->driver);
-	int error = 0;
-
-	if (dev->driver && drv->resume)
-		error = drv->resume(gio_dev);
-	return error;
-}
-
 static void gio_device_shutdown(struct device *dev)
 {
 	struct gio_device *gio_dev = to_gio_device(dev);
@@ -400,8 +378,6 @@ static struct bus_type gio_bus_type = {
 	.match	   = gio_bus_match,
 	.probe	   = gio_device_probe,
 	.remove	   = gio_device_remove,
-	.suspend   = gio_device_suspend,
-	.resume	   = gio_device_resume,
 	.shutdown  = gio_device_shutdown,
 	.uevent	   = gio_device_uevent,
 };
-- 
1.7.10.4
