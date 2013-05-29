Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 May 2013 16:45:53 +0200 (CEST)
Received: from mail-pa0-f54.google.com ([209.85.220.54]:53260 "EHLO
        mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6833452Ab3E2OpoqHIvo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 May 2013 16:45:44 +0200
Received: by mail-pa0-f54.google.com with SMTP id kx1so9388967pab.13
        for <multiple recipients>; Wed, 29 May 2013 07:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=67QLURp4GXI2jVi1/7rB4zwgCt17VGSGVBlAW7fBA5A=;
        b=BiHRJTbJB+gMjRph6PuN8JE6vpbCq7O1WOPrNwLuZvQhp7BKCfeyu50S3a+SoGcq/d
         NYbTQ8QQQmygDRZL6WRShgOL8m7JSBzDBRyhhbOd9pjKJKjl2Q4/eVMKhAuTTRjXUhdl
         NFOsMsUbE2Qglp7pAxNZSPahf8f7glq1LlyyQHt9a5UZVVlIsA2rJU30hY4AzmPTLJ8r
         rTZ8mSNoxiCctpOiaikFhTcrLxBWITvgkKHk1gn73LmV5xy7a8R6laZejL59DvsyvS6P
         CA6LZ5TukPq49LoLecWgd5BFXrfFerB6vhUZGtawAJnHcD8EwwGrNpD8jvgKFIqRJcFS
         SrDw==
X-Received: by 10.68.94.5 with SMTP id cy5mr3207791pbb.62.1369838738201;
        Wed, 29 May 2013 07:45:38 -0700 (PDT)
Received: from localhost.localdomain (pppoe146.47.east.tokyo.dcn.ne.jp. [219.105.47.146])
        by mx.google.com with ESMTPSA id zs12sm40209652pab.0.2013.05.29.07.45.35
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 29 May 2013 07:45:37 -0700 (PDT)
From:   Jiang Liu <liuj97@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jiang Liu <jiang.liu@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Wen Congyang <wency@cn.fujitsu.com>,
        Mel Gorman <mgorman@suse.de>, Minchan Kim <minchan@kernel.org>,
        KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
        Michal Hocko <mhocko@suse.cz>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        David Howells <dhowells@redhat.com>,
        Mark Salter <msalter@redhat.com>,
        Jianguo Wu <wujianguo@huawei.com>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH, v2 07/13] mm/MIPS: prepare for killing free_all_bootmem_node()
Date:   Wed, 29 May 2013 22:44:46 +0800
Message-Id: <1369838692-26860-8-git-send-email-jiang.liu@huawei.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <1369838692-26860-1-git-send-email-jiang.liu@huawei.com>
References: <1369838692-26860-1-git-send-email-jiang.liu@huawei.com>
Return-Path: <liuj97@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36631
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
 arch/mips/sgi-ip27/ip27-memory.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/mips/sgi-ip27/ip27-memory.c b/arch/mips/sgi-ip27/ip27-memory.c
index a0c9e34..a95c00f 100644
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
1.8.1.2
