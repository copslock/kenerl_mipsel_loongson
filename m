Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 14 Nov 2009 07:38:02 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:41548 "EHLO
	mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492303AbZKNGfn (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 14 Nov 2009 07:35:43 +0100
Received: by pwi15 with SMTP id 15so2475092pwi.24
        for <multiple recipients>; Fri, 13 Nov 2009 22:35:36 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=8+Nu7P8DKU5SRxQDxNqZu9sLxVkns0R/McR5vqvzyIM=;
        b=PqJ+85KhNQqOUawO68q67WRCoMZFSb2FZiWNARLUyO8SDpFU3dAAW9t4aRJjxr1mSs
         JkWQYUmk4TR4jtnYSZprcW14bVEWu82RKJvRCVDahggoVbEAefb0gDGuq6Q7NZNzEHI0
         9sh9NzC0Y8RfmzMDZ4IRduT+Dnm/olT5jFP3E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=hCpIFz7WI4GvC49m3ouhmJxPRdcfd3j0oYlXn191x3CoTGtNB5uFAAEELGHJnzxkUE
         kH8EQEoKeDZ+VgkL7eRtCt4FRlwvKa7Ksm2CPFbpq5+ed9PJ2kfB4LMDhQIPil3apHBa
         dvjo5EfcVkl2WhZXlFvCiWTdoJFevSvMOn6xw=
Received: by 10.114.4.25 with SMTP id 25mr9153386wad.164.1258180536194;
        Fri, 13 Nov 2009 22:35:36 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 20sm2668108pzk.5.2009.11.13.22.35.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 13 Nov 2009 22:35:35 -0800 (PST)
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
Subject: [PATCH v8 10/16] tracing: not trace the timecounter_read* in kernel/time/clocksource.c
Date:	Sat, 14 Nov 2009 14:33:25 +0800
Message-Id: <f3a54cef2de00885ee75a930b243083a716370bd.1258177321.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <c1fe0d6822e98bc0ffd2dfee7a579fbbe21430e0.1258177321.git.wuzhangjin@gmail.com>
References: <9dc81a7a9e5a292cccdf465c533a2b08d19d6021.1258177321.git.wuzhangjin@gmail.com>
 <b99c08397d9ff92ac5a72bda9131df41b702fc71.1258177321.git.wuzhangjin@gmail.com>
 <8f579e2cece16cd22358a4ec143ef6a8c462639b.1258177321.git.wuzhangjin@gmail.com>
 <ea337742d3ca7eec2825416041a6d4fa917d5cc4.1258177321.git.wuzhangjin@gmail.com>
 <7c7568247ad6cc109ec20387cfc3ca258d1d430f.1258177321.git.wuzhangjin@gmail.com>
 <3fcaffcfb3c8c8cd3015151ed5b7480ccaecde0f.1258177321.git.wuzhangjin@gmail.com>
 <48676d84140dbafd46e530611766121e18abc4ef.1258177321.git.wuzhangjin@gmail.com>
 <99ebd8fcb19e4cccd702fca966405ffc45f8540b.1258177321.git.wuzhangjin@gmail.com>
 <c1fe0d6822e98bc0ffd2dfee7a579fbbe21430e0.1258177321.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1258177321.git.wuzhangjin@gmail.com>
References: <cover.1258177321.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24901
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

Some platforms(i.e. MIPS) need these two functions to get the precise
timestamp, we use __time_notrace(added in the last patch) to annotate
it. By default, __time_notrace is empty, so, this patch have no
influence to the original functions, but if you really not need to trace
them, just add the following line into the arch specific ftrace.h:

	#define __time_notrace notrace

If you only need it for function graph tracer, wrap it:

	#ifdef CONFIG_FUNCTION_GRAPH_TRACER
	 #define __time_notrace notrace
	#endif

please get more information from include/linux/ftrace.h

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 kernel/time/clocksource.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 5e18c6a..b00476a 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -30,6 +30,7 @@
 #include <linux/sched.h> /* for spin_unlock_irq() using preempt_count() m68k */
 #include <linux/tick.h>
 #include <linux/kthread.h>
+#include <linux/ftrace.h>
 
 void timecounter_init(struct timecounter *tc,
 		      const struct cyclecounter *cc,
@@ -52,7 +53,7 @@ EXPORT_SYMBOL(timecounter_init);
  * The first call to this function for a new time counter initializes
  * the time tracking and returns an undefined result.
  */
-static u64 timecounter_read_delta(struct timecounter *tc)
+static u64 __time_notrace timecounter_read_delta(struct timecounter *tc)
 {
 	cycle_t cycle_now, cycle_delta;
 	u64 ns_offset;
@@ -72,7 +73,7 @@ static u64 timecounter_read_delta(struct timecounter *tc)
 	return ns_offset;
 }
 
-u64 timecounter_read(struct timecounter *tc)
+u64 __time_notrace timecounter_read(struct timecounter *tc)
 {
 	u64 nsec;
 
-- 
1.6.2.1
