Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Dec 2008 16:38:21 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:18987 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S24207708AbYLJQiN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 10 Dec 2008 16:38:13 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B493ff0460000>; Wed, 10 Dec 2008 11:37:27 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 10 Dec 2008 08:37:25 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 10 Dec 2008 08:37:25 -0800
Message-ID: <493FF045.1020803@caviumnetworks.com>
Date:	Wed, 10 Dec 2008 08:37:25 -0800
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.18 (X11/20081119)
MIME-Version: 1.0
To:	linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] MIPS: Use ei/di for mipsr2.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Dec 2008 16:37:25.0190 (UTC) FILETIME=[95140E60:01C95AE5]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21565
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips


For mipsr2, use the ei and di instructions to enable and disable
interrupts.

Signed-off-by: Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/asmmacro.h |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/asmmacro.h b/arch/mips/include/asm/asmmacro.h
index 7a88175..6c8342a 100644
--- a/arch/mips/include/asm/asmmacro.h
+++ b/arch/mips/include/asm/asmmacro.h
@@ -35,6 +35,16 @@
 	mtc0	\reg, CP0_TCSTATUS
 	_ehb
 	.endm
+#elif defined(CONFIG_CPU_MIPSR2)
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
