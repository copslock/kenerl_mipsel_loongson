Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jun 2012 05:08:38 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:34181 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903701Ab2FVDGU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Jun 2012 05:06:20 +0200
Received: by mail-pz0-f49.google.com with SMTP id m1so1844262dad.36
        for <multiple recipients>; Thu, 21 Jun 2012 20:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=hPmFYMIfYw1sBWfuaBWY4ntQdhShoVbGNLw2OFGmkAE=;
        b=b3OGTNiGSKAOQ1CJlsu3dljRIuYEM1fx2a1Q72woWzVO0mMjDOpOcY6rk+bduBOhZ7
         lbW7tMb1851KLgZ4RmbHnI/J77zWAnRzB8A9VHPlShRxTp29nQtupiLmPaeT/Qh8QgVj
         hD009rfDO+OAZocDC+saBdkyC4vhyujyyc24DwUbNnhTDKmhL44ieyHakPXwFbo1Vd75
         nQJHYuZX59BoIEIqRcpO5JMQwpXYtYUesfvTvsuCVAAaIvn2E8ClaTQhuDu6/L2t6i8M
         l90A+aGy2B7TVhaKs2SMcTjESHHwT0JXbNZ/2fTaaUdL/76qncqklmG4l3cArv2n43wk
         lRTg==
Received: by 10.68.191.72 with SMTP id gw8mr4662939pbc.143.1340334379601;
        Thu, 21 Jun 2012 20:06:19 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id wk3sm37516519pbc.21.2012.06.21.20.06.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 21 Jun 2012 20:06:18 -0700 (PDT)
From:   Huacai Chen <chenhuacai@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>,
        stable@vger.kernel.org
Subject: [PATCH V3 15/16] MIPS: Fix poweroff failure when HOTPLUG_CPU configured.
Date:   Fri, 22 Jun 2012 11:01:12 +0800
Message-Id: <1340334073-17804-16-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1340334073-17804-1-git-send-email-chenhc@lemote.com>
References: <1340334073-17804-1-git-send-email-chenhc@lemote.com>
X-archive-position: 33772
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
Reviewed-by: Yong Zhang <yong.zhang@windriver.com>
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
