Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 May 2013 17:46:28 +0200 (CEST)
Received: from mail-pb0-f47.google.com ([209.85.160.47]:35580 "EHLO
        mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835010Ab3EQPqZXmcV0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 May 2013 17:46:25 +0200
Received: by mail-pb0-f47.google.com with SMTP id rr4so3423604pbb.20
        for <multiple recipients>; Fri, 17 May 2013 08:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=YCbvmE2kjo0Fkl1FgLDtC6uZeMtsy1XBRGTVcDkQKpg=;
        b=ES7rfkvmhVtN3e9og8GGXFfzD9kOLHT7WweTb1EMeKE3Ci77Rd2bZ4VjZfbdhxYa9x
         8Cay2KoZeYsVpWCcVpw7jsdcCeANygIbT+2YY/HdIJfzlNVc6Ea2Q9QP2vc1awWCKsb+
         aRQgrTtl4nqic42xmQHh5mR1WLjOKs6N/ffW+OJFFvw0+z0H6mbopkSE4TKdEPsXRWJH
         3x9nkvGAGF9Yr7eERqXuYQ+nO/T3JHtM0dkBXR2xbSdv8DyclUOg04v9L/RlEDDMSMT8
         wBuofDpoiOVBTsIIcYpZs/Bn/YtZ3hA6t6yG3w5LKrakvIdv92s0Vk9t+N0l3nqtlUw0
         NeKg==
X-Received: by 10.68.196.65 with SMTP id ik1mr47757842pbc.194.1368805577267;
        Fri, 17 May 2013 08:46:17 -0700 (PDT)
Received: from localhost.localdomain ([120.196.98.100])
        by mx.google.com with ESMTPSA id dr6sm12699445pac.11.2013.05.17.08.46.12
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 17 May 2013 08:46:16 -0700 (PDT)
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
Subject: [PATCH v7, part3 06/16] mm, powertv: use free_reserved_area() to simplify code
Date:   Fri, 17 May 2013 23:45:08 +0800
Message-Id: <1368805518-2634-7-git-send-email-jiang.liu@huawei.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <1368805518-2634-1-git-send-email-jiang.liu@huawei.com>
References: <1368805518-2634-1-git-send-email-jiang.liu@huawei.com>
Return-Path: <liuj97@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36432
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
