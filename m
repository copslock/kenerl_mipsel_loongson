Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 May 2016 23:26:16 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:25244 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27036621AbcE0VZkyuZcQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 May 2016 23:25:40 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email with ESMTPS id F1CC813CBA33F;
        Fri, 27 May 2016 22:25:29 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 27 May 2016 22:25:34 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Fri, 27 May 2016 22:25:34 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        <linux-mips@linux-mips.org>
Subject: [PATCH 2/2] MIPS: Fix 64-bit HTW configuration
Date:   Fri, 27 May 2016 22:25:23 +0100
Message-ID: <1464384323-4520-3-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1464384323-4520-1-git-send-email-james.hogan@imgtec.com>
References: <1464384323-4520-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53679
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

The Hardware page Table Walker (HTW) is being misconfigured on 64-bit
kernels. The PWSize.PS (pointer size) bit determines whether pointers
within directories are loaded as 32-bit or 64-bit addresses, but was
never being set to 1 for 64-bit kernels where the unsigned long in pgd_t
is 64-bits wide.

This actually reduces rather than improves performance when the HTW is
enabled on P6600 since the HTW is initiated lots, but walks are all
aborted due I think to bad intermediate pointers.

Since we were already taking the width of the PTEs into account by
setting PWSize.PTEW, which is the left shift applied to the page table
index *in addition to* the native pointer size, we also need to reduce
PTEW by 1 when PS=1. This is done by calculating PTEW based on the
relative size of pte_t compared to pgd_t.

Finally in order for the HTW to be used when PS=1, the appropriate
XK/XS/XU bits corresponding to the different 64-bit segments need to be
set in PWCtl. We enable only XU for now to enable walking for XUSeg.

Supporting walking for XKSeg would be a bit more involved so is left for
a future patch. It would either require the use of a per-CPU top level
base directory if supported by the HTW (a bit like pgd_current but with
a second entry pointing at swapper_pg_dir), or the HTW would prepend bit
63 of the address to the global directory index which doesn't really
match how we split user and kernel page directories.

Fixes: cab25bc7537b ("MIPS: Extend hardware table walking support to MIPS64")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org
---
 arch/mips/mm/tlbex.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index c363890368cd..4004b659ce50 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -2431,15 +2431,25 @@ static void config_htw_params(void)
 	if (CONFIG_PGTABLE_LEVELS >= 3)
 		pwsize |= ilog2(PTRS_PER_PMD) << MIPS_PWSIZE_MDW_SHIFT;
 
-	pwsize |= ilog2(sizeof(pte_t)/4) << MIPS_PWSIZE_PTEW_SHIFT;
+	/* Set pointer size to size of directory pointers */
+	if (config_enabled(CONFIG_64BIT))
+		pwsize |= MIPS_PWSIZE_PS_MASK;
+	/* PTEs may be multiple pointers long (e.g. with XPA) */
+	pwsize |= ((PTE_T_LOG2 - PGD_T_LOG2) << MIPS_PWSIZE_PTEW_SHIFT)
+			& MIPS_PWSIZE_PTEW_MASK;
 
 	write_c0_pwsize(pwsize);
 
 	/* Make sure everything is set before we enable the HTW */
 	back_to_back_c0_hazard();
 
-	/* Enable HTW and disable the rest of the pwctl fields */
+	/*
+	 * Enable HTW (and only for XUSeg on 64-bit), and disable the rest of
+	 * the pwctl fields.
+	 */
 	config = 1 << MIPS_PWCTL_PWEN_SHIFT;
+	if (config_enabled(CONFIG_64BIT))
+		config |= MIPS_PWCTL_XU_MASK;
 	write_c0_pwctl(config);
 	pr_info("Hardware Page Table Walker enabled\n");
 
-- 
2.4.10
