Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jan 2006 01:33:48 +0000 (GMT)
Received: from mail.dvmed.net ([216.237.124.58]:60837 "EHLO mail.dvmed.net")
	by ftp.linux-mips.org with ESMTP id S8133529AbWAQBda (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 17 Jan 2006 01:33:30 +0000
Received: from cpe-069-134-188-146.nc.res.rr.com ([69.134.188.146] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.52 #1 (Red Hat Linux))
	id 1EyfmM-0003E2-To; Tue, 17 Jan 2006 01:36:59 +0000
Message-ID: <43CC4A37.9050502@pobox.com>
Date:	Mon, 16 Jan 2006 20:36:55 -0500
From:	Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Andrew Morton <akpm@osdl.org>
CC:	Martin Michlmayr <tbm@cyrius.com>, linux-mips@linux-mips.org,
	grundler@parisc-linux.org
Subject: Re: Tulip RaQ2 64 Bit Fix
References: <4393CD9F.3090305@jg555.com>	<20051205114456.GA2728@linux-mips.org>	<20060116160355.GB28383@deprecation.cyrius.com>	<43CBC97E.3090800@jg555.com>	<20060116165825.GG5798@deprecation.cyrius.com> <20060116172320.1e6d3cfd.akpm@osdl.org>
In-Reply-To: <20060116172320.1e6d3cfd.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <jgarzik@pobox.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9912
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jgarzik@pobox.com
Precedence: bulk
X-list: linux-mips

Andrew Morton wrote:
> Martin Michlmayr <tbm@cyrius.com> wrote:
> 
>>* Jim Gifford <maillist@jg555.com> [2006-01-16 08:27]:
>>
>>>>>>The attached patch allows the tulip driver to work with the RaQ2's
>>>>>>network adapter. Without the patch under a 64 bit build, it will
>>>>>>never negotiate and will drop packets. This driver is part of
>>>>>>Linux Parisc, by Grant Grundler. It's currently in -mm, but Jeff
>>>>>>Garzick will not apply it to the main tree.
>>>>>>     
>>>>>
>>>>>Why?
>>>
>>>Jeff Garzick refuses to apply it do to spinlocks. Andrew Morton is
>>>including in his tree because it fixes issue with Parisc and with
>>>MIPS based builds. So it's kinda of what is the right thing to do. I
>>>also use this driver on my x86 builds, and it actually performs
>>>better. Here is a little history of how Grant made the driver.
>>>
>>>Grant Grundler is the network maintainer for Parisc Linux.  He
>>>discovered that the tulip driver didn't perform that well. He
>>>researched the manufactures documentation and found out how to fix
>>>the driver to work to its optimum performance. He did this back in
>>>2003, has submitted it to Jeff Garzick several times with no
>>>response. Around late 2004, I started to do test builds on 64 bit on
>>>my RaQ2 and discovered that the driver would not auto-negotiate
>>>transfer speeds. Talked to numerous people, then someone put me in
>>>touch with Grant. I tested the driver for about 2 weeks, ask Grant
>>>why it wasn't sent upstream, he told me about the spinlock issue. I
>>>then contacted Andrew Morton, explained everything as I am here, and
>>>he agreed it was needed and tried to get Jeff to add it. Jeff sends
>>>back a one liner say doing to it's use of spinlocks it's not
>>>accepted.
>>
>>Andrew, do you think that issue will be resolved in some way at some
>>point?
>>
> 
> 
> This has been hanging around for too long.  We need to get it over the hump.
> 
> Jeff, can you please suggest how this patch should be altered to make it
> acceptable?

Answer hasn't changed since this was last discussed:  sleep, rather than 
delay for an extra-long time.  That's the only hurdle for the tulip 
patches you keep resending.

Francois Romieu even had an untested patch that attempted this, somewhere.

	Jeff
