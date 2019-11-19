Return-Path: <SRS0=PhWg=ZL=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 851FDC432C0
	for <linux-mips@archiver.kernel.org>; Tue, 19 Nov 2019 11:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EEB62230D
	for <linux-mips@archiver.kernel.org>; Tue, 19 Nov 2019 11:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbfKSLJG (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 19 Nov 2019 06:09:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:53472 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726351AbfKSLJG (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Tue, 19 Nov 2019 06:09:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8B88FB488;
        Tue, 19 Nov 2019 11:09:04 +0000 (UTC)
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paulburton@kernel.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] MIPS: PCI: remember nasid changed by set interrupt affinity
Date:   Tue, 19 Nov 2019 12:08:57 +0100
Message-Id: <20191119110857.28540-2-tbogendoerfer@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191119110857.28540-1-tbogendoerfer@suse.de>
References: <20191119110857.28540-1-tbogendoerfer@suse.de>
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

When changing interrupt affinity remember the possible changed nasid,
otherwise an interrupt deactivate/activate sequence will incorrectly
setup interrupt.

Fixes: e6308b6d35ea ("MIPS: SGI-IP27: abstract chipset irq from bridge")
Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
---
 arch/mips/pci/pci-xtalk-bridge.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/mips/pci/pci-xtalk-bridge.c b/arch/mips/pci/pci-xtalk-bridge.c
index b475cf5aef2f..5c1a196be0c5 100644
--- a/arch/mips/pci/pci-xtalk-bridge.c
+++ b/arch/mips/pci/pci-xtalk-bridge.c
@@ -306,16 +306,15 @@ static int bridge_set_affinity(struct irq_data *d, const struct cpumask *mask,
 	struct bridge_irq_chip_data *data = d->chip_data;
 	int bit = d->parent_data->hwirq;
 	int pin = d->hwirq;
-	nasid_t nasid;
 	int ret, cpu;
 
 	ret = irq_chip_set_affinity_parent(d, mask, force);
 	if (ret >= 0) {
 		cpu = cpumask_first_and(mask, cpu_online_mask);
-		nasid = cpu_to_node(cpu);
+		data->nasid = cpu_to_node(cpu);
 		bridge_write(data->bc, b_int_addr[pin].addr,
 			     (((data->bc->intr_addr >> 30) & 0x30000) |
-			      bit | (nasid << 8)));
+			      bit | (data->nasid << 8)));
 		bridge_read(data->bc, b_wid_tflush);
 	}
 	return ret;
-- 
2.16.4

