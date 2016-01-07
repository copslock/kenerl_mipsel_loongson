Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jan 2016 01:55:35 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:26061 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010061AbcAGAzcCzWrY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Jan 2016 01:55:32 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id C4DA173234CC2;
        Thu,  7 Jan 2016 00:55:20 +0000 (GMT)
Received: from [10.100.200.34] (10.100.200.34) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.235.1; Thu, 7 Jan 2016
 00:55:24 +0000
Date:   Thu, 7 Jan 2016 00:55:36 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Joseph Myers <joseph@codesourcery.com>
CC:     <linux-mips@linux-mips.org>, <libc-alpha@sourceware.org>,
        <binutils@sourceware.org>, <gcc@gcc.gnu.org>,
        Matthew Fortune <Matthew.Fortune@imgtec.com>,
        Daniel Sanders <Daniel.Sanders@imgtec.com>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Subject: Re: [RFC] MIPS ABI Extension for IEEE Std 754 Non-Compliant
 Interlinking
In-Reply-To: <alpine.DEB.2.10.1511271750590.3430@digraph.polyomino.org.uk>
Message-ID: <alpine.DEB.2.00.1601061844450.5958@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1511140411050.7097@tp.orcam.me.uk> <alpine.DEB.2.10.1511171503510.14808@digraph.polyomino.org.uk> <alpine.DEB.2.00.1511201535580.6915@tp.orcam.me.uk> <alpine.DEB.2.10.1511201815230.9012@digraph.polyomino.org.uk>
 <alpine.DEB.2.00.1511271547290.16168@tp.orcam.me.uk> <alpine.DEB.2.10.1511271750590.3430@digraph.polyomino.org.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.100.200.34]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50951
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

On Fri, 27 Nov 2015, Joseph Myers wrote:

> > I find it highly unlikely though that the writers will (be able to) chase 
> > individual targets and any obscure hardware-dependent options the targets 
> > may provide.  And we cannot expect people compiling software to be 
> 
> What that says to me is that there should be an architecture-independent 
> option (-fieee?) that, for architectures where the default configuration 
> may have architecture-specific deviations from the normal defaults 
> regarding conformance to IEEE 754 language bindings but there are options 
> to disable those deviations, disables those deviations.  For example, on 
> alpha that would imply -mieee-with-inexact.  On architectures without such 
> issues (beyond bugs that should be fixed unconditionally, not conditional 
> on a command-line option, or issues with the hardware ISA that are 
> infeasible to fix in software), that option would do nothing (beyond any 
> architecture-independent effects it might have such as implying 
> -fno-fast-math).

 I'm fine with `-fieee'/`-fno-ieee', and corresponding 
`--with-ieee=yes/no' configuration options.

 I have been aware of the Alpha processor's imprecise IEEE 754 exception 
mode and while working on the specification concerned here I had in my 
mind the possibility of expanding the semantics of the MIPS target's 
`-mieee=' option to cover the somewhat similar imprecise IEEE 754 
exception mode of the MIPS R8000 processor, or any optimisations of the 
same or a different kind the MIPS architecture might introduce in the 
future.

 Since (regrettably) by now the Alpha architecture has become a legacy one 
I didn't consider it important enough to create a generic option which 
would only control the Alpha target, in addition to the MIPS target being 
considered here.  So I am actually glad you proposed it as I agree it will 
make things cleaner.

> >  As you may see in the GCC patches I have just posted the `-mieee=strict' 
> > option I've implemented sets `-fno-fast-math', and `-mrelaxed-nan=none', 
> > the only target-specific option so far.  So this does exactly what I 
> > outlined above.
> 
> I am doubtful about the architecture-specific option setting 
> architecture-independent options here.  Having it the other way round as I 
> suggested above would make more sense to me.

 Agreed, as noted above.

> > "Any or all of these options may have effects beyond propagating the IEEE 
> > Std 754 compliance mode down to the assembler and the linker.  In 
> > particular `-mieee=strict' is expected to produce strictly compliant code, 
> > which in the context of this specification is defined as: following IEEE 
> > Std 754 as closely as the programming language binding to the standard 
> > (defined in the relevant language standard), the compiler implementation 
> > and target hardware permit.  This means the use of this option may affect 
> > code produced in ways beyond NaN representation only."
> > 
> > > >  Does this answer address your concerns?
> > > 
> > > No, the option concept as described seems too irremediably vague.
> > 
> >  Does this explanation give you a better idea of what I have in mind?  Do 
> > you still have concerns about the feasibility of the idea?
> 
> It's better defined, but I think it would be better for -fieee to imply 
> -mieee=strict -fno-fast-math (or whatever) rather than for -mieee=strict 
> to imply architecture-independent options.  Cf. i386 and sh where 
> -ffinite-math-only affects architecture-specific options.

 Thanks for the references.  I'll have a look in the course of updating 
the implementation.

 With `-fieee' in the picture I think we can get rid of GCC's 
target-specific high-level `-mieee=' option, as having become redundant, 
and retain the low-level `-mrelaxed-nan=' only, with the assumption that 
only power users will need to control this setting directly and they will 
necessarily have studied and understood all the implications.  Additional 
low-level options can be added in the future as needed to control the 
R8000 exception mode or other architectural features affecting IEEE 754 
arithmetic, wired to `-fieee' as appropriate.

 I'm going to retain the assembler and linker options and directives of 
the `*ieee*' form though as their purpose is a bit different -- to set 
flags in a binary file rather than affecting code generation -- and I 
don't think it makes sense to expand the namespace there.  The effects of 
these options are cumulative rather than mutually exclusive and it's the 
names of individual bits or enumeration fields within binary file's 
control structures, referred in the option's or directive's argument, that 
tell features apart.

 I'll be updating the specification and the proposed implementation 
shortly, and I also think the addition of `-fieee' will then better be 
done as a separate preparatory change, initially affecting the Alpha 
target only.  Please let me know if I missed anything, or if you have any 
other questions or comments.

 Thank you for your input, and Happy New Year!

  Maciej
