Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Sep 2004 21:16:13 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:22523 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225196AbUIIUQJ>;
	Thu, 9 Sep 2004 21:16:09 +0100
Received: from [10.0.10.221] (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id NAA01297;
	Thu, 9 Sep 2004 13:16:01 -0700
Message-ID: <4140BA01.4050607@mvista.com>
Date: Thu, 09 Sep 2004 13:16:01 -0700
From: Pete Popov <ppopov@mvista.com>
User-Agent: Mozilla Thunderbird 0.7.3 (Windows/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: charles.eidsness@ieee.org
CC: ppopov@embeddedalley.com, linux-mips@linux-mips.org
Subject: Re: Au1000 AC97 ALSA Driver
References: <40CB2FAF.3050807@ieee.org> <1087103071.1432.3.camel@thinkpad> <4140AA56.2050903@ieee.org>
In-Reply-To: <4140AA56.2050903@ieee.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5808
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

Charles,

Awesome, thanks -- I'll take a look at it later. I was going to do this 
work soon so ... thanks :)

Pete

Charles Eidsness wrote:

> I've been testing this driver for a while now and I think I've worked 
> out most of the bugs.
>
> If any one's interested they can find the source code here:
> http://members.rogers.com/charles.eidsness/au1000.c
>
> A patch that adds the code plus edits the KConfig Makefiles here:
> http://members.rogers.com/charles.eidsness/au1000_alsa.patch
>
> To compile it as a module you'll probably need this little patch to 
> the au1000's dma.c.
> http://members.rogers.com/charles.eidsness/au1000_dma_module.patch
>
> In order for this driver to work you'll of course need the ALSA 
> drivers as well so it will only work on kernel 2.6+, unless you add 
> them to pre-2.6. I also recommend updating the ALSA drivers that come 
> with the kernel from 1.0.4 to the latest, all of my testing was 
> performed using ALSA drivers 1.0.5a, but it will probably run fine on 
> 1.0.4.
>
> In order to use most of the ALSA applications out there you will also 
> need an alsa.conf somewhere. You'll need to "export 
> ALSA_CONFIG_PATH=/....../alsa.conf" sometime too so all your apps know 
> where to find your alsa.conf file, like during boot (in .profile for 
> example). Here's the alsa.conf file I've been using.
> http://members.rogers.com/charles.eidsness/alsa.conf
>
> Cheers,
> Charles
>
>
> Pete Popov wrote:
>
>> On Sat, 2004-06-12 at 09:30, Charles Eidsness wrote:
>>
>>> I've been working on an ALSA driver for the Au1000 processor AC'97 
>>> port. Specifically for the DBAu1000 Merlot eval card. It seems to be 
>>> working in OSS emulation mode, I'm having a few problems setting up 
>>> my system to work in ALSA native mode, and it contains only a 
>>> minimum of features. i.e. it's still a work in progress, but I 
>>> thought there may be someone else out there interested in it.
>>>
>>> I've posted a patch that should add a mips sub-directory in the 
>>> sound directory of the 2.6.6 kernel and add an au1000 sound option 
>>> to the kernel configuration menu here: 
>>> http://members.rogers.com/charles.eidsness/au1000_alsa.patch
>>>
>>> Alternately you can find just the source code here:
>>> http://members.rogers.com/charles.eidsness/au1000.c
>>
>>
>>
>> Great -- let me know when the driver is ready to be checked in :)
>>
>> Pete
>>
>>
>>
>
