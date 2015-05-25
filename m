Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 May 2015 20:15:22 +0200 (CEST)
Received: from resqmta-ch2-05v.sys.comcast.net ([69.252.207.37]:60485 "EHLO
        resqmta-ch2-05v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007138AbbEYSPUIe8vD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 25 May 2015 20:15:20 +0200
Received: from resomta-ch2-08v.sys.comcast.net ([69.252.207.104])
        by resqmta-ch2-05v.sys.comcast.net with comcast
        id YJF61q0012Fh1PH01JFFA8; Mon, 25 May 2015 18:15:15 +0000
Received: from [192.168.1.13] ([69.251.155.187])
        by resomta-ch2-08v.sys.comcast.net with comcast
        id YJFE1q00P42s2jH01JFFfz; Mon, 25 May 2015 18:15:15 +0000
Message-ID: <556366AE.6030001@gentoo.org>
Date:   Mon, 25 May 2015 14:15:10 -0400
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Linux MIPS List <linux-mips@linux-mips.org>
Subject: [PATCH v2 1/2]: MIPS: Xtalk: Update xwidget.h with known Xtalk device
 numbers
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1432577715;
        bh=B8O7nq1qoyyuxzPBNTv/ijqzkOD6W1atTxwJxUrqPxs=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=wc8Ar7HqZku+dAfrHG8vyVLjJ4oCSJnlpHWW01TeBz+LjrdNFM72ECSH8Ft91xotT
         Nsb1FYModh0qcKbynSuEt6mUBypdzXbO0HTKqkbESArN30KUpba/JVYmfuG+a5A062
         ZGhPX9Ffpx0DyvtiO6+R1t1WnaIS0BnnRSTxeE65WAbayDj1gcACd7QLtInJSEpGOp
         wy+eRZcNdY5azlyU2Fg1u1ZnXurMiVUmUnSg4c38Cevn3R9kEn0A6CpnNk7e/5jDaU
         8kx4Jm2O576b0r9/NyzVgEKNxgtLEkfN89shlFu2/bAP2cZZ+4Ppn16PN+SYXpYwF+
         W38qLBJ14GYaA==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47654
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

This is the first patch of two to clean up/update the Xtalk detection
code used by IP27 with some of the code used in the IP30 port.

This specific patch adds Xtalk widget manufacturer and widget device
numbers to arch/mips/include/asm/xtalk/widget.h

Signed-off-by: Joshua Kinard <kumba@gentoo.org>
---
 arch/mips/include/asm/xtalk/xwidget.h |  112 ++++++++++++++++++++++++
 1 file changed, 112 insertions(+)

This version corrects several issues detected by checkpatch.pl.

linux-mips-xtalk-updates.patch
diff --git a/arch/mips/include/asm/xtalk/xwidget.h b/arch/mips/include/asm/xtalk/xwidget.h
index 32e4e88..24f121d 100644
--- a/arch/mips/include/asm/xtalk/xwidget.h
+++ b/arch/mips/include/asm/xtalk/xwidget.h
@@ -84,6 +84,118 @@
 #define WIDGET_LLP_MAXBURST		0x000003ff
 #define WIDGET_LLP_MAXBURST_SHFT	0
 
+/* Xtalk Widget Device Mfgr Nums */
+#define WIDGET_XBOW_MFGR_NUM	0x0      /* IP30 XBow Chip */
+#define WIDGET_XXBOW_MFGR_NUM	0x0      /* IP35 Xbow + XBridge Chip */
+#define WIDGET_ODYS_MFGR_NUM	0x023    /* Odyssey / VPro GFX */
+#define WIDGET_TPU_MFGR_NUM	0x024    /* Tensor Processor Unit */
+#define WIDGET_XBRDG_MFGR_NUM	0x024    /* IP35 XBridge Chip */
+#define WIDGET_HEART_MFGR_NUM	0x036    /* IP30 HEART Chip */
+#define WIDGET_BRIDG_MFGR_NUM	0x036    /* PCI Bridge */
+#define WIDGET_HUB_MFGR_NUM	0x036    /* IP27 Hub Chip */
+#define WIDGET_BDRCK_MFGR_NUM	0x036    /* IP35 Bedrock Chip */
+#define WIDGET_IMPCT_MFGR_NUM	0x2aa    /* HQ4 / Impact GFX */
+#define WIDGET_KONA_MFGR_NUM	0x2aa    /* InfiniteReality3 / Kona GFX */
+#define WIDGET_NULL_MFGR_NUM	-1       /* NULL */
+
+/* Xtalk Widget Device Part Nums */
+#define WIDGET_XBOW_PART_NUM	0x0000
+#define WIDGET_HEART_PART_NUM	0xc001
+#define WIDGET_BRIDG_PART_NUM	0xc002
+#define WIDGET_IMPCT_PART_NUM	0xc003
+#define WIDGET_ODYS_PART_NUM	0xc013
+#define WIDGET_HUB_PART_NUM	0xc101
+#define WIDGET_KONA_PART_NUM	0xc102
+#define WIDGET_BDRCK_PART_NUM	0xc110
+#define WIDGET_TPU_PART_NUM	0xc202
+#define WIDGET_XXBOW_PART_NUM	0xd000
+#define WIDGET_XBRDG_PART_NUM	0xd002
+#define WIDGET_NULL_PART_NUM	-1
+
+/* For Xtalk Widget identification */
+struct widget_ident {
+	u32 mfgr;
+	u32 part;
+	char *name;
+	char *revs[16];
+};
+
+/* Known Xtalk Widgets */
+static const struct widget_ident __initconst widget_idents[] = {
+	{
+		WIDGET_XBOW_MFGR_NUM,
+		WIDGET_XBOW_PART_NUM,
+		"xbow",
+		{NULL, "1.0", "1.1", "1.2", "1.3", "2.0", NULL},
+	},
+	{
+		WIDGET_HEART_MFGR_NUM,
+		WIDGET_HEART_PART_NUM,
+		"heart",
+		{NULL, "A", "B", "C", "D", "E", "F", NULL},
+	},
+	{
+		WIDGET_BRIDG_MFGR_NUM,
+		WIDGET_BRIDG_PART_NUM,
+		"bridge",
+		{NULL, "A", "B", "C", "D", NULL},
+	},
+	{
+		WIDGET_IMPCT_MFGR_NUM,
+		WIDGET_IMPCT_PART_NUM,
+		"impact",
+		{NULL, "A", "B", NULL},
+	},
+	{
+		WIDGET_ODYS_MFGR_NUM,
+		WIDGET_ODYS_PART_NUM,
+		"odyssey",
+		{NULL, "A", "B", NULL},
+	},
+	{
+		WIDGET_HUB_MFGR_NUM,
+		WIDGET_HUB_PART_NUM,
+		"hub",
+		{NULL, "1.0", "2.0", "2.1", "2.2", "2.3", "2.4", NULL},
+	},
+	{
+		WIDGET_KONA_MFGR_NUM,
+		WIDGET_KONA_PART_NUM,
+		"kona",
+		{NULL},
+	},
+	{
+		WIDGET_BDRCK_MFGR_NUM,
+		WIDGET_BDRCK_PART_NUM,
+		"bedrock",
+		{NULL, "1.0", "1.1", NULL},
+	},
+	{
+		WIDGET_TPU_MFGR_NUM,
+		WIDGET_TPU_PART_NUM,
+		"tpu",
+		{"0", NULL},
+	},
+	{
+		WIDGET_XXBOW_MFGR_NUM,
+		WIDGET_XXBOW_PART_NUM,
+		"xxbow",
+		{NULL, "1.0", "2.0", NULL},
+	},
+	{
+		WIDGET_XBRDG_MFGR_NUM,
+		WIDGET_XBRDG_PART_NUM,
+		"xbridge",
+		{NULL, "A", "B", NULL},
+	},
+	{
+		WIDGET_NULL_MFGR_NUM,
+		WIDGET_NULL_PART_NUM,
+		NULL,
+		{NULL},
+	}
+};
+
 /*
  * according to the crosstalk spec, only 32-bits access to the widget
  * configuration registers is allowed.	some widgets may allow 64-bits
