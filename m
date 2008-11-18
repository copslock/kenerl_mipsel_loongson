Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Nov 2008 22:26:07 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:12334 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S23754598AbYKRWYC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 18 Nov 2008 22:24:02 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4923406e0006>; Tue, 18 Nov 2008 17:23:42 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 18 Nov 2008 14:23:40 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 18 Nov 2008 14:23:40 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id mAIMNZtn004834;
	Tue, 18 Nov 2008 14:23:35 -0800
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id mAIMNZkn004833;
	Tue, 18 Nov 2008 14:23:35 -0800
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 07/26] MIPS: Override assembler target architecture for octeon.
Date:	Tue, 18 Nov 2008 14:23:22 -0800
Message-Id: <1227047013-4785-7-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <49233FDE.3010404@caviumnetworks.com>
References: <49233FDE.3010404@caviumnetworks.com>
X-OriginalArrivalTime: 18 Nov 2008 22:23:40.0300 (UTC) FILETIME=[4EEBC4C0:01C949CC]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21309
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
