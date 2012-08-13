Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Aug 2012 14:52:52 +0200 (CEST)
Received: from mail-yw0-f49.google.com ([209.85.213.49]:35220 "EHLO
        mail-yw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903503Ab2HMMwq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Aug 2012 14:52:46 +0200
Received: by yhjj52 with SMTP id j52so3289135yhj.36
        for <multiple recipients>; Mon, 13 Aug 2012 05:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=u8qlQZkE+zi4TzdsFk+tC2JNmiYcsC/3mAysIxourfQ=;
        b=R6eOwYhcx7Vj71LplcsCiINfPdIhptgAlJmRL+wBYpag4FJM2ODhP9wP7+gLoCbJEK
         lQLbnnTMe7bhKUyiUWN2OuthkRNcatkTgB/nGx2a4AQtYB461oOikh02F6vHKIuytunJ
         trfK2rlO23LzXdcOqst+Vw+64kymGYpYuuGS7aDowcZ940adUVoMxirWv6k7dG6xSeOy
         SY6QwAwcfV5GNIj+oqHDK8QTGV98PHGXxFG1CeOtS+6ivqYkEK7DvGaCvu6DlI6AJNzK
         55BfG41bCvc0YY+pjtxF3zPOFzc/VTE7DNhP9iAO4+VhU2qgD3zSt7ZtlkCbAdc82B8Z
         ORLA==
Received: by 10.66.77.168 with SMTP id t8mr17388789paw.28.1344862360263;
        Mon, 13 Aug 2012 05:52:40 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id pn4sm5290599pbb.50.2012.08.13.05.52.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 13 Aug 2012 05:52:39 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>,
        Yong Zhang <yong.zhang@windriver.com>, stable@vger.kernel.org
Subject: [PATCH V2] MIPS: Fix poweroff failure when HOTPLUG_CPU configured.
Date:   Mon, 13 Aug 2012 20:52:24 +0800
Message-Id: <1344862344-27434-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
X-archive-position: 34126
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

When poweroff machine, kernel_power_off() call disable_nonboot_cpus().
And if we have HOTPLUG_CPU configured, disable_nonboot_cpus() is not an
empty function but attempt to actually disable the nonboot cpus. Since
system state is SYSTEM_POWER_OFF, play_dead() won't be called and thus
disable_nonboot_cpus() hangs. Therefore, we make this patch to avoid
poweroff failure.

V2:
Make the From: address the same as Signed-off-by address.

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
