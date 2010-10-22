Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Oct 2010 22:57:34 +0200 (CEST)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:56534 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491178Ab0JVU5a (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Oct 2010 22:57:30 +0200
Received: by pwj6 with SMTP id 6so177604pwj.36
        for <multiple recipients>; Fri, 22 Oct 2010 13:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=fs5iWtryRhSOQ43S6rVKz57PWIq6QgxmOOAdr7QZxiQ=;
        b=ZmzRNd1D8NxKPBgh8rfcMXNabhVK5UtbwrMa7Cco7gkd/6ImRCxpz+cKIYZRjkfwVp
         R3wCAdpkmeMKP1euqUUpnzIJXC4tGCqfmG9S3S8rFaQ1IXl9di1sKQFU8r0au9Jcwov+
         U0Km5LG4x4WeO0uuBsRcPiByK7LnWR0+EJzzs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=vGh2PoASGz1BjtAxZZyk6Q+Ms1znAP1UC2xYcOS5zgBqNllYU51fWIAonKYRyOPj1v
         lGVvxy3SgwkIpjnnMBOKxqLeAgYg63ExsuxzXUYByJR+BvJIdNUfamithHxXdgh2HcFp
         XXXjKhg6WT4ci9JkglqDi3l8kU8xX5GNFtHDQ=
Received: by 10.142.125.4 with SMTP id x4mr2842304wfc.234.1287781043744;
        Fri, 22 Oct 2010 13:57:23 -0700 (PDT)
Received: from localhost.localdomain ([61.48.68.246])
        by mx.google.com with ESMTPS id x35sm5108441wfd.13.2010.10.22.13.57.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 22 Oct 2010 13:57:22 -0700 (PDT)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>, rostedt@goodmis.org,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH] MIPS: tracing/ftrace: Speedup a little for function graph tracer
Date:   Sat, 23 Oct 2010 04:57:01 +0800
Message-Id: <d64c74f74b7c0d7f98bb7a00a5850ff591c01ff7.1287779009.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28203
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

This patch removes one "ip -= 4" instruction via the following change:

	ip = x;				ip = x - 4;

	do {				do {
		ip -= 4;	==>		foo(ip);
		foo(ip);			...
		...				ip -= 4;
	} while (y);			} while (y);

BTW, the "while (( ))" is cleaned up to "while ()".

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/kernel/ftrace.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/mips/kernel/ftrace.c b/arch/mips/kernel/ftrace.c
index 5a84a1f..65f1949 100644
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
+		/* Move to the previous instruction position */
+		ip -= 4;
+	} while ((code & S_RA_SP) != S_RA_SP);
 
 	sp = fp + (code & OFFSET_MASK);
 
-- 
1.7.1
