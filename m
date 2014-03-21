Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Mar 2014 16:20:59 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.89.28.114]:49408 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6818693AbaCUPU5mdvW- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 21 Mar 2014 16:20:57 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id C110B9FE2CB46
        for <linux-mips@linux-mips.org>; Fri, 21 Mar 2014 15:20:48 +0000 (GMT)
Received: from KLMAIL02.kl.imgtec.org (192.168.5.97) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.174.1; Fri, 21 Mar
 2014 15:20:51 +0000
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (192.168.5.97) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Fri, 21 Mar 2014 15:20:51 +0000
Received: from pburton-linux.le.imgtec.org (192.168.154.79) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Fri, 21 Mar 2014 15:20:50 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 1/2] MIPS: Malta: setup PM I/O region on boot
Date:   Fri, 21 Mar 2014 15:20:31 +0000
Message-ID: <1395415232-42288-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.79]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39538
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

This patch ensures that the kernel sets a sane base address for the
PIIX4 PM I/O register region during boot. Without this the kernel may
not successfully claim the region as a resource if the bootloader didn't
configure the region. With this patch the kernel will always succeed
with:

  pci 0000:00:0a.3: quirk: [io  0x1000-0x103f] claimed by PIIX4 ACPI

The lack of the resource claiming is easily reproducible without this
patch using current versions of QEMU.

Tested-by: James Hogan <james.hogan@imgtec.com>
Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/include/asm/mips-boards/piix4.h |  5 +++++
 arch/mips/pci/fixup-malta.c               | 13 +++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/arch/mips/include/asm/mips-boards/piix4.h b/arch/mips/include/asm/mips-boards/piix4.h
index 836e2ed..9cf5404 100644
--- a/arch/mips/include/asm/mips-boards/piix4.h
+++ b/arch/mips/include/asm/mips-boards/piix4.h
@@ -50,4 +50,9 @@
 #define PIIX4_FUNC1_IDETIM_SECONDARY_HI		0x43
 #define   PIIX4_FUNC1_IDETIM_SECONDARY_HI_IDE_DECODE_EN	(1 << 7)
 
+/* Power Management Configuration Space */
+#define PIIX4_FUNC3_PMBA			0x40
+#define PIIX4_FUNC3_PMREGMISC			0x80
+#define   PIIX4_FUNC3_PMREGMISC_EN			(1 << 0)
+
 #endif /* __ASM_MIPS_BOARDS_PIIX4_H */
diff --git a/arch/mips/pci/fixup-malta.c b/arch/mips/pci/fixup-malta.c
index 7a0eda7..2f9e52a 100644
--- a/arch/mips/pci/fixup-malta.c
+++ b/arch/mips/pci/fixup-malta.c
@@ -51,6 +51,19 @@ int pcibios_plat_dev_init(struct pci_dev *dev)
 	return 0;
 }
 
+static void malta_piix_func3_base_fixup(struct pci_dev *dev)
+{
+	/* Set a sane PM I/O base address */
+	pci_write_config_word(dev, PIIX4_FUNC3_PMBA, 0x1000);
+
+	/* Enable access to the PM I/O region */
+	pci_write_config_byte(dev, PIIX4_FUNC3_PMREGMISC,
+			      PIIX4_FUNC3_PMREGMISC_EN);
+}
+
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371AB_3,
+			malta_piix_func3_base_fixup);
+
 static void malta_piix_func0_fixup(struct pci_dev *pdev)
 {
 	unsigned char reg_val;
-- 
1.8.5.3
