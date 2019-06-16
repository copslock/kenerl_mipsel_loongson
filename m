Return-Path: <SRS0=C0/O=UP=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B453C31E50
	for <linux-mips@archiver.kernel.org>; Sun, 16 Jun 2019 18:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01A1D20862
	for <linux-mips@archiver.kernel.org>; Sun, 16 Jun 2019 18:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=vdorst.com header.i=@vdorst.com header.b="bqVTw9z6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbfFPS35 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sun, 16 Jun 2019 14:29:57 -0400
Received: from mx.0dd.nl ([5.2.79.48]:35812 "EHLO mx.0dd.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbfFPS35 (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Sun, 16 Jun 2019 14:29:57 -0400
Received: from mail.vdorst.com (mail.vdorst.com [IPv6:fd01::250])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.0dd.nl (Postfix) with ESMTPS id BCECC6049A;
        Sun, 16 Jun 2019 20:20:26 +0200 (CEST)
Authentication-Results: mx.0dd.nl;
        dkim=pass (2048-bit key; secure) header.d=vdorst.com header.i=@vdorst.com header.b="bqVTw9z6";
        dkim-atps=neutral
Received: from pc-rene.vdorst.com (pc-rene.vdorst.com [192.168.2.125])
        by mail.vdorst.com (Postfix) with ESMTPA id 811721C65C71;
        Sun, 16 Jun 2019 20:20:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.vdorst.com 811721C65C71
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vdorst.com;
        s=default; t=1560709226;
        bh=cJxXS1s1q+LMki6wCGzDmpmkzhZ9t4IB5EDQoDNc6yk=;
        h=From:To:Cc:Subject:Date:From;
        b=bqVTw9z692OAlhlk9cyH0sN8FA7xgd/gcSZ5xYPoe0qxdzbA1VYG2t6dk2bJc1zhl
         Duz6MfC4CsYL+iqWMsMOrksePP77I7PQdNZfBwCkfW6q9jHvWq/sLrqsayusUd/fPG
         TvyBc/hFJZJShV1Qi4joz193cV8PgD+Si8aRIMX+wmyb1KAc5nauFVeUFbRXL9AQQq
         pZnPGVkayXzb7J8nwUckN265BOX6DFuRYWmzJDhlw49Ym7PzIG19GeG9EfHw1DJ0xl
         TGkF7dANVFkm8CHkEc9vE6W3MIT8OhVpCx6jPY3KWF1XHZCqpdglnVV9y8DL+Gut6P
         nbXHCjke3gWeQ==
From:   =?UTF-8?q?Ren=C3=A9=20van=20Dorst?= <opensource@vdorst.com>
To:     Sean Wang <sean.wang@mediatek.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>
Cc:     netdev@vger.kernel.org, john@phrozen.org,
        linux-mediatek@lists.infradead.org, linux-mips@vger.kernel.org,
        =?UTF-8?q?Ren=C3=A9=20van=20Dorst?= <opensource@vdorst.com>
Subject: [PATCH net-next 0/2] net: mediatek: Add MT7621 TRGMII mode support
Date:   Sun, 16 Jun 2019 20:20:08 +0200
Message-Id: <20190616182010.18778-1-opensource@vdorst.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Like many other mediatek SOCs, the MT7621 SOC and the internal MT7530 switch both
supports TRGMII mode. MT7621 TRGMII speed is 1200MBit.

René van Dorst (2):
  net: ethernet: mediatek: Add MT7621 TRGMII mode support
  net: dsa: mt7530: Add MT7621 TRGMII mode support

 drivers/net/dsa/mt7530.c                    | 15 ++++++--
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 38 ++++++++++++++++++---
 drivers/net/ethernet/mediatek/mtk_eth_soc.h | 11 ++++++
 3 files changed, 58 insertions(+), 6 deletions(-)

-- 
2.20.1

