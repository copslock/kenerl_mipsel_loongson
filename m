Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Apr 2016 12:38:11 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:6752 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026655AbcDOKh7O9uDe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Apr 2016 12:37:59 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email with ESMTPS id C6743569012CF;
        Fri, 15 Apr 2016 11:37:50 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Fri, 15 Apr 2016 11:37:53 +0100
Received: from localhost (10.100.200.59) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Fri, 15 Apr
 2016 11:37:52 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        "Adam Buchbinder" <adam.buchbinder@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        "Paul Gortmaker" <paul.gortmaker@windriver.com>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 02/12] MIPS: Fix HTW config on XPA kernel without LPA enabled
Date:   Fri, 15 Apr 2016 11:36:50 +0100
Message-ID: <1460716620-13382-3-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1460716620-13382-1-git-send-email-paul.burton@imgtec.com>
References: <1460716620-13382-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.59]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52999
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

From: James Hogan <james.hogan@imgtec.com>

The hardware page table walker (HTW) configuration is broken on XPA
kernels where XPA couldn't be enabled (either nohtw or the hardware
doesn't support it). This is because the PWSize.PTEW field (PTE width)
was only set to 8 bytes (an extra shift of 1) in config_htw_params() if
PageGrain.ELPA (enable large physical addressing) is set. On an XPA
kernel though the size of PTEs is fixed at 8 bytes regardless of whether
XPA could actually be enabled.

Fix the initialisation of this field based on sizeof(pte_t) instead.

Fixes: c5b367835cfc ("MIPS: Add support for XPA.")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Steven J. Hill <Steven.Hill@imgtec.com>
Cc: linux-mips@linux-mips.org
Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/mm/tlbex.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 84c6e3f..86aa7c2 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -2311,9 +2311,7 @@ static void config_htw_params(void)
 	if (CONFIG_PGTABLE_LEVELS >= 3)
 		pwsize |= ilog2(PTRS_PER_PMD) << MIPS_PWSIZE_MDW_SHIFT;
 
-	/* If XPA has been enabled, PTEs are 64-bit in size. */
-	if (config_enabled(CONFIG_64BITS) || (read_c0_pagegrain() & PG_ELPA))
-		pwsize |= 1;
+	pwsize |= ilog2(sizeof(pte_t)/4) << MIPS_PWSIZE_PTEW_SHIFT;
 
 	write_c0_pwsize(pwsize);
 
-- 
2.8.0
