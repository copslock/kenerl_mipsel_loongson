Return-Path: <SRS0=IGt2=VV=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 491DEC76191
	for <linux-mips@archiver.kernel.org>; Wed, 24 Jul 2019 08:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26E7B21873
	for <linux-mips@archiver.kernel.org>; Wed, 24 Jul 2019 08:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbfGXITW (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 24 Jul 2019 04:19:22 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:35825 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbfGXITV (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Wed, 24 Jul 2019 04:19:21 -0400
X-Originating-IP: 86.250.200.211
Received: from localhost (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 659F1E0004;
        Wed, 24 Jul 2019 08:19:19 +0000 (UTC)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net, richardcochran@gmail.com,
        alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com,
        ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, linux-mips@vger.kernel.org,
        thomas.petazzoni@bootlin.com, allan.nielsen@microchip.com
Subject: [PATCH net-next v3 7/8] net: mscc: remove the frame_info cpuq member
Date:   Wed, 24 Jul 2019 10:17:14 +0200
Message-Id: <20190724081715.29159-8-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190724081715.29159-1-antoine.tenart@bootlin.com>
References: <20190724081715.29159-1-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

In struct frame_info, the cpuq member is never used. This cosmetic patch
removes it from the structure, and from the parsing of the frame header
as it's only set but never used.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/net/ethernet/mscc/ocelot.h       | 1 -
 drivers/net/ethernet/mscc/ocelot_board.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/mscc/ocelot.h b/drivers/net/ethernet/mscc/ocelot.h
index e0da8b4eddf2..515dee6fa8a6 100644
--- a/drivers/net/ethernet/mscc/ocelot.h
+++ b/drivers/net/ethernet/mscc/ocelot.h
@@ -45,7 +45,6 @@ struct frame_info {
 	u32 len;
 	u16 port;
 	u16 vid;
-	u8 cpuq;
 	u8 tag_type;
 };
 
diff --git a/drivers/net/ethernet/mscc/ocelot_board.c b/drivers/net/ethernet/mscc/ocelot_board.c
index 5e4f1718dd99..df8d15994a89 100644
--- a/drivers/net/ethernet/mscc/ocelot_board.c
+++ b/drivers/net/ethernet/mscc/ocelot_board.c
@@ -33,7 +33,6 @@ static int ocelot_parse_ifh(u32 *_ifh, struct frame_info *info)
 
 	info->port = IFH_EXTRACT_BITFIELD64(ifh[1], 43, 4);
 
-	info->cpuq = IFH_EXTRACT_BITFIELD64(ifh[1], 20, 8);
 	info->tag_type = IFH_EXTRACT_BITFIELD64(ifh[1], 16,  1);
 	info->vid = IFH_EXTRACT_BITFIELD64(ifh[1], 0,  12);
 
-- 
2.21.0

