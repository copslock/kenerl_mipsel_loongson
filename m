Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Oct 2009 16:38:24 +0200 (CEST)
Received: from mail-fx0-f225.google.com ([209.85.220.225]:52047 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493594AbZJUOft (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 21 Oct 2009 16:35:49 +0200
Received: by mail-fx0-f225.google.com with SMTP id 25so8067331fxm.0
        for <multiple recipients>; Wed, 21 Oct 2009 07:35:49 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=0jNVTZNALtsIxeoXhb1EHrV4ZkmTphwnE288Xbw5DDE=;
        b=pHcPgf1NFGPX0X0qyrYSru1kAWvskqj1slrGBzATCk9yJAeJDJVJQpdF7gL5zY36PM
         3y7pbzeuK5n/ivPAYZoSRatdHYWY7jget6tKk04CuDcY55X0ch+4K4wo0FxAqWDgW5uF
         c6CEoufKhUZPUqI9NMcBMcEEquvH7SaFH9YQ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Exox2RPYx2E4ohm++AA1OVjyXCypROZY4P9YXWtVY4m4/72FuEMX8lKFi3jsv2DPcT
         BM2LVozSc3IAj0/S+QFGLAfZFiDw7OE/F51LGlR7CJnM1SYw9kAFtZCeL6lrnP2pLrjf
         d9uDvE8k9rDlZNSGVMF3boyz5cysYlzrcXFtQ=
Received: by 10.204.24.69 with SMTP id u5mr8045019bkb.1.1256135749411;
        Wed, 21 Oct 2009 07:35:49 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 1sm303459fkt.11.2009.10.21.07.35.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 21 Oct 2009 07:35:48 -0700 (PDT)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Cc:	Wu Zhangjin <wuzhangjin@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH -v4 8/9] tracing: not trace mips_timecounter_init() in MIPS
Date:	Wed, 21 Oct 2009 22:35:02 +0800
Message-Id: <a6f2959a69b6a77dd32cc36a5c8202f97d524f1e.1256135456.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <af3ec1b5cd06b6f6a461c9fa7d09a51fabccb08d.1256135456.git.wuzhangjin@gmail.com>
References: <028867b99ec532b84963a35e7d552becc783cafc.1256135456.git.wuzhangjin@gmail.com>
 <2f73eae542c47ac5bbb9f7280e6c0271d193e90d.1256135456.git.wuzhangjin@gmail.com>
 <3f0d3515f74a58f4cfd11e61b62a129fdc21e3a7.1256135456.git.wuzhangjin@gmail.com>
 <ea8aa927fbd184b54941e4c2ae0be8ea0b4f6b8a.1256135456.git.wuzhangjin@gmail.com>
 <96110ea5dd4d3d54eb97d0bb708a5bd81c7a50b5.1256135456.git.wuzhangjin@gmail.com>
 <5dda13e8e3a9c9dba4bb7179183941bda502604f.1256135456.git.wuzhangjin@gmail.com>
 <af3ec1b5cd06b6f6a461c9fa7d09a51fabccb08d.1256135456.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1256135456.git.wuzhangjin@gmail.com>
References: <cover.1256135456.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24411
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
