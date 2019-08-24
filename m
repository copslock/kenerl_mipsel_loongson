Return-Path: <SRS0=Wt1X=WU=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FBBCC3A59E
	for <linux-mips@archiver.kernel.org>; Sat, 24 Aug 2019 21:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 537EE20870
	for <linux-mips@archiver.kernel.org>; Sat, 24 Aug 2019 21:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbfHXVSH (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sat, 24 Aug 2019 17:18:07 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:47676 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbfHXVSH (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Sat, 24 Aug 2019 17:18:07 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C951915251CF9;
        Sat, 24 Aug 2019 14:18:05 -0700 (PDT)
Date:   Sat, 24 Aug 2019 14:18:03 -0700 (PDT)
Message-Id: <20190824.141803.1656753287804303137.davem@davemloft.net>
To:     andrew@lunn.ch
Cc:     opensource@vdorst.com, sean.wang@mediatek.com,
        vivien.didelot@gmail.com, f.fainelli@gmail.com,
        matthias.bgg@gmail.com, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, john@phrozen.org,
        linux-mips@vger.kernel.org, frank-w@public-files.de
Subject: Re: [PATCH net-next v2 0/3] net: dsa: mt7530: Convert to PHYLINK
 and add support for port 5
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190823010928.GK13020@lunn.ch>
References: <20190821144547.15113-1-opensource@vdorst.com>
        <20190822.162047.1140525762795777800.davem@davemloft.net>
        <20190823010928.GK13020@lunn.ch>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 24 Aug 2019 14:18:06 -0700 (PDT)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

From: Andrew Lunn <andrew@lunn.ch>
Date: Fri, 23 Aug 2019 03:09:28 +0200

> That would be Russell.
> 
> We should try to improve MAINTAINER so that Russell King gets picked
> by the get_maintainer script.

Shoule he be added to the mt7530 entry?
