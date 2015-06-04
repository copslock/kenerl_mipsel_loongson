Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Jun 2015 06:16:56 +0200 (CEST)
Received: from mga02.intel.com ([134.134.136.20]:60188 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006587AbbFDEQyQZ2Qn (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 4 Jun 2015 06:16:54 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP; 03 Jun 2015 21:16:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.13,551,1427785200"; 
   d="scan'208";a="736801781"
Received: from gerry-dev.bj.intel.com ([10.238.158.61])
  by fmsmga002.fm.intel.com with ESMTP; 03 Jun 2015 21:16:43 -0700
From:   Jiang Liu <jiang.liu@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Yinghai Lu <yinghai@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jason Cooper <jason@lakedaemon.net>
Cc:     Jiang Liu <jiang.liu@linux.intel.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-mips@linux-mips.org
Subject: [RFT v2 31/48] irqchip: Prepare for killing the first parameter 'irq' of irq_flow_handler_t
Date:   Thu,  4 Jun 2015 12:13:41 +0800
Message-Id: <1433391238-19471-32-git-send-email-jiang.liu@linux.intel.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
References: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
Return-Path: <jiang.liu@linux.intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47839
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

Change irq flow handler to prepare for killing the first parameter 'irq'
of irq_flow_handler_t.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 drivers/irqchip/irq-brcmstb-l2.c     |    7 ++++---
 drivers/irqchip/irq-imgpdc.c         |    3 ++-
 drivers/irqchip/irq-keystone.c       |    4 ++--
 drivers/irqchip/irq-mmp.c            |    3 ++-
 drivers/irqchip/irq-s3c24xx.c        |    4 ++--
 drivers/irqchip/irq-tb10x.c          |    2 +-
 drivers/irqchip/irq-versatile-fpga.c |    6 +++---
 7 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/irqchip/irq-brcmstb-l2.c b/drivers/irqchip/irq-brcmstb-l2.c
index d6bcc6be0777..994c01fdb4b5 100644
--- a/drivers/irqchip/irq-brcmstb-l2.c
+++ b/drivers/irqchip/irq-brcmstb-l2.c
@@ -51,7 +51,7 @@ struct brcmstb_l2_intc_data {
 	u32 saved_mask; /* for suspend/resume */
 };
 
-static void brcmstb_l2_intc_irq_handle(unsigned int irq, struct irq_desc *desc)
+static void brcmstb_l2_intc_irq_handle(unsigned int __irq, struct irq_desc *desc)
 {
 	struct brcmstb_l2_intc_data *b = irq_desc_get_handler_data(desc);
 	struct irq_chip_generic *gc = irq_get_domain_generic_chip(b->domain, 0);
@@ -65,13 +65,14 @@ static void brcmstb_l2_intc_irq_handle(unsigned int irq, struct irq_desc *desc)
 
 	if (status == 0) {
 		raw_spin_lock(&desc->lock);
-		handle_bad_irq(irq, desc);
+		handle_bad_irq(__irq, desc);
 		raw_spin_unlock(&desc->lock);
 		goto out;
 	}
 
 	do {
-		irq = ffs(status) - 1;
+		unsigned int irq = ffs(status) - 1;
+
 		/* ack at our level */
 		irq_reg_writel(gc, 1 << irq, CPU_CLEAR);
 		status &= ~(1 << irq);
diff --git a/drivers/irqchip/irq-imgpdc.c b/drivers/irqchip/irq-imgpdc.c
index 8071c2eb0248..d94eb43f252a 100644
--- a/drivers/irqchip/irq-imgpdc.c
+++ b/drivers/irqchip/irq-imgpdc.c
@@ -218,8 +218,9 @@ static int pdc_irq_set_wake(struct irq_data *data, unsigned int on)
 	return 0;
 }
 
-static void pdc_intc_perip_isr(unsigned int irq, struct irq_desc *desc)
+static void pdc_intc_perip_isr(unsigned int __irq, struct irq_desc *desc)
 {
+	unsigned int irq = irq_desc_get_irq(desc);
 	struct pdc_intc_priv *priv;
 	unsigned int i, irq_no;
 
diff --git a/drivers/irqchip/irq-keystone.c b/drivers/irqchip/irq-keystone.c
index 78e8b3ce5252..8b05603d3be0 100644
--- a/drivers/irqchip/irq-keystone.c
+++ b/drivers/irqchip/irq-keystone.c
@@ -90,7 +90,7 @@ static void keystone_irq_handler(unsigned irq, struct irq_desc *desc)
 	unsigned long pending;
 	int src, virq;
 
-	dev_dbg(kirq->dev, "start irq %d\n", irq);
+	dev_dbg(kirq->dev, "start irq %d\n", irq_desc_get_irq(desc));
 
 	chained_irq_enter(irq_desc_get_chip(desc), desc);
 
@@ -117,7 +117,7 @@ static void keystone_irq_handler(unsigned irq, struct irq_desc *desc)
 
 	chained_irq_exit(irq_desc_get_chip(desc), desc);
 
-	dev_dbg(kirq->dev, "end irq %d\n", irq);
+	dev_dbg(kirq->dev, "end irq %d\n", irq_desc_get_irq(desc));
 }
 
 static int keystone_irq_map(struct irq_domain *h, unsigned int virq,
diff --git a/drivers/irqchip/irq-mmp.c b/drivers/irqchip/irq-mmp.c
index c0da57bdb89d..44febf10be2f 100644
--- a/drivers/irqchip/irq-mmp.c
+++ b/drivers/irqchip/irq-mmp.c
@@ -130,8 +130,9 @@ struct irq_chip icu_irq_chip = {
 	.irq_unmask	= icu_unmask_irq,
 };
 
-static void icu_mux_irq_demux(unsigned int irq, struct irq_desc *desc)
+static void icu_mux_irq_demux(unsigned int __irq, struct irq_desc *desc)
 {
+	unsigned int irq = irq_desc_get_irq(desc);
 	struct irq_domain *domain;
 	struct icu_chip_data *data;
 	int i;
diff --git a/drivers/irqchip/irq-s3c24xx.c b/drivers/irqchip/irq-s3c24xx.c
index c8d373fcd823..efca6390aa87 100644
--- a/drivers/irqchip/irq-s3c24xx.c
+++ b/drivers/irqchip/irq-s3c24xx.c
@@ -327,8 +327,8 @@ static void s3c_irq_demux(unsigned int irq, struct irq_desc *desc)
 	while (src) {
 		n = __ffs(src);
 		src &= ~(1 << n);
-		irq = irq_find_mapping(sub_intc->domain, offset + n);
-		generic_handle_irq(irq);
+		generic_handle_irq(irq_find_mapping(sub_intc->domain,
+						    offset + n));
 	}
 
 	chained_irq_exit(chip, desc);
diff --git a/drivers/irqchip/irq-tb10x.c b/drivers/irqchip/irq-tb10x.c
index accc20036a3c..117cf25c6cfe 100644
--- a/drivers/irqchip/irq-tb10x.c
+++ b/drivers/irqchip/irq-tb10x.c
@@ -101,7 +101,7 @@ static void tb10x_irq_cascade(unsigned int irq, struct irq_desc *desc)
 {
 	struct irq_domain *domain = irq_desc_get_handler_data(desc);
 
-	generic_handle_irq(irq_find_mapping(domain, irq));
+	generic_handle_irq(irq_find_mapping(domain, irq_desc_get_irq(desc)));
 }
 
 static int __init of_tb10x_init_irq(struct device_node *ictl,
diff --git a/drivers/irqchip/irq-versatile-fpga.c b/drivers/irqchip/irq-versatile-fpga.c
index 1ab451729a5c..efbfd425d2e0 100644
--- a/drivers/irqchip/irq-versatile-fpga.c
+++ b/drivers/irqchip/irq-versatile-fpga.c
@@ -66,18 +66,18 @@ static void fpga_irq_unmask(struct irq_data *d)
 	writel(mask, f->base + IRQ_ENABLE_SET);
 }
 
-static void fpga_irq_handle(unsigned int irq, struct irq_desc *desc)
+static void fpga_irq_handle(unsigned int __irq, struct irq_desc *desc)
 {
 	struct fpga_irq_data *f = irq_desc_get_handler_data(desc);
 	u32 status = readl(f->base + IRQ_STATUS);
 
 	if (status == 0) {
-		do_bad_IRQ(irq, desc);
+		do_bad_IRQ(__irq, desc);
 		return;
 	}
 
 	do {
-		irq = ffs(status) - 1;
+		unsigned int irq = ffs(status) - 1;
 		status &= ~(1 << irq);
 		generic_handle_irq(irq_find_mapping(f->domain, irq));
 	} while (status);
-- 
1.7.10.4
