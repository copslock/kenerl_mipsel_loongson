Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Dec 2008 23:52:07 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:48279 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S24087261AbYLCXpu (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 3 Dec 2008 23:45:50 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B493719e80006>; Wed, 03 Dec 2008 18:44:40 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 3 Dec 2008 15:44:39 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 3 Dec 2008 15:44:39 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id mB3NiYJG015650;
	Wed, 3 Dec 2008 15:44:34 -0800
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id mB3NiYrU015649;
	Wed, 3 Dec 2008 15:44:34 -0800
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Subject: [PATCH 16/21] MIPS: Add Cavium OCTEON irq hazard in asmmacro.h.
Date:	Wed,  3 Dec 2008 15:44:26 -0800
Message-Id: <1228347871-15563-16-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <493718EA.40703@caviumnetworks.com>
References: <493718EA.40703@caviumnetworks.com>
X-OriginalArrivalTime: 03 Dec 2008 23:44:39.0555 (UTC) FILETIME=[1B757D30:01C955A1]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21523
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
