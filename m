Received:  by oss.sgi.com id <S305184AbQB1Mnf>;
	Mon, 28 Feb 2000 04:43:35 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:40300 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305182AbQB1MnR>; Mon, 28 Feb 2000 04:43:17 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id EAA02877; Mon, 28 Feb 2000 04:46:23 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id EAA39674
	for linux-list;
	Mon, 28 Feb 2000 04:21:04 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id EAA65595
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 28 Feb 2000 04:20:55 -0800 (PST)
	mail_from (kevink@mips.com)
Received: from mx.mips.com (mx.mips.com [206.31.31.226]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id EAA02775
	for <linux@cthulhu.engr.sgi.com>; Mon, 28 Feb 2000 04:21:00 -0800 (PST)
	mail_from (kevink@mips.com)
Received: from newman.mips.com (newman [206.31.31.8])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id EAA08242;
	Mon, 28 Feb 2000 04:20:48 -0800 (PST)
Received: from satanas (satanas [192.168.236.12])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id EAA25223;
	Mon, 28 Feb 2000 04:20:44 -0800 (PST)
Message-ID: <010101bf81e6$9c546120$0ceca8c0@satanas.mips.com>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "Linux/MIPS fnet" <linux-mips@fnet.fr>,
        "Linux/MIPS algor" <linux-porters@algor.co.uk>,
        "Linux SGI" <linux@cthulhu.engr.sgi.com>
Subject: Kernel/User Memory Access and Original Sin
Date:   Mon, 28 Feb 2000 13:23:17 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 4.72.3110.5
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.3110.3
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

My apologies to those of you who will get three copies of this, 
but I wanted to reach, to the extent possible, the full MIPS/Linux 
community.

I began running the "crashme" test program, available at
http://people.delphi.com/gjc/crashme.html, on a MIPS/Linux
configuration, a week or so ago.  It has been a useful exercise,
but one that opens up a real pandora's box.  Note that I've been
running it on our 2.2.12 kernel for embedded MIPS chips,
and not on 2.3.x for SGI platforms, but my findings are relevant
to both environments.

In addition to turning up a couple of bugs in the FPU emulator
interface to the kernel - the sort of thing I was looking for - crashme
turned up a problem with kernel access to the user memory map
that looks to me to be very serious.  I have implemented a fix,
but it casts doubt on the wisdom of the general Linux scheme
for handling kernel access to user memory - hence the "original
sin" reference above.

Linux, as written for the x86, goes very heavily for inlining.
Rather than call specially protected copyin/copyout sorts
of routines for manipulating user memory, Linux uses inline
macros (copy_from_user/copy_to_user, etc.) that depend on
doing explicit checks of the address space for correctness.
This is tenable if and only if the explicit check is both
cheap and reliable.   On the x86, this check, __range_ok,
is accomplished with a quick check of segment registers,
and may or may not actually be reliable, depending on
the x86 VM implementation.   In the MIPS 2.2 and 2.3
kernels, the check, __access_ok, is a simple heuristic
that verifies that the access does not reference kernel
memory, nor is it greater than 2GB in size.  That's cheap,
but not reliable.  The primary failure mode I observed was 
where signal.c blows up when trying to set up a signal context 
on a corrupted user stack, but the problem is more pervasive.

I have succeeded in writing what seems to be a "real"
__access_ok routine, but it is much more heavyweight
than the old heuristic.  Not only does it need to check the
virtual address against the process' VMAs, but it needs
to deal with accesses that span multiple, contiguous
VMAs (such as those the xmalloc returns to /bin/cat!),
and it needs to deal with accesses to addresses
to which a stack VMA will be grown.   In my opinion,
the result is too big to put in ubiquitous in-line macros,
so it became a function (in mm/fault.c for want of a better
home), and the macros now call the function.   The system
handles the previously fatal test cases, and now I need to 
make some measurements of the effects on performance.
I'll post patches/sources to the web shortly, but for the
moment, I'm curious as to the opinions of other kernel
hackers in the MIPS/Linux community.

Is it acceptable to allow corrupted processes to cause
system panics?  Is speed more important than stability 
to you and your users?  At MIPS, we need the OS to be 
as stable as possible, so that we can stress new chips on it
with some confidence that the chips will break before
the OS does, and we would happily pay a significant
penalty in performance for that confidence.   Those who
re-use our code for embedded Linux applications, on
the other hand, need stability *and* performance.

I have formed the opinion that the "correct" way to deal 
with kernel/user memory accesses in Linux, at least for 
MIPS, is to take a model much closer to System V and BSD 
than to the Linux/x86 tradition. Instead of performing range 
checks at each reference, protected routines (copyin/copyout, 
et al.) need to be set up to perform the necessary accesses in 
kernel mode, but with the appropriate VM hooks so that any 
page faults are handled as if for the user.  This way, the overhead 
of checking VMAs, etc, is only incurred if something out of the 
ordinary happens, and not on every access.  Is there a good 
reason *not* to do things this way?
__

Kevin D. Kissell
MIPS Technologies European Architecture Lab
kevink@mips.com
Tel. +33.4.78.38.70.67
FAX. +33.4.78.38.70.68
