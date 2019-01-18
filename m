Return-Path: <SRS0=gTW6=P2=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB9AC43387
	for <linux-mips@archiver.kernel.org>; Fri, 18 Jan 2019 09:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 747D22086D
	for <linux-mips@archiver.kernel.org>; Fri, 18 Jan 2019 09:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbfARJJr (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 18 Jan 2019 04:09:47 -0500
Received: from mail.bootlin.com ([62.4.15.54]:35588 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbfARJJr (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Fri, 18 Jan 2019 04:09:47 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E7BD3207AC; Fri, 18 Jan 2019 10:09:44 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr [90.88.156.87])
        by mail.bootlin.com (Postfix) with ESMTPSA id BD7C6206A7;
        Fri, 18 Jan 2019 10:09:44 +0100 (CET)
Date:   Fri, 18 Jan 2019 10:09:45 +0100
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     Richard Cochran <richardcochran@gmail.com>
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>, davem@davemloft.net,
        alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com,
        ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org,
        netdev@vger.kernel.org, linux-mips@vger.kernel.org,
        thomas.petazzoni@bootlin.com, quentin.schulz@bootlin.com,
        allan.nielsen@microchip.com
Subject: Re: [PATCH net-next 0/8] net: mscc: PTP offloading support
Message-ID: <20190118090945.GI25424@kwain>
References: <20190117100212.2336-1-antoine.tenart@bootlin.com>
 <20190118021342.enounbkp7v7nqzj2@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190118021342.enounbkp7v7nqzj2@localhost>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hi Richard,

On Thu, Jan 17, 2019 at 06:13:42PM -0800, Richard Cochran wrote:
> On Thu, Jan 17, 2019 at 11:02:04AM +0100, Antoine Tenart wrote:
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
> 
> The subject lines and this description are misleading.  You are not
> offloading the Precision Time Protocol.  Instead, this series
> implements a normal PHC driver.
> 
> Please change the text to avoid the phrase, "PTP offloading".

Will do.

Thanks!
Antoine

-- 
Antoine Ténart, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
