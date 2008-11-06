Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Nov 2008 20:58:41 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:47514 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S23298205AbYKFUza (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 6 Nov 2008 20:55:30 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4913599e0001>; Thu, 06 Nov 2008 15:54:54 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 6 Nov 2008 12:54:54 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 6 Nov 2008 12:54:54 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id mA6KsnJ9027720;
	Thu, 6 Nov 2008 12:54:49 -0800
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id mA6KsnWu027719;
	Thu, 6 Nov 2008 12:54:49 -0800
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 11/29] MIPS: Override assembler target architecture for octeon.
Date:	Thu,  6 Nov 2008 12:54:24 -0800
Message-Id: <1226004875-27654-11-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <491358F5.7040002@caviumnetworks.com>
References: <491358F5.7040002@caviumnetworks.com>
X-OriginalArrivalTime: 06 Nov 2008 20:54:54.0089 (UTC) FILETIME=[EB4B7790:01C94051]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21205
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
