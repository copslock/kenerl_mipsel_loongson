Return-Path: <SRS0=OeKb=W4=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 942C8C3A5A4
	for <linux-mips@archiver.kernel.org>; Sun,  1 Sep 2019 16:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70CB321874
	for <linux-mips@archiver.kernel.org>; Sun,  1 Sep 2019 16:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbfIAQfd (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sun, 1 Sep 2019 12:35:33 -0400
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:60758 "EHLO
        pio-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbfIAQfd (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Sun, 1 Sep 2019 12:35:33 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 962F23F752
        for <linux-mips@vger.kernel.org>; Sun,  1 Sep 2019 18:35:31 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qzbCWvMS0Tdg for <linux-mips@vger.kernel.org>;
        Sun,  1 Sep 2019 18:35:30 +0200 (CEST)
Received: from localhost (h-41-252.A163.priv.bahnhof.se [46.59.41.252])
        (Authenticated sender: mb547485)
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id E67533F393
        for <linux-mips@vger.kernel.org>; Sun,  1 Sep 2019 18:35:30 +0200 (CEST)
Date:   Sun, 1 Sep 2019 18:35:30 +0200
From:   Fredrik Noring <noring@nocrew.org>
To:     linux-mips@vger.kernel.org
Subject: [PATCH 114/120] MIPS: PS2: Workaround for unexpected uLaunchELF CP0
 Status user mode
Message-ID: <05de0a34e2f6e28a611838c615c562bb12e3f680.1567326213.git.noring@nocrew.org>
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

The PlayStation 2 uLaunchELF program, used as a kernel boot loader,
starts in user mode with CP0 access enabled (CP0 Status 0x70030c11).
This is unexpected and causes a boot freeze.

Signed-off-by: Fredrik Noring <noring@nocrew.org>
---
 arch/mips/boot/compressed/head.S | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/mips/boot/compressed/head.S b/arch/mips/boot/compressed/head.S
index e3dc831e2616..6dc728d6ebea 100644
--- a/arch/mips/boot/compressed/head.S
+++ b/arch/mips/boot/compressed/head.S
@@ -24,6 +24,15 @@ start:
 	move	s2, a2
 	move	s3, a3
 
+#ifdef CONFIG_CPU_R5900
+	# The PlayStation 2 uLaunchELF starts in user mode with
+	# CP0 access enabled (CP0 Status 0x70030c11), which is
+	# unexpected. This is corrected here:
+	li	k0, 0x30010000
+	mtc0	k0, $12
+	sync.p
+#endif /* CONFIG_CPU_R5900 */
+
 	/* Clear BSS */
 	PTR_LA	a0, _edata - 4
 	PTR_LA	a2, _end
-- 
2.21.0

