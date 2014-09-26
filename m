Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Sep 2014 11:46:16 +0200 (CEST)
Received: from cantor2.suse.de ([195.135.220.15]:54365 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009070AbaIZJpzIEW4j (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 26 Sep 2014 11:45:55 +0200
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7A9D6ADD1;
        Fri, 26 Sep 2014 09:45:54 +0000 (UTC)
Received: from ku by ip4-83-240-18-248.cust.nbox.cz with local (Exim 4.83)
        (envelope-from <jslaby@suse.cz>)
        id 1XXS65-0008Q6-RS; Fri, 26 Sep 2014 11:45:53 +0200
From:   Jiri Slaby <jslaby@suse.cz>
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Jeffrey Deans <jeffrey.deans@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 3.12 068/142] MIPS: GIC: Prevent array overrun
Date:   Fri, 26 Sep 2014 11:44:39 +0200
Message-Id: <41c6ebd1c89fd33d9d55fe5307626b35503d87db.1411724724.git.jslaby@suse.cz>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <406eb8e630446eff74211cba53a536f232bbefd1.1411724723.git.jslaby@suse.cz>
References: <406eb8e630446eff74211cba53a536f232bbefd1.1411724723.git.jslaby@suse.cz>
In-Reply-To: <cover.1411724723.git.jslaby@suse.cz>
References: <cover.1411724723.git.jslaby@suse.cz>
Return-Path: <jslaby@suse.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42840
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jslaby@suse.cz
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

From: Jeffrey Deans <jeffrey.deans@imgtec.com>

3.12-stable review patch.  If anyone has any objections, please let me know.

===============

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
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 arch/mips/kernel/irq-gic.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/irq-gic.c b/arch/mips/kernel/irq-gic.c
index 5b5ddb231f26..78f18436cdf2 100644
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
2.1.0
