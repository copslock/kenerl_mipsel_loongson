Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Nov 2008 00:16:50 +0000 (GMT)
Received: from gw.goop.org ([64.81.55.164]:26583 "EHLO mail.goop.org")
	by ftp.linux-mips.org with ESMTP id S23896563AbYKYAQm (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 25 Nov 2008 00:16:42 +0000
Received: by lurch.goop.org (Postfix, from userid 525)
	id CAFC82C8044; Mon, 24 Nov 2008 16:16:37 -0800 (PST)
Received: from lurch.goop.org (localhost [127.0.0.1])
	by lurch.goop.org (Postfix) with ESMTP id 6523A2C8042;
	Mon, 24 Nov 2008 16:16:37 -0800 (PST)
Received: from abulafia.goop.org (adsl-76-233-236-102.dsl.pltn13.sbcglobal.net [76.233.236.102])
	by lurch.goop.org (Postfix) with ESMTPSA;
	Mon, 24 Nov 2008 16:16:37 -0800 (PST)
Message-ID: <492B43E4.2020607@goop.org>
Date:	Mon, 24 Nov 2008 16:16:36 -0800
From:	Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 2.0.0.17 (X11/20081009)
MIME-Version: 1.0
To:	Ingo Molnar <mingo@elte.hu>
CC:	Andrew Morton <akpm@linux-foundation.org>,
	David Daney <ddaney@caviumnetworks.com>,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: Make BUG() __noreturn.
References: <49260E4C.8080500@caviumnetworks.com> <20081121150023.032f7b5b.akpm@linux-foundation.org> <20081123095818.GU30453@elte.hu>
In-Reply-To: <20081123095818.GU30453@elte.hu>
X-Enigmail-Version: 0.95.6
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP by lurch.goop.org
Return-Path: <jeremy@goop.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21408
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jeremy@goop.org
Precedence: bulk
X-list: linux-mips

Ingo Molnar wrote:
> * Andrew Morton <akpm@linux-foundation.org> wrote:
>
>   
>>> +static inline void __noreturn BUG(void)
>>> +{
>>> +	__asm__ __volatile__("break %0" : : "i" (BRK_BUG));
>>> +	/* Fool GCC into thinking the function doesn't return. */
>>> +	while (1)
>>> +		;
>>> +}
>>>       
>> This kind of sucks, doesn't it?  It adds instructions into the 
>> kernel text, very frequently on fast paths.  Those instructions are 
>> never executed, and we're blowing away i-cache just to quash 
>> compiler warnings.
>>
>> For example, this:
>>
>> --- a/arch/x86/include/asm/bug.h~a
>> +++ a/arch/x86/include/asm/bug.h
>> @@ -22,14 +22,12 @@ do {								\
>>  		     ".popsection"				\
>>  		     : : "i" (__FILE__), "i" (__LINE__),	\
>>  		     "i" (sizeof(struct bug_entry)));		\
>> -	for (;;) ;						\
>>  } while (0)
>>  
>>  #else
>>  #define BUG()							\
>>  do {								\
>>  	asm volatile("ud2");					\
>> -	for (;;) ;						\
>>  } while (0)
>>  #endif
>>  
>> _
>>
>> reduces the size of i386 mm/vmalloc.o text by 56 bytes.
>>     
>
> yes - the total image effect is significantly - recently looked at how 
> much larger !CONFIG_BUG builds would get if we inserted an infinite 
> loop into them - it was in the 50K text range (!).
>
> but in the x86 ud2 case we could guarantee that we wont ever return 
> from that exception. Mind sending a patch with a signoff, a 
> description and an infinite loop in the u2d handler?
>   

There are two arguments against making BUG() a noreturn:

    * if you compile without BUG enabled, then it won't be noreturn anyway
    * making it noreturn kills the lifetime of any variables that would
      otherwise be considered alive, making the DWARF debug info at that
      point less reliable (which is a pain even for post-mortem debugging)

The counter-argument is that not making it noreturn will keep variables 
alive that wouldn't otherwise be, causing greater register pressure, 
spillage, etc.

If adding an infinite loop really adds 50k to the image, the extra size 
must come from the changes to variable lifetime rather than the loop 
instructions themselves (which are only 2 bytes per instance, and we 
don't have 25,000 BUGs in the kernel, do we?).

    J
