Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Jul 2007 13:04:54 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.171]:36903 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20022562AbXGSMEw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 19 Jul 2007 13:04:52 +0100
Received: by ug-out-1314.google.com with SMTP id u2so416144uge
        for <linux-mips@linux-mips.org>; Thu, 19 Jul 2007 05:04:51 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:x-enigmail-version:content-type:content-transfer-encoding:from;
        b=UKWo6bCz0EXUrlOTuHLpuSIZGBoqNI26CvpD2+D3acXxKmHDCYC4DjdFGQYaF1BokU33z+t1HlzMWnFR3OOs4ynDuOGjjQt388bFmDIboFUFD51zLgKbLpfKp1TMkB/37cTSwEEBIkuuvPEPf6gIao/YZKsYjlyV9pjGBTy03sM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:x-enigmail-version:content-type:content-transfer-encoding:from;
        b=F9zW5QnQlwR+gmHHYnEqtTZVNTwUXw8hhNnc019ocY3FF8bjA19/riZXxihedAxXOkEdudsdL2/5Kp9NOWwg4EBKoAbisUxdHZYXdR/UNojUD6X8quSq3YSrWgZbHukbtt7TfBQPFz/a9Xpx3FEYXZV26HpWCxl8UPPgvmlqevE=
Received: by 10.86.79.19 with SMTP id c19mr1876429fgb.1184846691233;
        Thu, 19 Jul 2007 05:04:51 -0700 (PDT)
Received: from ?192.168.0.24? ( [81.252.61.1])
        by mx.google.com with ESMTPS id 31sm4293823fkt.2007.07.19.05.04.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 19 Jul 2007 05:04:50 -0700 (PDT)
Message-ID: <469F5345.5010209@innova-card.com>
Date:	Thu, 19 Jul 2007 14:04:21 +0200
Reply-To: franck.bui-huu@innova-card.com
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	nigel@mips.com, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] User stack pointer randomisation
X-Enigmail-Version: 0.94.4.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15807
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

From: Franck Bui-Huu <fbuihuu@gmail.com>

This patch adds a page size range randomisation to the user
stack pointer.

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---

  Hi Ralf,

 This is taken from the x86 architecture. I modified it a bit so the
 randomisation range is only a page size range. Since the top of the
 stack is already randomised, I don't see any point to make the range
 bigger as this is the case in x86 arch.

 I tested it and it works fine so far.

 Please try to have a look,

		Franck

 arch/mips/kernel/process.c |   14 ++++++++++++++
 include/asm-mips/system.h  |    2 +-
 2 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 6bdfb5a..42a60b4 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -25,7 +25,9 @@
 #include <linux/init.h>
 #include <linux/completion.h>
 #include <linux/kallsyms.h>
+#include <linux/random.h>
 
+#include <asm/asm.h>
 #include <asm/bootinfo.h>
 #include <asm/cpu.h>
 #include <asm/dsp.h>
@@ -460,3 +462,15 @@ unsigned long get_wchan(struct task_struct *task)
 out:
 	return pc;
 }
+
+/*
+ * Don't forget that the stack pointer must be aligned on a 8 bytes
+ * boundary for 32-bits ABI and 16 bytes for 64-bits ABI.
+ */
+unsigned long arch_align_stack(unsigned long sp)
+{
+	if (!(current->personality & ADDR_NO_RANDOMIZE) && randomize_va_space)
+		sp -= get_random_int() & ~PAGE_MASK;
+
+	return sp & ALMASK;
+}
diff --git a/include/asm-mips/system.h b/include/asm-mips/system.h
index 2908870..0cfb6e1 100644
--- a/include/asm-mips/system.h
+++ b/include/asm-mips/system.h
@@ -355,6 +355,6 @@ extern int stop_a_enabled;
  */
 #define __ARCH_WANT_UNLOCKED_CTXSW
 
-#define arch_align_stack(x) (x)
+extern unsigned long arch_align_stack(unsigned long sp);
 
 #endif /* _ASM_SYSTEM_H */
-- 
1.5.2.2
