Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 May 2009 20:43:47 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:10272 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20025713AbZELTnR (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 12 May 2009 20:43:17 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4a09d1400000>; Tue, 12 May 2009 15:42:56 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 12 May 2009 12:42:00 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 12 May 2009 12:42:00 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id n4CJfuZX020745;
	Tue, 12 May 2009 12:41:56 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id n4CJftrR020743;
	Tue, 12 May 2009 12:41:55 -0700
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 1/3] MIPS: Allow R2 CPUs to turn off generation of 'ehb' instructions.
Date:	Tue, 12 May 2009 12:41:53 -0700
Message-Id: <1242157315-20719-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
In-Reply-To: <4A09D0B1.2030305@caviumnetworks.com>
References: <4A09D0B1.2030305@caviumnetworks.com>
X-OriginalArrivalTime: 12 May 2009 19:42:00.0098 (UTC) FILETIME=[B770A820:01C9D339]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22689
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Some CPUs do not need ehb instructions after writing CP0 registers.
By allowing ehb generation to be overridden in
cpu-feature-overrides.h, we can save a few instructions in the TLB
handler hot paths.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/cpu-features.h |    4 ++++
 arch/mips/mm/tlbex.c                 |    3 ++-
 2 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index c0047f8..1cba4b2 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -147,6 +147,10 @@
 #define cpu_has_mips_r	(cpu_has_mips32r1 | cpu_has_mips32r2 | \
 			 cpu_has_mips64r1 | cpu_has_mips64r2)
 
+#ifndef cpu_has_mips_r2_exec_hazard
+#define cpu_has_mips_r2_exec_hazard cpu_has_mips_r2
+#endif
+
 /*
  * MIPS32, MIPS64, VR5500, IDT32332, IDT32334 and maybe a few other
  * pre-MIPS32/MIPS53 processors have CLO, CLZ.  For 64-bit kernels
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 3548acf..4108674 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -258,7 +258,8 @@ static void __cpuinit build_tlb_write_entry(u32 **p, struct uasm_label **l,
 	}
 
 	if (cpu_has_mips_r2) {
-		uasm_i_ehb(p);
+		if (cpu_has_mips_r2_exec_hazard)
+			uasm_i_ehb(p);
 		tlbw(p);
 		return;
 	}
-- 
1.6.0.6
