Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Apr 2009 09:33:53 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:46890 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S20024624AbZD2Idu (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 29 Apr 2009 09:33:50 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n3T8Xn2W032381;
	Wed, 29 Apr 2009 10:33:49 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n3T8XnIg032379;
	Wed, 29 Apr 2009 10:33:49 +0200
Date:	Wed, 29 Apr 2009 10:33:49 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: oops in futex_init()
Message-ID: <20090429083349.GB26289@linux-mips.org>
References: <20090428124645.GA14347@roarinelk.homelinux.net> <20090429060317.GB15627@linux-mips.org> <20090429082556.GA22844@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090429082556.GA22844@roarinelk.homelinux.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22534
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Apr 29, 2009 at 10:25:56AM +0200, Manuel Lauss wrote:

> > > (gdb) disass 0x8042f0f8
> > > Dump of assembler code for function futex_init:
> > > 0x8042f0dc <futex_init+0>:      lw      v1,20(gp)
> > > 0x8042f0e0 <futex_init+4>:      addiu   v1,v1,1
> > > 0x8042f0e4 <futex_init+8>:      sw      v1,20(gp)
> > > 0x8042f0e8 <futex_init+12>:     lw      v0,24(gp)
> > > 0x8042f0ec <futex_init+16>:     andi    v0,v0,0x4
> > > 0x8042f0f0 <futex_init+20>:     bnez    v0,0x8042f114 <futex_init+56>
> > > 0x8042f0f4 <futex_init+24>:     li      a0,-14
> > > 0x8042f0f8 <futex_init+28>:     ll      a0,0(v0)
> > 
> > So this is in futex_atomic_cmpxchg_inatomic which has been inlined into
> > futex_init.  The epc is pointing to this LL instruction which is a
> > legitimate MIPS32 instruction, so a reserved instruction exception does
> > not make sense.  However, a NULL pointer has intensionally been passed
> > as the argument heres so this LL instruction will take a TLB exception,
> > do_page_fault() will change the EPC to return to to point to the fixup
> > handler which in the sources are these lines:
> > 
> >                 "       .section .fixup,\"ax\"                          \n"
> >                 "4:     li      %0, %5                                  \n"
> >                 "       j       3b                                      \n"
> >                 "       .previous                                       \n"
> >                 "       .section __ex_table,\"a\"                       \n"
> >                 "       "__UA_ADDR "\t1b, 4b                            \n"
> >                 "       "__UA_ADDR "\t2b, 4b                            \n"
> >                 "       .previous                                       \n"
> > 
> > That's how it normally should function.  If however in the exception
> > handler something goes wrong while c0_status.exl is still set the c0_epc
> > regiser won't be updated for the 2nd exception which is that reserved
> > instruction exception.  This sort of bug can be ugly to chase, I'm afraid.
> 
> Thanks for this info! In other words, this oops is actually the result of
> another earlier problem, which trashes something used by the tlb fault
> handler? (I've also seen this oops as a "kernel unaligned access" with epc
> at the 'll'.  Also, isn't it a problem that a0 is -14 instead of zero?).

No - it will be overwritten either after the load succeeded or in the
fixup handler.  The load of the -14 value is from __access_() happens to
be in a branch delay slot of a branch which will never be executed - but
that's as far as gcc knows how to optimize the access_ok() invokation
away.

When did this issue start?  I wonder if it was when you removed the Alchemy
hazard barriers?

  Ralf
