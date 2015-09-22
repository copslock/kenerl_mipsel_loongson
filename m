Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Sep 2015 21:04:05 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:37241 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008792AbbIVTEDwA1KP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Sep 2015 21:04:03 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 1B4DAAE3654CC;
        Tue, 22 Sep 2015 20:03:54 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 22 Sep 2015 20:03:57 +0100
Received: from localhost (192.168.159.189) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 22 Sep
 2015 20:03:55 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Joshua Kinard <kumba@gentoo.org>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        "Markos Chandras" <markos.chandras@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] MIPS: extend hardware table walking support to MIPS64
Date:   Tue, 22 Sep 2015 12:03:37 -0700
Message-ID: <1442948617-15369-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.5.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.189]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49329
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

Extend the existing support for Hardware Table Walking (HTW) to MIPS64
systems by supporting PMDs & setting the pointer size bit in PWSize,
then ceasing to blacklist HTW on MIPS64 systems.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/kernel/cpu-probe.c | 3 +--
 arch/mips/mm/tlbex.c         | 8 +++++++-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 571a8e6..417fa3d 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -534,8 +534,7 @@ static inline unsigned int decode_config3(struct cpuinfo_mips *c)
 		c->options |= MIPS_CPU_SEGMENTS;
 	if (config3 & MIPS_CONF3_MSA)
 		c->ases |= MIPS_ASE_MSA;
-	/* Only tested on 32-bit cores */
-	if ((config3 & MIPS_CONF3_PW) && config_enabled(CONFIG_32BIT)) {
+	if (config3 & MIPS_CONF3_PW) {
 		c->htw_seq = 0;
 		c->options |= MIPS_CPU_HTW;
 	}
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 323d1d3..6d22a33 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -2299,6 +2299,10 @@ static void config_htw_params(void)
 	/* re-initialize the PTI field including the even/odd bit */
 	pwfield &= ~MIPS_PWFIELD_PTI_MASK;
 	pwfield |= PAGE_SHIFT << MIPS_PWFIELD_PTI_SHIFT;
+	if (CONFIG_PGTABLE_LEVELS >= 3) {
+		pwfield &= ~MIPS_PWFIELD_MDI_MASK;
+		pwfield |= PMD_SHIFT << MIPS_PWFIELD_MDI_SHIFT;
+	}
 	/* Set the PTEI right shift */
 	ptei = _PAGE_GLOBAL_SHIFT << MIPS_PWFIELD_PTEI_SHIFT;
 	pwfield |= ptei;
@@ -2320,9 +2324,11 @@ static void config_htw_params(void)
 
 	pwsize = ilog2(PTRS_PER_PGD) << MIPS_PWSIZE_GDW_SHIFT;
 	pwsize |= ilog2(PTRS_PER_PTE) << MIPS_PWSIZE_PTW_SHIFT;
+	if (CONFIG_PGTABLE_LEVELS >= 3)
+		pwsize |= ilog2(PTRS_PER_PMD) << MIPS_PWSIZE_MDW_SHIFT;
 
 	/* If XPA has been enabled, PTEs are 64-bit in size. */
-	if (read_c0_pagegrain() & PG_ELPA)
+	if (config_enabled(CONFIG_64BITS) || (read_c0_pagegrain() & PG_ELPA))
 		pwsize |= 1;
 
 	write_c0_pwsize(pwsize);
-- 
2.5.3
