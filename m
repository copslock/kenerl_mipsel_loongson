Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Sep 2014 14:16:55 +0200 (CEST)
Received: from mail-we0-f170.google.com ([74.125.82.170]:40849 "EHLO
        mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010161AbaI3MQsJYOrI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 30 Sep 2014 14:16:48 +0200
Received: by mail-we0-f170.google.com with SMTP id q58so5390095wes.29
        for <multiple recipients>; Tue, 30 Sep 2014 05:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=Iou3HR3OtN99jpbiTUJJ3/9saexeyNmrmAi7cBaFjbs=;
        b=JRz6y+UyKADhU8gcsfOjbfqZ1mWSnhJC9/nv6sw72jzJtAp0R4eJjiLGx8PbdCpLsu
         I9GORwSSFGcrBxzcCLwGEsYafxcY+47V2vmKeEBqA8xxQM/re9vpoakemt5rKg9BYbah
         S4s36Bxq4RIV+/X/4hq45S/7zt3UU2R9i8N7CGnA10j/ZmkpVwwMEhFNRqQxkQklnH9t
         dpATGDhRFf5puUP0GlFk1HHELuowoCcPVZUoscX/mUMKYU1G1NlnnPRIBsdFK/aWRqIF
         yKxwLGON7Xrx4Teo7tKh3FtjeU47Pz5LMdPGqP/2GkCSh5vwQbH2TVWj2HtM7xNrEQ6+
         +Rfw==
X-Received: by 10.194.237.9 with SMTP id uy9mr3152428wjc.132.1412079402876;
        Tue, 30 Sep 2014 05:16:42 -0700 (PDT)
Received: from L80496.fr01.awl.atosorigin.net ([160.92.7.69])
        by mx.google.com with ESMTPSA id t9sm19023420wjf.41.2014.09.30.05.16.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 Sep 2014 05:16:41 -0700 (PDT)
From:   Thibaut Robert <thibaut.robert@gmail.com>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Thibaut Robert <thibaut.robert@gmail.com>
Subject: [PATCH] tc: fix warning and coding style
Date:   Tue, 30 Sep 2014 14:16:36 +0200
Message-Id: <1412079396-26005-1-git-send-email-thibaut.robert@gmail.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <thibaut.robert@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42896
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thibaut.robert@gmail.com
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

Fix checkpatch warnings:
WARNING: Prefer [subsystem eg: netdev]_err([subsystem]dev, ... then dev_err(dev, ... then pr_err(...  to printk(KERN_ERR ...
WARNING: Possible unnecessary 'out of memory' message
WARNING: quoted string split across lines
WARNING: Use #include <linux/io.h> instead of <asm/io.h>

Fix gcc warning:
warning: format ‘%d’ expects argument of type ‘int’, but argument 4 has type ‘resource_size_t’ [-Wformat=]

As resource_size_t can be 32 or 64 bits (depending on CONFIG_RESOURCES_64BIT), this patch uses "%lld" format along with a cast to u64 for printing resource_size_t values

Signed-off-by: Thibaut Robert <thibaut.robert@gmail.com>
---
 drivers/tc/tc.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/tc/tc.c b/drivers/tc/tc.c
index 9465623..9b1f831 100644
--- a/drivers/tc/tc.c
+++ b/drivers/tc/tc.c
@@ -12,6 +12,7 @@
 #include <linux/compiler.h>
 #include <linux/errno.h>
 #include <linux/init.h>
+#include <linux/io.h>
 #include <linux/ioport.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
@@ -21,8 +22,6 @@
 #include <linux/tc.h>
 #include <linux/types.h>
 
-#include <asm/io.h>
-
 static struct tc_bus tc_bus = {
 	.name = "TURBOchannel",
 };
@@ -82,11 +81,9 @@ static void __init tc_bus_add_devices(struct tc_bus *tbus)
 
 		/* Found a board, allocate it an entry in the list */
 		tdev = kzalloc(sizeof(*tdev), GFP_KERNEL);
-		if (!tdev) {
-			printk(KERN_ERR "tc%x: unable to allocate tc_dev\n",
-			       slot);
+		if (!tdev)
 			goto out_err;
-		}
+
 		dev_set_name(&tdev->dev, "tc%x", slot);
 		tdev->bus = tbus;
 		tdev->dev.parent = &tbus->dev;
@@ -105,7 +102,7 @@ static void __init tc_bus_add_devices(struct tc_bus *tbus)
 		tdev->vendor[8] = 0;
 		tdev->name[8] = 0;
 
-		pr_info("%s: %s %s %s\n", dev_name(&tdev->dev), tdev->vendor,
+		dev_info(&tdev->dev, "%s %s %s\n", tdev->vendor,
 			tdev->name, tdev->firmware);
 
 		devsize = readb(module + offset + TC_SLOT_SIZE);
@@ -117,10 +114,10 @@ static void __init tc_bus_add_devices(struct tc_bus *tbus)
 			tdev->resource.start = extslotaddr;
 			tdev->resource.end = extslotaddr + devsize - 1;
 		} else {
-			printk(KERN_ERR "%s: Cannot provide slot space "
-			       "(%dMiB required, up to %dMiB supported)\n",
-			       dev_name(&tdev->dev), devsize >> 20,
-			       max(slotsize, extslotsize) >> 20);
+			dev_err(&tdev->dev,
+				"Cannot provide slot space (%lluMiB required, up to %lluMiB supported)\n",
+				(u64) devsize >> 20,
+				(u64) max(slotsize, extslotsize) >> 20);
 			kfree(tdev);
 			goto out_err;
 		}
@@ -159,8 +156,8 @@ static int __init tc_init(void)
 	if (tc_bus.info.slot_size) {
 		unsigned int tc_clock = tc_get_speed(&tc_bus) / 100000;
 
-		pr_info("tc: TURBOchannel rev. %d at %d.%d MHz "
-			"(with%s parity)\n", tc_bus.info.revision,
+		pr_info("tc: TURBOchannel rev. %d at %d.%d MHz (with%s parity)\n",
+			tc_bus.info.revision,
 			tc_clock / 10, tc_clock % 10,
 			tc_bus.info.parity ? "" : "out");
 
@@ -172,7 +169,7 @@ static int __init tc_init(void)
 		tc_bus.resource[0].flags = IORESOURCE_MEM;
 		if (request_resource(&iomem_resource,
 				     &tc_bus.resource[0]) < 0) {
-			printk(KERN_ERR "tc: Cannot reserve resource\n");
+			pr_err("tc: Cannot reserve resource\n");
 			return 0;
 		}
 		if (tc_bus.ext_slot_size) {
@@ -184,8 +181,7 @@ static int __init tc_init(void)
 			tc_bus.resource[1].flags = IORESOURCE_MEM;
 			if (request_resource(&iomem_resource,
 					     &tc_bus.resource[1]) < 0) {
-				printk(KERN_ERR
-				       "tc: Cannot reserve resource\n");
+				pr_err("tc: Cannot reserve resource\n");
 				release_resource(&tc_bus.resource[0]);
 				return 0;
 			}
-- 
1.9.1
