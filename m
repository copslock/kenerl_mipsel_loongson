Return-Path: <SRS0=OeKb=W4=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97483C3A5A4
	for <linux-mips@archiver.kernel.org>; Sun,  1 Sep 2019 16:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6562220818
	for <linux-mips@archiver.kernel.org>; Sun,  1 Sep 2019 16:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbfIAQXW (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sun, 1 Sep 2019 12:23:22 -0400
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:60682 "EHLO
        pio-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728672AbfIAQXW (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Sun, 1 Sep 2019 12:23:22 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 549B13FC34
        for <linux-mips@vger.kernel.org>; Sun,  1 Sep 2019 18:23:20 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8Qct7PyYzeiR for <linux-mips@vger.kernel.org>;
        Sun,  1 Sep 2019 18:23:19 +0200 (CEST)
Received: from localhost (h-41-252.A163.priv.bahnhof.se [46.59.41.252])
        (Authenticated sender: mb547485)
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 9DFF83F62D
        for <linux-mips@vger.kernel.org>; Sun,  1 Sep 2019 18:23:19 +0200 (CEST)
Date:   Sun, 1 Sep 2019 18:23:19 +0200
From:   Fredrik Noring <noring@nocrew.org>
To:     linux-mips@vger.kernel.org
Subject: [PATCH 088/120] MIPS: PS2: GS: Primitive and texel coordinate
 transformations
Message-ID: <c02b88ffca47e03091ed78b27cb007b097a32298.1567326213.git.noring@nocrew.org>
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

The frame buffer coordinate system is the pixel drawing space, with
integer coordinates.

The primitive coordinate system is the drawing space used for vertices,
with 4-bit fractional parts.

The texel coordinate system is used for textures, with 4-bit fractional
parts, centered on the position where the fractional parts are 0.5[1].

References:

[1] "GS User's Manual", version 6.0, Sony Computer Entertainment Inc.,
    pp. 23-24,  28.

Signed-off-by: Fredrik Noring <noring@nocrew.org>
---
 arch/mips/include/asm/mach-ps2/gs.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/mips/include/asm/mach-ps2/gs.h b/arch/mips/include/asm/mach-ps2/gs.h
index 5429f52a4518..935d03007680 100644
--- a/arch/mips/include/asm/mach-ps2/gs.h
+++ b/arch/mips/include/asm/mach-ps2/gs.h
@@ -46,6 +46,28 @@ u32 gs_psm_ct32_block_address(const u32 fbw, const u32 block_index);
 
 u32 gs_psm_ct16_block_address(const u32 fbw, const u32 block_index);
 
+/**
+ * gs_fbcs_to_pcs - frame buffer coordinate to primitive coordinate
+ * @c: frame buffer coordinate
+ *
+ * Return: primitive coordinate
+ */
+static inline int gs_fbcs_to_pcs(const int c)
+{
+	return c * 16;	/* The 4 least significant bits are fractional. */
+}
+
+/**
+ * gs_pxcs_to_tcs - pixel coordinate to texel coordinate
+ * @c: pixel coordinate
+ *
+ * Return: texel coordinate
+ */
+static inline int gs_pxcs_to_tcs(const int c)
+{
+	return c * 16 + 8;  /* The 4 least significant bits are fractional. */
+}
+
 struct gs_synch_gen gs_synch_gen_for_vck(const u32 vck);
 
 u32 gs_rfsh_from_synch_gen(const struct gs_synch_gen sg);
-- 
2.21.0

