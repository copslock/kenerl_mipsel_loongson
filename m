Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Sep 2004 06:53:46 +0100 (BST)
Received: from mail14.syd.optusnet.com.au ([IPv6:::ffff:211.29.132.195]:56229
	"EHLO mail14.syd.optusnet.com.au") by linux-mips.org with ESMTP
	id <S8224829AbUIHFxl>; Wed, 8 Sep 2004 06:53:41 +0100
Received: from [10.1.1.3] (d211-31-77-55.dsl.nsw.optusnet.com.au [211.31.77.55] (may be forged))
	(authenticated bits=0)
	by mail14.syd.optusnet.com.au (8.12.11/8.12.11) with ESMTP id i885rWnL022239;
	Wed, 8 Sep 2004 15:53:32 +1000
Message-ID: <413E9CB0.9020703@optusnet.com.au>
Date: Wed, 08 Sep 2004 15:46:24 +1000
From: Glenn Barry <glennrbarry@optusnet.com.au>
Reply-To: glennrbarry@optusnet.com.au
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kumba <kumba@gentoo.org>
CC: linux-mips@linux-mips.org
Subject: Re: SGI O2 Prom modification
References: <413E84E2.4060401@optusnet.com.au> <413E9931.8060605@gentoo.org>
In-Reply-To: <413E9931.8060605@gentoo.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <glennrbarry@optusnet.com.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5802
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: glennrbarry@optusnet.com.au
Precedence: bulk
X-list: linux-mips

Hi Kumba,

read below

Kumba wrote:

> Glenn Barry wrote:
>
>> Hi There,
>>
>> I have two questions related to MIPS which someone may be able to 
>> help with. Sorry for the long post.
>>
>> Firstly I don't know if you've heard about the upgrading of the 
>> RM5200 300MHz CPU modules in SGI O2's with RM7000C 600MHz chips.
>>
>> You can read about it at www.nekochan.net.
>
>
> AFAIK, this ability isn't too supported anymore.  The guy doing this 
> has apparently decided to quit.  While I'm sure this doesn't make such 
> modifications impossible, it likely makes them more difficult and more 
> expensive.


This modification is currently being done with RM5200 boards and 
replacing the CPU. You can read more about it at 
http://forums.nekochan.net/viewtopic.php?t=1071

The RM7000C @ 600MHx chip currently works fine in IRIX, sorry I should 
have specified that this isn't specifically related to Linux, I just 
thought that you people would have the best knnowledge of the SGI's 
outside SGI themselves, given that you've been able to port Linux to 
some of their machines.

>
> RM7000 has issues in Linux anyways.  L3 cache is disabled (atleast on 
> the official SGI RM7000.  Not sure if the 600MHz R7000 has an L3 cache 
> as well), and the scsi system isn't working in this system yet.  

The RM7000 @ 600MHz works perfectly under IRIX, I was just hoping to get 
the RM7900 @ 900MHz working under IRIX

> There's possibly others, but so few people have access to these kinds 
> of machines that it makes testing diffcult.
>
>
>> My question is about the possibility of someone helping out with 
>> modifying the O2's PROM to recognise the RM7900 CPU from PMC-Sierra.
>
>
> This would quite likely require direct access to the source code of 
> the IP32 PROM.  I think only IRIX developers have this access, and 
> there are likely license issues that would get in the way of modifying 
> such code to allow for detection of the RM7900

Hmmm...given that the O2 line is discontinued I wonder if SGI would 
really object to having the code modified.

>
> Modifying the binary is most assuredly way more difficult than gaining 
> access to ip32PROM source and modifying it directly (and solving 
> license issues). The level of change to the binary needed to make the 
> ip32PROM detect a new CPU would require extremely detailed knowledge 
> of the binary format the ip32PROM is in, SGI O2 systems, and how the 
> PROM even functions.  I'd wager a guess that a super-skilled SGI 
> engineer might possibly pull this off, given enough caffeine.

Yes that is where know how is in shortage, Chicage Joe got the hardware 
side of things sorted for the upgrade to the RM70000C @ 600MHz and there 
was no issue with the PROM as the CPU specs were identical to the RM5200 
and RM700A @300MHz..

>
>
>> Not having played with Linux on my O2, I don't know the details, but 
>> are you able to run dual monitors with a second video card in the PCI 
>> slot?
>
>
> Very unlikely in the current state, most video cards require 
> initialization from an x86 bios to function.  There are ways around 
> that, but then there's the problem of the O2 PCI slot not operating at 
> 100%.


There is a secondary video card available for the O2's (apparently) but 
with very low specs 8MB ram and something like a $2000 price tag.

So I was wondering if using an available XFree driver and possibly 
either running a second X server or proting the Xfree driver to XSGI.

>
>
>> If so does anyone think it would be possible to port a video card 
>> driver to Irix to be able run a second screen. Unfortunately the 
>> dualhead monitor adaptor isn't really an option as they are very 
>> difficult to find and expensive.
>
>
> About the only guy who can pull something like that off currently is 
> Stan, the guy who did the Octane port, since he reverse-engineered the 
> Impact card on Octanes.  Short of that, not without documentation, and 
> alot of time.  And you'll need more weight than that in the core of a 
> neutron star to get SGI to dig up those docs (since they're probably 
> lost in a black hole anyways).

This sounds familiar, it;'s a shame SGI doesn't give more 
help/documentation to people working with thier older machines, though I 
can understand it not being financially feasible.

Glenn

>
>
> --Kumba
>
