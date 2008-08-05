Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Aug 2008 11:43:19 +0100 (BST)
Received: from smtp.gentoo.org ([140.211.166.183]:3276 "EHLO smtp.gentoo.org")
	by ftp.linux-mips.org with ESMTP id S20021597AbYHEKnR (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 5 Aug 2008 11:43:17 +0100
Received: by smtp.gentoo.org (Postfix, from userid 2204)
	id 5FB1D67445; Tue,  5 Aug 2008 10:43:14 +0000 (UTC)
Date:	Tue, 5 Aug 2008 10:43:14 +0000
From:	Ricardo Mendoza <ricmm@gentoo.org>
To:	linux-mips@linux-mips.org
Cc:	yoichi_yuasa@tripeaks.co.jp, ralf@linux-mips.org, ricmm@gentoo.org
Subject: [PATCH] vr41xx: fix problem with vr41xx_cpu_wait
Message-ID: <20080805104314.GB4628@woodpecker.gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <ricmm@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20100
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ricmm@gentoo.org
Precedence: bulk
X-list: linux-mips

Hello,

Yoichi, please correct me if I am wrong but I think that the "standby"
instruction does not set IE bit on its own, so calling it with
interrupts disabled will loop the cpu away forever on standby state
being unable to come back due to no interrupts getting through.

Please ack the patch if you consider it correct.

Please apply afterwards, Ralf.


     Ricardo

---

Standby instruction can't be called with interrupts disabled
as it doesn't set IE bit on it's own.

Signed-off-by: Ricardo Mendoza <ricmm@gentoo.org>
---
 arch/mips/vr41xx/common/pmu.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/arch/mips/vr41xx/common/pmu.c b/arch/mips/vr41xx/common/pmu.c
index 028aaf7..6d651ec 100644
--- a/arch/mips/vr41xx/common/pmu.c
+++ b/arch/mips/vr41xx/common/pmu.c
@@ -48,14 +48,8 @@ static void __iomem *pmu_base;
 
 static void vr41xx_cpu_wait(void)
 {
-	local_irq_disable();
 	if (!need_resched())
-		/*
-		 * "standby" sets IE bit of the CP0_STATUS to 1.
-		 */
 		__asm__("standby;\n");
-	else
-		local_irq_enable();
 }
 
 static inline void software_reset(void)
