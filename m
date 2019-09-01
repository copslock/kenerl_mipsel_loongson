Return-Path: <SRS0=OeKb=W4=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 441F7C3A5A4
	for <linux-mips@archiver.kernel.org>; Sun,  1 Sep 2019 16:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 216EA21874
	for <linux-mips@archiver.kernel.org>; Sun,  1 Sep 2019 16:34:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbfIAQeU (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sun, 1 Sep 2019 12:34:20 -0400
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:45524 "EHLO
        pio-pvt-msa3.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728570AbfIAQeT (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Sun, 1 Sep 2019 12:34:19 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id 257473F63C
        for <linux-mips@vger.kernel.org>; Sun,  1 Sep 2019 18:34:18 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fT08sWrPsi-E for <linux-mips@vger.kernel.org>;
        Sun,  1 Sep 2019 18:34:17 +0200 (CEST)
Received: from localhost (h-41-252.A163.priv.bahnhof.se [46.59.41.252])
        (Authenticated sender: mb547485)
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id 9C4403F58C
        for <linux-mips@vger.kernel.org>; Sun,  1 Sep 2019 18:34:17 +0200 (CEST)
Date:   Sun, 1 Sep 2019 18:34:17 +0200
From:   Fredrik Noring <noring@nocrew.org>
To:     linux-mips@vger.kernel.org
Subject: [PATCH 109/120] MIPS: PS2: FB: Disable GIF DMA completion interrupts
Message-ID: <7c32a4bbe85b15f94958070991dc9a6ad77d4e1c.1567326213.git.noring@nocrew.org>
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

The GIF asserts DMA completion interrupts that are uninteresting
because DMA operations are fast enough to busy-wait for.

Signed-off-by: Fredrik Noring <noring@nocrew.org>
---
 drivers/video/fbdev/ps2fb.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/video/fbdev/ps2fb.c b/drivers/video/fbdev/ps2fb.c
index 92957797045f..d7a54108f37e 100644
--- a/drivers/video/fbdev/ps2fb.c
+++ b/drivers/video/fbdev/ps2fb.c
@@ -2173,6 +2173,12 @@ static int ps2fb_probe(struct platform_device *pdev)
 	}
 	fb_set_cmap(&info->cmap, info);
 
+	/*
+	 * The GIF asserts DMA completion interrupts that are uninteresting
+	 * because DMA operations are fast enough to busy-wait for.
+	 */
+	disable_irq(IRQ_DMAC_GIF);
+
 	if (register_framebuffer(info) < 0) {
 		fb_err(info, "register_framebuffer failed\n");
 		err = -EINVAL;
@@ -2184,6 +2190,7 @@ static int ps2fb_probe(struct platform_device *pdev)
 	return 0;
 
 err_register_framebuffer:
+	enable_irq(IRQ_DMAC_GIF);
 	fb_dealloc_cmap(&info->cmap);
 err_alloc_cmap:
 err_find_mode:
@@ -2212,6 +2219,7 @@ static int ps2fb_remove(struct platform_device *pdev)
 		fb_err(info, "Failed to complete GIF DMA transfer\n");
 		err = -EBUSY;
 	}
+	enable_irq(IRQ_DMAC_GIF);
 	free_page((unsigned long)par->package.buffer);
 
 	return err;
-- 
2.21.0

