Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Jan 2013 17:11:38 +0100 (CET)
Received: from mms3.broadcom.com ([216.31.210.19]:2054 "EHLO mms3.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6831955Ab3ANQKSZ-rDk (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 Jan 2013 17:10:18 +0100
Received: from [10.9.200.131] by mms3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Mon, 14 Jan 2013 08:04:50 -0800
X-Server-Uuid: B86B6450-0931-4310-942E-F00ED04CA7AF
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB01.corp.ad.broadcom.com (10.9.200.131) with Microsoft SMTP
 Server id 8.2.247.2; Mon, 14 Jan 2013 08:09:33 -0800
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 3301B40FE5; Mon, 14
 Jan 2013 08:09:31 -0800 (PST)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 04/10] MIPS: Netlogic: Split XLP L1 i-cache among
 threads
Date:   Mon, 14 Jan 2013 21:41:56 +0530
Message-ID: <1358179922-26663-5-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1358179922-26663-1-git-send-email-jchandra@broadcom.com>
References: <1358179922-26663-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7CEAF3283Q42009767-12-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 35423
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Since we now use r4k cache code for Netlogic XLP, it is
better to split L1 icache among the active threads, so that
threads won't step on each other while flushing icache.

The L1 dcache is already split among the threads in the core.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 .../mips/include/asm/netlogic/xlp-hal/cpucontrol.h |    2 ++
 arch/mips/netlogic/common/smpboot.S                |    6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/arch/mips/include/asm/netlogic/xlp-hal/cpucontrol.h b/arch/mips/include/asm/netlogic/xlp-hal/cpucontrol.h
index 7b63a6b..6d2e58a 100644
--- a/arch/mips/include/asm/netlogic/xlp-hal/cpucontrol.h
+++ b/arch/mips/include/asm/netlogic/xlp-hal/cpucontrol.h
@@ -46,6 +46,8 @@
 #define CPU_BLOCKID_FPU		9
 #define CPU_BLOCKID_MAP		10
 
+#define ICU_DEFEATURE		0x100
+
 #define LSU_DEFEATURE		0x304
 #define LSU_DEBUG_ADDR		0x305
 #define LSU_DEBUG_DATA0		0x306
diff --git a/arch/mips/netlogic/common/smpboot.S b/arch/mips/netlogic/common/smpboot.S
index a0b7487..d772a87 100644
--- a/arch/mips/netlogic/common/smpboot.S
+++ b/arch/mips/netlogic/common/smpboot.S
@@ -69,6 +69,12 @@
 #endif
 	mtcr	t1, t0
 
+	li	t0, ICU_DEFEATURE
+	mfcr	t1, t0
+	ori	t1, 0x1000	/* Enable Icache partitioning */
+	mtcr	t1, t0
+
+
 #ifdef XLP_AX_WORKAROUND
 	li	t0, SCHED_DEFEATURE
 	lui	t1, 0x0100	/* Disable BRU accepting ALU ops */
-- 
1.7.9.5
