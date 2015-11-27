Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Nov 2015 16:47:38 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:54416 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006752AbbK0PrhHkKPb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Nov 2015 16:47:37 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id A3E5384A909B1;
        Fri, 27 Nov 2015 15:47:27 +0000 (GMT)
Received: from [192.168.14.72] (192.168.14.72) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.235.1; Fri, 27 Nov
 2015 15:47:29 +0000
Date:   Fri, 27 Nov 2015 15:47:36 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Joseph Myers <joseph@codesourcery.com>
CC:     <linux-mips@linux-mips.org>, <libc-alpha@sourceware.org>,
        <binutils@sourceware.org>, <gcc@gcc.gnu.org>,
        Matthew Fortune <Matthew.Fortune@imgtec.com>,
        Daniel Sanders <Daniel.Sanders@imgtec.com>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Subject: Re: [RFC] MIPS ABI Extension for IEEE Std 754 Non-Compliant
 Interlinking
In-Reply-To: <alpine.DEB.2.10.1511201815230.9012@digraph.polyomino.org.uk>
Message-ID: <alpine.DEB.2.00.1511271547290.16168@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1511140411050.7097@tp.orcam.me.uk> <alpine.DEB.2.10.1511171503510.14808@digraph.polyomino.org.uk> <alpine.DEB.2.00.1511201535580.6915@tp.orcam.me.uk> <alpine.DEB.2.10.1511201815230.9012@digraph.polyomino.org.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [192.168.14.72]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50158
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
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

On Fri, 20 Nov 2015, Joseph Myers wrote:

> >  The target audience for the `-mieee=strict' option is in my idea a 
> > non-technical user, say a physicist, who does not necessarily know or is 
> > fluent with the guts of computer hardware and who has the need to build 
> > and reliably run their software which uses IEEE Std 754 arithmetic.  
> > Rather than giving such a user necessarily lengthy explanations as to the 
> > complexity of the situation I'd prefer to give them this single option to 
> > guarantee (modulo bugs, as noted above) that a piece of software built 
> > with this option will either produce correct (as in "standard-compliant") 
> > results or refuse to run.
> 
> This does not make any sense.  The correspondence between IEEE 754 
> operations and source code in C or other languages is extremely 
> complicated.  If the user thinks of C as some form of portable assembler 
> for IEEE 754 operations, that is not something effectively supportable.
> 
> Can we assume that if the user depends on rounding modes, they will use 
> the FENV_ACCESS pragma (not implemented, of course) or -frounding-math?  
> Can we assume that their dependence on the absence of contraction of 
> expressions is in accordance with ISO C rules (again, FP_CONTRACT isn't 
> implemented but -ffp-contract=off is)?  Can we assume that they don't 
> depend on signaling NaNs?  Can we assume they don't depend on trap 
> handlers that count the number of times a given exception occurs, since 
> that is explicitly unsupported by ISO C?
> 
> An option like that has to be defined in terms of existing C bindings for 
> IEEE 754, not in terms of supporting users who don't know what they are 
> doing and are unfamiliar with how C source code constructs are mapped to 
> IEEE 754 operations and what features the C standard allows non-default 
> pragmas or options to be required for.

 These are all valid points, thank you for raising them.

 One problem with the situation you have summarised is it may be possible 
(though perhaps challenging) for software writers to understand it.  They 
may take it into account while implementing their code, and they may even 
provide information to the person compiling their piece of software as to 
which revision of the relevant language standard to compile for, maybe 
even some guidelines to which options to select with particular compilers.  
I find it highly unlikely though that the writers will (be able to) chase 
individual targets and any obscure hardware-dependent options the targets 
may provide.  And we cannot expect people compiling software to be 
educated enough to understand all the complexities behind all the 
standards and particular implementations involved.

 What I think we therefore need is an option that, on top of the generic 
compiler options like ones you've noted, will control to permit or forbid 
target-specific (in this case MIPS-specific) deviations from IEEE Std 754, 
its language bindings and the ABI that has been out there for at least 20 
years (concerning the Linux target in particular).  And I don't think 
having to explain the peculiarities of NaN encodings and their dependency 
on hardware implementation in this case to people compiling software is a 
good idea.  I think they won't just get it as I've even seen people very 
familiar with computer architectures getting lost.

 As you may see in the GCC patches I have just posted the `-mieee=strict' 
option I've implemented sets `-fno-fast-math', and `-mrelaxed-nan=none', 
the only target-specific option so far.  So this does exactly what I 
outlined above.

 NB I am not going to dive into implementation shortcomings GCC has now as 
I don't think they really matter for this consideration.  There's no way 
an option is going to make a compiler do what it does not implement, and 
users will have to live with that.  I think the presence or absence of an 
option to control target-specific aspects of IEEE Std 754 compliance is 
really tangential to any compiler shortcomings, and any such shortcomings 
addressed in the future will apply accordingly to the mode of compilation 
set with `-mieee=strict'.

 Taking the observations above into account I propose to reword the 
paragraph you questioned as follows:

"Any or all of these options may have effects beyond propagating the IEEE 
Std 754 compliance mode down to the assembler and the linker.  In 
particular `-mieee=strict' is expected to produce strictly compliant code, 
which in the context of this specification is defined as: following IEEE 
Std 754 as closely as the programming language binding to the standard 
(defined in the relevant language standard), the compiler implementation 
and target hardware permit.  This means the use of this option may affect 
code produced in ways beyond NaN representation only."

> >  Does this answer address your concerns?
> 
> No, the option concept as described seems too irremediably vague.

 Does this explanation give you a better idea of what I have in mind?  Do 
you still have concerns about the feasibility of the idea?

 Thank you for your input.

  Maciej
