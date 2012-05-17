Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 May 2012 12:12:36 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:51296 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903632Ab2EQKLb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 May 2012 12:11:31 +0200
Received: by mail-pz0-f49.google.com with SMTP id m1so2524865dad.36
        for <multiple recipients>; Thu, 17 May 2012 03:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=xqY0MV5RGS8aeyjQ/6Qo9Jd7BcVSjwMgTeE6MhKWfdk=;
        b=XzoY/Q3z/rX5xFA0ZQ/x3NNFh1dKX1Mtl4xH13R30S+HVwqHRrdHer+zRKqQdpL1zz
         d4AJSbK2g0gdxyjqNjRzvRqJGugmvvjm4AdAarRajzyXbXj50FGtSzFsiqZ2Pdmo0vsR
         L3rcP5IccnbyRvP0MCGlAnKfMmecTArMigD6R7wvH+NeOTQ2j7uaf16DtMYFXzUfR/aI
         +Zcm+u7ArcWfvaZC4qC3lrd/7pKia0wTbSlxVSia+GJkot7QQBuq2/V6ToNEyGiEgxF+
         aisejLpOb5rVhL65Jp5WnxZ9aGNzJg4eTPRdksOz5Ew2PvAYRrIuVD1NSBGCvMTynYrB
         gtYQ==
Received: by 10.68.136.165 with SMTP id qb5mr7078026pbb.150.1337249490236;
        Thu, 17 May 2012 03:11:30 -0700 (PDT)
Received: from localhost ([221.223.131.58])
        by mx.google.com with ESMTPS id ve6sm8630300pbc.75.2012.05.17.03.11.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 17 May 2012 03:11:29 -0700 (PDT)
From:   Yong Zhang <yong.zhang0@gmail.com>
To:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc:     ralf@linux-mips.org, david.daney@cavium.com
Subject: [PATCH 5/8] MIPS: call ->smp_finish() a little late
Date:   Thu, 17 May 2012 18:10:07 +0800
Message-Id: <1337249410-7162-6-git-send-email-yong.zhang0@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1337249410-7162-1-git-send-email-yong.zhang0@gmail.com>
References: <1337249410-7162-1-git-send-email-yong.zhang0@gmail.com>
X-archive-position: 33346
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yong.zhang0@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: Yong Zhang <yong.zhang@windriver.com>

We have move irq enable to ->smp_finish. Place ->smp_finish() a little
late to prepare for move set_cpu_online() into start_secondary.
And it's not necessary to call cpu_set(cpu, cpu_callin_map) and
synchronise_count_slave() with irq enabled.

Signed-off-by: Yong Zhang <yong.zhang0@gmail.com>
---
 arch/mips/kernel/smp.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index ba9376b..73a268a 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -122,13 +122,14 @@ asmlinkage __cpuinit void start_secondary(void)
 
 	notify_cpu_starting(cpu);
 
-	mp_ops->smp_finish();
 	set_cpu_sibling_map(cpu);
 
 	cpu_set(cpu, cpu_callin_map);
 
 	synchronise_count_slave();
 
+	mp_ops->smp_finish();
+
 	cpu_idle();
 }
 
-- 
1.7.1
