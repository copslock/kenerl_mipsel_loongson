Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Apr 2009 13:52:03 +0100 (BST)
Received: from gateway08.websitewelcome.com ([69.93.106.23]:35188 "HELO
	gateway08.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with SMTP id S20023018AbZD0Mv6 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 27 Apr 2009 13:51:58 +0100
Received: (qmail 22064 invoked from network); 27 Apr 2009 12:54:40 -0000
Received: from gator750.hostgator.com (174.132.194.2)
  by gateway08.websitewelcome.com with SMTP; 27 Apr 2009 12:54:40 -0000
Received: from [217.109.65.213] (port=1864 helo=[127.0.0.1])
	by gator750.hostgator.com with esmtpa (Exim 4.69)
	(envelope-from <kevink@paralogos.com>)
	id 1LyQJM-0002qf-No; Mon, 27 Apr 2009 07:51:53 -0500
Message-ID: <49F5AA6A.7010402@paralogos.com>
Date:	Mon, 27 Apr 2009 14:51:54 +0200
From:	"Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
MIME-Version: 1.0
To:	Brian Foster <brian.foster@innova-card.com>
CC:	David Daney <ddaney@caviumnetworks.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH 1/2] MIPS: Preliminary vdso.
References: <49EE3B0F.3040506@caviumnetworks.com> <49F16F38.8060009@paralogos.com> <49F1DB1B.2060209@caviumnetworks.com> <200904270919.00761.brian.foster@innova-card.com>
In-Reply-To: <200904270919.00761.brian.foster@innova-card.com>
Content-Type: multipart/alternative;
 boundary="------------000705080409090902090504"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator750.hostgator.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - paralogos.com
Return-Path: <kevink@paralogos.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22486
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------000705080409090902090504
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Brian Foster wrote:
> On Friday 24 April 2009 17:30:35 David Daney wrote:
>   
>> Kevin D. Kissell wrote:
>>     
>>> Brian Foster wrote:
>>>       
>>>> On Wednesday 22 April 2009 20:01:44 David Daney wrote:
>>>>         
>>>>> Kevin D. Kissell wrote:
>>>>>           
>>>>>> David Daney wrote:
>>>>>>             
>>>>>>> This is a preliminary patch to add a vdso to all user processes.
>>>>>>> [ ... ]
>>>>>>>               
>>>>>> Note that for FPU-less CPUs, the kernel FP emulator also uses a user
>>>>>> stack trampoline to execute instructions in the delay slots of emulated
>>>>>> FP branches.  [ ... ]
>>>>>>             
>>>>    As David says, this is a Very Ugly Problem.  Each FP trampoline
>>>>   is effectively per-(runtime-)instance per-thread [ ... ]
>>>>         
>>> I haven't reviewed David's code in detail, but from his description, I 
>>> thought that there was a vdso page per task/thread.  If there's only one 
>>> per processor, then, yes, that poses a challenge to porting the FPU 
>>> emulation code to use it, since, as you observe, the instruction 
>>> sequence to be executed may differ for each delay slot emulation.  It 
>>> should still be possible, though.  [ ... ]
>>>       
>> Kevin is right, this is ugly.
>>
>> My current plan is to map an anonymous page with execute permission for 
>> each vma (process) and place all FP trampolines there.  Each thread that 
>> needs a trampoline will allocate a piece of this page and write the 
>> trampoline.  We can arrange it so that the only way a thread can exit 
>> the trampoline is by taking some sort of fault (currently this is true 
>> for the normal case), or exiting.
>>     
>
> David,
>
>    The above is the bit which has always stumped me.
>   Having a per-process(or similar) page for the FP
>   trampoline(s) is the “obvious” approach, but what
>   has had me going around in circles is how to know
>   when an allocated slot/trampoline can be freed.
>   As you imply, in the normal case, it seems trivial.
>   It's the not-normal cases which aren't clear (or at
>   least aren't clear to me!).
>
>    You say (EMPHASIS added) “We can arrange it so
>   that the ONLY way a thread can exit the trampoline
>   is by taking some sort of fault ... or exiting”,
>   which if true, could solve the issue.  Could you
>   elucidate on this point, please?
>
>   
Well, he's *almost* right about that. The delay slot emulation function
executes a single instruction off the user stack/vdso slot, which is
followed in memory by an instruction that provokes an address
exception.  The address exception handler detects the special case (and
it should be noted that detecting the special case could be made simpler
and more reliable if a vdso-type region were used), cleans up, and
restores normal stack behavior.  That "clean up" could, of course,
include any necessary vdso slot management.  But what about cases that
won't get to the magic alignment trap?

As the instruction being executed is extracted from a branch delay slot,
we know it's not legal for it to be any sort of branch or jump
instruction.  But it *could* be a trap or system call instruction, or a
load/store that would provoke a TLB exception.  In the usual cases,
however, as I believe David was alluding, either the exception will
ultimately unwind to return to execute the magic alignment trap, or the
thread will exit, and could free the emulation slot as part of general
cleanup.

But there's a case that isn't handled in this model, and that's the case
of an exception (or interrupt that falls in the 2-instruction window)
resulting in a signal that is caught and dispatched, and where either
the signal handler does a longjmp and restarts FP computation, or where
the signal handler itself contains a FP branch with yet another delay
slot to be emulated. One *could* get alarm signal before the original
delay slot instruction is executed, so recycling the same vdso cache
line would be premature.  It's hard to get away from something
distinctly stack-like if one wants to cover these cases.

My short-term suggestion would be to leave FP emulator delay slot
handling on the (executable) user stack, even if signal trampolines use
the vdso.  Longer term, we might consider what sorts of crockery would
be necessary to deal with delay slot abandonment and recursion.  That
might mean adding cruft to the signal dispatch logic to detect that
we're in mid-delay-slot-emulation and defer the signal until after the
alignment trap cleanup is done (adds annoying run-time overhead, but is
probably the smallest increase in footprint and complexity), or it might
mean changing the delay slot emulation paradigm completely and bolting a
full instruction set emulator into the FP emulator, so that the delay
slot instruction is simulated in kernel mode, rather than requiring
execution in user mode.  I rejected that idea out-of-hand when I first
did the FP emulator integration with the kernel, years ago, but maybe
the constraints have changed...

          Regards,

          Kevin K.

--------------000705080409090902090504
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=UTF-8" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Brian Foster wrote:
<blockquote cite="mid:200904270919.00761.brian.foster@innova-card.com"
 type="cite">
  <pre wrap="">On Friday 24 April 2009 17:30:35 David Daney wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Kevin D. Kissell wrote:
    </pre>
    <blockquote type="cite">
      <pre wrap="">Brian Foster wrote:
      </pre>
      <blockquote type="cite">
        <pre wrap="">On Wednesday 22 April 2009 20:01:44 David Daney wrote:
        </pre>
        <blockquote type="cite">
          <pre wrap="">Kevin D. Kissell wrote:
          </pre>
          <blockquote type="cite">
            <pre wrap="">David Daney wrote:
            </pre>
            <blockquote type="cite">
              <pre wrap="">This is a preliminary patch to add a vdso to all user processes.
[ ... ]
              </pre>
            </blockquote>
            <pre wrap="">Note that for FPU-less CPUs, the kernel FP emulator also uses a user
stack trampoline to execute instructions in the delay slots of emulated
FP branches.  [ ... ]
            </pre>
          </blockquote>
        </blockquote>
        <pre wrap="">   As David says, this is a Very Ugly Problem.  Each FP trampoline
  is effectively per-(runtime-)instance per-thread [ ... ]
        </pre>
      </blockquote>
      <pre wrap="">I haven't reviewed David's code in detail, but from his description, I 
thought that there was a vdso page per task/thread.  If there's only one 
per processor, then, yes, that poses a challenge to porting the FPU 
emulation code to use it, since, as you observe, the instruction 
sequence to be executed may differ for each delay slot emulation.  It 
should still be possible, though.  [ ... ]
      </pre>
    </blockquote>
    <pre wrap="">Kevin is right, this is ugly.

My current plan is to map an anonymous page with execute permission for 
each vma (process) and place all FP trampolines there.  Each thread that 
needs a trampoline will allocate a piece of this page and write the 
trampoline.  We can arrange it so that the only way a thread can exit 
the trampoline is by taking some sort of fault (currently this is true 
for the normal case), or exiting.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
David,

   The above is the bit which has always stumped me.
  Having a per-process(or similar) page for the FP
  trampoline(s) is the “obvious” approach, but what
  has had me going around in circles is how to know
  when an allocated slot/trampoline can be freed.
  As you imply, in the normal case, it seems trivial.
  It's the not-normal cases which aren't clear (or at
  least aren't clear to me!).

   You say (EMPHASIS added) “We can arrange it so
  that the ONLY way a thread can exit the trampoline
  is by taking some sort of fault ... or exiting”,
  which if true, could solve the issue.  Could you
  elucidate on this point, please?

  </pre>
</blockquote>
Well, he's *almost* right about that. The delay slot emulation function
executes a single instruction off the user stack/vdso slot, which is
followed in memory by an instruction that provokes an address
exception.  The address exception handler detects the special case (and
it should be noted that detecting the special case could be made
simpler and more reliable if a vdso-type region were used), cleans up,
and restores normal stack behavior.  That "clean up" could, of course,
include any necessary vdso slot management.  But what about cases that
won't get to the magic alignment trap?<br>
<br>
As the instruction being executed is extracted from a branch delay
slot, we know it's not legal for it to be any sort of branch or jump
instruction.  But it *could* be a trap or system call instruction, or a
load/store that would provoke a TLB exception.  In the usual cases,
however, as I believe David was alluding, either the exception will
ultimately unwind to return to execute the magic alignment trap, or the
thread will exit, and could free the emulation slot as part of general
cleanup.<br>
<br>
But there's a case that isn't handled in this model, and that's the
case of an exception (or interrupt that falls in the 2-instruction
window) resulting in a signal that is caught and dispatched, and where
either the signal handler does a longjmp and restarts FP computation,
or where the signal handler itself contains a FP branch with yet
another delay slot to be emulated. One *could* get alarm signal before
the original delay slot instruction is executed, so recycling the same
vdso cache line would be premature.  It's hard to get away from
something distinctly stack-like if one wants to cover these cases.<br>
<br>
My short-term suggestion would be to leave FP emulator delay slot
handling on the (executable) user stack, even if signal trampolines use
the vdso.  Longer term, we might consider what sorts of crockery would
be necessary to deal with delay slot abandonment and recursion.  That
might mean adding cruft to the signal dispatch logic to detect that
we're in mid-delay-slot-emulation and defer the signal until after the
alignment trap cleanup is done (adds annoying run-time overhead, but is
probably the smallest increase in footprint and complexity), or it
might mean changing the delay slot emulation paradigm completely and
bolting a full instruction set emulator into the FP emulator, so that
the delay slot instruction is simulated in kernel mode, rather than
requiring execution in user mode.  I rejected that idea out-of-hand
when I first did the FP emulator integration with the kernel, years
ago, but maybe the constraints have changed...<br>
<br>
          Regards,<br>
<br>
          Kevin K.<br>
</body>
</html>

--------------000705080409090902090504--
