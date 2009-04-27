Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Apr 2009 18:28:03 +0100 (BST)
Received: from gateway05.websitewelcome.com ([67.18.55.14]:39151 "HELO
	gateway05.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with SMTP id S20024311AbZD0R16 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 27 Apr 2009 18:27:58 +0100
Received: (qmail 1599 invoked from network); 27 Apr 2009 17:29:32 -0000
Received: from gator750.hostgator.com (174.132.194.2)
  by gateway05.websitewelcome.com with SMTP; 27 Apr 2009 17:29:32 -0000
Received: from [217.109.65.213] (port=2003 helo=[127.0.0.1])
	by gator750.hostgator.com with esmtpa (Exim 4.69)
	(envelope-from <kevink@paralogos.com>)
	id 1LyUcR-0006K3-D5; Mon, 27 Apr 2009 12:27:51 -0500
Message-ID: <49F5EB1A.5010407@paralogos.com>
Date:	Mon, 27 Apr 2009 19:27:54 +0200
From:	"Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
MIME-Version: 1.0
To:	David Daney <ddaney@caviumnetworks.com>
CC:	Brian Foster <brian.foster@innova-card.com>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 1/2] MIPS: Preliminary vdso.
References: <49EE3B0F.3040506@caviumnetworks.com> <49F16F38.8060009@paralogos.com> <49F1DB1B.2060209@caviumnetworks.com> <200904270919.00761.brian.foster@innova-card.com> <49F5AA6A.7010402@paralogos.com> <49F5D546.2000806@caviumnetworks.com>
In-Reply-To: <49F5D546.2000806@caviumnetworks.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator750.hostgator.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - paralogos.com
Return-Path: <kevink@paralogos.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22495
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

David Daney wrote:
> Kevin D. Kissell wrote:
>
>
>>  But it *could* be a trap or system call instruction, or a load/store
>> that would provoke a TLB exception.  In the usual cases, however, as
>> I believe David was alluding, either the exception will ultimately
>> unwind to return to execute the magic alignment trap, or the thread
>> will exit, and could free the emulation slot as part of general cleanup.
>>
>> But there's a case that isn't handled in this model, and that's the
>> case of an exception (or interrupt that falls in the 2-instruction
>> window) resulting in a signal that is caught and dispatched, and
>> where either the signal handler does a longjmp and restarts FP
>> computation, or where the signal handler itself contains a FP branch
>> with yet another delay slot to be emulated. One *could* get alarm
>> signal before the original delay slot instruction is executed, so
>> recycling the same vdso cache line would be premature.  It's hard to
>> get away from something distinctly stack-like if one wants to cover
>> these cases.
>>
>
> System calls we don't have to handle, they will eventually return to
> the break instruction following the delay slot instruction and be
> handled by the normal processing.
>
> I am thinking that all other exceptions will result in one of three
> cases:
>
> 1) They will work like system calls and return to the 'break'.
>
> 2) The thread will exit.
>
> 3) They result in a signal being sent to the thread.  We can handle it
> in force_signal().  In this case we would adjust the eip to point at
> the  original location of the instruction and clean things up.  If the
> signal handler tries to restart the instruction, the FP emulator will
> re-run the emulation.
That's presumably OK if we *know* that the delay slot instruction has
*not* executed prior to the signal being taken.  But if it has, it may
have had side-effects, i.e. imagine if it's an "ADD.S f4, f4, f6". We
can't re-run the emulation without generating erroneous processor
state.  What do we do if, between the ADD.S and the
BREAK-that-replaces-my-old-alignment-trap, a timer interrupt comes in,
causing a SIGALRM which is caught and which executes another FP branch? 
When I first wrote the delay slot handling code, I dreamed of disabling
interrupts during the delay slot instruction emulation - I think I even
coded it that way at one point - but it's fundamentally uncool to go off
into user mode with interrupts off.

I really think that once the delay slot emulation machinery has been put
into motion, that fact needs to become a part of the thread state. 
Currently, it's encoded, in a sense, in the stack pointer and the stack
contents.  If we no longer stack it, and use a more static instruction
buffer as a trampoline, then I think it needs to be tagged as part of
the kernel's thread state.

That knowledge might be used in various ways.  I still think it would
work to check that state and cause any signals to that thread need to be
deferred until it has processed the BREAK instruction to restore the
pre-emulation instruction flow.  Once the state has been restored from
the dsemul record, the signal can be dispatched rather than returning
directly to the branch target.  I don't like putting another check into
the context restore code, though. 

A cruftier, but less inefficient-in-the-expected-case approach would be
a variant on what you suggest above.  Signal dispatch could check the
EPC, and *if* EPC shows that the delay slot exception hasn't yet
executed, it could roll back the EPC to re-execute the FP branch after
the signal.  If the delay slot instruction *has* executed, but not the
following BREAK, the signal dispatch code could preemptively do the
dsemulret cleanup and restore the pre-emulation stack and post-emulation
EPC before doing the signal dispatch.

          Regards,

          Kevin K.
