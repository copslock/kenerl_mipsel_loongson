Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 14 Nov 2009 07:38:26 +0100 (CET)
Received: from mail-px0-f173.google.com ([209.85.216.173]:61701 "EHLO
	mail-px0-f173.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492180AbZKNGfv (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 14 Nov 2009 07:35:51 +0100
Received: by pxi3 with SMTP id 3so2941645pxi.22
        for <multiple recipients>; Fri, 13 Nov 2009 22:35:44 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=0Op6X47jKOjXHcflG9C2/0WNQSAyjqOLYMRClxcAk94=;
        b=wN3gTUEN/U2q6Vif0SCFZAKK3GkeRzkaEdkvA1eJECkyWSii9XKxXPKHCC/xJ70ohx
         0mJWhg7KG+iz4oN3JkxXZcbMWyB6tRcaQCMgFPNk13dyvC9D62mUAKjN7zW0SnlbtA91
         O81/FNmdRX2/s8ndNhTKChD4QaGHGlau+qB/s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=YIkwdED7ewVF/vfP1SLIUxCpvysNElpSfUx5CiZgkoE1MP8NOyoP4pvhr7N+Em7N5+
         zRzlqrr3xELCeyomrrgEzaUZuZRljzw8AmKi/12GQpFzFRVr3lYpvT3KFAUSQum0y+la
         c0GlVRG10vtky0jpljNzGR6R2h7oXASE5YdXg=
Received: by 10.115.112.40 with SMTP id p40mr9112890wam.182.1258180544561;
        Fri, 13 Nov 2009 22:35:44 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 20sm2668108pzk.5.2009.11.13.22.35.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 13 Nov 2009 22:35:44 -0800 (PST)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	rostedt@goodmis.org, Ralf Baechle <ralf@linux-mips.org>
Cc:	Wu Zhangjin <wuzhangjin@gmail.com>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Ingo Molnar <mingo@elte.hu>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	David Daney <ddaney@caviumnetworks.com>,
	Richard Sandiford <rdsandiford@googlemail.com>,
	Patrik Kluba <kpajko79@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Michal Simek <monstr@monstr.eu>,
	"Maciej W . Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	zhangfx@lemote.com, zhouqg@gmail.com
Subject: [PATCH v8 11/16] tracing: not trace mips_timecounter_read() for MIPS
Date:	Sat, 14 Nov 2009 14:33:26 +0800
Message-Id: <b98ca1b2048aeab8aac82ec8723ac729c2cd4b54.1258177321.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <f3a54cef2de00885ee75a930b243083a716370bd.1258177321.git.wuzhangjin@gmail.com>
References: <9dc81a7a9e5a292cccdf465c533a2b08d19d6021.1258177321.git.wuzhangjin@gmail.com>
 <b99c08397d9ff92ac5a72bda9131df41b702fc71.1258177321.git.wuzhangjin@gmail.com>
 <8f579e2cece16cd22358a4ec143ef6a8c462639b.1258177321.git.wuzhangjin@gmail.com>
 <ea337742d3ca7eec2825416041a6d4fa917d5cc4.1258177321.git.wuzhangjin@gmail.com>
 <7c7568247ad6cc109ec20387cfc3ca258d1d430f.1258177321.git.wuzhangjin@gmail.com>
 <3fcaffcfb3c8c8cd3015151ed5b7480ccaecde0f.1258177321.git.wuzhangjin@gmail.com>
 <48676d84140dbafd46e530611766121e18abc4ef.1258177321.git.wuzhangjin@gmail.com>
 <99ebd8fcb19e4cccd702fca966405ffc45f8540b.1258177321.git.wuzhangjin@gmail.com>
 <c1fe0d6822e98bc0ffd2dfee7a579fbbe21430e0.1258177321.git.wuzhangjin@gmail.com>
 <f3a54cef2de00885ee75a930b243083a716370bd.1258177321.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1258177321.git.wuzhangjin@gmail.com>
References: <cover.1258177321.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24902
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

We use mips_timecounter_read() to get the timestamp in MIPS, so, it's
better to not trace it and it's subroutines, otherwise, it will goto
recursion(hang) when using function graph tracer. we use the
__notrace_funcgraph annotation to indicate them not to be traced.

And there are two common functions called by mips_timecounter_read(), we
define the __time_notrace macro to ensure they are not to be traced
either.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/include/asm/ftrace.h |    6 ++++++
 arch/mips/kernel/csrc-r4k.c    |    5 +++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/ftrace.h b/arch/mips/include/asm/ftrace.h
index 7094a40..aa7c80b 100644
--- a/arch/mips/include/asm/ftrace.h
+++ b/arch/mips/include/asm/ftrace.h
@@ -28,6 +28,12 @@ static inline unsigned long ftrace_call_adjust(unsigned long addr)
 struct dyn_arch_ftrace {
 };
 #endif /*  CONFIG_DYNAMIC_FTRACE */
+
+/* not trace the timecounter_read* in kernel/time/clocksource.c */
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+ #define __time_notrace notrace
+#endif
+
 #endif /* __ASSEMBLY__ */
 #endif /* CONFIG_FUNCTION_TRACER */
 #endif /* _ASM_MIPS_FTRACE_H */
diff --git a/arch/mips/kernel/csrc-r4k.c b/arch/mips/kernel/csrc-r4k.c
index 4e7705f..0c1bf80 100644
--- a/arch/mips/kernel/csrc-r4k.c
+++ b/arch/mips/kernel/csrc-r4k.c
@@ -8,6 +8,7 @@
 #include <linux/clocksource.h>
 #include <linux/init.h>
 #include <linux/sched.h>
+#include <linux/ftrace.h>
 
 #include <asm/time.h>
 
@@ -42,7 +43,7 @@ static struct timecounter r4k_tc = {
 	.cc = NULL,
 };
 
-static cycle_t r4k_cc_read(const struct cyclecounter *cc)
+static cycle_t __notrace_funcgraph r4k_cc_read(const struct cyclecounter *cc)
 {
 	return read_c0_count();
 }
@@ -66,7 +67,7 @@ int __init init_r4k_timecounter(void)
 	return 0;
 }
 
-u64 r4k_timecounter_read(void)
+u64 __notrace_funcgraph r4k_timecounter_read(void)
 {
 	u64 clock;
 
-- 
1.6.2.1
