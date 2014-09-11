Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Sep 2014 14:35:12 +0200 (CEST)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36554 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008733AbaIKMehf6hQh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Sep 2014 14:34:37 +0200
Received: from deadeye.wl.decadent.org.uk ([192.168.4.249] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <ben@decadent.org.uk>)
        id 1XS3Zd-0006Js-0A; Thu, 11 Sep 2014 13:34:05 +0100
Received: from ben by deadeye with local (Exim 4.84)
        (envelope-from <ben@decadent.org.uk>)
        id 1XS3ZS-0004G9-Dp; Thu, 11 Sep 2014 13:33:54 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Ralf Baechle" <ralf@linux-mips.org>,
        "Jeffrey Deans" <jeffrey.deans@imgtec.com>,
        "Markos Chandras" <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org
Date:   Thu, 11 Sep 2014 13:32:13 +0100
Message-ID: <lsq.1410438733.712861249@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 039/131] MIPS: GIC: Prevent array overrun
In-Reply-To: <lsq.1410438733.176537304@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.249
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42518
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
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

3.2.63-rc1 review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/kernel/irq-gic.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/arch/mips/kernel/irq-gic.c
+++ b/arch/mips/kernel/irq-gic.c
@@ -166,11 +166,13 @@ static void __init gic_setup_intr(unsign
 {
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
