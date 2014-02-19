Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Feb 2014 15:55:15 +0100 (CET)
Received: from mail-pd0-f173.google.com ([209.85.192.173]:57843 "EHLO
        mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6824766AbaBSOzLe5Jv2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Feb 2014 15:55:11 +0100
Received: by mail-pd0-f173.google.com with SMTP id y10so469352pdj.4
        for <multiple recipients>; Wed, 19 Feb 2014 06:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=DOuEyUgN2nu4bje8ZZNNlWcJpchwctpQ8ERXQyM9QJM=;
        b=eTRQIEqHmCT0Tgd8IWdwd2rcx/sGLAjKFloCHRnwK9NOHCSf/WbEnPzHPXB9fEYENX
         utJrl/0AQrFLvY97PE/CnpkM0JyJ82kMWiIaPoosL6WI75tpZ8cHccJUHPt8bkbbUd1o
         4+bb3s5Qf5gVNsLFS45KZjgutJn+c+bo/VwKMSD/XOKzR05jmIs8IA8o96LainJVVY2T
         sIrmkJYtnThaLcZZiUhabR4Sa52XhnnhxzNqR/Q5rOCwXVOF2UDGVebLTJRfqlHxyieI
         6DY3YYtj4/e9qEx0+IYdUVDN9YfH1+imk446mKXnRi6Uit9Cv9EadCVzAA8MppurmkAx
         Tngw==
X-Received: by 10.69.20.11 with SMTP id gy11mr2775480pbd.64.1392821704398;
        Wed, 19 Feb 2014 06:55:04 -0800 (PST)
Received: from localhost.localdomain (123-204-160-157.adsl.dynamic.seed.net.tw. [123.204.160.157])
        by mx.google.com with ESMTPSA id ac5sm1304767pbc.37.2014.02.19.06.54.57
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Feb 2014 06:55:04 -0800 (PST)
From:   Viller Hsiao <villerhsiao@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Viller Hsiao <villerhsiao@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] MIPS: ftrace: Fix icache flush range error
Date:   Wed, 19 Feb 2014 22:54:38 +0800
Message-Id: <1392821678-18556-1-git-send-email-villerhsiao@gmail.com>
X-Mailer: git-send-email 1.8.4.3
Return-Path: <villerhsiao@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39342
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


In 32-bit machine, the start address of flushing icache is wrong after
calculated address of 2nd modified instruction in function tracer. The
start address is shifted 4 bytes from ordinary calculation.

This causes problem when the address of 1st instruction is the last
word of one cache line. It will not be flushed at this case.

Signed-off-by: Viller Hsiao <villerhsiao@gmail.com>
---
 arch/mips/kernel/ftrace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/ftrace.c b/arch/mips/kernel/ftrace.c
index 185ba25..5bdc535 100644
--- a/arch/mips/kernel/ftrace.c
+++ b/arch/mips/kernel/ftrace.c
@@ -107,12 +107,12 @@ static int ftrace_modify_code_2(unsigned long ip, unsigned int new_code1,
 				unsigned int new_code2)
 {
 	int faulted;
+	unsigned long ip2 = ip + 4;
 
 	safe_store_code(new_code1, ip, faulted);
 	if (unlikely(faulted))
 		return -EFAULT;
-	ip += 4;
-	safe_store_code(new_code2, ip, faulted);
+	safe_store_code(new_code2, ip2, faulted);
 	if (unlikely(faulted))
 		return -EFAULT;
 	flush_icache_range(ip, ip + 8); /* original ip + 12 */
-- 
1.8.4.3
