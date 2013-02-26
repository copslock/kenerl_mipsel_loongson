Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Feb 2013 23:36:37 +0100 (CET)
Received: from mail-da0-f44.google.com ([209.85.210.44]:41825 "EHLO
        mail-da0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825727Ab3BZWggahll8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Feb 2013 23:36:36 +0100
Received: by mail-da0-f44.google.com with SMTP id z20so2240457dae.31
        for <multiple recipients>; Tue, 26 Feb 2013 14:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=k/d2tkXDtEvmpQZNFOeShUva0bvPoxsqNVLILvLF01Q=;
        b=H3JI7dRttIZZvmTtnhlgcUTCTCf5qNP6gYHgDvLUsGBgV3QK9OsXOh1xD9Fjv2y3L6
         g1c02bb1ZKWtSslAja14ySA61zRT932QUwSfE+Je50d34VwEt8FfrlqZ8M72/x0j3dwU
         4LkD8BPVrrK4S0DW45xbn7A+xSIOGPcOON6Utf8y9FQrX9wQ/LoGIjhV1e2Hu5cBxqgr
         m6c+LV0GqTsGq6TPXiuNiMgAfloUHL0BJHTJyxUDkrz7Ef1L3x93jfOZZ17OH/QUU68b
         9hUIMY+HB5wY0cbhFdRAXHDyAPnZmUc0BRujCeQYs4EcChmylAA6E7Y8rGH/ZsY+wZeN
         ShiQ==
X-Received: by 10.68.31.73 with SMTP id y9mr26236508pbh.102.1361918189624;
        Tue, 26 Feb 2013 14:36:29 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id j7sm2840130pay.10.2013.02.26.14.36.28
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 26 Feb 2013 14:36:28 -0800 (PST)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r1QMZQbW019438;
        Tue, 26 Feb 2013 14:35:26 -0800
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r1QMZPFG019437;
        Tue, 26 Feb 2013 14:35:25 -0800
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>,
        Jim Quinlan <jim2101024@gmail.com>, <stable@vger.kernel.org>
Subject: [PATCH] MIPS: Fix logic errors in bitops.c
Date:   Tue, 26 Feb 2013 14:35:23 -0800
Message-Id: <1361918123-19404-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
X-archive-position: 35828
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <david.daney@cavium.com>

commit 92d11594f6 (MIPS: Remove irqflags.h dependency from bitops.h)
factored some of the bitops code out into a separate file
(arch/mips/lib/bitops.c).  Unfortunately the logic converting a bit
mask into a boolean result was lost in some of the functions.  We had:

   int res;
   unsigned long shifted_result_bit;
   .
   .
   .
   res = shifted_result_bit;
   return res;

Which truncates off the high 32 bits (thus yielding an incorrect
value) on 64-bit systems.

The manifestation of this is that a non-SMP 64-bit kernel will not
boot as the bitmap operations in bootmem.c are all screwed up.

Signed-off-by: David Daney <david.daney@cavium.com>
Cc: Jim Quinlan <jim2101024@gmail.com>
Cc: <stable@vger.kernel.org>
---
 arch/mips/lib/bitops.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/mips/lib/bitops.c b/arch/mips/lib/bitops.c
index 239a9c9..f3f7756 100644
--- a/arch/mips/lib/bitops.c
+++ b/arch/mips/lib/bitops.c
@@ -90,12 +90,12 @@ int __mips_test_and_set_bit(unsigned long nr,
 	unsigned bit = nr & SZLONG_MASK;
 	unsigned long mask;
 	unsigned long flags;
-	unsigned long res;
+	int res;
 
 	a += nr >> SZLONG_LOG;
 	mask = 1UL << bit;
 	raw_local_irq_save(flags);
-	res = (mask & *a);
+	res = (mask & *a) != 0;
 	*a |= mask;
 	raw_local_irq_restore(flags);
 	return res;
@@ -116,12 +116,12 @@ int __mips_test_and_set_bit_lock(unsigned long nr,
 	unsigned bit = nr & SZLONG_MASK;
 	unsigned long mask;
 	unsigned long flags;
-	unsigned long res;
+	int res;
 
 	a += nr >> SZLONG_LOG;
 	mask = 1UL << bit;
 	raw_local_irq_save(flags);
-	res = (mask & *a);
+	res = (mask & *a) != 0;
 	*a |= mask;
 	raw_local_irq_restore(flags);
 	return res;
@@ -141,12 +141,12 @@ int __mips_test_and_clear_bit(unsigned long nr, volatile unsigned long *addr)
 	unsigned bit = nr & SZLONG_MASK;
 	unsigned long mask;
 	unsigned long flags;
-	unsigned long res;
+	int res;
 
 	a += nr >> SZLONG_LOG;
 	mask = 1UL << bit;
 	raw_local_irq_save(flags);
-	res = (mask & *a);
+	res = (mask & *a) != 0;
 	*a &= ~mask;
 	raw_local_irq_restore(flags);
 	return res;
@@ -166,12 +166,12 @@ int __mips_test_and_change_bit(unsigned long nr, volatile unsigned long *addr)
 	unsigned bit = nr & SZLONG_MASK;
 	unsigned long mask;
 	unsigned long flags;
-	unsigned long res;
+	int res;
 
 	a += nr >> SZLONG_LOG;
 	mask = 1UL << bit;
 	raw_local_irq_save(flags);
-	res = (mask & *a);
+	res = (mask & *a) != 0;
 	*a ^= mask;
 	raw_local_irq_restore(flags);
 	return res;
-- 
1.7.11.7
