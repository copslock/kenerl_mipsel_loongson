Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Oct 2009 01:54:45 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:16130 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493805AbZJAXxr (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 2 Oct 2009 01:53:47 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,5,4,7535)
	id <B4ac540f90007>; Thu, 01 Oct 2009 16:53:29 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 1 Oct 2009 16:47:44 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 1 Oct 2009 16:47:44 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id n91Nlfuj025434;
	Thu, 1 Oct 2009 16:47:41 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id n91NldQ6025432;
	Thu, 1 Oct 2009 16:47:39 -0700
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 1/2] MIPS: Octeon: Fix compile error in arch/mips/cavium-octeon/smp.c
Date:	Thu,  1 Oct 2009 16:47:38 -0700
Message-Id: <1254440859-25408-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
In-Reply-To: <4AC53F75.4090902@caviumnetworks.com>
References: <4AC53F75.4090902@caviumnetworks.com>
X-OriginalArrivalTime: 01 Oct 2009 23:47:44.0107 (UTC) FILETIME=[923663B0:01CA42F1]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24124
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/cavium-octeon/smp.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
index 32d51a3..c198efd 100644
--- a/arch/mips/cavium-octeon/smp.c
+++ b/arch/mips/cavium-octeon/smp.c
@@ -65,11 +65,12 @@ void octeon_send_ipi_single(int cpu, unsigned int action)
 	cvmx_write_csr(CVMX_CIU_MBOX_SETX(coreid), action);
 }
 
-static inline void octeon_send_ipi_mask(cpumask_t mask, unsigned int action)
+static inline void octeon_send_ipi_mask(const struct cpumask *mask,
+					unsigned int action)
 {
 	unsigned int i;
 
-	for_each_cpu_mask(i, mask)
+	for_each_cpu_mask(i, *mask)
 		octeon_send_ipi_single(i, action);
 }
 
-- 
1.6.0.6
