Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 Apr 2013 20:20:46 +0200 (CEST)
Received: from jacques.telenet-ops.be ([195.130.132.50]:37623 "EHLO
        jacques.telenet-ops.be" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835174Ab3D0SUnx-GDH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 27 Apr 2013 20:20:43 +0200
Received: from ayla.of.borg ([84.193.72.141])
        by jacques.telenet-ops.be with bizsmtp
        id V6Li1l00X32ts5g0J6LiGS; Sat, 27 Apr 2013 20:20:43 +0200
Received: from geert by ayla.of.borg with local (Exim 4.71)
        (envelope-from <geert@linux-m68k.org>)
        id 1UW9jm-0002nh-5g; Sat, 27 Apr 2013 20:20:42 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Sanjay Lal <sanjayl@kymasys.com>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     kvm@vger.kernel.org, linux-mips@linux-mips.org,
        linux-ia64@vger.kernel.org, James Hogan <james.hogan@imgtec.com>,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH -next] ia64, metag: Do not export min_low_pfn in arch-specific code
Date:   Sat, 27 Apr 2013 20:20:31 +0200
Message-Id: <1367086831-10740-1-git-send-email-geert@linux-m68k.org>
X-Mailer: git-send-email 1.7.0.4
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36300
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

As of commit 787dcbe6984b3638e94f60d807dcb51bb8a07211 ("MIPS: Export
symbols used by KVM/MIPS module"), min_low_pfn is already exported by
the generic mm/bootmem.c, causing:

WARNING: vmlinux: 'min_low_pfn' exported twice. Previous export was in vmlinux

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/ia64/kernel/ia64_ksyms.c   |    1 -
 arch/metag/kernel/metag_ksyms.c |    1 -
 2 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/ia64/kernel/ia64_ksyms.c b/arch/ia64/kernel/ia64_ksyms.c
index 5b7791d..ca95c8b 100644
--- a/arch/ia64/kernel/ia64_ksyms.c
+++ b/arch/ia64/kernel/ia64_ksyms.c
@@ -25,7 +25,6 @@ EXPORT_SYMBOL(copy_page);
 
 #ifdef CONFIG_VIRTUAL_MEM_MAP
 #include <linux/bootmem.h>
-EXPORT_SYMBOL(min_low_pfn);	/* defined by bootmem.c, but not exported by generic code */
 EXPORT_SYMBOL(max_low_pfn);	/* defined by bootmem.c, but not exported by generic code */
 #endif
 
diff --git a/arch/metag/kernel/metag_ksyms.c b/arch/metag/kernel/metag_ksyms.c
index ec872ef..08e9b6f 100644
--- a/arch/metag/kernel/metag_ksyms.c
+++ b/arch/metag/kernel/metag_ksyms.c
@@ -12,7 +12,6 @@ EXPORT_SYMBOL(copy_page);
 #ifdef CONFIG_FLATMEM
 /* needed for the pfn_valid macro */
 EXPORT_SYMBOL(max_pfn);
-EXPORT_SYMBOL(min_low_pfn);
 #endif
 
 /* TBI symbols */
-- 
1.7.0.4
