Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Aug 2005 22:02:21 +0100 (BST)
Received: from outmx026.isp.belgacom.be ([IPv6:::ffff:195.238.2.91]:5250 "EHLO
	outmx026.isp.belgacom.be") by linux-mips.org with ESMTP
	id <S8225792AbVHEVCF>; Fri, 5 Aug 2005 22:02:05 +0100
Received: from outmx026.isp.belgacom.be (localhost [127.0.0.1])
        by outmx026.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with ESMTP id j75L5UYg018317
        for <linux-mips@linux-mips.org>; Fri, 5 Aug 2005 23:05:30 +0200
        (envelope-from <tnt@246tNt.com>)
Received: from ayanami.246tNt.com (82-135.245.81.adsl.skynet.be [81.245.135.82])
        by outmx026.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with ESMTP id j75L5PCb018262;
	Fri, 5 Aug 2005 23:05:25 +0200
        (envelope-from <tnt@246tNt.com>)
Received: from [10.0.0.245] (246tNt-laptop.lan.ayanami.246tNt.com [10.0.0.245])
	by ayanami.246tNt.com (Postfix) with ESMTP
	id B0E941CAC1C; Fri,  5 Aug 2005 23:05:17 +0200 (CEST)
Message-ID: <42F3D4B7.6040905@246tNt.com>
Date:	Fri, 05 Aug 2005 23:05:59 +0200
From:	Sylvain Munaut <tnt@246tNt.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050610)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	ppopov@embeddedalley.com
Cc:	Michael Kelly <mike@cogcomp.com>,
	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: Re: AMD Au1100 problems (USB & Ethernet)
References: <42F3C05E.7060002@246tNt.com>	 <1123271252.19992.189.camel@localhost.localdomain>	 <6.2.0.14.2.20050805155414.044a0f00@mail.cogcomp.com> <1123272640.19992.199.camel@localhost.localdomain>
In-Reply-To: <1123272640.19992.199.camel@localhost.localdomain>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <tnt@246tNt.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8700
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tnt@246tNt.com
Precedence: bulk
X-list: linux-mips

Pete Popov wrote:
> On Fri, 2005-08-05 at 15:58 -0400, Michael Kelly wrote:
> 
>>The error count is less than .15%, not 5%.  This does not seem excessive.
>>So, the question is what are these errors exactly.  We have done internal
>>testing, but there is no way to test with every cable and switch/hub 
>>combination.

Yes, on that particular count because I mainly testing TX on that
particular boot (so the RX are mainly small acks). But when testing
heavy receive with big packets, it can climbs up.

> Of course. I'm sure the CPU module itself is fine. I took a look at the
> picture and it looks like the PHY is external so I'm guessing it's on
> their custom PCB.
> 

The PHY is on the CPU module itself, it's a BCM5221.


>>If you could determine the actual errors (such as CRC, collision, etc) then we
>>can try to determine where the errors are coming from.  It may very well be
>>HW, but it is a bit too early to make such a broad statement without more
>>information.
> 
> 
> Well, could be just a cable issue, hub, etc, but I'll put that in the HW
> bucket as well :)

The RX errors are reported as "rx miss" (RX_MISSED_FRAME set) which is
described as "Internal FIFO overrun". Maybe those are just OK and it's
just that it can't wistand full 100Mbps (the module is connected on a
10/100/1000 switch and the server is gigabit).

The TX errors are time-out, how can I find more details about that ?


	Sylvain
