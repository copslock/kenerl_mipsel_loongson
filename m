Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 May 2015 07:14:52 +0200 (CEST)
Received: from resqmta-ch2-09v.sys.comcast.net ([69.252.207.41]:42855 "EHLO
        resqmta-ch2-09v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006587AbbEYFOrJKj3n (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 25 May 2015 07:14:47 +0200
Received: from resomta-ch2-19v.sys.comcast.net ([69.252.207.115])
        by resqmta-ch2-09v.sys.comcast.net with comcast
        id Y5Ej1q0032VvR6D015Ejxx; Mon, 25 May 2015 05:14:43 +0000
Received: from [192.168.1.13] ([69.251.155.187])
        by resomta-ch2-19v.sys.comcast.net with comcast
        id Y5Ei1q00L42s2jH015EjrK; Mon, 25 May 2015 05:14:43 +0000
Message-ID: <5562AFC2.7070502@gentoo.org>
Date:   Mon, 25 May 2015 01:14:42 -0400
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Linux MIPS List <linux-mips@linux-mips.org>
Subject: [PATCH 2/2]: IP27: Xtalk detection cleanups
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1432530883;
        bh=wJkNHgCxnWsC9VbfbkdtayUcO52jbS4DWKSKwSX9B9k=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=juMolv+bALrfbkFkM+EJysF3KpAuE7Br57twoYvnKZYtYxLNCyN1FOCRa/xBdFTuI
         luQt1GSgV/xc7kPnCKfutmw+4/dHa454OaqVBMGPzIRO+hMb3HVFXYHVpZyuZ53EFD
         QFbewSJ8M6d73jY4HjY8YIWGqEsJfqKFXK1tDeGz97oMhkgMnH8iWNd8BGZPb4sQuh
         dGNbhXbGyjH8RTOBf1y7Wkg5o1pKoLr5vqEBka5F0AFCg1r1KxJiUZbLunxDvbqnH1
         DVxzBMvZChc1RDMYI8ZYt5E7extGMhISd5ea0rfUmL2BXFO7BhOiH8Kp1X3LhKK9ur
         WKDHmiet995jA==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47645
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

From: Joshua Kinard <kumba@gentoo.org>

This is the second patch of two to clean up/update the Xtalk detection
code used by IP27 with some of the code used in the IP30 port.

This specific patch replaces some of the IP27 Xtalk detection code with
methods used in the IP30 port, and converts the Xtalk devices into
platform devices.

Signed-off-by: Joshua Kinard <kumba@gentoo.org>
---
 arch/mips/sgi-ip27/ip27-xtalk.c |   87 +++++++++++++++++++++---------
 1 file changed, 61 insertions(+), 26 deletions(-)

linux-mips-ip27-xtalk-cleanup.patch
diff --git a/arch/mips/sgi-ip27/ip27-xtalk.c b/arch/mips/sgi-ip27/ip27-xtalk.c
index 20f582a..b664770 100644
--- a/arch/mips/sgi-ip27/ip27-xtalk.c
+++ b/arch/mips/sgi-ip27/ip27-xtalk.c
@@ -9,38 +9,55 @@
 
 #include <linux/kernel.h>
 #include <linux/smp.h>
+#include <linux/platform_device.h>
+
 #include <asm/sn/types.h>
 #include <asm/sn/klconfig.h>
 #include <asm/sn/hub.h>
 #include <asm/pci/bridge.h>
 #include <asm/xtalk/xtalk.h>
+#include <asm/xtalk/xwidget.h>
 
-
-#define XBOW_WIDGET_PART_NUM	0x0
-#define XXBOW_WIDGET_PART_NUM	0xd000	/* Xbow in Xbridge */
 #define BASE_XBOW_PORT		8     /* Lowest external port */
 
 extern int bridge_probe(nasid_t nasid, int widget, int masterwid);
 
 static int probe_one_port(nasid_t nasid, int widget, int masterwid)
 {
-	widgetreg_t		widget_id;
-	xwidget_part_num_t	partnum;
+	const struct widget_ident *res;
+	u32 wid_id, wid_part, wid_mfgr, wid_rev;
 
-	widget_id = *(volatile widgetreg_t *)
+	wid_id = *(volatile widgetreg_t *)
 		(RAW_NODE_SWIN_BASE(nasid, widget) + WIDGET_ID);
-	partnum = XWIDGET_PART_NUM(widget_id);
 
-	printk(KERN_INFO "Cpu %d, Nasid 0x%x, widget 0x%x (partnum 0x%x) is ",
-			smp_processor_id(), nasid, widget, partnum);
+	wid_mfgr = XWIDGET_MFG_NUM(wid_id);
+	wid_part = XWIDGET_PART_NUM(wid_id);
+	wid_rev = XWIDGET_REV_NUM(wid_id);
+
+	for (res = widget_idents; res->name; res++)
+		if ((res->mfgr == wid_mfgr) &&
+			(res->part == wid_part))
+			break;
+
+	if (res->name == NULL) {
+		printk(KERN_INFO "xtalk:%d unknown widget 0x%08x\n", widget, wid_id);
+		return -ENODEV;
+	}
 
-	switch (partnum) {
-	case BRIDGE_WIDGET_PART_NUM:
-	case XBRIDGE_WIDGET_PART_NUM:
+	printk(KERN_INFO "Cpu %d, Nasid 0x%x, widget 0x%x (part 0x%x) is ",
+			smp_processor_id(), nasid, widget, wid_part);
+
+	switch (wid_part) {
+	case WIDGET_BRIDG_PART_NUM:
+	case WIDGET_XBRDG_PART_NUM:
 		bridge_probe(nasid, widget, masterwid);
 		break;
 	default:
-		break;
+		if (platform_device_register_simple(res->name , widget, NULL, 0))
+			printk(KERN_INFO "xtalk:%d %s widget (rev %s) registered as "
+							 "as platform device.\n", widget, res->name,
+							 (res->revs[wid_rev] ?
+							  res->revs[wid_rev] : "unknown"));
 	}
 
 	return 0;
@@ -103,8 +120,8 @@ void xtalk_probe_node(cnodeid_t nid)
 {
 	volatile u64		hubreg;
 	nasid_t			nasid;
-	xwidget_part_num_t	partnum;
-	widgetreg_t		widget_id;
+	const struct widget_ident *res;
+	u32 wid_id, wid_part, wid_mfgr, wid_rev;
 
 	nasid = COMPACT_TO_NASID_NODEID(nid);
 	hubreg = REMOTE_HUB_L(nasid, IIO_LLP_CSR);
@@ -113,23 +130,41 @@ void xtalk_probe_node(cnodeid_t nid)
 	if (!(hubreg & IIO_LLP_CSR_IS_UP))
 		return;
 
-	widget_id = *(volatile widgetreg_t *)
+	wid_id = *(volatile widgetreg_t *)
 		       (RAW_NODE_SWIN_BASE(nasid, 0x0) + WIDGET_ID);
-	partnum = XWIDGET_PART_NUM(widget_id);
+	wid_mfgr = XWIDGET_MFG_NUM(wid_id);
+	wid_part = XWIDGET_PART_NUM(wid_id);
+	wid_rev = XWIDGET_REV_NUM(wid_id);
+
+	for (res = widget_idents; res->name; res++)
+		if ((res->mfgr == wid_mfgr) &&
+			(res->part == wid_part))
+			break;
+
+	if (res->name == NULL) {
+		printk(KERN_INFO "xtalk:%d unknown widget 0x%08x\n", 0x0, wid_id);
+		goto out;
+	}
 
-	printk(KERN_INFO "Cpu %d, Nasid 0x%x: partnum 0x%x is ",
-			smp_processor_id(), nasid, partnum);
+	printk(KERN_INFO "Cpu %d, Nasid 0x%x, wid_part 0x%x (part 0x%x) is ",
+			smp_processor_id(), nasid, 0x0, wid_part);
 
-	switch (partnum) {
-	case BRIDGE_WIDGET_PART_NUM:
-		bridge_probe(nasid, 0x8, 0xa);
+	switch (wid_part) {
+	case WIDGET_BRIDG_PART_NUM:
+		bridge_probe(nasid, 0x8, 0xa);  /* XXX: Fix! */
 		break;
-	case XBOW_WIDGET_PART_NUM:
-	case XXBOW_WIDGET_PART_NUM:
+	case WIDGET_XBOW_PART_NUM:
+	case WIDGET_XXBOW_PART_NUM:
 		xbow_probe(nasid);
 		break;
 	default:
-		printk(" unknown widget??\n");
-		break;
+		if (platform_device_register_simple(res->name , 0x0, NULL, 0))
+			printk(KERN_INFO "xtalk:%d %s widget (rev %s) registered as "
+							 "as platform device.\n", 0x0, res->name,
+							 (res->revs[wid_rev] ?
+							  res->revs[wid_rev] : "unknown"));
 	}
+
+out:
+	return;
 }
