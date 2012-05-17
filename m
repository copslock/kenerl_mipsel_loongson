Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 May 2012 12:13:01 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:51296 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903643Ab2EQKLp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 May 2012 12:11:45 +0200
Received: by mail-pz0-f49.google.com with SMTP id m1so2524865dad.36
        for <multiple recipients>; Thu, 17 May 2012 03:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=BQf4ybewMkzmNx26qm3Yec9qvjYA2RxBqt0xuEXJy/4=;
        b=WfAzxP5cz9CxCiUJnoR7QrEWaL6oUC9uh+OR4puvhGtFubQpD0iMogOltvOfye/PnC
         q6AXuYwqIkmEekiwhBMNma5G6uvBnpKPjDfwCr2nxVYJcK1IHoK+BM8puGrC5ftBBlQH
         13RUpc++RPpzr6UJUfJRyFY/HRC+60s+C2XjY00aQN1QELfppJURw/Eq2bH7E0oQmFBO
         PCTZfM9mDrVwxMp0tZ2qwhvY64XeCq+AKr6pve/vI1zBDbId5Zpp0aMeIc81ZvKwGoQN
         r6OsGcHp36M+j3xUw4WmwPdUiBSwRj5E6sb7b+YA5xKZDcRw4935VUY0r9Eq8uJWO0sa
         drKA==
Received: by 10.68.197.99 with SMTP id it3mr6362598pbc.148.1337249504739;
        Thu, 17 May 2012 03:11:44 -0700 (PDT)
Received: from localhost ([221.223.131.58])
        by mx.google.com with ESMTPS id nd6sm8640058pbc.63.2012.05.17.03.11.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 17 May 2012 03:11:43 -0700 (PDT)
From:   Yong Zhang <yong.zhang0@gmail.com>
To:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc:     ralf@linux-mips.org, david.daney@cavium.com
Subject: [PATCH 6/8] MIPS: call set_cpu_online() on the uping cpu with irq disabled
Date:   Thu, 17 May 2012 18:10:08 +0800
Message-Id: <1337249410-7162-7-git-send-email-yong.zhang0@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1337249410-7162-1-git-send-email-yong.zhang0@gmail.com>
References: <1337249410-7162-1-git-send-email-yong.zhang0@gmail.com>
X-archive-position: 33347
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yong.zhang0@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: Yong Zhang <yong.zhang@windriver.com>

To prevent a problem as commit 5fbd036b && 2baab4e9 try to resolve,
move set_cpu_online() to the uping CPU and with irq disabled.

Signed-off-by: Yong Zhang <yong.zhang0@gmail.com>
---
 arch/mips/kernel/smp.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index 73a268a..042145f 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -122,6 +122,8 @@ asmlinkage __cpuinit void start_secondary(void)
 
 	notify_cpu_starting(cpu);
 
+	set_cpu_online(cpu, true);
+
 	set_cpu_sibling_map(cpu);
 
 	cpu_set(cpu, cpu_callin_map);
@@ -249,8 +251,6 @@ int __cpuinit __cpu_up(unsigned int cpu)
 	while (!cpu_isset(cpu, cpu_callin_map))
 		udelay(100);
 
-	set_cpu_online(cpu, true);
-
 	return 0;
 }
 
-- 
1.7.1
