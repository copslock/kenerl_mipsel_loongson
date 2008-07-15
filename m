Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jul 2008 14:06:29 +0100 (BST)
Received: from p549F7458.dip.t-dialin.net ([84.159.116.88]:40876 "EHLO
	p549F7458.dip.t-dialin.net") by ftp.linux-mips.org with ESMTP
	id S28580861AbYGPNG1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 16 Jul 2008 14:06:27 +0100
Received: from smtp.movial.fi ([62.236.91.34]:21925 "EHLO smtp.movial.fi")
	by lappi.linux-mips.net with ESMTP id S1097984AbYGOQ6F (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 15 Jul 2008 18:58:05 +0200
Received: from localhost (mailscanner.hel.movial.fi [172.17.81.9])
	by smtp.movial.fi (Postfix) with ESMTP id BF7E9C80FE;
	Tue, 15 Jul 2008 19:57:32 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at movial.fi
Received: from smtp.movial.fi ([62.236.91.34])
	by localhost (mailscanner.hel.movial.fi [172.17.81.9]) (amavisd-new, port 10026)
	with ESMTP id oimtF0fOkdI0; Tue, 15 Jul 2008 19:57:32 +0300 (EEST)
Received: from sd048.hel.movial.fi (sd048.hel.movial.fi [172.17.49.48])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.movial.fi (Postfix) with ESMTP id 5B6F1C80F6;
	Tue, 15 Jul 2008 19:57:32 +0300 (EEST)
Received: by sd048.hel.movial.fi (Postfix, from userid 30120)
	id 31854B403F; Tue, 15 Jul 2008 19:57:31 +0300 (EEST)
From:	Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
To:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] [MIPS] fix missing prototypes in asm/fpu.h
Date:	Tue, 15 Jul 2008 19:57:31 +0300
Message-Id: <1216141052-28005-3-git-send-email-dmitri.vorobiev@movial.fi>
X-Mailer: git-send-email 1.5.6
In-Reply-To: <1216141052-28005-1-git-send-email-dmitri.vorobiev@movial.fi>
References: <1216141052-28005-1-git-send-email-dmitri.vorobiev@movial.fi>
Return-Path: <dvorobye@movial.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19861
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@movial.fi
Precedence: bulk
X-list: linux-mips

While building the Malta defconfig, sparse spat the following
warnings:

>>>>>>>>>>>>>>>>>>
arch/mips/math-emu/kernel_linkage.c:31:6: warning: symbol
'fpu_emulator_init_fpu' was not declared. Should it be static?

arch/mips/math-emu/kernel_linkage.c:54:5: warning: symbol
'fpu_emulator_save_context' was not declared. Should it be
static?

arch/mips/math-emu/kernel_linkage.c:68:5: warning: symbol
'fpu_emulator_restore_context' was not declared. Should it be
static?
>>>>>>>>>>>>>>>>>>

This patch fixes these errors by adding the proper prototypes
to the include/asm-mips/fpu.h header, and actually using this
header in the sparse-spotted source file.

Build-tested with Malta defconfig.

Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
---
 arch/mips/math-emu/kernel_linkage.c |    1 +
 include/asm-mips/fpu.h              |    2 ++
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/mips/math-emu/kernel_linkage.c b/arch/mips/math-emu/kernel_linkage.c
index ed49ef0..52e6c58 100644
--- a/arch/mips/math-emu/kernel_linkage.c
+++ b/arch/mips/math-emu/kernel_linkage.c
@@ -24,6 +24,7 @@
 #include <asm/signal.h>
 #include <asm/uaccess.h>
 
+#include <asm/fpu.h>
 #include <asm/fpu_emulator.h>
 
 #define SIGNALLING_NAN 0x7ff800007ff80000LL
diff --git a/include/asm-mips/fpu.h b/include/asm-mips/fpu.h
index e59d4c0..8a3ef24 100644
--- a/include/asm-mips/fpu.h
+++ b/include/asm-mips/fpu.h
@@ -35,6 +35,8 @@ extern asmlinkage int (*save_fp_context32)(struct sigcontext32 __user *sc);
 extern asmlinkage int (*restore_fp_context32)(struct sigcontext32 __user *sc);
 
 extern void fpu_emulator_init_fpu(void);
+extern int fpu_emulator_save_context(struct sigcontext __user *sc);
+extern int fpu_emulator_restore_context(struct sigcontext __user *sc);
 extern void _init_fpu(void);
 extern void _save_fp(struct task_struct *);
 extern void _restore_fp(struct task_struct *);
-- 
1.5.6
