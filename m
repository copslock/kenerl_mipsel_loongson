Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Jan 2016 02:03:22 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:50190 "EHLO localhost"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011069AbcALBDTBW1Fj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 12 Jan 2016 02:03:19 +0100
Date:   Tue, 12 Jan 2016 01:03:18 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     Petri Gynther <pgynther@google.com>,
        linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: add nmi_enter() + nmi_exit() to
 nmi_exception_handler()
In-Reply-To: <20151109080906.GA27251@linux-mips.org>
Message-ID: <alpine.LFD.2.20.1601120044470.23714@eddie.linux-mips.org>
References: <1445280592-43038-1-git-send-email-pgynther@google.com> <CAGXr9JH5TLxOnA2LMPdxo3Sqeigprm=KFiiM9Vu2eMOaMgC6yA@mail.gmail.com> <20151109080906.GA27251@linux-mips.org>
User-Agent: Alpine 2.20 (LFD 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51066
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Mon, 9 Nov 2015, Ralf Baechle wrote:

> > > diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
> > > index fdb392b..efcedd4 100644
> > > --- a/arch/mips/kernel/traps.c
> > > +++ b/arch/mips/kernel/traps.c
> > > @@ -1856,12 +1856,14 @@ void __noreturn nmi_exception_handler(struct pt_regs *regs)
> > >  {
> > >         char str[100];
> > >
> > > +       nmi_enter();
> > >         raw_notifier_call_chain(&nmi_chain, 0, regs);
> > >         bust_spinlocks(1);
> > >         snprintf(str, 100, "CPU%d NMI taken, CP0_EPC=%lx\n",
> > >                  smp_processor_id(), regs->cp0_epc);
> > >         regs->cp0_epc = read_c0_errorepc();
> > >         die(str, regs);
> > > +       nmi_exit();
> > >  }
> > >
> > >  #define VECTORSPACING 0x100    /* for EI/VI mode */
> > > --
> > > 2.6.0.rc2.230.g3dd15c0
> > >
> > 
> > Any comments/concerns about this patch?
> 
> Is NMI on your systems actually recoverable?  I never bothered with
> nmi_enther / nmi_exit and other fine details of the NMI implementations
> because as defined by the MIPS architecture an NMI may be pretty destructive
> and closer to a reset than what other architectures describer as their NMI.
> Think what's going to happen if it hits during any phase when $k0 / $k1
> are active.

 We could do better though, by having a register stash area defined 
somewhere in low memory (0x0-0x7fff) -- of course if physical memory is 
actually available there in a given system.  Remember that setting 
CP0.Status.ERL makes KUSEG identity mapped, making it possible to access 
its beginning off $zero and save all GPRs in a non-destructive manner.

 That is however assuming we can take control at all in the first place as 
the NMI vector is hardwired and points to a ROM location in a typical 
system.

  Maciej
