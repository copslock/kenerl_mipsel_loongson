Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Apr 2013 17:41:35 +0200 (CEST)
Received: from mail-pd0-f174.google.com ([209.85.192.174]:36239 "EHLO
        mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835098Ab3DMPle3pBWG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 13 Apr 2013 17:41:34 +0200
Received: by mail-pd0-f174.google.com with SMTP id p12so1876429pdj.19
        for <multiple recipients>; Sat, 13 Apr 2013 08:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=YUseVs047IhbR5J6SHCav1rn2ZvVRWsXrf2K/gvf5y4=;
        b=07/aWiUsaZIbt+En8i9f5Tqfv46XUg0T0gyTizT9RNMXBYNcUqcX7CDdx6K1byLnvv
         96vF6eA95lXjuqK9Fdg6kgkEVC2tvSDcudUpx1MKW4qmc19bnPpCZ9UUNLLGn7BsOV9H
         psjZurM2Rvz5PHMlgWJFA726wdKIWjJCMfzHAG7c4cZUggvbxCG4SBPLhbVLS8lGrDFH
         tN+DCaAJvK/JRz/cM087pbKv4OOm8IqXHghewPYePfqHOxcJaLlOwaA9nUwfuP5hUMpK
         7KA8nOfDZ8fLUDAVHKepwNMZgXCfQ2RcRAak02iB2p08yNSrq2VyV1AjGkcfTiLjGChm
         O1nA==
X-Received: by 10.66.49.38 with SMTP id r6mr20859082pan.212.1365867687539;
        Sat, 13 Apr 2013 08:41:27 -0700 (PDT)
Received: from localhost.localdomain ([114.250.101.164])
        by mx.google.com with ESMTPS id dg5sm12981254pbc.29.2013.04.13.08.41.17
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 13 Apr 2013 08:41:26 -0700 (PDT)
From:   Jiang Liu <liuj97@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Yinghai Lu <yinghai@kernel.org>
Cc:     Jiang Liu <jiang.liu@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Wen Congyang <wency@cn.fujitsu.com>,
        Mel Gorman <mgorman@suse.de>, Minchan Kim <minchan@kernel.org>,
        KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
        Michal Hocko <mhocko@suse.cz>,
        David Howells <dhowells@redhat.com>,
        Mark Salter <msalter@redhat.com>,
        Jianguo Wu <wujianguo@huawei.com>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [RFC PATCH v1 07/19] mm/MIPS: prepare for killing free_all_bootmem_node()
Date:   Sat, 13 Apr 2013 23:36:27 +0800
Message-Id: <1365867399-21323-8-git-send-email-jiang.liu@huawei.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1365867399-21323-1-git-send-email-jiang.liu@huawei.com>
References: <1365867399-21323-1-git-send-email-jiang.liu@huawei.com>
Return-Path: <liuj97@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36151
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: liuj97@gmail.com
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

Prepare for killing free_all_bootmem_node() by using
free_all_bootmem().

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Minchan Kim <minchan@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
---
 arch/mips/sgi-ip27/ip27-memory.c |   12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/mips/sgi-ip27/ip27-memory.c b/arch/mips/sgi-ip27/ip27-memory.c
index d074680..0ebea6f 100644
--- a/arch/mips/sgi-ip27/ip27-memory.c
+++ b/arch/mips/sgi-ip27/ip27-memory.c
@@ -477,18 +477,8 @@ void __init paging_init(void)
 
 void __init mem_init(void)
 {
-	unsigned node;
-
 	high_memory = (void *) __va(get_num_physpages() << PAGE_SHIFT);
-
-	for_each_online_node(node) {
-		/*
-		 * This will free up the bootmem, ie, slot 0 memory.
-		 */
-		free_all_bootmem_node(NODE_DATA(node));
-	}
-
+	free_all_bootmem();
 	setup_zero_pages();	/* This comes from node 0 */
-
 	mem_init_print_info(NULL);
 }
-- 
1.7.9.5
