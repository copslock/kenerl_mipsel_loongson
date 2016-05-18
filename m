Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 May 2016 16:46:55 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:4887 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026667AbcEROqxMf5nY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 May 2016 16:46:53 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email with ESMTPS id DD8FC77D71896;
        Wed, 18 May 2016 15:46:43 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 18 May 2016 15:46:47 +0100
Received: from mredfearn-linux.kl.imgtec.org (192.168.154.116) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 18 May 2016 15:46:46 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Matt Redfearn <matt.redfearn@imgtec.com>,
        <linux-mips@linux-mips.org>, Joshua Kinard <kumba@gentoo.org>,
        <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        Chris Packham <judge.packham@gmail.com>,
        "Paul Burton" <paul.burton@imgtec.com>
Subject: [PATCH 1/2] MIPS: Add definitions of SegCtl registers and use them
Date:   Wed, 18 May 2016 15:45:21 +0100
Message-ID: <1463582722-31420-1-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.5.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.116]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53511
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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

The SegCtl registers are standard for MIPSr3..MIPSr5. Add definitions of
these registers and use them rather than constants

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
---

 arch/mips/include/asm/mach-malta/kernel-entry-init.h | 6 +++---
 arch/mips/include/asm/mipsregs.h                     | 3 +++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/mach-malta/kernel-entry-init.h b/arch/mips/include/asm/mach-malta/kernel-entry-init.h
index 0cf8622db27f..ab03eb3fadac 100644
--- a/arch/mips/include/asm/mach-malta/kernel-entry-init.h
+++ b/arch/mips/include/asm/mach-malta/kernel-entry-init.h
@@ -56,7 +56,7 @@
 		(0 << MIPS_SEGCFG_PA_SHIFT) |				\
 		(1 << MIPS_SEGCFG_EU_SHIFT)) << 16)
 	or	t0, t2
-	mtc0	t0, $5, 2
+	mtc0	t0, CP0_SEGCTL0
 
 	/* SegCtl1 */
 	li      t0, ((MIPS_SEGCFG_MUSUK << MIPS_SEGCFG_AM_SHIFT) |	\
@@ -67,7 +67,7 @@
 		(0 << MIPS_SEGCFG_PA_SHIFT) |				\
 		(1 << MIPS_SEGCFG_EU_SHIFT)) << 16)
 	ins	t0, t1, 16, 3
-	mtc0	t0, $5, 3
+	mtc0	t0, CP0_SEGCTL1
 
 	/* SegCtl2 */
 	li	t0, ((MIPS_SEGCFG_MUSUK << MIPS_SEGCFG_AM_SHIFT) |	\
@@ -77,7 +77,7 @@
 		(4 << MIPS_SEGCFG_PA_SHIFT) |				\
 		(1 << MIPS_SEGCFG_EU_SHIFT)) << 16)
 	or	t0, t2
-	mtc0	t0, $5, 4
+	mtc0	t0, CP0_SEGCTL2
 
 	jal	mips_ihb
 	mfc0    t0, $16, 5
diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 3ad19ad04d8a..639137f12f1a 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -48,6 +48,9 @@
 #define CP0_CONF $3
 #define CP0_CONTEXT $4
 #define CP0_PAGEMASK $5
+#define CP0_SEGCTL0 $5, 2
+#define CP0_SEGCTL1 $5, 3
+#define CP0_SEGCTL2 $5, 4
 #define CP0_WIRED $6
 #define CP0_INFO $7
 #define CP0_HWRENA $7, 0
-- 
2.5.0
