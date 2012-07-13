Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jul 2012 18:24:34 +0200 (CEST)
Received: from mms2.broadcom.com ([216.31.210.18]:2885 "EHLO mms2.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903498Ab2GMQY0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 13 Jul 2012 18:24:26 +0200
Received: from [10.9.200.131] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Fri, 13 Jul 2012 09:23:13 -0700
X-Server-Uuid: 4500596E-606A-40F9-852D-14843D8201B2
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB01.corp.ad.broadcom.com (10.9.200.131) with Microsoft SMTP
 Server id 8.2.247.2; Fri, 13 Jul 2012 09:24:10 -0700
Received: from hqcas02.netlogicmicro.com (unknown [10.65.50.15]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id B25879F9F5; Fri, 13
 Jul 2012 09:24:10 -0700 (PDT)
Received: from jayachandranc.netlogicmicro.com (10.7.0.77) by
 hqcas02.netlogicmicro.com (10.65.50.15) with Microsoft SMTP Server id
 14.1.339.1; Fri, 13 Jul 2012 09:24:10 -0700
From:   "Jayachandran C" <jayachandranc@netlogicmicro.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Jayachandran C" <jayachandranc@netlogicmicro.com>
Subject: [PATCH 01/12] MIPS: Netlogic: Fix indentation of smpboot.S
Date:   Fri, 13 Jul 2012 21:53:14 +0530
Message-ID: <1342196605-4260-2-git-send-email-jayachandranc@netlogicmicro.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1342196605-4260-1-git-send-email-jayachandranc@netlogicmicro.com>
References: <1342196605-4260-1-git-send-email-jayachandranc@netlogicmicro.com>
MIME-Version: 1.0
X-Originating-IP: [10.7.0.77]
X-WSS-ID: 7C1E94FB3NK5403875-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 33909
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
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

Fix whitespace issue introduced in the last merge, and while there
use tabs consistently in assembly after opcode. No change in logic.

Signed-off-by: Jayachandran C <jayachandranc@netlogicmicro.com>
---
 arch/mips/netlogic/common/smpboot.S |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/mips/netlogic/common/smpboot.S b/arch/mips/netlogic/common/smpboot.S
index a58f498..7badf38 100644
--- a/arch/mips/netlogic/common/smpboot.S
+++ b/arch/mips/netlogic/common/smpboot.S
@@ -67,7 +67,7 @@
 	li	t2, ~0xe	/* S1RCM */
 	and	t1, t1, t2
 #endif
-	mtcr    t1, t0
+	mtcr	t1, t0
 
 #ifdef XLP_AX_WORKAROUND
 	li	t0, SCHED_DEFEATURE
@@ -82,7 +82,7 @@
  */
 .macro	xlp_flush_l1_dcache
 	li	t0, LSU_DEBUG_DATA0
-	li      t1, LSU_DEBUG_ADDR
+	li	t1, LSU_DEBUG_ADDR
 	li	t2, 0		/* index */
 	li 	t3, 0x200	/* loop count, 512 sets */
 1:
@@ -95,13 +95,13 @@
 	andi	v1, 0x1		/* wait for write_active == 0 */
 	bnez	v1, 2b
 	nop
-	mtcr    zero, t0
+	mtcr	zero, t0
 	ori	v1, v0, 0x7	/* way1 | write_enable | write_active */
-	mtcr    v1, t1
+	mtcr	v1, t1
 3:
-	mfcr    v1, t1
-	andi    v1, 0x1		/* wait for write_active == 0 */
-	bnez    v1, 3b
+	mfcr	v1, t1
+	andi	v1, 0x1		/* wait for write_active == 0 */
+	bnez	v1, 3b
 	nop
 	addi	t2, 1
 	bne	t3, t2, 1b
@@ -193,9 +193,9 @@ EXPORT(nlm_boot_siblings)
 	bnez	v1, 2f
 	nop
 
-        li	t0, MMU_SETUP
-        li	t1, 0
-        mtcr	t1, t0
+	li	t0, MMU_SETUP
+	li	t1, 0
+	mtcr	t1, t0
 	_ehb
 
 2:	beqz	v0, 4f		/* boot cpu (cpuid == 0)? */
-- 
1.7.9.5
