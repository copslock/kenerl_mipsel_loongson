Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Aug 2016 21:20:58 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:53855 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992490AbcHHTUvPjciO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 8 Aug 2016 21:20:51 +0200
Received: from localhost (pes75-3-78-192-101-3.fbxo.proxad.net [78.192.101.3])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C7865413;
        Mon,  8 Aug 2016 19:20:43 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Burton <paul.burton@imgtec.com>,
        linux-mips@linux-mips.org, Jason Cooper <jason@lakedaemon.net>,
        Qais Yousef <qsyousef@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.6 78/96] irqchip/mips-gic: Map to VPs using HW VPNum
Date:   Mon,  8 Aug 2016 21:11:41 +0200
Message-Id: <20160808180247.317701468@linuxfoundation.org>
X-Mailer: git-send-email 2.9.2
In-Reply-To: <20160808180243.898163389@linuxfoundation.org>
References: <20160808180243.898163389@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54424
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Burton <paul.burton@imgtec.com>

commit 99ec8a3608330d202448085185cf28389b789b7b upstream.

When mapping an interrupt to a VP(E) we must use the identifier for the
VP that the hardware expects, and this does not always match up with the
Linux CPU number. Commit d46812bb0bef ("irqchip: mips-gic: Use HW IDs
for VPE_OTHER_ADDR") corrected this for the cases that existed at the
time it was written, but commit 2af70a962070 ("irqchip/mips-gic: Add a
IPI hierarchy domain") added another case before the former patch was
merged. This leads to incorrectly using Linux CPU numbers when mapping
interrupts to VPs, which breaks on certain systems such as those with
multi-core I6400 CPUs. Fix by adding the appropriate call to
mips_cm_vp_id() to retrieve the expected VP identifier.

Fixes: d46812bb0bef ("irqchip: mips-gic: Use HW IDs for VPE_OTHER_ADDR")
Fixes: 2af70a962070 ("irqchip/mips-gic: Add a IPI hierarchy domain")
Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Qais Yousef <qsyousef@gmail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Link: http://lkml.kernel.org/r/20160705132600.27730-1-paul.burton@imgtec.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/irqchip/irq-mips-gic.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -706,7 +706,7 @@ static int gic_shared_irq_domain_map(str
 
 	spin_lock_irqsave(&gic_lock, flags);
 	gic_map_to_pin(intr, gic_cpu_pin);
-	gic_map_to_vpe(intr, vpe);
+	gic_map_to_vpe(intr, mips_cm_vp_id(vpe));
 	for (i = 0; i < min(gic_vpes, NR_CPUS); i++)
 		clear_bit(intr, pcpu_masks[i].pcpu_mask);
 	set_bit(intr, pcpu_masks[vpe].pcpu_mask);
