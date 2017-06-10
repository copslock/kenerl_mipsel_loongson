Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Jun 2017 02:28:34 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:53966 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993949AbdFJA17230Kt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 10 Jun 2017 02:27:59 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id DABD85688ABEF;
        Sat, 10 Jun 2017 01:27:51 +0100 (IST)
Received: from localhost (10.20.1.33) by HHMAIL01.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Sat, 10 Jun 2017 01:27:53
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 03/11] MIPS: cmpxchg: Use __compiletime_error() for bad cmpxchg() pointers
Date:   Fri, 9 Jun 2017 17:26:35 -0700
Message-ID: <20170610002644.8434-4-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.13.1
In-Reply-To: <20170610002644.8434-1-paul.burton@imgtec.com>
References: <20170610002644.8434-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.1.33]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58392
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

Our cmpxchg() implementation relies upon generating a call to a function
which doesn't really exist (__cmpxchg_called_with_bad_pointer) to create
a link failure in cases where cmpxchg() is called with a pointer to a
value of an unsupported size.

The __compiletime_error macro can be used to decorate a function such
that a call to it generates a compile-time, rather than a link-time,
error. This patch uses __compiletime_error to cause bad cmpxchg() calls
to error out at compile time rather than link time, allowing errors to
occur more quickly & making it easier to spot where the problem comes
from.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---

 arch/mips/include/asm/cmpxchg.h | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/cmpxchg.h b/arch/mips/include/asm/cmpxchg.h
index a19359649b60..ee0214e00ab1 100644
--- a/arch/mips/include/asm/cmpxchg.h
+++ b/arch/mips/include/asm/cmpxchg.h
@@ -137,10 +137,17 @@ static inline unsigned long __xchg(unsigned long x, volatile void * ptr, int siz
 })
 
 /*
- * This function doesn't exist, so you'll get a linker error
- * if something tries to do an invalid cmpxchg().
+ * This function doesn't exist, so if it is called you'll either:
+ *
+ * - Get an error at compile-time due to __compiletime_error, if supported by
+ *   your compiler.
+ *
+ * or:
+ *
+ * - Get an error at link-time due to the call to the missing function.
  */
-extern void __cmpxchg_called_with_bad_pointer(void);
+extern void __cmpxchg_called_with_bad_pointer(void)
+	__compiletime_error("Bad argument size for cmpxchg");
 
 #define __cmpxchg(ptr, old, new, pre_barrier, post_barrier)		\
 ({									\
-- 
2.13.1
