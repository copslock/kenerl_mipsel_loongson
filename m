Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Aug 2012 09:11:10 +0200 (CEST)
Received: from mail-yx0-f177.google.com ([209.85.213.177]:34067 "EHLO
        mail-yx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903722Ab2HCHHa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 3 Aug 2012 09:07:30 +0200
Received: by mail-yx0-f177.google.com with SMTP id r9so506866yen.36
        for <multiple recipients>; Fri, 03 Aug 2012 00:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=rHS4PP1RdxLXdBHjjv8BZyshZKEGg+xI8YL2CedeiHI=;
        b=v3c0FshN3YCl1OgID3ULX2AlBEHpo71aViJRmGiA9gUFDeF8yKJlA6kuDPgAti38aq
         PCC0MQrqRE5hGX4vBOD9lOjTuzfXEuoes2nBZsq16AeF09qI0+9M0OqA+1mlLxOufDEK
         MZfuOke+e4v7VxElLLxoi3HqTfOrJgwt0pcfl4NJXLJLAGLaQ/rsx/CftlsjMaCIb0rE
         We/D+Dtev14pd+qUPc1sg+jXmIXHuu1UK3tFF/2UGoBstXokUlPPxIj3ULqwpnW4NrRY
         hPbfWGb/zNoNOWH/UIANKm69mg2m5DATssxB5LcexxFsNcN6R5CeI/xl0x+I3Am//qcz
         CuWg==
Received: by 10.42.162.195 with SMTP id z3mr1276306icx.4.1343977649937;
        Fri, 03 Aug 2012 00:07:29 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id z3sm20852677igc.7.2012.08.03.00.07.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 03 Aug 2012 00:07:29 -0700 (PDT)
From:   Huacai Chen <chenhuacai@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH V4 11/16] drm/radeon: Make radeon card usable for Loongson.
Date:   Fri,  3 Aug 2012 15:06:06 +0800
Message-Id: <1343977571-2292-12-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1343977571-2292-1-git-send-email-chenhc@lemote.com>
References: <1343977571-2292-1-git-send-email-chenhc@lemote.com>
X-archive-position: 34035
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhuacai@gmail.com
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

1, Handle io prot correctly for MIPS.
2, Define SAREA_MAX as the size of one page.
3, Include swiotlb.h if SWIOTLB configured.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Hongliang Tao <taohl@lemote.com>
Signed-off-by: Hua Yan <yanh@lemote.com>
Cc: dri-devel@lists.freedesktop.org
---
 drivers/gpu/drm/drm_vm.c            |    2 +-
 drivers/gpu/drm/radeon/radeon_ttm.c |    4 ++++
 drivers/gpu/drm/ttm/ttm_bo_util.c   |    2 +-
 include/drm/drm_sarea.h             |    2 ++
 4 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_vm.c b/drivers/gpu/drm/drm_vm.c
index 961ee08..3f06166 100644
--- a/drivers/gpu/drm/drm_vm.c
+++ b/drivers/gpu/drm/drm_vm.c
@@ -62,7 +62,7 @@ static pgprot_t drm_io_prot(uint32_t map_type, struct vm_area_struct *vma)
 		tmp = pgprot_writecombine(tmp);
 	else
 		tmp = pgprot_noncached(tmp);
-#elif defined(__sparc__) || defined(__arm__)
+#elif defined(__sparc__) || defined(__arm__) || defined(__mips__)
 	tmp = pgprot_noncached(tmp);
 #endif
 	return tmp;
diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon/radeon_ttm.c
index 5b71c71..fc3ac22 100644
--- a/drivers/gpu/drm/radeon/radeon_ttm.c
+++ b/drivers/gpu/drm/radeon/radeon_ttm.c
@@ -41,6 +41,10 @@
 #include "radeon_reg.h"
 #include "radeon.h"
 
+#ifdef CONFIG_SWIOTLB
+#include <linux/swiotlb.h>
+#endif
+
 #define DRM_FILE_PAGE_OFFSET (0x100000000ULL >> PAGE_SHIFT)
 
 static int radeon_ttm_debugfs_init(struct radeon_device *rdev);
diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
index f8187ea..0df71ea 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_util.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
@@ -472,7 +472,7 @@ pgprot_t ttm_io_prot(uint32_t caching_flags, pgprot_t tmp)
 	else
 		tmp = pgprot_noncached(tmp);
 #endif
-#if defined(__sparc__)
+#if defined(__sparc__) || defined(__mips__)
 	if (!(caching_flags & TTM_PL_FLAG_CACHED))
 		tmp = pgprot_noncached(tmp);
 #endif
diff --git a/include/drm/drm_sarea.h b/include/drm/drm_sarea.h
index ee5389d..1d1a858 100644
--- a/include/drm/drm_sarea.h
+++ b/include/drm/drm_sarea.h
@@ -37,6 +37,8 @@
 /* SAREA area needs to be at least a page */
 #if defined(__alpha__)
 #define SAREA_MAX                       0x2000U
+#elif defined(__mips__)
+#define SAREA_MAX                       0x4000U
 #elif defined(__ia64__)
 #define SAREA_MAX                       0x10000U	/* 64kB */
 #else
-- 
1.7.7.3
