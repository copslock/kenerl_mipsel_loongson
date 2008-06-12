Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jun 2008 21:10:31 +0100 (BST)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.144]:25300 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S28580441AbYFLUKZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 12 Jun 2008 21:10:25 +0100
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id 252C931EA05;
	Thu, 12 Jun 2008 20:10:28 +0000 (UTC)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [67.116.42.147])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Thu, 12 Jun 2008 20:10:27 +0000 (UTC)
Received: from dl2.hq2.avtrex.com ([192.168.7.26]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 12 Jun 2008 13:10:11 -0700
Message-ID: <485182A2.7020702@avtrex.com>
Date:	Thu, 12 Jun 2008 13:10:10 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
MIME-Version: 1.0
To:	David Daney <ddaney@avtrex.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	GCC Mailing List <gcc@gcc.gnu.org>,
	MIPS Linux List <linux-mips@linux-mips.org>,
	rdsandiford@googlemail.com
Subject: Re: Resend: [PATCH] [MIPS] Fix asm constraints for 'ins'	instructions.
References: <48500599.9080807@avtrex.com>	<20080611172950.GA16600@linux-mips.org> <48500EDD.404@avtrex.com>	<871w339hy9.fsf@firetop.home> <48514F3E.6050906@avtrex.com> <87k5gu8qey.fsf@firetop.home>
In-Reply-To: <87k5gu8qey.fsf@firetop.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Jun 2008 20:10:11.0999 (UTC) FILETIME=[51EBC2F0:01C8CCC8]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19527
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Richard Sandiford wrote:
> David Daney <ddaney@avtrex.com> writes:
>> Richard Sandiford wrote:
>>> David Daney <ddaney@avtrex.com> writes:
>>>> Ralf Baechle wrote:
>>>>> On Wed, Jun 11, 2008 at 10:04:25AM -0700, David Daney wrote:
>>>>>
>>>>>> The third operand to 'ins' must be a constant int, not a register.
>>>>>>
>>>>>> Signed-off-by: David Daney <ddaney@avtrex.com>
>>>>>> ---
>>>>>> include/asm-mips/bitops.h |    6 +++---
>>>>>> 1 files changed, 3 insertions(+), 3 deletions(-)
>>>>>>
>>>>>> diff --git a/include/asm-mips/bitops.h b/include/asm-mips/bitops.h
>>>>>> index 6427247..9a7274b 100644
>>>>>> --- a/include/asm-mips/bitops.h
>>>>>> +++ b/include/asm-mips/bitops.h
>>>>>> @@ -82,7 +82,7 @@ static inline void set_bit(unsigned long nr, volatile unsigned long *addr)
>>>>>> 		"2:	b	1b					\n"
>>>>>> 		"	.previous					\n"
>>>>>> 		: "=&r" (temp), "=m" (*m)
>>>>>> -		: "ir" (bit), "m" (*m), "r" (~0));
>>>>>> +		: "i" (bit), "m" (*m), "r" (~0));
>>>>>> #endif /* CONFIG_CPU_MIPSR2 */
>>>>>> 	} else if (cpu_has_llsc) {
>>>>>> 		__asm__ __volatile__(
>>>>> An old trick to get gcc to do the right thing.  Basically at the stage when
>>>>> gcc is verifying the constraints it may not yet know that it can optimize
>>>>> things into an "i" argument, so compilation may fail if "r" isn't in the
>>>>> constraints.  However we happen to know that due to the way the code is
>>>>> written gcc will always be able to make use of the "i" constraint so no
>>>>> code using "r" should ever be created.
>>>>>
>>>>> The trick is a bit ugly; I think it was used first in asm-i386/io.h ages ago
>>>>> and I would be happy if we could get rid of it without creating new problems.
>>>>> Maybe a gcc hacker here can tell more?
>>>> It is not nice to lie to GCC.
>>>>
>>>> CCing GCC and Richard in hopes that a wider audience may shed some light on the issue.
>>> You _might_ be able to use "i#r" instead of "ri", but I wouldn't
>>> really recommend it.  Even if it works now, I don't think there's
>>> any guarantee it will in future.
>>>
>>> There are tricks you could pull to detect the problem at compile time
>>> rather than assembly time, but that's probably not a big win.  And again,
>>> I wouldn't recommend them.
>>>
>>> I'm not saying anything you don't know here, but if the argument is
>>> always a syntactic constant, the safest bet would be to apply David's
>>> patch and also convert the function into a macro.  I notice some other
>>> ports use macros rather than inline functions here.  I assume you've
>>> deliberately rejected macros as being too ugly though.
>> I am still a little unclear on this.
>>
>> To restate the question:
>>
>> static inline void f(unsigned nr, unsigned *p)
>> {
>>   unsigned short bit = nr & 5;
>>
>>   if (__builtin_constant_p(bit)) {
>>     __asm__ __volatile__ ("  foo %0, %1" : "=m" (*p) : "i" (bit));
>>   }
>>   else {
>>     // Do something else.
>>   }
>> }
>> .
>> .
>> .
>>   f(3, some_pointer);
>> .
>> .
>> .
>>
>> Among the versions of GCC that can build the current kernel, will any
>> fail on this code because the "i" constraint cannot be matched when
>> expanded to RTL?
> 
> Someone will point this out if I don't, so for avoidance of doubt:
> this needs to be always_inline.  It also isn't guaranteed to work
> with "bit" being a separate statement.  I'm not truly sure it's
> guaranteed to work even with:
> 
>     __asm__ __volatile__ ("  foo %0, %1" : "=m" (*p) : "i" (nr & 5));
> 
> but I think we'd try hard to make sure it does.
> 
> I think Maciej said that 3.2 was the minimum current version.
> Even with those two issues sorted out, I don't think you can
> rely on this sort of thing with compilers that used RTL inlining.
> (always_inline does go back to 3.2, in case you're wondering.)
> 

Well I withdraw the patch.  With the current kernel code we seem to always get good code generation.  In the event that the compiler tries to put the shift amount (nr) in a register, the assembler will complain.  I don't think it is possible to generate bad object code, so best to leave it alone.

FYI, the reason that I stumbled on this several weeks ago is that if(__builtin_constant_p(nr)) in the trunk compiler was generating code for the asm even though nr was not constant.

David Daney
