Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Sep 2004 22:43:35 +0100 (BST)
Received: from mail19.syd.optusnet.com.au ([IPv6:::ffff:211.29.132.200]:40922
	"EHLO mail19.syd.optusnet.com.au") by linux-mips.org with ESMTP
	id <S8225004AbUIHVna>; Wed, 8 Sep 2004 22:43:30 +0100
Received: from [10.1.1.3] (d211-31-77-55.dsl.nsw.optusnet.com.au [211.31.77.55])
	(authenticated bits=0)
	by mail19.syd.optusnet.com.au (8.12.11/8.12.11) with ESMTP id i88LhIqP003312;
	Thu, 9 Sep 2004 07:43:24 +1000
Message-ID: <413F7B4A.8090108@optusnet.com.au>
Date: Thu, 09 Sep 2004 07:36:10 +1000
From: Glenn Barry <glennrbarry@optusnet.com.au>
Reply-To: glennrbarry@optusnet.com.au
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Robin H. Johnson" <robbat2@gentoo.org>
CC: linux-mips@linux-mips.org
Subject: Re: SGI O2 Prom modification
References: <413E84E2.4060401@optusnet.com.au> <413E9931.8060605@gentoo.org> <413E9CB0.9020703@optusnet.com.au> <20040908211728.GB3955@curie-int.orbis-terrarum.net>
In-Reply-To: <20040908211728.GB3955@curie-int.orbis-terrarum.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <glennrbarry@optusnet.com.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5806
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: glennrbarry@optusnet.com.au
Precedence: bulk
X-list: linux-mips

Hi Robin,

O.K. I misunderstood when I thought that Kumba misunderstood. D'OH.

I think that our biggest hope is to find someone that maybe worked on 
the O2 development, one of the engineers maybe, that would like to see 
the O2 evolve to its ultimate potential. It might not involve getting 
the source code if they did the mod for us, but knowing who in 
particular to ask in the first place is the real challenge..

Glenn

Robin H. Johnson wrote:

>On Wed, Sep 08, 2004 at 03:46:24PM +1000, Glenn Barry wrote:
>  
>
>>>AFAIK, this ability isn't too supported anymore.  The guy doing this 
>>>has apparently decided to quit.  While I'm sure this doesn't make such 
>>>modifications impossible, it likely makes them more difficult and more 
>>>expensive.
>>>      
>>>
>>This modification is currently being done with RM5200 boards and 
>>replacing the CPU. You can read more about it at 
>>http://forums.nekochan.net/viewtopic.php?t=1071
>>
>>The RM7000C @ 600MHx chip currently works fine in IRIX, sorry I should 
>>have specified that this isn't specifically related to Linux, I just 
>>thought that you people would have the best knnowledge of the SGI's 
>>outside SGI themselves, given that you've been able to port Linux to 
>>some of their machines.
>>    
>>
>Kumba and I do know all about the RM7000C work, as we are frequent
>visitors to nekochan.
>
>What Kumba was referring to what the mid-August post by ChicagoJoe (on
>page 14) stating that the company that had been doing the BGA chip
>replacement is not taking on any more work.
>
>  
>
>>>This would quite likely require direct access to the source code of 
>>>the IP32 PROM.  I think only IRIX developers have this access, and 
>>>there are likely license issues that would get in the way of modifying 
>>>such code to allow for detection of the RM7900
>>>      
>>>
>>Hmmm...given that the O2 line is discontinued I wonder if SGI would 
>>really object to having the code modified.
>>    
>>
>To get the PROM source, you'd really have to be in bed with SGI, as many
>other folk from here have asked for a lot less and had no success.
>
>  
>
