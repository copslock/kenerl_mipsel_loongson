Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Oct 2012 15:31:53 +0200 (CEST)
Received: from mail-pa0-f49.google.com ([209.85.220.49]:48366 "EHLO
        mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6870326Ab2JEN1DQGBZQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Oct 2012 15:27:03 +0200
Received: by mail-pa0-f49.google.com with SMTP id bi5so1886586pad.36
        for <multiple recipients>; Fri, 05 Oct 2012 06:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=wwsN01bNbglem1+Oo67QbSeqXYqos3nHSsDd4RDmxkU=;
        b=LLKYMIcPBtr6Hmv2Uznanx1lFdBvXNR3GQjeahKLL/fkFuyxYNb4K2FUnZL7OMTZji
         KxSB7P0Gv6MqofGDzrwhz4cXHx3Tm1eQ41wsGqFLKjmT/kzyGbArhbzDn/uJURXBSavF
         vHfpAwCuDxTskcdVGXAOFEUPOhFkWW6iwKfv8VrVNXvlP7wZ1tL5xHR7YImP9Ps3WyeX
         4u9iVGGLv371lRBgesyykk9boiProvFGhlqwnoPJ+Yi8UREGF73W/y6dnky79ASIYnrN
         BFHfSEOQcEXhijeHv+WWHYkXXgnSyeI+Gqppmd/JjORj9G0GzMHHeavOjP9OlNL2Kugs
         GibA==
Received: by 10.68.203.195 with SMTP id ks3mr30694609pbc.79.1349443616675;
        Fri, 05 Oct 2012 06:26:56 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id op7sm270211pbc.52.2012.10.05.06.26.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 05 Oct 2012 06:26:55 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH V7 11/15] drm: Handle io prot correctly for MIPS
Date:   Fri,  5 Oct 2012 21:25:08 +0800
Message-Id: <1349443512-18340-12-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1349443512-18340-1-git-send-email-chenhc@lemote.com>
References: <1349443512-18340-1-git-send-email-chenhc@lemote.com>
X-archive-position: 34625
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Hongliang Tao <taohl@lemote.com>
Signed-off-by: Hua Yan <yanh@lemote.com>
Cc: dri-devel@lists.freedesktop.org
---
 drivers/gpu/drm/drm_vm.c          |    2 +-
 drivers/gpu/drm/ttm/ttm_bo_util.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

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
-- 
1.7.7.3
