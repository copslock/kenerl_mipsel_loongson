Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Jun 2017 02:31:19 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:16518 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993975AbdFJA3qTpNbt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 10 Jun 2017 02:29:46 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id D75A75E637AB0;
        Sat, 10 Jun 2017 01:29:38 +0100 (IST)
Received: from localhost (10.20.1.33) by HHMAIL01.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Sat, 10 Jun 2017 01:29:40
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 09/11] MIPS: cmpxchg: Rearrange __xchg() arguments to match xchg()
Date:   Fri, 9 Jun 2017 17:26:41 -0700
Message-ID: <20170610002644.8434-10-paul.burton@imgtec.com>
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
X-archive-position: 58398
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

The __xchg() function declares its first 2 arguments in reverse order
compared to the xchg() macro, which is confusing & serves no purpose.
Reorder the arguments such that __xchg() & xchg() match.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---

 arch/mips/include/asm/cmpxchg.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/cmpxchg.h b/arch/mips/include/asm/cmpxchg.h
index a633f61c5545..903f3bf48419 100644
--- a/arch/mips/include/asm/cmpxchg.h
+++ b/arch/mips/include/asm/cmpxchg.h
@@ -73,7 +73,8 @@ extern unsigned long __xchg_called_with_bad_pointer(void)
 extern unsigned long __xchg_small(volatile void *ptr, unsigned long val,
 				  unsigned int size);
 
-static inline unsigned long __xchg(unsigned long x, volatile void * ptr, int size)
+static inline unsigned long __xchg(volatile void *ptr, unsigned long x,
+				   int size)
 {
 	switch (size) {
 	case 1:
@@ -101,7 +102,7 @@ static inline unsigned long __xchg(unsigned long x, volatile void * ptr, int siz
 	smp_mb__before_llsc();						\
 									\
 	__res = (__typeof__(*(ptr)))					\
-		__xchg((unsigned long)(x), (ptr), sizeof(*(ptr)));	\
+		__xchg((ptr), (unsigned long)(x), sizeof(*(ptr)));	\
 									\
 	smp_llsc_mb();							\
 									\
-- 
2.13.1
