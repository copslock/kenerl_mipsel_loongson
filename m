Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Jan 2013 20:48:49 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:37367 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6820301Ab3A2TssAm-X5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 29 Jan 2013 20:48:48 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>,
        Conor O'Gorman <i@conorogorman.net>
Subject: [PATCH] MIPS: lantiq: fix cp0_perfcount_irq mapping
Date:   Tue, 29 Jan 2013 20:46:02 +0100
Message-Id: <1359488762-13076-1-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
X-archive-position: 35619
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

The introduction of the OF support broken the cp0_perfcount_irq mapping. This
resulted in oprofile not working anymore.

Offending commit is :

commit 3645da0276ae9f6938ff29b13904b803ecb68424
Author: John Crispin <blogic@openwrt.org>
Date:   Tue Apr 17 10:18:32 2012 +0200

OF: MIPS: lantiq: implement irq_domain support

Signed-off-by: Conor O'Gorman <i@conorogorman.net>
Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/lantiq/irq.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/lantiq/irq.c b/arch/mips/lantiq/irq.c
index 6f84009..5119487 100644
--- a/arch/mips/lantiq/irq.c
+++ b/arch/mips/lantiq/irq.c
@@ -449,7 +449,7 @@ int __init icu_of_init(struct device_node *node, struct device_node *parent)
 #endif
 
 	/* tell oprofile which irq to use */
-	cp0_perfcount_irq = LTQ_PERF_IRQ;
+	cp0_perfcount_irq = irq_create_mapping(ltq_domain, LTQ_PERF_IRQ);
 
 	/*
 	 * if the timer irq is not one of the mips irqs we need to
-- 
1.7.10.4
