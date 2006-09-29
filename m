Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Sep 2006 10:08:11 +0100 (BST)
Received: from py-out-1112.google.com ([64.233.166.177]:39778 "EHLO
	py-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20038434AbWI2JIK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 29 Sep 2006 10:08:10 +0100
Received: by py-out-1112.google.com with SMTP id i49so949440pyi
        for <linux-mips@linux-mips.org>; Fri, 29 Sep 2006 02:08:08 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding:from;
        b=fIZjs0e55e89rzrvV9HdZfbiypR2dO6YN/M7rdu/FsoYT/s/ZVwvq+lyMmSaF1Inw8EUV98HDyQFPpwvOLBddV7l5RpkpATdakuZbz9xX4BcwL0DA1Ap5rWKMD4qM3zeyr/Xe0tWGdVIkcxzjPqiDnHB5l7OABDFpqSW/EpCAe8=
Received: by 10.65.112.5 with SMTP id p5mr3314490qbm;
        Fri, 29 Sep 2006 02:08:08 -0700 (PDT)
Received: from ?192.168.0.24? ( [81.252.61.1])
        by mx.gmail.com with ESMTP id e16sm3193464qbe.2006.09.29.02.08.07;
        Fri, 29 Sep 2006 02:08:08 -0700 (PDT)
Message-ID: <451CE2AB.70907@innova-card.com>
Date:	Fri, 29 Sep 2006 11:08:59 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips@linux-mips.org
Subject: [PATCH] Let gcc align 'struct pt_regs' on 8 bytes boundary
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12729
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

From: Franck Bui-Huu <fbuihuu@gmail.com>

The stack pointer in MIPS/gcc should always 8 bytes aligned on
entry to any routines. Therefore pt_regs structure must be
aligned to 8-byte boundary too.

Instead of creating dummy fields to achieve this alignment, this
patch let gcc doing it. Therefore 'smtc_pad' field can be safely
removed.

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 include/asm-mips/ptrace.h |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/include/asm-mips/ptrace.h b/include/asm-mips/ptrace.h
index 4fb0fc4..5f3a907 100644
--- a/include/asm-mips/ptrace.h
+++ b/include/asm-mips/ptrace.h
@@ -44,9 +44,8 @@ #endif
 	unsigned long cp0_epc;
 #ifdef CONFIG_MIPS_MT_SMTC
 	unsigned long cp0_tcstatus;
-	unsigned long smtc_pad;
 #endif /* CONFIG_MIPS_MT_SMTC */
-};
+} __attribute__ ((aligned (8)));
 
 /* Arbitrarily choose the same ptrace numbers as used by the Sparc code. */
 #define PTRACE_GETREGS		12
-- 
1.4.2.1
