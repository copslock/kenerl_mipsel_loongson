Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Mar 2014 08:39:55 +0100 (CET)
Received: from mail-pb0-f41.google.com ([209.85.160.41]:63752 "EHLO
        mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816759AbaCRHjw7cj0R (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 18 Mar 2014 08:39:52 +0100
Received: by mail-pb0-f41.google.com with SMTP id jt11so6862559pbb.14
        for <multiple recipients>; Tue, 18 Mar 2014 00:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=VTR848uiHQQxwKtUUNjVHHspmZ5bIkhiYdPfXP34Q5U=;
        b=Zjgc0BTZyoWVFPwmDNJVSy24WfW0YRyzPi4fGbIDM9IUiipUMhZkgwQPi7nbzKKtkn
         sTWySweIj2IbPJMBu/OWADSup/rRS2Wii+y2lCfLRsfPEddUplUR0IqOox8ycLnZhlLJ
         P+mxM+P4Qrb1+1cad4o+qF0vnoYaOvcAPnKoFDATyGIGqpxpIWn6F7NwbbpaVLvxapwO
         zLE5uebiRdPpEfObDoQcy0CHuiBjJw3e7LCCcoDCztCKwzwbdqTLOrMPrEcRgAVgfCrv
         isCZmWJaaWgX6OqAEptWv/LS2gNQ2ykdQYrYNMLD38TWOcnVXNASqL6jKjUpsbIcz6CT
         ll+g==
X-Received: by 10.66.232.40 with SMTP id tl8mr8717519pac.137.1395128386024;
        Tue, 18 Mar 2014 00:39:46 -0700 (PDT)
Received: from localhost.localdomain (42-74-21-171.dynamic-ip.hinet.net. [42.74.21.171])
        by mx.google.com with ESMTPSA id un5sm83644781pab.3.2014.03.18.00.39.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Mar 2014 00:39:45 -0700 (PDT)
From:   Viller Hsiao <villerhsiao@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     rostedt@goodmis.org, fweisbec@gmail.com, mingo@redhat.com,
        ralf@linux-mips.org, Qais.Yousef@imgtec.com,
        Viller Hsiao <villerhsiao@gmail.com>
Subject: [PATCH v3 1/2] MIPS: ftrace: Tweak safe_load()/safe_store() macros
Date:   Tue, 18 Mar 2014 15:39:34 +0800
Message-Id: <1395128374-31967-1-git-send-email-villerhsiao@gmail.com>
X-Mailer: git-send-email 1.8.4.3
Return-Path: <villerhsiao@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39488
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
index ce35c9a..992aaba 100644
--- a/arch/mips/include/asm/ftrace.h
+++ b/arch/mips/include/asm/ftrace.h
@@ -22,12 +22,12 @@ extern void _mcount(void);
 #define safe_load(load, src, dst, error)		\
 do {							\
 	asm volatile (					\
-		"1: " load " %[" STR(dst) "], 0(%[" STR(src) "])\n"\
-		"   li %[" STR(error) "], 0\n"		\
+		"1: " load " %[tmp_dst], 0(%[tmp_src])\n"	\
+		"   li %[tmp_err], 0\n"			\
 		"2:\n"					\
 							\
 		".section .fixup, \"ax\"\n"		\
-		"3: li %[" STR(error) "], 1\n"		\
+		"3: li %[tmp_err], 1\n"			\
 		"   j 2b\n"				\
 		".previous\n"				\
 							\
@@ -35,8 +35,8 @@ do {							\
 		STR(PTR) "\t1b, 3b\n\t"			\
 		".previous\n"				\
 							\
-		: [dst] "=&r" (dst), [error] "=r" (error)\
-		: [src] "r" (src)			\
+		: [tmp_dst] "=&r" (dst), [tmp_err] "=r" (error)\
+		: [tmp_src] "r" (src)			\
 		: "memory"				\
 	);						\
 } while (0)
@@ -44,12 +44,12 @@ do {							\
 #define safe_store(store, src, dst, error)	\
 do {						\
 	asm volatile (				\
-		"1: " store " %[" STR(src) "], 0(%[" STR(dst) "])\n"\
-		"   li %[" STR(error) "], 0\n"	\
+		"1: " store " %[tmp_src], 0(%[tmp_dst])\n"\
+		"   li %[tmp_err], 0\n"		\
 		"2:\n"				\
 						\
 		".section .fixup, \"ax\"\n"	\
-		"3: li %[" STR(error) "], 1\n"	\
+		"3: li %[tmp_err], 1\n"		\
 		"   j 2b\n"			\
 		".previous\n"			\
 						\
@@ -57,8 +57,8 @@ do {						\
 		STR(PTR) "\t1b, 3b\n\t"		\
 		".previous\n"			\
 						\
-		: [error] "=r" (error)		\
-		: [dst] "r" (dst), [src] "r" (src)\
+		: [tmp_err] "=r" (error)	\
+		: [tmp_dst] "r" (dst), [tmp_src] "r" (src)\
 		: "memory"			\
 	);					\
 } while (0)
-- 
1.8.4.3
