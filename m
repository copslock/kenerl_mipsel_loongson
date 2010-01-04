Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jan 2010 10:18:34 +0100 (CET)
Received: from mail-yw0-f182.google.com ([209.85.211.182]:60952 "EHLO
        mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492628Ab0ADJRj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Jan 2010 10:17:39 +0100
Received: by mail-yw0-f182.google.com with SMTP id 12so15942361ywh.21
        for <multiple recipients>; Mon, 04 Jan 2010 01:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=tEWdPpqSgDywKc7ivHG1U4Ss4J1ZoK3W1mj2ZYsnZ/k=;
        b=njxMZ+1R26+fiESW0JhZlY4x30yXvsM+ZePFUNpDbtKcv1tVWYDZLZUqWeZDKlpGIy
         9iHKdrd/8ESbnzxsnvJKsSQYrVZTEut0XQt0mfG5mxLgc6/w97kiCFBIPUzka9eZijdd
         I2KJ/EQkUKFv/blzXDCjDtEfEa0E5+eU5Knf0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=U98kx+FUM5NZ2oCwRjl3aUgyUTtnYGcPWKceOoYaiPsYLsFu+5gWiYmmyoCau9SiEI
         wK4JFZr6eDm4iW6WXfZ11nEvUFKsLmNd1X9zYk4jn7fUhhwMB14dqOTkmcxHo8e/lgfo
         J48DPWc7viLarNqgt8nH6OWmmbZgbM/Dm/SqQ=
Received: by 10.90.6.34 with SMTP id 34mr1860589agf.42.1262596657412;
        Mon, 04 Jan 2010 01:17:37 -0800 (PST)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id 21sm6122077ywh.16.2010.01.04.01.17.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 04 Jan 2010 01:17:36 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, yanh@lemote.com, huhb@lemote.com,
        zhangfx@lemote.com, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH 03/10] Loongson: Convert loongson_halt() to use unreachable()
Date:   Mon,  4 Jan 2010 17:16:45 +0800
Message-Id: <9bcc0f00c46fdf5c832ce3bdd0df8d7f08b7a1be.1262596493.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.5.6
In-Reply-To: <669ff2f39fd2aa3849e472438d3d9d499c8f0e3a.1262596493.git.wuzhangjin@gmail.com>
References: <cover.1262586650.git.wuzhangjin@gmail.com>
 <f4aeb125cb030f10d34966febfe9715874d52ab2.1262596493.git.wuzhangjin@gmail.com>
 <669ff2f39fd2aa3849e472438d3d9d499c8f0e3a.1262596493.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1262596493.git.wuzhangjin@gmail.com>
References: <cover.1262596493.git.wuzhangjin@gmail.com>
X-archive-position: 25501
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 2262

From: Wu Zhangjin <wuzhangjin@gmail.com>

Use the new unreachable() macro instead of while(1);

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/loongson/common/reset.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/mips/loongson/common/reset.c b/arch/mips/loongson/common/reset.c
index d57f171..5833f9f 100644
--- a/arch/mips/loongson/common/reset.c
+++ b/arch/mips/loongson/common/reset.c
@@ -6,7 +6,7 @@
  *
  * Copyright (C) 2007 Lemote, Inc. & Institute of Computing Technology
  * Author: Fuxin Zhang, zhangfx@lemote.com
- * Copyright (C) 2009 Lemote, Inc. & Institute of Computing Technology
+ * Copyright (C) 2009 Lemote, Inc.
  * Author: Zhangjin Wu, wuzj@lemote.com
  */
 #include <linux/init.h>
@@ -28,8 +28,7 @@ static void loongson_restart(char *command)
 static void loongson_halt(void)
 {
 	mach_prepare_shutdown();
-	while (1)
-		;
+	unreachable();
 }
 
 static int __init mips_reboot_setup(void)
-- 
1.6.5.6
