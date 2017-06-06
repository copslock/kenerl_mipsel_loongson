Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Jun 2017 21:11:49 +0200 (CEST)
Received: from mail-pf0-x242.google.com ([IPv6:2607:f8b0:400e:c00::242]:36188
        "EHLO mail-pf0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993879AbdFFTKg4DHbB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 6 Jun 2017 21:10:36 +0200
Received: by mail-pf0-x242.google.com with SMTP id y7so6590851pfd.3
        for <linux-mips@linux-mips.org>; Tue, 06 Jun 2017 12:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:to:to:to:to:to:to:to:to:to:to:to:to:cc:subject:date
         :message-id:in-reply-to:references;
        bh=EalZlzEWIRkzFIBivEHQX54fg2fNljIQYyxlVMe0+mw=;
        b=rB7eSxATzWb4Nj4R2Sia+wYS9F77K15HY0z23bmTF9YwpxFQhNeDN+9zd8rjsRBh7F
         XPDR2SFqluTODfgvM5Tijtz5RtCjET+ZjZCBe1cW0iLibP5BG1MFMPVsEpd6Jvj4wEkr
         0N4JB/NvfHQ2qORLYbyAiAyGrNbcLSVlnBX6hQzE/UQjL72rHPtNexn8LoxOFmDzD0A2
         36oGp/wBlDJGmxcVtG5Yb7PSlXtykEGaA8VPZoREVLPsopmxg/GzoJSlxF6WN7s9dFT/
         NuBp5etDD35jSoQkCdB8UPoJYvYf6JivnrX++fisa4tXLDQFSjNOhb943mWklTSpz4aN
         eFFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:to:to:to:to:to:to:to:to:to:to:to:to:cc
         :subject:date:message-id:in-reply-to:references;
        bh=EalZlzEWIRkzFIBivEHQX54fg2fNljIQYyxlVMe0+mw=;
        b=psJksiLjGpQjyxFebfS9poyYc4QN83z/0DUCwmLlLfROvbR5NLrH6oATup+qxr9Jyu
         hS3a125YnIOH5HI72C12b6ExpPIlrXASUsDnUXW9Owd9Xe/wdqU1cu4MlAMRVWqp0Pn0
         tFXz3tkeRA2VKP1pSReU8XEE3iG4I2UhlMNf21UG8r7689nmm8VGycnCFr4chPpgVQQn
         /cBVbfC5Ny7R65GhU01hYTEjhX+bXNaiTUA8jYwNi9xuFl039QXHhh9cRgTYYYWMgeB5
         RmJIddioNNPIOu/Y7h65FkthpL70JUFjHf82OeltBhbUgFN0d1NJn1lMZBjGJih6xO2l
         gdmw==
X-Gm-Message-State: AODbwcBiFcmw84isjXW8jWzC2RZzKoPHuQA76b8MNv9kIV2UHA8og4IT
        1FAqlKSoY4wubtAw
X-Received: by 10.98.72.129 with SMTP id q1mr27178545pfi.161.1496776230980;
        Tue, 06 Jun 2017 12:10:30 -0700 (PDT)
Received: from localhost ([216.38.154.21])
        by smtp.gmail.com with ESMTPSA id x6sm62566120pfk.22.2017.06.06.12.10.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Jun 2017 12:10:30 -0700 (PDT)
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
Date:   Tue,  6 Jun 2017 12:10:18 -0700
Message-Id: <20170606191023.24581-3-palmer@dabbelt.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170606191023.24581-1-palmer@dabbelt.com>
References: <20170523220546.16758-1-palmer@dabbelt.com>
 <20170606191023.24581-1-palmer@dabbelt.com>
Return-Path: <palmer@dabbelt.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58263
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
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m32r/Kconfig       |  1 +
 arch/m32r/lib/Makefile  |  3 +--
 arch/m32r/lib/libgcc.h  | 23 -----------------------
 arch/m32r/lib/ucmpdi2.c | 17 -----------------
 4 files changed, 2 insertions(+), 42 deletions(-)
 delete mode 100644 arch/m32r/lib/libgcc.h
 delete mode 100644 arch/m32r/lib/ucmpdi2.c

diff --git a/arch/m32r/Kconfig b/arch/m32r/Kconfig
index 95474460b367..756d68d4f4e1 100644
--- a/arch/m32r/Kconfig
+++ b/arch/m32r/Kconfig
@@ -19,6 +19,7 @@ config M32R
 	select HAVE_DEBUG_STACKOVERFLOW
 	select CPU_NO_EFFICIENT_FFS
 	select DMA_NOOP_OPS
+	select GENERIC_UCMPDI3
 
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
