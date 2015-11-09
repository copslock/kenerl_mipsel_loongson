Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Nov 2015 09:09:10 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:47786 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27012973AbbKIIJIMjUWD (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 9 Nov 2015 09:09:08 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id tA9897uB001440;
        Mon, 9 Nov 2015 09:09:07 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id tA98960Y001439;
        Mon, 9 Nov 2015 09:09:06 +0100
Date:   Mon, 9 Nov 2015 09:09:06 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Petri Gynther <pgynther@google.com>
Cc:     linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: add nmi_enter() + nmi_exit() to
 nmi_exception_handler()
Message-ID: <20151109080906.GA27251@linux-mips.org>
References: <1445280592-43038-1-git-send-email-pgynther@google.com>
 <CAGXr9JH5TLxOnA2LMPdxo3Sqeigprm=KFiiM9Vu2eMOaMgC6yA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXr9JH5TLxOnA2LMPdxo3Sqeigprm=KFiiM9Vu2eMOaMgC6yA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49869
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Mon, Nov 02, 2015 at 12:50:50PM -0800, Petri Gynther wrote:

> On Mon, Oct 19, 2015 at 11:49 AM, Petri Gynther <pgynther@google.com> wrote:
> >
> > We need to enter NMI context when NMI interrupt fires.
> >
> > Signed-off-by: Petri Gynther <pgynther@google.com>
> > ---
> >  arch/mips/kernel/traps.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
> > index fdb392b..efcedd4 100644
> > --- a/arch/mips/kernel/traps.c
> > +++ b/arch/mips/kernel/traps.c
> > @@ -1856,12 +1856,14 @@ void __noreturn nmi_exception_handler(struct pt_regs *regs)
> >  {
> >         char str[100];
> >
> > +       nmi_enter();
> >         raw_notifier_call_chain(&nmi_chain, 0, regs);
> >         bust_spinlocks(1);
> >         snprintf(str, 100, "CPU%d NMI taken, CP0_EPC=%lx\n",
> >                  smp_processor_id(), regs->cp0_epc);
> >         regs->cp0_epc = read_c0_errorepc();
> >         die(str, regs);
> > +       nmi_exit();
> >  }
> >
> >  #define VECTORSPACING 0x100    /* for EI/VI mode */
> > --
> > 2.6.0.rc2.230.g3dd15c0
> >
> 
> Any comments/concerns about this patch?

Is NMI on your systems actually recoverable?  I never bothered with
nmi_enther / nmi_exit and other fine details of the NMI implementations
because as defined by the MIPS architecture an NMI may be pretty destructive
and closer to a reset than what other architectures describer as their NMI.
Think what's going to happen if it hits during any phase when $k0 / $k1
are active.

  Ralf
