Return-Path: <SRS0=aTje=VC=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C03C46499
	for <linux-mips@archiver.kernel.org>; Fri,  5 Jul 2019 19:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D343B2133F
	for <linux-mips@archiver.kernel.org>; Fri,  5 Jul 2019 19:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfGETza (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 5 Jul 2019 15:55:30 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:60603 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727179AbfGETza (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Fri, 5 Jul 2019 15:55:30 -0400
X-Originating-IP: 90.76.143.236
Received: from localhost (lfbn-1-2078-236.w90-76.abo.wanadoo.fr [90.76.143.236])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 06958E0004;
        Fri,  5 Jul 2019 19:55:22 +0000 (UTC)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net, richardcochran@gmail.com,
        alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com,
        ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, linux-mips@vger.kernel.org,
        thomas.petazzoni@bootlin.com, allan.nielsen@microchip.com
Subject: [PATCH net-next v2 6/8] net: mscc: improve the frame header parsing readability
Date:   Fri,  5 Jul 2019 21:52:11 +0200
Message-Id: <20190705195213.22041-7-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190705195213.22041-1-antoine.tenart@bootlin.com>
References: <20190705195213.22041-1-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

This cosmetic patch improves the frame header parsing readability by
introducing a new macro to access and mask its fields.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/net/ethernet/mscc/ocelot_board.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/mscc/ocelot_board.c b/drivers/net/ethernet/mscc/ocelot_board.c
index c508e51c1e28..09ad6a123347 100644
--- a/drivers/net/ethernet/mscc/ocelot_board.c
+++ b/drivers/net/ethernet/mscc/ocelot_board.c
@@ -16,24 +16,26 @@
 
 #include "ocelot.h"
 
-static int ocelot_parse_ifh(u32 *ifh, struct frame_info *info)
+#define IFH_EXTRACT_BITFIELD64(x, o, w) (((x) >> (o)) & GENMASK_ULL((w) - 1, 0))
+
+static int ocelot_parse_ifh(u32 *_ifh, struct frame_info *info)
 {
-	int i;
 	u8 llen, wlen;
+	u64 ifh[2];
+
+	ifh[0] = be64_to_cpu(((__force __be64 *)_ifh)[0]);
+	ifh[1] = be64_to_cpu(((__force __be64 *)_ifh)[1]);
 
-	/* The IFH is in network order, switch to CPU order */
-	for (i = 0; i < IFH_LEN; i++)
-		ifh[i] = ntohl((__force __be32)ifh[i]);
+	wlen = IFH_EXTRACT_BITFIELD64(ifh[0], 7,  8);
+	llen = IFH_EXTRACT_BITFIELD64(ifh[0], 15,  6);
 
-	wlen = (ifh[1] >> 7) & 0xff;
-	llen = (ifh[1] >> 15) & 0x3f;
 	info->len = OCELOT_BUFFER_CELL_SZ * wlen + llen - 80;
 
-	info->port = (ifh[2] & GENMASK(14, 11)) >> 11;
+	info->port = IFH_EXTRACT_BITFIELD64(ifh[1], 43, 4);
 
-	info->cpuq = (ifh[3] & GENMASK(27, 20)) >> 20;
-	info->tag_type = (ifh[3] & BIT(16)) >> 16;
-	info->vid = ifh[3] & GENMASK(11, 0);
+	info->cpuq = IFH_EXTRACT_BITFIELD64(ifh[1], 20, 8);
+	info->tag_type = IFH_EXTRACT_BITFIELD64(ifh[1], 16,  1);
+	info->vid = IFH_EXTRACT_BITFIELD64(ifh[1], 0,  12);
 
 	return 0;
 }
-- 
2.21.0

