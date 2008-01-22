Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Jan 2008 18:56:06 +0000 (GMT)
Received: from zrtps0kn.nortel.com ([47.140.192.55]:31432 "EHLO
	zrtps0kn.nortel.com") by ftp.linux-mips.org with ESMTP
	id S28589591AbYAVSz6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 22 Jan 2008 18:55:58 +0000
Received: from zcarhxs1.corp.nortel.com (zcarhxs1.corp.nortel.com [47.129.230.89])
	by zrtps0kn.nortel.com (Switch-2.2.6/Switch-2.2.0) with ESMTP id m0MItmD03934;
	Tue, 22 Jan 2008 18:55:48 GMT
Received: from [47.130.25.222] ([47.130.25.222] RDNS failed) by zcarhxs1.corp.nortel.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 22 Jan 2008 13:55:48 -0500
Message-ID: <47963C31.2000403@nortel.com>
Date:	Tue, 22 Jan 2008 12:55:45 -0600
From:	"Chris Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips@linux-mips.org
Subject: Re: quick question on 64-bit values with 32-bit inline assembly
References: <4794DFE1.5040805@nortel.com> <20080122175734.GA31013@linux-mips.org>
In-Reply-To: <20080122175734.GA31013@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Jan 2008 18:55:48.0461 (UTC) FILETIME=[66C969D0:01C85D28]
Return-Path: <CFRIESEN@nortel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18114
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cfriesen@nortel.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Mon, Jan 21, 2008 at 12:09:37PM -0600, Chris Friesen wrote:

>>We're running a 64-bit kernel and 32-bit userspace.  We've got some code 
>>that is trying to get a 64-bit timestamp in userspace.
>>
>>The following code seems to work fine in the kernel but in userspace it 
>>appears to be swapping the two words in the result.
>>
>>gethrtime(void)
>>{
>>   unsigned long long result;
>>
>>   asm volatile ("rdhwr %0,$31" : "=r" (result));

> Ah, Cavium.

Yes indeed.  Any peculiarities that we should be watching out for? 
Previous mailing list threads would be great.

> Ouch.  You found a nasty special case.  Normally 32-bit userspace should
> not use 64-bit values but since you're running a 64-bit kernel.

I haven't done mips in years and was a bit surprised that the 
instruction set didn't provide for ways to read high and low words of a 
64-bit value the way that ppc32 does.

> unsigned long long gethrtime(void)
> {
> 	unsigned long long result;
> 
> 	asm volatile(
> 	"	.set	mips64r2		\n"
> 	"	rdhwr	%M0, $31		\n"
> 	"	sll	%L0, %M0, 0		\n"
> 	"	dsra	%M0, 32			\n"
> 	"	.set	mips0			\n"
> 	: "=r" (result));
> 
> 	return result;
> }
> 
> Note this wouldn't possibly work on a 32-bit kernel because 32-bit kernels
> will corrupt the upper 32-bit of integer registers so you might lose the
> result value before you can stash it away.  Also 32-bit kernels don't allow
> the execution of 64-bit instructions, not even on 64-bit processors.

I was a bit worried looking at the mips32 architecture manuals...didn't 
realize that you could just flip to 64-bit mode like that.

Thanks for all the help.

Chris
