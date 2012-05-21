Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 May 2012 08:03:49 +0200 (CEST)
Received: from mail-wg0-f43.google.com ([74.125.82.43]:60427 "EHLO
        mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903551Ab2EUGCH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 21 May 2012 08:02:07 +0200
Received: by wgbdr1 with SMTP id dr1so3995385wgb.24
        for <multiple recipients>; Sun, 20 May 2012 23:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=2kNb8BdRoWiTq2Jmd2KUZXTlxF5zxMs+wKLYdsvSgt0=;
        b=DeMiFMVG9zINzOKHqVMtAsTb6vV908Xe0LHUNaN+/B+Ieayqc6IBQHSEhSTzChHE0k
         CzUnaEBOYwuhIpaXDxPMBXhQ44MxtANBwOeULI8JoJHEP4q4C0qb5/QQhAOuVE2GrlzB
         SCHdEQsss9KZixf6xX6DPUs+enqW2rMlmIHwWXGtaXHhCw09zU6aAAT2nWyHDXlJPx0d
         KENAY3f4upH6zt3HnDKzN7FiUh+pI965Nk9gV1CwXbc+7UlGgymxYfiuoZjWUrws603A
         lgC4YYayfjH3y3peX56MA5LG4G3/ni2RVACCLRv2f+MRkbMh0KsfSpgWug7gROEQz04/
         FOpw==
Received: by 10.180.107.101 with SMTP id hb5mr22127011wib.7.1337580122151;
        Sun, 20 May 2012 23:02:02 -0700 (PDT)
Received: from localhost ([61.148.56.138])
        by mx.google.com with ESMTPS id r2sm36665556wif.7.2012.05.20.23.01.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 20 May 2012 23:02:01 -0700 (PDT)
From:   Yong Zhang <yong.zhang0@gmail.com>
To:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc:     ralf@linux-mips.org, sshtylyov@mvista.com, david.daney@cavium.com
Subject: [PATCH 6/8] MIPS: call set_cpu_online() on the uping cpu with irq disabled
Date:   Mon, 21 May 2012 14:00:06 +0800
Message-Id: <1337580008-7280-7-git-send-email-yong.zhang0@gmail.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1337580008-7280-1-git-send-email-yong.zhang0@gmail.com>
References: <1337580008-7280-1-git-send-email-yong.zhang0@gmail.com>
X-archive-position: 33395
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yong.zhang0@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: Yong Zhang <yong.zhang@windriver.com>

To prevent a problem as commit 5fbd036b [sched: Cleanup cpu_active madness]
and commit 2baab4e9 [sched: Fix select_fallback_rq() vs cpu_active/cpu_online]
try to resolve, move set_cpu_online() to the brought up CPU and with irq
disabled.

Signed-off-by: Yong Zhang <yong.zhang0@gmail.com>
Acked-by: David Daney <david.daney@cavium.com>
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
1.7.5.4
