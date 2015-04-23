Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Apr 2015 23:21:21 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27025961AbbDWVVT0IwwN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Apr 2015 23:21:19 +0200
Date:   Thu, 23 Apr 2015 22:21:19 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Markos Chandras <Markos.Chandras@imgtec.com>
cc:     linux-mips@linux-mips.org
Subject: Re: [RFC] MIPS: Prevent "BUG: using smp_processor_id() in preemptible..."
 errors
In-Reply-To: <5538A647.10009@imgtec.com>
Message-ID: <alpine.LFD.2.11.1504232203580.5204@eddie.linux-mips.org>
References: <20150422172359.GA20553@paulmartin.codethink.co.uk> <5538A647.10009@imgtec.com>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47018
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

On Thu, 23 Apr 2015, Markos Chandras wrote:

> > Commit 9b26616c8d9dae53fbac7f7cb2c6dd1308102976 "MIPS: Respect the ISA
> > level in FCSR handling" added references to current_cpu_data, which is
> > a macro expanding to cpu_data[smp_processor_id()].  Change these to
> > raw_current_cpu_data.
> > 
> > These changes may or may not be a good idea.

 Good catch, thanks!  I don't use the kernel preemption feature, so it 
slipped through my testing.

> > diff --git a/arch/mips/include/asm/elf.h b/arch/mips/include/asm/elf.h
> > index a594d8e..63f3bbc 100644
> > --- a/arch/mips/include/asm/elf.h
> > +++ b/arch/mips/include/asm/elf.h
> > @@ -304,7 +304,7 @@ do {									\
> >  									\
> >  	current->thread.abi = &mips_abi;				\
> >  									\
> > -	current->thread.fpu.fcr31 = current_cpu_data.fpu_csr31;		\
> > +	current->thread.fpu.fcr31 = raw_current_cpu_data.fpu_csr31;	\
> 
> The change looks sensible. I am wondering if
> boot_cpu_data(==cpu_data[0]) is a better option though.

 Yeah, we have this schizophrenic arrangement where we collect per-CPU 
features first according to what individual processors support and then 
implicitly assert (without really checking) that CPU[0] is the weakest and 
its settings will do for the rest.  So e.g. all `cpu_has_*' macros expand 
to `cpu_data[0].*' regardless of what CPU they're called from (why they 
ask for `cpu_data[0]' explictly rather that `boot_cpu_data' escapes me).

 I think we should reconsider it all and rework (simplify) one day, and 
maybe decide how much asymmetry we can afford and consequently have noted 
on a per-CPU basis, but for the time being let's have `boot_cpu_data' here 
as well.  Thanks!

  Maciej
