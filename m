Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 06 Aug 2005 11:38:59 +0100 (BST)
Received: from outmx021.isp.belgacom.be ([IPv6:::ffff:195.238.2.202]:11917
	"EHLO outmx021.isp.belgacom.be") by linux-mips.org with ESMTP
	id <S8224971AbVHFKim>; Sat, 6 Aug 2005 11:38:42 +0100
Received: from outmx021.isp.belgacom.be (localhost [127.0.0.1])
        by outmx021.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with ESMTP id j76AgInG032257
        for <linux-mips@linux-mips.org>; Sat, 6 Aug 2005 12:42:18 +0200
        (envelope-from <tnt@246tNt.com>)
Received: from ayanami.246tNt.com (82-135.245.81.adsl.skynet.be [81.245.135.82])
        by outmx021.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with ESMTP id j76AgFP9032224
        for <linux-mips@linux-mips.org>; Sat, 6 Aug 2005 12:42:15 +0200
        (envelope-from <tnt@246tNt.com>)
Received: from [10.0.0.245] (246tNt-laptop.lan.ayanami.246tNt.com [10.0.0.245])
	by ayanami.246tNt.com (Postfix) with ESMTP id AA7EC1CAC5D
	for <linux-mips@linux-mips.org>; Sat,  6 Aug 2005 12:42:07 +0200 (CEST)
Message-ID: <42F4942A.7060006@246tNt.com>
Date:	Sat, 06 Aug 2005 12:42:50 +0200
From:	Sylvain Munaut <tnt@246tNt.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050610)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Re: AMD Au1100 problems (USB & Ethernet)
References: <42F3C05E.7060002@246tNt.com>	 <1123271252.19992.189.camel@localhost.localdomain>	 <6.2.0.14.2.20050805155414.044a0f00@mail.cogcomp.com>	 <1123272640.19992.199.camel@localhost.localdomain>	 <42F3D4B7.6040905@246tNt.com> <1123276474.23193.6.camel@localhost.localdomain>
In-Reply-To: <1123276474.23193.6.camel@localhost.localdomain>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <tnt@246tNt.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8702
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tnt@246tNt.com
Precedence: bulk
X-list: linux-mips

Pete Popov wrote:

>>The RX errors are reported as "rx miss" (RX_MISSED_FRAME set) which is
>>described as "Internal FIFO overrun". Maybe those are just OK and it's
>>just that it can't wistand full 100Mbps (the module is connected on a
>>10/100/1000 switch and the server is gigabit).
> 
> No, I don't think that's normal.

Maybe it has something to do with initialisation that I don't do
properly. The bootloader is uMon, not YaMon so maybe something is
execpted to be setup that I don't know of.


>>The TX errors are time-out, how can I find more details about that ?
> 
> 
> If possible, eliminate the gig switch by replacing it with a small
> 10/100 switch. If the problems go away, then that's a big clue.

I don't habe a 10/100 switch but I tried on a 10/100 Hub and the results
are quite the same. I just have a few "rx runt" error more that are due
to the hub.

> Take a look at what the bcm phy is auto-negotiating and make sure it
> matches what the switch thinks it has negotiated. Although, the tx
> timeouts should have nothing to do with mismatched auto negotiation...
> but I see there are a bunch of "carrier" errors.

Phy reports 100Mbps half duplex with the hub and 100Mbps full duplex
with the switch, which looks correct.

btw, It seems that after a timeout error, the au1000_timer isn't
restored correctly ( I put a printk in it and before the errors, it
prints every sec, and never after ).

> You of course tried a different cable, just in case?

Sure, with 3 differents cables in fact.


	Sylvain
