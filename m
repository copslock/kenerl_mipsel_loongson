Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Dec 2014 13:46:02 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:44380 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007955AbaLLMp5W156m (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Dec 2014 13:45:57 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id D12333E9432E;
        Fri, 12 Dec 2014 12:45:48 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 12 Dec 2014 12:45:51 +0000
Received: from zkakakhel-linux.le.imgtec.org (192.168.154.89) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Fri, 12 Dec 2014 12:45:50 +0000
From:   Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
To:     <ralf@linux-mips.org>
CC:     <Markos.Chandras@imgtec.com>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] mips: pci: Add ifdef around pci_proc_domain
Date:   Fri, 12 Dec 2014 12:45:39 +0000
Message-ID: <1418388339-19750-1-git-send-email-Zubair.Kakakhel@imgtec.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.89]
Return-Path: <Zubair.Kakakhel@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44628
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Zubair.Kakakhel@imgtec.com
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

Without these, there are multiple definitions of pci_proc_domain()
and pci_domain_nr() if linux/pci.h and asm/pci.h are included.

Add #ifdefs around them

Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Reviewed-by: Markos Chandras <Markos.Chandras@imgtec.com>
---
 arch/mips/include/asm/pci.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/include/asm/pci.h b/arch/mips/include/asm/pci.h
index 6952962..193b4c6 100644
--- a/arch/mips/include/asm/pci.h
+++ b/arch/mips/include/asm/pci.h
@@ -121,6 +121,7 @@ static inline void pci_dma_burst_advice(struct pci_dev *pdev,
 }
 #endif
 
+#ifdef CONFIG_PCI_DOMAINS
 #define pci_domain_nr(bus) ((struct pci_controller *)(bus)->sysdata)->index
 
 static inline int pci_proc_domain(struct pci_bus *bus)
@@ -128,6 +129,7 @@ static inline int pci_proc_domain(struct pci_bus *bus)
 	struct pci_controller *hose = bus->sysdata;
 	return hose->need_domain_info;
 }
+#endif /* CONFIG_PCI_DOMAINS */
 
 #endif /* __KERNEL__ */
 
-- 
1.9.1
