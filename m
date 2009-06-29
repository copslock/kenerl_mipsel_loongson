Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Jun 2009 19:00:06 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:4537 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493064AbZF2Q77 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 29 Jun 2009 18:59:59 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4a48f1d80000>; Mon, 29 Jun 2009 12:54:53 -0400
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 29 Jun 2009 09:54:20 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 29 Jun 2009 09:54:20 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id n5TGsF4R026892;
	Mon, 29 Jun 2009 09:54:15 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id n5TGsFtp026890;
	Mon, 29 Jun 2009 09:54:15 -0700
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Define  __arch_swab64 for all mips r2 cpus (v2).
Date:	Mon, 29 Jun 2009 09:54:15 -0700
Message-Id: <1246294455-26866-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
X-OriginalArrivalTime: 29 Jun 2009 16:54:20.0281 (UTC) FILETIME=[3F266690:01C9F8DA]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23535
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Some CPUs implement mipsr2, but because they are a super-set of
mips64r2 do not define CONFIG_CPU_MIPS64_R2.  Cavium OCTEON falls into
this category.  We would still like to use the optimized
implementation, so since we have already checked for
CONFIG_CPU_MIPSR2, checking for CONFIG_64BIT instead of
CONFIG_CPU_MIPS64_R2 is sufficient.

Change from v1: Add comments about why the change is safe.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/swab.h |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/swab.h b/arch/mips/include/asm/swab.h
index 99993c0..97c2f81 100644
--- a/arch/mips/include/asm/swab.h
+++ b/arch/mips/include/asm/swab.h
@@ -38,7 +38,11 @@ static inline __attribute_const__ __u32 __arch_swab32(__u32 x)
 }
 #define __arch_swab32 __arch_swab32
 
-#ifdef CONFIG_CPU_MIPS64_R2
+/*
+ * Having already checked for CONFIG_CPU_MIPSR2, enable the
+ * optimized version for 64-bit kernel on r2 CPUs.
+ */
+#ifdef CONFIG_64BIT
 static inline __attribute_const__ __u64 __arch_swab64(__u64 x)
 {
 	__asm__(
@@ -50,6 +54,6 @@ static inline __attribute_const__ __u64 __arch_swab64(__u64 x)
 	return x;
 }
 #define __arch_swab64 __arch_swab64
-#endif /* CONFIG_CPU_MIPS64_R2 */
+#endif /* CONFIG_64BIT */
 #endif /* CONFIG_CPU_MIPSR2 */
 #endif /* _ASM_SWAB_H */
-- 
1.6.0.6
