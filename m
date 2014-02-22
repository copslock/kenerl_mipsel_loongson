Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 22 Feb 2014 08:37:01 +0100 (CET)
Received: from mail-pd0-f170.google.com ([209.85.192.170]:51690 "EHLO
        mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6824821AbaBVHguDaJsd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 22 Feb 2014 08:36:50 +0100
Received: by mail-pd0-f170.google.com with SMTP id y10so1009318pdj.1
        for <multiple recipients>; Fri, 21 Feb 2014 23:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rjDy1FAe6RluYjnhMbHv+QCxYq43/srUMK2pts7AnY8=;
        b=eoeyzp32x5vA7iBJu88RMgiPhgDVkl+9GF0xK47DqKK9+qMIFgz8kc/uwN4aZhO3Wl
         Fb6swoJtKTfr0yly0EprMS20dVhX8A75cupYCThDjno3xZpnHqV0bU7X83tlb54Ydzbj
         EY+32atbwkAskO6BgyQtwpVTPWh/aTxtT1FgmkvA+hIw8Tblmw9Pd1HKuZWwfH4jrYu4
         304j2VsHr874OtAnoBYMBFTS8BbURyCPf1ykf8VH+SIL5IGpl3WmQx8uBrKWqwBLIN+u
         zDmE1jpMTHrBvO+R07Zk1mej3SV00wnwNnCoK2ffoYebKBSqOeCDp8mvsE5QkCMixrfJ
         XCJQ==
X-Received: by 10.66.65.134 with SMTP id x6mr13718969pas.12.1393054603408;
        Fri, 21 Feb 2014 23:36:43 -0800 (PST)
Received: from localhost.localdomain (42-72-119-126.dynamic-ip.hinet.net. [42.72.119.126])
        by mx.google.com with ESMTPSA id n6sm28331046pbj.22.2014.02.21.23.36.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 21 Feb 2014 23:36:43 -0800 (PST)
From:   Viller Hsiao <villerhsiao@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Viller Hsiao <villerhsiao@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Qais Yousef <Qais.Yousef@imgtec.com>
Subject: 
Date:   Sat, 22 Feb 2014 15:31:58 +0800
Message-Id: <1393054318-27356-3-git-send-email-villerhsiao@gmail.com>
X-Mailer: git-send-email 1.8.4.3
In-Reply-To: <1393054318-27356-1-git-send-email-villerhsiao@gmail.com>
References: <1393054318-27356-1-git-send-email-villerhsiao@gmail.com>
Return-Path: <villerhsiao@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39372
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

Subject: [PATCH v2 2/2] MIPS: ftrace: Fix icache flush range error

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
