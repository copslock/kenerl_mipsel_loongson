Received:  by oss.sgi.com id <S553685AbQKNVav>;
	Tue, 14 Nov 2000 13:30:51 -0800
Received: from mail.ivm.net ([62.204.1.4]:37158 "EHLO mail.ivm.net")
	by oss.sgi.com with ESMTP id <S553677AbQKNVag>;
	Tue, 14 Nov 2000 13:30:36 -0800
Received: from franz.no.dom (port120.duesseldorf.ivm.de [195.247.65.120])
	by mail.ivm.net (8.8.8/8.8.8) with ESMTP id WAA18232;
	Tue, 14 Nov 2000 22:30:23 +0100
X-To:   linux-mips@oss.sgi.com
Message-ID: <XFMail.001114223017.Harald.Koerfgen@home.ivm.de>
X-Mailer: XFMail 1.4.0 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <20001113104735.A3253@bacchus.dhis.org>
Date:   Tue, 14 Nov 2000 22:30:17 +0100 (CET)
Reply-To: Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
Organization: none
From:   Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
To:     Ralf Baechle <ralf@oss.sgi.com>
Subject: Re: Build failure for R3000 DECstation
Cc:     linux-mips@oss.sgi.com
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


On 13-Nov-00 Ralf Baechle wrote:
> The sysmips(MIPS_ATOMIC_SET, ...) implementation used to be completly broken.
> I fixed it for CPUs with ll/sc and left the part with ll/sc to others.
> 
> Obviously none of them seemed to care so now I'm doing the quick fix.
> Frankly, a syscall which shouldn't be used doesn't deserve more attention ...

Well, it seems as if there are people with a different opinion. Fresh from the
glibc CVS (libc/sysdeps/unix/sysv/linux/mips/sys/tas.h):

# if (_MIPS_ISA >= _MIPS_ISA_MIPS2)

_EXTERN_INLINE int
_test_and_set (int *p, int v) __THROW
{
[ll/sc implementation snipped]
}

# else /* !(_MIPS_ISA >= _MIPS_ISA_MIPS2) */

_EXTERN_INLINE int
_test_and_set (int *p, int v) __THROW
{
  return sysmips (MIPS_ATOMIC_SET, (int) p, v, 0);
}

# endif /* !(_MIPS_ISA >= _MIPS_ISA_MIPS2) */

Personally I like this more than a kernel ll/sc emulation. A syscall is likely
to be faster than at least two illegal instruction exceptions. If you're
concerned about binary compatibilty, the syscall should work on ISA>=2 CPUs as
well.

-- 
Regards,
Harald
