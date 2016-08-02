Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Aug 2016 20:55:33 +0200 (CEST)
Received: from mail5.windriver.com ([192.103.53.11]:54764 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993127AbcHBSz0VzB5x (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 2 Aug 2016 20:55:26 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id u72Isxcx015089
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=OK);
        Tue, 2 Aug 2016 11:54:59 -0700
Received: from yow-lpgnfs-02.wrs.com (128.224.149.8) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.248.2; Tue, 2 Aug 2016 11:54:58 -0700
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        John Crispin <john@phrozen.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-mips@linux-mips.org>
Subject: [PATCH] mips: lantiq: fix irq_chip name to not land in new parent field
Date:   Tue, 2 Aug 2016 14:54:47 -0400
Message-ID: <20160802185447.3831-1-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.8.4
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <Paul.Gortmaker@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54399
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.gortmaker@windriver.com
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

As of commit be45beb2df69 ("genirq: Add runtime power management
support for IRQ chips") the irq_chip struct got a struct *device
parent_device field added to it.  However, it was added at the
beginning of the struct, which previously was the "name" entry.

The driver here was using a mix of ordered struct init entries and
named init entries.  It was supplying the name assuming it was the 1st
in the order, and hence when that became a struct *device we get:

arch/mips/lantiq/irq.c:209:2: warning: initialization from incompatible pointer type [enabled by default]
arch/mips/lantiq/irq.c:209:2: warning: (near initialization for 'ltq_irq_type.parent_device') [enabled by default]
arch/mips/lantiq/irq.c:219:2: warning: initialization from incompatible pointer type [enabled by default]
arch/mips/lantiq/irq.c:219:2: warning: (near initialization for 'ltq_eiu_type.parent_device') [enabled by default]

While not runtime tested, I can't imagine trying to dereference a
a struct device field from a char string will end well.

Here we've used named element init entries for the name string as well
to fix it.

Fixes: be45beb2df69 ("genirq: Add runtime power management support for IRQ chips")
Cc: Jon Hunter <jonathanh@nvidia.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: John Crispin <john@phrozen.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mips@linux-mips.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---

[
  in mainline via: commit a5c8a01968fc9dc94f182172cee7ab40bc496ea4
    Merge: ff5b706f5189 3faf24ea894a
    Author: Thomas Gleixner <tglx@linutronix.de>
    Date:   Mon Jun 13 16:33:48 2016 +0200

    Merge tag 'irqchip-for-4.8' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/core
]

 arch/mips/lantiq/irq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/lantiq/irq.c b/arch/mips/lantiq/irq.c
index ff17669e30a3..02c0252b49a3 100644
--- a/arch/mips/lantiq/irq.c
+++ b/arch/mips/lantiq/irq.c
@@ -206,7 +206,7 @@ static void ltq_shutdown_eiu_irq(struct irq_data *d)
 }
 
 static struct irq_chip ltq_irq_type = {
-	"icu",
+	.name = "icu",
 	.irq_enable = ltq_enable_irq,
 	.irq_disable = ltq_disable_irq,
 	.irq_unmask = ltq_enable_irq,
@@ -216,7 +216,7 @@ static struct irq_chip ltq_irq_type = {
 };
 
 static struct irq_chip ltq_eiu_type = {
-	"eiu",
+	.name = "eiu",
 	.irq_startup = ltq_startup_eiu_irq,
 	.irq_shutdown = ltq_shutdown_eiu_irq,
 	.irq_enable = ltq_enable_irq,
-- 
2.8.4
