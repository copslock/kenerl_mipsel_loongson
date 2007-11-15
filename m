Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Nov 2007 17:21:34 +0000 (GMT)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.144]:58035 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S20031871AbXKORVY (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 15 Nov 2007 17:21:24 +0000
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id 770CD30F71D;
	Thu, 15 Nov 2007 17:21:24 +0000 (UTC)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [67.116.42.147])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Thu, 15 Nov 2007 17:21:24 +0000 (UTC)
Received: from [192.168.7.26] ([192.168.7.26]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 15 Nov 2007 09:21:10 -0800
Message-ID: <473C8006.2070902@avtrex.com>
Date:	Thu, 15 Nov 2007 09:21:10 -0800
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 1.5.0.12 (X11/20071019)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Franck Bui-Huu <vagabon.xyz@gmail.com>, linux-mips@linux-mips.org
Subject: Re: Cannot unwind through MIPS signal frames with	ICACHE_REFILLS_WORKAROUND_WAR
References: <473957B6.3030202@avtrex.com> <18233.36645.232058.964652@zebedee.pink> <20071113121036.GA6582@linux-mips.org> <473C0761.1040205@gmail.com> <20071115115351.GA4973@linux-mips.org>
In-Reply-To: <20071115115351.GA4973@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Nov 2007 17:21:10.0408 (UTC) FILETIME=[EA504880:01C827AB]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17511
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Thu, Nov 15, 2007 at 09:46:25AM +0100, Franck Bui-Huu wrote:
> 
>> Ralf Baechle wrote:
>>> Another reason is to get rid of the classic trampoline the kernel installs
>>> on the stack.  On some multiprocessor systems it requires a cacheflush
>> BTW, could we get rid of the trampoline so easily ? I mean won't we have
>> to keep it for backward compatibility reasons ?

There has to be some way for user code to unwind the call stack through 
signal handler frames.  For Linux/MIPS systems that use GCC as their 
system compiler, this is done by code in libgcc which is part of the GCC 
runtime.

Currently the unwinder examines the code at the signal handler return 
address and if it detects one of the several know trampoline code 
sequences, it makes assumptions about the way the kernel lays out the 
stack.  In particular, it assumes that there is a struct sigcontext at a 
  well known offset from the stack pointer at entry to the signal handler.

The code that handles this is in gcc/config/mips/linux-unwind.h

As of GCC-4.3 the location of the trampoline is unimportant, but the 
location of the sigcontext relative to the value in $sp is important and 
should not be changed unless there really is no other choice.


> 
> The trampolines are an implementation detail.  Little software needs to
> know about it, so while I expect some slight colateral damage from getting
> rid of trampolines it's not going to be painful.  GDB is the primary piece
> of software that will need to change.

And any user code that uses SIGSEGV to detect and handle dereferencing 
null pointers.

> 
> Some of the other architectures have an sa_restorer field in struct
> sigaction but we don't have that on MIPS.
> 
> One way to deal with this would be to do a similar as IRIX where the
> sigaction(2) takes a 4th argument which takes the role of sa_restorer.
> For backward compatibility an SA_RESTORER field.  So if the SA_RESTORER
> is clear we'd be using a classic trampoline, if it's set the value of
> the 4th argument.
> 
> Or slightly crazier, put a kernel address into the $ra register of the
> invoked signal handler.  So the signal handler will cause an address
> error exception which then can be trapped.  Additional advantage - some of
> the "Don't let your children do this ..." sections of code can go away ;-)

I am liking the idea of putting the trampoline code in the (as of yet 
non-existent vdso).  This eliminates the need to flush the icache, but 
maintains the ability of user code to unwind through signal frames.

Putting a .eh_frame section in the vdso would be even better as that 
would eliminate the need for libgcc to do code reading and let the 
kernel use any means desired to return from signal handlers.

David Daney
