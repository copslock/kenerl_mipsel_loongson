Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Jun 2015 06:16:15 +0200 (CEST)
Received: from mga09.intel.com ([134.134.136.24]:27781 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006587AbbFDEQOEpson (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 4 Jun 2015 06:16:14 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP; 03 Jun 2015 21:16:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.13,549,1427785200"; 
   d="scan'208";a="736801592"
Received: from gerry-dev.bj.intel.com ([10.238.158.61])
  by fmsmga002.fm.intel.com with ESMTP; 03 Jun 2015 21:16:03 -0700
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
        Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc:     Jiang Liu <jiang.liu@linux.intel.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-mips@linux-mips.org
Subject: [RFT v2 25/48] mips, irq: Prepare for killing the first parameter 'irq' of irq_flow_handler_t
Date:   Thu,  4 Jun 2015 12:13:35 +0800
Message-Id: <1433391238-19471-26-git-send-email-jiang.liu@linux.intel.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
References: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
Return-Path: <jiang.liu@linux.intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47838
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

Change irq flow handlers to prepare for killing the first parameter 'irq'
of irq_flow_handler_t.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 arch/mips/alchemy/devboards/bcsr.c |    3 ++-
 arch/mips/ath79/irq.c              |    9 ++++++---
 arch/mips/pci/pci-rt3883.c         |    4 +---
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/mips/alchemy/devboards/bcsr.c b/arch/mips/alchemy/devboards/bcsr.c
index c98c9ea3372c..8d6ea369bde4 100644
--- a/arch/mips/alchemy/devboards/bcsr.c
+++ b/arch/mips/alchemy/devboards/bcsr.c
@@ -85,8 +85,9 @@ EXPORT_SYMBOL_GPL(bcsr_mod);
 /*
  * DB1200/PB1200 CPLD IRQ muxer
  */
-static void bcsr_csc_handler(unsigned int irq, struct irq_desc *d)
+static void bcsr_csc_handler(unsigned int __irq, struct irq_desc *d)
 {
+	unsigned int irq = irq_desc_get_irq(d);
 	unsigned short bisr = __raw_readw(bcsr_virt + BCSR_REG_INTSTAT);
 
 	disable_irq_nosync(irq);
diff --git a/arch/mips/ath79/irq.c b/arch/mips/ath79/irq.c
index 6adae366f11a..1b6620b0c057 100644
--- a/arch/mips/ath79/irq.c
+++ b/arch/mips/ath79/irq.c
@@ -120,8 +120,9 @@ static void __init ath79_misc_irq_init(void)
 	irq_set_chained_handler(ATH79_CPU_IRQ(6), ath79_misc_irq_handler);
 }
 
-static void ar934x_ip2_irq_dispatch(unsigned int irq, struct irq_desc *desc)
+static void ar934x_ip2_irq_dispatch(unsigned int __irq, struct irq_desc *desc)
 {
+	unsigned int irq = irq_desc_get_irq(desc);
 	u32 status;
 
 	disable_irq_nosync(irq);
@@ -153,8 +154,9 @@ static void ar934x_ip2_irq_init(void)
 	irq_set_chained_handler(ATH79_CPU_IRQ(2), ar934x_ip2_irq_dispatch);
 }
 
-static void qca955x_ip2_irq_dispatch(unsigned int irq, struct irq_desc *desc)
+static void qca955x_ip2_irq_dispatch(unsigned int __irq, struct irq_desc *desc)
 {
+	unsigned int irq = irq_desc_get_irq(desc);
 	u32 status;
 
 	disable_irq_nosync(irq);
@@ -181,8 +183,9 @@ enable:
 	enable_irq(irq);
 }
 
-static void qca955x_ip3_irq_dispatch(unsigned int irq, struct irq_desc *desc)
+static void qca955x_ip3_irq_dispatch(unsigned int __irq, struct irq_desc *desc)
 {
+	unsigned int irq = irq_desc_get_irq(desc);
 	u32 status;
 
 	disable_irq_nosync(irq);
diff --git a/arch/mips/pci/pci-rt3883.c b/arch/mips/pci/pci-rt3883.c
index 80fafe646e74..67d483206d6c 100644
--- a/arch/mips/pci/pci-rt3883.c
+++ b/arch/mips/pci/pci-rt3883.c
@@ -147,9 +147,7 @@ static void rt3883_pci_irq_handler(unsigned int irq, struct irq_desc *desc)
 	while (pending) {
 		unsigned bit = __ffs(pending);
 
-		irq = irq_find_mapping(rpc->irq_domain, bit);
-		generic_handle_irq(irq);
-
+		generic_handle_irq(irq_find_mapping(rpc->irq_domain, bit));
 		pending &= ~BIT(bit);
 	}
 }
-- 
1.7.10.4
