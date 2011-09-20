Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Sep 2011 00:49:57 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:13449 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491861Ab1ITWtt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Sep 2011 00:49:49 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4e7918d40001>; Tue, 20 Sep 2011 15:51:00 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 20 Sep 2011 15:49:45 -0700
Received: from dd1.caveonetworks.com ([64.2.3.195]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 20 Sep 2011 15:49:45 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id p8KMnin9011560;
        Tue, 20 Sep 2011 15:49:44 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id p8KMngSj011559;
        Tue, 20 Sep 2011 15:49:43 -0700
From:   David Daney <david.daney@cavium.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH 1/2] MIPS: Add more CPU identifiers for Octeon II CPUs.
Date:   Tue, 20 Sep 2011 15:49:40 -0700
Message-Id: <1316558981-11526-1-git-send-email-david.daney@cavium.com>
X-Mailer: git-send-email 1.7.2.3
X-OriginalArrivalTime: 20 Sep 2011 22:49:45.0701 (UTC) FILETIME=[97EE0150:01CC77E7]
X-archive-position: 31112
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 11117

The CPU identifiers for cn68XX, cn66XX and cn61XX are known, so add
them.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/include/asm/cpu.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index 5f95a4b..2f7f418 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -135,6 +135,9 @@
 #define PRID_IMP_CAVIUM_CN50XX 0x0600
 #define PRID_IMP_CAVIUM_CN52XX 0x0700
 #define PRID_IMP_CAVIUM_CN63XX 0x9000
+#define PRID_IMP_CAVIUM_CN68XX 0x9100
+#define PRID_IMP_CAVIUM_CN66XX 0x9200
+#define PRID_IMP_CAVIUM_CN61XX 0x9300
 
 /*
  * These are the PRID's for when 23:16 == PRID_COMP_INGENIC
-- 
1.7.2.3
