Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Dec 2008 23:50:51 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:36759 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S24087258AbYLCXpc (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 3 Dec 2008 23:45:32 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B493719e80004>; Wed, 03 Dec 2008 18:44:40 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 3 Dec 2008 15:44:39 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 3 Dec 2008 15:44:39 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id mB3NiYFR015642;
	Wed, 3 Dec 2008 15:44:34 -0800
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id mB3NiYlq015641;
	Wed, 3 Dec 2008 15:44:34 -0800
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>,
	Paul Gortmaker <Paul.Gortmaker@windriver.com>
Subject: [PATCH 14/21] MIPS: Add SMP_ICACHE_FLUSH for the Cavium CPU family.
Date:	Wed,  3 Dec 2008 15:44:24 -0800
Message-Id: <1228347871-15563-14-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <493718EA.40703@caviumnetworks.com>
References: <493718EA.40703@caviumnetworks.com>
X-OriginalArrivalTime: 03 Dec 2008 23:44:39.0258 (UTC) FILETIME=[1B482BA0:01C955A1]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21520
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Signed-off-by: Paul Gortmaker <Paul.Gortmaker@windriver.com>
Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/smp.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/smp.h b/arch/mips/include/asm/smp.h
index 0ff5b52..e6f419f 100644
--- a/arch/mips/include/asm/smp.h
+++ b/arch/mips/include/asm/smp.h
@@ -37,6 +37,9 @@ extern int __cpu_logical_map[NR_CPUS];
 
 #define SMP_RESCHEDULE_YOURSELF	0x1	/* XXX braindead */
 #define SMP_CALL_FUNCTION	0x2
+/* Octeon - Tell another core to flush its icache */
+#define SMP_ICACHE_FLUSH	0x4
+
 
 extern cpumask_t phys_cpu_present_map;
 #define cpu_possible_map	phys_cpu_present_map
-- 
1.5.6.5
