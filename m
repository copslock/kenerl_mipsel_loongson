Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Jan 2011 20:30:50 +0100 (CET)
Received: from mail-px0-f177.google.com ([209.85.212.177]:46490 "EHLO
        mail-px0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491154Ab1AST3B (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Jan 2011 20:29:01 +0100
Received: by pxi7 with SMTP id 7so231789pxi.36
        for <multiple recipients>; Wed, 19 Jan 2011 11:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:in-reply-to:references;
        bh=xlTacdS9VaVylCtQevnxyeVcxfbwPy5Swfg69u5GWuQ=;
        b=xnWdpS78xnDEcdh19zLbr7UNG39Su+DlOSw4YZsqSe+xfSXrQ4WrfVQo7IAri2WW/D
         gC8uPvFVNWDghD9LB3B2J9UjkyV8Wfuzz/hh501UmS42NTp/deCNagBiNW43YrhGMyx4
         TS7wpjkaI0hqutMgFSXnot7ZWNwoco+zWFJMc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=JgSvDjvZ/CzUKgQdrYtW4c6cLj2JTuHD7Q5/H+nfipF8+EOVK6cRAtHbqWyrdbJrZB
         8VxtYnqGxup4aGS+D6bRY1N/fbyVIMnaF9+W8XPYTppWACeKCvw7QOhV4ore55wbA/FN
         98kXMV/lv3+BPVIY0UAfQWOjkYVpYm01xcq0Y=
Received: by 10.142.216.1 with SMTP id o1mr1132686wfg.190.1295465331105;
        Wed, 19 Jan 2011 11:28:51 -0800 (PST)
Received: from localhost.localdomain ([221.220.250.179])
        by mx.google.com with ESMTPS id v19sm9985333wfh.12.2011.01.19.11.28.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 19 Jan 2011 11:28:50 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Wu Zhangjin <wuzhangjin@gmail.com>,
        Steven Rostedt <srostedt@redhat.com>, linux-mips@linux-mips.org
Subject: [PATCH 1/5] tracing, MIPS: Speed up function graph tracer
Date:   Thu, 20 Jan 2011 03:28:27 +0800
Message-Id: <fb8f28a14e37c9421ed568a45b6b3705a3b282a1.1295464855.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <cover.1295464855.git.wuzhangjin@gmail.com>
References: <cover.1295464855.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1295464855.git.wuzhangjin@gmail.com>
References: <cover.1295464855.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28978
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
