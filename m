Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Dec 2002 12:59:03 +0100 (CET)
Received: from p508B7FA8.dip.t-dialin.net ([80.139.127.168]:38045 "EHLO
	p508B7FA8.dip.t-dialin.net") by linux-mips.org with ESMTP
	id <S8225207AbSLJL6o>; Tue, 10 Dec 2002 12:58:44 +0100
Received: from mx2.mips.com ([IPv6:::ffff:206.31.31.227]:33528 "EHLO
	mx2.mips.com") by ralf.linux-mips.org with ESMTP id <S868808AbSLJHvP>;
	Tue, 10 Dec 2002 08:51:15 +0100
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id gBA7otNf022766;
	Mon, 9 Dec 2002 23:50:55 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id XAA24864;
	Mon, 9 Dec 2002 23:50:56 -0800 (PST)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id gBA7otb07168;
	Tue, 10 Dec 2002 08:50:56 +0100 (MET)
Message-ID: <3DF59CDF.DC160221@mips.com>
Date: Tue, 10 Dec 2002 08:50:55 +0100
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>
CC: Dominic Sweetman <dom@algor.co.uk>,
	Dominic Sweetman <dom@mips.com>, chris@mips.com,
	kevink@mips.com, linux-mips@linux-mips.org
Subject: Re: The 64-bit version of __access_ok is broken.
References: <3DEF7087.B6DEA7EC@mips.com> <20021209051845.A31939@linux-mips.org> <3DF4629B.F377F711@mips.com> <15860.33900.117478.251574@gladsmuir.algor.co.uk> <20021209193808.B27999@linux-mips.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-Path: <carstenl@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 832
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: carstenl@mips.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:

> On Mon, Dec 09, 2002 at 11:54:20AM +0000, Dominic Sweetman wrote:
>
> > I'd like to be clear about the consequences of this.  Presumably the
> > 'access_ok()' macro is used to check addresses which were (originally)
> > provided by a user program's system call.
> >
> > Carsten, are you saying that if such an address is set to say 2**41 in
> > a CPU supporting 40-bit user virtual addresses, that the kernel will
> > crash?
>
> That's correct.  The problem which Carsten diagnosed correctly was the
> assumption which has been inherited from the 32-bit kernel that the sign-
> bit makes the difference between valid userspace and kernelspace
> addresses.
>
> Linux doesn't use the supervisor mode so basically that assumption is still
> true with the except of the area 2^PHYSBITS ... 2^63-1.
>
> > If so, that seems to require a fix, even if we don't know a very
> > efficient one.  But perhaps any problem is a bit more subtle than
> > that?
>
> Access_ok is a macro which depending on kernel configuration is expanded
> hundreds, if not thousands of times throughout the kernel.  So every single
> machine instruction in access_ok will make a size difference of several
> kB.  Carsten's patch was performing pretty badly in that cathegory.  If
> access_ok wasn't used that often the issue certainly wasn't worth the fuzz.
>
> Access_ok is of course only usable in C code.  We also have a few piece of
> assembler code that access userspace and need to perform the same kind of
> address validation tests.  Carsten's patch was missing these completly.  As
> such it did only reduce the window of this bug from huge to "just" big.
>

At least I haven't hit those holes, the would have been fixed otherwise, too
;-)


>
> An efficient solution only requires fairly minor changes as you can see in
> the patch I just posted.  It doesn't even require thinking, it can be
> obtained by cut'n'paste from the Alpha code.  Alternatively the problem
> could also have been solved by forwarding address errors for the address
> range in question to the page fault handler which would have served the
> same purpose, maybe even a tad more efficient but ofuscated ...
>

I absolutely agree that we should go for an optimized solution, but we discuss
this issue 1/2 year ago, none of us, had the time to come up with a better fix
than the one I send. I'm going through my to-do list and came across this
issue again, and I just wanted to reopen the case again.
This time it annoyed you enough, so you came up with a better solution and
I achieved what I came for, so that's great ;-)
Thanks a lot. I will try you patch right away.


>
>   Ralf

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
