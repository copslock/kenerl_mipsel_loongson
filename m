Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Feb 2009 19:15:08 +0000 (GMT)
Received: from smtp2.caviumnetworks.com ([209.113.159.134]:55602 "EHLO
	smtp2.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S20021772AbZBXTPG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 24 Feb 2009 19:15:06 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by smtp2.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B49a447380000>; Tue, 24 Feb 2009 14:15:04 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 24 Feb 2009 11:14:42 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 24 Feb 2009 11:14:41 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id n1OJEdmn026685;
	Tue, 24 Feb 2009 11:14:39 -0800
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id n1OJEc4g026683;
	Tue, 24 Feb 2009 11:14:38 -0800
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Revert 25c3000300163e2ebf68d94425088de35ead3d76
Date:	Tue, 24 Feb 2009 11:14:38 -0800
Message-Id: <1235502878-26660-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.6.6
X-OriginalArrivalTime: 24 Feb 2009 19:14:41.0974 (UTC) FILETIME=[253C0560:01C996B4]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21963
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Commit 25c3000300163e2ebf68d94425088de35ead3d76 added an ugly work
around for a bug in binutils 2.19 that was needed for Cavium Octeon
processor support.  Now binutils 2.19.1 have been released and the
work around is no longer necessary.

Since Cavium Octeon processor support has not yet been part of any
official kernel release, there is no need to maintain compatibility
with older toolchains.  We can simply say that only binutils 2.19.1 or
later is supported (instead of 2.19 or later as it was before).

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/mipsregs.h |    2 --
 arch/mips/kernel/genex.S         |    4 ----
 2 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 0417516..207d098 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -1028,8 +1028,6 @@ do {									\
 	__asm__ __volatile__(                                   \
 	".set\tpush\n\t"					\
 	".set\treorder\n\t"					\
-	/* gas fails to assemble cfc1 for some archs (octeon).*/ \
-	".set\tmips1\n\t"					\
         "cfc1\t%0,"STR(source)"\n\t"                            \
 	".set\tpop"						\
         : "=r" (__res));                                        \
diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
index 8882e57..4d49322 100644
--- a/arch/mips/kernel/genex.S
+++ b/arch/mips/kernel/genex.S
@@ -385,14 +385,10 @@ NESTED(nmi_handler, PT_SIZE, sp)
 	.endm
 
 	.macro	__build_clear_fpe
-	.set	push
-	/* gas fails to assemble cfc1 for some archs (octeon).*/ \
-	.set	mips1
 	cfc1	a1, fcr31
 	li	a2, ~(0x3f << 12)
 	and	a2, a1
 	ctc1	a2, fcr31
-	.set	pop
 	TRACE_IRQS_ON
 	STI
 	.endm
-- 
1.5.6.6
