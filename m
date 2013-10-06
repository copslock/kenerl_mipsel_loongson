Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 06 Oct 2013 22:35:37 +0200 (CEST)
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:55386 "EHLO
        filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6867679Ab3JFUfdyBU8f (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 6 Oct 2013 22:35:33 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri1.pp.htv.fi (Postfix) with ESMTP id 7A6DF21B86E;
        Sun,  6 Oct 2013 23:35:32 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp6.welho.com ([213.243.153.40])
        by localhost (filtteri1.pp.htv.fi [213.243.153.184]) (amavisd-new, port 10024)
        with ESMTP id dvkwg+Pz29dm; Sun,  6 Oct 2013 23:35:27 +0300 (EEST)
Received: from blackmetal.pp.htv.fi (cs181064211.pp.htv.fi [82.181.64.211])
        by smtp6.welho.com (Postfix) with ESMTP id 850D45BC006;
        Sun,  6 Oct 2013 23:35:27 +0300 (EEST)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     devel@driverdev.osuosl.org, linux-mips@linux-mips.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Daney <david.daney@cavium.com>
Cc:     richard@nod.at, Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH v2 1/2] staging: octeon-ethernet: allow to set IRQ smp_affinity freely
Date:   Sun,  6 Oct 2013 23:35:15 +0300
Message-Id: <1381091716-23531-2-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 1.8.4.rc3
In-Reply-To: <1381091716-23531-1-git-send-email-aaro.koskinen@iki.fi>
References: <1381091716-23531-1-git-send-email-aaro.koskinen@iki.fi>
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38211
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

Currently the driver assumes that CPU 0 is handling all the hard IRQs.
This is wrong in Linux SMP systems where user is allowed to assign to
hardware IRQs to any CPU. The driver will stop working if user sets
smp_affinity so that interrupts end up being handled by other than CPU
0. The patch fixes that.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/staging/octeon/ethernet-rx.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/octeon/ethernet-rx.c b/drivers/staging/octeon/ethernet-rx.c
index 8897d2d..0d539eb 100644
--- a/drivers/staging/octeon/ethernet-rx.c
+++ b/drivers/staging/octeon/ethernet-rx.c
@@ -80,6 +80,8 @@ struct cvm_oct_core_state {
 
 static struct cvm_oct_core_state core_state __cacheline_aligned_in_smp;
 
+static int cvm_irq_cpu;
+
 static void cvm_oct_enable_napi(void *_)
 {
 	int cpu = smp_processor_id();
@@ -112,11 +114,7 @@ static void cvm_oct_no_more_work(void)
 {
 	int cpu = smp_processor_id();
 
-	/*
-	 * CPU zero is special.  It always has the irq enabled when
-	 * waiting for incoming packets.
-	 */
-	if (cpu == 0) {
+	if (cpu == cvm_irq_cpu) {
 		enable_irq(OCTEON_IRQ_WORKQ0 + pow_receive_group);
 		return;
 	}
@@ -135,6 +133,7 @@ static irqreturn_t cvm_oct_do_interrupt(int cpl, void *dev_id)
 {
 	/* Disable the IRQ and start napi_poll. */
 	disable_irq_nosync(OCTEON_IRQ_WORKQ0 + pow_receive_group);
+	cvm_irq_cpu = smp_processor_id();
 	cvm_oct_enable_napi(NULL);
 
 	return IRQ_HANDLED;
-- 
1.8.4.rc3
