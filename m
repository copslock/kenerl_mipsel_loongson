Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jul 2010 06:01:06 +0200 (CEST)
Received: from smtp.gentoo.org ([140.211.166.183]:50844 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1490954Ab0GSEAi (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 19 Jul 2010 06:00:38 +0200
Received: from localhost.localdomain (87-194-206-159.bethere.co.uk [87.194.206.159])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp.gentoo.org (Postfix) with ESMTPSA id E38261B4001;
        Mon, 19 Jul 2010 04:00:35 +0000 (UTC)
From:   Ricardo Mendoza <ricmm@gentoo.org>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     Ricardo Mendoza <ricmm@gentoo.org>
Subject: [PATCH 1/2] MIPS: RM7000: Make use of cache_op() instead of inline asm
Date:   Mon, 19 Jul 2010 04:59:59 +0100
Message-Id: <1279512000-9154-2-git-send-email-ricmm@gentoo.org>
X-Mailer: git-send-email 1.6.4.4
In-Reply-To: <1279512000-9154-1-git-send-email-ricmm@gentoo.org>
References: <1279512000-9154-1-git-send-email-ricmm@gentoo.org>
Return-Path: <ricmm@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27419
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ricmm@gentoo.org
Precedence: bulk
X-list: linux-mips

Small cleanup of the cache code to get rid of inline asm, in preparation
to give tertiary cache support.

Signed-off-by: Ricardo Mendoza <ricmm@gentoo.org>
---
 arch/mips/mm/sc-rm7k.c |   12 ++----------
 1 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/arch/mips/mm/sc-rm7k.c b/arch/mips/mm/sc-rm7k.c
index de69bfb..85678c4 100644
--- a/arch/mips/mm/sc-rm7k.c
+++ b/arch/mips/mm/sc-rm7k.c
@@ -95,16 +95,8 @@ static __cpuinit void __rm7k_sc_enable(void)
 	write_c0_taglo(0);
 	write_c0_taghi(0);
 
-	for (i = 0; i < scache_size; i += sc_lsize) {
-		__asm__ __volatile__ (
-		      ".set noreorder\n\t"
-		      ".set mips3\n\t"
-		      "cache %1, (%0)\n\t"
-		      ".set mips0\n\t"
-		      ".set reorder"
-		      :
-		      : "r" (CKSEG0ADDR(i)), "i" (Index_Store_Tag_SD));
-	}
+	for (i = 0; i < scache_size; i += sc_lsize)
+		cache_op(Index_Store_Tag_SD, CKSEG0ADDR(i));
 }
 
 static __cpuinit void rm7k_sc_enable(void)
-- 
1.6.4.4
