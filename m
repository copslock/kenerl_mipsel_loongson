Return-Path: <SRS0=aTje=VC=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C614AC468A0
	for <linux-mips@archiver.kernel.org>; Fri,  5 Jul 2019 17:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E969216E3
	for <linux-mips@archiver.kernel.org>; Fri,  5 Jul 2019 17:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbfGERQu (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 5 Jul 2019 13:16:50 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:47429 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbfGERQu (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Fri, 5 Jul 2019 13:16:50 -0400
X-Originating-IP: 90.76.143.236
Received: from localhost (lfbn-1-2078-236.w90-76.abo.wanadoo.fr [90.76.143.236])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id CFF1E2000D;
        Fri,  5 Jul 2019 17:16:42 +0000 (UTC)
Date:   Fri, 5 Jul 2019 19:16:40 +0200
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     Richard Cochran <richardcochran@gmail.com>
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>, davem@davemloft.net,
        alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com,
        ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org,
        netdev@vger.kernel.org, linux-mips@vger.kernel.org,
        thomas.petazzoni@bootlin.com, allan.nielsen@microchip.com
Subject: Re: [PATCH net-next 8/8] net: mscc: PTP Hardware Clock (PHC) support
Message-ID: <20190705171640.GM3926@kwain>
References: <20190701100327.6425-1-antoine.tenart@bootlin.com>
 <20190701100327.6425-9-antoine.tenart@bootlin.com>
 <20190705164736.x6dy2oc6jo5db65v@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190705164736.x6dy2oc6jo5db65v@localhost>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hello Richard,

On Fri, Jul 05, 2019 at 09:47:36AM -0700, Richard Cochran wrote:
> On Mon, Jul 01, 2019 at 12:03:27PM +0200, Antoine Tenart wrote:
> 
> > +void ocelot_get_hwtimestamp(struct ocelot *ocelot, struct timespec64 *ts)
> > +{
> > +	/* Read current PTP time to get seconds */
> > +	u32 val = ocelot_read_rix(ocelot, PTP_PIN_CFG, TOD_ACC_PIN);
> 
> This register is protected by ocelot->ptp_clock_lock from other code
> paths, but not in this one!

Oops. I'll fix it.

> > +static int ocelot_init_timestamp(struct ocelot *ocelot)
> > +{
> > +	ocelot->ptp_info = ocelot_ptp_clock_info;
> > +
> > +	ocelot->ptp_clock = ptp_clock_register(&ocelot->ptp_info, ocelot->dev);
> > +	if (IS_ERR(ocelot->ptp_clock))
> > +		return PTR_ERR(ocelot->ptp_clock);
> 
> You need to handle the NULL case:

Will do.

> ptp_clock_register() - register a PTP hardware clock driver
> 
> @info:   Structure describing the new clock.
> @parent: Pointer to the parent device of the new clock.
> 
> Returns a valid pointer on success or PTR_ERR on failure.  If PHC
> support is missing at the configuration level, this function
> returns NULL, and drivers are expected to gracefully handle that
> case separately.

Thanks,
Antoine

-- 
Antoine T�nart, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
