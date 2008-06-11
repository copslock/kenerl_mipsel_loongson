Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jun 2008 19:50:44 +0100 (BST)
Received: from mx.mips.com ([63.167.95.198]:33515 "EHLO dns0.mips.com")
	by ftp.linux-mips.org with ESMTP id S20039320AbYFKSul (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 11 Jun 2008 19:50:41 +0100
Received: from mercury.mips.com (mercury [192.168.64.101])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id m5BIn2f0015804;
	Wed, 11 Jun 2008 11:49:02 -0700 (PDT)
Received: from [127.0.0.1] (grendel [192.168.236.16])
	by mercury.mips.com (8.13.5/8.13.5) with ESMTP id m5BInbJW014977;
	Wed, 11 Jun 2008 11:49:53 -0700 (PDT)
Message-ID: <48501E9E.1040202@mips.com>
Date:	Wed, 11 Jun 2008 20:51:10 +0200
From:	"Kevin D. Kissell" <kevink@mips.com>
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
MIME-Version: 1.0
To:	Brian Foster <brian.foster@innova-card.com>
CC:	David Daney <ddaney@avtrex.com>, linux-mips@linux-mips.org,
	Thiemo Seufer <ths@networkno.de>,
	"Kevin D. Kissell" <KevinK@paralogos.com>,
	Andrew Dyer <adyer@righthandtech.com>
Subject: Re: Adding(?) XI support to MIPS-Linux?
References: <200806091658.10937.brian.foster@innova-card.com> <20080610095702.GG11233@networkno.de> <484EAA16.80903@avtrex.com> <200806111516.57406.brian.foster@innova-card.com>
In-Reply-To: <200806111516.57406.brian.foster@innova-card.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19486
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

Brian Foster wrote:
>  It's case 2 (above), the trampoline that has “something
>  to do with FPU emulation”, which has me concerned ATM.
>  The 4KSd core does not have an FPU.  That encourages the
>  use of ‘-msoft-float’ (at least for performance), but does
>  not require it.  (Albeit I wonder if, in the restricted
>  world I'm playing in, if it could be “required” (assuming
>  it doesn't have an issue?)?  Hum .... .)
>   
The use of -msoft-float historically required (and as far as I know 
still requires)
a completely different ground-up userland build, so it gets used less 
than you
might think.
>  The quick summary (which I'm sure others on this list can
>  clarify/correct) is the FP trampoline, which is pushed on
>  the user-land stack is, unlike sigreturn, not fixed code.
>  It varies on a per-instance per-thread basis.  Hence the
>  simple ‘vsyscall’ mechanism ((to be?) used for sigreturn)
>  is inappropriate.
>
>  The trampoline is only used to execute a non-FP instruction
>  (<instr>) in the delay slot of an FP-instruction:
>
>      <instr>  # Non-FP instruction to execute in user-land
>      BADINST  # Bad instruction forcing return to FP emulator
>      COOKIE   # Bad instruction (not executed) for verification
>      <epc>    # Where to resume execution after <instr>
>
>  Belch! ;-\  Whilst I can think of a few things that may work
>  (temporarily change page permissions;  or go ahead and use
>  the ‘vsyscall’ page with some interlocking magic;  or a new
>  new dedicated per-thread page;  or ...?) none seem appealing.
>
>  Suggestions?  Comments?  Prior art to study?
>   
As the jerk who originally bolted the FP emulator into the MIPS kernel
and came up with the stack trampoline hack, I can explain why it seemed
sane at the time.  If an FP branch is emulated and to be taken, we have to
find a way for the instruction in the delay slot to be executed prior to the
transfer of control to the branch target.  It has to execute with the user's
permissions.  Putting it on the user's stack and building a trampoline was
the fairly classical way of doing it, but note that it's architecturally 
illegal
to put a branch in a branch delay slot (floating point or otherwise), so
there's no possibility of recursion. So one only needs 3-4 words (one
could substitute another means of validation for the cookie) per
thread.  It just has to be part of the user's address space.  I suppose
that instead of using a few words just above the stack, one could use
a few words just below the current "brk()" point, or, better still (but
far more invasive) pad the text segment, which should always be
executable, with 4 words that the kernel can find in a hurry.

          Regards,

          Kevin K.
