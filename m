Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 Mar 2015 19:32:20 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:25505 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007557AbbCGSbsw6NTz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 7 Mar 2015 19:31:48 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 3622992A86A30;
        Sat,  7 Mar 2015 18:31:40 +0000 (GMT)
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Sat, 7 Mar
 2015 18:31:43 +0000
Received: from fun-lab.mips.com (10.20.2.221) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Sat, 7 Mar 2015
 10:31:41 -0800
From:   Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
To:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>
CC:     <macro@linux-mips.org>, Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
Subject: [PATCH v2 02/17] MIPS: Fall back to generic implementation of cmpxchg64 on 32-bit platforms
Date:   Sat, 7 Mar 2015 10:30:20 -0800
Message-ID: <1425753035-17087-3-git-send-email-dengcheng.zhu@imgtec.com>
X-Mailer: git-send-email 2.3.2
In-Reply-To: <1425753035-17087-1-git-send-email-dengcheng.zhu@imgtec.com>
References: <1425753035-17087-1-git-send-email-dengcheng.zhu@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.2.221]
Return-Path: <DengCheng.Zhu@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46252
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@imgtec.com
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

This is in preparation of adding HAVE_VIRT_CPU_ACCOUNTING_GEN support in
the next patch.

Without having cmpxchg64 to use the generic implementation, kernel linking
will complain:

kernel/built-in.o: In function `cputime_adjust':
cputime.c:(.text+0x33748): undefined reference to `__cmpxchg_called_with_bad_pointer'
cputime.c:(.text+0x33810): undefined reference to `__cmpxchg_called_with_bad_pointer'

Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
---
 arch/mips/include/asm/cmpxchg.h | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/mips/include/asm/cmpxchg.h b/arch/mips/include/asm/cmpxchg.h
index d0a2a68..412f945 100644
--- a/arch/mips/include/asm/cmpxchg.h
+++ b/arch/mips/include/asm/cmpxchg.h
@@ -229,21 +229,22 @@ extern void __cmpxchg_called_with_bad_pointer(void);
 #define cmpxchg(ptr, old, new)		__cmpxchg(ptr, old, new, smp_mb__before_llsc(), smp_llsc_mb())
 #define cmpxchg_local(ptr, old, new)	__cmpxchg(ptr, old, new, , )
 
-#define cmpxchg64(ptr, o, n)						\
+#ifdef CONFIG_64BIT
+#define cmpxchg64_local(ptr, o, n)					\
   ({									\
 	BUILD_BUG_ON(sizeof(*(ptr)) != 8);				\
-	cmpxchg((ptr), (o), (n));					\
+	cmpxchg_local((ptr), (o), (n));					\
   })
 
-#ifdef CONFIG_64BIT
-#define cmpxchg64_local(ptr, o, n)					\
+#define cmpxchg64(ptr, o, n)						\
   ({									\
 	BUILD_BUG_ON(sizeof(*(ptr)) != 8);				\
-	cmpxchg_local((ptr), (o), (n));					\
+	cmpxchg((ptr), (o), (n));					\
   })
 #else
 #include <asm-generic/cmpxchg-local.h>
 #define cmpxchg64_local(ptr, o, n) __cmpxchg64_local_generic((ptr), (o), (n))
+#define cmpxchg64(ptr, o, n) cmpxchg64_local((ptr), (o), (n))
 #endif
 
 #endif /* __ASM_CMPXCHG_H */
-- 
2.3.2
