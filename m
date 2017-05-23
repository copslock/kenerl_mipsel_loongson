Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 May 2017 00:07:20 +0200 (CEST)
Received: from mail-pf0-x243.google.com ([IPv6:2607:f8b0:400e:c00::243]:34077
        "EHLO mail-pf0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994949AbdEWWGrMXWac (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 May 2017 00:06:47 +0200
Received: by mail-pf0-x243.google.com with SMTP id w69so30199146pfk.1
        for <linux-mips@linux-mips.org>; Tue, 23 May 2017 15:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:to:to:to:to:to:to:to:to:to:to:to:to:cc:subject:date
         :message-id:in-reply-to:references;
        bh=dV01VdDXV94ygRbSh+MJ1tIhN19rQAViJXPXa7NcrD4=;
        b=FcuRxT7NdjaKul/Isf7t3ekW+wwnd1ryFPkfXMysryRER6WTk9diORa45+iHjwr8EX
         tQ9sKcFDmlAbd9DfV5w4gMoQYyCDkzDQ6LRhNa4Q4MO+Hc4S05oEZg/6lMnrTUjw6zEW
         IIkzANNyR/xOhuViSKt8mVUNCpo22+KeNNulxxykfnFXKt9Lu1ABP0GTdMExKZ64elg6
         5IauBfAkPb1NSHSmujc4dkCiFINdG3YSM+QZ++L2hUo4VrIP9LoWCwPNZRfj8LzkazFL
         qI8IXtsnTlmFP+8rL5xaYRKGyGU+9BOVaDtg7dhqKrAIWaxczrSZAiS6YkHwttaBftZL
         m/6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:to:to:to:to:to:to:to:to:to:to:to:to:cc
         :subject:date:message-id:in-reply-to:references;
        bh=dV01VdDXV94ygRbSh+MJ1tIhN19rQAViJXPXa7NcrD4=;
        b=TUMwHlNLyxu7e5XuVWj5FuVuMbQERWFIRWURrsEKm0ytcJX4l3A1wk+PZHb/3thBTw
         gMamH0VUpcMFGMneOQ5mNCvuqge4EwW2BLTDvqZDxBqn0Siw7zkuESVnbn7xH+T57Uvd
         0GUFM9DnhiU1r0mWNhyuoJ2DNb6AQref8UaKUhmQ7cVSyzabvpVdx7ToglbRL8olM4Oh
         /UNfdexl+kfvI1DdQbhB3v+weczA0AWG0Io9tw7c8riApasngZbd7eoTywBBmAoi2IgT
         euH2iR9gR0/2g4YywlPhoVoFouVyz14k/RtrU+qzd1Qsi9xX6vI16aNjF8cobRPp+gk0
         xamQ==
X-Gm-Message-State: AODbwcCARa0T01PTTza5anh+6Qh8MgIYcWkSB3M+afpiDD9T5KXMxZiZ
        VOLDnhefOkXuubbF
X-Received: by 10.84.236.77 with SMTP id h13mr39059001pln.5.1495577201452;
        Tue, 23 May 2017 15:06:41 -0700 (PDT)
Received: from localhost ([216.38.154.21])
        by smtp.gmail.com with ESMTPSA id p13sm3769321pfl.52.2017.05.23.15.06.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 May 2017 15:06:40 -0700 (PDT)
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     monstr@monstr.eu
To:     ralf@linux-mips.org
To:     liqin.linux@gmail.com
To:     lennox.wu@gmail.com
To:     ysato@users.sourceforge.jp
To:     dalias@libc.org
To:     davem@davemloft.net
To:     linux-mips@linux-mips.org
To:     linux-sh@vger.kernel.org
To:     sparclinux@vger.kernel.org
To:     geert@linux-m68k.org
To:     linux-kernel@vger.kernel.org
To:     linux-arch@vger.kernel.org
Cc:     Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 2/7] m32r: Use lib/ucmpdi2.c
Date:   Tue, 23 May 2017 15:05:41 -0700
Message-Id: <20170523220546.16758-3-palmer@dabbelt.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170523220546.16758-1-palmer@dabbelt.com>
References: <20170523220546.16758-1-palmer@dabbelt.com>
Return-Path: <palmer@dabbelt.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57969
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: palmer@dabbelt.com
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

These files are functionally identical to the shared copies that I
recently added.

Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
---
 arch/m32r/Kconfig       |  1 +
 arch/m32r/lib/Makefile  |  3 +--
 arch/m32r/lib/libgcc.h  | 23 -----------------------
 arch/m32r/lib/ucmpdi2.c | 17 -----------------
 4 files changed, 2 insertions(+), 42 deletions(-)
 delete mode 100644 arch/m32r/lib/libgcc.h
 delete mode 100644 arch/m32r/lib/ucmpdi2.c

diff --git a/arch/m32r/Kconfig b/arch/m32r/Kconfig
index 95474460b367..2fbe3aa3e0c4 100644
--- a/arch/m32r/Kconfig
+++ b/arch/m32r/Kconfig
@@ -19,6 +19,7 @@ config M32R
 	select HAVE_DEBUG_STACKOVERFLOW
 	select CPU_NO_EFFICIENT_FFS
 	select DMA_NOOP_OPS
+	select LIB_UCMPDI3
 
 config SBUS
 	bool
diff --git a/arch/m32r/lib/Makefile b/arch/m32r/lib/Makefile
index 5889eb9610b5..0a753a833bbf 100644
--- a/arch/m32r/lib/Makefile
+++ b/arch/m32r/lib/Makefile
@@ -3,5 +3,4 @@
 #
 
 lib-y  := checksum.o ashxdi3.o memset.o memcpy.o \
-	  delay.o strlen.o usercopy.o csum_partial_copy.o \
-	  ucmpdi2.o
+	  delay.o strlen.o usercopy.o csum_partial_copy.o
diff --git a/arch/m32r/lib/libgcc.h b/arch/m32r/lib/libgcc.h
deleted file mode 100644
index 267aa435bc35..000000000000
--- a/arch/m32r/lib/libgcc.h
+++ /dev/null
@@ -1,23 +0,0 @@
-#ifndef __ASM_LIBGCC_H
-#define __ASM_LIBGCC_H
-
-#include <asm/byteorder.h>
-
-#ifdef __BIG_ENDIAN
-struct DWstruct {
-	int high, low;
-};
-#elif defined(__LITTLE_ENDIAN)
-struct DWstruct {
-	int low, high;
-};
-#else
-#error I feel sick.
-#endif
-
-typedef union {
-	struct DWstruct s;
-	long long ll;
-} DWunion;
-
-#endif /* __ASM_LIBGCC_H */
diff --git a/arch/m32r/lib/ucmpdi2.c b/arch/m32r/lib/ucmpdi2.c
deleted file mode 100644
index 9d3c682c89b5..000000000000
--- a/arch/m32r/lib/ucmpdi2.c
+++ /dev/null
@@ -1,17 +0,0 @@
-#include "libgcc.h"
-
-int __ucmpdi2(unsigned long long a, unsigned long long b)
-{
-	const DWunion au = {.ll = a};
-	const DWunion bu = {.ll = b};
-
-	if ((unsigned int)au.s.high < (unsigned int)bu.s.high)
-		return 0;
-	else if ((unsigned int)au.s.high > (unsigned int)bu.s.high)
-		return 2;
-	if ((unsigned int)au.s.low < (unsigned int)bu.s.low)
-		return 0;
-	else if ((unsigned int)au.s.low > (unsigned int)bu.s.low)
-		return 2;
-	return 1;
-}
-- 
2.13.0
