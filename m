Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 Oct 2009 16:19:37 +0100 (CET)
Received: from mail-pz0-f197.google.com ([209.85.222.197]:60449 "EHLO
	mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492462AbZJYPRx (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 25 Oct 2009 16:17:53 +0100
Received: by mail-pz0-f197.google.com with SMTP id 35so7469042pzk.22
        for <multiple recipients>; Sun, 25 Oct 2009 08:17:52 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=g75Vs6VuJB5BwEhkOzuJDt6x75f6Yx0PQvPS5s+oUiQ=;
        b=SGTAcd9Ms6jkk2Bk2mUdLuSujbMKqRhYGe9Au43Dd3/OB0XmvajuTtrnZfZMKjYT67
         4Xg0nu9t5QNMaVQBHtA+I73clcG4Jh9pwe1fS465/s/yATLuxNP8KeM2o+OqbNAZXjVN
         fqsAAEqVjQF+OzYI+GqYpI+BlvvyHYk1YV8fA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=SGaYcg4CGVEm1lzWtXNkMvSKTGVRXjPvA5S5d8SFhARM7K2shV9bsAQEJrzt5kvSHM
         Th1RNZCMc46RCROyjEKwak7JR6fHIwu57ZJWXTsl9354ix+nQ4ITvneG6yC/bgiwtKrv
         cR/tkvLf7OfCVirjCJdHdp7wnzl8R2zEuoaqg=
Received: by 10.114.162.20 with SMTP id k20mr20570818wae.135.1256483872315;
        Sun, 25 Oct 2009 08:17:52 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 22sm1742515pxi.14.2009.10.25.08.17.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 25 Oct 2009 08:17:51 -0700 (PDT)
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
Subject: [PATCH -v5 05/11] tracing: enable HAVE_FUNCTION_TRACE_MCOUNT_TEST for MIPS
Date:	Sun, 25 Oct 2009 23:16:56 +0800
Message-Id: <29bccff04932e993ecd9f516d8b6dcf84e2ceecf.1256483735.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <54c417629e91f40b2bbb4e08cda2a4e6527824c0.1256483735.git.wuzhangjin@gmail.com>
References: <cover.1256482555.git.wuzhangjin@gmail.com>
 <028867b99ec532b84963a35e7d552becc783cafc.1256483735.git.wuzhangjin@gmail.com>
 <2f73eae542c47ac5bbb9f7280e6c0271d193e90d.1256483735.git.wuzhangjin@gmail.com>
 <3e0c2d7d8b8f196a8153beb41ea7f3cbf42b3d84.1256483735.git.wuzhangjin@gmail.com>
 <54c417629e91f40b2bbb4e08cda2a4e6527824c0.1256483735.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1256483735.git.wuzhangjin@gmail.com>
References: <cover.1256483735.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24488
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

There is an exisiting common ftrace_test_stop_func() in
kernel/trace/ftrace.c, which is used to check the global variable
ftrace_trace_stop to determine whether stop the function tracing.

This patch implepment the MIPS specific one to speedup the procedure.

Thanks goes to Zhang Le for Cleaning it up.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/Kconfig         |    1 +
 arch/mips/kernel/mcount.S |    4 ++++
 2 files changed, 5 insertions(+), 0 deletions(-)

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
index 0c39bc8..5dfaca8 100644
--- a/arch/mips/kernel/mcount.S
+++ b/arch/mips/kernel/mcount.S
@@ -64,6 +64,10 @@
 	.endm
 
 NESTED(_mcount, PT_SIZE, ra)
+	lw	t0, function_trace_stop
+	bnez	t0, ftrace_stub
+	nop
+
 	PTR_LA	t0, ftrace_stub
 	PTR_L	t1, ftrace_trace_function /* Prepare t1 for (1) */
 	bne	t0, t1, static_trace
-- 
1.6.2.1
