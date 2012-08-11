Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 11 Aug 2012 11:40:17 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:32989 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903836Ab2HKJeX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 11 Aug 2012 11:34:23 +0200
Received: by mail-pb0-f49.google.com with SMTP id rq8so2856061pbb.36
        for <multiple recipients>; Sat, 11 Aug 2012 02:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=gi7q2TFBpO5Fo+No/pyrdu6Tne6S2cYh6BehiIcFeVY=;
        b=fSrd5SI08WiFOMGcb8AhNX/wyP1oLMo0QVaS1UtfPbtIxjiSjoDFc4n0UiMNiNWeqY
         Zv5ZhlAYfbWgZ5XoRo7jM/yLSj/+Z0gas1WFYWLQK7+BUC/l3JqAo+eK8fk3W50rK8jc
         9GxJqjx2pIjCJhfhuoZh7vlOrJdd+QHDbx/0y/QIE5iSRRa/GvGCKzP2at3CS26EtO4b
         sVkEqaJk9StJl72z/AfHhmusEcyg7gYyqe0gHPQQe/1Q3QxqLM8XpXN+Yocl+FxUfmPI
         mDPLzaGvABnTgl4UWn8j+Lur8IbU+9C3Ny4hZdswUg6LZQhRcYHTnz9ZW+bZTDnZby4O
         uhaw==
Received: by 10.68.195.197 with SMTP id ig5mr18924792pbc.137.1344677662132;
        Sat, 11 Aug 2012 02:34:22 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id nu5sm1079954pbb.53.2012.08.11.02.34.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 11 Aug 2012 02:34:21 -0700 (PDT)
From:   Huacai Chen <chenhuacai@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>,
        stable@vger.kernel.org
Subject: [PATCH V5 17/18] MIPS: Fix poweroff failure when HOTPLUG_CPU configured.
Date:   Sat, 11 Aug 2012 17:32:22 +0800
Message-Id: <1344677543-22591-18-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1344677543-22591-1-git-send-email-chenhc@lemote.com>
References: <1344677543-22591-1-git-send-email-chenhc@lemote.com>
X-archive-position: 34110
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
