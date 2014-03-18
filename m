Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Mar 2014 08:41:04 +0100 (CET)
Received: from mail-pb0-f41.google.com ([209.85.160.41]:52246 "EHLO
        mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816759AbaCRHlCuAzW0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 18 Mar 2014 08:41:02 +0100
Received: by mail-pb0-f41.google.com with SMTP id jt11so6863879pbb.14
        for <multiple recipients>; Tue, 18 Mar 2014 00:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=GOYlGfbl+FLfcAkuQ71qx3y6+10Js538WSEv5tcbL7U=;
        b=0qQJlHVA/yNhrbmyQbXe4GM97XmgSV/5ShdGrONK5XnQ8BkePWJVXysmdyDXeRD+Tt
         lyZTd4ou7YwW8ZqnfZAgNhGT6KONNgbaXT8lu27FzRIkDgebf+uZhPqVYKIbWt5D8f8q
         II62Tm4jfE9ENVO3cabD+OPhtVXtukTVKafKNv918GuSYRhIwGpa6m/rnvLItTJ3jo6d
         hSP0+h8N6pJM9qfsmyf4KOw8Gxv7aQ8faysm9V3KnXV/ZXIlucKn3dsrYbe+Dyv9yZqE
         NH94tjqPKgQ3iMMI0RYK0ngadbTtwcRdkaRSMRHEq8N0yMTKDjnfYiM1TFs6pEQg5nv7
         nDNQ==
X-Received: by 10.66.171.76 with SMTP id as12mr31239176pac.52.1395128456683;
        Tue, 18 Mar 2014 00:40:56 -0700 (PDT)
Received: from localhost.localdomain (42-74-21-171.dynamic-ip.hinet.net. [42.74.21.171])
        by mx.google.com with ESMTPSA id x9sm49878772pbu.1.2014.03.18.00.40.51
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Mar 2014 00:40:55 -0700 (PDT)
From:   Viller Hsiao <villerhsiao@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     rostedt@goodmis.org, fweisbec@gmail.com, mingo@redhat.com,
        ralf@linux-mips.org, Qais.Yousef@imgtec.com,
        Viller Hsiao <villerhsiao@gmail.com>
Subject: [PATCH v3 2/2] MIPS: ftrace: Fix icache flush range error
Date:   Tue, 18 Mar 2014 15:40:41 +0800
Message-Id: <1395128441-32062-1-git-send-email-villerhsiao@gmail.com>
X-Mailer: git-send-email 1.8.4.3
Return-Path: <villerhsiao@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39489
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

In 32-bit mode, the start address passed to flush_icache_range is
shifted by 4 bytes before the second safe_store_code() call.

This causes system crash from time to time because the first 4 bytes
might not be flushed properly. This bug exists since linux-3.8.

Also remove obsoleted comment while at it.

Signed-off-by: Viller Hsiao <villerhsiao@gmail.com>
---
 arch/mips/kernel/ftrace.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/ftrace.c b/arch/mips/kernel/ftrace.c
index ddcc350..74fe735 100644
--- a/arch/mips/kernel/ftrace.c
+++ b/arch/mips/kernel/ftrace.c
@@ -115,11 +115,10 @@ static int ftrace_modify_code_2(unsigned long ip, unsigned int new_code1,
 	safe_store_code(new_code1, ip, faulted);
 	if (unlikely(faulted))
 		return -EFAULT;
-	ip += 4;
-	safe_store_code(new_code2, ip, faulted);
+	safe_store_code(new_code2, ip + 4, faulted);
 	if (unlikely(faulted))
 		return -EFAULT;
-	flush_icache_range(ip, ip + 8); /* original ip + 12 */
+	flush_icache_range(ip, ip + 8);
 	return 0;
 }
 #endif
-- 
1.8.4.3
