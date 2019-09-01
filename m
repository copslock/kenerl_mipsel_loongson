Return-Path: <SRS0=OeKb=W4=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC55C3A5A4
	for <linux-mips@archiver.kernel.org>; Sun,  1 Sep 2019 16:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBF4F21874
	for <linux-mips@archiver.kernel.org>; Sun,  1 Sep 2019 16:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728934AbfIAQbH (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sun, 1 Sep 2019 12:31:07 -0400
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:45262 "EHLO
        pio-pvt-msa3.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbfIAQbH (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Sun, 1 Sep 2019 12:31:07 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id 39C263F63C
        for <linux-mips@vger.kernel.org>; Sun,  1 Sep 2019 18:31:05 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FuTZB4b0X92A for <linux-mips@vger.kernel.org>;
        Sun,  1 Sep 2019 18:31:04 +0200 (CEST)
Received: from localhost (h-41-252.A163.priv.bahnhof.se [46.59.41.252])
        (Authenticated sender: mb547485)
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id 8A9723F58C
        for <linux-mips@vger.kernel.org>; Sun,  1 Sep 2019 18:31:04 +0200 (CEST)
Date:   Sun, 1 Sep 2019 18:31:04 +0200
From:   Fredrik Noring <noring@nocrew.org>
To:     linux-mips@vger.kernel.org
Subject: [PATCH 097/120] MIPS: PS2: FB: fb_set_par() VESA computer display
 mode support
Message-ID: <eed20cb918dd50ac419afcc48bd044c9dc1117ff.1567326213.git.noring@nocrew.org>
References: <cover.1567326213.git.noring@nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1567326213.git.noring@nocrew.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Some of the numeric register field constants come from fixed VESA video
modes made by Sony[1]. The main complication is that these values are
the basis to compute arbitrary top, bottom, left and right display
margin (border) settings. This is useful to for example precisely
center the image for a given analogue video display.

The VESA modes are designed to work with the synch-on-green (SOG) VGA
cable that Sony distributed with the Linux kit for the PlayStation 2.
Modern computer displays typically do not support synch-on-green, so
an adapter is most likely necessary for these modes.

References:

[1] "GS User's Manual", version 6.0, Sony Computer Entertainment Inc.,
    p. 84.

Signed-off-by: Fredrik Noring <noring@nocrew.org>
---
 drivers/video/fbdev/ps2fb.c | 78 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 77 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/ps2fb.c b/drivers/video/fbdev/ps2fb.c
index f9061ccc5755..dd8b468ab72b 100644
--- a/drivers/video/fbdev/ps2fb.c
+++ b/drivers/video/fbdev/ps2fb.c
@@ -633,6 +633,81 @@ static struct gs_sync_param vm_to_sp_hdtv(
 	};
 }
 
+/**
+ * vm_to_sp_vesa - VESA computer display mode synch parameters
+ * @vm: video mode object to compute synchronisation parameters for
+ * @sg: Graphics Synthesizer SMODE1 register video clock fields
+ *
+ * Some of the numeric register field constants come from fixed VESA video
+ * modes made by Sony. The main complication is that these values are the
+ * basis to compute arbitrary top, bottom, left and right display margin
+ * (border) settings. This is useful to for example precisely center the
+ * image for a given analogue video display.
+ *
+ * The VESA modes are designed to work with the synch-on-green (SOG) VGA cable
+ * that Sony distributed with the Linux kit for the PlayStation 2. Modern
+ * computer displays typically do not support synch-on-green, so an adapter
+ * is most likely necessary for these modes.
+ *
+ * Return: Graphics Synthesizer VESA display mode synchronisation parameters
+ */
+static struct gs_sync_param vm_to_sp_vesa(
+	const struct fb_videomode *vm, const struct gs_synch_gen sg)
+{
+	const u32 spml  = sg.spml;
+	const u32 t1248 = sg.t1248;
+	const u32 lc    = sg.lc;
+	const u32 rc    = sg.rc;
+	const u32 hadj  = spml / 2;
+	const u32 vhp   = (vm->vmode & FB_VMODE_INTERLACED) ? 0 : 1;
+	const u32 hb    = vm->xres * spml * 3 / 5;
+
+	return (struct gs_sync_param) {
+		.smode1 = {
+			.vhp    = vhp, .vcksel =  0, .slck2 =     1, .nvck = 1,
+			.clksel =   1, .pevs   =  0, .pehs  =     0, .pvs  = 0,
+			.phs    =   0, .gcont  =  0, .spml  =  spml, .pck2 = 0,
+			.xpck   =   0, .sint   =  1, .prst  =     0, .ex   = 0,
+			.cmod   =   0, .slck   =  0, .t1248 = t1248,
+			.lc     =  lc, .rc     = rc
+		},
+		.smode2 = {
+			.intm = (vm->vmode & FB_VMODE_INTERLACED) ? 1 : 0
+		},
+		.srfsh = {
+			.rfsh = gs_rfsh_from_synch_gen(sg)
+		},
+		.synch1 = {
+			.hs   = vm->hsync_len * spml,
+			.hsvs = (vm->left_margin + vm->xres +
+				 vm->right_margin - vm->hsync_len) * spml / 2,
+			.hseq = vm->hsync_len * spml,
+			.hbp  = vm->left_margin * spml - hadj,
+			.hfp  = vm->right_margin * spml + hadj
+		},
+		.synch2 = {
+			.hb = hb,
+			.hf = vm->xres * spml - hb
+		},
+		.syncv = {
+			.vs   = vm->vsync_len,
+			.vdp  = vm->yres,
+			.vbpe = 0,
+			.vbp  = vm->upper_margin,
+			.vfpe = 0,
+			.vfp  = vm->lower_margin
+		},
+		.display = {
+			.dh   = vm->yres - 1,
+			.dw   = vm->xres * spml - 1,
+			.magv = 0,
+			.magh = spml - 1,
+			.dy   = vm->vsync_len + vm->upper_margin - 1,
+			.dx   = (vm->hsync_len + vm->left_margin) * spml - 1 - hadj
+		}
+	};
+}
+
 static struct gs_sync_param vm_to_sp_for_synch_gen(
 	const struct fb_videomode *vm, const struct gs_synch_gen sg)
 {
@@ -641,7 +716,8 @@ static struct gs_sync_param vm_to_sp_for_synch_gen(
 	struct gs_sync_param sp =
 		vm->yres <= 288 &&       bc ? vm_to_sp_sdtv(vm) :
 		vm->yres <= 576 && il && bc ? vm_to_sp_sdtv(vm) :
-					      vm_to_sp_hdtv(vm, sg);
+					 bc ? vm_to_sp_hdtv(vm, sg) :
+					      vm_to_sp_vesa(vm, sg);
 
 	sp.smode1.gcont = gs_gcont_ycrcb;
 	sp.smode1.sint = 1;
-- 
2.21.0

