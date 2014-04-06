Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 06 Apr 2014 21:52:42 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:60985 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816417AbaDFTwh1WzLY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 6 Apr 2014 21:52:37 +0200
Date:   Sun, 6 Apr 2014 20:52:37 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: [PATCH] tc: Error handling clean-ups
Message-ID: <alpine.LFD.2.11.1404062030280.15266@eddie.linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39667
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

Rewrite TURBOchannel error handling to use a common failure path, making 
sure put_device is called for devices that failed initialization.  While 
at it update printk calls to use pr_err rather than KERN_ERR.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
The checkpatch.pl warning deliberately ignored, I'm not going to go past 
79 columns.
linux-mips-tc-init-fix.patch
Index: linux-20140329-4maxp64/drivers/tc/tc.c
===================================================================
--- linux-20140329-4maxp64.orig/drivers/tc/tc.c
+++ linux-20140329-4maxp64/drivers/tc/tc.c
@@ -83,8 +83,7 @@ static void __init tc_bus_add_devices(st
 		/* Found a board, allocate it an entry in the list */
 		tdev = kzalloc(sizeof(*tdev), GFP_KERNEL);
 		if (!tdev) {
-			printk(KERN_ERR "tc%x: unable to allocate tc_dev\n",
-			       slot);
+			pr_err("tc%x: unable to allocate tc_dev\n", slot);
 			goto out_err;
 		}
 		dev_set_name(&tdev->dev, "tc%x", slot);
@@ -117,10 +116,10 @@ static void __init tc_bus_add_devices(st
 			tdev->resource.start = extslotaddr;
 			tdev->resource.end = extslotaddr + devsize - 1;
 		} else {
-			printk(KERN_ERR "%s: Cannot provide slot space "
-			       "(%dMiB required, up to %dMiB supported)\n",
-			       dev_name(&tdev->dev), devsize >> 20,
-			       max(slotsize, extslotsize) >> 20);
+			pr_err("%s: Cannot provide slot space "
+			       "(%ldMiB required, up to %ldMiB supported)\n",
+			       dev_name(&tdev->dev), (long)(devsize >> 20),
+			       (long)(max(slotsize, extslotsize) >> 20));
 			kfree(tdev);
 			goto out_err;
 		}
@@ -147,14 +146,12 @@ static int __init tc_init(void)
 {
 	/* Initialize the TURBOchannel bus */
 	if (tc_bus_get_info(&tc_bus))
-		return 0;
+		goto out_err;
 
 	INIT_LIST_HEAD(&tc_bus.devices);
 	dev_set_name(&tc_bus.dev, "tc");
-	if (device_register(&tc_bus.dev)) {
-		put_device(&tc_bus.dev);
-		return 0;	
-	}
+	if (device_register(&tc_bus.dev))
+		goto out_err_device;
 
 	if (tc_bus.info.slot_size) {
 		unsigned int tc_clock = tc_get_speed(&tc_bus) / 100000;
@@ -172,8 +169,8 @@ static int __init tc_init(void)
 		tc_bus.resource[0].flags = IORESOURCE_MEM;
 		if (request_resource(&iomem_resource,
 				     &tc_bus.resource[0]) < 0) {
-			printk(KERN_ERR "tc: Cannot reserve resource\n");
-			return 0;
+			pr_err("tc: Cannot reserve resource\n");
+			goto out_err_device;
 		}
 		if (tc_bus.ext_slot_size) {
 			tc_bus.resource[1].start = tc_bus.ext_slot_base;
@@ -184,10 +181,8 @@ static int __init tc_init(void)
 			tc_bus.resource[1].flags = IORESOURCE_MEM;
 			if (request_resource(&iomem_resource,
 					     &tc_bus.resource[1]) < 0) {
-				printk(KERN_ERR
-				       "tc: Cannot reserve resource\n");
-				release_resource(&tc_bus.resource[0]);
-				return 0;
+				pr_err("tc: Cannot reserve resource\n");
+				goto out_err_resource;
 			}
 		}
 
@@ -195,6 +190,13 @@ static int __init tc_init(void)
 	}
 
 	return 0;
+
+out_err_resource:
+	release_resource(&tc_bus.resource[0]);
+out_err_device:
+	put_device(&tc_bus.dev);
+out_err:
+	return 0;
 }
 
 subsys_initcall(tc_init);
