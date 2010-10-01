Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Oct 2010 22:28:39 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:8587 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492021Ab0JAU1u (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 Oct 2010 22:27:50 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4ca644650001>; Fri, 01 Oct 2010 13:28:21 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 1 Oct 2010 13:27:51 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 1 Oct 2010 13:27:51 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id o91KRhKs028708;
        Fri, 1 Oct 2010 13:27:43 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id o91KRhEK028707;
        Fri, 1 Oct 2010 13:27:43 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 2/8] MIPS: Allow MAX_DMA32_PFN to be overridden.
Date:   Fri,  1 Oct 2010 13:27:28 -0700
Message-Id: <1285964854-28659-3-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.2
In-Reply-To: <1285964854-28659-1-git-send-email-ddaney@caviumnetworks.com>
References: <1285964854-28659-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 01 Oct 2010 20:27:51.0329 (UTC) FILETIME=[1EBC7110:01CB61A7]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27916
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

DMA mapping may reduce the usable physical address range usable for
32-bit DMA.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/dma.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/dma.h b/arch/mips/include/asm/dma.h
index 1353c81..2d47da6 100644
--- a/arch/mips/include/asm/dma.h
+++ b/arch/mips/include/asm/dma.h
@@ -91,7 +91,10 @@
 #define MAX_DMA_ADDRESS		(PAGE_OFFSET + 0x01000000)
 #endif
 #define MAX_DMA_PFN		PFN_DOWN(virt_to_phys((void *)MAX_DMA_ADDRESS))
+
+#ifndef MAX_DMA32_PFN
 #define MAX_DMA32_PFN		(1UL << (32 - PAGE_SHIFT))
+#endif
 
 /* 8237 DMA controllers */
 #define IO_DMA1_BASE	0x00	/* 8 bit slave DMA, channels 0..3 */
-- 
1.7.2.2
