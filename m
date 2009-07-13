Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jul 2009 20:15:48 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:64295 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492470AbZGMSPm (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 13 Jul 2009 20:15:42 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4a5b79bd0000>; Mon, 13 Jul 2009 14:15:25 -0400
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 13 Jul 2009 11:15:24 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 13 Jul 2009 11:15:24 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id n6DIFLZf029183;
	Mon, 13 Jul 2009 11:15:21 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id n6DIFLGg029182;
	Mon, 13 Jul 2009 11:15:21 -0700
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 2/2] MIPS: Octeon: Set kernel_uses_llsc to false on non-SMP builds.
Date:	Mon, 13 Jul 2009 11:15:20 -0700
Message-Id: <1247508920-29153-2-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
In-Reply-To: <1247508920-29153-1-git-send-email-ddaney@caviumnetworks.com>
References: <1247508920-29153-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 13 Jul 2009 18:15:24.0467 (UTC) FILETIME=[E436C830:01CA03E5]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23735
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 .../asm/mach-cavium-octeon/cpu-feature-overrides.h |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h b/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
index 3d83075..425e708 100644
--- a/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
@@ -31,12 +31,16 @@
 #define cpu_has_cache_cdex_s	0
 #define cpu_has_prefetch	1
 
+#define cpu_has_llsc		1
 /*
- * We should disable LL/SC on non SMP systems as it is faster to
- * disable interrupts for atomic access than a LL/SC.  Unfortunatly we
- * cannot as this breaks asm/futex.h
+ * We Disable LL/SC on non SMP systems as it is faster to disable
+ * interrupts for atomic access than a LL/SC.
  */
-#define cpu_has_llsc		1
+#ifdef CONFIG_SMP
+# define kernel_uses_llsc	1
+#else
+# define kernel_uses_llsc	0
+#endif
 #define cpu_has_vtag_icache	1
 #define cpu_has_dc_aliases	0
 #define cpu_has_ic_fills_f_dc	0
-- 
1.6.0.6
