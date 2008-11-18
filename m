Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Nov 2008 22:30:28 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:5935 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S23754607AbYKRWY3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 18 Nov 2008 22:24:29 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B492340700000>; Tue, 18 Nov 2008 17:23:44 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 18 Nov 2008 14:23:42 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 18 Nov 2008 14:23:41 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id mAIMNbW4004871;
	Tue, 18 Nov 2008 14:23:37 -0800
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id mAIMNaCF004870;
	Tue, 18 Nov 2008 14:23:37 -0800
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Subject: [PATCH 16/26] MIPS: Add Cavium OCTEON irq hazard in asmmacro.h.
Date:	Tue, 18 Nov 2008 14:23:31 -0800
Message-Id: <1227047013-4785-16-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <49233FDE.3010404@caviumnetworks.com>
References: <49233FDE.3010404@caviumnetworks.com>
X-OriginalArrivalTime: 18 Nov 2008 22:23:41.0738 (UTC) FILETIME=[4FC730A0:01C949CC]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21319
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
