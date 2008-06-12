Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jun 2008 17:31:10 +0100 (BST)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.144]:38554 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S28579677AbYFLQbI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 12 Jun 2008 17:31:08 +0100
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id 7F86D31EDF9;
	Thu, 12 Jun 2008 16:31:07 +0000 (UTC)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [67.116.42.147])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Thu, 12 Jun 2008 16:31:07 +0000 (UTC)
Received: from silver64.hq2.avtrex.com ([192.168.7.27]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 12 Jun 2008 09:30:54 -0700
Message-ID: <48514F3E.6050906@avtrex.com>
Date:	Thu, 12 Jun 2008 09:30:54 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>,
	GCC Mailing List <gcc@gcc.gnu.org>,
	MIPS Linux List <linux-mips@linux-mips.org>,
	rdsandiford@googlemail.com
Subject: Re: Resend: [PATCH] [MIPS] Fix asm constraints for 'ins'	instructions.
References: <48500599.9080807@avtrex.com>	<20080611172950.GA16600@linux-mips.org> <48500EDD.404@avtrex.com> <871w339hy9.fsf@firetop.home>
In-Reply-To: <871w339hy9.fsf@firetop.home>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Jun 2008 16:30:54.0073 (UTC) FILETIME=[AF2F9690:01C8CCA9]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19519
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Richard Sandiford wrote:
> David Daney <ddaney@avtrex.com> writes:
>> Ralf Baechle wrote:
>>> On Wed, Jun 11, 2008 at 10:04:25AM -0700, David Daney wrote:
>>>
>>>> The third operand to 'ins' must be a constant int, not a register.
>>>>
>>>> Signed-off-by: David Daney <ddaney@avtrex.com>
>>>> ---
>>>> include/asm-mips/bitops.h |    6 +++---
>>>> 1 files changed, 3 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/include/asm-mips/bitops.h b/include/asm-mips/bitops.h
>>>> index 6427247..9a7274b 100644
>>>> --- a/include/asm-mips/bitops.h
>>>> +++ b/include/asm-mips/bitops.h
>>>> @@ -82,7 +82,7 @@ static inline void set_bit(unsigned long nr, volatile unsigned long *addr)
>>>> 		"2:	b	1b					\n"
>>>> 		"	.previous					\n"
>>>> 		: "=&r" (temp), "=m" (*m)
>>>> -		: "ir" (bit), "m" (*m), "r" (~0));
>>>> +		: "i" (bit), "m" (*m), "r" (~0));
>>>> #endif /* CONFIG_CPU_MIPSR2 */
>>>> 	} else if (cpu_has_llsc) {
>>>> 		__asm__ __volatile__(
>>> An old trick to get gcc to do the right thing.  Basically at the stage when
>>> gcc is verifying the constraints it may not yet know that it can optimize
>>> things into an "i" argument, so compilation may fail if "r" isn't in the
>>> constraints.  However we happen to know that due to the way the code is
>>> written gcc will always be able to make use of the "i" constraint so no
>>> code using "r" should ever be created.
>>>
>>> The trick is a bit ugly; I think it was used first in asm-i386/io.h ages ago
>>> and I would be happy if we could get rid of it without creating new problems.
>>> Maybe a gcc hacker here can tell more?
>> It is not nice to lie to GCC.
>>
>> CCing GCC and Richard in hopes that a wider audience may shed some light on the issue.
> 
> You _might_ be able to use "i#r" instead of "ri", but I wouldn't
> really recommend it.  Even if it works now, I don't think there's
> any guarantee it will in future.
> 
> There are tricks you could pull to detect the problem at compile time
> rather than assembly time, but that's probably not a big win.  And again,
> I wouldn't recommend them.
> 
> I'm not saying anything you don't know here, but if the argument is
> always a syntactic constant, the safest bet would be to apply David's
> patch and also convert the function into a macro.  I notice some other
> ports use macros rather than inline functions here.  I assume you've
> deliberately rejected macros as being too ugly though.

I am still a little unclear on this.

To restate the question:

static inline void f(unsigned nr, unsigned *p)
{
  unsigned short bit = nr & 5;

  if (__builtin_constant_p(bit)) {
    __asm__ __volatile__ ("  foo %0, %1" : "=m" (*p) : "i" (bit));
  }
  else {
    // Do something else.
  }
}
.
.
.
  f(3, some_pointer);
.
.
.

Among the versions of GCC that can build the current kernel, will any fail on this code because the "i" constraint  cannot be matched when expanded to RTL?

David Daney
