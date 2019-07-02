Return-Path: <SRS0=dwk6=VA=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D7B3C5B57D
	for <linux-mips@archiver.kernel.org>; Wed,  3 Jul 2019 00:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70BA4218AD
	for <linux-mips@archiver.kernel.org>; Wed,  3 Jul 2019 00:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfGCAkf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 2 Jul 2019 20:40:35 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:45130 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbfGCAkf (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Tue, 2 Jul 2019 20:40:35 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C0FD613EABC39;
        Tue,  2 Jul 2019 14:06:03 -0700 (PDT)
Date:   Tue, 02 Jul 2019 14:06:03 -0700 (PDT)
Message-Id: <20190702.140603.579018215880523684.davem@davemloft.net>
To:     opensource@vdorst.com
Cc:     sean.wang@mediatek.com, f.fainelli@gmail.com,
        linux@armlinux.org.uk, matthias.bgg@gmail.com, andrew@lunn.ch,
        vivien.didelot@gmail.com, frank-w@public-files.de,
        netdev@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: mediatek: Allow non TRGMII mode with
 MT7621 DDR2 devices
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190629122451.19578-1-opensource@vdorst.com>
References: <20190629122451.19578-1-opensource@vdorst.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 02 Jul 2019 14:06:04 -0700 (PDT)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

From: René van Dorst <opensource@vdorst.com>
Date: Sat, 29 Jun 2019 14:24:51 +0200

> No reason to error out on a MT7621 device with DDR2 memory when non
> TRGMII mode is selected.
> Only MT7621 DDR2 clock setup is not supported for TRGMII mode.
> But non TRGMII mode doesn't need any special clock setup.
> 
> Signed-off-by: René van Dorst <opensource@vdorst.com>

Applied to net-next, thanks.
