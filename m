Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Nov 2011 21:50:43 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:4086 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904245Ab1KGUue (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Nov 2011 21:50:34 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4eb844be0000>; Mon, 07 Nov 2011 12:51:10 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 7 Nov 2011 12:49:47 -0800
Received: from dd1.caveonetworks.com ([64.2.3.195]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 7 Nov 2011 12:49:46 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id pA7Knkoc001900;
        Mon, 7 Nov 2011 12:49:46 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id pA7KnhQG001898;
        Mon, 7 Nov 2011 12:49:43 -0800
From:   David Daney <david.daney@cavium.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        netdev@vger.kernel.org, gregkh@suse.de, devel@driverdev.osuosl.org
Cc:     ddaney.cavm@gmail.com, David Daney <david.daney@cavium.com>
Subject: [PATCH] staging: octeon-ethernet: Fix compile error caused by changed to struct skb_frag_struct.
Date:   Mon,  7 Nov 2011 12:49:30 -0800
Message-Id: <1320698970-1854-1-git-send-email-david.daney@cavium.com>
X-Mailer: git-send-email 1.7.2.3
X-OriginalArrivalTime: 07 Nov 2011 20:49:47.0061 (UTC) FILETIME=[C908B650:01CC9D8E]
X-archive-position: 31418
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 6024

Evidently the definition of struct skb_frag_struct has changed, so we
need to change to match it.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 drivers/staging/octeon/ethernet-tx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/octeon/ethernet-tx.c b/drivers/staging/octeon/ethernet-tx.c
index b445cd6..2542c37 100644
--- a/drivers/staging/octeon/ethernet-tx.c
+++ b/drivers/staging/octeon/ethernet-tx.c
@@ -275,7 +275,7 @@ int cvm_oct_xmit(struct sk_buff *skb, struct net_device *dev)
 		CVM_OCT_SKB_CB(skb)[0] = hw_buffer.u64;
 		for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
 			struct skb_frag_struct *fs = skb_shinfo(skb)->frags + i;
-			hw_buffer.s.addr = XKPHYS_TO_PHYS((u64)(page_address(fs->page) + fs->page_offset));
+			hw_buffer.s.addr = XKPHYS_TO_PHYS((u64)(page_address(fs->page.p) + fs->page_offset));
 			hw_buffer.s.size = fs->size;
 			CVM_OCT_SKB_CB(skb)[i + 1] = hw_buffer.u64;
 		}
-- 
1.7.2.3
