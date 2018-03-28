Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Mar 2018 10:36:21 +0200 (CEST)
Received: from mail-pf0-x243.google.com ([IPv6:2607:f8b0:400e:c00::243]:42906
        "EHLO mail-pf0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992243AbeC1IgN6atVL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Mar 2018 10:36:13 +0200
Received: by mail-pf0-x243.google.com with SMTP id a16so707534pfn.9;
        Wed, 28 Mar 2018 01:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=AAS2cm9vITDO+Vm+0YhMN+xBJrUz645LdenuzRantAE=;
        b=KkRGUcpLbfecjB/Xi2Y0mI7ZG+8cOkUD6w9uL3hdqTSdkVoD160dKGZ2yek0x7uk9K
         NVuvLtFSeFl13UWCUQyTm56XiqSFM5HFmLwRSmWpcrz0jbN6D5ii7/1QkD+1huXmlkzf
         fqiL89kICBVwJdxNpTzkpYcnuSSmZmTgqRE1oJ0jkPebGRE82ZygaEojsMAd7yFvGckx
         mRVcnWyJSWaI93qL1EOkQY2OhDWYd+PSktGavQ3cOkU+hzilS1dtMxeD8srgdsZ120CR
         oiw9nKgU2LtUg+myK7HJ7YXDeQuVD+epkxYCrbs0VlF2ibrKO4g1ktIFt5wofUODqDPm
         KnLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=AAS2cm9vITDO+Vm+0YhMN+xBJrUz645LdenuzRantAE=;
        b=OuwethQ7h9T6geWnW8vXR7bfucPoFqBy3gOJa3kugTD4AnJcJdsuhYrMPPKeybiljE
         B60x94NjV0TV/otXiR7Z0GFfIfUGW18JSYNkaugwYJMQG0Ju/iDGMIm+yy46T1dD+pm4
         /FWtLDbjzYGLLExH0eq+RkmXuowG+2f+g+g9Uf9pdIdHq5TDX1lzOOmFqpLvsLwUctYB
         fow4VWe618ZZCNHtBgw0WNSGVa883rpJFuQkS35YippB++QFHowI4Fq5omdLu5wo7i1n
         y5CPaIMxXqe0E77kQ5p5toVwv8m5GM/fvMhMtb1fCrWrynDUMcHCiekE9LfnkYOirv2B
         7ApQ==
X-Gm-Message-State: AElRT7Em0swE5ScAbrzsNmTJ+lxERWgEV2w7tFY8QgIFnqmPuaaKhBY1
        /uvGOM12wnMEbyj/EPC7HyU=
X-Google-Smtp-Source: AIpwx4/1c+jq9VXM7GuSYMhy2pNr40eOF5nVGOrQg3UaQV8FtTzExX96uV2AFc09k3lLTivlum7CDA==
X-Received: by 10.99.115.84 with SMTP id d20mr1912235pgn.362.1522226167145;
        Wed, 28 Mar 2018 01:36:07 -0700 (PDT)
Received: from software.domain.org ([172.247.34.138])
        by smtp.gmail.com with ESMTPSA id u9sm5530949pgb.27.2018.03.28.01.36.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Mar 2018 01:36:05 -0700 (PDT)
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
Subject: [PATCH V4] ZBOOT: fix stack protector in compressed boot phase
Date:   Wed, 28 Mar 2018 16:38:16 +0800
Message-Id: <1522226296-3091-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63274
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
 arch/arm/boot/compressed/head.S        | 4 ++++
 arch/arm/boot/compressed/misc.c        | 7 -------
 arch/mips/boot/compressed/decompress.c | 7 -------
 arch/mips/boot/compressed/head.S       | 4 ++++
 arch/sh/boot/compressed/head_32.S      | 8 ++++++++
 arch/sh/boot/compressed/head_64.S      | 4 ++++
 arch/sh/boot/compressed/misc.c         | 7 -------
 7 files changed, 20 insertions(+), 21 deletions(-)

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
