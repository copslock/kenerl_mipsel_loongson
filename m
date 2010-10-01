Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Oct 2010 22:29:03 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:8589 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492022Ab0JAU1v (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 Oct 2010 22:27:51 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4ca644660000>; Fri, 01 Oct 2010 13:28:22 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 1 Oct 2010 13:27:51 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 1 Oct 2010 13:27:51 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id o91KRiPM028712;
        Fri, 1 Oct 2010 13:27:44 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id o91KRhVM028711;
        Fri, 1 Oct 2010 13:27:43 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 3/8] MIPS: Octeon: Adjust top of DMA32 zone.
Date:   Fri,  1 Oct 2010 13:27:29 -0700
Message-Id: <1285964854-28659-4-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.2
In-Reply-To: <1285964854-28659-1-git-send-email-ddaney@caviumnetworks.com>
References: <1285964854-28659-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 01 Oct 2010 20:27:51.0892 (UTC) FILETIME=[1F125940:01CB61A7]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27917
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On OCTEON, we reserve the last 256MB of 32-bit PCI address space,
mapping the RAM in this region at a high DMA address.  This makes
memory in this region unavailable for 32-bit DMA.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 .../asm/mach-cavium-octeon/cpu-feature-overrides.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h b/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
index b952fc7..c84ed74 100644
--- a/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
@@ -81,4 +81,10 @@ static inline int octeon_has_saa(void)
 	return id >= 0x000d0300;
 }
 
+/*
+ * The last 256MB are reserved for device to device mappings and the
+ * BAR1 hole.
+ */
+#define MAX_DMA32_PFN (((1ULL << 32) - (1ULL << 28)) >> PAGE_SHIFT)
+
 #endif
-- 
1.7.2.2
