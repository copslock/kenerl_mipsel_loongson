Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Oct 2008 00:15:52 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:32022 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S22533363AbYJ1AFl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 28 Oct 2008 00:05:41 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B490656f7000e>; Mon, 27 Oct 2008 20:04:07 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 27 Oct 2008 17:03:14 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 27 Oct 2008 17:03:14 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id m9S039tv003344;
	Mon, 27 Oct 2008 17:03:09 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id m9S0398n003343;
	Mon, 27 Oct 2008 17:03:09 -0700
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Subject: [PATCH 25/36] Add Cavium OCTEON irq hazard in asmmacro.h.
Date:	Mon, 27 Oct 2008 17:02:57 -0700
Message-Id: <1225152181-3221-25-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1225152181-3221-24-git-send-email-ddaney@caviumnetworks.com>
References: <490655B6.4030406@caviumnetworks.com>
 <1225152181-3221-1-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-2-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-3-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-4-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-5-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-6-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-7-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-8-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-9-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-10-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-11-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-12-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-13-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-14-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-15-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-16-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-17-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-18-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-19-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-20-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-21-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-22-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-23-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-24-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 28 Oct 2008 00:03:14.0413 (UTC) FILETIME=[92AE91D0:01C93890]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21036
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Place irq_enable_hazard and irq_disable_hazard into asmmacro.h

Signed-off-by: Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/asmmacro.h |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/asmmacro.h b/arch/mips/include/asm/asmmacro.h
index 7a88175..5408149 100644
--- a/arch/mips/include/asm/asmmacro.h
+++ b/arch/mips/include/asm/asmmacro.h
@@ -35,6 +35,16 @@
 	mtc0	\reg, CP0_TCSTATUS
 	_ehb
 	.endm
+#elif defined(CONFIG_CPU_CAVIUM_OCTEON)
+	.macro	local_irq_enable reg=t0
+	ei
+	irq_enable_hazard
+	.endm
+
+	.macro	local_irq_disable reg=t0
+	di
+	irq_disable_hazard
+	.endm
 #else
 	.macro	local_irq_enable reg=t0
 	mfc0	\reg, CP0_STATUS
-- 
1.5.6.5
