Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Apr 2009 16:32:15 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:36061 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S20023952AbZDXPcJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 24 Apr 2009 16:32:09 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B49f1db580000>; Fri, 24 Apr 2009 11:31:36 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 24 Apr 2009 08:30:37 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 24 Apr 2009 08:30:37 -0700
Message-ID: <49F1DB1B.2060209@caviumnetworks.com>
Date:	Fri, 24 Apr 2009 08:30:35 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	"Kevin D. Kissell" <kevink@paralogos.com>
CC:	Brian Foster <brian.foster@innova-card.com>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 1/2] MIPS: Preliminary vdso.
References: <49EE3B0F.3040506@caviumnetworks.com> <49EEE4EA.8040100@paralogos.com> <49EF5B88.90004@caviumnetworks.com> <200904240920.03343.brian.foster@innova-card.com> <49F16F38.8060009@paralogos.com>
In-Reply-To: <49F16F38.8060009@paralogos.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Apr 2009 15:30:37.0270 (UTC) FILETIME=[9DF03F60:01C9C4F1]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22469
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Kevin D. Kissell wrote:
> Brian Foster wrote:
>> On Wednesday 22 April 2009 20:01:44 David Daney wrote:
>>   
>>> Kevin D. Kissell wrote:
>>>     
>>>> David Daney wrote:
>>>>       
>>>>> This is a preliminary patch to add a vdso to all user processes.
>>>>> Still missing are ELF headers and .eh_frame information.  But it is
>>>>> enough to allow us to move signal trampolines off of the stack.
>>>>>
>>>>> We allocate a single page (the vdso) and write all possible signal
>>>>> trampolines into it.  The stack is moved down by one page and the vdso
>>>>> is mapped into this space.
>>>>>
>>>>> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
>>>>>         
>>>> Note that for FPU-less CPUs, the kernel FP emulator also uses a user
>>>> stack trampoline to execute instructions in the delay slots of emulated
>>>> FP branches.  I didn't see any of the math-emu modules being tweaked in
>>>> either part of your patch.  Presumably, one would want to move that
>>>> operation into the vdso as well.
>>>>       
>>
>> Kevin,
>>
>>    As David says, this is a Very Ugly Problem.  Each FP trampoline
>>   is effectively per-(runtime-)instance per-thread, i.e., there is
>>   a unique FP trampoline for every dynamic instance of (non-trivial
>>   non-FP) instruction in an FP delay slot.  This is essentially the
>>   complete opposite of the signal-return trampoline, which is fixed
>>   (constant text) for all instances in all threads.
>>
>>    As such, David's vdso (assuming it's similar to those on other
>>   architectures (I've not looked at it closely yet)) may not have
>>   any obvious role to play in moving the FP trampoline('s code?)
>>   off the user's stack.
>>   
> I haven't reviewed David's code in detail, but from his description, I 
> thought that there was a vdso page per task/thread.  If there's only one 
> per processor, then, yes, that poses a challenge to porting the FPU 
> emulation code to use it, since, as you observe, the instruction 
> sequence to be executed may differ for each delay slot emulation.  It 
> should still be possible, though.  FP emulation is in itself expensive, 
> and FP branches with live delay slots are a smallish subset of the 
> overall FP instructions to be emulated, so a dynamic scheme to 
> allocate/free slots in a vdso page wouldn't have that dramatic a 
> performance impact, overall.  As the instructions aren't constant, the 
> I-caches would need to be flushed after each dsemul setup, even using a 
> vdso page, but that shouldn't break the fact that one could avoid it for 
> signals, so long as a different cache line within the vdso page is used 
> for signal versus dsemul trampolines.
> 

Kevin is right, this is ugly.

My current plan is to map an anonymous page with execute permission for 
each vma (process) and place all FP trampolines there.  Each thread that 
needs a trampoline will allocate a piece of this page and write the 
trampoline.  We can arrange it so that the only way a thread can exit 
the trampoline is by taking some sort of fault (currently this is true 
for the normal case), or exiting.  Then we free the trampoline for other 
threads to use.  If all the slots in the trampoline page are in use, a 
thread would block until there is a free one, rarely, if ever would this 
happen.

Doing the memory management for the trampoline area and the blocking 
would add quite a bit of complexity.  I am not really concerned about 
performance because people that want good FP performance should use a 
CPU with FP hardware (like my R5000 O2).

David Daney
