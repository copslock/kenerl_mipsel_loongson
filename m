Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Dec 2002 09:39:22 +0000 (GMT)
Received: from p508B6F96.dip.t-dialin.net ([IPv6:::ffff:80.139.111.150]:58756
	"EHLO p508B6F96.dip.t-dialin.net") by linux-mips.org with ESMTP
	id <S8225215AbSLPJjU>; Mon, 16 Dec 2002 09:39:20 +0000
Received: from onda.linux-mips.net ([IPv6:::ffff:192.168.169.2]:4480 "EHLO
	dea.linux-mips.net") by ralf.linux-mips.org with ESMTP
	id <S868646AbSLOVGI>; Sun, 15 Dec 2002 22:06:08 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id gB9Ic8R01628;
	Mon, 9 Dec 2002 19:38:08 +0100
Date: Mon, 9 Dec 2002 19:38:08 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Dominic Sweetman <dom@algor.co.uk>
Cc: Carsten Langgaard <carstenl@mips.com>,
	Dominic Sweetman <dom@mips.com>, chris@mips.com,
	kevink@mips.com, linux-mips@linux-mips.org
Subject: Re: The 64-bit version of __access_ok is broken.
Message-ID: <20021209193808.B27999@linux-mips.org>
References: <3DEF7087.B6DEA7EC@mips.com> <20021209051845.A31939@linux-mips.org> <3DF4629B.F377F711@mips.com> <15860.33900.117478.251574@gladsmuir.algor.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <15860.33900.117478.251574@gladsmuir.algor.co.uk>; from dom@algor.co.uk on Mon, Dec 09, 2002 at 11:54:20AM +0000
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 894
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Dec 09, 2002 at 11:54:20AM +0000, Dominic Sweetman wrote:

> I'd like to be clear about the consequences of this.  Presumably the
> 'access_ok()' macro is used to check addresses which were (originally)
> provided by a user program's system call.
> 
> Carsten, are you saying that if such an address is set to say 2**41 in
> a CPU supporting 40-bit user virtual addresses, that the kernel will
> crash?

That's correct.  The problem which Carsten diagnosed correctly was the
assumption which has been inherited from the 32-bit kernel that the sign-
bit makes the difference between valid userspace and kernelspace
addresses.

Linux doesn't use the supervisor mode so basically that assumption is still
true with the except of the area 2^PHYSBITS ... 2^63-1.

> If so, that seems to require a fix, even if we don't know a very
> efficient one.  But perhaps any problem is a bit more subtle than
> that?

Access_ok is a macro which depending on kernel configuration is expanded
hundreds, if not thousands of times throughout the kernel.  So every single
machine instruction in access_ok will make a size difference of several
kB.  Carsten's patch was performing pretty badly in that cathegory.  If
access_ok wasn't used that often the issue certainly wasn't worth the fuzz.

Access_ok is of course only usable in C code.  We also have a few piece of
assembler code that access userspace and need to perform the same kind of
address validation tests.  Carsten's patch was missing these completly.  As
such it did only reduce the window of this bug from huge to "just" big.

An efficient solution only requires fairly minor changes as you can see in
the patch I just posted.  It doesn't even require thinking, it can be
obtained by cut'n'paste from the Alpha code.  Alternatively the problem
could also have been solved by forwarding address errors for the address
range in question to the page fault handler which would have served the
same purpose, maybe even a tad more efficient but ofuscated ...

  Ralf
