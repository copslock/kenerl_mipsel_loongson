Received:  by oss.sgi.com id <S553926AbQJaWCD>;
	Tue, 31 Oct 2000 14:02:03 -0800
Received: from gateway-490.mvista.com ([63.192.220.206]:14332 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S553923AbQJaWBn>;
	Tue, 31 Oct 2000 14:01:43 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id e9VLxt326114;
	Tue, 31 Oct 2000 13:59:55 -0800
Message-ID: <39FF414D.6B0A553C@mvista.com>
Date:   Tue, 31 Oct 2000 14:01:49 -0800
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To:     Ralf Baechle <ralf@oss.sgi.com>
CC:     Florian Lohoff <flo@rfc822.org>, linux-mips@oss.sgi.com
Subject: Re: userspace spinlocks
References: <20001030151736.C2687@paradigm.rfc822.org> <39FDB50A.4919D84E@mvista.com> <20001031211431.C28909@bacchus.dhis.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Ralf Baechle wrote:
> 
> On Mon, Oct 30, 2000 at 09:51:06AM -0800, Jun Sun wrote:
> 
> > > Could
> > > there be a runtime linking thing with a cpu detection wether we
> > > have ll/sc or not ?
> >
> > This is a wonderful idea.  It should incorporate into future MIPS CPU
> > support structure.
> 
> But what is the better alternative?  Emulating ll/sc is a generic facility.
> Aside of making that more efficient the only idea I have is putting entire
> atomic operations into the kernel such that the standard case should result
> in at most one exception to be handled in the kernel.
> 

When I was playing with NEC Vr4111 (a MIPS III cpu but without ll/sc), I
notice the following comment in
glibc/linuxthreads/sysdeps/mips/pt-machine.h file (Is that Ralf's
comment?) :

"
   TODO: This version makes use of MIPS ISA 2 features.  It won't
   work on ISA 1.  These machines will have to take the overhead of
   a sysmips(MIPS_ATOMIC_SET, ...) syscall which isn't implemented
   yet correctly.  There is however a better solution for R3000
   uniprocessor machines possible.  */
"

I remembered I found a patch which actually uses mips syscalls.  For
some reasons, it did not work in the end.

BTW, I didn't know the kernel already has ll/sc emulation.  That seems
to be necessary, even just for the binary compability sake.

Jun
