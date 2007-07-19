Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Jul 2007 08:11:04 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.174]:13934 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20022459AbXGSHLA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 19 Jul 2007 08:11:00 +0100
Received: by ug-out-1314.google.com with SMTP id u2so379634uge
        for <linux-mips@linux-mips.org>; Thu, 19 Jul 2007 00:10:59 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:x-enigmail-version:content-type:content-transfer-encoding:from;
        b=K9EM4GICseFsafUxisGWTWqFqAv1FdM1KT/oGdFj+FXXYgm5mMzDS3sx/f1msmGjuNEugHIkhvNlExQXy39G/TWthhmOGwKlP37TwQH09Mfk3h16FM0UGppmVbPqReWiKgQl4HnYjgQZPhHARnig6caCDP96yoPQbp2jMeWG6QI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:x-enigmail-version:content-type:content-transfer-encoding:from;
        b=bh5+8AnSd4brf1EVLnDi5nbGRa9RJe5wYXlvFMn/WWpKOyCcbx2v3MpD5WzVXmQVka/U2C7rdXMQBwNK2zIAML/XwMkoOgsQ5oUNNxFGcmO5Ps60DrkDqS1+tpEMotVGNmvOd3Lu5WWQ0Bk7gzLBTQRZGXQey1rmGXdbdl0sge4=
Received: by 10.86.86.12 with SMTP id j12mr1712949fgb.1184829059796;
        Thu, 19 Jul 2007 00:10:59 -0700 (PDT)
Received: from ?192.168.0.24? ( [81.252.61.1])
        by mx.google.com with ESMTPS id b17sm3718620fka.2007.07.19.00.10.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 19 Jul 2007 00:10:58 -0700 (PDT)
Message-ID: <469F0E5F.4050005@innova-card.com>
Date:	Thu, 19 Jul 2007 09:10:23 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips <linux-mips@linux-mips.org>
Subject: [RFC] User stack pointer randomisation
X-Enigmail-Version: 0.94.4.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15801
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

This patch adds a page size range randomisation to the user
stack pointer.

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---

  Hi Ralf,

 This is taken from the x86 architecture. I modified it a bit so the
 randomisation range is only a page size range. Since the top of the
 stack is already randomised, I don't see any point to make the range
 bigger as this is the case in x86 arch. I'm surely missing something
 obvious and that's the reason this patch is a RFC.

 I tested it and it works fine so far.

 Please try to have a look,

		Franck

 arch/mips/kernel/process.c |   13 +++++++++++++
 include/asm-mips/system.h  |    2 +-
 2 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 6bdfb5a..4f411fa 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -25,6 +25,7 @@
 #include <linux/init.h>
 #include <linux/completion.h>
 #include <linux/kallsyms.h>
+#include <linux/random.h>
 
 #include <asm/bootinfo.h>
 #include <asm/cpu.h>
@@ -460,3 +461,15 @@ unsigned long get_wchan(struct task_struct *task)
 out:
 	return pc;
 }
+
+/*
+ * Don't forget that the stack pointer must be aligned on a 8 bytes
+ * boundary at least.
+ */
+unsigned long arch_align_stack(unsigned long sp)
+{
+	if (!(current->personality & ADDR_NO_RANDOMIZE) && randomize_va_space)
+		sp -= get_random_int() & ~PAGE_MASK;
+
+	return sp & ~7;
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
