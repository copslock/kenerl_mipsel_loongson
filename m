Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Aug 2012 11:11:37 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:50536 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903487Ab2HPJKk (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 16 Aug 2012 11:10:40 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH 3/4] MIPS: lantiq: dont register irq_chip for the irq cascade
Date:   Thu, 16 Aug 2012 11:09:21 +0200
Message-Id: <1345108162-1080-3-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.9.1
In-Reply-To: <1345108162-1080-1-git-send-email-blogic@openwrt.org>
References: <1345108162-1080-1-git-send-email-blogic@openwrt.org>
X-archive-position: 34197
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

We dont want to register the irq_chip for the MIPS IRQ cascade.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/lantiq/irq.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/mips/lantiq/irq.c b/arch/mips/lantiq/irq.c
index 0cec43d..87f15d6 100644
--- a/arch/mips/lantiq/irq.c
+++ b/arch/mips/lantiq/irq.c
@@ -297,6 +297,9 @@ static int icu_map(struct irq_domain *d, unsigned int irq, irq_hw_number_t hw)
 	struct irq_chip *chip = &ltq_irq_type;
 	int i;
 
+	if (hw < MIPS_CPU_IRQ_CASCADE)
+		return 0;
+
 	for (i = 0; i < exin_avail; i++)
 		if (hw == ltq_eiu_irq[i])
 			chip = &ltq_eiu_type;
-- 
1.7.9.1
