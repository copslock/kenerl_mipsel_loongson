Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Mar 2013 18:04:15 +0100 (CET)
Received: from mail-pb0-f50.google.com ([209.85.160.50]:34335 "EHLO
        mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816154Ab3CPREOR4IGz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 16 Mar 2013 18:04:14 +0100
Received: by mail-pb0-f50.google.com with SMTP id up1so5091101pbc.9
        for <multiple recipients>; Sat, 16 Mar 2013 10:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=RmA8l7civqvdKf/QFO54LzuLldXG+76wNfN0AWrmrQw=;
        b=trwhQSXpdV5R/FczsEaSIWOOEriFU3VnXlLF5eOcelMHyEz9cpjNamZZS2AjGRoblQ
         GrD7UBrXXK8q3TpTTcyWiuNHFBs9cg0P3+10HMpLgn7wVO48yom+6EXr3RuIc6Wav3FO
         Ecwqln/S+Yb77psF3tB1Zxq/XVIl2Z1OvwYDMfoDWYTD6QEa7vGBz2uNqLLGus8CnGHB
         KqY4xr0tmM8/VrVlOYkRsbZd5gYMuxOpgOuWtbHzjSUMLVOAJ4lYkSR2ZrOwxRdtwym/
         Hf6Dr8I9X8JJ/WIbhWankj4d0AFNPiWGUrrgPteZOFb2ARbgwmDUPYjV45acBgOjQDe8
         KmmQ==
X-Received: by 10.68.242.65 with SMTP id wo1mr25188985pbc.62.1363453447772;
        Sat, 16 Mar 2013 10:04:07 -0700 (PDT)
Received: from localhost.localdomain ([120.196.98.116])
        by mx.google.com with ESMTPS id y13sm14082307pbv.0.2013.03.16.10.04.03
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 16 Mar 2013 10:04:07 -0700 (PDT)
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
        linux-mips@linux-mips.org
Subject: [PATCH v2, part3 05/12] mm/powertv: use common help functions to free reserved pages
Date:   Sun, 17 Mar 2013 01:03:26 +0800
Message-Id: <1363453413-8139-6-git-send-email-jiang.liu@huawei.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1363453413-8139-1-git-send-email-jiang.liu@huawei.com>
References: <1363453413-8139-1-git-send-email-jiang.liu@huawei.com>
X-archive-position: 35894
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

Use common help functions to free reserved pages.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Jiang Liu <jiang.liu@huawei.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
---
 arch/mips/powertv/asic/asic_devices.c |   13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/arch/mips/powertv/asic/asic_devices.c b/arch/mips/powertv/asic/asic_devices.c
index bce1872..746b06d 100644
--- a/arch/mips/powertv/asic/asic_devices.c
+++ b/arch/mips/powertv/asic/asic_devices.c
@@ -529,17 +529,8 @@ EXPORT_SYMBOL(asic_resource_get);
  */
 void platform_release_memory(void *ptr, int size)
 {
-	unsigned long addr;
-	unsigned long end;
-
-	addr = ((unsigned long)ptr + (PAGE_SIZE - 1)) & PAGE_MASK;
-	end = ((unsigned long)ptr + size) & PAGE_MASK;
-
-	for (; addr < end; addr += PAGE_SIZE) {
-		ClearPageReserved(virt_to_page(__va(addr)));
-		init_page_count(virt_to_page(__va(addr)));
-		free_page((unsigned long)__va(addr));
-	}
+	free_reserved_area((unsigned long)ptr, (unsigned long)(ptr + size),
+			   -1, NULL);
 }
 EXPORT_SYMBOL(platform_release_memory);
 
-- 
1.7.9.5
