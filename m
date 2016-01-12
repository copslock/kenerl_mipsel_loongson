Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Jan 2016 22:38:45 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:38762 "EHLO localhost"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010680AbcALVilzbXhk (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 12 Jan 2016 22:38:41 +0100
Date:   Tue, 12 Jan 2016 21:38:41 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     Petri Gynther <pgynther@google.com>,
        linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: add nmi_enter() + nmi_exit() to
 nmi_exception_handler()
In-Reply-To: <20160112135019.GB30362@linux-mips.org>
Message-ID: <alpine.LFD.2.20.1601121740520.23714@eddie.linux-mips.org>
References: <1445280592-43038-1-git-send-email-pgynther@google.com> <CAGXr9JH5TLxOnA2LMPdxo3Sqeigprm=KFiiM9Vu2eMOaMgC6yA@mail.gmail.com> <20151109080906.GA27251@linux-mips.org> <alpine.LFD.2.20.1601120044470.23714@eddie.linux-mips.org>
 <20160112135019.GB30362@linux-mips.org>
User-Agent: Alpine 2.20 (LFD 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51084
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

On Tue, 12 Jan 2016, Ralf Baechle wrote:

> >  We could do better though, by having a register stash area defined 
> > somewhere in low memory (0x0-0x7fff) -- of course if physical memory is 
> > actually available there in a given system.  Remember that setting 
> > CP0.Status.ERL makes KUSEG identity mapped, making it possible to access 
> > its beginning off $zero and save all GPRs in a non-destructive manner.
> > 
> >  That is however assuming we can take control at all in the first place as 
> > the NMI vector is hardwired and points to a ROM location in a typical 
> > system.
> 
> NMIs don't nest; the system is lost if it receives another NMI before the
> state of the first is saved.  It's currently up to the system to avoid that
> probably by yes masking the non-maskable interrupt.

 Indeed, ErrorEPC will be lost on a nested NMI.  We should be able to 
detect it and let the handler complete gracefully if it reaches to the end 
uninterrupted.

> ErrorEPC is also used by cache errors so an NMI following a cache error
> exception before state has been saved might be fatal.

 Hmm, I think a cache error is fatal by itself, so this scenario is 
probably not of much concern -- just dumping the available state to the 
console and panicking should do.

> These are scenarios that are taken care of by CISC architectures but on a
> purebred RISC they're up to system implementors.

 E.g. x86 masks NMIs internally to avoid nesting, but it is able to notice 
another incoming NMI and releases it as soon as the handling of the 
previous one has completed.  We'd need to have external circuitry for any 
handling of this kind.

  Maciej
