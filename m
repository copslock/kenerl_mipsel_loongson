Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Jun 2015 10:07:14 +0200 (CEST)
Received: from mga09.intel.com ([134.134.136.24]:20643 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006840AbbFAIHLzKdy4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 1 Jun 2015 10:07:11 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP; 01 Jun 2015 01:07:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.13,531,1427785200"; 
   d="scan'208";a="734800408"
Received: from gerry-dev.bj.intel.com ([10.238.158.61])
  by fmsmga002.fm.intel.com with ESMTP; 01 Jun 2015 01:06:57 -0700
From:   Jiang Liu <jiang.liu@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Yinghai Lu <yinghai@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Jonas Gorski <jogo@openwrt.org>,
        Aleksey Makarov <aleksey.makarov@auriga.com>,
        David Daney <david.daney@cavium.com>,
        Christoph Lameter <cl@linux.com>
Cc:     Jiang Liu <jiang.liu@linux.intel.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-mips@linux-mips.org
Subject: [Patch v3 21/36] mips, irq: Use access helper irq_data_get_affinity_mask()
Date:   Mon,  1 Jun 2015 16:05:30 +0800
Message-Id: <1433145945-789-22-git-send-email-jiang.liu@linux.intel.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1433145945-789-1-git-send-email-jiang.liu@linux.intel.com>
References: <1433145945-789-1-git-send-email-jiang.liu@linux.intel.com>
Return-Path: <jiang.liu@linux.intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47760
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jiang.liu@linux.intel.com
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

Use access helper irq_data_get_affinity_mask() to hide implementation
details of struct irq_desc.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 arch/mips/bcm63xx/irq.c              |    2 +-
 arch/mips/cavium-octeon/octeon-irq.c |   14 ++++++++------
 arch/mips/pmcs-msp71xx/msp_irq_cic.c |    3 ++-
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/mips/bcm63xx/irq.c b/arch/mips/bcm63xx/irq.c
index e3e808a6c542..02983b90826d 100644
--- a/arch/mips/bcm63xx/irq.c
+++ b/arch/mips/bcm63xx/irq.c
@@ -60,7 +60,7 @@ static inline int enable_irq_for_cpu(int cpu, struct irq_data *d,
 	if (m)
 		enable &= cpumask_test_cpu(cpu, m);
 	else if (irqd_affinity_was_set(d))
-		enable &= cpumask_test_cpu(cpu, d->affinity);
+		enable &= cpumask_test_cpu(cpu, irq_data_get_affinity_mask(d));
 #endif
 	return enable;
 }
diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
index 10f762557b92..0643ae614284 100644
--- a/arch/mips/cavium-octeon/octeon-irq.c
+++ b/arch/mips/cavium-octeon/octeon-irq.c
@@ -225,13 +225,14 @@ static int next_cpu_for_irq(struct irq_data *data)
 
 #ifdef CONFIG_SMP
 	int cpu;
-	int weight = cpumask_weight(data->affinity);
+	struct cpumask *mask = irq_data_get_affinity_mask(data);
+	int weight = cpumask_weight(mask);
 	struct octeon_ciu_chip_data *cd = irq_data_get_irq_chip_data(data);
 
 	if (weight > 1) {
 		cpu = cd->current_cpu;
 		for (;;) {
-			cpu = cpumask_next(cpu, data->affinity);
+			cpu = cpumask_next(cpu, mask);
 			if (cpu >= nr_cpu_ids) {
 				cpu = -1;
 				continue;
@@ -240,7 +241,7 @@ static int next_cpu_for_irq(struct irq_data *data)
 			}
 		}
 	} else if (weight == 1) {
-		cpu = cpumask_first(data->affinity);
+		cpu = cpumask_first(mask);
 	} else {
 		cpu = smp_processor_id();
 	}
@@ -710,16 +711,17 @@ static void octeon_irq_cpu_offline_ciu(struct irq_data *data)
 {
 	int cpu = smp_processor_id();
 	cpumask_t new_affinity;
+	struct cpumask *mask = irq_data_get_affinity_mask(data);
 
-	if (!cpumask_test_cpu(cpu, data->affinity))
+	if (!cpumask_test_cpu(cpu, mask))
 		return;
 
-	if (cpumask_weight(data->affinity) > 1) {
+	if (cpumask_weight(mask) > 1) {
 		/*
 		 * It has multi CPU affinity, just remove this CPU
 		 * from the affinity set.
 		 */
-		cpumask_copy(&new_affinity, data->affinity);
+		cpumask_copy(&new_affinity, mask);
 		cpumask_clear_cpu(cpu, &new_affinity);
 	} else {
 		/* Otherwise, put it on lowest numbered online CPU. */
diff --git a/arch/mips/pmcs-msp71xx/msp_irq_cic.c b/arch/mips/pmcs-msp71xx/msp_irq_cic.c
index 1207ec4dfb77..8b9cf6463040 100644
--- a/arch/mips/pmcs-msp71xx/msp_irq_cic.c
+++ b/arch/mips/pmcs-msp71xx/msp_irq_cic.c
@@ -88,7 +88,8 @@ static void unmask_cic_irq(struct irq_data *d)
 	* Make sure we have IRQ affinity.  It may have changed while
 	* we were processing the IRQ.
 	*/
-	if (!cpumask_test_cpu(smp_processor_id(), d->affinity))
+	if (!cpumask_test_cpu(smp_processor_id(),
+			      irq_data_get_affinity_mask(d)))
 		return;
 #endif
 
-- 
1.7.10.4
