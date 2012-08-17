Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Aug 2012 10:48:30 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:58706 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903438Ab2HQIos (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Aug 2012 10:44:48 +0200
Received: by mail-pb0-f49.google.com with SMTP id rq8so3158599pbb.36
        for <multiple recipients>; Fri, 17 Aug 2012 01:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=wwsN01bNbglem1+Oo67QbSeqXYqos3nHSsDd4RDmxkU=;
        b=KuOtx+Ww5OTO0pYbjv1pJaiG+M+pGBN6lAV5PRUXfTvDn7vwngxzwqgYrOggdZAWK/
         XgJAYmtN58YiV+fe2P33Rdb0zNaqprfQV9lY601JSMAZaknFO5cgBRPfoXuEcZpClVS6
         z1uAXwZJRFuiylOE6ZlfqRK++6U6fgY1tcrbKEoXsLmSDcNL7AIxM9vQ67Zswwws8xXK
         2BijvqeYsbVJdMDdneECmd9S0lGREmZOzrpep3Tmi7CdRSWEbKqOGCoS/AN2FO7ehVf2
         meNDNHq8LBtrbL7I8eTXX8TKwQuKDxmuKaOzf/MsZtuwfB8eYDy1ujcWESU5Lw0zIUrW
         QRHg==
Received: by 10.68.197.228 with SMTP id ix4mr10038316pbc.40.1345193087897;
        Fri, 17 Aug 2012 01:44:47 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id sz3sm4503572pbc.21.2012.08.17.01.44.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 17 Aug 2012 01:44:47 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH V6 11/15] drm: Handle io prot correctly for MIPS
Date:   Fri, 17 Aug 2012 16:43:31 +0800
Message-Id: <1345193015-3024-12-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1345193015-3024-1-git-send-email-chenhc@lemote.com>
References: <1345193015-3024-1-git-send-email-chenhc@lemote.com>
X-archive-position: 34245
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
