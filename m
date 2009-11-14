Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 14 Nov 2009 07:35:56 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:52839 "EHLO
	mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492044AbZKNGeh (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 14 Nov 2009 07:34:37 +0100
Received: by mail-pw0-f45.google.com with SMTP id 15so2474684pwi.24
        for <multiple recipients>; Fri, 13 Nov 2009 22:34:36 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=hlXsEE1Ecv8QHAZg/DflgICMUJmLJ7gKdxz2WOUXnIk=;
        b=QaV0tzQs/Pld6yQd0ygD6UiHWgCge4qKwDrGXe3uK3GyN3PR9tzVDcfkgsRbokZ+bu
         +HmyxMHP87yqhVptF/wEBFEev6sSR0C/Lxcqjr8lrEo33W/5yfj+Fnb+L5MliZ9mODL0
         pvt6rtKOX+aHVk6hhkQC0Hfg0YSFHsfBiGlO0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=IR5lzP7kI69ajxU2ypIleRS1njVvNe+dIXKubaJfS1tHCcrVHWWwPVLMUwUfkCNqkD
         XB2XyS6DJKS9zo2x8Byd3aziAwxK9nc4Re79p2mYW5+hStnY5rdLUTTOwLnWEqYRG5m4
         Ki3x39Jg00qVus84xKqFQv62FrjbIFZOhlVaY=
Received: by 10.115.113.14 with SMTP id q14mr1545184wam.178.1258180476254;
        Fri, 13 Nov 2009 22:34:36 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 20sm2668108pzk.5.2009.11.13.22.34.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 13 Nov 2009 22:34:35 -0800 (PST)
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
Subject: [PATCH v8 05/16] tracing: enable HAVE_FUNCTION_TRACE_MCOUNT_TEST for MIPS
Date:	Sat, 14 Nov 2009 14:33:20 +0800
Message-Id: <7c7568247ad6cc109ec20387cfc3ca258d1d430f.1258177321.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <ea337742d3ca7eec2825416041a6d4fa917d5cc4.1258177321.git.wuzhangjin@gmail.com>
References: <9dc81a7a9e5a292cccdf465c533a2b08d19d6021.1258177321.git.wuzhangjin@gmail.com>
 <b99c08397d9ff92ac5a72bda9131df41b702fc71.1258177321.git.wuzhangjin@gmail.com>
 <8f579e2cece16cd22358a4ec143ef6a8c462639b.1258177321.git.wuzhangjin@gmail.com>
 <ea337742d3ca7eec2825416041a6d4fa917d5cc4.1258177321.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1258177321.git.wuzhangjin@gmail.com>
References: <cover.1258177321.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24896
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

There is an exisiting common ftrace_test_stop_func() in
kernel/trace/ftrace.c, which is used to check the global variable
ftrace_trace_stop to determine whether stop the function tracing.

This patch implepment the MIPS specific one to speedup the procedure.

Thanks goes to Zhang Le for Cleaning it up.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/Kconfig         |    1 +
 arch/mips/kernel/mcount.S |    3 +++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 6b33e88..a9bd992 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -5,6 +5,7 @@ config MIPS
 	select HAVE_OPROFILE
 	select HAVE_ARCH_KGDB
 	select HAVE_FUNCTION_TRACER
+	select HAVE_FUNCTION_TRACE_MCOUNT_TEST
 	# Horrible source of confusion.  Die, die, die ...
 	select EMBEDDED
 	select RTC_LIB if !LEMOTE_FULOONG2E
diff --git a/arch/mips/kernel/mcount.S b/arch/mips/kernel/mcount.S
index cebcc3c..cbb45ed 100644
--- a/arch/mips/kernel/mcount.S
+++ b/arch/mips/kernel/mcount.S
@@ -59,6 +59,9 @@
 	.endm
 
 NESTED(_mcount, PT_SIZE, ra)
+	lw	t0, function_trace_stop
+	bnez	t0, ftrace_stub
+	 nop
 	PTR_LA	t0, ftrace_stub
 	PTR_L	t1, ftrace_trace_function /* Prepare t1 for (1) */
 	bne	t0, t1, static_trace
-- 
1.6.2.1
