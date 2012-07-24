Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jul 2012 03:10:39 +0200 (CEST)
Received: from LGEMRELSE1Q.lge.com ([156.147.1.111]:44694 "EHLO
        LGEMRELSE1Q.lge.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903712Ab2GXBK1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Jul 2012 03:10:27 +0200
X-AuditID: 9c93016f-b7b08ae00000790d-e8-500df5f6575e
Received: from localhost.localdomain ( [10.177.220.67])
        by LGEMRELSE1Q.lge.com (Symantec Brightmail Gateway) with SMTP id CA.2D.30989.7F5FD005; Tue, 24 Jul 2012 10:10:16 +0900 (KST)
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>, Yinghai Lu <yinghai@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Minchan Kim <minchan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 1/3] mips: zero out pg_data_t when it's allocated
Date:   Tue, 24 Jul 2012 10:10:33 +0900
Message-Id: <1343092235-13399-1-git-send-email-minchan@kernel.org>
X-Mailer: git-send-email 1.7.9.5
X-Brightmail-Tracker: AAAAAA==
X-archive-position: 33957
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: minchan@kernel.org
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

This patch is ready for next patch which try to remove zero-out
of pg_data_t in core MM part. At a glance, all archs except this part
already have done it so this patch makes consistent with other archs.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 arch/mips/sgi-ip27/ip27-memory.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/sgi-ip27/ip27-memory.c b/arch/mips/sgi-ip27/ip27-memory.c
index b105eca..cd8fcab 100644
--- a/arch/mips/sgi-ip27/ip27-memory.c
+++ b/arch/mips/sgi-ip27/ip27-memory.c
@@ -401,6 +401,7 @@ static void __init node_mem_init(cnodeid_t node)
 	 * Allocate the node data structures on the node first.
 	 */
 	__node_data[node] = __va(slot_freepfn << PAGE_SHIFT);
+	memset(__node_data[node], 0, PAGE_SIZE);
 
 	NODE_DATA(node)->bdata = &bootmem_node_data[node];
 	NODE_DATA(node)->node_start_pfn = start_pfn;
-- 
1.7.9.5
