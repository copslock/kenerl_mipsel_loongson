Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Oct 2009 16:18:40 +0100 (CET)
Received: from mail-qy0-f202.google.com ([209.85.221.202]:37988 "EHLO
	mail-qy0-f202.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493113AbZJZPPt (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 26 Oct 2009 16:15:49 +0100
Received: by qyk40 with SMTP id 40so1400531qyk.22
        for <multiple recipients>; Mon, 26 Oct 2009 08:15:43 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=5V6qC/UCQArhzNRD0PSxRjxW1Xci5btQmV+HopSM8Ow=;
        b=bFSCDRsxwFzCHsiP2J4LiS3e1bQKMjme0POoR04Gv1d37LZvEDPStf3bvhfExDd0yJ
         cdaQlv1FdmMM5ALvn5iZKGOokKGZQvhl/sLQLGHjNw43JtRYdxeVC+a6P1GH9sin39Y/
         EClZdkPXFYdr2cizyqkU303V1X56oaEK7TMXU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=FrXWXDGh/g1N+F0/7fxZ0+KajJ+ExinBA+ryBwPi2Wzb0xzKyIpI9vjT6IUPozpVnY
         blkKFRpNpTYlqIPYiBVpUOcf73caIkbULQo4gXRE3aEGJVN0cxtzaL1EMAt5Akl4mMfl
         UaesJpSpWJ8L+sQXaiBchBK+oxzE0BGqXalrg=
Received: by 10.224.66.136 with SMTP id n8mr7312476qai.328.1256570142963;
        Mon, 26 Oct 2009 08:15:42 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 21sm3876989qyk.0.2009.10.26.08.15.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 26 Oct 2009 08:15:41 -0700 (PDT)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc:	Wu Zhangjin <wuzhangjin@gmail.com>,
	Frederic Weisbecker <fweisbec@gmail.com>, rostedt@goodmis.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	Richard Sandiford <rdsandiford@googlemail.com>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	David Daney <ddaney@caviumnetworks.com>,
	Adam Nemet <anemet@caviumnetworks.com>,
	Patrik Kluba <kpajko79@gmail.com>
Subject: [PATCH -v6 10/13] tracing: not trace the timecounter_read* in kernel/time/clocksource.c
Date:	Mon, 26 Oct 2009 23:13:27 +0800
Message-Id: <4e022c090601c3585a8d69a54deade2a53f93e8c.1256569489.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <07e35715c3af78e3c4b537940277240ed031365a.1256569489.git.wuzhangjin@gmail.com>
References: <cover.1256569489.git.wuzhangjin@gmail.com>
 <747deea2f18d5ccffe842df95a9dd1c86251a958.1256569489.git.wuzhangjin@gmail.com>
 <3f47087b70a965fd679b17a59521671296457df1.1256569489.git.wuzhangjin@gmail.com>
 <f290e125634d164ec65b09b24b269815f78455ab.1256569489.git.wuzhangjin@gmail.com>
 <07dc907ec62353b1aca99b2850d3b2e4b734189a.1256569489.git.wuzhangjin@gmail.com>
 <374da7039d2e1b97083edd8bcd7811356884d427.1256569489.git.wuzhangjin@gmail.com>
 <3c82af564d70be05b92687949ed134ce034bf8db.1256569489.git.wuzhangjin@gmail.com>
 <a11775df0ec9665fab5861f4fa63a3e192b9ffec.1256569489.git.wuzhangjin@gmail.com>
 <f746f813531a16bd650f9290787c66cbc0cdc34d.1256569489.git.wuzhangjin@gmail.com>
 <07e35715c3af78e3c4b537940277240ed031365a.1256569489.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1256569489.git.wuzhangjin@gmail.com>
References: <cover.1256569489.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24518
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Some platforms(i.e. MIPS) need these two functions to get the precise
timestamp, we use __arch_notrace(added in the last patch) to annotate
it. By default, __arch_notrace is empty, so, this patch have no
influence to the original functions, but if you really not need to trace
them, just add the following line into the arch specific ftrace.h:

	#define __arch_notrace

If only want to enable it for function graph tracer, add these lines
instead.

	#ifdef CONFIG_FUNCTION_GRAPH_TRACER
	#define __arch_notrace
	#endif

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 kernel/time/clocksource.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 5e18c6a..91acdf7 100644
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
+static u64 __arch_notrace timecounter_read_delta(struct timecounter *tc)
 {
 	cycle_t cycle_now, cycle_delta;
 	u64 ns_offset;
@@ -72,7 +73,7 @@ static u64 timecounter_read_delta(struct timecounter *tc)
 	return ns_offset;
 }
 
-u64 timecounter_read(struct timecounter *tc)
+u64 __arch_notrace timecounter_read(struct timecounter *tc)
 {
 	u64 nsec;
 
-- 
1.6.2.1
