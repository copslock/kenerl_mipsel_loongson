Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Mar 2007 22:55:01 +0100 (BST)
Received: from sccrmhc11.comcast.net ([63.240.77.81]:1173 "EHLO
	sccrmhc11.comcast.net") by ftp.linux-mips.org with ESMTP
	id S20022479AbXC1VzA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 28 Mar 2007 22:55:00 +0100
Received: from plexity.net (c-71-193-156-244.hsd1.or.comcast.net[71.193.156.244])
          by comcast.net (sccrmhc11) with ESMTP
          id <2007032821541501100kef34e>; Wed, 28 Mar 2007 21:54:15 +0000
Received: by plexity.net (Postfix, from userid 1025)
	id E9EBC5444C1; Wed, 28 Mar 2007 13:54:42 -0700 (PDT)
Date:	Wed, 28 Mar 2007 13:54:42 -0700
From:	Deepak Saxena <dsaxena@plexity.net>
To:	ralf@linux-mips.org
Cc:	Manish Lachwani <mlachwani@mvista.com>,
	Ingo Molnar <mingo@elte.hu>, linux-mips@linux-mips.org
Subject: [PATCH] Make page fault preempt-safe
Message-ID: <20070328205442.GA18508@plexity.net>
Reply-To: dsaxena@plexity.net
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Plexity Networks
User-Agent: Mutt/1.5.11
Return-Path: <dsaxena@plexity.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14765
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dsaxena@plexity.net
Precedence: bulk
X-list: linux-mips


Like the udelay() patch, this makes vmalloc_fault() preempt-safe under 
DEBUG_PREEMPT.

Signed-off-by: Deepak Saxena <dsaxena@mvista.com>

diff --git a/arch/mips/mm/fault.c b/arch/mips/mm/fault.c
index 6f90e7e..a2466c8 100644
--- a/arch/mips/mm/fault.c
+++ b/arch/mips/mm/fault.c
@@ -228,7 +228,7 @@ vmalloc_fault:
 		pmd_t *pmd, *pmd_k;
 		pte_t *pte_k;
 
-		pgd = (pgd_t *) pgd_current[smp_processor_id()] + offset;
+		pgd = (pgd_t *) pgd_current[raw_smp_processor_id()] + offset;
 		pgd_k = init_mm.pgd + offset;
 
 		if (!pgd_present(*pgd_k))

-- 
Deepak Saxena - dsaxena@plexity.net - http://www.plexity.net

In the end, they will not say, "those were dark times,"  they will ask
"why were their poets silent?" - Bertolt Brecht
