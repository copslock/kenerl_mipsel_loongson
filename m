Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Nov 2009 16:35:22 +0100 (CET)
Received: from mail-ew0-f216.google.com ([209.85.219.216]:46041 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493128AbZKIPcx (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 9 Nov 2009 16:32:53 +0100
Received: by mail-ew0-f216.google.com with SMTP id 12so3364851ewy.0
        for <multiple recipients>; Mon, 09 Nov 2009 07:32:53 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=WHgYJhzOUuKzwUTV1v7u0drKAEXRtW1PbR2aW3XzMbo=;
        b=YL2ktzqFWluibhpwXdQv/5KWZY9a5yRzVFY2fKnXjKDoe1VIs1CLogbVV/idQ0TY03
         Pu3kCivmmSp3rXqauapibwy+WyctEvyGTCM/Gnt0Y2A1KHHNDMHfw+x353B+uClxRqwJ
         OzWKur+MmhKmbbcCcVw3AQzGj/tHxBPXEn00Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Bz1MCrU8tNcRA6/UKc3T/YENxR0sM/j7cgtzP8a94GrcDK5ezweRFauprMPfPTLaeR
         HvRIaXiOVULVnCdmZZ7LPiFckf7HImgjqhwCmH5/q6kK4wPfL8x7hCjK71siCMV1AvWG
         Ldl3iV/13ewIZVsfPUcGcUd0MJN+UU7MK51Xo=
Received: by 10.216.86.137 with SMTP id w9mr2691834wee.104.1257780772917;
        Mon, 09 Nov 2009 07:32:52 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id g9sm9033556gvc.25.2009.11.09.07.32.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 09 Nov 2009 07:32:51 -0800 (PST)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc:	zhangfx@lemote.com, zhouqg@gmail.com,
	Wu Zhangjin <wuzhangjin@gmail.com>,
	Ralf Baechle <ralf@linux-mips.org>, rostedt@goodmis.org,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Ingo Molnar <mingo@elte.hu>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	David Daney <ddaney@caviumnetworks.com>,
	Richard Sandiford <rdsandiford@googlemail.com>,
	Patrik Kluba <kpajko79@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Michal Simek <monstr@monstr.eu>
Subject: [PATCH v7 09/17] tracing: define a new __time_notrace annotation flag
Date:	Mon,  9 Nov 2009 23:31:26 +0800
Message-Id: <18e1d617ed824bb1c10f15216f2ed9ed3de78abd.1257779502.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <0cef783a71333ff96a78aaea8961e3b6b5392665.1257779502.git.wuzhangjin@gmail.com>
References: <9dc81a7a9e5a292cccdf465c533a2b08d19d6021.1257779502.git.wuzhangjin@gmail.com>
 <b99c08397d9ff92ac5a72bda9131df41b702fc71.1257779502.git.wuzhangjin@gmail.com>
 <8f579e2cece16cd22358a4ec143ef6a8c462639b.1257779502.git.wuzhangjin@gmail.com>
 <cefe074f5eb3cfbc2e0bb41b0c1f61fcd0190d90.1257779502.git.wuzhangjin@gmail.com>
 <6199d7b3956b544fc65896af1062787a2e1283ce.1257779502.git.wuzhangjin@gmail.com>
 <58a7558730fbea6cd0417100c8fcd6f45668d1e3.1257779502.git.wuzhangjin@gmail.com>
 <3a9fc9ca02e8e6e9c3c28797a4c084c1f9d91f69.1257779502.git.wuzhangjin@gmail.com>
 <0cef783a71333ff96a78aaea8961e3b6b5392665.1257779502.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1257779502.git.wuzhangjin@gmail.com>
References: <cover.1257779502.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24781
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

Ftrace gets the timestamp via time relative functions, when enabling
function graph tracer, if we also trace these functions, the system will
go into recusion and then hang there. So, we must not trace them. and
there are two existing methods help this job.

The first one is annotating them with notrace, another method is
removing the -pg for the whole file which included them:

CFLAGS_REMOVE_ftrace.o = -pg

But there is a particular situation, that is some archs(i.e MIPS,
Microblaze) need to notrace the common time relative source code, we can
not simply annotate them with the above methods, but need to consider
the archs respectively. this patch does it!

This patch introduce a new annotation flag: __time_notrace, if your
platform need it, define it in your arch specific ftrace.h:

	#define __time_notrace notrace

if only function graph trace need it, wrap it:

	#ifdef CONFIG_FUNCTION_GRAPH_TRACER
	 #define __time_notrace notrace
	#endif

otherwise, ignore it!

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>

common notrace

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 include/linux/ftrace.h |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 0b4f97d..c3f2f0f 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -511,4 +511,16 @@ static inline void trace_hw_branch_oops(void) {}
 
 #endif /* CONFIG_HW_BRANCH_TRACER */
 
+/* arch specific notrace for time relative functions, If your arch need it,
+ * define it in the arch specific ftrace.h
+ *
+ *	#define __time_notrace notrace
+ *
+ * otherwise, ignore it!
+ */
+
+#ifndef __time_notrace
+ #define __time_notrace
+#endif
+
 #endif /* _LINUX_FTRACE_H */
-- 
1.6.2.1
