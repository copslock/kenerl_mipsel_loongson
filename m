Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Mar 2018 03:02:45 +0100 (CET)
Received: from mail-pl0-x242.google.com ([IPv6:2607:f8b0:400e:c01::242]:36384
        "EHLO mail-pl0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993070AbeCLCCiJnEyL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Mar 2018 03:02:38 +0100
Received: by mail-pl0-x242.google.com with SMTP id 61-v6so8485387plf.3;
        Sun, 11 Mar 2018 19:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=MFIDtUr/Kn1dn/r/qzotSMa5WuYQqNv14xsckZ/fSJ8=;
        b=uJE7VJRDj35zDBYhigUMNVJ4sDHPjF2iEoSN8V1XkkVbh+2qe83cC/JX/ymNIeLT7L
         8GtmPvZBsUojJ+/Ex3PTvkOuv06tQIGI8Pt7tdZx4BYFeXcybPy7RERl92BiPVEDvGj3
         zBh5kRcXbD06EuU7Na+dc0x0/0ztgSRMkaCWmNKrt7CGyPwRXPkNvxxsJkihHnLH5TgR
         Tp5qtuGW1P1Haq+Gb2tkwxWBxCqd1ggpfXyf/Mls4xW5aRhoshL2isp0wyUhXX0iW7YL
         TERp9mYfi7ZxsmC/UE1HBWl/MitArUAY5W55wKwYaWhgS0nXgH4/Dfyq/KSulwgwKc60
         iXow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=MFIDtUr/Kn1dn/r/qzotSMa5WuYQqNv14xsckZ/fSJ8=;
        b=SxEC+Yzly1/y65nQoj6HXsF6Wg1P4duOuw/H9ezuN+Q7ToghlwOzO8T6SwGp9Iw+jS
         1XLfU5cicMTS8HFetI2YfMeh7m3f2BdyQ0shcHW0JERsQ8ND8cveo493xq9UsEtzfLMV
         yfY3Wyyso8UYpgIFA6f/4atYm5RE67E/jDGcPdBjInZt1zKmE5+FrcRhOerKhvIB/Kfn
         PLgwdMrZa2AAWCdFxNgJsjToSkKSBc/Q7uovye7diFOn5R3OSsRab1mgKBYm9kaZ/Yk7
         +HDZvjaoLv+xBQDB4E/6skUisrD57N5haXUFFVONjlLIb1i4dxu+NuGoaFOWKr7ozvuX
         Ih6g==
X-Gm-Message-State: AElRT7FZW5x7IoUFTPqWfogcnXnqENaxVpgmc1APdtmKa/bZnwJS8Fa+
        z0VmKW9cu4Koy3FlrKSCFCQ=
X-Google-Smtp-Source: AG47ELuWcL3AW8nEXKYfgRZ6AphkpwoaHIu92OifbQ1iyp5a2HLfwsTHrjmtmHehnM8FaS0WsbUOfA==
X-Received: by 2002:a17:902:6d0f:: with SMTP id s15-v6mr6630074plk.375.1520820151523;
        Sun, 11 Mar 2018 19:02:31 -0700 (PDT)
Received: from software.domain.org ([172.247.34.138])
        by smtp.gmail.com with ESMTPSA id z4sm10684911pgb.4.2018.03.11.19.02.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 11 Mar 2018 19:02:30 -0700 (PDT)
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
Subject: [PATCH V2] ZBOOT: fix stack protector in compressed boot phase
Date:   Mon, 12 Mar 2018 10:04:17 +0800
Message-Id: <1520820258-19225-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62912
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

V2: Fix build on ARM.

Cc: stable@vger.kernel.org
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/arm/boot/compressed/head.S        | 4 ++++
 arch/arm/boot/compressed/misc.c        | 7 -------
 arch/mips/boot/compressed/decompress.c | 7 -------
 arch/mips/boot/compressed/head.S       | 4 ++++
 arch/sh/boot/compressed/head_32.S      | 4 ++++
 arch/sh/boot/compressed/head_64.S      | 4 ++++
 arch/sh/boot/compressed/misc.c         | 7 -------
 7 files changed, 16 insertions(+), 21 deletions(-)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 45c8823..bae1fc6 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -547,6 +547,10 @@ not_relocated:	mov	r0, #0
 		bic	r4, r4, #1
 		blne	cache_on
 
+		ldr	r0, =__stack_chk_guard
+		ldr	r1, =0x000a0dff
+		str	r1, [r0]
+
 /*
  * The C runtime environment should now be setup sufficiently.
  * Set up some pointers, and start decompressing.
diff --git a/arch/arm/boot/compressed/misc.c b/arch/arm/boot/compressed/misc.c
index 16a8a80..e518ef5 100644
--- a/arch/arm/boot/compressed/misc.c
+++ b/arch/arm/boot/compressed/misc.c
@@ -130,11 +130,6 @@ asmlinkage void __div0(void)
 
 unsigned long __stack_chk_guard;
 
-void __stack_chk_guard_setup(void)
-{
-	__stack_chk_guard = 0x000a0dff;
-}
-
 void __stack_chk_fail(void)
 {
 	error("stack-protector: Kernel stack is corrupted\n");
@@ -150,8 +145,6 @@ decompress_kernel(unsigned long output_start, unsigned long free_mem_ptr_p,
 {
 	int ret;
 
-	__stack_chk_guard_setup();
-
 	output_data		= (unsigned char *)output_start;
 	free_mem_ptr		= free_mem_ptr_p;
 	free_mem_end_ptr	= free_mem_ptr_end_p;
diff --git a/arch/mips/boot/compressed/decompress.c b/arch/mips/boot/compressed/decompress.c
index fdf99e9..5ba431c 100644
--- a/arch/mips/boot/compressed/decompress.c
+++ b/arch/mips/boot/compressed/decompress.c
@@ -78,11 +78,6 @@ void error(char *x)
 
 unsigned long __stack_chk_guard;
 
-void __stack_chk_guard_setup(void)
-{
-	__stack_chk_guard = 0x000a0dff;
-}
-
 void __stack_chk_fail(void)
 {
 	error("stack-protector: Kernel stack is corrupted\n");
@@ -92,8 +87,6 @@ void decompress_kernel(unsigned long boot_heap_start)
 {
 	unsigned long zimage_start, zimage_size;
 
-	__stack_chk_guard_setup();
-
 	zimage_start = (unsigned long)(&__image_begin);
 	zimage_size = (unsigned long)(&__image_end) -
 	    (unsigned long)(&__image_begin);
diff --git a/arch/mips/boot/compressed/head.S b/arch/mips/boot/compressed/head.S
index 409cb48..00d0ee0 100644
--- a/arch/mips/boot/compressed/head.S
+++ b/arch/mips/boot/compressed/head.S
@@ -32,6 +32,10 @@ start:
 	bne	a2, a0, 1b
 	 addiu	a0, a0, 4
 
+	PTR_LA	a0, __stack_chk_guard
+	PTR_LI	a1, 0x000a0dff
+	sw	a1, 0(a0)
+
 	PTR_LA	a0, (.heap)	     /* heap address */
 	PTR_LA	sp, (.stack + 8192)  /* stack address */
 
diff --git a/arch/sh/boot/compressed/head_32.S b/arch/sh/boot/compressed/head_32.S
index 7bb1681..a3fdb05 100644
--- a/arch/sh/boot/compressed/head_32.S
+++ b/arch/sh/boot/compressed/head_32.S
@@ -76,6 +76,10 @@ l1:
 	mov.l	init_stack_addr, r0
 	mov.l	@r0, r15
 
+	mov.l	__stack_chk_guard, r0
+	mov	#0x000a0dff, r1
+	mov.l	r1, @r0
+
 	/* Decompress the kernel */
 	mov.l	decompress_kernel_addr, r0
 	jsr	@r0
diff --git a/arch/sh/boot/compressed/head_64.S b/arch/sh/boot/compressed/head_64.S
index 9993113..8b4d540 100644
--- a/arch/sh/boot/compressed/head_64.S
+++ b/arch/sh/boot/compressed/head_64.S
@@ -132,6 +132,10 @@ startup:
 	addi	r22, 4, r22
 	bne	r22, r23, tr1
 
+	movi	datalabel __stack_chk_guard, r0
+	movi	0x000a0dff, r1
+	st.l	r0, 0, r1
+
 	/*
 	 * Decompress the kernel.
 	 */
diff --git a/arch/sh/boot/compressed/misc.c b/arch/sh/boot/compressed/misc.c
index 627ce8e..fe4c079 100644
--- a/arch/sh/boot/compressed/misc.c
+++ b/arch/sh/boot/compressed/misc.c
@@ -106,11 +106,6 @@ static void error(char *x)
 
 unsigned long __stack_chk_guard;
 
-void __stack_chk_guard_setup(void)
-{
-	__stack_chk_guard = 0x000a0dff;
-}
-
 void __stack_chk_fail(void)
 {
 	error("stack-protector: Kernel stack is corrupted\n");
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
