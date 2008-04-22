Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Apr 2008 01:33:17 +0100 (BST)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.144]:5357 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S20043690AbYDVAdP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 22 Apr 2008 01:33:15 +0100
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id 142E7318F62;
	Tue, 22 Apr 2008 00:34:49 +0000 (UTC)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [67.116.42.147])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Tue, 22 Apr 2008 00:34:48 +0000 (UTC)
Received: from dl2.hq2.avtrex.com ([192.168.7.26]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 21 Apr 2008 17:33:05 -0700
Message-ID: <480D3240.5050106@avtrex.com>
Date:	Mon, 21 Apr 2008 17:33:04 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 2.0.0.12 (X11/20080226)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Cc:	linux-kernel@vger.kernel.org
Subject: [Patch 5/6] Scheduler support for HARDWARE_WATCHPOINTS.
References: <480D2151.2020701@avtrex.com>
In-Reply-To: <480D2151.2020701@avtrex.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Apr 2008 00:33:05.0654 (UTC) FILETIME=[6E458160:01C8A410]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18990
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

This is the meat of the patch.  Here we install the watch register values when we
schedule a new thread.

The implemtation of __restore_watch() is in asm/watch.h.  In the case where there
are no watch registers to install (the normal case) the overhead is 5 machine
instructions with gcc-3.4.3.

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
1.5.5
