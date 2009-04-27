Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Apr 2009 16:55:27 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:13379 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20023798AbZD0PzV (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 27 Apr 2009 16:55:21 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B49f5d54a0000>; Mon, 27 Apr 2009 11:54:50 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 27 Apr 2009 08:54:47 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 27 Apr 2009 08:54:46 -0700
Message-ID: <49F5D546.2000806@caviumnetworks.com>
Date:	Mon, 27 Apr 2009 08:54:46 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	"Kevin D. Kissell" <kevink@paralogos.com>
CC:	Brian Foster <brian.foster@innova-card.com>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 1/2] MIPS: Preliminary vdso.
References: <49EE3B0F.3040506@caviumnetworks.com> <49F16F38.8060009@paralogos.com> <49F1DB1B.2060209@caviumnetworks.com> <200904270919.00761.brian.foster@innova-card.com> <49F5AA6A.7010402@paralogos.com>
In-Reply-To: <49F5AA6A.7010402@paralogos.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Apr 2009 15:54:46.0772 (UTC) FILETIME=[7D25F340:01C9C750]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22494
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Kevin D. Kissell wrote:

> Well, he's *almost* right about that. The delay slot emulation function 
> executes a single instruction off the user stack/vdso slot, which is 
> followed in memory by an instruction that provokes an address 
> exception.  The address exception handler detects the special case (and 
> it should be noted that detecting the special case could be made simpler 
> and more reliable if a vdso-type region were used),

Ralf recently changed this to a 'break' instruction, but the logic 
remains the same.

> cleans up, and 
> restores normal stack behavior.  That "clean up" could, of course, 
> include any necessary vdso slot management.  But what about cases that 
> won't get to the magic alignment trap?
> 
> As the instruction being executed is extracted from a branch delay slot, 
> we know it's not legal for it to be any sort of branch or jump 
> instruction.

These we would detect and since the behavior is 'UNPREDICTABLE' we can 
treat them as a nop and remain within the specified behavior.

>  But it *could* be a trap or system call instruction, or a 
> load/store that would provoke a TLB exception.  In the usual cases, 
> however, as I believe David was alluding, either the exception will 
> ultimately unwind to return to execute the magic alignment trap, or the 
> thread will exit, and could free the emulation slot as part of general 
> cleanup.
> 
> But there's a case that isn't handled in this model, and that's the case 
> of an exception (or interrupt that falls in the 2-instruction window) 
> resulting in a signal that is caught and dispatched, and where either 
> the signal handler does a longjmp and restarts FP computation, or where 
> the signal handler itself contains a FP branch with yet another delay 
> slot to be emulated. One *could* get alarm signal before the original 
> delay slot instruction is executed, so recycling the same vdso cache 
> line would be premature.  It's hard to get away from something 
> distinctly stack-like if one wants to cover these cases.
> 

System calls we don't have to handle, they will eventually return to the 
break instruction following the delay slot instruction and be handled by 
the normal processing.

I am thinking that all other exceptions will result in one of three cases:

1) They will work like system calls and return to the 'break'.

2) The thread will exit.

3) They result in a signal being sent to the thread.  We can handle it 
in force_signal().  In this case we would adjust the eip to point at the 
  original location of the instruction and clean things up.  If the 
signal handler tries to restart the instruction, the FP emulator will 
re-run the emulation.


> My short-term suggestion would be to leave FP emulator delay slot 
> handling on the (executable) user stack, even if signal trampolines use 
> the vdso.

They are really two seperate (but related) problems.  If we want 
eXecute-Inhibit for the stack we need to solve it.

> Longer term, we might consider what sorts of crockery would 
> be necessary to deal with delay slot abandonment and recursion.  That 
> might mean adding cruft to the signal dispatch logic to detect that 
> we're in mid-delay-slot-emulation and defer the signal until after the 
> alignment trap cleanup is done (adds annoying run-time overhead, but is 
> probably the smallest increase in footprint and complexity), or it might 
> mean changing the delay slot emulation paradigm completely and bolting a 
> full instruction set emulator into the FP emulator, so that the delay 
> slot instruction is simulated in kernel mode, rather than requiring 
> execution in user mode.  I rejected that idea out-of-hand when I first 
> did the FP emulator integration with the kernel, years ago, but maybe 
> the constraints have changed...
> 

I think full instruction set emulation is not so easy.  How would you 
emulate COP2 instructions?

David Daney
