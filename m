Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Mar 2010 17:34:11 +0100 (CET)
Received: from mail-fx0-f227.google.com ([209.85.220.227]:34863 "EHLO
        mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491194Ab0CIQeG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Mar 2010 17:34:06 +0100
Received: by fxm27 with SMTP id 27so2968813fxm.28
        for <multiple recipients>; Tue, 09 Mar 2010 08:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=rYOHgFXmHgPDw/W+yk0UbExd6NQrL5qkhiDnUvuwqjk=;
        b=XPjgWVMPU4FYt4zHHTKf4LliGPz6OZmz6LJhKwXmoA/zzNjGMVQIdQx/mOmKyQzPjo
         4gQ9Ig26bAcWkn0/flErUUP2gMMNuP1K/LRAi/IAxxblIzZRViqJbsZTT6AAn3HZRtta
         /oYnuQqiRuu0vmm97BuDNlf+dZqPHEmhA2xJQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=IE4stG8S8mG1QzR+ANhUaCZE091yVZB4bxJcsGrCCEjm01gniZi0gsvfaAF9gwFFPY
         NqmCysQzrmXlyyGi3WvHHkOFpsrG+f0YMfD5x+P4Hd8q7B5pxigJDqMIKNoNQu/vnIzV
         jRMfG7xLfSAcGXu8viu/FxL0KRNpJyo0vBKpg=
Received: by 10.223.77.85 with SMTP id f21mr29236fak.40.1268152441443;
        Tue, 09 Mar 2010 08:34:01 -0800 (PST)
Received: from localhost.localdomain ([202.201.12.142])
        by mx.google.com with ESMTPS id p9sm11297164fkb.33.2010.03.09.08.33.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Mar 2010 08:34:00 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Steven Rostedt <rostedt@goodmis.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH] MIPS: Don't trace irqsoff for idle
Date:   Wed, 10 Mar 2010 00:27:28 +0800
Message-Id: <1268152048-30522-1-git-send-email-wuzhangin@gmail.com>
X-Mailer: git-send-email 1.7.0.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26156
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

As the X86 platform did in arch/x86/kernel/{process_32.c,process_64.c},
   we also don't trace irqsoff for idle.

If "There's no useful work to be done", we don't care about the irqsoff
duration. If we trace for idle, the max duration of irqsoff will be
always the idle time and eventually make the irqsoff tracer out of
action.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/kernel/process.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index f3d73e1..87d19dd 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -64,8 +64,13 @@ void __noreturn cpu_idle(void)
 
 			smtc_idle_loop_hook();
 #endif
-			if (cpu_wait)
+
+			if (cpu_wait) {
+				/* Don't trace irqs off for idle */
+				stop_critical_timings();
 				(*cpu_wait)();
+				start_critical_timings();
+			}
 		}
 #ifdef CONFIG_HOTPLUG_CPU
 		if (!cpu_online(cpu) && !cpu_isset(cpu, cpu_callin_map) &&
-- 
1.7.0.1
