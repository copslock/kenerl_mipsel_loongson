Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Mar 2018 03:51:53 +0100 (CET)
Received: from mail-pl0-x242.google.com ([IPv6:2607:f8b0:400e:c01::242]:36780
        "EHLO mail-pl0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992781AbeCACvqDhxf8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Mar 2018 03:51:46 +0100
Received: by mail-pl0-x242.google.com with SMTP id 61-v6so2816735plf.3;
        Wed, 28 Feb 2018 18:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=vYRX+SWMym+IbZ6qx4en40mwXw7Da2mzxWfQ6a8kjs4=;
        b=s1sSJ77CVWvyr3aGEK1xXtvxEK6aD27C3I6uWlCoWaqcF+9j4pkyzbo6R7DiRbTVcL
         83j0dKuxBEuNMj2BjUsCVSLJmwSLvzNUfsYenRP+f8fshr8s+BZ5qL9TJW6h18uNVCiq
         0QMGb0k6gv/meiZjuGQkAu7eBEPv+lf6lSeBwPxERHS8kp5c3/KzKpJ8aCWrtvDlvNKY
         l0EvOn+RlLUzTesh5VoOlWqIVC6USliODPxKtOKI92m796Yt/Q6TMx1qaFqpDraoY9oY
         fU+eK33C7qHGXd55rDEq0fMYmyvTuVafPRMdn43+06TJhKBdc625G8mzA6/e+tp7fmcA
         gwtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=vYRX+SWMym+IbZ6qx4en40mwXw7Da2mzxWfQ6a8kjs4=;
        b=p/Dmg6q8HB5H/VuLZ6LQzgEucLKxSpLN4mTEKqYSQnpw3kMrDtBwtmKGUNv1BklNLY
         9porSDwiJp2oSk/HQug7bYw3h9DKcD5R2cTaVnAkTEmECODhXk0gw4voO6+dDUJPf00h
         7uzgjV+oG1OA2ZS06O2dkEfWZnJ4lL4Q+TtaV4yPPsUyAfoHks90sArAQWzDsszLhdNL
         8+BUv0/7X9P7xeLtkt1MnGBWRqF3abEbRNnHMihCIxkDUzPJu2DmurkT9Jca+8oCu6KM
         bYkk2YNYxUaN/apzPFxo9mfnGD13TKenGwSo09BIqbH0m0HkarqztV++WqYZxDZqLS9z
         9Vzw==
X-Gm-Message-State: APf1xPDet92IvM9kcdc/B3Q46G/xwrbiOVVXVmuKdjpNA5fXoNNOEt/o
        ct43538eYRfZ8mm5CcXlydbyDA==
X-Google-Smtp-Source: AG47ELtoD+GRBf9a4HeyGWRKpRssCHAxzvAszb8cFcGR2MyvtwZNv+SU0u5me6mHjZUoKts3VYOwlA==
X-Received: by 2002:a17:902:70cb:: with SMTP id l11-v6mr367207plt.192.1519872699285;
        Wed, 28 Feb 2018 18:51:39 -0800 (PST)
Received: from software.domain.org ([172.247.34.138])
        by smtp.gmail.com with ESMTPSA id q67sm6170147pfg.180.2018.02.28.18.51.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Feb 2018 18:51:38 -0800 (PST)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     James Hogan <james.hogan@mips.com>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Russell King <linux@arm.linux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        Huacai Chen <chenhc@lemote.com>, stable@vger.kernel.org
Subject: [PATCH 01/99] ZBOOT: fix stack protector in compressed boot phase
Date:   Thu,  1 Mar 2018 10:53:11 +0800
Message-Id: <1519872791-19076-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62759
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
together.

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
