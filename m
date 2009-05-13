Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 May 2009 00:01:25 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:7638 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20026374AbZEMXAz (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 14 May 2009 00:00:55 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4a0b51170007>; Wed, 13 May 2009 19:00:39 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 13 May 2009 16:00:09 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 13 May 2009 16:00:09 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id n4DN04cD014561;
	Wed, 13 May 2009 16:00:04 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id n4DN02oN014560;
	Wed, 13 May 2009 16:00:02 -0700
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 2/2] MIPS: Move Cavium CP0 hwrena impl bits to cpu-feature-overrides.h
Date:	Wed, 13 May 2009 15:59:56 -0700
Message-Id: <1242255596-14531-2-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
In-Reply-To: <4A0B5077.2010600@caviumnetworks.com>
References: <4A0B5077.2010600@caviumnetworks.com>
X-OriginalArrivalTime: 13 May 2009 23:00:09.0090 (UTC) FILETIME=[903E9E20:01C9D41E]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22712
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

We had an ugly #ifdef for Cavium Octeon hwrena bits in traps.c, remove
it to mach-cavium-octeon/cpu-feature-overrides.h

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 .../asm/mach-cavium-octeon/cpu-feature-overrides.h |    1 +
 arch/mips/kernel/traps.c                           |    4 ----
 2 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h b/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
index bb291f4..3d83075 100644
--- a/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
@@ -53,6 +53,7 @@
 #define cpu_has_userlocal	0
 #define cpu_has_vint		0
 #define cpu_has_veic		0
+#define cpu_hwrena_impl_bits	0xc0000000
 #define ARCH_HAS_READ_CURRENT_TIMER 1
 #define ARCH_HAS_IRQ_PER_CPU	1
 #define ARCH_HAS_SPINLOCK_PREFETCH 1
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index efcb509..295a584 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1549,10 +1549,6 @@ void __cpuinit per_cpu_trap_init(void)
 		write_c0_hwrena(enable);
 	}
 
-#ifdef CONFIG_CPU_CAVIUM_OCTEON
-	write_c0_hwrena(0xc000000f); /* Octeon has register 30 and 31 */
-#endif
-
 #ifdef CONFIG_MIPS_MT_SMTC
 	if (!secondaryTC) {
 #endif /* CONFIG_MIPS_MT_SMTC */
-- 
1.6.0.6
