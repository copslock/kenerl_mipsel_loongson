Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Sep 2010 00:39:43 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:5477 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491167Ab0IWWid (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 24 Sep 2010 00:38:33 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4c9bd7080000>; Thu, 23 Sep 2010 15:39:04 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 23 Sep 2010 15:38:31 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 23 Sep 2010 15:38:31 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id o8NMcQ56024750;
        Thu, 23 Sep 2010 15:38:26 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id o8NMcPfM024749;
        Thu, 23 Sep 2010 15:38:25 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 3/9] MIPS: Octeon: Adjust top of DMA32 zone.
Date:   Thu, 23 Sep 2010 15:38:10 -0700
Message-Id: <1285281496-24696-4-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.2
In-Reply-To: <1285281496-24696-1-git-send-email-ddaney@caviumnetworks.com>
References: <1285281496-24696-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 23 Sep 2010 22:38:31.0706 (UTC) FILETIME=[0CA907A0:01CB5B70]
X-archive-position: 27808
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 18814

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
