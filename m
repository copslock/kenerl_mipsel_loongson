Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jul 2015 17:53:40 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:29099 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010210AbbGJPxjHnVg1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Jul 2015 17:53:39 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 984B5E6ADB34A;
        Fri, 10 Jul 2015 16:53:30 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 10 Jul 2015 16:53:33 +0100
Received: from localhost (10.100.200.189) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Fri, 10 Jul
 2015 16:53:32 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 2/2] MIPS: malta: use generic platform_maar_init
Date:   Fri, 10 Jul 2015 16:52:39 +0100
Message-ID: <1436543559-26886-3-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.4.4
In-Reply-To: <1436543559-26886-1-git-send-email-paul.burton@imgtec.com>
References: <1436543559-26886-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.189]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48195
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

The default implementation of platform_maar_init is sufficient for Malta
boards where we want to allow speculation in the regions of memory
corresponding to DDR & disallow it elsewhere. Drop the custom
implementation such that the default is used, reducing the duplication
of information provided by the Malta platform code.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/mti-malta/malta-memory.c | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/arch/mips/mti-malta/malta-memory.c b/arch/mips/mti-malta/malta-memory.c
index b769657..dadeb83 100644
--- a/arch/mips/mti-malta/malta-memory.c
+++ b/arch/mips/mti-malta/malta-memory.c
@@ -179,31 +179,6 @@ void __init prom_free_prom_memory(void)
 	}
 }
 
-unsigned platform_maar_init(unsigned num_pairs)
-{
-	phys_addr_t mem_end = (physical_memsize & ~0xffffull) - 1;
-	struct maar_config cfg[] = {
-		/* DRAM preceding I/O */
-		{ 0x00000000, 0x0fffffff, MIPS_MAAR_S },
-
-		/* DRAM following I/O */
-		{ 0x20000000, mem_end, MIPS_MAAR_S },
-
-		/* DRAM alias in upper half of physical */
-		{ 0x80000000, 0x80000000 + mem_end, MIPS_MAAR_S },
-	};
-	unsigned i, num_cfg = ARRAY_SIZE(cfg);
-
-	/* If DRAM fits before I/O, drop the region following it */
-	if (physical_memsize <= 0x10000000) {
-		num_cfg--;
-		for (i = 1; i < num_cfg; i++)
-			cfg[i] = cfg[i + 1];
-	}
-
-	return maar_config(cfg, num_cfg, num_pairs);
-}
-
 phys_addr_t mips_cdmm_phys_base(void)
 {
 	/* This address is "typically unused" */
-- 
2.4.4
