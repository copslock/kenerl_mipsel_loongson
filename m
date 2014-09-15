Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Sep 2014 00:20:30 +0200 (CEST)
Received: from youngberry.canonical.com ([91.189.89.112]:34685 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009014AbaIOWUNJ12iN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Sep 2014 00:20:13 +0200
Received: from c-76-102-4-12.hsd1.ca.comcast.net ([76.102.4.12] helo=fourier)
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
        (Exim 4.71)
        (envelope-from <kamal@canonical.com>)
        id 1XTeTg-0000A0-MF; Mon, 15 Sep 2014 22:10:32 +0000
Received: from kamal by fourier with local (Exim 4.82)
        (envelope-from <kamal@whence.com>)
        id 1XTeTe-0002fs-UF; Mon, 15 Sep 2014 15:10:30 -0700
From:   Kamal Mostafa <kamal@canonical.com>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel-team@lists.ubuntu.com
Cc:     Jeffrey Deans <jeffrey.deans@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Kamal Mostafa <kamal@canonical.com>
Subject: [PATCH 3.13 124/187] MIPS: GIC: Prevent array overrun
Date:   Mon, 15 Sep 2014 15:08:54 -0700
Message-Id: <1410818997-9432-125-git-send-email-kamal@canonical.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1410818997-9432-1-git-send-email-kamal@canonical.com>
References: <1410818997-9432-1-git-send-email-kamal@canonical.com>
X-Extended-Stable: 3.13
Return-Path: <kamal@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42613
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kamal@canonical.com
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

3.13.11.7 -stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jeffrey Deans <jeffrey.deans@imgtec.com>

commit ffc8415afab20bd97754efae6aad1f67b531132b upstream.

A GIC interrupt which is declared as having a GIC_MAP_TO_NMI_MSK
mapping causes the cpu parameter to gic_setup_intr() to be increased
to 32, causing memory corruption when pcpu_masks[] is written to again
later in the function.

Signed-off-by: Jeffrey Deans <jeffrey.deans@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/7375/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/kernel/irq-gic.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/irq-gic.c b/arch/mips/kernel/irq-gic.c
index 5b5ddb2..78f1843 100644
--- a/arch/mips/kernel/irq-gic.c
+++ b/arch/mips/kernel/irq-gic.c
@@ -255,11 +255,13 @@ static void __init gic_setup_intr(unsigned int intr, unsigned int cpu,
 
 	/* Setup Intr to Pin mapping */
 	if (pin & GIC_MAP_TO_NMI_MSK) {
+		int i;
+
 		GICWRITE(GIC_REG_ADDR(SHARED, GIC_SH_MAP_TO_PIN(intr)), pin);
 		/* FIXME: hack to route NMI to all cpu's */
-		for (cpu = 0; cpu < NR_CPUS; cpu += 32) {
+		for (i = 0; i < NR_CPUS; i += 32) {
 			GICWRITE(GIC_REG_ADDR(SHARED,
-					  GIC_SH_MAP_TO_VPE_REG_OFF(intr, cpu)),
+					  GIC_SH_MAP_TO_VPE_REG_OFF(intr, i)),
 				 0xffffffff);
 		}
 	} else {
-- 
1.9.1
