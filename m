Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Aug 2010 17:43:42 +0200 (CEST)
Received: from smtp.gentoo.org ([140.211.166.183]:48916 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491009Ab0HFPnh (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 6 Aug 2010 17:43:37 +0200
Received: from localhost.localdomain (unknown [201.208.61.81])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp.gentoo.org (Postfix) with ESMTPSA id 04E5A1B406E;
        Fri,  6 Aug 2010 15:43:23 +0000 (UTC)
From:   Ricardo Mendoza <ricmm@gentoo.org>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     Ricardo Mendoza <ricmm@gentoo.org>
Subject: [PATCH] MIPS: RM7000: Symbol should be static
Date:   Fri,  6 Aug 2010 11:12:57 -0430
Message-Id: <1281109377-9576-1-git-send-email-ricmm@gentoo.org>
X-Mailer: git-send-email 1.6.4.4
Return-Path: <ricmm@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27601
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ricmm@gentoo.org
Precedence: bulk
X-list: linux-mips

arch/mips/mm/sc-rm7k.c defines tcache_size globally.

Make it static.

Signed-off-by: Ricardo Mendoza <ricmm@gentoo.org>
---
 arch/mips/mm/sc-rm7k.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/mm/sc-rm7k.c b/arch/mips/mm/sc-rm7k.c
index 1ef75cd..274af3b 100644
--- a/arch/mips/mm/sc-rm7k.c
+++ b/arch/mips/mm/sc-rm7k.c
@@ -30,7 +30,7 @@
 #define tc_lsize	32
 
 extern unsigned long icache_way_size, dcache_way_size;
-unsigned long tcache_size;
+static unsigned long tcache_size;
 
 #include <asm/r4kcache.h>
 
-- 
1.6.4.4
