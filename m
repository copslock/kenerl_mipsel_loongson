Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 May 2010 13:09:56 +0200 (CEST)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:58672 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491836Ab0ENLJI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 May 2010 13:09:08 +0200
Received: by mail-pw0-f49.google.com with SMTP id 3so114515pwi.36
        for <multiple recipients>; Fri, 14 May 2010 04:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=E6hXixHENrMS+tDvU0nISkXRP6XsUtNtv6RR7WooTW4=;
        b=WzGGIBi4b2RB9OROqDTRtnUrCvDEntrM8UtB3GZcqmscpOTaJbHeBuv08U7Iar4sDB
         IDLrOxz9PZzUVH8NZcnNkenrKyRztjLZ1rsswjK+N03wkVzLFAQOBhKCpzatDwsF/t/a
         vJSv4uarchnqhmI+1ri9nP2SzFGf09dhMildA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=CqmKxLkV4UEGnrHODER8CqTpXnuYZANOj0POcaiNdflNugMOw0c618/7TZDUHwWtp2
         jfWmaPr4arH4GnIr57UpgUE476Q3RjKzGJ0LapGC7oquyC3bZYK+f+cW/XP9ZTDQtDVh
         WbRiI7i0YLU32duJ8Q16y1QO1ca2YX8FgskbQ=
Received: by 10.114.237.2 with SMTP id k2mr992476wah.214.1273835348044;
        Fri, 14 May 2010 04:09:08 -0700 (PDT)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id c14sm19145160waa.13.2010.05.14.04.09.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 14 May 2010 04:09:07 -0700 (PDT)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips <linux-mips@linux-mips.org>,
        David Daney <david.s.daney@gmail.com>,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH 3/9] tracing: MIPS: mcount.S: cleanup of the comments
Date:   Fri, 14 May 2010 19:08:28 +0800
Message-Id: <87986bf45b99632f5ef1b4c7aa6e639a1af7d983.1273834562.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <cover.1273834561.git.wuzhangjin@gmail.com>
References: <cover.1273834561.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1273834561.git.wuzhangjin@gmail.com>
References: <cover.1273834561.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26711
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

This patch cleans up the comments.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/kernel/mcount.S |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/mips/kernel/mcount.S b/arch/mips/kernel/mcount.S
index d4a00d2..9a029d4 100644
--- a/arch/mips/kernel/mcount.S
+++ b/arch/mips/kernel/mcount.S
@@ -6,6 +6,7 @@
  * more details.
  *
  * Copyright (C) 2009 Lemote Inc. & DSLab, Lanzhou University, China
+ * Copyright (C) 2010 DSLab, Lanzhou University, China
  * Author: Wu Zhangjin <wuzhangjin@gmail.com>
  */
 
@@ -69,14 +70,14 @@ _mcount:
 
 	MCOUNT_SAVE_REGS
 #ifdef KBUILD_MCOUNT_RA_ADDRESS
-	PTR_S	t0, PT_R12(sp)	/* t0 saved the location of the return address(at) by -mmcount-ra-address */
+	PTR_S	t0, PT_R12(sp)	/* save location of parent's return address */
 #endif
 
-	move	a0, ra		/* arg1: next ip, selfaddr */
+	move	a0, ra		/* arg1: self return address */
 	.globl ftrace_call
 ftrace_call:
 	nop	/* a placeholder for the call to a real tracing function */
-	 move	a1, AT		/* arg2: the caller's next ip, parent */
+	 move	a1, AT		/* arg2: parent's return address */
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	.globl ftrace_graph_call
@@ -117,9 +118,9 @@ NESTED(_mcount, PT_SIZE, ra)
 static_trace:
 	MCOUNT_SAVE_REGS
 
-	move	a0, ra		/* arg1: next ip, selfaddr */
+	move	a0, ra		/* arg1: self return address */
 	jalr	t2		/* (1) call *ftrace_trace_function */
-	 move	a1, AT		/* arg2: the caller's next ip, parent */
+	 move	a1, AT		/* arg2: parent's return address */
 
 	MCOUNT_RESTORE_REGS
 	.globl ftrace_stub
-- 
1.7.0.4
