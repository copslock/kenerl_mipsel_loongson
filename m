Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 11 Aug 2012 11:38:38 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:32989 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903798Ab2HKJeC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 11 Aug 2012 11:34:02 +0200
Received: by mail-pb0-f49.google.com with SMTP id rq8so2856061pbb.36
        for <multiple recipients>; Sat, 11 Aug 2012 02:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=xSJOHiPbbkLH3jBzAos1o813tfIDkQ7exnZ6UUpcwTo=;
        b=ut/sRrDQ2wWwK4uLJaef+vuOQ6xWs1gFfvwzWjj0najqIQeCD2klQFPURQ3arFun1P
         65vDNnCof8JwuThb55y5ILpDY4oNW88Tumduw0DYbz9tDmiaQkkaKEmoMSiwZ00QGUdE
         2Zp+DYqSZBDrA9AS6ItxU20y6S7jTv2Qax6dlERTXA7aUyaV0CaBjE2IcLPQXfhkqbvv
         pCsnYucC3lKVcwD1q4Kt4r6fUgdJErh4C2UskTw1gSQh793aEkanRT/UQ6p8C8pH7TtY
         g/uj5omkTEvtqKIzh7BLKcEYrcNo9A/Li+j8WzCdJyPSX5s6XaQrE4SUMId8ZrYMIDFF
         u8QA==
Received: by 10.68.233.197 with SMTP id ty5mr19176524pbc.12.1344677641773;
        Sat, 11 Aug 2012 02:34:01 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id nu5sm1079954pbb.53.2012.08.11.02.33.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 11 Aug 2012 02:34:00 -0700 (PDT)
From:   Huacai Chen <chenhuacai@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH V5 13/18] drm: Define SAREA_MAX for Loongson (PageSize = 16KB).
Date:   Sat, 11 Aug 2012 17:32:18 +0800
Message-Id: <1344677543-22591-14-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1344677543-22591-1-git-send-email-chenhc@lemote.com>
References: <1344677543-22591-1-git-send-email-chenhc@lemote.com>
X-archive-position: 34106
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

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Hongliang Tao <taohl@lemote.com>
Signed-off-by: Hua Yan <yanh@lemote.com>
Cc: dri-devel@lists.freedesktop.org
---
 include/drm/drm_sarea.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

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
