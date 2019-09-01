Return-Path: <SRS0=OeKb=W4=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 571EEC3A5A4
	for <linux-mips@archiver.kernel.org>; Sun,  1 Sep 2019 16:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FDB121874
	for <linux-mips@archiver.kernel.org>; Sun,  1 Sep 2019 16:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbfIAQeK (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sun, 1 Sep 2019 12:34:10 -0400
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:33348 "EHLO
        pio-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728966AbfIAQeJ (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Sun, 1 Sep 2019 12:34:09 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 065F03FC34
        for <linux-mips@vger.kernel.org>; Sun,  1 Sep 2019 18:34:08 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JI6C7rzUa2rr for <linux-mips@vger.kernel.org>;
        Sun,  1 Sep 2019 18:34:07 +0200 (CEST)
Received: from localhost (h-41-252.A163.priv.bahnhof.se [46.59.41.252])
        (Authenticated sender: mb547485)
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 58BF83FBF6
        for <linux-mips@vger.kernel.org>; Sun,  1 Sep 2019 18:34:07 +0200 (CEST)
Date:   Sun, 1 Sep 2019 18:34:07 +0200
From:   Fredrik Noring <noring@nocrew.org>
To:     linux-mips@vger.kernel.org
Subject: [PATCH 108/120] MIPS: PS2: FB: fb_blank() display power management
 signaling (DPMS)
Message-ID: <2ac54422f1a639be35b049f1608e0f5f7d3e19dd.1567326213.git.noring@nocrew.org>
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

The Graphics Synthesizer implements four DPMS levels: on, standby,
suspend and off. The level is set with the SMODE2 register DPMS
field[1].

References:

[1] "GS User's Manual", version 6.0, Sony Computer Entertainment Inc.,
    p. 157.

Signed-off-by: Fredrik Noring <noring@nocrew.org>
---
 drivers/video/fbdev/ps2fb.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/video/fbdev/ps2fb.c b/drivers/video/fbdev/ps2fb.c
index 73fc1fd3f4eb..92957797045f 100644
--- a/drivers/video/fbdev/ps2fb.c
+++ b/drivers/video/fbdev/ps2fb.c
@@ -2004,6 +2004,38 @@ static int ps2fb_cb_set_par(struct fb_info *info)
 	return err;
 }
 
+/**
+ * ps2fb_blank - VESA display power management signaling (DPMS)
+ * @blank: frame buffer blanking level
+ * @info: frame buffer info object
+ *
+ * Return: 0 on success, otherwise a negative error number
+ */
+static int ps2fb_blank(int blank, struct fb_info *info)
+{
+	struct ps2fb_par *par = info->par;
+	struct gs_smode2 smode2;
+	unsigned long flags;
+
+	if (!gs_valid_smode2())
+		return -EIO;	/* Blanking before video mode is set. */
+
+	spin_lock_irqsave(&par->lock, flags);
+
+	smode2 = gs_read_smode2();
+
+	smode2.dpms = blank == FB_BLANK_POWERDOWN     ? gs_dpms_off :
+		      blank == FB_BLANK_NORMAL        ? gs_dpms_standby :
+		      blank == FB_BLANK_VSYNC_SUSPEND ? gs_dpms_suspend :
+		      blank == FB_BLANK_HSYNC_SUSPEND ? gs_dpms_suspend :
+							gs_dpms_on;
+	gs_write_smode2(smode2);
+
+	spin_unlock_irqrestore(&par->lock, flags);
+
+	return 0;
+}
+
 static u32 block_dimensions(u32 dim, u32 alignment)
 {
 	u32 mask = 0;
@@ -2032,6 +2064,7 @@ static int init_console_buffer(struct platform_device *pdev,
 {
 	static struct fb_ops fbops = {
 		.owner		= THIS_MODULE,
+		.fb_blank	= ps2fb_blank,
 		.fb_setcolreg	= ps2fb_setcolreg,
 		.fb_set_par	= ps2fb_cb_set_par,
 		.fb_check_var	= ps2fb_cb_check_var,
-- 
2.21.0

