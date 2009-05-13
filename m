Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 May 2009 00:01:49 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:7634 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20026376AbZEMXAz (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 14 May 2009 00:00:55 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4a0b51170003>; Wed, 13 May 2009 19:00:39 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 13 May 2009 16:00:07 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 13 May 2009 16:00:07 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id n4DMxx8D014557;
	Wed, 13 May 2009 15:59:59 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id n4DMxulU014555;
	Wed, 13 May 2009 15:59:56 -0700
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 1/2] MIPS: Allow CPU specific overriding of CP0 hwrena impl bits.
Date:	Wed, 13 May 2009 15:59:55 -0700
Message-Id: <1242255596-14531-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
In-Reply-To: <4A0B5077.2010600@caviumnetworks.com>
References: <4A0B5077.2010600@caviumnetworks.com>
X-OriginalArrivalTime: 13 May 2009 23:00:07.0090 (UTC) FILETIME=[8F0D7120:01C9D41E]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22713
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Some CPUs have implementation dependent rdhwr registers.  Allow them
to be enabled on a per CPU basis.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/cpu-features.h |    4 ++++
 arch/mips/kernel/traps.c             |    2 +-
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index 1cba4b2..8ab1d12 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -234,4 +234,8 @@
 #define cpu_scache_line_size()	cpu_data[0].scache.linesz
 #endif
 
+#ifndef cpu_hwrena_impl_bits
+#define cpu_hwrena_impl_bits		0
+#endif
+
 #endif /* __ASM_CPU_FEATURES_H */
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index c3cc42e..efcb509 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1541,7 +1541,7 @@ void __cpuinit per_cpu_trap_init(void)
 			 status_set);
 
 	if (cpu_has_mips_r2) {
-		unsigned int enable = 0x0000000f;
+		unsigned int enable = 0x0000000f | cpu_hwrena_impl_bits;
 
 		if (!noulri && cpu_has_userlocal)
 			enable |= (1 << 29);
-- 
1.6.0.6
