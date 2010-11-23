Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Nov 2010 19:49:36 +0100 (CET)
Received: from mail.atheros.com ([12.19.149.2]:59455 "EHLO mail.atheros.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491930Ab0KWSt2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 23 Nov 2010 19:49:28 +0100
Received: from mail.atheros.com ([10.10.20.107])
        by sidewinder.atheros.com
        for <ralf@linux-mips.org>; Tue, 23 Nov 2010 10:49:15 -0800
Received: from tux (10.10.11.84) by SC1EXHC-02.global.atheros.com
 (10.10.20.106) with Microsoft SMTP Server (TLS) id 8.2.213.0; Tue, 23 Nov
 2010 10:49:20 -0800
Received: by tux (sSMTP sendmail emulation); Tue, 23 Nov 2010 10:49:19 -0800
Date:   Tue, 23 Nov 2010 10:49:19 -0800
From:   "Luis R. Rodriguez" <lrodriguez@atheros.com>
To:     Arnaud Lacombe <lacombar@gmail.com>
CC:     Gabor Juhos <juhosg@openwrt.org>, Felix Fietkau <nbd@openwrt.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "kaloz@openwrt.org" <kaloz@openwrt.org>,
        Luis Rodriguez <Luis.Rodriguez@Atheros.com>,
        Cliff Holden <Cliff.Holden@Atheros.com>
Subject: Re: [PATCH 03/18] MIPS: add generic support for multiple machines
 within a single kernel
Message-ID: <20101123184919.GJ29396@tux>
References: <1290524800-21419-1-git-send-email-juhosg@openwrt.org>
 <1290524800-21419-4-git-send-email-juhosg@openwrt.org>
 <AANLkTikMwNqd507sPSTQOXt4KYkr9v61H=4_ESo7xFdj@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <AANLkTikMwNqd507sPSTQOXt4KYkr9v61H=4_ESo7xFdj@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <Luis.Rodriguez@Atheros.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28497
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lrodriguez@atheros.com
Precedence: bulk
X-list: linux-mips

On Tue, Nov 23, 2010 at 10:29:49AM -0800, Arnaud Lacombe wrote:
> Hi,
> 
> On Tue, Nov 23, 2010 at 10:06 AM, Gabor Juhos <juhosg@openwrt.org> wrote:
> > This patch adds a generic solution to support multiple machines based on
> > a given SoC within a single kernel image. It is implemented already for
> > several other architectures but MIPS has no generic support for that yet.
> >
> Is this the way `arch/mips' wants to go to support multiple machine
> within a same kernel image ? Flattened Device Tree is the other way to
> achieve that. I remind the latter being proposed by Felix Fietkau on
> #openwrt.

We either do this now or later. If now it means more work and we'd have
to wait until the work is done. If no one is working on it right now
it seems easier to submit this as is for now and later get the port
done to the device tree model.

  Luis
