Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Jan 2011 19:02:17 +0100 (CET)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:45144 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491763Ab1AUSCO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 21 Jan 2011 19:02:14 +0100
Received: by pwj8 with SMTP id 8so357940pwj.36
        for <multiple recipients>; Fri, 21 Jan 2011 10:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=IpQLMpYRIp+STx0biLLklAKqSlWzwlwizjLLGtuz99I=;
        b=OtbO5SI84pNw0ijkJcRbEVarmEcAycnWmlAkST8lhJtdhR6+4p2pO2V4MMt1UIQnH8
         TCoFm45mgsuePjEy2Cry3DIcUMKeU1+M4IaM8gSjNz9WD/ptZj8T0iD4g+uyXE3nEnQ+
         JYX1vFIihRokm08JsBHkTBigmWLq5j7r0wGu0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=cuOz67lYJvNOiAEKy4H3MU5WYXZ7s9h6IpSf7G4//3WGi09hdP912ah3mKtaaFWbrI
         snIWQo64z7ZSFCcH/+fl9+3VeezLsPuYHKENWQhf91dQ0W6+ZaFjVx19Wpqu6mtTR4D2
         mjIT1F+9BTxyW8u0khY49bE7i8zrJZp5xKuCo=
Received: by 10.142.171.3 with SMTP id t3mr971940wfe.281.1295632927251;
        Fri, 21 Jan 2011 10:02:07 -0800 (PST)
Received: from localhost.localdomain ([61.48.59.106])
        by mx.google.com with ESMTPS id q13sm12980214wfc.5.2011.01.21.10.02.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 21 Jan 2011 10:02:05 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Steven Rostedt <srostedt@redhat.com>,
        Sergei Shtylyov <sshtylyov@mvista.com>,
        linux-mips@linux-mips.org, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [v3 PATCH 5/5] tracing, MIPS: Fix set_graph_function of function graph tracer
Date:   Sat, 22 Jan 2011 02:01:53 +0800
Message-Id: <1295632913-4558-1-git-send-email-wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29011
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
index bc91e4a..94ca2b0 100644
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
+	insns = in_kernel_space(self_ra) ? 2 : MCOUNT_OFFSET_INSNS + 1;
+	trace.func = self_ra - (MCOUNT_INSN_SIZE * insns);
 
 	/* Only trace if the calling function expects to */
 	if (!ftrace_graph_entry(&trace)) {
-- 
1.7.1
