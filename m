Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 26 Jun 2010 01:47:23 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:4150 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492391Ab0FYXq0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 26 Jun 2010 01:46:26 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4c253fe70000>; Fri, 25 Jun 2010 16:46:47 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 25 Jun 2010 16:46:24 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 25 Jun 2010 16:46:24 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.3/8.14.3) with ESMTP id o5PNkImh028972;
        Fri, 25 Jun 2010 16:46:18 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.3/8.14.3/Submit) id o5PNkIbR028971;
        Fri, 25 Jun 2010 16:46:18 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 2/2] MIPS: Octeon: Define ARCH_HAS_USABLE_BUILTIN_POPCOUNT for OCTEON.
Date:   Fri, 25 Jun 2010 16:46:08 -0700
Message-Id: <1277509568-28927-3-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.6.1
In-Reply-To: <1277509568-28927-1-git-send-email-ddaney@caviumnetworks.com>
References: <1277509568-28927-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 25 Jun 2010 23:46:24.0081 (UTC) FILETIME=[9ECEA410:01CB14C0]
X-archive-position: 27253
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 17738

OCTEON implements __builtin_popcount with a single instruction, so
lets use it.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 .../asm/mach-cavium-octeon/cpu-feature-overrides.h |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h b/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
index e412777..b952fc7 100644
--- a/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
@@ -66,6 +66,14 @@
 #define spin_lock_prefetch(x) prefetch(x)
 #define PREFETCH_STRIDE 128
 
+#ifdef __OCTEON__
+/*
+ * All gcc versions that have OCTEON support define __OCTEON__ and have the
+ *  __builtin_popcount support.
+ */
+#define ARCH_HAS_USABLE_BUILTIN_POPCOUNT 1
+#endif
+
 static inline int octeon_has_saa(void)
 {
 	int id;
-- 
1.6.6.1
