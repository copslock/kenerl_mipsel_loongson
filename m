Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Mar 2004 21:32:28 +0100 (BST)
Received: from zcars04f.nortelnetworks.com ([IPv6:::ffff:47.129.242.57]:25039
	"EHLO zcars04f.nortelnetworks.com") by linux-mips.org with ESMTP
	id <S8225772AbUCaUc0>; Wed, 31 Mar 2004 21:32:26 +0100
Received: from zcard309.ca.nortel.com (zcard309.ca.nortel.com [47.129.242.69])
	by zcars04f.nortelnetworks.com (Switch-2.2.6/Switch-2.2.0) with ESMTP id i2VKQFm08962;
	Wed, 31 Mar 2004 15:26:16 -0500 (EST)
Received: from zcard0k6.ca.nortel.com ([47.129.242.158]) by zcard309.ca.nortel.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2653.13)
	id GXT6M5VK; Wed, 31 Mar 2004 15:26:16 -0500
Received: from americasm01.nt.com (wcary3hh.ca.nortel.com [47.129.112.118]) by zcard0k6.ca.nortel.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2653.13)
	id DNVQHS2D; Wed, 31 Mar 2004 15:26:16 -0500
Message-ID: <406B2967.5090607@americasm01.nt.com>
Date: Wed, 31 Mar 2004 15:26:15 -0500
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: "Lijun Chen" <chenli@nortelnetworks.com>
Organization: Nortel Networks
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20021120 Netscape/7.01
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jun Sun <jsun@mvista.com>
CC: linux-mips@linux-mips.org, Dominic Sweetman <dom@mips.com>,
	ralf@linux-mips.org
Subject: Re: exception priority for BCM1250
References: <4069F90D.9060903@americasm01.nt.com> <16490.33481.5505.705679@arsenal.mips.com> <406AE627.30104@americasm01.nt.com> <20040331101905.D6712@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <chenli@nortelnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4712
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenli@nortelnetworks.com
Precedence: bulk
X-list: linux-mips

Jun, Thanks a lot for your reply. Your jtrace is interesting, i am going 
to give a try.
Lijun

Jun Sun wrote:

>On Wed, Mar 31, 2004 at 10:39:19AM -0500, Lijun Chen wrote:
>  
>
>>Thanks a lot, Dominic and Ralf.
>>So interrupts and a few exception conditions are maskable and preemptable.
>>The machine-level exceptions are non-maskable.If ever multiple 
>>exceptions occur
>>at the same time, cpu picks the highest priority one.
>>
>>But in the MIPS64 spec, it says the EXL bit is set when any exception 
>>other than Reset,
>>Soft reset, NMI or Cache Error exception are taken. Does this mean Cache 
>>error can
>>preempt whatever else is going on except for Reset and NMI?
>>
>>    
>>
>
>I think so.  Usually when cache error happens you are dead.  
>For bcm1250 there is a cache error handler which works around a hw bug.
>I believe the workaround code is in the linux-mips.org tree.
> 
>  
>
>>My intention is to write some information to a kernel buffer when cache 
>>and bus
>>error exceptions occur. If they use the common buffer and a spin_lock() 
>>is used before
>>writing, will this cause dead lock if kernel is handling bus error while 
>>a cache error
>>occurs?
>>
>>    
>>
>
>It will be a deadlock only if another exception happens and you try
>to acquire the lock while you are already in the middle of spin_lock()/spin_unlock(). 
>You should use spin_lock() in a scope as small as possible.
>
>BTW, you may my tiby tracing patch handy for something like this.
>
>http://linux.junsun.net/patches/generic/experimental/040316.a-jstrace.patch
>
>Jun
>
>  
>
