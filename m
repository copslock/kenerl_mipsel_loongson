Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Mar 2018 10:47:03 +0200 (CEST)
Received: from mail-pg0-x243.google.com ([IPv6:2607:f8b0:400e:c05::243]:37962
        "EHLO mail-pg0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992273AbeC1Iq4V4e-L (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Mar 2018 10:46:56 +0200
Received: by mail-pg0-x243.google.com with SMTP id a15so691893pgn.5;
        Wed, 28 Mar 2018 01:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=8GZGcSurecrsTVxb6yqZqI1ILcYj7HVhPQ9TN4Nh43A=;
        b=SXqdOjdvtctW2nug/LNl6b8sLXH4HC+0QjP1KzTIiotDtE7fLnq0vuv1b2BevqOyQw
         HD49bBqj7ofE+iuLSSNCI2RZuSJLQ7hcumdQnFxX37qAHWiF37Wvt63m2kqvTujNidkl
         oC5S5GlH3kB4Se9d5b3ygkgvaUfdpXlPy8kxbermUMGrOc1hH19mH+5nu3pgl/N1CS/0
         cL4rzwL9XFjy/bxU/UnSr21rhBEMK3AujX9vkj4CUI41QlBaXnMv+VfFqU6znVQp8Ikr
         9TMq+G38ZJBxwqfGSyQ+7XzbSxTxqkcZy7WdA0CDU33fPxU662z3o466F5GgFiQ8b9Ce
         2zig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=8GZGcSurecrsTVxb6yqZqI1ILcYj7HVhPQ9TN4Nh43A=;
        b=cRlEMZvpuqPlYv3VfCWYwaq1VjPbMDPbhG8VNIccyMa1uD5IInG1P0UU7f0ViwUmSa
         TtfvK5YsWtWgfPzqwMvRH8iWYOxbwL5Is2XI0vARWKY9T9Eaj2L9w4Mz/HblAC3d97bW
         KlpVLIpmOoi4OiOHsPyhkQu2i8b0/x1lHMizoUDVIqz6boACO9sgoezwinr3cHOPkHsG
         PlCcKHo8FAD1fKbC24CVq2MFEUTXfpWRl5/TzZe83fDii5+nfvlxcM5XR9t3DZjW/xY0
         LJs8iH5cmPNF8+moH60hI5G20T3Tiuz9Ocr/1FVDQJIFVzopDg65w7ogo3rTxT69tfZq
         iXig==
X-Gm-Message-State: AElRT7Hm3XMC03THcuNYPIEogBIn6dKCNvy0fwyFDllZbaTOo4ZewbW9
        pb6TEta9u3st8d6UBJOlcnk=
X-Google-Smtp-Source: AIpwx48SvZNB4jyj+PD3m9/aAdKaemhU/kkK1WiQNLrkyJdYSx0e1kXisr32kYr0r6hWEgKTzY/qag==
X-Received: by 10.98.237.12 with SMTP id u12mr2246898pfh.72.1522226809854;
        Wed, 28 Mar 2018 01:46:49 -0700 (PDT)
Received: from software.domain.org ([172.247.34.138])
        by smtp.gmail.com with ESMTPSA id z67sm5907759pgb.69.2018.03.28.01.46.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Mar 2018 01:46:49 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>, linux-mips@linux-mips.org,
        Russell King <linux@arm.linux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        Huacai Chen <chenhc@lemote.com>, stable@vger.kernel.org
Subject: [PATCH V4 Resend] ZBOOT: fix stack protector in compressed boot phase
Date:   Wed, 28 Mar 2018 16:48:53 +0800
Message-Id: <1522226933-29317-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63276
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

Call __stack_chk_guard_setup() in decompress_kernel() is too late that
stack checking always fails for decompress_kernel() itself. So remove
__stack_chk_guard_setup() and initialize __stack_chk_guard before we
call decompress_kernel().

Original code comes from ARM but also used for MIPS and SH, so fix them
together. If without this fix, compressed booting of these archs will
fail because stack checking is enabled by default (>=4.16).

V1 -> V2: Fix build on ARM.
V2 -> V3: Fix build on SuperH.
V3 -> V4: Initialize __stack_chk_guard in C code as a constant.

Cc: stable@vger.kernel.org
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/arm/boot/compressed/misc.c        | 9 +--------
 arch/mips/boot/compressed/decompress.c | 9 +--------
 arch/sh/boot/compressed/misc.c         | 9 +--------
 3 files changed, 3 insertions(+), 24 deletions(-)

diff --git a/arch/arm/boot/compressed/misc.c b/arch/arm/boot/compressed/misc.c
index 16a8a80..e8fe51f 100644
--- a/arch/arm/boot/compressed/misc.c
+++ b/arch/arm/boot/compressed/misc.c
@@ -128,12 +128,7 @@ asmlinkage void __div0(void)
 	error("Attempting division by 0!");
 }
 
-unsigned long __stack_chk_guard;
-
-void __stack_chk_guard_setup(void)
-{
-	__stack_chk_guard = 0x000a0dff;
-}
+const unsigned long __stack_chk_guard = 0x000a0dff;
 
 void __stack_chk_fail(void)
 {
@@ -150,8 +145,6 @@ decompress_kernel(unsigned long output_start, unsigned long free_mem_ptr_p,
 {
 	int ret;
 
-	__stack_chk_guard_setup();
-
 	output_data		= (unsigned char *)output_start;
 	free_mem_ptr		= free_mem_ptr_p;
 	free_mem_end_ptr	= free_mem_ptr_end_p;
diff --git a/arch/mips/boot/compressed/decompress.c b/arch/mips/boot/compressed/decompress.c
index fdf99e9..81df904 100644
--- a/arch/mips/boot/compressed/decompress.c
+++ b/arch/mips/boot/compressed/decompress.c
@@ -76,12 +76,7 @@ void error(char *x)
 #include "../../../../lib/decompress_unxz.c"
 #endif
 
-unsigned long __stack_chk_guard;
-
-void __stack_chk_guard_setup(void)
-{
-	__stack_chk_guard = 0x000a0dff;
-}
+const unsigned long __stack_chk_guard = 0x000a0dff;
 
 void __stack_chk_fail(void)
 {
@@ -92,8 +87,6 @@ void decompress_kernel(unsigned long boot_heap_start)
 {
 	unsigned long zimage_start, zimage_size;
 
-	__stack_chk_guard_setup();
-
 	zimage_start = (unsigned long)(&__image_begin);
 	zimage_size = (unsigned long)(&__image_end) -
 	    (unsigned long)(&__image_begin);
diff --git a/arch/sh/boot/compressed/misc.c b/arch/sh/boot/compressed/misc.c
index 627ce8e..c15cac9 100644
--- a/arch/sh/boot/compressed/misc.c
+++ b/arch/sh/boot/compressed/misc.c
@@ -104,12 +104,7 @@ static void error(char *x)
 	while(1);	/* Halt */
 }
 
-unsigned long __stack_chk_guard;
-
-void __stack_chk_guard_setup(void)
-{
-	__stack_chk_guard = 0x000a0dff;
-}
+const unsigned long __stack_chk_guard = 0x000a0dff;
 
 void __stack_chk_fail(void)
 {
@@ -130,8 +125,6 @@ void decompress_kernel(void)
 {
 	unsigned long output_addr;
 
-	__stack_chk_guard_setup();
-
 #ifdef CONFIG_SUPERH64
 	output_addr = (CONFIG_MEMORY_START + 0x2000);
 #else
-- 
2.7.0
