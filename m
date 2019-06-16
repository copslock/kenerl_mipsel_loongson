Return-Path: <SRS0=C0/O=UP=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC1DC31E50
	for <linux-mips@archiver.kernel.org>; Sun, 16 Jun 2019 22:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E96E820679
	for <linux-mips@archiver.kernel.org>; Sun, 16 Jun 2019 22:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbfFPWbO (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sun, 16 Jun 2019 18:31:14 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:36854 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbfFPWbO (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Sun, 16 Jun 2019 18:31:14 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 1B66EA017A;
        Mon, 17 Jun 2019 00:31:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id arRDHarA94YK; Mon, 17 Jun 2019 00:31:04 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     paul.burton@mips.com
Cc:     ralf@linux-mips.org, jhogan@kernel.org, f4bug@amsat.org,
        linux-mips@vger.kernel.org, ysu@wavecomp.com, jcristau@debian.org,
        Hauke Mehrtens <hauke@hauke-m.de>, stable@vger.kernel.org
Subject: [PATCH] MIPS: Fix bounds check virt_addr_valid
Date:   Mon, 17 Jun 2019 00:30:39 +0200
Message-Id: <20190616223039.28158-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

The bounds check used the uninitialized variable vaddr, it should use
the given parameter kaddr instead. When using the uninitialized value
the compiler assumed it to be 0 and optimized this function to just
return 0 in all cases.

This should make the function check the range of the given address and
only do the page map check in case it is in the expected range of
virtual addresses.

Fixes: 074a1e1167af ("MIPS: Bounds check virt_addr_valid")
Cc: stable@vger.kernel.org # v4.12+
Cc: Paul Burton <paul.burton@mips.com>
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/mm/mmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/mm/mmap.c b/arch/mips/mm/mmap.c
index 50ee7213b432..d79f2b432318 100644
--- a/arch/mips/mm/mmap.c
+++ b/arch/mips/mm/mmap.c
@@ -203,7 +203,7 @@ unsigned long arch_randomize_brk(struct mm_struct *mm)
 
 bool __virt_addr_valid(const volatile void *kaddr)
 {
-	unsigned long vaddr = (unsigned long)vaddr;
+	unsigned long vaddr = (unsigned long)kaddr;
 
 	if ((vaddr < PAGE_OFFSET) || (vaddr >= MAP_BASE))
 		return false;
-- 
2.20.1

