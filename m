Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Aug 2012 04:06:59 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:58529 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903677Ab2HMCGz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Aug 2012 04:06:55 +0200
Received: by pbbrq8 with SMTP id rq8so5447697pbb.36
        for <multiple recipients>; Sun, 12 Aug 2012 19:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=touXnpPMnjrF+CQYpVMhoadvTyXebhWC1iHAn0pSF9s=;
        b=It36fRriiRH4iCfHi+ABqpiWDhagbq2Fw+qcucitqpiyvGbju6Cgsie1UMo2pYNUDZ
         1pTUvpiKJdZODYJ1PRY2bmLtVdiRNL1Z5XlG2GN9dNkTCa3JbNwHfvywM+qnRSVm5RJx
         a9y/rqCZzj5MmYALUIIfzY1yvfewpHanWrdNZhHR2M6BqBy88ew9y365Xh5+2ws2LJhd
         NpcIt67/QOsMOEvSnbOVNjPKdj/L5yD3hSXHkXToAuhN6C80nO4AkmxTtOQkTJiufSST
         TA1UTQ+VLTEMU8JFjLJE0vZIHK59dRvv7eT1LxnowCcDN3/zUnqLNXwF429gpnb3tJiL
         Es4Q==
Received: by 10.68.219.65 with SMTP id pm1mr15819197pbc.121.1344823608496;
        Sun, 12 Aug 2012 19:06:48 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id gf7sm4337011pbc.65.2012.08.12.19.06.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 12 Aug 2012 19:06:47 -0700 (PDT)
From:   Huacai Chen <chenhuacai@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>,
        Yong Zhang <yong.zhang@windriver.com>, stable@vger.kernel.org
Subject: [PATCH] MIPS: Fix poweroff failure when HOTPLUG_CPU configured.
Date:   Mon, 13 Aug 2012 10:06:12 +0800
Message-Id: <1344823572-28461-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
X-archive-position: 34121
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
Cc: Yong Zhang <yong.zhang@windriver.com>
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
