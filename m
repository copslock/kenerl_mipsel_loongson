Return-Path: <SRS0=j293=UT=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A18C43613
	for <linux-mips@archiver.kernel.org>; Thu, 20 Jun 2019 12:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87EF2206E0
	for <linux-mips@archiver.kernel.org>; Thu, 20 Jun 2019 12:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=vdorst.com header.i=@vdorst.com header.b="l0AJ7yGD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731791AbfFTMXO (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 20 Jun 2019 08:23:14 -0400
Received: from mx.0dd.nl ([5.2.79.48]:53428 "EHLO mx.0dd.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726551AbfFTMXO (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Thu, 20 Jun 2019 08:23:14 -0400
Received: from mail.vdorst.com (mail.vdorst.com [IPv6:fd01::250])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.0dd.nl (Postfix) with ESMTPS id E0EFD5FE8A;
        Thu, 20 Jun 2019 14:23:11 +0200 (CEST)
Authentication-Results: mx.0dd.nl;
        dkim=pass (2048-bit key; secure) header.d=vdorst.com header.i=@vdorst.com header.b="l0AJ7yGD";
        dkim-atps=neutral
Received: from pc-rene.vdorst.com (pc-rene.vdorst.com [192.168.2.125])
        by mail.vdorst.com (Postfix) with ESMTPA id A20C01CB7225;
        Thu, 20 Jun 2019 14:23:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.vdorst.com A20C01CB7225
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vdorst.com;
        s=default; t=1561033391;
        bh=ZO1c9BII2Z2wQ9yE2KhkKyW57oPWJZCCZrdn53OOIAM=;
        h=From:To:Cc:Subject:Date:From;
        b=l0AJ7yGD4A5q1Y7bVJQ9xkaehZrsQ5e88Q7W0m9CTwZ7a/P+Vxcr2NsF58jmDOHqb
         7M1c19OGvLWyVriuYFfGLz7bbxo6B5DRZ5HAWg3WNOIqHL29mlcYtQ14+WB7BMRdJS
         VZXpV+s6yHTwaYaoXmaWi0GpA0cS37l7DdfKFWW7YRlQNyZ1ES7qPehZOEIrHkjTDf
         X5x1LgSKvU+lRnfOVVw8RntEwDYdLDcwkVPiGc2LKLV2Xg+WZN8yA3pMQLFeQzLcQN
         /ydesZyqIFLhSxWqyIqRGoXsRz145P3/k5pdzrczI+I+DPgmfG0ID3hRjmXS3A915+
         n54gb2MogiOfA==
From:   =?UTF-8?q?Ren=C3=A9=20van=20Dorst?= <opensource@vdorst.com>
To:     frank-w@public-files.de, sean.wang@mediatek.com,
        f.fainelli@gmail.com, davem@davemloft.net, matthias.bgg@gmail.com,
        andrew@lunn.ch, vivien.didelot@gmail.com
Cc:     netdev@vger.kernel.org, john@phrozen.org,
        linux-mediatek@lists.infradead.org, linux-mips@vger.kernel.org,
        =?UTF-8?q?Ren=C3=A9=20van=20Dorst?= <opensource@vdorst.com>
Subject: [PATCH v2 net-next 0/2] net: mediatek: Add MT7621 TRGMII mode support
Date:   Thu, 20 Jun 2019 14:21:53 +0200
Message-Id: <20190620122155.32078-1-opensource@vdorst.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Like many other mediatek SOCs, the MT7621 SOC and the internal MT7530
switch both supports TRGMII mode. MT7621 TRGMII speed is fix 1200MBit.

v1->v2: 
 - Fix breakage on non MT7621 SOC
 - Support 25MHz and 40MHz XTAL as MT7530 clocksource

René van Dorst (2):
  net: ethernet: mediatek: Add MT7621 TRGMII mode support
  net: dsa: mt7530: Add MT7621 TRGMII mode support

 drivers/net/dsa/mt7530.c                    | 46 ++++++++++++++++-----
 drivers/net/dsa/mt7530.h                    |  4 ++
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 38 +++++++++++++++--
 drivers/net/ethernet/mediatek/mtk_eth_soc.h | 11 +++++
 4 files changed, 85 insertions(+), 14 deletions(-)

-- 
2.20.1
