Return-Path: <SRS0=tpP8=S2=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A3EBC10F11
	for <linux-mips@archiver.kernel.org>; Wed, 24 Apr 2019 20:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AC10208E4
	for <linux-mips@archiver.kernel.org>; Wed, 24 Apr 2019 20:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729896AbfDXUk5 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 24 Apr 2019 16:40:57 -0400
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:44192 "EHLO
        emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfDXUk5 (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Wed, 24 Apr 2019 16:40:57 -0400
Received: from darkstar.musicnaut.iki.fi (85-76-5-198-nat.elisa-mobile.fi [85.76.5.198])
        by emh02.mail.saunalahti.fi (Postfix) with ESMTP id 51BDE2005E;
        Wed, 24 Apr 2019 23:40:55 +0300 (EEST)
Date:   Wed, 24 Apr 2019 23:40:55 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Paul Burton <paul.burton@mips.com>
Cc:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: MIPS/CI20: BUG: Bad page state
Message-ID: <20190424204055.GB21072@darkstar.musicnaut.iki.fi>
References: <20190424182012.GA21072@darkstar.musicnaut.iki.fi>
 <20190424192922.ilnn3oxc7ryzhd3l@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424192922.ilnn3oxc7ryzhd3l@pburton-laptop>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hi,

On Wed, Apr 24, 2019 at 07:29:29PM +0000, Paul Burton wrote:
> On Wed, Apr 24, 2019 at 09:20:12PM +0300, Aaro Koskinen wrote:
> > I have been trying to get GCC bootstrap to pass on CI20 board, but it
> > seems to always crash. Today, I finally got around connecting the serial
> > console to see why, and it logged the below BUG.
> > 
> > I wonder if this is an actual bug, or is the hardware faulty?
> > 
> > FWIW, this is 32-bit board with 1 GB RAM. The rootfs is on MMC, as well
> > as 2 GB + 2 GB swap files.
> > 
> > Kernel config is at the end of the mail.
> 
> I'd bet on memory corruption, though not necessarily faulty hardware.
> 
> Unfortunately memory corruption on Ci20 boards isn't uncommon... Someone
> did make some tweaks to memory timings configured in the DDR controller
> which improved things for them a while ago:
> 
>   https://github.com/MIPS/CI20_u-boot/pull/18
> 
> Would you be up for testing with those tweaks? I'd be happy to help with
> updating U-Boot if needed.

Thanks, I wasn't aware of this, and seems like it could help.

I guess instructions here <https://elinux.org/CI20_Dev_Zone> are valid,
i.e. I can use MMC/SD card to re-flash the U-boot without the risk of
bricking the board, if I understood correctly?

BTW, would it be possible to re-adjust these timings from the kernel side?

> Do you know which board revision you have? (Is it square or a funny
> shape, green or purple, and does it have a revision number printed on
> the silkscreen?)

It's a purple one. Based on quick look all printings are identical to this
one:
https://images.anandtech.com/doci/8958/purple%20ci20_smaller_678x452.jpg

A.
