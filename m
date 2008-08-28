Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Aug 2008 23:12:07 +0100 (BST)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.134]:20102 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S28575175AbYH1WMF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 28 Aug 2008 23:12:05 +0100
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id 7D367320CA5;
	Thu, 28 Aug 2008 22:12:15 +0000 (UTC)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [67.116.42.147])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Thu, 28 Aug 2008 22:12:15 +0000 (UTC)
Received: from silver64.hq2.avtrex.com ([192.168.7.14]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 28 Aug 2008 15:11:58 -0700
Message-ID: <48B722AD.3000703@avtrex.com>
Date:	Thu, 28 Aug 2008 15:11:57 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Cc:	linux-kernel@vger.kernel.org
Subject: [Patch 5/6] MIPS: Scheduler support for HARDWARE_WATCHPOINTS.
References: <48B71ADD.601@avtrex.com>
In-Reply-To: <48B71ADD.601@avtrex.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Aug 2008 22:11:58.0461 (UTC) FILETIME=[16B822D0:01C9095B]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20384
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips


Here we hook up the scheduler.  Whenever we switch to a new process,
we check to see if the watch registers should be installed, and do it
if needed.

Signed-off-by: David Daney <ddaney@avtrex.com>
---
 include/asm-mips/system.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/asm-mips/system.h b/include/asm-mips/system.h
index a944eda..cd30f83 100644
--- a/include/asm-mips/system.h
+++ b/include/asm-mips/system.h
@@ -20,6 +20,7 @@
 #include <asm/cmpxchg.h>
 #include <asm/cpu-features.h>
 #include <asm/dsp.h>
+#include <asm/watch.h>
 #include <asm/war.h>
 
 
@@ -76,6 +77,7 @@ do {									\
 		__restore_dsp(current);					\
 	if (cpu_has_userlocal)						\
 		write_c0_userlocal(current_thread_info()->tp_value);	\
+	__restore_watch();						\
 } while (0)
 
 static inline unsigned long __xchg_u32(volatile int * m, unsigned int val)
-- 
1.5.5.1
