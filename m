Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Apr 2009 19:26:36 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:46172 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20024487AbZD0S0a (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 27 Apr 2009 19:26:30 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B49f5f8c30000>; Mon, 27 Apr 2009 14:26:11 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 27 Apr 2009 11:26:08 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 27 Apr 2009 11:26:08 -0700
Message-ID: <49F5F8BF.3020501@caviumnetworks.com>
Date:	Mon, 27 Apr 2009 11:26:07 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	"Kevin D. Kissell" <kevink@paralogos.com>
CC:	Brian Foster <brian.foster@innova-card.com>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 1/2] MIPS: Preliminary vdso.
References: <49EE3B0F.3040506@caviumnetworks.com> <49F16F38.8060009@paralogos.com> <49F1DB1B.2060209@caviumnetworks.com> <200904270919.00761.brian.foster@innova-card.com> <49F5AA6A.7010402@paralogos.com> <49F5D546.2000806@caviumnetworks.com> <49F5EB1A.5010407@paralogos.com>
In-Reply-To: <49F5EB1A.5010407@paralogos.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Apr 2009 18:26:08.0245 (UTC) FILETIME=[A220C250:01C9C765]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22496
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Kevin D. Kissell wrote:
> David Daney wrote:
>> Kevin D. Kissell wrote:
>>
>>
>>>  But it *could* be a trap or system call instruction, or a load/store
>>> that would provoke a TLB exception.  In the usual cases, however, as
>>> I believe David was alluding, either the exception will ultimately
>>> unwind to return to execute the magic alignment trap, or the thread
>>> will exit, and could free the emulation slot as part of general cleanup.
>>>
>>> But there's a case that isn't handled in this model, and that's the
>>> case of an exception (or interrupt that falls in the 2-instruction
>>> window) resulting in a signal that is caught and dispatched, and
>>> where either the signal handler does a longjmp and restarts FP
>>> computation, or where the signal handler itself contains a FP branch
>>> with yet another delay slot to be emulated. One *could* get alarm
>>> signal before the original delay slot instruction is executed, so
>>> recycling the same vdso cache line would be premature.  It's hard to
>>> get away from something distinctly stack-like if one wants to cover
>>> these cases.
>>>
>> System calls we don't have to handle, they will eventually return to
>> the break instruction following the delay slot instruction and be
>> handled by the normal processing.
>>
>> I am thinking that all other exceptions will result in one of three
>> cases:
>>
>> 1) They will work like system calls and return to the 'break'.
>>
>> 2) The thread will exit.
>>
>> 3) They result in a signal being sent to the thread.  We can handle it
>> in force_signal().  In this case we would adjust the eip to point at
>> the  original location of the instruction and clean things up.  If the
>> signal handler tries to restart the instruction, the FP emulator will
>> re-run the emulation.
> That's presumably OK if we *know* that the delay slot instruction has
> *not* executed prior to the signal being taken.  But if it has, it may
> have had side-effects, i.e. imagine if it's an "ADD.S f4, f4, f6". We
> can't re-run the emulation without generating erroneous processor
> state.  What do we do if, between the ADD.S and the

FP instructions are always emulated, so they don't do this delay slot 
processing thing.

> BREAK-that-replaces-my-old-alignment-trap, a timer interrupt comes in,
> causing a SIGALRM which is caught and which executes another FP branch? 
> When I first wrote the delay slot handling code, I dreamed of disabling
> interrupts during the delay slot instruction emulation - I think I even
> coded it that way at one point - but it's fundamentally uncool to go off
> into user mode with interrupts off.

Asynchronous signals could be a problem.  I would have to think about 
that more.


> 
> I really think that once the delay slot emulation machinery has been put
> into motion, that fact needs to become a part of the thread state. 
> Currently, it's encoded, in a sense, in the stack pointer and the stack
> contents.  If we no longer stack it, and use a more static instruction
> buffer as a trampoline, then I think it needs to be tagged as part of
> the kernel's thread state.
> 

Exactly.  I had planned on augmenting the thread state to handle all of 
this.



> That knowledge might be used in various ways.  I still think it would
> work to check that state and cause any signals to that thread need to be
> deferred until it has processed the BREAK instruction to restore the
> pre-emulation instruction flow.  Once the state has been restored from
> the dsemul record, the signal can be dispatched rather than returning
> directly to the branch target.  I don't like putting another check into
> the context restore code, though. 
> 
> A cruftier, but less inefficient-in-the-expected-case approach would be
> a variant on what you suggest above.  Signal dispatch could check the
> EPC, and *if* EPC shows that the delay slot exception hasn't yet
> executed, it could roll back the EPC to re-execute the FP branch after
> the signal.  If the delay slot instruction *has* executed, but not the
> following BREAK, the signal dispatch code could preemptively do the
> dsemulret cleanup and restore the pre-emulation stack and post-emulation
> EPC before doing the signal dispatch.
> 
>           Regards,
> 
>           Kevin K.
> 
