Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 22 Feb 2014 08:48:21 +0100 (CET)
Received: from mail-pa0-f47.google.com ([209.85.220.47]:51745 "EHLO
        mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822302AbaBVHr5j29bu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 22 Feb 2014 08:47:57 +0100
Received: by mail-pa0-f47.google.com with SMTP id kp14so4426428pab.6
        for <multiple recipients>; Fri, 21 Feb 2014 23:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GOYlGfbl+FLfcAkuQ71qx3y6+10Js538WSEv5tcbL7U=;
        b=vlbuYT2dY85HhP08Ts+UbGVW9m13ofVOFr6+PHrmPIVOELXEvF7V+HVPvRzssrjLYq
         7nVNOQa3VqndVvegpQt6ikDWW/lLpPf/b3i4Aob+Xf4ntLW2ME9oNK1FoExv/5A2m9Ro
         iouz42fxNxUr1pMM2zZvsb+Eo+Pba/HdjjdFCt8xP/XVO1fIiheF/FvE9CP/YZMDwrnD
         OPVZduiQl9XkQnvMHW6Q/z84piytZXd5S+B7JOCYbjnDGiDm6NYP22p30yrNt3As0f+Y
         8AmMDE5uAJ6g9Wza+SJkDLBpkOr6WPmf2QF+rut286X/9n7CLGrTLWEVajY93LrxfVN4
         sXuw==
X-Received: by 10.68.209.193 with SMTP id mo1mr14099839pbc.38.1393055271425;
        Fri, 21 Feb 2014 23:47:51 -0800 (PST)
Received: from localhost.localdomain (42-72-119-126.dynamic-ip.hinet.net. [42.72.119.126])
        by mx.google.com with ESMTPSA id xs1sm67029365pac.7.2014.02.21.23.47.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 21 Feb 2014 23:47:51 -0800 (PST)
From:   Viller Hsiao <villerhsiao@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     rostedt@goodmis.org, fweisbec@gmail.com, mingo@redhat.com,
        ralf@linux-mips.org, Qais.Yousef@imgtec.com,
        Viller Hsiao <villerhsiao@gmail.com>
Subject: [PATCH v2 2/2] MIPS: ftrace: Fix icache flush range error
Date:   Sat, 22 Feb 2014 15:46:49 +0800
Message-Id: <1393055209-28251-3-git-send-email-villerhsiao@gmail.com>
X-Mailer: git-send-email 1.8.4.3
In-Reply-To: <1393055209-28251-1-git-send-email-villerhsiao@gmail.com>
References: <1393055209-28251-1-git-send-email-villerhsiao@gmail.com>
Return-Path: <villerhsiao@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39375
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
