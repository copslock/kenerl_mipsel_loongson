Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Apr 2005 13:14:23 +0100 (BST)
Received: from mail.timesys.com ([IPv6:::ffff:65.117.135.102]:54912 "EHLO
	exchange.timesys.com") by linux-mips.org with ESMTP
	id <S8224939AbVDGMOJ>; Thu, 7 Apr 2005 13:14:09 +0100
Received: from [192.168.2.27] ([192.168.2.27]) by exchange.timesys.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Thu, 7 Apr 2005 08:09:57 -0400
Message-ID: <4255240E.4050701@timesys.com>
Date:	Thu, 07 Apr 2005 08:14:06 -0400
From:	Greg Weeks <greg.weeks@timesys.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips@linux-mips.org
Subject: Re: memcpy prefetch
References: <4253D67C.4010705@timesys.com> <20050406200848.GB4978@linux-mips.org>
In-Reply-To: <20050406200848.GB4978@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Apr 2005 12:09:57.0625 (UTC) FILETIME=[B735B690:01C53B6A]
Return-Path: <greg.weeks@timesys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7622
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: greg.weeks@timesys.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:

>On Wed, Apr 06, 2005 at 08:30:52AM -0400, Greg Weeks wrote:
>
>  
>
>>In trying to understand the prefetch code in memcpy it looks like it's 
>>prefetching too far out in front of the loop. In the main aligned loop 
>>the loop copies 32 or 64 bytes of data and the prefetch is trying to 
>>prefetch 256 bytes ahead of the current copy. The prefetches should also 
>>pay attention to cache line size and they currently don't. If the line 
>>size is less than the copy size we are skipping prefetches that should 
>>be done. For the 4kc the line size is only 16 bytes. We should be doing 
>>a prefetch for each line. The src_unaligned_dst_aligned loop is even 
>>worse as it prefetches 288 bytes ahead of the copy and only copies 16 or 
>>32 bytes at a time.
>>
>>Have I totally misunderstood the code?
>>    
>>
>
>Nope, you've understood that perfectly right.  The messy thing is that on
>a whole bunch of system we don't know the cacheline size before runtime
>so we have two choices a) work under worst case assumptions which would be
>16 bytes.  Or do the same thing as we're already doing it for a bunch of
>other performance sensitive functions, generating them at runtime.  Choose
>your poison ;-)
>  
>
What's the performance hit for doing a pref on a cache line that is 
already pref'd? Does it turn into a nop, or do we get some horrible 
degenerate case? Are 64 bit processors always at least 32 byte cache 
line size? I don't really expect anyone to know the answers right now. I 
expect I'll need to time code to tell. This makes generating them at run 
time look better and better.

Greg Weeks
