Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 11 May 2013 19:40:56 +0200 (CEST)
Received: from mail-pd0-f173.google.com ([209.85.192.173]:56668 "EHLO
        mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822664Ab3EKRkyHbbvv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 11 May 2013 19:40:54 +0200
Received: by mail-pd0-f173.google.com with SMTP id v10so3484696pde.4
        for <multiple recipients>; Sat, 11 May 2013 10:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=YCbvmE2kjo0Fkl1FgLDtC6uZeMtsy1XBRGTVcDkQKpg=;
        b=xVI/rU6KiPN480vUpJIv84zeVoFPReEJ8HWNqd2m+q8DVSrw0dJLx4k3wgNM9t7+VA
         VAjtI9DhZpZbFnRIno9Rbd6ekqeHWFPDqylyDQ5z6vSAdmLh/mpP/X2sZMEE91kArG2t
         jK5R/T+l+HAURlYH+y029c7jG4KBQgBkDIhyx3E/vsqK3QecQ4GUq29ejM+HhE4DvTCT
         QsG2jlxK4MNgNZirZemgC3bX9V4L89Xr2A8t0ey8gI4/64ooCccswC82m5/MXXvLcXVw
         eNbg+c0UuG+UM+ITi5fmg4ZZBgQnvCJ9bK1s9X+onDtjuRINaJ7vM8mtLEnfSpkObBaR
         aIsw==
X-Received: by 10.68.232.42 with SMTP id tl10mr22278752pbc.72.1368294047555;
        Sat, 11 May 2013 10:40:47 -0700 (PDT)
Received: from localhost.localdomain ([114.250.79.205])
        by mx.google.com with ESMTPSA id 10sm7299323pbm.0.2013.05.11.10.40.40
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 11 May 2013 10:40:46 -0700 (PDT)
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
Subject: [PATCH v6, part3 06/16] mm, powertv: use free_reserved_area() to simplify code
Date:   Sun, 12 May 2013 01:34:39 +0800
Message-Id: <1368293689-16410-7-git-send-email-jiang.liu@huawei.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <1368293689-16410-1-git-send-email-jiang.liu@huawei.com>
References: <1368293689-16410-1-git-send-email-jiang.liu@huawei.com>
Return-Path: <liuj97@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36383
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
 arch/mips/powertv/asic/asic_devices.c | 13 ++-----------
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
1.8.1.2
