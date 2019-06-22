Return-Path: <SRS0=Sfs/=UV=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BFD4C43613
	for <linux-mips@archiver.kernel.org>; Sat, 22 Jun 2019 23:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CF0C2070B
	for <linux-mips@archiver.kernel.org>; Sat, 22 Jun 2019 23:58:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfFVX6o convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@archiver.kernel.org>);
        Sat, 22 Jun 2019 19:58:44 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:32964 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbfFVX6o (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Sat, 22 Jun 2019 19:58:44 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id CF63E1540C18B;
        Sat, 22 Jun 2019 16:58:42 -0700 (PDT)
Date:   Sat, 22 Jun 2019 16:58:42 -0700 (PDT)
Message-Id: <20190622.165842.918757451860285746.davem@davemloft.net>
To:     opensource@vdorst.com
Cc:     frank-w@public-files.de, sean.wang@mediatek.com,
        f.fainelli@gmail.com, matthias.bgg@gmail.com, andrew@lunn.ch,
        vivien.didelot@gmail.com, netdev@vger.kernel.org, john@phrozen.org,
        linux-mediatek@lists.infradead.org, linux-mips@vger.kernel.org
Subject: Re: [PATCH v2 net-next 0/2] net: mediatek: Add MT7621 TRGMII mode
 support
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190620122155.32078-1-opensource@vdorst.com>
References: <20190620122155.32078-1-opensource@vdorst.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 22 Jun 2019 16:58:43 -0700 (PDT)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

From: Ren� van Dorst <opensource@vdorst.com>
Date: Thu, 20 Jun 2019 14:21:53 +0200

> Like many other mediatek SOCs, the MT7621 SOC and the internal MT7530
> switch both supports TRGMII mode. MT7621 TRGMII speed is fix 1200MBit.
> 
> v1->v2: 
>  - Fix breakage on non MT7621 SOC
>  - Support 25MHz and 40MHz XTAL as MT7530 clocksource

Series applied, thanks.
