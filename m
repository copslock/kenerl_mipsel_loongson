Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 15 Apr 2018 17:02:05 +0200 (CEST)
Received: from bombadil.infradead.org ([IPv6:2607:7c80:54:e::133]:41294 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994614AbeDOPAh02GXu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 15 Apr 2018 17:00:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=JDYl8u3wrO9qilfm+B09eTkREpDja4QCKB/4bOYzQ9M=; b=kHdgi5cb8uKCyYqdixjwi2t5T
        BnroMohLhAYl5rFaID2cG0mm6sa+WZKCJjGFqObisbXKwkhUTmJBCWt6P1FpWGIHynYq7vQpH02wK
        vsjCYCJr3R4e+77/+j/et0jIc3HCx7SrvebizNF+yekPAkdWxAQyCriavXX5L4Wf62kzQstNlNkya
        vYh2z3YxNjj2ra05PMx32vSAzqPk6s0fKo8qFC7Iv8qDUWpkw92k6L4q1tmAPF5YriiMORnBzGL6S
        cdM847lBzKIKKzzfzsK1pSB7qkyYlhzpoxTVaxmrfzWxVCACfXboj98HYrpW5nRuBA4n11/OsJH46
        EvVIgqUzQ==;
Received: from 089144200254.atnat0009.highway.a1.net ([89.144.200.254] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1f7j8e-00073R-Ep; Sun, 15 Apr 2018 15:00:21 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        iommu@lists.linux-foundation.org
Cc:     x86@kernel.org, linux-block@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-mm@kvack.org,
        linux-ide@vger.kernel.org, linux-mips@linux-mips.org,
        sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 09/12] PCI: remove CONFIG_PCI_BUS_ADDR_T_64BIT
Date:   Sun, 15 Apr 2018 16:59:44 +0200
Message-Id: <20180415145947.1248-10-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180415145947.1248-1-hch@lst.de>
References: <20180415145947.1248-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+7d17fcac680d61fee2d2+5348+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63545
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@lst.de
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

This symbol is now always identical to CONFIG_ARCH_DMA_ADDR_T_64BIT, so
remove it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/pci/Kconfig | 4 ----
 drivers/pci/bus.c   | 4 ++--
 include/linux/pci.h | 2 +-
 3 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 34b56a8f8480..29a487f31dae 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -5,10 +5,6 @@
 
 source "drivers/pci/pcie/Kconfig"
 
-config PCI_BUS_ADDR_T_64BIT
-	def_bool y if (ARCH_DMA_ADDR_T_64BIT || 64BIT)
-	depends on PCI
-
 config PCI_MSI
 	bool "Message Signaled Interrupts (MSI and MSI-X)"
 	depends on PCI
diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index bc2ded4c451f..35b7fc87eac5 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -120,7 +120,7 @@ int devm_request_pci_bus_resources(struct device *dev,
 EXPORT_SYMBOL_GPL(devm_request_pci_bus_resources);
 
 static struct pci_bus_region pci_32_bit = {0, 0xffffffffULL};
-#ifdef CONFIG_PCI_BUS_ADDR_T_64BIT
+#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
 static struct pci_bus_region pci_64_bit = {0,
 				(pci_bus_addr_t) 0xffffffffffffffffULL};
 static struct pci_bus_region pci_high = {(pci_bus_addr_t) 0x100000000ULL,
@@ -230,7 +230,7 @@ int pci_bus_alloc_resource(struct pci_bus *bus, struct resource *res,
 					  resource_size_t),
 		void *alignf_data)
 {
-#ifdef CONFIG_PCI_BUS_ADDR_T_64BIT
+#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
 	int rc;
 
 	if (res->flags & IORESOURCE_MEM_64) {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 73178a2fcee0..55371cb827ad 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -670,7 +670,7 @@ int raw_pci_read(unsigned int domain, unsigned int bus, unsigned int devfn,
 int raw_pci_write(unsigned int domain, unsigned int bus, unsigned int devfn,
 		  int reg, int len, u32 val);
 
-#ifdef CONFIG_PCI_BUS_ADDR_T_64BIT
+#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
 typedef u64 pci_bus_addr_t;
 #else
 typedef u32 pci_bus_addr_t;
-- 
2.17.0
