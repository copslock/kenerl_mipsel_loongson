Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Jun 2006 07:49:47 +0100 (BST)
Received: from deliver-1.mx.triera.net ([213.161.0.31]:34216 "HELO
	deliver-1.mx.triera.net") by ftp.linux-mips.org with SMTP
	id S8133451AbWFVGti (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 22 Jun 2006 07:49:38 +0100
Received: from localhost (in-1.mx.triera.net [213.161.0.25])
	by deliver-1.mx.triera.net (Postfix) with ESMTP id 91365BFD5;
	Thu, 22 Jun 2006 08:49:27 +0200 (CEST)
Received: from smtp.triera.net (smtp.triera.net [213.161.0.30])
	by in-1.mx.triera.net (Postfix) with SMTP id 060151BC095;
	Thu, 22 Jun 2006 08:49:28 +0200 (CEST)
Received: from localhost (unknown [213.161.20.162])
	by smtp.triera.net (Postfix) with ESMTP id A2D5B1A18AB;
	Thu, 22 Jun 2006 08:49:28 +0200 (CEST)
Date:	Thu, 22 Jun 2006 08:49:30 +0200
From:	Domen Puncer <domen.puncer@ultra.si>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Kumba <kumba@gentoo.org>, linux-mips@linux-mips.org
Subject: Re: Commit 78eef01b0fae087c5fadbd85dd4fe2918c3a015f (on_each_cpu(): disable local interrupts) Breaks SGI IP32
Message-ID: <20060622064930.GP5568@domen.ultra.si>
References: <4478C0F1.8000006@gentoo.org> <20060528010603.GA24997@linux-mips.org> <20060527194243.a8157338.akpm@osdl.org> <4479250E.3080604@gentoo.org> <20060528105014.GA28621@linux-mips.org> <20060621095150.GO5568@domen.ultra.si> <20060621121110.GA12545@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060621121110.GA12545@linux-mips.org>
User-Agent: Mutt/1.5.11+cvs20060126
X-Virus-Scanned: Triera AV Service
Return-Path: <domen.puncer@ultra.si>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11804
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: domen.puncer@ultra.si
Precedence: bulk
X-list: linux-mips

On 21/06/06 13:11 +0100, Ralf Baechle wrote:
> On Wed, Jun 21, 2006 at 11:51:50AM +0200, Domen Puncer wrote:
> 
> > > #define on_each_cpu(func,info,retry,wait)       \
> > >         ({                                      \
> > > 		WARN_ON(irqs_disabled());	\
> > >                 func(info);                     \
> > >                 0;                              \
> > >         })
> > 
> > On Alchemy au1200 this produces:
> > [4294667.296000] Synthesized TLB modify handler fastpath (33 instructions).
> > [4294667.296000] Badness in r4k_flush_icache_range at /home/domen/tmp/linux-2.6.bisecting/linux-mips.git/arch/mips/mm/c-r4k.c:516
> > [4294667.296000] Call Trace:
> > [4294667.296000]  [<80113434>] r4k_flush_icache_range+0x144/0x150
> > [4294667.296000]  [<803f0000>] inflate_dynamic+0x634/0x70c
> > [4294667.296000]  [<803f3630>] trap_init+0x3c/0x440
> 
> Pretty much as expected, thanks!

Guess I forgot to state my simptoms... they don't seem so expected to me
:-)

set_c0_status(ALLINTS) causes in_interrupt to be non-zero, which in time
causes a hang via kernel/printk.c:acquire_console_sem->BUG().

set_c0_status call trace:
start_kernel->init_IRQ->arch_init_irq->set_c0_status


I'm a bit lost in mipsregs.h, and I can't figure out why it sets
preempt_count() to 0x100 (that being HARD_IRQ).

Ideas?


	Domen
