Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 06 Apr 2013 15:56:39 +0200 (CEST)
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35029 "EHLO
        mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823009Ab3DFN4iURrdC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 6 Apr 2013 15:56:38 +0200
Received: by mail-pa0-f47.google.com with SMTP id bj3so2497817pad.20
        for <multiple recipients>; Sat, 06 Apr 2013 06:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=AaHjsGPm0uU8h9VEmFnPm/QOR8wfJFDCmOt3TAHGp/0=;
        b=eItVHEaEl2Np9xPsiIst2CKdnZwRKr8L+u58sH5SfijhIwRCqtcgCNpGjSBQm5jq+/
         nOCO1cGbApWBuE8ndCgteUr+yEwpcyHS+m/io2AZgagwKm30tJz3RJ6GxZHjMxsTL8Wd
         cKPbC8Y/FjdRCXQ7OrXh3WOMCm0JoV33D0uddjRG7m4c2UPWA4/uoOEYcP38NsxtsTGl
         r5IT05Sigix4EmMJQDTCHQoTgtr+1XguZVS2Uqj0usj+ueu31K0S0uOkWPQaVQoyYzSB
         bl+nYNhyXVvp2KnMG+up8gBQb4HCFffypZXg0CcXsPcC/n+NB8RddlCzqDNFl7B15iN8
         UNfA==
X-Received: by 10.68.209.194 with SMTP id mo2mr19850789pbc.37.1365256591373;
        Sat, 06 Apr 2013 06:56:31 -0700 (PDT)
Received: from localhost.localdomain ([114.250.92.211])
        by mx.google.com with ESMTPS id ef3sm20423445pad.20.2013.04.06.06.56.23
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 06 Apr 2013 06:56:30 -0700 (PDT)
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
Subject: [PATCH v4, part3 06/15] mm, powertv: use free_reserved_area() to simplify code
Date:   Sat,  6 Apr 2013 21:55:00 +0800
Message-Id: <1365256509-29024-7-git-send-email-jiang.liu@huawei.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1365256509-29024-1-git-send-email-jiang.liu@huawei.com>
References: <1365256509-29024-1-git-send-email-jiang.liu@huawei.com>
Return-Path: <liuj97@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36022
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

Use common help function free_reserved_area() to simplify code.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Jiang Liu <jiang.liu@huawei.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
---
 arch/mips/powertv/asic/asic_devices.c |   13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/arch/mips/powertv/asic/asic_devices.c b/arch/mips/powertv/asic/asic_devices.c
index d38b095..9f64c23 100644
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
