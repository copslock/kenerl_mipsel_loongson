Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Oct 2009 16:35:27 +0200 (CEST)
Received: from mail-fx0-f225.google.com ([209.85.220.225]:36649 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492348AbZJUOfV (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 21 Oct 2009 16:35:21 +0200
Received: by fxm25 with SMTP id 25so8067248fxm.0
        for <multiple recipients>; Wed, 21 Oct 2009 07:35:15 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=LT3AYB6XkTxNpHG8Gw+zUOC4kOO94rjbGYbttyFN5kg=;
        b=odK0JLJ8OMlJp08ccFV58biToAkBsVSanctIeV992wdcX3aSG6lm+LWMxnLNNYr6tc
         w5wf1O+nhTJt6JKG+k9xImkpmc+RUkTOhdLgxC9jGJNvgozRd6d5SwIbCR9F2bIQvzwA
         qMN5+fbe5d8mOJmzJ7hrTkpW+bfOSJXQgwxDk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=f+u9j+rG8W/in3qIeV74JaH/8S0pv58xuL3yrWZpcOUDIt8nSKvXhk2F8SGWBAmcq5
         goJQnCBf6I0Lb+kI+A1CSqpsgKdH8yb61FvVoPH80XwjCn65SRfxHUxdOvrqQs6v5gqS
         66N0poDkrTCYPFzfyyrUBlm5Ks4Tldbl0wBPM=
Received: by 10.204.160.143 with SMTP id n15mr8013870bkx.183.1256135715301;
        Wed, 21 Oct 2009 07:35:15 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 1sm303459fkt.11.2009.10.21.07.35.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 21 Oct 2009 07:35:14 -0700 (PDT)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Cc:	Wu Zhangjin <wuzhangjin@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH -v4 1/9] tracing: convert trace_clock_local() as weak function
Date:	Wed, 21 Oct 2009 22:34:55 +0800
Message-Id: <028867b99ec532b84963a35e7d552becc783cafc.1256135456.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <cover.1256135456.git.wuzhangjin@gmail.com>
References: <cover.1256135456.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24404
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

The MIPS specific trace_clock_local() is coming in the next two patches.

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
