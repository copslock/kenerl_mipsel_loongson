Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Sep 2004 06:27:16 +0100 (BST)
Received: from sccrmhc11.comcast.net ([IPv6:::ffff:204.127.202.55]:7909 "EHLO
	sccrmhc11.comcast.net") by linux-mips.org with ESMTP
	id <S8224828AbUIHF1H>; Wed, 8 Sep 2004 06:27:07 +0100
Received: from [192.168.1.4] (pcp04939029pcs.waldrf01.md.comcast.net[68.48.72.58])
          by comcast.net (sccrmhc11) with ESMTP
          id <20040908052658011001mg5ue>
          (Authid: kumba12345);
          Wed, 8 Sep 2004 05:26:58 +0000
Message-ID: <413E9931.8060605@gentoo.org>
Date: Wed, 08 Sep 2004 01:31:29 -0400
From: Kumba <kumba@gentoo.org>
User-Agent: Mozilla Thunderbird 0.7.3 (Windows/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: glennrbarry@optusnet.com.au
CC: linux-mips@linux-mips.org
Subject: Re: SGI O2 Prom modification
References: <413E84E2.4060401@optusnet.com.au>
In-Reply-To: <413E84E2.4060401@optusnet.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5800
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Glenn Barry wrote:

> Hi There,
> 
> I have two questions related to MIPS which someone may be able to help 
> with. Sorry for the long post.
> 
> Firstly I don't know if you've heard about the upgrading of the RM5200 
> 300MHz CPU modules in SGI O2's with RM7000C 600MHz chips.
> 
> You can read about it at www.nekochan.net.

AFAIK, this ability isn't too supported anymore.  The guy doing this has 
apparently decided to quit.  While I'm sure this doesn't make such 
modifications impossible, it likely makes them more difficult and more expensive.

RM7000 has issues in Linux anyways.  L3 cache is disabled (atleast on the 
official SGI RM7000.  Not sure if the 600MHz R7000 has an L3 cache as well), 
and the scsi system isn't working in this system yet.  There's possibly 
others, but so few people have access to these kinds of machines that it makes 
testing diffcult.


> My question is about the possibility of someone helping out with 
> modifying the O2's PROM to recognise the RM7900 CPU from PMC-Sierra.

This would quite likely require direct access to the source code of the IP32 
PROM.  I think only IRIX developers have this access, and there are likely 
license issues that would get in the way of modifying such code to allow for 
detection of the RM7900

Modifying the binary is most assuredly way more difficult than gaining access 
to ip32PROM source and modifying it directly (and solving license issues). 
The level of change to the binary needed to make the ip32PROM detect a new CPU 
would require extremely detailed knowledge of the binary format the ip32PROM 
is in, SGI O2 systems, and how the PROM even functions.  I'd wager a guess 
that a super-skilled SGI engineer might possibly pull this off, given enough 
caffeine.


> Not having played with Linux on my O2, I don't know the details, but are 
> you able to run dual monitors with a second video card in the PCI slot?

Very unlikely in the current state, most video cards require initialization 
from an x86 bios to function.  There are ways around that, but then there's 
the problem of the O2 PCI slot not operating at 100%.


> If so does anyone think it would be possible to port a video card driver 
> to Irix to be able run a second screen. Unfortunately the dualhead 
> monitor adaptor isn't really an option as they are very difficult to 
> find and expensive.

About the only guy who can pull something like that off currently is Stan, the 
guy who did the Octane port, since he reverse-engineered the Impact card on 
Octanes.  Short of that, not without documentation, and alot of time.  And 
you'll need more weight than that in the core of a neutron star to get SGI to 
dig up those docs (since they're probably lost in a black hole anyways).


--Kumba

-- 
"Such is oft the course of deeds that move the wheels of the world: small 
hands do them because they must, while the eyes of the great are elsewhere." 
--Elrond
