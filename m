Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Dec 2008 23:43:00 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:14891 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S24207788AbYLKXkU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 11 Dec 2008 23:40:20 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4941a39c0000>; Thu, 11 Dec 2008 18:34:57 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 11 Dec 2008 15:33:52 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 11 Dec 2008 15:33:52 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id mBBNXlmm031911;
	Thu, 11 Dec 2008 15:33:48 -0800
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id mBBNXlNa031910;
	Thu, 11 Dec 2008 15:33:47 -0800
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>,
	Paul Gortmaker <Paul.Gortmaker@windriver.com>
Subject: [PATCH 14/20] MIPS: Add SMP_ICACHE_FLUSH for the Cavium CPU family.
Date:	Thu, 11 Dec 2008 15:33:32 -0800
Message-Id: <1229038418-31833-14-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <4941A2F5.1010202@caviumnetworks.com>
References: <4941A2F5.1010202@caviumnetworks.com>
X-OriginalArrivalTime: 11 Dec 2008 23:33:52.0833 (UTC) FILETIME=[ED498B10:01C95BE8]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21593
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
