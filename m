Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Sep 2015 11:37:44 +0200 (CEST)
Received: from resqmta-ch2-07v.sys.comcast.net ([69.252.207.39]:53126 "EHLO
        resqmta-ch2-07v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007281AbbIGJhfqRTbz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Sep 2015 11:37:35 +0200
Received: from resomta-ch2-11v.sys.comcast.net ([69.252.207.107])
        by resqmta-ch2-07v.sys.comcast.net with comcast
        id E9dV1r0032Ka2Q5019dVhY; Mon, 07 Sep 2015 09:37:29 +0000
Received: from [192.168.1.13] ([76.106.83.43])
        by resomta-ch2-11v.sys.comcast.net with comcast
        id E9dU1r0010w5D38019dUf2; Mon, 07 Sep 2015 09:37:29 +0000
From:   Joshua Kinard <kumba@gentoo.org>
Subject: [PATCH v3]: MIPS: IP27: Xtalk detection cleanups
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux/MIPS <linux-mips@linux-mips.org>
Message-ID: <55ED5AD5.7090103@gentoo.org>
Date:   Mon, 7 Sep 2015 05:37:25 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1441618649;
        bh=9LkTFOV6ZkVOXNUFKj1O5r2BeClwAsZbAopc4Vyw+w8=;
        h=Received:Received:From:Subject:To:Message-ID:Date:MIME-Version:
         Content-Type;
        b=HTcziOcR/2/GyngllsWkVc+jdff9QrGpsl+jsoxIaR7dWiV4hMbEVWutjm2GVyEmq
         tAEJA4mIjP/qRvmrEF8Wg3HLTPR1OxDN2lx3aLWtW0IJo29Nm2rvYH0pg6W4lOlZBQ
         28jdSnPsedBFOHVIqY5nBA5/GYSF2DVNTTvUsibCgPvzw4r9N5tCOD16e0dI4G/fCq
         uYkOr/JQ8lCMMRnRYL/HXzoUhlU/qFRRpOW6fJsr5r1Ay1+WrHoaDq7bq0Vn/fxDBN
         Bs8aNfwadLV3apBWVd6Ine6uRMz58rxld1FkRJru0F+jNIMTt27+fwUhPPWjV3v1ha
         V+CtBoeqDy7Sw==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49120
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

This patch, formerly of two (but the first was added to the tree in
4.1), cleans up the Xtalk detection code used by IP27 with some of the
code used in the IP30 port.

Specifically, it enables use of the static widget_idents struct added in
the earlier 4.1 patch to identify Xtalk devices, and for any
non-BRIDGE/XBRIDGE Xtalk device, will register as a platform_device
(which, right now, should only be the Impact/MardiGras board that can be
converted from an Octane).

Signed-off-by: Joshua Kinard <kumba@gentoo.org>
---
 arch/mips/sgi-ip27/ip27-xtalk.c |   87 +++++++++++++++++++++---------
 1 file changed, 61 insertions(+), 26 deletions(-)

This version corrects the diffstat output and is diff'ed against the
post-4.2/pre-4.3 tree.

linux-mips-ip27-xtalk-cleanup.patch
diff --git a/arch/mips/sgi-ip27/ip27-xtalk.c b/arch/mips/sgi-ip27/ip27-xtalk.c
index 20f582a..c262208 100644
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
+		pr_info("xtalk:%d unknown widget 0x%08x\n", widget, wid_id);
+		return -ENODEV;
+	}
 
-	switch (partnum) {
-	case BRIDGE_WIDGET_PART_NUM:
-	case XBRIDGE_WIDGET_PART_NUM:
+	pr_info("Cpu %d, Nasid 0x%x, widget 0x%x (part 0x%x) is ",
+		smp_processor_id(), nasid, widget, wid_part);
+
+	switch (wid_part) {
+	case WIDGET_BRIDG_PART_NUM:
+	case WIDGET_XBRDG_PART_NUM:
 		bridge_probe(nasid, widget, masterwid);
 		break;
 	default:
-		break;
+		if (platform_device_register_simple(res->name, widget, NULL, 0))
+			pr_info("xtalk:%d %s widget (rev %s) registered as "
+				"platform device.\n", widget, res->name,
+				(res->revs[wid_rev] ?
+				 res->revs[wid_rev] : "unknown"));
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
+		pr_info("xtalk:%d unknown widget 0x%08x\n", 0x0, wid_id);
+		goto out;
+	}
 
-	printk(KERN_INFO "Cpu %d, Nasid 0x%x: partnum 0x%x is ",
-			smp_processor_id(), nasid, partnum);
+	pr_info("Cpu %d, Nasid 0x%x, wid_part 0x%x (part 0x%x) is ",
+		smp_processor_id(), nasid, 0x0, wid_part);
 
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
+		if (platform_device_register_simple(res->name, 0x0, NULL, 0))
+			pr_info("xtalk:%d %s widget (rev %s) registered as "
+				"as platform device.\n", 0x0, res->name,
+				(res->revs[wid_rev] ?
+				 res->revs[wid_rev] : "unknown"));
 	}
+
+out:
+	return;
 }
