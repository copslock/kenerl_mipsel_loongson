Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Apr 2009 08:50:25 +0100 (BST)
Received: from gateway09.websitewelcome.com ([69.93.154.26]:24811 "HELO
	gateway09.websitewelcome.com") by ftp.linux-mips.org with SMTP
	id S20023485AbZDXHuQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 24 Apr 2009 08:50:16 +0100
Received: (qmail 27506 invoked from network); 24 Apr 2009 07:52:27 -0000
Received: from gator750.hostgator.com (174.132.194.2)
  by gateway09.websitewelcome.com with SMTP; 24 Apr 2009 07:52:27 -0000
Received: from [217.109.65.213] (port=1474 helo=[127.0.0.1])
	by gator750.hostgator.com with esmtpa (Exim 4.69)
	(envelope-from <kevink@paralogos.com>)
	id 1LxGAi-0004iM-Vz; Fri, 24 Apr 2009 02:50:09 -0500
Message-ID: <49F16F38.8060009@paralogos.com>
Date:	Fri, 24 Apr 2009 09:50:16 +0200
From:	"Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
MIME-Version: 1.0
To:	Brian Foster <brian.foster@innova-card.com>
CC:	David Daney <ddaney@caviumnetworks.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH 1/2] MIPS: Preliminary vdso.
References: <49EE3B0F.3040506@caviumnetworks.com> <49EEE4EA.8040100@paralogos.com> <49EF5B88.90004@caviumnetworks.com> <200904240920.03343.brian.foster@innova-card.com>
In-Reply-To: <200904240920.03343.brian.foster@innova-card.com>
Content-Type: multipart/alternative;
 boundary="------------050000060703070306040907"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator750.hostgator.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - paralogos.com
Return-Path: <kevink@paralogos.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22464
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------050000060703070306040907
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Brian Foster wrote:
> On Wednesday 22 April 2009 20:01:44 David Daney wrote:
>   
>> Kevin D. Kissell wrote:
>>     
>>> David Daney wrote:
>>>       
>>>> This is a preliminary patch to add a vdso to all user processes.
>>>> Still missing are ELF headers and .eh_frame information.  But it is
>>>> enough to allow us to move signal trampolines off of the stack.
>>>>
>>>> We allocate a single page (the vdso) and write all possible signal
>>>> trampolines into it.  The stack is moved down by one page and the vdso
>>>> is mapped into this space.
>>>>
>>>> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
>>>>         
>>> Note that for FPU-less CPUs, the kernel FP emulator also uses a user
>>> stack trampoline to execute instructions in the delay slots of emulated
>>> FP branches.  I didn't see any of the math-emu modules being tweaked in
>>> either part of your patch.  Presumably, one would want to move that
>>> operation into the vdso as well.
>>>       
>
> Kevin,
>
>    As David says, this is a Very Ugly Problem.  Each FP trampoline
>   is effectively per-(runtime-)instance per-thread, i.e., there is
>   a unique FP trampoline for every dynamic instance of (non-trivial
>   non-FP) instruction in an FP delay slot.  This is essentially the
>   complete opposite of the signal-return trampoline, which is fixed
>   (constant text) for all instances in all threads.
>
>    As such, David's vdso (assuming it's similar to those on other
>   architectures (I've not looked at it closely yet)) may not have
>   any obvious role to play in moving the FP trampoline('s code?)
>   off the user's stack.
>   
I haven't reviewed David's code in detail, but from his description, I
thought that there was a vdso page per task/thread.  If there's only one
per processor, then, yes, that poses a challenge to porting the FPU
emulation code to use it, since, as you observe, the instruction
sequence to be executed may differ for each delay slot emulation.  It
should still be possible, though.  FP emulation is in itself expensive,
and FP branches with live delay slots are a smallish subset of the
overall FP instructions to be emulated, so a dynamic scheme to
allocate/free slots in a vdso page wouldn't have that dramatic a
performance impact, overall.  As the instructions aren't constant, the
I-caches would need to be flushed after each dsemul setup, even using a
vdso page, but that shouldn't break the fact that one could avoid it for
signals, so long as a different cache line within the vdso page is used
for signal versus dsemul trampolines.

I'm no longer paid to worry about this stuff - I participate in the
mailing list out of habit, as time permits. I don't have any MIPS
hardware handy to work with, even if I wasn't busy with totally
unrelated stuff.  So my talk is cheap.  You guys can do whatever you
want.  I'm just pointing out that, if you want to get rid of executable
user stacks, you either have to re-implement FP branch delay slot
emulation, or eliminate FPU emulation in the kernel.  If your motivation
is really only signal dispatch performance, you can just leave the
dsemul stuff on the user stack.

          Regards,

          Kevin K.

--------------050000060703070306040907
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
<blockquote cite="mid:200904240920.03343.brian.foster@innova-card.com"
 type="cite">
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
Still missing are ELF headers and .eh_frame information.  But it is
enough to allow us to move signal trampolines off of the stack.

We allocate a single page (the vdso) and write all possible signal
trampolines into it.  The stack is moved down by one page and the vdso
is mapped into this space.

Signed-off-by: David Daney <a class="moz-txt-link-rfc2396E" href="mailto:ddaney@caviumnetworks.com">&lt;ddaney@caviumnetworks.com&gt;</a>
        </pre>
      </blockquote>
      <pre wrap="">Note that for FPU-less CPUs, the kernel FP emulator also uses a user
stack trampoline to execute instructions in the delay slots of emulated
FP branches.  I didn't see any of the math-emu modules being tweaked in
either part of your patch.  Presumably, one would want to move that
operation into the vdso as well.
      </pre>
    </blockquote>
  </blockquote>
  <pre wrap=""><!---->
Kevin,

   As David says, this is a Very Ugly Problem.  Each FP trampoline
  is effectively per-(runtime-)instance per-thread, i.e., there is
  a unique FP trampoline for every dynamic instance of (non-trivial
  non-FP) instruction in an FP delay slot.  This is essentially the
  complete opposite of the signal-return trampoline, which is fixed
  (constant text) for all instances in all threads.

   As such, David's vdso (assuming it's similar to those on other
  architectures (I've not looked at it closely yet)) may not have
  any obvious role to play in moving the FP trampoline('s code?)
  off the user's stack.
  </pre>
</blockquote>
I haven't reviewed David's code in detail, but from his description, I
thought that there was a vdso page per task/thread.  If there's only
one per processor, then, yes, that poses a challenge to porting the FPU
emulation code to use it, since, as you observe, the instruction
sequence to be executed may differ for each delay slot emulation.  It
should still be possible, though.  FP emulation is in itself expensive,
and FP branches with live delay slots are a smallish subset of the
overall FP instructions to be emulated, so a dynamic scheme to
allocate/free slots in a vdso page wouldn't have that dramatic a
performance impact, overall.  As the instructions aren't constant, the
I-caches would need to be flushed after each dsemul setup, even using a
vdso page, but that shouldn't break the fact that one could avoid it
for signals, so long as a different cache line within the vdso page is
used for signal versus dsemul trampolines.<br>
<br>
I'm no longer paid to worry about this stuff - I participate in the
mailing list out of habit, as time permits. I don't have any MIPS
hardware handy to work with, even if I wasn't busy with totally
unrelated stuff.  So my talk is cheap.  You guys can do whatever you
want.  I'm just pointing out that, if you want to get rid of executable
user stacks, you either have to re-implement FP branch delay slot
emulation, or eliminate FPU emulation in the kernel.  If your
motivation is really only signal dispatch performance, you can just
leave the dsemul stuff on the user stack.<br>
<br>
          Regards,<br>
<br>
          Kevin K.<br>
</body>
</html>

--------------050000060703070306040907--
