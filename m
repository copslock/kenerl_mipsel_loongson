Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Mar 2004 16:39:36 +0100 (BST)
Received: from zcars04f.nortelnetworks.com ([IPv6:::ffff:47.129.242.57]:58755
	"EHLO zcars04f.nortelnetworks.com") by linux-mips.org with ESMTP
	id <S8225759AbUCaPj3>; Wed, 31 Mar 2004 16:39:29 +0100
Received: from zcard309.ca.nortel.com (zcard309.ca.nortel.com [47.129.242.69])
	by zcars04f.nortelnetworks.com (Switch-2.2.6/Switch-2.2.0) with ESMTP id i2VFdKm00601;
	Wed, 31 Mar 2004 10:39:20 -0500 (EST)
Received: from zcard0k6.ca.nortel.com ([47.129.242.158]) by zcard309.ca.nortel.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2653.13)
	id GXT6MSYW; Wed, 31 Mar 2004 10:39:19 -0500
Received: from americasm01.nt.com (wcary3hh.ca.nortel.com [47.129.112.118]) by zcard0k6.ca.nortel.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2653.13)
	id DNVQHRNB; Wed, 31 Mar 2004 10:39:20 -0500
Message-ID: <406AE627.30104@americasm01.nt.com>
Date: Wed, 31 Mar 2004 10:39:19 -0500
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: "Lijun Chen" <chenli@nortelnetworks.com>
Organization: Nortel Networks
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20021120 Netscape/7.01
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
CC: Dominic Sweetman <dom@mips.com>, ralf@linux-mips.org
Subject: Re: exception priority for BCM1250
References: <4069F90D.9060903@americasm01.nt.com> <16490.33481.5505.705679@arsenal.mips.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <chenli@nortelnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4709
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenli@nortelnetworks.com
Precedence: bulk
X-list: linux-mips

Thanks a lot, Dominic and Ralf.
So interrupts and a few exception conditions are maskable and preemptable.
The machine-level exceptions are non-maskable.If ever multiple 
exceptions occur
at the same time, cpu picks the highest priority one.

But in the MIPS64 spec, it says the EXL bit is set when any exception 
other than Reset,
Soft reset, NMI or Cache Error exception are taken. Does this mean Cache 
error can
preempt whatever else is going on except for Reset and NMI?

My intention is to write some information to a kernel buffer when cache 
and bus
error exceptions occur. If they use the common buffer and a spin_lock() 
is used before
writing, will this cause dead lock if kernel is handling bus error while 
a cache error
occurs?

Thanks again.
Lijun

Dominic Sweetman wrote:

>Lijun,
>
>  
>
>>Does anybody know which mips family SB1 core on bcm1250 falls into?
>>It is a MIPS64 processor
>>    
>>
>
>Yes, it complies to the MIPS64 Architecture specification...
>
>  
>
>>... does it belong to 5K family or 20Kc?
>>    
>>
>
>Neither one.  5K and 20Kc are specific core CPUs licensed by MIPS
>Technologies.  Broadcom have an "architecture license" and design
>their own compatible MIPS64 CPUs, like the BCM1250.
>
>  
>
>>What about the exception priorities, such as cache error exception,
>>bus error exception, and so on? Are they maskable or non-maskable? 
>>    
>>
>
>Other than interrupts, only a few obscure exception conditions are
>maskable. 
>
>Ralf was sensible to suggest you back off to the architecture manuals,
>which talk about all MIPS CPUs.  You might also like to read a book
>(like my "See MIPS Run").
>
>  
>
>>Further to my last email, another question is if multiple
>>simultaneous exceptions occur, or kernel is handling an exception,
>>another exception occurs, how linux handles this?
>>    
>>
>
>As always, that depends what you mean by "handling".
>
>At the lowest level, the CPU:
>
>o If ever confronted by multiple possible exceptions at the same time,
>  picks the highest priority one which affects the oldest instruction
>  in the pipeline...
>
>o When it takes the exception and vectors into the kernel exception
>  handler, it atomically sets the register bit SR[EXL] ("exception
>  mode").  In this mode interrupts are disabled.  The kernel code
>  should be careful not to cause an exception.
>
>Read the book, is my advice.
>
>Of course Linux goes on from the low-level exception handler to call
>other kernel functions which you might regard as "handlers" too -
>interrupt routines, for example.  In many cases these OS "handlers"
>are run with SR[EXL] set to zero, making it possible to handle new
>machine-level exceptions...  
>
>But that's complicated.
>
>--
>Dominic Sweetman
>MIPS Technologies
>
>
>  
>
