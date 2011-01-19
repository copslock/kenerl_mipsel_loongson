Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Jan 2011 20:29:53 +0100 (CET)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:52567 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491148Ab1AST26 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Jan 2011 20:28:58 +0100
Received: by pwj8 with SMTP id 8so239269pwj.36
        for <multiple recipients>; Wed, 19 Jan 2011 11:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:in-reply-to:references;
        bh=xlTacdS9VaVylCtQevnxyeVcxfbwPy5Swfg69u5GWuQ=;
        b=jmWl+6JxZYkAndY6RyWiyvyqEQeSqoRoM4xdT1BzPlEyNTUwYLq9nfYnOcXd6RgHJQ
         Hr+MrE8RmSpQxa3OTw66M3TRNx8WCLSp4kojJ8OMlb/4PnGEXzWNIa/P2M0S64lmr1gM
         cwCJyd0rwo71yiuEzVk9Pch28P+HI5PYjGHkQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=b10OlBEjZhR27KkxjFHYKDc4Snrv0tn4xtv6lc4sNpUb+UcCQavpQ3A7PoJbO+qO9k
         ZdhLDnNP+az3gdJDwck3BCDBsOKdf+X9PtSy1XcaVeM2K0FIlN1Rw6cgK5iljrybSh2v
         vWTJ5azqdifZ8+QXrG8AIhjWFBrZofkasRHSQ=
Received: by 10.142.223.18 with SMTP id v18mr1117840wfg.178.1295465327266;
        Wed, 19 Jan 2011 11:28:47 -0800 (PST)
Received: from localhost.localdomain ([221.220.250.179])
        by mx.google.com with ESMTPS id v19sm9985333wfh.12.2011.01.19.11.28.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 19 Jan 2011 11:28:46 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Wu Zhangjin <wuzhangjin@gmail.com>,
        Steven Rostedt <srostedt@redhat.com>, linux-mips@linux-mips.org
Subject: [PATCH 1/5] tracing, MIPS: reduce one instruction for function graph tracer
Date:   Thu, 20 Jan 2011 03:28:26 +0800
Message-Id: <5fcf37ab006f1ccfe6844e7392a66c4cdd1aa84d.1295464564.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <cover.1295464855.git.wuzhangjin@gmail.com>
References: <cover.1295464855.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1295464564.git.wuzhangjin@gmail.com>
References: <cover.1295464564.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28976
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

This simply moves the "ip-=4" statement down to the end of the do { ...
} while (...); loop, which reduces one unneeded subtration and the
subsequent memory loading and comparation. as a result, speed up the
function a little.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/kernel/ftrace.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/mips/kernel/ftrace.c b/arch/mips/kernel/ftrace.c
index 5a84a1f..635c1dc 100644
--- a/arch/mips/kernel/ftrace.c
+++ b/arch/mips/kernel/ftrace.c
@@ -200,19 +200,17 @@ unsigned long ftrace_get_parent_addr(unsigned long self_addr,
 	int faulted;
 
 	/*
-	 * For module, move the ip from calling site of mcount to the
-	 * instruction "lui v1, hi_16bit_of_mcount"(offset is 20), but for
-	 * kernel, move to the instruction "move ra, at"(offset is 12)
+	 * For module, move the ip from calling site of mcount after the
+	 * instruction "lui v1, hi_16bit_of_mcount"(offset is 24), but for
+	 * kernel, move after the instruction "move ra, at"(offset is 16)
 	 */
-	ip = self_addr - (in_module(self_addr) ? 20 : 12);
+	ip = self_addr - (in_module(self_addr) ? 24 : 16);
 
 	/*
 	 * search the text until finding the non-store instruction or "s{d,w}
 	 * ra, offset(sp)" instruction
 	 */
 	do {
-		ip -= 4;
-
 		/* get the code at "ip": code = *(unsigned int *)ip; */
 		safe_load_code(code, ip, faulted);
 
@@ -226,7 +224,9 @@ unsigned long ftrace_get_parent_addr(unsigned long self_addr,
 		if ((code & S_R_SP) != S_R_SP)
 			return parent_addr;
 
-	} while (((code & S_RA_SP) != S_RA_SP));
+		/* Move to the next instruction */
+		ip -= 4;
+	} while ((code & S_RA_SP) != S_RA_SP);
 
 	sp = fp + (code & OFFSET_MASK);
 
-- 
1.7.1
