Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Aug 2016 17:39:37 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:47528 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992489AbcHZPi4vfkpI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Aug 2016 17:38:56 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 431A2C4BFA743;
        Fri, 26 Aug 2016 16:38:37 +0100 (IST)
Received: from localhost (10.100.200.141) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 26 Aug
 2016 16:38:40 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-kernel@vger.kernel.org>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH 03/26] MIPS: PCI: Inline pcibios_assign_all_busses
Date:   Fri, 26 Aug 2016 16:37:02 +0100
Message-ID: <20160826153725.11629-4-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160826153725.11629-1-paul.burton@imgtec.com>
References: <20160826153725.11629-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.141]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54787
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

The MIPS implementation of pcibios_assign_all_busses trivially returns
1. Implement it as a static function in asm/pci.h such that the compiler
can inline it & optimise out never-taken paths.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/include/asm/pci.h | 6 ++++--
 arch/mips/pci/pci.c         | 5 -----
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/mips/include/asm/pci.h b/arch/mips/include/asm/pci.h
index 0564692..acc651e 100644
--- a/arch/mips/include/asm/pci.h
+++ b/arch/mips/include/asm/pci.h
@@ -66,8 +66,10 @@ extern int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin);
 /* Can be used to override the logic in pci_scan_bus for skipping
    already-configured bus numbers - to be used for buggy BIOSes
    or architectures with incomplete PCI setup by the loader */
-
-extern unsigned int pcibios_assign_all_busses(void);
+static inline unsigned int pcibios_assign_all_busses(void)
+{
+	return 1;
+}
 
 extern unsigned long PCIBIOS_MIN_IO;
 extern unsigned long PCIBIOS_MIN_MEM;
diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
index 30320a4..8cc6ea4 100644
--- a/arch/mips/pci/pci.c
+++ b/arch/mips/pci/pci.c
@@ -297,11 +297,6 @@ static int pcibios_enable_resources(struct pci_dev *dev, int mask)
 	return 0;
 }
 
-unsigned int pcibios_assign_all_busses(void)
-{
-	return 1;
-}
-
 int pcibios_enable_device(struct pci_dev *dev, int mask)
 {
 	int err;
-- 
2.9.3
