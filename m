Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Apr 2014 16:33:47 +0200 (CEST)
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:29457 "EHLO
        mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6843072AbaD2ObzG9NCo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 29 Apr 2014 16:31:55 +0200
X-IronPort-AV: E=Sophos;i="4.97,951,1389772800"; 
   d="scan'208";a="26850000"
Received: from irvexchcas08.broadcom.com (HELO IRVEXCHCAS08.corp.ad.broadcom.com) ([10.9.208.57])
  by mail-gw2-out.broadcom.com with ESMTP; 29 Apr 2014 07:57:03 -0700
Received: from IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP Server
 (TLS) id 14.3.174.1; Tue, 29 Apr 2014 07:31:52 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) with Microsoft SMTP Server id
 14.3.174.1; Tue, 29 Apr 2014 07:31:53 -0700
Received: from netl-snoppy.ban.broadcom.com (netl-snoppy.ban.broadcom.com
 [10.132.128.129])      by mail-irva-13.broadcom.com (Postfix) with ESMTP id
 3354F51E7D;    Tue, 29 Apr 2014 07:31:50 -0700 (PDT)
From:   Jayachandran C <jchandra@broadcom.com>
To:     <linux-mips@linux-mips.org>
CC:     Jayachandran C <jchandra@broadcom.com>, <ralf@linux-mips.org>
Subject: [PATCH 06/17] MIPS: Netlogic: Use cpumask_scnprintf for wakup_mask
Date:   Tue, 29 Apr 2014 20:07:45 +0530
Message-ID: <26b70b3880094baa731bfe9b2927fd6d872b82fc.1398780013.git.jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1398780013.git.jchandra@broadcom.com>
References: <cover.1398780013.git.jchandra@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39973
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
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

Use standard function to print cpumask. Also fixup a typo in the same
file.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/netlogic/common/smp.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/mips/netlogic/common/smp.c b/arch/mips/netlogic/common/smp.c
index 6baae15..b93c5d4 100644
--- a/arch/mips/netlogic/common/smp.c
+++ b/arch/mips/netlogic/common/smp.c
@@ -198,7 +198,7 @@ void __init nlm_smp_setup(void)
 	cpumask_scnprintf(buf, ARRAY_SIZE(buf), cpu_possible_mask);
 	pr_info("Possible CPU mask: %s\n", buf);
 
-	/* check with the cores we have worken up */
+	/* check with the cores we have woken up */
 	for (ncore = 0, i = 0; i < NLM_NR_NODES; i++)
 		ncore += hweight32(nlm_get_node(i)->coremask);
 
@@ -213,6 +213,7 @@ static int nlm_parse_cpumask(cpumask_t *wakeup_mask)
 {
 	uint32_t core0_thr_mask, core_thr_mask;
 	int threadmode, i, j;
+	char buf[64];
 
 	core0_thr_mask = 0;
 	for (i = 0; i < NLM_THREADS_PER_CORE; i++)
@@ -247,8 +248,8 @@ static int nlm_parse_cpumask(cpumask_t *wakeup_mask)
 	return threadmode;
 
 unsupp:
-	panic("Unsupported CPU mask %lx",
-		(unsigned long)cpumask_bits(wakeup_mask)[0]);
+	cpumask_scnprintf(buf, ARRAY_SIZE(buf), wakeup_mask);
+	panic("Unsupported CPU mask %s", buf);
 	return 0;
 }
 
-- 
1.7.9.5
