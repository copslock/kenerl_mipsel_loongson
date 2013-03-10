Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 10 Mar 2013 09:09:28 +0100 (CET)
Received: from mail-da0-f49.google.com ([209.85.210.49]:51596 "EHLO
        mail-da0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6820505Ab3CJIJ1S112J (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 10 Mar 2013 09:09:27 +0100
Received: by mail-da0-f49.google.com with SMTP id t11so2743daj.8
        for <multiple recipients>; Sun, 10 Mar 2013 00:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=4hmxRDohHND3kgZ85+pux7NhKqeFghWG5+EPcjKXM1I=;
        b=adNLczACAjwAUkv6vrQJrRG5GcyreRl1NJ3xc/9l6+V14DxPQNWIvbbHtnU6Z2itnU
         YmhVDzf8c1nMoT7YCWsaql2LZbqmnfWQL0mPtESnkZfUq26ZwAvGwKkoWtfarKZOU8uj
         zVhpS+taB4HuUbWQ6S3mrN7Sf2U5C8QczgCJXu/AnLMpxsQ6BUzwSvqfAnDlRyoKKdZS
         JWgjfuWBctYhROsvS6ySzxYEJ1c525Hyb69hYTC1UHIHmcc7d1xvHkrHKql2k/859K1Z
         hOK9jl/M4YwpIGZB9H7eFY7gyJAQsRW1xqyKbbe704MN1iXzb2NZheXVQRc6cV2dv7KU
         uSNw==
X-Received: by 10.68.190.195 with SMTP id gs3mr10846691pbc.14.1362902960430;
        Sun, 10 Mar 2013 00:09:20 -0800 (PST)
Received: from localhost.localdomain ([114.250.98.254])
        by mx.google.com with ESMTPS id rd1sm14267202pbc.19.2013.03.10.00.09.12
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 10 Mar 2013 00:09:19 -0800 (PST)
From:   Jiang Liu <liuj97@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>
Cc:     Jiang Liu <jiang.liu@huawei.com>,
        Wen Congyang <wency@cn.fujitsu.com>,
        Mel Gorman <mgorman@suse.de>, Minchan Kim <minchan@kernel.org>,
        KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
        Michal Hocko <mhocko@suse.cz>,
        Jianguo Wu <wujianguo@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        Cong Wang <amwang@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-mips@linux-mips.org
Subject: [PATCH v2, part2 06/10] mm/MIPS: use free_highmem_page() to free highmem pages into buddy system
Date:   Sun, 10 Mar 2013 16:01:06 +0800
Message-Id: <1362902470-25787-7-git-send-email-jiang.liu@huawei.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1362902470-25787-1-git-send-email-jiang.liu@huawei.com>
References: <1362902470-25787-1-git-send-email-jiang.liu@huawei.com>
X-archive-position: 35861
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Use helper function free_highmem_page() to free highmem pages into
the buddy system.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: David Daney <david.daney@cavium.com>
Cc: Cong Wang <amwang@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
---
 arch/mips/mm/init.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 60f7c61..3d0346d 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -393,12 +393,8 @@ void __init mem_init(void)
 			SetPageReserved(page);
 			continue;
 		}
-		ClearPageReserved(page);
-		init_page_count(page);
-		__free_page(page);
-		totalhigh_pages++;
+		free_highmem_page(page);
 	}
-	totalram_pages += totalhigh_pages;
 	num_physpages += totalhigh_pages;
 #endif
 
-- 
1.7.9.5
