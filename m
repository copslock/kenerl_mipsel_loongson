Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 22 Feb 2014 08:36:41 +0100 (CET)
Received: from mail-pd0-f180.google.com ([209.85.192.180]:42062 "EHLO
        mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6815989AbaBVHgjbAJAm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 22 Feb 2014 08:36:39 +0100
Received: by mail-pd0-f180.google.com with SMTP id x10so4210512pdj.25
        for <multiple recipients>; Fri, 21 Feb 2014 23:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nDAy0mv0GJHw7gur0209QCn0U2V5uqdYc0fQsjVePog=;
        b=qpYZjhyD7NWuJ5xOZWOEpg1Q/fnOh+q7BLLRrLs/Do6U8ThxiE+Q9ZjBgaYqKtAEhN
         BiMgh5gwfBw7fPDrpOO4aUrDwJuvSwz9oyiT3k08yDYZ8cMeTTKjRJAqibqcbVaFcMKd
         Lvv8A1zWvRc5NaMsAQNR8q0z1yqE0oBPEgX6vcNVtTKVX+aF2B9nZhAWonXthnImI4YZ
         YBZynrSMkS/60V4LWmaj574nememXsJrLxQauf76E4eUL4mXEg5nNP5kbnW63UBQkXP5
         7WYGPZdbx73v+E/q7aAK1JoNE5vU36SSvP6x2lGsoQXJWcBz74h6sn1uLFjwjik2ymUw
         LKag==
X-Received: by 10.66.51.137 with SMTP id k9mr2452152pao.11.1393054593086;
        Fri, 21 Feb 2014 23:36:33 -0800 (PST)
Received: from localhost.localdomain (42-72-119-126.dynamic-ip.hinet.net. [42.72.119.126])
        by mx.google.com with ESMTPSA id n6sm28331046pbj.22.2014.02.21.23.36.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 21 Feb 2014 23:36:32 -0800 (PST)
From:   Viller Hsiao <villerhsiao@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Viller Hsiao <villerhsiao@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Qais Yousef <Qais.Yousef@imgtec.com>
Subject: 
Date:   Sat, 22 Feb 2014 15:31:57 +0800
Message-Id: <1393054318-27356-2-git-send-email-villerhsiao@gmail.com>
X-Mailer: git-send-email 1.8.4.3
In-Reply-To: <1393054318-27356-1-git-send-email-villerhsiao@gmail.com>
References: <1393054318-27356-1-git-send-email-villerhsiao@gmail.com>
Return-Path: <villerhsiao@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39371
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: villerhsiao@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Subject: [PATCH v2 1/2] MIPS: ftrace: Tweak safe_load()/safe_store() macros

Due to name collision in ftrace safe_load and safe_store macros,
these macros cannot take expressions as operands.

For example, compiler will complain for a macro call like the following:
  safe_store_code(new_code2, ip + 4, faulted);

  arch/mips/include/asm/ftrace.h:61:6: note: in definition of macro 'safe_store'
     : [dst] "r" (dst), [src] "r" (src)\
        ^
  arch/mips/kernel/ftrace.c:118:2: note: in expansion of macro 'safe_store_code'
    safe_store_code(new_code2, ip + 4, faulted);
    ^
  arch/mips/kernel/ftrace.c:118:32: error: undefined named operand 'ip + 4'
    safe_store_code(new_code2, ip + 4, faulted);
                                  ^
  arch/mips/include/asm/ftrace.h:61:6: note: in definition of macro 'safe_store'
     : [dst] "r" (dst), [src] "r" (src)\
        ^
  arch/mips/kernel/ftrace.c:118:2: note: in expansion of macro 'safe_store_code'
    safe_store_code(new_code2, ip + 4, faulted);
    ^

This patch tweaks variable naming in those macros to allow flexible
operands.

Signed-off-by: Viller Hsiao <villerhsiao@gmail.com>
---
 arch/mips/include/asm/ftrace.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/mips/include/asm/ftrace.h b/arch/mips/include/asm/ftrace.h
index ce35c9a..434321c 100644
--- a/arch/mips/include/asm/ftrace.h
+++ b/arch/mips/include/asm/ftrace.h
@@ -22,12 +22,12 @@ extern void _mcount(void);
 #define safe_load(load, src, dst, error)		\
 do {							\
 	asm volatile (					\
-		"1: " load " %[" STR(dst) "], 0(%[" STR(src) "])\n"\
-		"   li %[" STR(error) "], 0\n"		\
+		"1: " load " %[dest], 0(%[source])\n"	\
+		"   li %[err], 0\n"			\
 		"2:\n"					\
 							\
 		".section .fixup, \"ax\"\n"		\
-		"3: li %[" STR(error) "], 1\n"		\
+		"3: li %[err], 1\n"			\
 		"   j 2b\n"				\
 		".previous\n"				\
 							\
@@ -35,8 +35,8 @@ do {							\
 		STR(PTR) "\t1b, 3b\n\t"			\
 		".previous\n"				\
 							\
-		: [dst] "=&r" (dst), [error] "=r" (error)\
-		: [src] "r" (src)			\
+		: [dest] "=&r" (dst), [err] "=r" (error)\
+		: [source] "r" (src)			\
 		: "memory"				\
 	);						\
 } while (0)
@@ -44,12 +44,12 @@ do {							\
 #define safe_store(store, src, dst, error)	\
 do {						\
 	asm volatile (				\
-		"1: " store " %[" STR(src) "], 0(%[" STR(dst) "])\n"\
-		"   li %[" STR(error) "], 0\n"	\
+		"1: " store " %[source], 0(%[dest])\n"\
+		"   li %[err], 0\n"		\
 		"2:\n"				\
 						\
 		".section .fixup, \"ax\"\n"	\
-		"3: li %[" STR(error) "], 1\n"	\
+		"3: li %[err], 1\n"		\
 		"   j 2b\n"			\
 		".previous\n"			\
 						\
@@ -57,8 +57,8 @@ do {						\
 		STR(PTR) "\t1b, 3b\n\t"		\
 		".previous\n"			\
 						\
-		: [error] "=r" (error)		\
-		: [dst] "r" (dst), [src] "r" (src)\
+		: [err] "=r" (error)		\
+		: [dest] "r" (dst), [source] "r" (src)\
 		: "memory"			\
 	);					\
 } while (0)
-- 
1.8.4.3
