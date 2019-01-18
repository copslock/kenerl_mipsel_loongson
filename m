Return-Path: <SRS0=gTW6=P2=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B47BC43387
	for <linux-mips@archiver.kernel.org>; Fri, 18 Jan 2019 09:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02DEA2086D
	for <linux-mips@archiver.kernel.org>; Fri, 18 Jan 2019 09:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbfARJIn (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 18 Jan 2019 04:08:43 -0500
Received: from mail.bootlin.com ([62.4.15.54]:35559 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbfARJIn (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Fri, 18 Jan 2019 04:08:43 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 09B32207AC; Fri, 18 Jan 2019 10:08:41 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr [90.88.156.87])
        by mail.bootlin.com (Postfix) with ESMTPSA id D0073206A7;
        Fri, 18 Jan 2019 10:08:40 +0100 (CET)
Date:   Fri, 18 Jan 2019 10:08:41 +0100
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     Richard Cochran <richardcochran@gmail.com>
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>, davem@davemloft.net,
        alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com,
        ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org,
        netdev@vger.kernel.org, linux-mips@vger.kernel.org,
        thomas.petazzoni@bootlin.com, quentin.schulz@bootlin.com,
        allan.nielsen@microchip.com
Subject: Re: [PATCH net-next 8/8] net: mscc: PTP offloading support
Message-ID: <20190118090841.GH25424@kwain>
References: <20190117100212.2336-1-antoine.tenart@bootlin.com>
 <20190117100212.2336-9-antoine.tenart@bootlin.com>
 <20190118022343.qmorsbg6mjtaq3gi@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190118022343.qmorsbg6mjtaq3gi@localhost>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hi Richard,

On Thu, Jan 17, 2019 at 06:23:43PM -0800, Richard Cochran wrote:
> On Thu, Jan 17, 2019 at 11:02:12AM +0100, Antoine Tenart wrote:
> > This patch adds support for offloading PTP timestamping to the Ocelot
> > switch for both 1-step and 2-step modes.
> 
> For PTP Hardware Clock drivers, please add the PTP maintainer onto CC.

Will do for the v2, sorry about that.

> > +static int ocelot_ptp_settime64(struct ptp_clock_info *ptp,
> > +				const struct timespec64 *ts)
> > +{
> > +	struct ocelot *ocelot = container_of(ptp, struct ocelot, ptp_info);
> > +	u32 val;
> > +
> > +	val = ocelot_read_rix(ocelot, PTP_PIN_CFG, TOD_ACC_PIN);
> > +	val &= ~(PTP_PIN_CFG_SYNC | PTP_PIN_CFG_ACTION_MASK | PTP_PIN_CFG_DOM);
> > +	val |= PTP_PIN_CFG_ACTION(PTP_PIN_ACTION_IDLE);
> > +
> > +	ocelot_write_rix(ocelot, val, PTP_PIN_CFG, TOD_ACC_PIN);
> > +
> > +	ocelot_write_rix(ocelot, lower_32_bits(ts->tv_sec), PTP_PIN_TOD_SEC_LSB,
> > +			 TOD_ACC_PIN);
> > +	ocelot_write_rix(ocelot, upper_32_bits(ts->tv_sec), PTP_PIN_TOD_SEC_MSB,
> > +			 TOD_ACC_PIN);
> > +	ocelot_write_rix(ocelot, ts->tv_nsec, PTP_PIN_TOD_NSEC, TOD_ACC_PIN);
> > +
> > +	val = ocelot_read_rix(ocelot, PTP_PIN_CFG, TOD_ACC_PIN);
> > +	val &= ~(PTP_PIN_CFG_SYNC | PTP_PIN_CFG_ACTION_MASK | PTP_PIN_CFG_DOM);
> > +	val |= PTP_PIN_CFG_ACTION(PTP_PIN_ACTION_LOAD);
> > +
> > +	ocelot_write_rix(ocelot, val, PTP_PIN_CFG, TOD_ACC_PIN);
> 
> You are writing multiple registers.  This code is not safe when called
> concurrently.
> 
> Ditto for gettime, adjtime, and adjfreq.

Right, I'll fix that.

> > +static int ocelot_ptp_adjfreq(struct ptp_clock_info *ptp, s32 ppb)
> > +{
> 
> Please implement adjfine instead.

OK, I'll look into it.

> > +	struct mutex ptp_lock;
> 
> Just what does this mutex protect?  Please add a comment.

OK.

Thanks!
Antoine

-- 
Antoine Ténart, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
