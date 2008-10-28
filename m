Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Oct 2008 00:09:38 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:57364 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S22533327AbYJ1AE5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 28 Oct 2008 00:04:57 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B490656f6000a>; Mon, 27 Oct 2008 20:04:07 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 27 Oct 2008 17:03:10 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 27 Oct 2008 17:03:10 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id m9S035Au003288;
	Mon, 27 Oct 2008 17:03:05 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id m9S035Xv003287;
	Mon, 27 Oct 2008 17:03:05 -0700
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Subject: [PATCH 11/36] MIPSR2 ebase isn't just CAC_BASE
Date:	Mon, 27 Oct 2008 17:02:43 -0700
Message-Id: <1225152181-3221-11-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1225152181-3221-10-git-send-email-ddaney@caviumnetworks.com>
References: <490655B6.4030406@caviumnetworks.com>
 <1225152181-3221-1-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-2-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-3-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-4-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-5-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-6-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-7-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-8-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-9-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-10-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 28 Oct 2008 00:03:10.0116 (UTC) FILETIME=[901EE640:01C93890]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21021
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On mips{32,64}r2, the ebase isn't just CAC_BASE, but also the part of
read_c0_ebase() too.

Signed-off-by: Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/cpu-features.h |    4 ++++
 arch/mips/kernel/traps.c             |   11 +++++++----
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index 5ea701f..1d0cf0a 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -101,6 +101,10 @@
 #ifndef cpu_has_pindexed_dcache
 #define cpu_has_pindexed_dcache	(cpu_data[0].dcache.flags & MIPS_CACHE_PINDEX)
 #endif
+#ifndef cpu_has_ebase
+#define cpu_has_ebase		(cpu_data[0].isa_level == MIPS_CPU_ISA_M32R2 \
+				 || cpu_data[0].isa_level == MIPS_CPU_ISA_M64R2)
+#endif
 
 /*
  * I-Cache snoops remote store.  This only matters on SMP.  Some multiprocessors
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 8e40795..cfec89c 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1609,8 +1609,11 @@ void __init trap_init(void)
 
 	if (cpu_has_veic || cpu_has_vint)
 		ebase = (unsigned long) alloc_bootmem_low_pages(0x200 + VECTORSPACING*64);
-	else
+	else {
 		ebase = CAC_BASE;
+		if (cpu_has_ebase)
+			ebase += read_c0_ebase() & 0x3ffff000;
+	}
 
 	per_cpu_trap_init();
 
@@ -1718,11 +1721,11 @@ void __init trap_init(void)
 
 	if (cpu_has_vce)
 		/* Special exception: R4[04]00 uses also the divec space. */
-		memcpy((void *)(CAC_BASE + 0x180), &except_vec3_r4000, 0x100);
+		memcpy((void *)(ebase + 0x180), &except_vec3_r4000, 0x100);
 	else if (cpu_has_4kex)
-		memcpy((void *)(CAC_BASE + 0x180), &except_vec3_generic, 0x80);
+		memcpy((void *)(ebase + 0x180), &except_vec3_generic, 0x80);
 	else
-		memcpy((void *)(CAC_BASE + 0x080), &except_vec3_generic, 0x80);
+		memcpy((void *)(ebase + 0x080), &except_vec3_generic, 0x80);
 
 	signal_init();
 #ifdef CONFIG_MIPS32_COMPAT
-- 
1.5.6.5
