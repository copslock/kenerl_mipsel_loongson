Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Oct 2008 02:03:25 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:48486 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S22251750AbYJXA6S (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 24 Oct 2008 01:58:18 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B49011d670001>; Thu, 23 Oct 2008 20:57:11 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 23 Oct 2008 17:57:10 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 23 Oct 2008 17:57:10 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id m9O0v5oU005653;
	Thu, 23 Oct 2008 17:57:05 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id m9O0v5Su005652;
	Thu, 23 Oct 2008 17:57:05 -0700
From:	ddaney@caviumnetworks.com
To:	linux-mips@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>,
	Paul Gortmaker <Paul.Gortmaker@windriver.com>
Subject: [PATCH 23/37] Add SMP_ICACHE_FLUSH for the Cavium CPU family.
Date:	Thu, 23 Oct 2008 17:56:47 -0700
Message-Id: <1224809821-5532-24-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1224809821-5532-1-git-send-email-ddaney@caviumnetworks.com>
References: <1224809821-5532-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 24 Oct 2008 00:57:10.0360 (UTC) FILETIME=[71CDE580:01C93573]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20897
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

From: David Daney <ddaney@caviumnetworks.com>

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
1.5.5.1
