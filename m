Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 May 2008 23:25:10 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:6379 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20025348AbYECWZI (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 3 May 2008 23:25:08 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1JsQAF-0004mp-00; Sun, 04 May 2008 00:25:07 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id 52F3BFAB11; Sun,  4 May 2008 00:25:02 +0200 (CEST)
From:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH] Fix __fls for non mips32/mips64 cpus
To:	linux-mips@linux-mips.org
cc:	ralf@linux-mips.org
Message-Id: <20080503222502.52F3BFAB11@solo.franken.de>
Date:	Sun,  4 May 2008 00:25:02 +0200 (CEST)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19093
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

Only MIPS32 and MIPS64 CPUs implement clz/dclz. Therefore don't
export __ilog2() for non MIPS32/MIPS64 cpus and use generic
__fls bitop code for these cpus.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---

 include/asm-mips/bitops.h |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/asm-mips/bitops.h b/include/asm-mips/bitops.h
index c2bd126..5e1f590 100644
--- a/include/asm-mips/bitops.h
+++ b/include/asm-mips/bitops.h
@@ -558,6 +558,8 @@ static inline void __clear_bit_unlock(unsigned long nr, volatile unsigned long *
 	__clear_bit(nr, addr);
 }
 
+#if defined(CONFIG_CPU_MIPS32) || defined(CONFIG_CPU_MIPS64)
+
 /*
  * Return the bit position (0..63) of the most significant 1 bit in a word
  * Returns -1 if no 1 bit exists
@@ -596,8 +598,6 @@ static inline unsigned long __fls(unsigned long x)
 	return __ilog2(x);
 }
 
-#if defined(CONFIG_CPU_MIPS32) || defined(CONFIG_CPU_MIPS64)
-
 /*
  * __ffs - find first bit in word.
  * @word: The word to search
@@ -654,6 +654,7 @@ static inline int ffs(int word)
 #else
 
 #include <asm-generic/bitops/__ffs.h>
+#include <asm-generic/bitops/__fls.h>
 #include <asm-generic/bitops/ffs.h>
 #include <asm-generic/bitops/fls.h>
 #include <asm-generic/bitops/fls64.h>
