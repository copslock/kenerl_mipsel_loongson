Return-Path: <SRS0=gTW6=P2=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6143C43387
	for <linux-mips@archiver.kernel.org>; Fri, 18 Jan 2019 08:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9B632087E
	for <linux-mips@archiver.kernel.org>; Fri, 18 Jan 2019 08:58:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbfARI6g (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 18 Jan 2019 03:58:36 -0500
Received: from mail.bootlin.com ([62.4.15.54]:35341 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726031AbfARI6g (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Fri, 18 Jan 2019 03:58:36 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id CCC1C207AC; Fri, 18 Jan 2019 09:58:33 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr [90.88.156.87])
        by mail.bootlin.com (Postfix) with ESMTPSA id A1655206DC;
        Fri, 18 Jan 2019 09:58:33 +0100 (CET)
Date:   Fri, 18 Jan 2019 09:58:33 +0100
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>, davem@davemloft.net,
        alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com,
        ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org,
        netdev@vger.kernel.org, linux-mips@vger.kernel.org,
        thomas.petazzoni@bootlin.com, quentin.schulz@bootlin.com,
        allan.nielsen@microchip.com
Subject: Re: [PATCH net-next 0/8] net: mscc: PTP offloading support
Message-ID: <20190118085833.GG25424@kwain>
References: <20190117100212.2336-1-antoine.tenart@bootlin.com>
 <d6ed760a-a236-189f-b3e9-8a668fdf371f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d6ed760a-a236-189f-b3e9-8a668fdf371f@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hi Florian,

On Thu, Jan 17, 2019 at 09:07:05PM -0800, Florian Fainelli wrote:
> On 1/17/2019 2:02 AM, Antoine Tenart wrote:
> > 
> > This series adds support for the PTP offloading support in the Mscc
> > Ocelot Ethernet switch driver. Both PTP 1-step and 2-step modes are
> > supported.
> > 
> > In order to make use of the PTP offloading support, two new register
> > banks were described in the Ocelot device tree. The use of those
> > registers by the Mscc Ocelot Ethernet switch driver is made optional for
> > dt compatibility reasons. For the same reason a new interrupt is
> > described, and its use is also made optinal for compatibility reasons.
> > All of this is done ine patches 1-5.
> > 
> > The PTP offloading support itself is added in patch 8.
> > 
> > While doing this support, a few reworks were done in the Ocelot switch
> > driver, in patches 6-7.
> > 
> > Patches 2 and 4 should probably go through the MIPS tree.
> 
> Looks like you missed copying netdev on this patch series, do you mind
> re-sending there as well?

I just checked and netdev is Cc'ed. I'll prepare a v2 to take in account
the comments, so I'll sent it again anyway.

Thanks!
Antoine

-- 
Antoine Ténart, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
