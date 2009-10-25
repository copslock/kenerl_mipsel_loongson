Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 Oct 2009 16:20:51 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:45028 "EHLO
	mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492471AbZJYPSS (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 25 Oct 2009 16:18:18 +0100
Received: by mail-pw0-f45.google.com with SMTP id 11so939668pwi.24
        for <multiple recipients>; Sun, 25 Oct 2009 08:18:17 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=0jNVTZNALtsIxeoXhb1EHrV4ZkmTphwnE288Xbw5DDE=;
        b=BPUxy6zq/vQhle7z/K3+x7ypBjbW4GEsBiALGFG51H4JG5JjkMROGneZpwtRDDUdIe
         +U7lXSwQSgNF0J8ZHFtYMufhs0kAam/NBevCvifjKEHcREGIATmhT9RB0HsHvGPIqnof
         4PaICXLRzg3AJMGF6oxIPBO28xd/BIHjRLdqA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=bpmddossNrOj77TAAFlGveuUHExkzNRVnh6j6LfwtNnCTVLnAHvONZxTXLsiFxmOai
         Zot0rJGIrNVZj9N8d0KLgBzzWuZlex8An81+axxAa1Bc22dpMFMsxvZPLLHWcQc6vnET
         ii5DP/0LECIpm5eFrrGhpOnUvsrHBFQyiJu6Y=
Received: by 10.115.117.4 with SMTP id u4mr20545835wam.43.1256483897533;
        Sun, 25 Oct 2009 08:18:17 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 22sm1742515pxi.14.2009.10.25.08.18.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 25 Oct 2009 08:18:16 -0700 (PDT)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc:	Wu Zhangjin <wuzhangjin@gmail.com>, rostedt@goodmis.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	Richard Sandiford <rdsandiford@googlemail.com>,
	David Daney <ddaney@caviumnetworks.com>,
	Adam Nemet <anemet@caviumnetworks.com>,
	Patrik Kluba <kpajko79@gmail.com>
Subject: [PATCH -v5 08/11] tracing: not trace mips_timecounter_init() in MIPS
Date:	Sun, 25 Oct 2009 23:16:59 +0800
Message-Id: <49b3c441a57f4db423732f81432a3450ccb3240e.1256483735.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <6140dd8f4e1783e5ac30977cf008bb98e4698322.1256483735.git.wuzhangjin@gmail.com>
References: <cover.1256482555.git.wuzhangjin@gmail.com>
 <028867b99ec532b84963a35e7d552becc783cafc.1256483735.git.wuzhangjin@gmail.com>
 <2f73eae542c47ac5bbb9f7280e6c0271d193e90d.1256483735.git.wuzhangjin@gmail.com>
 <3e0c2d7d8b8f196a8153beb41ea7f3cbf42b3d84.1256483735.git.wuzhangjin@gmail.com>
 <54c417629e91f40b2bbb4e08cda2a4e6527824c0.1256483735.git.wuzhangjin@gmail.com>
 <29bccff04932e993ecd9f516d8b6dcf84e2ceecf.1256483735.git.wuzhangjin@gmail.com>
 <72f2270f7b6e01ca7a4cdf4ac8c21778e5d9652f.1256483735.git.wuzhangjin@gmail.com>
 <6140dd8f4e1783e5ac30977cf008bb98e4698322.1256483735.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1256483735.git.wuzhangjin@gmail.com>
References: <cover.1256483735.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24491
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

We use mips_timecounter_init() to get the timestamp in MIPS, so, it's
better to not trace it, otherwise, it will goto recursion(hang) when
using function graph tracer.

but this patch have touched the common part in kernel/time/clocksource.c
and include/linux/clocksource.h, so it is not good, perhaps the better
solution is moving the whole mips_timecounter_init() implementation into
arch/mips, but that will introduce source code duplication. any other
solution?

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/include/asm/time.h |    2 +-
 arch/mips/kernel/csrc-r4k.c  |    4 ++--
 include/linux/clocksource.h  |    2 +-
 kernel/time/clocksource.c    |    4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/mips/include/asm/time.h b/arch/mips/include/asm/time.h
index b8af7fa..e1c660f 100644
--- a/arch/mips/include/asm/time.h
+++ b/arch/mips/include/asm/time.h
@@ -77,7 +77,7 @@ extern int init_r4k_timecounter(void);
 extern u64 r4k_timecounter_read(void);
 #endif
 
-static inline u64 mips_timecounter_read(void)
+static inline u64 notrace mips_timecounter_read(void)
 {
 #ifdef CONFIG_CSRC_R4K
 	return r4k_timecounter_read();
diff --git a/arch/mips/kernel/csrc-r4k.c b/arch/mips/kernel/csrc-r4k.c
index 4e7705f..0690bea 100644
--- a/arch/mips/kernel/csrc-r4k.c
+++ b/arch/mips/kernel/csrc-r4k.c
@@ -42,7 +42,7 @@ static struct timecounter r4k_tc = {
 	.cc = NULL,
 };
 
-static cycle_t r4k_cc_read(const struct cyclecounter *cc)
+static cycle_t notrace r4k_cc_read(const struct cyclecounter *cc)
 {
 	return read_c0_count();
 }
@@ -66,7 +66,7 @@ int __init init_r4k_timecounter(void)
 	return 0;
 }
 
-u64 r4k_timecounter_read(void)
+u64 notrace r4k_timecounter_read(void)
 {
 	u64 clock;
 
diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index 83d2fbd..2a02992 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -73,7 +73,7 @@ struct timecounter {
  * XXX - This could use some mult_lxl_ll() asm optimization. Same code
  * as in cyc2ns, but with unsigned result.
  */
-static inline u64 cyclecounter_cyc2ns(const struct cyclecounter *cc,
+static inline u64 notrace cyclecounter_cyc2ns(const struct cyclecounter *cc,
 				      cycle_t cycles)
 {
 	u64 ret = (u64)cycles;
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 5e18c6a..9ce9d02 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -52,7 +52,7 @@ EXPORT_SYMBOL(timecounter_init);
  * The first call to this function for a new time counter initializes
  * the time tracking and returns an undefined result.
  */
-static u64 timecounter_read_delta(struct timecounter *tc)
+static u64 notrace timecounter_read_delta(struct timecounter *tc)
 {
 	cycle_t cycle_now, cycle_delta;
 	u64 ns_offset;
@@ -72,7 +72,7 @@ static u64 timecounter_read_delta(struct timecounter *tc)
 	return ns_offset;
 }
 
-u64 timecounter_read(struct timecounter *tc)
+u64 notrace timecounter_read(struct timecounter *tc)
 {
 	u64 nsec;
 
-- 
1.6.2.1
