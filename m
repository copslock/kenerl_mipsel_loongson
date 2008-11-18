Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Nov 2008 22:23:50 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:57389 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S23754591AbYKRWXr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 18 Nov 2008 22:23:47 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4923406e0001>; Tue, 18 Nov 2008 17:23:42 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 18 Nov 2008 14:23:40 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 18 Nov 2008 14:23:39 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id mAIMNZHC004822;
	Tue, 18 Nov 2008 14:23:35 -0800
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id mAIMNZpM004821;
	Tue, 18 Nov 2008 14:23:35 -0800
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>,
	Paul Gortmaker <Paul.Gortmaker@windriver.com>
Subject: [PATCH 04/26] MIPS: For Cavium OCTEON handle hazards as per the R10000 handling.
Date:	Tue, 18 Nov 2008 14:23:19 -0800
Message-Id: <1227047013-4785-4-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <49233FDE.3010404@caviumnetworks.com>
References: <49233FDE.3010404@caviumnetworks.com>
X-OriginalArrivalTime: 18 Nov 2008 22:23:39.0831 (UTC) FILETIME=[4EA43470:01C949CC]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21304
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

For Cavium CPU, we treat the same as R10000, in that all hazards
are dealt with in hardware.

Signed-off-by: Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Signed-off-by: Paul Gortmaker <Paul.Gortmaker@windriver.com>
Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/hazards.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/hazards.h b/arch/mips/include/asm/hazards.h
index 2de638f..43baed1 100644
--- a/arch/mips/include/asm/hazards.h
+++ b/arch/mips/include/asm/hazards.h
@@ -42,7 +42,7 @@ ASMMACRO(_ehb,
 /*
  * TLB hazards
  */
-#if defined(CONFIG_CPU_MIPSR2)
+#if defined(CONFIG_CPU_MIPSR2) && !defined(CONFIG_CPU_CAVIUM_OCTEON)
 
 /*
  * MIPSR2 defines ehb for hazard avoidance
@@ -138,7 +138,7 @@ do {									\
 		__instruction_hazard();					\
 } while (0)
 
-#elif defined(CONFIG_CPU_R10000)
+#elif defined(CONFIG_CPU_R10000) || defined(CONFIG_CPU_CAVIUM_OCTEON)
 
 /*
  * R10000 rocks - all hazards handled in hardware, so this becomes a nobrainer.
-- 
1.5.6.5
