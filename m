Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Nov 2013 21:36:03 +0100 (CET)
Received: from mms1.broadcom.com ([216.31.210.17]:3328 "EHLO mms1.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6867263Ab3K0UgA4aor1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 27 Nov 2013 21:36:00 +0100
Received: from [10.9.208.53] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Wed, 27 Nov 2013 12:35:28 -0800
X-Server-Uuid: 06151B78-6688-425E-9DE2-57CB27892261
Received: from IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) by
 IRVEXCHCAS06.corp.ad.broadcom.com (10.9.208.53) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Wed, 27 Nov 2013 12:35:45 -0800
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) with Microsoft SMTP
 Server id 14.1.438.0; Wed, 27 Nov 2013 12:35:44 -0800
Received: from stbsrv-and-2.and.broadcom.com (
 stbsrv-and-2.and.broadcom.com [10.32.128.96]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 2F782246A7; Wed, 27
 Nov 2013 12:35:44 -0800 (PST)
From:   "Jim Quinlan" <jim2101024@gmail.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org
cc:     cernekee@gmail.com, "Jim Quinlan" <jim2101024@gmail.com>
Subject: [PATCH] MIPS: make local_irq_disable macro safe for non-mipsr2
Date:   Wed, 27 Nov 2013 15:34:50 -0500
Message-ID: <1385584490-20589-1-git-send-email-jim2101024@gmail.com>
X-Mailer: git-send-email 1.7.6
MIME-Version: 1.0
X-WSS-ID: 7E88881A15011878762-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <jim2101024@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38589
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jim2101024@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

For non-mipsr2 processors, the local_irq_disable contains an mfc0-mtc0
pair with instructions inbetween.  With preemption enabled, this sequence
may get preempted and effect a stale value of CP0_STATUS when executing
the mtc0 instruction.  This commit avoids this scenario by incrementing
the preempt count before the mfc0 and decrementing it after the mtc9.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 arch/mips/include/asm/asmmacro.h |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/asmmacro.h b/arch/mips/include/asm/asmmacro.h
index 6c8342a..3f809a4 100644
--- a/arch/mips/include/asm/asmmacro.h
+++ b/arch/mips/include/asm/asmmacro.h
@@ -9,6 +9,7 @@
 #define _ASM_ASMMACRO_H
 
 #include <asm/hazards.h>
+//#include <asm/asm-offsets.h>
 
 #ifdef CONFIG_32BIT
 #include <asm/asmmacro-32.h>
@@ -54,11 +55,21 @@
 	.endm
 
 	.macro	local_irq_disable reg=t0
+#ifdef CONFIG_PREEMPT
+	lw      \reg, TI_PRE_COUNT($28)
+	addi    \reg, \reg, 1
+	sw      \reg, TI_PRE_COUNT($28)
+#endif
 	mfc0	\reg, CP0_STATUS
 	ori	\reg, \reg, 1
 	xori	\reg, \reg, 1
 	mtc0	\reg, CP0_STATUS
 	irq_disable_hazard
+#ifdef CONFIG_PREEMPT
+	lw      \reg, TI_PRE_COUNT($28)
+	addi    \reg, \reg, -1
+	sw      \reg, TI_PRE_COUNT($28)
+#endif
 	.endm
 #endif /* CONFIG_MIPS_MT_SMTC */
 
-- 
1.7.6
