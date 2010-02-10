Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Feb 2010 00:13:53 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:15978 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492360Ab0BJXNu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Feb 2010 00:13:50 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4b733db50001>; Wed, 10 Feb 2010 15:13:57 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 10 Feb 2010 15:12:52 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 10 Feb 2010 15:12:52 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.3/8.14.2) with ESMTP id o1ANCncl005827;
        Wed, 10 Feb 2010 15:12:49 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.3/8.14.3/Submit) id o1ANCn3R005826;
        Wed, 10 Feb 2010 15:12:49 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 2/6] MIPS: Add accessor functions and bit definitions for c0_PageGrain
Date:   Wed, 10 Feb 2010 15:12:45 -0800
Message-Id: <1265843569-5786-2-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.2.5
In-Reply-To: <4B733C71.8030304@caviumnetworks.com>
References: <4B733C71.8030304@caviumnetworks.com>
X-OriginalArrivalTime: 10 Feb 2010 23:12:52.0410 (UTC) FILETIME=[91FDC1A0:01CAAAA6]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25904
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/mipsregs.h |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index b30819c..9893758 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -251,6 +251,14 @@
 #define PL_256M		28
 
 /*
+ * PageGrain bits
+ */
+#define PG_RIE		(_ULCAST_(1) <<  31)
+#define PG_XIE		(_ULCAST_(1) <<  30)
+#define PG_ELPA		(_ULCAST_(1) <<  29)
+#define PG_ESP		(_ULCAST_(1) <<  28)
+
+/*
  * R4x00 interrupt enable / cause bits
  */
 #define IE_SW0          (_ULCAST_(1) <<  8)
@@ -840,6 +848,9 @@ do {									\
 #define read_c0_pagemask()	__read_32bit_c0_register($5, 0)
 #define write_c0_pagemask(val)	__write_32bit_c0_register($5, 0, val)
 
+#define read_c0_pagegrain()	__read_32bit_c0_register($5, 1)
+#define write_c0_pagegrain(val)	__write_32bit_c0_register($5, 1, val)
+
 #define read_c0_wired()		__read_32bit_c0_register($6, 0)
 #define write_c0_wired(val)	__write_32bit_c0_register($6, 0, val)
 
-- 
1.6.2.5
