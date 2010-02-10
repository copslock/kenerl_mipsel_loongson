Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Feb 2010 00:15:54 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:15985 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492382Ab0BJXNx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Feb 2010 00:13:53 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4b733db60003>; Wed, 10 Feb 2010 15:13:58 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 10 Feb 2010 15:12:54 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 10 Feb 2010 15:12:54 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.3/8.14.2) with ESMTP id o1ANCoTU005843;
        Wed, 10 Feb 2010 15:12:50 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.3/8.14.3/Submit) id o1ANCogO005842;
        Wed, 10 Feb 2010 15:12:50 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 6/6] MIPS: Enable Read Inhibit/eXecute Inhibit for Octeon+ CPUs
Date:   Wed, 10 Feb 2010 15:12:49 -0800
Message-Id: <1265843569-5786-6-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.2.5
In-Reply-To: <4B733C71.8030304@caviumnetworks.com>
References: <4B733C71.8030304@caviumnetworks.com>
X-OriginalArrivalTime: 10 Feb 2010 23:12:54.0910 (UTC) FILETIME=[937B39E0:01CAAAA6]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25909
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 .../asm/mach-cavium-octeon/cpu-feature-overrides.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h b/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
index 425e708..bbf0540 100644
--- a/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
@@ -58,6 +58,9 @@
 #define cpu_has_vint		0
 #define cpu_has_veic		0
 #define cpu_hwrena_impl_bits	0xc0000000
+
+#define kernel_uses_smartmips_rixi (cpu_data[0].cputype == CPU_CAVIUM_OCTEON_PLUS)
+
 #define ARCH_HAS_READ_CURRENT_TIMER 1
 #define ARCH_HAS_IRQ_PER_CPU	1
 #define ARCH_HAS_SPINLOCK_PREFETCH 1
-- 
1.6.2.5
