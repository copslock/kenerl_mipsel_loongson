Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Apr 2014 22:23:41 +0200 (CEST)
Received: from qmta12.emeryville.ca.mail.comcast.net ([76.96.27.227]:41794
        "EHLO qmta12.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822274AbaDMUXg7QPUS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 13 Apr 2014 22:23:36 +0200
Received: from omta21.emeryville.ca.mail.comcast.net ([76.96.30.88])
        by qmta12.emeryville.ca.mail.comcast.net with comcast
        id pXkz1n0051u4NiL01YPVaH; Sun, 13 Apr 2014 20:23:29 +0000
Received: from [192.168.1.13] ([50.190.84.14])
        by omta21.emeryville.ca.mail.comcast.net with comcast
        id pYPT1n00K0JZ7Re8hYPUYw; Sun, 13 Apr 2014 20:23:29 +0000
Message-ID: <534AF23E.4060809@gentoo.org>
Date:   Sun, 13 Apr 2014 16:23:26 -0400
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     linux-mips@linux-mips.org
Subject: Re: arch/mips/sgi-ip22/Platform:29: *** gcc doesn't support needed
 option -mr10k-cache-barrier=store.  Stop.
References: <534138d9.RISUZQYUMS8U8s42%fengguang.wu@intel.com> <20140409051929.GA29246@localhost> <20140409082445.GC1438@pax.zz.de> <20140409133229.GA22315@alpha.franken.de> <20140409231345.GC8370@localhost> <5345DB6A.7060004@gentoo.org> <20140410003806.GV17197@linux-mips.org> <534609B2.5070808@gentoo.org> <20140410065928.GW17197@linux-mips.org>
In-Reply-To: <20140410065928.GW17197@linux-mips.org>
X-Enigmail-Version: 1.6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1397420609;
        bh=+uDdKUVipuDDHltdxHhzQXzmM5Ot7madbNApZqjV4jE=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=tlU/59OvJkRssG+oR+0PEh8NJMvYQigmoAcM7XEe+NixlF/ySAMl7jwiWqdibcdcq
         F0WdNfLsptgYzx8m1gZu8kly93LjMBQ4+DrEDThdifYFuZzjwHy2xbkzp9sy6NudcT
         sLfd2U5KXEG3WnE3KdH2j5g0RXPVOjtcjgmliIczk3g8DSvl/FyrCczoaKYEu4LCsO
         zmLrgKjRPHIPRklqZM9EtFTYhWWM/sFfM9yl2KPb0veneru1t8lOgwo3Y6FYkIxGyg
         DD87ObnwjwdPNp10zLWtt0wJ8wY0zgmNIrA09YYNp9WPPf80OQQoIjJ+DB9+eh+Nyp
         d8KqAwAj62dIg==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39793
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On 04/10/2014 02:59, Ralf Baechle wrote:
> On Wed, Apr 09, 2014 at 11:02:10PM -0400, Joshua Kinard wrote:
> 
>> Odd, I thought R10K systems were locked to booting 64-bit kernels only.  At
>> least the Octane was when it was bootable.  Not sure about IP27.
>>
>> Maybe that's another one of ARCS' ingenious features...
> 
> No; IP27's address map is huge; a single node can take 2GB RAM.  A full
> blown 512 CPU system could have 0.5TB memory.  Your homework for today:
> try to use all that efficiently with highmem ;-)

I'll need to upgrade my electrical service first.  Then install a fusion
power plant in the backyard, with hamster-wheel backups...


> Octane is essentially a specialized, single-node IP27.  It also can take
> more memory than addressable in a 32 bit kernel which assumes that all memory
> is visible in CKSEG0, all I/O in CKSEG1 - or you need to ioremap to CKSEG2/3.
> So 32 bit kernels just don't cut it on Octane either.

I believe that, in Stan's old patches, there was a cutoff at 2GB detected
memory, because he never resolved a problem with DMA/PCI on machines with
>2GB memory.  So the machine was kinda hamstrung there anyways.  That bit of
code was always confusing to forward-port.

If only I could finally find the motivation to figure out HEART's IRQ
trickery and Linux's IRQ system...


> Similarly 32 bit kernels don't cut it on other systems such as Sibyte,
> SGI O2, Octane.  They may be possible for some configurations but that
> that's either too rarely a useful choice or too inefficient.
> 
> Let's say 32 bit is slowly running out of juice :-)
> 

I wonder if I'll be alive when 128-bit becomes all the rage...


>>>> Are you configuring for IP22 (Indy, Indigo2 R4x00), or IP28 (R10000)?  Note,
>>>> IP26 (R8000) is not supported in Linux.  I think OpenBSD got it working, though.
>>>
>>> Wish I'd have a box ....
>>
>> They do pop up on eBay from time-to-time.  UPS destroyed the case mine came
>> in, though.  I've got it in a closet, with duct tape holding the teal skins
>> on.  It does boot to the PROM, but the RTC is probably dead by now.
> 
> The common problem.  You can cut it open with a dremel or similar tool,
> disconect the internal battery and connect an external battery instead.
> There are howtos for this on the web.  I'm also tired of reprogramming
> the MAC address again when I use my Indy so I should do this myself ...

I'll probably stick to finding old DS1386's on eBay :)  Never had much luck
w/ those cutting discs on a Dremel tool.  They shatter too easily and send
little shards of pain flying across the room.

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
4096R/D25D95E3 2011-03-28

"The past tempts us, the present confuses us, the future frightens us.  And
our lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
