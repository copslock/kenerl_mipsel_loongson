Return-Path: <SRS0=KjQ3=WY=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13132C3A5A1
	for <linux-mips@archiver.kernel.org>; Wed, 28 Aug 2019 14:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E805D2080F
	for <linux-mips@archiver.kernel.org>; Wed, 28 Aug 2019 14:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfH1OEJ (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 28 Aug 2019 10:04:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:39766 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726844AbfH1ODd (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Wed, 28 Aug 2019 10:03:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8D352B653;
        Wed, 28 Aug 2019 14:03:32 +0000 (UTC)
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH net-next 12/15] net: sgi: ioc3-eth: use csum_fold
Date:   Wed, 28 Aug 2019 16:03:11 +0200
Message-Id: <20190828140315.17048-13-tbogendoerfer@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190828140315.17048-1-tbogendoerfer@suse.de>
References: <20190828140315.17048-1-tbogendoerfer@suse.de>
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

replace open coded checksum folding by csum_fold.

Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
---
 drivers/net/ethernet/sgi/ioc3-eth.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/sgi/ioc3-eth.c b/drivers/net/ethernet/sgi/ioc3-eth.c
index aea3fecfac24..82a298eea8d4 100644
--- a/drivers/net/ethernet/sgi/ioc3-eth.c
+++ b/drivers/net/ethernet/sgi/ioc3-eth.c
@@ -1393,16 +1393,12 @@ static netdev_tx_t ioc3_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		/* Sum up dest addr, src addr and protocol  */
 		ehsum = eh[0] + eh[1] + eh[2] + eh[3] + eh[4] + eh[5] + eh[6];
 
-		/* Fold ehsum.  can't use csum_fold which negates also ...  */
-		ehsum = (ehsum & 0xffff) + (ehsum >> 16);
-		ehsum = (ehsum & 0xffff) + (ehsum >> 16);
-
 		/* Skip IP header; it's sum is always zero and was
 		 * already filled in by ip_output.c
 		 */
 		csum = csum_tcpudp_nofold(ih->saddr, ih->daddr,
 					  ih->tot_len - (ih->ihl << 2),
-					  proto, 0xffff ^ ehsum);
+					  proto, csum_fold(ehsum));
 
 		csum = (csum & 0xffff) + (csum >> 16);	/* Fold again */
 		csum = (csum & 0xffff) + (csum >> 16);
-- 
2.13.7

