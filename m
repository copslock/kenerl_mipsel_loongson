Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Aug 2012 11:12:00 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:50538 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903518Ab2HPJKl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 16 Aug 2012 11:10:41 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH 4/4] MIPS: lantiq: external irq sources are not loaded properly
Date:   Thu, 16 Aug 2012 11:09:22 +0200
Message-Id: <1345108162-1080-4-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.9.1
In-Reply-To: <1345108162-1080-1-git-send-email-blogic@openwrt.org>
References: <1345108162-1080-1-git-send-email-blogic@openwrt.org>
X-archive-position: 34198
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

Support for the external interrupt unit was broken when the code was converted
to devicetree support.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/lantiq/irq.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/lantiq/irq.c b/arch/mips/lantiq/irq.c
index 87f15d6..f36acd1 100644
--- a/arch/mips/lantiq/irq.c
+++ b/arch/mips/lantiq/irq.c
@@ -341,7 +341,7 @@ int __init icu_of_init(struct device_node *node, struct device_node *parent)
 
 	/* the external interrupts are optional and xway only */
 	eiu_node = of_find_compatible_node(NULL, NULL, "lantiq,eiu");
-	if (eiu_node && of_address_to_resource(eiu_node, 0, &res)) {
+	if (eiu_node && !of_address_to_resource(eiu_node, 0, &res)) {
 		/* find out how many external irq sources we have */
 		const __be32 *count = of_get_property(node,
 							"lantiq,count",	NULL);
-- 
1.7.9.1
