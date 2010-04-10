Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Apr 2010 14:14:32 +0200 (CEST)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:50328 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492579Ab0DJMOS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 10 Apr 2010 14:14:18 +0200
Received: by pwj3 with SMTP id 3so3630144pwj.36
        for <multiple recipients>; Sat, 10 Apr 2010 05:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=VYUmR+Y4s9bws+/rs2pv3MfiLu/dxIYtiWM+i75a2WU=;
        b=CmrcKTBSwJ14H15wB1GfrdJzkh+KzaJYRHn3emNfMF4v4wgi9oU2IDOKHvxSVJk3Wx
         o6TH8TeAT+svRYTGMrGwybRNfAw0LiMJuSnSn4n4uqzhS7wAJaMA4/yKXrcN+YNydwox
         ofNQ+C8KmHey2aH2to1Sn4qVBd5cCNGl0Khkw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=qPqr4EqNAR03hInrKkK+J7KtOqrhqD/4vIPp2+vaeM+tareVUhvZXIlQmYTOA277RR
         7FIYv4v9WOuqTiIvcxxn7+NWA4e7wC6ueQdC1OuWm/VynRJelDXgydbDUnQ9Y1P4QndK
         sXtJZUfibc0Lnh7bEkgulFTUxtskr/m4hATKI=
Received: by 10.115.24.9 with SMTP id b9mr1434585waj.83.1270901649508;
        Sat, 10 Apr 2010 05:14:09 -0700 (PDT)
Received: from [192.168.2.212] ([202.201.14.140])
        by mx.google.com with ESMTPS id 22sm1923058pzk.9.2010.04.10.05.14.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 10 Apr 2010 05:14:09 -0700 (PDT)
Subject: [PATCH v5 4/4] Loongson-2F: Fixup of problems introduced by
 -mfix-loongson2f-jump
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Wu Zhangjin <wuzhangjin@gmail.com>,
        linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <cover.1270882402.git.wuzhangjin@gmail.com>
References: <cover.1270882402.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1270882402.git.wuzhangjin@gmail.com>
References: <cover.1270882402.git.wuzhangjin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Sat, 10 Apr 2010 20:07:13 +0800
Message-ID: <1270901233.14758.9.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.2 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26387
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

Changes from old revisions:

  o Incorporated with the feedbacks from Ralf Baechle and used the
  option CONFIG_CPU_JUMP_WORKAROUNDS introduced by "Loongson: Add
  CPU_LOONGSON2F_WORKAROUNDS".

The -mfix-loongson2f-jump option provided by the latest binutils(in the cvs
repository) have fixed the Out-of-order Issue of Loongson-2F described in
Chapter 15 of "Loongson2F User Manual"[1,2], but introduced some problems.

The option changes all of the jumping target to "addr & 0xcfffffff" through the
at($1) register, but for the REBOOT address of loongson-2F: 0xbfc00000, this is
totally wrong, so, this patch try to avoid the problem via telling the
assembler not to use at($1) register.

[1] Loongson2F User Manual(Chinese Version)
http://www.loongson.cn/uploadfile/file/200808211
[2] English Version of Chapter 15:
http://groups.google.com.hk/group/loongson-dev/msg/e0d2e220958f10a6?dmode=source

Reported-and-tested-by: Liu Shiwei <liushiwei@gmail.com>
Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/loongson/common/reset.c |   20 +++++++++++++++++++-
 1 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/arch/mips/loongson/common/reset.c b/arch/mips/loongson/common/reset.c
index 4bd9c18..9e10d62 100644
--- a/arch/mips/loongson/common/reset.c
+++ b/arch/mips/loongson/common/reset.c
@@ -16,13 +16,31 @@
 
 #include <loongson.h>
 
+static inline void loongson_reboot(void)
+{
+#ifndef CONFIG_CPU_JUMP_WORKAROUNDS
+	((void (*)(void))ioremap_nocache(LOONGSON_BOOT_BASE, 4)) ();
+#else
+	void (*func)(void);
+
+	func = (void *)ioremap_nocache(LOONGSON_BOOT_BASE, 4);
+
+	__asm__ __volatile__(
+	"       .set    noat                                            \n"
+	"       jr      %[func]                                         \n"
+	"       .set    at                                              \n"
+	: /* No outputs */
+	: [func] "r" (func));
+#endif
+}
+
 static void loongson_restart(char *command)
 {
 	/* do preparation for reboot */
 	mach_prepare_reboot();
 
 	/* reboot via jumping to boot base address */
-	((void (*)(void))ioremap_nocache(LOONGSON_BOOT_BASE, 4)) ();
+	loongson_reboot();
 }
 
 static void loongson_poweroff(void)
-- 
1.7.0.1
