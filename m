Return-Path: <SRS0=OeKb=W4=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CDC2C3A5A4
	for <linux-mips@archiver.kernel.org>; Sun,  1 Sep 2019 16:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E90820828
	for <linux-mips@archiver.kernel.org>; Sun,  1 Sep 2019 16:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728886AbfIAQZh (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sun, 1 Sep 2019 12:25:37 -0400
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:59868 "EHLO
        pio-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728877AbfIAQZh (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Sun, 1 Sep 2019 12:25:37 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 708EE3F752
        for <linux-mips@vger.kernel.org>; Sun,  1 Sep 2019 18:25:35 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5gb38kM-JAFE for <linux-mips@vger.kernel.org>;
        Sun,  1 Sep 2019 18:25:34 +0200 (CEST)
Received: from localhost (h-41-252.A163.priv.bahnhof.se [46.59.41.252])
        (Authenticated sender: mb547485)
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id C9EC23F393
        for <linux-mips@vger.kernel.org>; Sun,  1 Sep 2019 18:25:34 +0200 (CEST)
Date:   Sun, 1 Sep 2019 18:25:34 +0200
From:   Fredrik Noring <noring@nocrew.org>
To:     linux-mips@vger.kernel.org
Subject: [PATCH 093/120] fbdev: Add fb_warn_once() variant that only prints a
 warning once
Message-ID: <5dd47e9805a123aa9bea3c8c3cadfab24e25c29d.1567326213.git.noring@nocrew.org>
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

fb_warn_once() is a variant of fb_warn(), to print a warning only once.

Signed-off-by: Fredrik Noring <noring@nocrew.org>
---
 include/linux/fb.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/fb.h b/include/linux/fb.h
index 303771264644..19f5118e34ea 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -818,6 +818,8 @@ extern int fb_find_mode(struct fb_var_screeninfo *var,
 	pr_notice("fb%d: " fmt, (fb_info)->node, ##__VA_ARGS__)
 #define fb_warn(fb_info, fmt, ...)					\
 	pr_warn("fb%d: " fmt, (fb_info)->node, ##__VA_ARGS__)
+#define fb_warn_once(fb_info, fmt, ...)					\
+	pr_warn_once("fb%d: " fmt, (fb_info)->node, ##__VA_ARGS__)
 #define fb_info(fb_info, fmt, ...)					\
 	pr_info("fb%d: " fmt, (fb_info)->node, ##__VA_ARGS__)
 #define fb_dbg(fb_info, fmt, ...)					\
-- 
2.21.0

