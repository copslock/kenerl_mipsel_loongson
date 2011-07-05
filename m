Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jul 2011 01:36:05 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:1495 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492026Ab1GEXf7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 Jul 2011 01:35:59 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4e13a0210000>; Tue, 05 Jul 2011 16:37:05 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 5 Jul 2011 16:35:57 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 5 Jul 2011 16:35:57 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id p65NZtDL001764;
        Tue, 5 Jul 2011 16:35:55 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id p65NZt9N001763;
        Tue, 5 Jul 2011 16:35:55 -0700
From:   David Daney <david.daney@cavium.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH] MIPS: Octeon: Enable C0_UserLocal probing.
Date:   Tue,  5 Jul 2011 16:35:53 -0700
Message-Id: <1309908953-1726-1-git-send-email-david.daney@cavium.com>
X-Mailer: git-send-email 1.7.2.3
X-OriginalArrivalTime: 05 Jul 2011 23:35:57.0684 (UTC) FILETIME=[4A5A4B40:01CC3B6C]
X-archive-position: 30585
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 3614

Octeon2 processor cores have a UserLocal register.  Remove the hard
coded negative probe and allow the standard probing to detect this
feature.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 .../asm/mach-cavium-octeon/cpu-feature-overrides.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h b/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
index 0d5a42b..a58addb 100644
--- a/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
@@ -54,7 +54,6 @@
 #define cpu_has_mips_r2_exec_hazard 0
 #define cpu_has_dsp		0
 #define cpu_has_mipsmt		0
-#define cpu_has_userlocal	0
 #define cpu_has_vint		0
 #define cpu_has_veic		0
 #define cpu_hwrena_impl_bits	0xc0000000
-- 
1.7.2.3
