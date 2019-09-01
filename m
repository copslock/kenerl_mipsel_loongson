Return-Path: <SRS0=OeKb=W4=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E6BFC3A5A4
	for <linux-mips@archiver.kernel.org>; Sun,  1 Sep 2019 15:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36B6020828
	for <linux-mips@archiver.kernel.org>; Sun,  1 Sep 2019 15:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbfIAPvL (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sun, 1 Sep 2019 11:51:11 -0400
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:41794 "EHLO
        pio-pvt-msa3.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728753AbfIAPvK (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Sun, 1 Sep 2019 11:51:10 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id 4FAFA3F6E5
        for <linux-mips@vger.kernel.org>; Sun,  1 Sep 2019 17:42:27 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id S1ySVjPVa914 for <linux-mips@vger.kernel.org>;
        Sun,  1 Sep 2019 17:42:26 +0200 (CEST)
Received: from localhost (h-41-252.A163.priv.bahnhof.se [46.59.41.252])
        (Authenticated sender: mb547485)
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id 9BA213F6D1
        for <linux-mips@vger.kernel.org>; Sun,  1 Sep 2019 17:42:26 +0200 (CEST)
Date:   Sun, 1 Sep 2019 17:42:26 +0200
From:   Fredrik Noring <noring@nocrew.org>
To:     linux-mips@vger.kernel.org
Subject: [PATCH 018/120] MIPS: R5900: Workaround where MSB must be 0 for the
 instruction cache
Message-ID: <5e49b0399a19c01bf1964daec5e30a1417da02a7.1567326213.git.noring@nocrew.org>
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

Signed-off-by: Fredrik Noring <noring@nocrew.org>
---
The Linux 2.6 port to the PlayStation 2 has this remark. I don't know
where it comes from.
---
 arch/mips/include/asm/r4kcache.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/mips/include/asm/r4kcache.h b/arch/mips/include/asm/r4kcache.h
index 7f4a32d3345a..e00087db9d74 100644
--- a/arch/mips/include/asm/r4kcache.h
+++ b/arch/mips/include/asm/r4kcache.h
@@ -37,7 +37,12 @@ extern void (*r4k_blast_icache)(void);
  *  - We need a properly sign extended address for 64-bit code.	 To get away
  *    without ifdefs we let the compiler do it by a type cast.
  */
+#ifdef CONFIG_CPU_R5900
+/* MSB must be 0 for the instruction cache due to an R5900 bug. */
+#define INDEX_BASE	0
+#else
 #define INDEX_BASE	CKSEG0
+#endif
 
 #define cache_op(op,addr)						\
 	__asm__ __volatile__(						\
-- 
2.21.0

