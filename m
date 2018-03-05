Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Mar 2018 07:17:43 +0100 (CET)
Received: from mail-pl0-x242.google.com ([IPv6:2607:f8b0:400e:c01::242]:39906
        "EHLO mail-pl0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990411AbeCEGRfZlTEQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Mar 2018 07:17:35 +0100
Received: by mail-pl0-x242.google.com with SMTP id s13-v6so9121166plq.6;
        Sun, 04 Mar 2018 22:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=KGehzYkKKqzo+hnUP//aodr7AgGERwIf8u6K0mivxEE=;
        b=ItIUhJqLGsdpF7t7DOJ7/kFwGyS1RmqHP9G6eNNMfrUTGR8xQ9XRJYqubauFS+nER5
         FyKI9DtRHaicZQmFQR7HuP81pHqf9o4fm7O66q8rew3xgcvS5PPERNljq0CtykwZbPwC
         3ROMiFPvGD1ptNyIA8Hqhlc272gpWnb1S7dCwvx8ueScifsOguyrelsdrvrTsJLhUrrd
         9d7Rxp147b53Jn0qpk35XcCliTfVMEbif6LGAyVN02NEth1lsv1UbnwE2ixcb6nGMmTe
         +OM9C+fp8RMMNOjzFuT96aVO3lQALL0wjQfTA0jyBbndvnSm9ISEs5YTqGTpyCYKykw7
         fnpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=KGehzYkKKqzo+hnUP//aodr7AgGERwIf8u6K0mivxEE=;
        b=iytMJWeU9gFSGVNGwWo8CBgb/lCy5Sxu45O0Xie80ZkT9L/nJZACucmKyBIDVkdqxw
         a5HWi+vorZ4WIyqJZ5qp0D9NFF+G+axjGYdBlbtMJ952J7RbcB6Yavyu+Kk12GjkQjlQ
         hxEDnqQbLmddlPSI1hzb1mPjUXo0eCNrJ4334xJaaHHcPIIHl0U0j9hxdxI2srJJnqDQ
         KM3pdTfjqEP6tCHwBpr2lRj8Z6wLArzbwaTVB+bwIUgVXOChtA8HVI0YH9TneZYQ4G0U
         Xeg22mcbiNJW78z+LLIjSui8R9yTQy2iEBS4odfQN8K+b0bRLrqNByYUscTP0toWdayD
         GuaQ==
X-Gm-Message-State: APf1xPAat6WqOjqIT6SfZyEFLOBV/UgNW/C+FZBTrvJUxRjpqpgrWw1V
        4YIvaX6d2Vhp1jaEjmFqNWA=
X-Google-Smtp-Source: AG47ELsDGWRk7trRWpnT1w48RJ1vH90vwyIVx3UoINonP2qE2GSDxiEvEy5UYsqSw5qTvE2veunoDg==
X-Received: by 2002:a17:902:5716:: with SMTP id k22-v6mr12321396pli.229.1520230648772;
        Sun, 04 Mar 2018 22:17:28 -0800 (PST)
Received: from software.domain.org ([172.247.34.138])
        by smtp.gmail.com with ESMTPSA id o82sm27211131pfj.163.2018.03.04.22.17.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 04 Mar 2018 22:17:27 -0800 (PST)
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
Subject: [PATCH] ZBOOT: fix stack protector in compressed boot phase
Date:   Mon,  5 Mar 2018 14:18:41 +0800
Message-Id: <1520230721-1839-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62804
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
__stack_chk_guard_setup() and initialize __stack_chk_guard at where we
define it.

Original code comes from ARM but also used for MIPS and SH, so fix them
together. If without this fix, compressed booting of these archs will
fail because stack checking is enabled by default (>=4.16).

Cc: stable@vger.kernel.org
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/arm/boot/compressed/misc.c        | 9 +--------
 arch/mips/boot/compressed/decompress.c | 9 +--------
 arch/sh/boot/compressed/misc.c         | 9 +--------
 3 files changed, 3 insertions(+), 24 deletions(-)

diff --git a/arch/arm/boot/compressed/misc.c b/arch/arm/boot/compressed/misc.c
index 16a8a80..43aca75 100644
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
+unsigned long __stack_chk_guard = 0x000a0dff;
 
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
index fdf99e9..0694b3f 100644
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
+unsigned long __stack_chk_guard = 0x000a0dff;
 
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
index 627ce8e..2c564c2 100644
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
+unsigned long __stack_chk_guard = 0x000a0dff;
 
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
