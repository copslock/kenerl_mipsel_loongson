Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Dec 2008 23:42:36 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:11051 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S24207787AbYLKXkT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 11 Dec 2008 23:40:19 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4941a3970000>; Thu, 11 Dec 2008 18:34:52 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 11 Dec 2008 15:33:49 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 11 Dec 2008 15:33:48 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id mBBNXiEQ031883;
	Thu, 11 Dec 2008 15:33:44 -0800
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id mBBNXhlC031882;
	Thu, 11 Dec 2008 15:33:43 -0800
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 07/20] MIPS: Override assembler target architecture for octeon.
Date:	Thu, 11 Dec 2008 15:33:25 -0800
Message-Id: <1229038418-31833-7-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <4941A2F5.1010202@caviumnetworks.com>
References: <4941A2F5.1010202@caviumnetworks.com>
X-OriginalArrivalTime: 11 Dec 2008 23:33:48.0911 (UTC) FILETIME=[EAF317F0:01C95BE8]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21592
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Gas from binutils 2.19 fails to compile some cop1 instructions with
-march=octeon.  Since the cop1 instructions are present in mips1, use
that arch instead.  This will be fixed in binutils 2.20.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/mipsregs.h |    2 ++
 arch/mips/kernel/genex.S         |    4 ++++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 207d098..0417516 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -1028,6 +1028,8 @@ do {									\
 	__asm__ __volatile__(                                   \
 	".set\tpush\n\t"					\
 	".set\treorder\n\t"					\
+	/* gas fails to assemble cfc1 for some archs (octeon).*/ \
+	".set\tmips1\n\t"					\
         "cfc1\t%0,"STR(source)"\n\t"                            \
 	".set\tpop"						\
         : "=r" (__res));                                        \
diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
index 757d48f..fb6f731 100644
--- a/arch/mips/kernel/genex.S
+++ b/arch/mips/kernel/genex.S
@@ -385,10 +385,14 @@ NESTED(nmi_handler, PT_SIZE, sp)
 	.endm
 
 	.macro	__build_clear_fpe
+	.set	push
+	/* gas fails to assemble cfc1 for some archs (octeon).*/ \
+	.set	mips1
 	cfc1	a1, fcr31
 	li	a2, ~(0x3f << 12)
 	and	a2, a1
 	ctc1	a2, fcr31
+	.set	pop
 	TRACE_IRQS_ON
 	STI
 	.endm
-- 
1.5.6.5
