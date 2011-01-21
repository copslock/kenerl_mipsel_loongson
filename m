Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Jan 2011 18:29:55 +0100 (CET)
Received: from mail-px0-f177.google.com ([209.85.212.177]:42003 "EHLO
        mail-px0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491815Ab1AUR3w (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 21 Jan 2011 18:29:52 +0100
Received: by pxi7 with SMTP id 7so347697pxi.36
        for <multiple recipients>; Fri, 21 Jan 2011 09:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=CL2/32WMjakT05Li5u+/oJhcKByTU5M2BpJ7Fc1otDo=;
        b=oE0e+ZJxf8xjvcM4R8XKyAjuTGK9qMKA/pmf4OVu51+LqlNZ3ydy9uFRMLImunJ3JI
         HhR7Hk3VLKlQ+JAJLmBB5HUTGPKbu2zimIClJ1uEVXmqS6Tjg3BpYHuB57wb2M/xdiu3
         12021bF6PqCKH47cjBruV765e2YoBP+jXsl5E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=PZGLSu1h/0R5u1I8ZssJOKC4m+A1IXFSOfEurlPvyoAs5E5FceJrEjfOyKjJ5qGzOq
         4RiMcCZJv2g8up8lbAtMMi3aPcUauddzUCbG57KCVj1Y4wie5ROb8eLND+dRJGvoSltd
         yITlyey8WDHUNIH2qEaZTA5Jw1Jx98R1bWTw8=
Received: by 10.142.144.4 with SMTP id r4mr958034wfd.76.1295630983363;
        Fri, 21 Jan 2011 09:29:43 -0800 (PST)
Received: from localhost.localdomain ([61.48.59.106])
        by mx.google.com with ESMTPS id w22sm12944197wfd.7.2011.01.21.09.29.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 21 Jan 2011 09:29:41 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Steven Rostedt <srostedt@redhat.com>,
        Sergei Shtylyov <sshtylyov@mvista.com>,
        linux-mips@linux-mips.org, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [v2 PATCH 5/5] tracing, MIPS: Fix set_graph_function of function graph tracer
Date:   Sat, 22 Jan 2011 01:29:30 +0800
Message-Id: <1295630970-32044-1-git-send-email-wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29008
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

trace.func should be set to the recorded ip of the mcount calling site
in the __mcount_loc section to filter the function entries configured
through the tracing/set_graph_function interface, but before, this is
set to the self_ra(the return address of mcount), which has made
set_graph_function not work as expected.

This fixes it via calculating the right recorded ip in the __mcount_loc
section and assign it to trace.func.

Reported-by: Zhiping Zhong <xzhong86@163.com>
Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/kernel/ftrace.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/ftrace.c b/arch/mips/kernel/ftrace.c
index bc91e4a..be3fa7a 100644
--- a/arch/mips/kernel/ftrace.c
+++ b/arch/mips/kernel/ftrace.c
@@ -257,7 +257,7 @@ void prepare_ftrace_return(unsigned long *parent_ra_addr, unsigned long self_ra,
 	struct ftrace_graph_ent trace;
 	unsigned long return_hooker = (unsigned long)
 	    &return_to_handler;
-	int faulted;
+	int faulted, insns;
 
 	if (unlikely(atomic_read(&current->tracing_graph_pause)))
 		return;
@@ -304,7 +304,14 @@ void prepare_ftrace_return(unsigned long *parent_ra_addr, unsigned long self_ra,
 		return;
 	}
 
-	trace.func = self_ra;
+	/*
+	 * Get the recorded ip of the current mcount calling site in the
+	 * __mcount_loc section, which will be used to filter the function
+	 * entries configured through the tracing/set_graph_function interface.
+	 */
+
+	insns = (in_kernel_space(self_ra)) ? 2 : MCOUNT_OFFSET_INSNS + 1;
+	trace.func = self_ra - (MCOUNT_INSN_SIZE * insns);
 
 	/* Only trace if the calling function expects to */
 	if (!ftrace_graph_entry(&trace)) {
-- 
1.7.1
