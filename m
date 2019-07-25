Return-Path: <SRS0=prOJ=VW=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C95C7618B
	for <linux-mips@archiver.kernel.org>; Thu, 25 Jul 2019 07:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEC532081B
	for <linux-mips@archiver.kernel.org>; Thu, 25 Jul 2019 07:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388025AbfGYHYJ (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 25 Jul 2019 03:24:09 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:43109 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387990AbfGYHYJ (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Thu, 25 Jul 2019 03:24:09 -0400
X-Originating-IP: 86.250.200.211
Received: from localhost (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 25234C000D;
        Thu, 25 Jul 2019 07:24:06 +0000 (UTC)
Date:   Thu, 25 Jul 2019 09:24:06 +0200
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     David Miller <davem@davemloft.net>
Cc:     antoine.tenart@bootlin.com, richardcochran@gmail.com,
        alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com,
        ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org,
        netdev@vger.kernel.org, linux-mips@vger.kernel.org,
        thomas.petazzoni@bootlin.com, allan.nielsen@microchip.com
Subject: Re: [PATCH net-next v3 8/8] net: mscc: PTP Hardware Clock (PHC)
 support
Message-ID: <20190725072406.GA3235@kwain>
References: <20190724081715.29159-1-antoine.tenart@bootlin.com>
 <20190724081715.29159-9-antoine.tenart@bootlin.com>
 <20190724.115226.478045379512899769.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190724.115226.478045379512899769.davem@davemloft.net>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hi David,

On Wed, Jul 24, 2019 at 11:52:26AM -0700, David Miller wrote:
> From: Antoine Tenart <antoine.tenart@bootlin.com>
> Date: Wed, 24 Jul 2019 10:17:15 +0200
> 
> > +static int ocelot_ptp_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
> > +{
> > +	struct ocelot *ocelot = container_of(ptp, struct ocelot, ptp_info);
> > +	u32 unit = 0, direction = 0;
> > +	unsigned long flags;
>                       ^^^^
> > +	u64 adj = 0;
> > +
> > +	if (!scaled_ppm)
> > +		goto disable_adj;
>  ...
> > +disable_adj:
> > +	ocelot_write(ocelot, 0, PTP_CLK_CFG_ADJ_CFG);
> > +
> > +	spin_unlock_irqrestore(&ocelot->ptp_clock_lock, flags);
>                                                         ^^^^^
> Did GCC really not warn about this in your build like it did immediately
> on mine?

I was using gcc8 for mips32, and it did not warn about this. Sorry about
that.

> drivers/net/ethernet/mscc/ocelot.c: In function ‘ocelot_ptp_adjfine’:
> ./include/linux/spinlock.h:288:3: warning: ‘flags’ may be used uninitialized in this function [-Wmaybe-uninitialized]
>    _raw_spin_unlock_irqrestore(lock, flags); \
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Please fix this and when you respin please just elide the MIPS tree
> patches and just keep all the ones that I should apply to net-next.

OK, will do.

Thanks!
Antoine

-- 
Antoine Ténart, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
