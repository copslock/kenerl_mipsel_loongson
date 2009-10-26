Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Oct 2009 16:19:06 +0100 (CET)
Received: from qw-out-1920.google.com ([74.125.92.150]:62093 "EHLO
	qw-out-1920.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1493130AbZJZPPv (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 26 Oct 2009 16:15:51 +0100
Received: by qw-out-1920.google.com with SMTP id 5so1741317qwc.54
        for <multiple recipients>; Mon, 26 Oct 2009 08:15:50 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=xFsRX/2Y4DbDzhBttXXIRkoW5RJTV2OL9A2xmn8Oq2Y=;
        b=J5rpDjfhUj3Z+GZHReeQk0qFVh0UEFDw7HQMJqvJaGmYx78/QA4VWfJox3MCmHqarE
         KwZfjdkctCw7zTum4kYa4Y+JDTU6p+zap/QPwX7reDaS8iFE1OLRKID1TuZoPgu1+uSJ
         1CV0uT5aRp0VweonAYjq2SmUOF+F1SeXhRSYg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=RDmM0RifS/UoppmHvj7/1NEO4AlLZhC0OPcp096P8OY5OO6B85+n8NHuZKuBH9968X
         pDBR1yIyjUqjvLQUZGQkpfD1ZpofQTLdO9u5SNwqfg+5sqjkhh0jkkwQDwJIO6klh4ed
         GL8JBEVAv180HWuVJjOHhMB8h5Se9UmZW0awY=
Received: by 10.224.39.70 with SMTP id f6mr7296531qae.341.1256570150323;
        Mon, 26 Oct 2009 08:15:50 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 21sm3876989qyk.0.2009.10.26.08.15.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 26 Oct 2009 08:15:48 -0700 (PDT)
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
Subject: [PATCH -v6 11/13] tracing: not trace mips_timecounter_read() for MIPS
Date:	Mon, 26 Oct 2009 23:13:28 +0800
Message-Id: <bdfc54ea3c82f1d34149a5565132ff896edd4f76.1256569489.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <4e022c090601c3585a8d69a54deade2a53f93e8c.1256569489.git.wuzhangjin@gmail.com>
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
 <4e022c090601c3585a8d69a54deade2a53f93e8c.1256569489.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1256569489.git.wuzhangjin@gmail.com>
References: <cover.1256569489.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24519
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

We use mips_timecounter_read() to get the timestamp in MIPS, so, it's
better to not trace it and it's subroutines, otherwise, it will goto
recursion(hang) when using function graph tracer. we use the
__notrace_funcgraph annotation to indicate them not to be traced.

And there are two common functions called by mips_timecounter_read(), we
define the __arch_notrace macro to ensure they are not to be traced.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/include/asm/ftrace.h |    5 +++++
 arch/mips/kernel/csrc-r4k.c    |    5 +++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/ftrace.h b/arch/mips/include/asm/ftrace.h
index d5771e8..452b996 100644
--- a/arch/mips/include/asm/ftrace.h
+++ b/arch/mips/include/asm/ftrace.h
@@ -31,6 +31,11 @@ static inline unsigned long ftrace_call_adjust(unsigned long addr)
 struct dyn_arch_ftrace {
 };
 #endif /*  CONFIG_DYNAMIC_FTRACE */
+
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+#define __arch_notrace
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
