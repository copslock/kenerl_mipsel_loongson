Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Jan 2004 15:47:16 +0000 (GMT)
Received: from neptune.fsa.ucl.ac.be ([IPv6:::ffff:130.104.233.21]:55535 "EHLO
	neptune.fsa.ucl.ac.be") by linux-mips.org with ESMTP
	id <S8225383AbUA1PrQ>; Wed, 28 Jan 2004 15:47:16 +0000
Received: from 246tNt.com (21-6.CampusNet.ucl.ac.be [130.104.21.6])
	by neptune.fsa.ucl.ac.be (8.12.10/8.12.9/mp-2002.03.25) with ESMTP id i0SFkgfe004301
	for <linux-mips@linux-mips.org>; Wed, 28 Jan 2004 16:46:42 +0100 (MET)
Message-ID: <4017D96F.2080202@246tNt.com>
Date: Wed, 28 Jan 2004 16:46:55 +0100
From: Sylvain Munaut <tnt@246tnt.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031211 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: Linux 2.6 on AMD Alchemy Au1500
References: <4017927B.5080907@246tNt.com> <1075302354.16255.12.camel@localhost.localdomain> <4017D2D5.2050605@246tNt.com> <1075303379.16255.23.camel@localhost.localdomain> <20040128153627.GB14580@linux-mips.org>
In-Reply-To: <20040128153627.GB14580@linux-mips.org>
X-Enigmail-Version: 0.82.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-MailScanner: Found to be clean
To: unlisted-recipients:; (no To-header on input)
Return-Path: <tnt@246tnt.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4169
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tnt@246tnt.com
Precedence: bulk
X-list: linux-mips



>>>Ok. Is it available on some CVS / www page ?
>>>If we eventually choose Au1500 as platform I may be able to test it as 
>>>well and bug reports.
>>>      
>>>
>>No yet, but I'll email it to the mailing list in the next couple of
>>days. I would consider it Beta.
>>
>>    
>>
Ok, anyway I don't yet have a board ...

>>Just curious, why 2.6? 2.4 is solid, everything works, provides a mature
>>kernel and drivers ...?
>>    
>>
>
>Because in the not too far future the Linux community will largely run
>away from 2.4?  In fact the motivation of many developers to continue
>with 2.4 is quite down already and Marcelo is going to put 2.4 into
>deep freeze after 2.4.25.
>
>  
>
Yes that's one of my main reason. And by the time the products ships to 
customers it will be tested. I think that one more person testing it is 
one more person able to find/debug problems.
There are also some features that are natively in 2.6 and requires 
external patches / drivers in a 2.4 series kernel ( ipsec, preemption, 
alsa, ... )


Sylvain Munaut
