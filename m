Return-Path: <SRS0=OeKb=W4=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2258C3A5A4
	for <linux-mips@archiver.kernel.org>; Sun,  1 Sep 2019 16:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E415233A2
	for <linux-mips@archiver.kernel.org>; Sun,  1 Sep 2019 16:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbfIAQX5 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sun, 1 Sep 2019 12:23:57 -0400
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:60738 "EHLO
        pio-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728672AbfIAQX5 (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Sun, 1 Sep 2019 12:23:57 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 8D47A3FC34
        for <linux-mips@vger.kernel.org>; Sun,  1 Sep 2019 18:23:55 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Wih7qAspd2mw for <linux-mips@vger.kernel.org>;
        Sun,  1 Sep 2019 18:23:54 +0200 (CEST)
Received: from localhost (h-41-252.A163.priv.bahnhof.se [46.59.41.252])
        (Authenticated sender: mb547485)
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id D44643F62D
        for <linux-mips@vger.kernel.org>; Sun,  1 Sep 2019 18:23:54 +0200 (CEST)
Date:   Sun, 1 Sep 2019 18:23:53 +0200
From:   Fredrik Noring <noring@nocrew.org>
To:     linux-mips@vger.kernel.org
Subject: [PATCH 089/120] MIPS: PS2: GS: Approximate video region with ROM
 region
Message-ID: <84a15a9832f0066d0de410c2613087a30ff99d73.1567326213.git.noring@nocrew.org>
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

PlayStation 2 hardware indicates regions in multiple ways. There are
regions for the ROM, discs, CSS, video mode and Magic Gate. Currently
only the ROM region is implemented.

Signed-off-by: Fredrik Noring <noring@nocrew.org>
---
 arch/mips/include/asm/mach-ps2/gs.h |  4 ++++
 drivers/ps2/gs.c                    | 30 +++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/arch/mips/include/asm/mach-ps2/gs.h b/arch/mips/include/asm/mach-ps2/gs.h
index 935d03007680..e719ca0531ba 100644
--- a/arch/mips/include/asm/mach-ps2/gs.h
+++ b/arch/mips/include/asm/mach-ps2/gs.h
@@ -34,6 +34,10 @@ struct gs_synch_gen {
 	u32 spml : 4;
 };
 
+bool gs_region_pal(void);
+
+bool gs_region_ntsc(void);
+
 u32 gs_video_clock(const u32 t1248, const u32 lc, const u32 rc);
 
 u32 gs_video_clock_for_smode1(const struct gs_smode1 smode1);
diff --git a/drivers/ps2/gs.c b/drivers/ps2/gs.c
index a3cd1a6adfb7..c380dfa358b5 100644
--- a/drivers/ps2/gs.c
+++ b/drivers/ps2/gs.c
@@ -21,6 +21,36 @@
 
 static struct device *gs_dev;
 
+/**
+ * gs_region_pal - is the machine for a PAL video mode region?
+ *
+ * See also gs_region_ntsc(). The system region is determined by rom_version(),
+ * which is an approximation because the ROM region does not always correspdond
+ * to the video region.
+ *
+ * Return: %true if PAL video mode is appropriate for the region, else %false
+ */
+bool gs_region_pal(void)
+{
+	return rom_version().region == 'E';
+}
+EXPORT_SYMBOL_GPL(gs_region_pal);
+
+/**
+ * gs_region_ntsc - is the machine for an NTSC video mode region?
+ *
+ * See also gs_region_pal(). The system region is determined by rom_version(),
+ * which is an approximation because the ROM region does not always correspdond
+ * to the video region.
+ *
+ * Return: %true if NTSC video mode is appropriate for the region, else %false
+ */
+bool gs_region_ntsc(void)
+{
+	return !gs_region_pal();
+}
+EXPORT_SYMBOL_GPL(gs_region_ntsc);
+
 /**
  * gs_video_clock - video clock (VCK) frequency given SMODE1 bit fields
  * @t1248 - &gs_smode1.t1248 PLL output divider
-- 
2.21.0

