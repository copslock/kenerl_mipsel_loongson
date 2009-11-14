Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 14 Nov 2009 07:34:13 +0100 (CET)
Received: from mail-pz0-f197.google.com ([209.85.222.197]:61427 "EHLO
	mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492149AbZKNGeG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 14 Nov 2009 07:34:06 +0100
Received: by pzk35 with SMTP id 35so3098670pzk.22
        for <multiple recipients>; Fri, 13 Nov 2009 22:33:58 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=3Fy+eJ2xCuR6BPI2IHMjpMpvBUtIljzj6cszgvs8xbk=;
        b=EyZiI+uDvKEXSryFUbd/Llg2wT5UDPm3PS7WYznizKJv3azB/suZIA7eqyFXJlh6xj
         tEyindfd2aiRuD9w9o+OSrjkvaT/sP62VeEmj/lNJB1KuIgveonA7S6rijuQOhWoTnzD
         6UyLFeXMvgWsfIH/Ov4j+j42A+G0F0CUv+K5k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=FKe7LvinNdlpNKFznX2g0IIITpB7ih6jyNbT63AoZFMlqPNKmavSsVlAggy4kN1lcZ
         3BJHZ3ya3/e8XTRxlhi22SbjVMEQiiCG031qvB7moMoPzA0zMhoCdjj6XH/bteKHlZxl
         plx4hjdOZuIGR3piYj2yS8yrpgnFkcqHDG3/w=
Received: by 10.115.114.18 with SMTP id r18mr78624wam.24.1258180438110;
        Fri, 13 Nov 2009 22:33:58 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 20sm2668108pzk.5.2009.11.13.22.33.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 13 Nov 2009 22:33:57 -0800 (PST)
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
Subject: [PATCH v8 01/16] tracing: convert trace_clock_local() as weak function
Date:	Sat, 14 Nov 2009 14:33:16 +0800
Message-Id: <9dc81a7a9e5a292cccdf465c533a2b08d19d6021.1258177321.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <cover.1258177321.git.wuzhangjin@gmail.com>
References: <cover.1258177321.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24892
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

trace_clock_local() is based on the arch-specific sched_clock(), in X86,
it is tsc(64bit) based, which can give very high precision(about 1ns
with 1GHz). but in MIPS, the sched_clock() is jiffies based, which can
give only 10ms precison with 1000 HZ. which is not enough for tracing,
especially for Real Time system.

so, we need to implement a MIPS specific sched_clock() to get higher
precision. There is a tsc like clock counter register in MIPS, whose
frequency is half of the processor, so, if the cpu frequency is 800MHz,
the time precision reaches 2.5ns, which is very good for tracing, even
for Real Time system.

but 'Cause it is only 32bit long, which will rollover quickly, so, such
a sched_clock() will bring with extra load, which is not good for the
whole system. so, we only need to implement a arch-specific
trace_clock_local() for tracing. as a preparation, we convert it as a
weak function.

The MIPS specific trace_clock_local() is coming in the next two patches.

Acked-by: Frederic Weisbecker <fweisbec@gmail.com>
Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 kernel/trace/trace_clock.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/kernel/trace/trace_clock.c b/kernel/trace/trace_clock.c
index 20c5f92..06b8cd2 100644
--- a/kernel/trace/trace_clock.c
+++ b/kernel/trace/trace_clock.c
@@ -26,7 +26,7 @@
  * Useful for tracing that does not cross to other CPUs nor
  * does it go through idle events.
  */
-u64 notrace trace_clock_local(void)
+u64 __weak notrace trace_clock_local(void)
 {
 	unsigned long flags;
 	u64 clock;
-- 
1.6.2.1
