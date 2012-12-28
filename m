Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Dec 2012 21:40:59 +0100 (CET)
Received: from jacques.telenet-ops.be ([195.130.132.50]:40744 "EHLO
        jacques.telenet-ops.be" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823033Ab2L1Uk6vUywz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 28 Dec 2012 21:40:58 +0100
Received: from ayla.of.borg ([84.193.72.141])
        by jacques.telenet-ops.be with bizsmtp
        id h8gx1k00832ts5g0J8gxXC; Fri, 28 Dec 2012 21:40:57 +0100
Received: from geert by ayla.of.borg with local (Exim 4.71)
        (envelope-from <geert@linux-m68k.org>)
        id 1Togjh-0000pd-Bz; Fri, 28 Dec 2012 21:40:57 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] mips: Export min_low_pfn if CONFIG_FLATMEM
Date:   Fri, 28 Dec 2012 21:40:56 +0100
Message-Id: <1356727256-3172-1-git-send-email-geert@linux-m68k.org>
X-Mailer: git-send-email 1.7.0.4
X-archive-position: 35345
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

If CONFIG_FLATMEM=y on MIPS, pfn_valid() (and thus virt_addr_valid()) uses
min_low_pfn. However, min_low_pfn is not exported by the generic bootmem
code.

As of commit e52a29326462badd9ceec90a9eb2ac2a8550e02e ("aoe: avoid races
between device destruction and discovery"), aoeblk_open() uses
virt_addr_valid(), causing a link error in the modular case:

    ERROR: "min_low_pfn" [drivers/block/aoe/aoe.ko] undefined!

Add a custom export to fix this, just like is done for ia64 in
arch/ia64/kernel/ia64_ksyms.c.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
http://kisskb.ellerman.id.au/kisskb/buildresult/7864918/

 arch/mips/kernel/mips_ksyms.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/mips/kernel/mips_ksyms.c b/arch/mips/kernel/mips_ksyms.c
index df1e3e4..8579bb8 100644
--- a/arch/mips/kernel/mips_ksyms.c
+++ b/arch/mips/kernel/mips_ksyms.c
@@ -60,3 +60,8 @@ EXPORT_SYMBOL(invalid_pte_table);
 /* _mcount is defined in arch/mips/kernel/mcount.S */
 EXPORT_SYMBOL(_mcount);
 #endif
+
+#ifdef CONFIG_FLATMEM
+#include <linux/bootmem.h>
+EXPORT_SYMBOL(min_low_pfn);	/* defined by bootmem.c, but not exported by generic code */
+#endif
-- 
1.7.0.4
