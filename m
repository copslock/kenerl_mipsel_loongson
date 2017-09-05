Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Sep 2017 09:11:54 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:40486 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994902AbdIEHLlcbfPB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Sep 2017 09:11:41 +0200
Received: from localhost (LFbn-1-12253-150.w90-92.abo.wanadoo.fr [90.92.67.150])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 59F8493E;
        Tue,  5 Sep 2017 07:11:33 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.9 01/18] irqchip: mips-gic: SYNC after enabling GIC region
Date:   Tue,  5 Sep 2017 09:11:09 +0200
Message-Id: <20170905070918.101123097@linuxfoundation.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170905070918.034746210@linuxfoundation.org>
References: <20170905070918.034746210@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59931
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <james.hogan@imgtec.com>

commit 2c0e8382386f618c85d20cb05e7cf7df8cdd382c upstream.

A SYNC is required between enabling the GIC region and actually trying
to use it, even if the first access is a read, otherwise its possible
depending on the timing (and in my case depending on the precise
alignment of certain kernel code) to hit CM bus errors on that first
access.

Add the SYNC straight after setting the GIC base.

[paul.burton@imgtec.com:
  Changes later in this series increase our likelihood of hitting this
  by reducing the amount of code that runs between enabling the GIC &
  accessing it.]

Fixes: a7057270c280 ("irqchip: mips-gic: Add device-tree support")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/17019/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/irqchip/irq-mips-gic.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -1115,8 +1115,11 @@ static int __init gic_of_init(struct dev
 		gic_len = resource_size(&res);
 	}
 
-	if (mips_cm_present())
+	if (mips_cm_present()) {
 		write_gcr_gic_base(gic_base | CM_GCR_GIC_BASE_GICEN_MSK);
+		/* Ensure GIC region is enabled before trying to access it */
+		__sync();
+	}
 	gic_present = true;
 
 	__gic_init(gic_base, gic_len, cpu_vec, 0, node);
