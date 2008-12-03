Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Dec 2008 23:50:03 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:36503 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S24087256AbYLCXpc (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 3 Dec 2008 23:45:32 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B493719e80005>; Wed, 03 Dec 2008 18:44:40 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 3 Dec 2008 15:44:39 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 3 Dec 2008 15:44:39 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id mB3NiYdb015646;
	Wed, 3 Dec 2008 15:44:34 -0800
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id mB3NiYn9015645;
	Wed, 3 Dec 2008 15:44:34 -0800
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Subject: [PATCH 15/21] MIPS: Cavium OCTEON multiplier state preservation.
Date:	Wed,  3 Dec 2008 15:44:25 -0800
Message-Id: <1228347871-15563-15-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <493718EA.40703@caviumnetworks.com>
References: <493718EA.40703@caviumnetworks.com>
X-OriginalArrivalTime: 03 Dec 2008 23:44:39.0430 (UTC) FILETIME=[1B626A60:01C955A1]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21518
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

For OCTEON, implement a save and restore of the multiplier state
across context switches.

Signed-off-by: Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/stackframe.h |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/stackframe.h b/arch/mips/include/asm/stackframe.h
index 4c37c4e..db0fa7b 100644
--- a/arch/mips/include/asm/stackframe.h
+++ b/arch/mips/include/asm/stackframe.h
@@ -194,6 +194,19 @@
 		LONG_S	$31, PT_R31(sp)
 		ori	$28, sp, _THREAD_MASK
 		xori	$28, _THREAD_MASK
+#ifdef CONFIG_CPU_CAVIUM_OCTEON
+		.set    mips64
+		pref    0, 0($28)       /* Prefetch the current pointer */
+		pref    0, PT_R31(sp)   /* Prefetch the $31(ra) */
+		/* The Octeon multiplier state is affected by general multiply
+		    instructions. It must be saved before and kernel code might
+		    corrupt it */
+		jal     octeon_mult_save
+		LONG_L  v1, 0($28)  /* Load the current pointer */
+			 /* Restore $31(ra) that was changed by the jal */
+		LONG_L  ra, PT_R31(sp)
+		pref    0, 0(v1)    /* Prefetch the current thread */
+#endif
 		.set	pop
 		.endm
 
@@ -324,6 +337,10 @@
 		DVPE	5				# dvpe a1
 		jal	mips_ihb
 #endif /* CONFIG_MIPS_MT_SMTC */
+#ifdef CONFIG_CPU_CAVIUM_OCTEON
+		/* Restore the Octeon multiplier state */
+		jal	octeon_mult_restore
+#endif
 		mfc0	a0, CP0_STATUS
 		ori	a0, STATMASK
 		xori	a0, STATMASK
-- 
1.5.6.5
