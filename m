Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Oct 2010 01:06:41 +0200 (CEST)
Received: from smtp2.caviumnetworks.com ([209.113.159.134]:18312 "EHLO
        smtp2.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491198Ab0JGXFD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Oct 2010 01:05:03 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by smtp2.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4cae50dd0001>; Thu, 07 Oct 2010 18:59:41 -0400
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 7 Oct 2010 16:04:17 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 7 Oct 2010 16:04:17 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id o97N433V026948;
        Thu, 7 Oct 2010 16:04:03 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id o97N43oQ026947;
        Thu, 7 Oct 2010 16:04:03 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 04/14] MIPS: Add identifiers for Octeon II CPUs.
Date:   Thu,  7 Oct 2010 16:03:43 -0700
Message-Id: <1286492633-26885-5-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1286492633-26885-1-git-send-email-ddaney@caviumnetworks.com>
References: <1286492633-26885-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 07 Oct 2010 23:04:17.0871 (UTC) FILETIME=[F80795F0:01CB6673]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27977
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/cpu.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index b201a8f..049a189 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -131,6 +131,7 @@
 #define PRID_IMP_CAVIUM_CN56XX 0x0400
 #define PRID_IMP_CAVIUM_CN50XX 0x0600
 #define PRID_IMP_CAVIUM_CN52XX 0x0700
+#define PRID_IMP_CAVIUM_CN63XX 0x9000
 
 /*
  * These are the PRID's for when 23:16 == PRID_COMP_INGENIC
@@ -231,7 +232,7 @@ enum cpu_type_enum {
 	 * MIPS64 class processors
 	 */
 	CPU_5KC, CPU_20KC, CPU_25KF, CPU_SB1, CPU_SB1A, CPU_LOONGSON2,
-	CPU_CAVIUM_OCTEON, CPU_CAVIUM_OCTEON_PLUS,
+	CPU_CAVIUM_OCTEON, CPU_CAVIUM_OCTEON_PLUS, CPU_CAVIUM_OCTEON2,
 
 	CPU_LAST
 };
-- 
1.7.2.3
