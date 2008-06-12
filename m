Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jun 2008 09:27:19 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.174]:54467 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S28577578AbYFLI1Q (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 12 Jun 2008 09:27:16 +0100
Received: by ug-out-1314.google.com with SMTP id 30so279217ugs.39
        for <linux-mips@linux-mips.org>; Thu, 12 Jun 2008 01:27:14 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:mail-followup-to:cc
         :subject:references:date:in-reply-to:message-id:user-agent
         :mime-version:content-type;
        bh=wNjZmHEX6jVa8NDjAz4yAd+Haf+p5cjtOBBQPiuJcWg=;
        b=S6BlVV2UZ15i1fpwOtSE5N0Mxs/j/ka5ixLiGmcRaqZ85pa2RDfdx2FeKgmeuwjzVk
         phEhJjP1OAgwvxrel03jEIE9S4I1Kn7FadMUjszt0mT/OljT9dkIPkXhAlxbHb2LxWdk
         gMfizHIEUgvjCabD7AQWTQ+CIn4rNcV3xBrJA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:mail-followup-to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-type;
        b=bK5AwrOY/ATQ93WLvjgiElIZ1RY/EVxy54Gv8FUG0dMBqPEKwo8ncddSB25IXsTERf
         gtlxG+Ss8SxiWQej+hQu7EkGvoo/3Q9z9XPyfMVNJcTGz90WGoLiNSqj1QAyhBe3iLSK
         DWTigSGSpujNVGERqpwCieZdHsxztqr21u1ko=
Received: by 10.210.54.19 with SMTP id c19mr823300eba.168.1213259234824;
        Thu, 12 Jun 2008 01:27:14 -0700 (PDT)
Received: from localhost ( [79.75.55.39])
        by mx.google.com with ESMTPS id t12sm1715476gvd.10.2008.06.12.01.27.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 12 Jun 2008 01:27:13 -0700 (PDT)
From:	Richard Sandiford <rdsandiford@googlemail.com>
To:	David Daney <ddaney@avtrex.com>
Mail-Followup-To: David Daney <ddaney@avtrex.com>,Ralf Baechle <ralf@linux-mips.org>,  GCC Mailing List <gcc@gcc.gnu.org>,  MIPS Linux List <linux-mips@linux-mips.org>, rdsandiford@googlemail.com
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	GCC Mailing List <gcc@gcc.gnu.org>,
	MIPS Linux List <linux-mips@linux-mips.org>
Subject: Re: Resend: [PATCH] [MIPS] Fix asm constraints for 'ins'	instructions.
References: <48500599.9080807@avtrex.com>
	<20080611172950.GA16600@linux-mips.org> <48500EDD.404@avtrex.com>
Date:	Thu, 12 Jun 2008 09:27:10 +0100
In-Reply-To: <48500EDD.404@avtrex.com> (David Daney's message of "Wed\, 11 Jun
	2008 10\:43\:57 -0700")
Message-ID: <871w339hy9.fsf@firetop.home>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <rdsandiford@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19494
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rdsandiford@googlemail.com
Precedence: bulk
X-list: linux-mips

David Daney <ddaney@avtrex.com> writes:
> Ralf Baechle wrote:
>> On Wed, Jun 11, 2008 at 10:04:25AM -0700, David Daney wrote:
>> 
>>> The third operand to 'ins' must be a constant int, not a register.
>>>
>>> Signed-off-by: David Daney <ddaney@avtrex.com>
>>> ---
>>> include/asm-mips/bitops.h |    6 +++---
>>> 1 files changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/include/asm-mips/bitops.h b/include/asm-mips/bitops.h
>>> index 6427247..9a7274b 100644
>>> --- a/include/asm-mips/bitops.h
>>> +++ b/include/asm-mips/bitops.h
>>> @@ -82,7 +82,7 @@ static inline void set_bit(unsigned long nr, volatile unsigned long *addr)
>>> 		"2:	b	1b					\n"
>>> 		"	.previous					\n"
>>> 		: "=&r" (temp), "=m" (*m)
>>> -		: "ir" (bit), "m" (*m), "r" (~0));
>>> +		: "i" (bit), "m" (*m), "r" (~0));
>>> #endif /* CONFIG_CPU_MIPSR2 */
>>> 	} else if (cpu_has_llsc) {
>>> 		__asm__ __volatile__(
>> 
>> An old trick to get gcc to do the right thing.  Basically at the stage when
>> gcc is verifying the constraints it may not yet know that it can optimize
>> things into an "i" argument, so compilation may fail if "r" isn't in the
>> constraints.  However we happen to know that due to the way the code is
>> written gcc will always be able to make use of the "i" constraint so no
>> code using "r" should ever be created.
>> 
>> The trick is a bit ugly; I think it was used first in asm-i386/io.h ages ago
>> and I would be happy if we could get rid of it without creating new problems.
>> Maybe a gcc hacker here can tell more?
>
> It is not nice to lie to GCC.
>
> CCing GCC and Richard in hopes that a wider audience may shed some light on the issue.

You _might_ be able to use "i#r" instead of "ri", but I wouldn't
really recommend it.  Even if it works now, I don't think there's
any guarantee it will in future.

There are tricks you could pull to detect the problem at compile time
rather than assembly time, but that's probably not a big win.  And again,
I wouldn't recommend them.

I'm not saying anything you don't know here, but if the argument is
always a syntactic constant, the safest bet would be to apply David's
patch and also convert the function into a macro.  I notice some other
ports use macros rather than inline functions here.  I assume you've
deliberately rejected macros as being too ugly though.

Richard
