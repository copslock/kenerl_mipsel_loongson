Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Nov 2017 23:15:07 +0100 (CET)
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:53772 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992911AbdKNWNAzlUXv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Nov 2017 23:13:00 +0100
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.224.233])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id EDBDE30C01E;
        Tue, 14 Nov 2017 14:12:58 -0800 (PST)
Received: from stbsrv-and-3.and.broadcom.com (stbsrv-and-3.and.broadcom.com [10.28.16.21])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id 4672281EAE;
        Tue, 14 Nov 2017 14:12:56 -0800 (PST)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jonas Gorski <jonas.gorski@gmail.com>
Cc:     linux-pci@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Jim Quinlan <jim2101024@gmail.com>
Subject: [PATCH v3 5/8] PCI/MSI: Enable PCI_MSI_IRQ_DOMAIN support for MIPS
Date:   Tue, 14 Nov 2017 17:12:09 -0500
Message-Id: <1510697532-32828-6-git-send-email-jim2101024@gmail.com>
X-Mailer: git-send-email 1.9.0.138.g2de3478
In-Reply-To: <1510697532-32828-1-git-send-email-jim2101024@gmail.com>
References: <1510697532-32828-1-git-send-email-jim2101024@gmail.com>
Return-Path: <jim2101024@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60944
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jim2101024@gmail.com
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

Add MIPS as an arch that supports PCI_MSI_IRQ_DOMAIN and add
generation of msi.h in the MIPS arch.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 arch/mips/include/asm/Kbuild | 1 +
 drivers/pci/Kconfig          | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/Kbuild b/arch/mips/include/asm/Kbuild
index 7c8aab2..8c78ba7 100644
--- a/arch/mips/include/asm/Kbuild
+++ b/arch/mips/include/asm/Kbuild
@@ -9,6 +9,7 @@ generic-y += irq_work.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
+generic-y += msi.h
 generic-y += parport.h
 generic-y += percpu.h
 generic-y += preempt.h
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index c32a77f..927c335 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -25,7 +25,7 @@ config PCI_MSI
 	   If you don't know what to do here, say Y.
 
 config PCI_MSI_IRQ_DOMAIN
-	def_bool ARC || ARM || ARM64 || X86
+	def_bool ARC || ARM || ARM64 || MIPS || X86
 	depends on PCI_MSI
 	select GENERIC_MSI_IRQ_DOMAIN
 
-- 
1.9.0.138.g2de3478
