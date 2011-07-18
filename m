Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Jul 2011 22:03:36 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:44583 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491106Ab1GRUDD (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 18 Jul 2011 22:03:03 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <blogic@openwrt.org>, linux-mips@linux-mips.org
Subject: [PATCH 2/3] MIPS: lantiq: fix setting the PCI bus speed on AR9
Date:   Mon, 18 Jul 2011 22:04:12 +0200
Message-Id: <1311019453-21277-2-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1311019453-21277-1-git-send-email-blogic@openwrt.org>
References: <1311019453-21277-1-git-send-email-blogic@openwrt.org>
X-archive-position: 30646
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 12692

The bits used to set the PCI bus speed on AR9 are slightly different to those
used on Danube.

Signed-off-by: John Crispin <blogic@openwrt.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/pci/pci-lantiq.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/mips/pci/pci-lantiq.c b/arch/mips/pci/pci-lantiq.c
index 603d749..8656388 100644
--- a/arch/mips/pci/pci-lantiq.c
+++ b/arch/mips/pci/pci-lantiq.c
@@ -171,8 +171,13 @@ static int __devinit ltq_pci_startup(struct ltq_pci_data *conf)
 	u32 temp_buffer;
 
 	/* set clock to 33Mhz */
-	ltq_cgu_w32(ltq_cgu_r32(LTQ_CGU_IFCCR) & ~0xf00000, LTQ_CGU_IFCCR);
-	ltq_cgu_w32(ltq_cgu_r32(LTQ_CGU_IFCCR) | 0x800000, LTQ_CGU_IFCCR);
+	if (ltq_is_ar9()) {
+		ltq_cgu_w32(ltq_cgu_r32(LTQ_CGU_IFCCR) & ~0x1f00000, LTQ_CGU_IFCCR);
+		ltq_cgu_w32(ltq_cgu_r32(LTQ_CGU_IFCCR) | 0xe00000, LTQ_CGU_IFCCR);
+	} else {
+		ltq_cgu_w32(ltq_cgu_r32(LTQ_CGU_IFCCR) & ~0xf00000, LTQ_CGU_IFCCR);
+		ltq_cgu_w32(ltq_cgu_r32(LTQ_CGU_IFCCR) | 0x800000, LTQ_CGU_IFCCR);
+	}
 
 	/* external or internal clock ? */
 	if (conf->clock) {
-- 
1.7.2.3
