Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jun 2013 09:46:16 +0200 (CEST)
Received: from mms2.broadcom.com ([216.31.210.18]:1225 "EHLO mms2.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6835073Ab3FJHkPRMQrZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 10 Jun 2013 09:40:15 +0200
Received: from [10.9.208.53] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Mon, 10 Jun 2013 00:34:24 -0700
X-Server-Uuid: 4500596E-606A-40F9-852D-14843D8201B2
Received: from IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) by
 IRVEXCHCAS06.corp.ad.broadcom.com (10.9.208.53) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Mon, 10 Jun 2013 00:40:04 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) with Microsoft SMTP
 Server id 14.1.438.0; Mon, 10 Jun 2013 00:40:04 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 949B8F2D86; Mon, 10
 Jun 2013 00:40:02 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 10/11] MIPS: Netlogic: Remove workarounds for early SoCs
Date:   Mon, 10 Jun 2013 13:11:09 +0530
Message-ID: <1370850070-5127-11-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1370850070-5127-1-git-send-email-jchandra@broadcom.com>
References: <1370850070-5127-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7DAB5E0A1R029041254-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36790
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

The XLPs in production do not need these workarounds. Remove the code and
the associated ifdef.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/netlogic/common/reset.S |   23 +----------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

diff --git a/arch/mips/netlogic/common/reset.S b/arch/mips/netlogic/common/reset.S
index 161b4d5..58952a8 100644
--- a/arch/mips/netlogic/common/reset.S
+++ b/arch/mips/netlogic/common/reset.S
@@ -54,8 +54,6 @@
 			XLP_IO_SYS_OFFSET(node) + XLP_IO_PCI_HDRSZ + \
 			SYS_CPU_NONCOHERENT_MODE * 4
 
-#define XLP_AX_WORKAROUND	/* enable Ax silicon workarounds */
-
 /* Enable XLP features and workarounds in the LSU */
 .macro xlp_config_lsu
 	li	t0, LSU_DEFEATURE
@@ -63,10 +61,6 @@
 
 	lui	t2, 0xc080	/* SUE, Enable Unaligned Access, L2HPE */
 	or	t1, t1, t2
-#ifdef XLP_AX_WORKAROUND
-	li	t2, ~0xe	/* S1RCM */
-	and	t1, t1, t2
-#endif
 	mtcr	t1, t0
 
 	li	t0, ICU_DEFEATURE
@@ -74,12 +68,9 @@
 	ori	t1, 0x1000	/* Enable Icache partitioning */
 	mtcr	t1, t0
 
-
-#ifdef XLP_AX_WORKAROUND
 	li	t0, SCHED_DEFEATURE
 	lui	t1, 0x0100	/* Disable BRU accepting ALU ops */
 	mtcr	t1, t0
-#endif
 .endm
 
 /*
@@ -195,19 +186,7 @@ EXPORT(nlm_boot_siblings)
 	mfc0	v0, CP0_EBASE, 1
 	andi	v0, 0x3ff		/* v0 <- node/core */
 
-	/* Init MMU in the first thread after changing THREAD_MODE
-	 * register (Ax Errata?)
-	 */
-	andi	v1, v0, 0x3		/* v1 <- thread id */
-	bnez	v1, 2f
-	nop
-
-	li	t0, MMU_SETUP
-	li	t1, 0
-	mtcr	t1, t0
-	_ehb
-
-2:	beqz	v0, 4f		/* boot cpu (cpuid == 0)? */
+	beqz	v0, 4f		/* boot cpu (cpuid == 0)? */
 	nop
 
 	/* setup status reg */
-- 
1.7.9.5
