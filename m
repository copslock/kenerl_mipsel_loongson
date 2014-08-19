Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Aug 2014 18:27:41 +0200 (CEST)
Received: from mail-wi0-f172.google.com ([209.85.212.172]:42710 "EHLO
        mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6855164AbaHSQ1cW-mwL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Aug 2014 18:27:32 +0200
Received: by mail-wi0-f172.google.com with SMTP id n3so5722092wiv.5
        for <linux-mips@linux-mips.org>; Tue, 19 Aug 2014 09:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Xl/JczCud+SstPBgXblABxuisRbJ2WgwVaKf29Z5ToI=;
        b=1FaPHajrS9GIU+wd32gt1G+Z8hWDk3WxSS85famlu+JilrF7yv6H2eSmuy7VIjToNV
         1eI/ez6zfnLAiOJi3ZG3DEtAuTr+F6NPR4l9MxWRNu7QhXvSguvV2UUeIf4sZ1GBfib0
         AUBMO4dOj8sCht4jedsCzPK23A4c/mF4YJJRZAEthWRotN6SfsIIEohxF78QFeyIQxPu
         oziQtLn4SVQsDh2dCnm3MKHZGkWQ2PhU9p2ryV9PrCZEPWpiEi7CMtXmsqYZxwK0iVbh
         HI380hj6AZHZAD8Asd0TSGa672U/cmrDTkUuePBF/v8BJfsTH7+jPDC/x5vK/O3Au7NC
         FbIw==
X-Received: by 10.194.205.70 with SMTP id le6mr50716728wjc.25.1408465646808;
        Tue, 19 Aug 2014 09:27:26 -0700 (PDT)
Received: from localhost.localdomain (p4FD8DDD4.dip0.t-ipconnect.de. [79.216.221.212])
        by mx.google.com with ESMTPSA id cx5sm51582592wjb.8.2014.08.19.09.27.25
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Aug 2014 09:27:26 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>
Subject: [RFC PATCH V2] MIPS: fix build with binutils 2.24.51+
Date:   Tue, 19 Aug 2014 18:27:12 +0200
Message-Id: <1408465632-34262-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 2.0.4
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42149
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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

With binutils snapshots since 29.07.2014 I get the following build failure:
{standard input}: Warning: .gnu_attribute 4,3 requires `softfloat'
  LD      arch/mips/alchemy/common/built-in.o
mipsel-softfloat-linux-gnu-ld: Warning: arch/mips/alchemy/common/built-in.o
 uses -msoft-float (set by arch/mips/alchemy/common/prom.o),
 arch/mips/alchemy/common/sleeper.o uses -mhard-float

Extend cflags with a soft-float directive for the assembler, and add
hardfloat directives to assembler files dealing with FPU
registers to compensate.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
V2: cover more assembler files.

This was introduced in binutils commit  351cdf24d223290b15fa991e5052ec9e9bd1e284
("[MIPS] Implement O32 FPXX, FP64 and FP64A ABI extensions"), and it seems is only
a problem with my gcc 4.9 or a very recent snapshot of gcc-4.10.
With gcc-4.8, the source builds, with 4.9 it aborts after the above error,
with 4.10 (which apparently passes -msoft-float along to the assembler automatically)
the .hardfloat directives are required.

 arch/mips/Makefile              | 2 +-
 arch/mips/kernel/r2300_switch.S | 1 +
 arch/mips/kernel/r4k_fpu.S      | 1 +
 arch/mips/kernel/r4k_switch.S   | 1 +
 arch/mips/kernel/r6000_fpu.S    | 1 +
 5 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 9336509..cffbd49 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -88,7 +88,7 @@ all-$(CONFIG_SYS_SUPPORTS_ZBOOT)+= vmlinuz
 # crossformat linking we rely on the elf2ecoff tool for format conversion.
 #
 cflags-y			+= -G 0 -mno-abicalls -fno-pic -pipe
-cflags-y			+= -msoft-float
+cflags-y			+= -msoft-float -Wa,-msoft-float
 LDFLAGS_vmlinux			+= -G 0 -static -n -nostdlib
 KBUILD_AFLAGS_MODULE		+= -mlong-calls
 KBUILD_CFLAGS_MODULE		+= -mlong-calls
diff --git a/arch/mips/kernel/r2300_switch.S b/arch/mips/kernel/r2300_switch.S
index 20b7b04..f33bf8b 100644
--- a/arch/mips/kernel/r2300_switch.S
+++ b/arch/mips/kernel/r2300_switch.S
@@ -22,6 +22,7 @@
 #include <asm/asmmacro.h>
 
 	.set	mips1
+	.set	hardfloat
 	.align	5
 
 /*
diff --git a/arch/mips/kernel/r4k_fpu.S b/arch/mips/kernel/r4k_fpu.S
index 8352523..722962c 100644
--- a/arch/mips/kernel/r4k_fpu.S
+++ b/arch/mips/kernel/r4k_fpu.S
@@ -21,6 +21,7 @@
 
 	.macro	EX insn, reg, src
 	.set	push
+	.set	hardfloat
 	.set	nomacro
 .ex\@:	\insn	\reg, \src
 	.set	pop
diff --git a/arch/mips/kernel/r4k_switch.S b/arch/mips/kernel/r4k_switch.S
index 4c4ec18..5313b6f 100644
--- a/arch/mips/kernel/r4k_switch.S
+++ b/arch/mips/kernel/r4k_switch.S
@@ -34,6 +34,7 @@
  *		       struct thread_info *next_ti, s32 fp_save)
  */
 	.align	5
+	.set hardfloat
 	LEAF(resume)
 	mfc0	t1, CP0_STATUS
 	LONG_S	t1, THREAD_STATUS(a0)
diff --git a/arch/mips/kernel/r6000_fpu.S b/arch/mips/kernel/r6000_fpu.S
index da0fbe4..c13e3ff 100644
--- a/arch/mips/kernel/r6000_fpu.S
+++ b/arch/mips/kernel/r6000_fpu.S
@@ -17,6 +17,7 @@
 #include <asm/regdef.h>
 
 	.set	noreorder
+	.set	hardfloat
 	.set	mips2
 	/* Save floating point context */
 	LEAF(_save_fp_context)
-- 
2.0.4
