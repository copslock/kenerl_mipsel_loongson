Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 May 2014 13:22:30 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.89.28.114]:3425 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-FAIL-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6839027AbaEGLVhVa4is (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 May 2014 13:21:37 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 6E7F5C6018A0E
        for <linux-mips@linux-mips.org>; Wed,  7 May 2014 12:21:28 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (192.168.5.97) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.181.6; Wed, 7 May
 2014 12:21:30 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (192.168.5.97) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Wed, 7 May 2014 12:21:30 +0100
Received: from pburton-linux.le.imgtec.org (192.168.154.79) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Wed, 7 May 2014 12:21:29 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 3/5] MIPS: Malta: let PIIX4 respond to PCI special cycles
Date:   Wed, 7 May 2014 12:20:58 +0100
Message-ID: <1399461660-17623-4-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1399461660-17623-1-git-send-email-paul.burton@imgtec.com>
References: <1399461660-17623-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.79]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40042
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

This patch enables the PIIX4 to respond to special cycles on the PCI
bus. One such special cycle must be used in order to enter a suspend
state, and if response to it is not enabled then the suspend state will
never be entered.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/pci/fixup-malta.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/mips/pci/fixup-malta.c b/arch/mips/pci/fixup-malta.c
index 2f9e52a..40e920c 100644
--- a/arch/mips/pci/fixup-malta.c
+++ b/arch/mips/pci/fixup-malta.c
@@ -68,6 +68,7 @@ static void malta_piix_func0_fixup(struct pci_dev *pdev)
 {
 	unsigned char reg_val;
 	u32 reg_val32;
+	u16 reg_val16;
 	/* PIIX PIRQC[A:D] irq mappings */
 	static int piixirqmap[PIIX4_FUNC0_PIRQRC_IRQ_ROUTING_MAX] = {
 		0,  0,	0,  3,
@@ -107,6 +108,11 @@ static void malta_piix_func0_fixup(struct pci_dev *pdev)
 	pci_read_config_byte(pdev, PIIX4_FUNC0_SERIRQC, &reg_val);
 	reg_val |= PIIX4_FUNC0_SERIRQC_EN | PIIX4_FUNC0_SERIRQC_CONT;
 	pci_write_config_byte(pdev, PIIX4_FUNC0_SERIRQC, reg_val);
+
+	/* Enable response to special cycles */
+	pci_read_config_word(pdev, PCI_COMMAND, &reg_val16);
+	pci_write_config_word(pdev, PCI_COMMAND,
+			      reg_val16 | PCI_COMMAND_SPECIAL);
 }
 
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371AB_0,
-- 
1.8.5.3
