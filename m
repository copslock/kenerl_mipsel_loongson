Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Oct 2009 16:18:15 +0100 (CET)
Received: from qw-out-1920.google.com ([74.125.92.150]:62093 "EHLO
	qw-out-1920.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1493120AbZJZPPa (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 26 Oct 2009 16:15:30 +0100
Received: by qw-out-1920.google.com with SMTP id 5so1741317qwc.54
        for <multiple recipients>; Mon, 26 Oct 2009 08:15:30 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=L26ic9HynXrYGPrY4MgLgFN/XVYSCv1X44kKAegxA2s=;
        b=ipvich4KSoocSBbMtW3tJnrcCUAm2sdIjWjFDsmC0vrEflijtUFtmWA0080PxfsbK2
         9DOZS6JXH6VEF7ylLFs2kA8RYQ2xtBBXLWasXzjKyXfEervjmqfIr1gF6ZIYqptisp49
         UVBcwDdasNTBOgwUXUtZWTcuCQi02xB9sUUBI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ONJrbruNbLpgMsyC62B1gs5uGdaa1XZZ1FugsXVBr01M7Dpe7tkjQv2hIGoSkewut/
         mg/pJi4lfL4V3lwkpOWPw1KtoQkksPILwTYbSlXq/jqXE0MTvdXdNdpTYADHmXMJHTgb
         eIiUjl5TdWs5ULNJ6I3dQpjUaFDbEu/DjpSFY=
Received: by 10.224.119.4 with SMTP id x4mr7231457qaq.304.1256570130311;
        Mon, 26 Oct 2009 08:15:30 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 21sm3876989qyk.0.2009.10.26.08.15.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 26 Oct 2009 08:15:29 -0700 (PDT)
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
Subject: [PATCH -v6 09/13] tracing: Add __arch_notrace for arch specific requirement
Date:	Mon, 26 Oct 2009 23:13:26 +0800
Message-Id: <07e35715c3af78e3c4b537940277240ed031365a.1256569489.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <f746f813531a16bd650f9290787c66cbc0cdc34d.1256569489.git.wuzhangjin@gmail.com>
References: <cover.1256569489.git.wuzhangjin@gmail.com>
 <747deea2f18d5ccffe842df95a9dd1c86251a958.1256569489.git.wuzhangjin@gmail.com>
 <3f47087b70a965fd679b17a59521671296457df1.1256569489.git.wuzhangjin@gmail.com>
 <f290e125634d164ec65b09b24b269815f78455ab.1256569489.git.wuzhangjin@gmail.com>
 <07dc907ec62353b1aca99b2850d3b2e4b734189a.1256569489.git.wuzhangjin@gmail.com>
 <374da7039d2e1b97083edd8bcd7811356884d427.1256569489.git.wuzhangjin@gmail.com>
 <3c82af564d70be05b92687949ed134ce034bf8db.1256569489.git.wuzhangjin@gmail.com>
 <a11775df0ec9665fab5861f4fa63a3e192b9ffec.1256569489.git.wuzhangjin@gmail.com>
 <f746f813531a16bd650f9290787c66cbc0cdc34d.1256569489.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1256569489.git.wuzhangjin@gmail.com>
References: <cover.1256569489.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24517
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Some arch need to not trace the common functions, but the other archs do
not need it, so, we add a new __arch_notrace to solve this problem, if
your arch need it, define it in your arch specific ftrace.h, otherwise,
ignore it! and if you just need to enable it with function graph tracer,
wrap it with "#ifdef CONFIG_FUNCTION_GRAPH_TRACER ... #endif".

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 include/linux/ftrace.h |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 0b4f97d..b3bd349 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -511,4 +511,23 @@ static inline void trace_hw_branch_oops(void) {}
 
 #endif /* CONFIG_HW_BRANCH_TRACER */
 
+/* Arch Specific notrace
+ *
+ * If your arch need it, define it in the arch specific ftrace.h
+ *
+ *	#define __arch_notrace
+ *
+ * If only need it with function graph tracer, wrap it.
+ *
+ *	#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+ *	#define __arch_notrace
+ *	#endif
+ */
+#ifndef __arch_notrace
+#define __arch_notrace
+#else
+#undef __arch_notrace
+#define __arch_notrace	notrace
+#endif
+
 #endif /* _LINUX_FTRACE_H */
-- 
1.6.2.1
