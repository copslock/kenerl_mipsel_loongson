Received:  by oss.sgi.com id <S553787AbQKNXlv>;
	Tue, 14 Nov 2000 15:41:51 -0800
Received: from u-210.karlsruhe.ipdial.viaginterkom.de ([62.180.18.210]:8452
        "EHLO u-210.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553767AbQKNXlk>; Tue, 14 Nov 2000 15:41:40 -0800
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S870080AbQKNXlW>;
        Wed, 15 Nov 2000 00:41:22 +0100
Date:   Wed, 15 Nov 2000 00:41:22 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
Cc:     linux-mips@oss.sgi.com
Subject: Re: Build failure for R3000 DECstation
Message-ID: <20001115004122.G927@bacchus.dhis.org>
References: <20001113104735.A3253@bacchus.dhis.org> <XFMail.001114223017.Harald.Koerfgen@home.ivm.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <XFMail.001114223017.Harald.Koerfgen@home.ivm.de>; from Harald.Koerfgen@home.ivm.de on Tue, Nov 14, 2000 at 10:30:17PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Nov 14, 2000 at 10:30:17PM +0100, Harald Koerfgen wrote:

> > Obviously none of them seemed to care so now I'm doing the quick fix.
> > Frankly, a syscall which shouldn't be used doesn't deserve more attention ...
> 
> Well, it seems as if there are people with a different opinion. Fresh from the
> glibc CVS (libc/sysdeps/unix/sysv/linux/mips/sys/tas.h):

I know.  Otherwise I'd have plain killed this syscall rsn.

> Personally I like this more than a kernel ll/sc emulation. A syscall is likely
> to be faster than at least two illegal instruction exceptions. If you're
> concerned about binary compatibilty, the syscall should work on ISA>=2 CPUs as
> well.

The idea is to punish the least widespread architecture and this are the
non-ll/sc CPUs.  Just like Linux is no longer performing optimally on x86.

In any case, for uniprocessor non-ll/sc machines there is also a better
solution availble with no syscalls at all.  It's easy to implement, just
use the fact that any exception will change the values of k0/k1.  That of
course breaks silently on SMP.

glibc 2.2 calls this sysmips(). very often so optimizing them is fairly
important ...

  Ralf
