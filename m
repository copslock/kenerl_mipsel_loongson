Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Sep 2018 11:32:21 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:45522 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990401AbeI1JcOw66VD (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 28 Sep 2018 11:32:14 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 4C25D20703; Fri, 28 Sep 2018 11:32:07 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 24404206D0;
        Fri, 28 Sep 2018 11:32:07 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Paul Burton <paul.burton@mips.com>
Cc:     James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] MIPS: stop using _PTRS_PER_PGD
Date:   Fri, 28 Sep 2018 11:32:02 +0200
Message-Id: <20180928093202.15426-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: <alexandre.belloni@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66605
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexandre.belloni@bootlin.com
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

gcc 3.3 has been retired for a while, use PTRS_PER_PGD and remove the
asm-offsets.h inclusion.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/mips/mm/init.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 400676ce03f4..15cae0f11880 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -32,7 +32,6 @@
 #include <linux/kcore.h>
 #include <linux/initrd.h>
 
-#include <asm/asm-offsets.h>
 #include <asm/bootinfo.h>
 #include <asm/cachectl.h>
 #include <asm/cpu.h>
@@ -521,17 +520,13 @@ unsigned long pgd_current[NR_CPUS];
 #endif
 
 /*
- * gcc 3.3 and older have trouble determining that PTRS_PER_PGD and PGD_ORDER
- * are constants.  So we use the variants from asm-offset.h until that gcc
- * will officially be retired.
- *
  * Align swapper_pg_dir in to 64K, allows its address to be loaded
  * with a single LUI instruction in the TLB handlers.  If we used
  * __aligned(64K), its size would get rounded up to the alignment
  * size, and waste space.  So we place it in its own section and align
  * it in the linker script.
  */
-pgd_t swapper_pg_dir[_PTRS_PER_PGD] __section(.bss..swapper_pg_dir);
+pgd_t swapper_pg_dir[PTRS_PER_PGD] __section(.bss..swapper_pg_dir);
 #ifndef __PAGETABLE_PUD_FOLDED
 pud_t invalid_pud_table[PTRS_PER_PUD] __page_aligned_bss;
 #endif
-- 
2.19.0
