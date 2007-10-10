Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Oct 2007 10:54:30 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:1229 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021828AbXJJJy2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 10 Oct 2007 10:54:28 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9A8rhcS000315;
	Wed, 10 Oct 2007 09:53:44 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9A8rhca000314;
	Wed, 10 Oct 2007 09:53:43 +0100
Date:	Wed, 10 Oct 2007 09:53:43 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Franck Bui-Huu <vagabon.xyz@gmail.com>,
	Thiemo Seufer <ths@networkno.de>, linux-mips@linux-mips.org
Subject: Re: [PATCH] mm/pg-r4k.c: Dump the generated code
Message-ID: <20071010085343.GA31184@linux-mips.org>
References: <4703F155.4000301@gmail.com> <20071003201800.GP16772@networkno.de> <47049734.6050802@gmail.com> <20071004121557.GA28928@linux-mips.org> <4705004C.5000705@gmail.com> <Pine.LNX.4.64N.0710041616570.10573@blysk.ds.pg.gda.pl> <4705EFE5.7090704@gmail.com> <Pine.LNX.4.64N.0710051312490.17849@blysk.ds.pg.gda.pl> <470A4349.9090301@gmail.com> <Pine.LNX.4.64N.0710081611460.8873@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0710081611460.8873@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16923
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Oct 08, 2007 at 04:39:38PM +0100, Maciej W. Rozycki wrote:

> > Well, having all cpu variations in Kconfig should be technically
> > possible. The user needs to know what exact cpu is running on which
> > doesn't sound impossible and we could add some sanity checkings to
> > ensure he doesn't messed up its configuration.
> 
>  As long as the user is indeed capable of knowing what the exact CPU type 
> is.  I have been told replacing R4X00 with a choice like R4000, R4400, 
> R4600, R4700 may already be too much of a hassle.

Four choices is too much; after all these four marketing names are really
just 4 variants of two fairly similar processors.  Doable?  Yes.  A useful
improvment?  I doubt, otoh users of those old machines count every cycle
by hand still ;-)

Another problem with the enormous and continuously growing number of
processors is that few users know about all the compatibility issues
between the choices offered in Kconfig.  Alot of bug reports were caused
for example because users took MIPS32 to mean 32-bit MIPS - but R3000
processors clearly disagree with that view ;-)

One of the things I'm trying to achieve is to get rid of all the use of
CONFIG_CPU_MIPS32_R1 and similar processor symbols in code coming to a
point where selection of one of those symbols in Kconfig only means to
optimize a kernel for the selected core without sacrificing compatibility.

(But of course the few machines that support processors with multiple ISAs
spoil that plan a little ..)

>  Frankly I am not entirely confident much choice beyond the ISA level is 
> actually a good idea.  We do have it, because lots of bits depend on 
> preprocessor conditionals even though they not necessarily should.  There 
> are probably some historical reasons too.  But essentially we have about 
> eight ISA variations (I - IV and four MIPS Architecture ISAs) and about 
> four privileged resource architecture variations (R2000, R6000, R4000, 
> R8000); not all combinations making sense and some of the choices actually 
> not supported at all.
> 
>  CPU variations matter performance-wise, but the use of "-mtune=" is 
> irrelevant in this context.
> 
> > BTW, we could pass more cpu compiler options for optimization this
> > way. For example, when using a '4ksd' cpu, we currently can't pass
> > '-march=4ksd' to gcc since the cpu type used for it is 'mips32r2'. And
> > I guess it's true for all cpu types which cover a range of slightly
> > different processors (r4x00 comes in mind).
> 
>  What would be the gain for the kernel from using "-march=4ksd" rather 
> than "-march=mips32r2"?

One looks fancier ;-)

> > OTOH, I don't know if it can work on SMP: if the system needs 2
> > different implementations of the handler (I don't know if it can
> > happen though), we must be able to select 2 different cpu types in
> > Kconfig...
> 
>  I do not think we happen to handle this scenario -- the more interesting 
> configurations that could benefit do not support the cp0.ebase register 
> making per-CPU handlers quite a challenge (i.e. the cost would exceed the 
> benefit).

It's doable but there is little point.  Ebase is an R2 feature and who
on earth would mix pre-R2 and R2 cores in a SOC now that R2 is established
for a few years?

> > Do you see any other points that we should consider before trying to
> > use static handlers ? Some other cpu features influencing the tlb
> > handler generations and that can be found only at runtime ?
> 
>  What if you want to run a single kernel image regardless of the CPU 
> installed in the system.  Rebuilding the kernel (or having to keep a large 
> collection of binaries) just because you want to swap the CPU does not 
> seem like a terribly attractive idea.  Some systems come with their CPU(s) 
> on a daughtercard (each), you know...

Or an FPGAs.  I can swap CPUs on my Malta from the other side of earth in
few seconds by downloading another bitfile.  And it's damn useful to be
able to use the same kernel binary, keeps another 10min from going down
the drain for just a rebuild.

  Ralf
