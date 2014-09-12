Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Sep 2014 22:17:36 +0200 (CEST)
Received: from mail-wg0-f46.google.com ([74.125.82.46]:49723 "EHLO
        mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008338AbaILURfJO674 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Sep 2014 22:17:35 +0200
Received: by mail-wg0-f46.google.com with SMTP id n12so1262214wgh.29
        for <linux-mips@linux-mips.org>; Fri, 12 Sep 2014 13:17:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=H6+bgosjXpm1bTfJ8GRVGFGdSSubX0fmWl2UyXk1aCs=;
        b=KblUWWpzkyXMYJCq1rxE7HWwe+An1Ip6WpDDEdVLqj7Su8DazQGPl4cP4Ppn9QyQAG
         YuDuxciqG5lyHSQcWVijYDH3veNxzO+zqalr1e+pHLH2ZTziODbUBbPdDxlHbYY4B6OV
         Sz2VMh4h9VkQg1sxw4NHGyCagEkN3p2rkgCCP49/FWB2dkUj40qlbwOq+33OgodQxa00
         IVOotN7O5OAg5CM0TJbryN8WNytCesKiNKZIwzQXMpyGYOQrOKDe6MNkeFLIS2A4uXTY
         BGmCYtx8GZDG8SNV3dkVqhOdAJHTRXJ/4+2nr014KBL4RaO0lrdpYoccTLeBCdw0oI1C
         rBLg==
X-Gm-Message-State: ALoCoQn3OOfA5oYcM2cM9aTKmVC1BXoTokIfvklF8n9n8OwvxIRbiiNOYvHgk+wkiKMXvzAINIha
X-Received: by 10.194.61.99 with SMTP id o3mr13862626wjr.103.1410553047908;
        Fri, 12 Sep 2014 13:17:27 -0700 (PDT)
Received: from ards-macbook-pro.local (cag06-7-83-153-85-71.fbx.proxad.net. [83.153.85.71])
        by mx.google.com with ESMTPSA id ny6sm1749257wic.22.2014.09.12.13.17.26
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 12 Sep 2014 13:17:27 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     kvm@vger.kernel.org, pbonzini@redhat.com,
        christoffer.dall@linaro.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, ralf@linux-mips.org,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        akpm@linux-foundation.org
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH] mm: export symbol dependencies of is_zero_pfn()
Date:   Fri, 12 Sep 2014 22:17:23 +0200
Message-Id: <1410553043-575-1-git-send-email-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 1.8.3.2
Return-Path: <ard.biesheuvel@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42525
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ard.biesheuvel@linaro.org
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

In order to make the static inline function is_zero_pfn() callable by
modules, export its symbol dependencies 'zero_pfn' and (for s390 and
mips) 'zero_page_mask'.

We need this for KVM, as CONFIG_KVM is a tristate for all supported
architectures except ARM and arm64, and testing a pfn whether it refers
to the zero page is required to correctly distinguish the zero page
from other special RAM ranges that may also have the PG_reserved bit
set, but need to be treated as MMIO memory.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/mips/mm/init.c | 1 +
 arch/s390/mm/init.c | 1 +
 mm/memory.c         | 2 ++
 3 files changed, 4 insertions(+)

diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 571aab064936..f42e35e42790 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -53,6 +53,7 @@
  */
 unsigned long empty_zero_page, zero_page_mask;
 EXPORT_SYMBOL_GPL(empty_zero_page);
+EXPORT_SYMBOL(zero_page_mask);
 
 /*
  * Not static inline because used by IP27 special magic initialization code
diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index 0c1073ed1e84..c7235e01fd67 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -43,6 +43,7 @@ pgd_t swapper_pg_dir[PTRS_PER_PGD] __attribute__((__aligned__(PAGE_SIZE)));
 
 unsigned long empty_zero_page, zero_page_mask;
 EXPORT_SYMBOL(empty_zero_page);
+EXPORT_SYMBOL(zero_page_mask);
 
 static void __init setup_zero_pages(void)
 {
diff --git a/mm/memory.c b/mm/memory.c
index adeac306610f..d17f1bcd2a91 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -118,6 +118,8 @@ __setup("norandmaps", disable_randmaps);
 unsigned long zero_pfn __read_mostly;
 unsigned long highest_memmap_pfn __read_mostly;
 
+EXPORT_SYMBOL(zero_pfn);
+
 /*
  * CONFIG_MMU architectures set up ZERO_PAGE in their paging_init()
  */
-- 
1.8.3.2
