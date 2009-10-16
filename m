Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Oct 2009 13:38:54 +0200 (CEST)
Received: from mail-pz0-f194.google.com ([209.85.222.194]:42621 "EHLO
	mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493588AbZJPLir (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 16 Oct 2009 13:38:47 +0200
Received: by pzk32 with SMTP id 32so2037555pzk.21
        for <multiple recipients>; Fri, 16 Oct 2009 04:38:39 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=IlDKtp0qWL6jn+JcvdkEIHu8PFwWmThMcXB/9t1cWX0=;
        b=m2BNobI48l7X/vE3HvXZ7SNTcTtfoRvBKEIU7Tk/nmXXRGcWiKICBtBWHEEo9rx61Y
         fX/xAtcrr5sSIlJsnftM/BbxfC8RJmEx43NF4CNTMUnkqLJiAXejgPfRrp0HliEnFbFH
         h4vxRzimgNtrIv4+hrTqDBI1L62IEwj3aKHaM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=BDT8mK4bOnvB+QbLgtuEnq8/qgU/J2zhRdblv7+6nPfefN9hRH4KImeOp/ucA26lFk
         iC96s/2xNAbatELeUQIN3r/Yjp12+lQb3C+mGRv7BhZK9+DzIlfPpVdmwM+8yn6rsrvZ
         uBQQ9Yt8NUSYsjgkshcuEYzl8i/DsmTV96s3I=
Received: by 10.114.2.29 with SMTP id 29mr1494882wab.48.1255693119774;
        Fri, 16 Oct 2009 04:38:39 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 21sm810497pzk.11.2009.10.16.04.38.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 16 Oct 2009 04:38:39 -0700 (PDT)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	linux-kernel@vger.kernel.org,
	linux-mips <linux-mips@linux-mips.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@elte.hu>,
	Manuel Lauss <manuel.lauss@googlemail.com>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH 1/2] tracing: convert trace_clock_local() as weak function
Date:	Fri, 16 Oct 2009 19:38:24 +0800
Message-Id: <4205779ae74d7c4144ee6cbf4e3f15f833646356.1255692619.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24364
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

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

The MIPS specific trace_clock_local() is coming in the next patch.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 kernel/trace/trace_clock.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/kernel/trace/trace_clock.c b/kernel/trace/trace_clock.c
index 20c5f92..a04dc18 100644
--- a/kernel/trace/trace_clock.c
+++ b/kernel/trace/trace_clock.c
@@ -26,7 +26,7 @@
  * Useful for tracing that does not cross to other CPUs nor
  * does it go through idle events.
  */
-u64 notrace trace_clock_local(void)
+u64 __attribute__((weak)) notrace trace_clock_local(void)
 {
 	unsigned long flags;
 	u64 clock;
-- 
1.6.2.1
