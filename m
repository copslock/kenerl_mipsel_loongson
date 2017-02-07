Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Feb 2017 06:58:17 +0100 (CET)
Received: from dev.gentoo.org ([IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4]:34009
        "EHLO smtp.gentoo.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990514AbdBGF6Kk04br (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Feb 2017 06:58:10 +0100
Received: from helcaraxe.arda (c-73-201-78-97.hsd1.md.comcast.net [73.201.78.97])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kumba)
        by smtp.gentoo.org (Postfix) with ESMTPSA id 5C4C8341698;
        Tue,  7 Feb 2017 05:58:04 +0000 (UTC)
From:   Joshua Kinard <kumba@gentoo.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux/MIPS <linux-mips@linux-mips.org>
Subject: [PATCH 1/3] MIPS: Xtalk: Replace several IRIX-era typedefs
Date:   Tue,  7 Feb 2017 00:57:49 -0500
Message-Id: <20170207055751.8134-2-kumba@gentoo.org>
X-Mailer: git-send-email 2.11.1
In-Reply-To: <20170207055751.8134-1-kumba@gentoo.org>
References: <20170207055751.8134-1-kumba@gentoo.org>
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56670
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

The following IRIX-era typedefs are replaced with standard types:
 - xwidgetnum_t       --> s8
 - xwidget_part_num_t --> s32
 - xwidget_rev_num_t  --> s32
 - xwidget_mfg_num_t  --> s32

Remove the following typedefs:
 - xtalk_piomap_t (unsued anywhere)

Other fixes made as detected by checkpatch.

Signed-off-by: Joshua Kinard <kumba@gentoo.org>
---
 arch/mips/include/asm/sn/hub.h        |  4 ++--
 arch/mips/include/asm/xtalk/xtalk.h   | 22 +++----------------
 arch/mips/include/asm/xtalk/xwidget.h | 28 ++++++++++++-------------
 arch/mips/sgi-ip27/ip27-hubio.c       |  2 +-
 arch/mips/sgi-ip27/ip27-xtalk.c       |  4 ++--
 5 files changed, 22 insertions(+), 38 deletions(-)

diff --git a/arch/mips/include/asm/sn/hub.h b/arch/mips/include/asm/sn/hub.h
index 1992d9254a08..41166e4f3e8b 100644
--- a/arch/mips/include/asm/sn/hub.h
+++ b/arch/mips/include/asm/sn/hub.h
@@ -9,8 +9,8 @@
 #include <asm/xtalk/xtalk.h>
 
 /* ip27-hubio.c */
-extern unsigned long hub_pio_map(cnodeid_t cnode, xwidgetnum_t widget,
-			  unsigned long xtalk_addr, size_t size);
+extern unsigned long hub_pio_map(cnodeid_t cnode, s8 widget,
+				 unsigned long xtalk_addr, size_t size);
 extern void hub_pio_init(cnodeid_t cnode);
 
 #endif /* __ASM_SN_HUB_H */
diff --git a/arch/mips/include/asm/xtalk/xtalk.h b/arch/mips/include/asm/xtalk/xtalk.h
index 26d2ed1fa917..9125bd85514d 100644
--- a/arch/mips/include/asm/xtalk/xtalk.h
+++ b/arch/mips/include/asm/xtalk/xtalk.h
@@ -13,30 +13,14 @@
 #define _ASM_XTALK_XTALK_H
 
 #ifndef __ASSEMBLY__
-/*
- * User-level device driver visible types
- */
-typedef char		xwidgetnum_t;	/* xtalk widget number	(0..15) */
 
+/* Xtalk "none" values. */
 #define XWIDGET_NONE		-1
-
-typedef int xwidget_part_num_t; /* xtalk widget part number */
-
 #define XWIDGET_PART_NUM_NONE	-1
-
-typedef int		xwidget_rev_num_t;	/* xtalk widget revision number */
-
 #define XWIDGET_REV_NUM_NONE	-1
-
-typedef int xwidget_mfg_num_t;	/* xtalk widget manufacturing ID */
-
 #define XWIDGET_MFG_NUM_NONE	-1
 
-typedef struct xtalk_piomap_s *xtalk_piomap_t;
-
-/* It is often convenient to fold the XIO target port
- * number into the XIO address.
- */
+/* It is often convenient to fold the XIO target port */
 #define XIO_NOWHERE	(0xFFFFFFFFFFFFFFFFull)
 #define XIO_ADDR_BITS	(0x0000FFFFFFFFFFFFull)
 #define XIO_PORT_BITS	(0xF000000000000000ull)
@@ -44,7 +28,7 @@ typedef struct xtalk_piomap_s *xtalk_piomap_t;
 
 #define XIO_PACKED(x)	(((x)&XIO_PORT_BITS) != 0)
 #define XIO_ADDR(x)	((x)&XIO_ADDR_BITS)
-#define XIO_PORT(x)	((xwidgetnum_t)(((x)&XIO_PORT_BITS) >> XIO_PORT_SHIFT))
+#define XIO_PORT(x)	((s8)(((x)&XIO_PORT_BITS) >> XIO_PORT_SHIFT))
 #define XIO_PACK(p, o)	((((uint64_t)(p))<<XIO_PORT_SHIFT) | ((o)&XIO_ADDR_BITS))
 
 #ifdef CONFIG_PCI
diff --git a/arch/mips/include/asm/xtalk/xwidget.h b/arch/mips/include/asm/xtalk/xwidget.h
index 24f121da6a1d..9f71148f9ff4 100644
--- a/arch/mips/include/asm/xtalk/xwidget.h
+++ b/arch/mips/include/asm/xtalk/xwidget.h
@@ -233,17 +233,17 @@ typedef volatile struct widget_cfg {
 } widget_cfg_t;
 
 typedef struct {
-	unsigned	didn:4;
-	unsigned	sidn:4;
-	unsigned	pactyp:4;
-	unsigned	tnum:5;
-	unsigned	ct:1;
-	unsigned	ds:2;
-	unsigned	gbr:1;
-	unsigned	vbpm:1;
-	unsigned	error:1;
-	unsigned	bo:1;
-	unsigned	other:8;
+	unsigned int	didn:4;
+	unsigned int	sidn:4;
+	unsigned int	pactyp:4;
+	unsigned int	tnum:5;
+	unsigned int	ct:1;
+	unsigned int	ds:2;
+	unsigned int	gbr:1;
+	unsigned int	vbpm:1;
+	unsigned int	error:1;
+	unsigned int	bo:1;
+	unsigned int	other:8;
 } w_err_cmd_word_f;
 
 typedef union {
@@ -257,9 +257,9 @@ typedef struct xwidget_info_s *xwidget_info_t;
  * Crosstalk Widget Hardware Identification, as defined in the Crosstalk spec.
  */
 typedef struct xwidget_hwid_s {
-	xwidget_part_num_t	part_num;
-	xwidget_rev_num_t	rev_num;
-	xwidget_mfg_num_t	mfg_num;
+	s32	part_num;
+	s32	rev_num;
+	s32	mfg_num;
 } *xwidget_hwid_t;
 
 
diff --git a/arch/mips/sgi-ip27/ip27-hubio.c b/arch/mips/sgi-ip27/ip27-hubio.c
index 2abe016a0ffc..36485dcf7af0 100644
--- a/arch/mips/sgi-ip27/ip27-hubio.c
+++ b/arch/mips/sgi-ip27/ip27-hubio.c
@@ -25,7 +25,7 @@ static int force_fire_and_forget = 1;
  * @size:	size of the PIO mapping
  *
  **/
-unsigned long hub_pio_map(cnodeid_t cnode, xwidgetnum_t widget,
+unsigned long hub_pio_map(cnodeid_t cnode, s8 widget,
 			  unsigned long xtalk_addr, size_t size)
 {
 	nasid_t nasid = COMPACT_TO_NASID_NODEID(cnode);
diff --git a/arch/mips/sgi-ip27/ip27-xtalk.c b/arch/mips/sgi-ip27/ip27-xtalk.c
index 4fe5678ba74d..cd522a45a781 100644
--- a/arch/mips/sgi-ip27/ip27-xtalk.c
+++ b/arch/mips/sgi-ip27/ip27-xtalk.c
@@ -25,7 +25,7 @@ extern int bridge_probe(nasid_t nasid, int widget, int masterwid);
 static int probe_one_port(nasid_t nasid, int widget, int masterwid)
 {
 	widgetreg_t		widget_id;
-	xwidget_part_num_t	partnum;
+	s32			partnum;
 
 	widget_id = *(volatile widgetreg_t *)
 		(RAW_NODE_SWIN_BASE(nasid, widget) + WIDGET_ID);
@@ -103,7 +103,7 @@ void xtalk_probe_node(cnodeid_t nid)
 {
 	volatile u64		hubreg;
 	nasid_t			nasid;
-	xwidget_part_num_t	partnum;
+	s32			partnum;
 	widgetreg_t		widget_id;
 
 	nasid = COMPACT_TO_NASID_NODEID(nid);
-- 
2.11.1
