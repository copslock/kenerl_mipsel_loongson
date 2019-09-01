Return-Path: <SRS0=OeKb=W4=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C67EC3A5A4
	for <linux-mips@archiver.kernel.org>; Sun,  1 Sep 2019 16:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD72121874
	for <linux-mips@archiver.kernel.org>; Sun,  1 Sep 2019 16:33:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728961AbfIAQdj (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sun, 1 Sep 2019 12:33:39 -0400
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:60602 "EHLO
        pio-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfIAQdj (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Sun, 1 Sep 2019 12:33:39 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id CDFF93F752
        for <linux-mips@vger.kernel.org>; Sun,  1 Sep 2019 18:33:37 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ShLec1K07khl for <linux-mips@vger.kernel.org>;
        Sun,  1 Sep 2019 18:33:37 +0200 (CEST)
Received: from localhost (h-41-252.A163.priv.bahnhof.se [46.59.41.252])
        (Authenticated sender: mb547485)
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 29A223F393
        for <linux-mips@vger.kernel.org>; Sun,  1 Sep 2019 18:33:37 +0200 (CEST)
Date:   Sun, 1 Sep 2019 18:33:36 +0200
From:   Fredrik Noring <noring@nocrew.org>
To:     linux-mips@vger.kernel.org
Subject: [PATCH 106/120] MIPS: PS2: FB: fb_tilecursor() placeholder
Message-ID: <a937cf09cfbb48b26bd71dba2e7e0e6f0e5eb298.1567326213.git.noring@nocrew.org>
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

Drawing the cursor seems to require composition such as xor, which is
not possible here. If the character under the cursor was known, a simple
change of foreground and background colours could be implemented to
achieve the same effect.

Signed-off-by: Fredrik Noring <noring@nocrew.org>
---
 drivers/video/fbdev/ps2fb.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/video/fbdev/ps2fb.c b/drivers/video/fbdev/ps2fb.c
index c63215efd07d..bbf9e1d9e3c1 100644
--- a/drivers/video/fbdev/ps2fb.c
+++ b/drivers/video/fbdev/ps2fb.c
@@ -1258,6 +1258,17 @@ static void ps2fb_cb_tileblit(struct fb_info *info, struct fb_tileblit *blit)
 	}
 }
 
+static void ps2fb_cb_tilecursor(struct fb_info *info,
+	struct fb_tilecursor *cursor)
+{
+	/*
+	 * FIXME: Drawing the cursor seems to require composition such as
+	 * xor, which is not possible here. If the character under the
+	 * cursor was known, a simple change of foreground and background
+	 * colors could be implemented to achieve the same effect.
+	 */
+}
+
 /**
  * ps2fb_cb_get_tilemax - maximum number of tiles
  * @info: frame buffer info object
@@ -1924,6 +1935,7 @@ static int init_console_buffer(struct platform_device *pdev,
 		.fb_tilecopy	= ps2fb_cb_tilecopy,
 		.fb_tilefill    = ps2fb_cb_tilefill,
 		.fb_tileblit    = ps2fb_cb_tileblit,
+		.fb_tilecursor  = ps2fb_cb_tilecursor,
 		.fb_get_tilemax = ps2fb_cb_get_tilemax
 	};
 
-- 
2.21.0

