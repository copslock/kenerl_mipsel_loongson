Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 06 May 2012 00:23:30 +0200 (CEST)
Received: from mail-yx0-f177.google.com ([209.85.213.177]:62080 "EHLO
        mail-yx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903612Ab2EEWXU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 6 May 2012 00:23:20 +0200
Received: by yenr9 with SMTP id r9so1250858yen.36
        for <multiple recipients>; Sat, 05 May 2012 15:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=EFWEDx1FZ83DhuwolRn2h5RVIGoxnm9Tpt+aEad1lyE=;
        b=Togtd+XjQtLFsRanKEOvCN6aV6rkVYRVCBJyyvXU0aK+9RDXL2eSRb0BDPMkg9kfc0
         0iKxW8HDKitYGusoIz+27Rl6tlkgox+FoZvuIhBhvZImxBGn+YP7i7WzKUcEi9MjxrI4
         0dkttzB/Qa34ci7n0eu3Q4QvPji7DP/niAttAvUfRhC3PV0qJjJkoPWWuCIGu+VEnEtV
         GI7PT1Ai32zSKkjS++yHec2Sw34NKvJiMKBSO9qNj8VK75rlo42kMDg6QmnliLB3cY6f
         SDGn41QcDKPRaK5suD/oMCDzB4CW2QV2KzfyqOWLo3bsQnfE//7U1rM4VqBFmqhhZ2yU
         6DlQ==
Received: by 10.236.72.133 with SMTP id t5mr13265888yhd.94.1336256594569;
        Sat, 05 May 2012 15:23:14 -0700 (PDT)
Received: from localhost (cpe-174-109-057-184.nc.res.rr.com. [174.109.57.184])
        by mx.google.com with ESMTPS id 32sm20145032anu.14.2012.05.05.15.23.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 05 May 2012 15:23:13 -0700 (PDT)
From:   Matt Turner <mattst88@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Matt Turner <mattst88@gmail.com>
Subject: [PATCH] mips: include export.h in for EXPORT_SYMBOL in ops-loongson2.c
Date:   Sat,  5 May 2012 18:22:55 -0400
Message-Id: <1336256575-31038-1-git-send-email-mattst88@gmail.com>
X-Mailer: git-send-email 1.7.3.4
X-archive-position: 33163
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mattst88@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Fixes
warning: data definition has no type or storage class [enabled by default]
warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL' [-Wimplicit-int]
warning: parameter names (without types) in function declaration [enabled by default]

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 arch/mips/pci/ops-loongson2.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/mips/pci/ops-loongson2.c b/arch/mips/pci/ops-loongson2.c
index d657ee0..afd2211 100644
--- a/arch/mips/pci/ops-loongson2.c
+++ b/arch/mips/pci/ops-loongson2.c
@@ -15,6 +15,7 @@
 #include <linux/pci.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/export.h>
 
 #include <loongson.h>
 
-- 
1.7.3.4
