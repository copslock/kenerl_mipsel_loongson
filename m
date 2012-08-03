Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Aug 2012 09:12:48 +0200 (CEST)
Received: from mail-yw0-f49.google.com ([209.85.213.49]:43118 "EHLO
        mail-yw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903773Ab2HCHHu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 3 Aug 2012 09:07:50 +0200
Received: by mail-yw0-f49.google.com with SMTP id j52so497944yhj.36
        for <multiple recipients>; Fri, 03 Aug 2012 00:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=gi7q2TFBpO5Fo+No/pyrdu6Tne6S2cYh6BehiIcFeVY=;
        b=u0lYz9nLXAxYVlwlI1lAlTQ89359c3QXBH9M4OcLDlqw3VoUOO787cMgjStrq7+51o
         531o4gnLM67U6WOmXM4eTCy3WcJ1L3VwBwjyxaiynQMNPfXvPvbBp9jm5i+jvB1PDpfF
         TLRKDjWXlid0vDs5rGophtiidoDyZRb4c9/meCGXGhvbNz4Sqv1jksSNIxALRWMzNN5n
         FWZ5Wu6KbCN/l1JwUqLdiIqg603qXlp0bO4PRLnUbBdxUt/5bT2BNNSg02KOiScBAT64
         BJSE6GZ4AtlPuM2mPc/mmqVRbMXpm/L0U4RVNaH6y2KyWd0yO5YOihzxtX2jQ3SY7so4
         hTFA==
Received: by 10.50.194.132 with SMTP id hw4mr1434663igc.63.1343977669141;
        Fri, 03 Aug 2012 00:07:49 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id z3sm20852677igc.7.2012.08.03.00.07.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 03 Aug 2012 00:07:48 -0700 (PDT)
From:   Huacai Chen <chenhuacai@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>,
        stable@vger.kernel.org
Subject: [PATCH V4 15/16] MIPS: Fix poweroff failure when HOTPLUG_CPU configured.
Date:   Fri,  3 Aug 2012 15:06:10 +0800
Message-Id: <1343977571-2292-16-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1343977571-2292-1-git-send-email-chenhc@lemote.com>
References: <1343977571-2292-1-git-send-email-chenhc@lemote.com>
X-archive-position: 34039
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

When poweroff machine, kernel_power_off() call disable_nonboot_cpus().
And if we have HOTPLUG_CPU configured, disable_nonboot_cpus() is not an
empty function but attempt to actually disable the nonboot cpus. Since
system state is SYSTEM_POWER_OFF, play_dead() won't be called and thus
disable_nonboot_cpus() hangs. Therefore, we make this patch to avoid
poweroff failure.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Hongliang Tao <taohl@lemote.com>
Signed-off-by: Hua Yan <yanh@lemote.com>
Cc: stable@vger.kernel.org
---
 arch/mips/kernel/process.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index e9a5fd7..69b17a9 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -72,9 +72,7 @@ void __noreturn cpu_idle(void)
 			}
 		}
 #ifdef CONFIG_HOTPLUG_CPU
-		if (!cpu_online(cpu) && !cpu_isset(cpu, cpu_callin_map) &&
-		    (system_state == SYSTEM_RUNNING ||
-		     system_state == SYSTEM_BOOTING))
+		if (!cpu_online(cpu) && !cpu_isset(cpu, cpu_callin_map))
 			play_dead();
 #endif
 		rcu_idle_exit();
-- 
1.7.7.3
