Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f2GJZq313409
	for linux-mips-outgoing; Fri, 16 Mar 2001 11:35:52 -0800
Received: from dea.waldorf-gmbh.de (u-210-18.karlsruhe.ipdial.viaginterkom.de [62.180.18.210])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f2GJZlM13406
	for <linux-mips@oss.sgi.com>; Fri, 16 Mar 2001 11:35:48 -0800
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f2GJZe214975;
	Fri, 16 Mar 2001 20:35:40 +0100
Date: Fri, 16 Mar 2001 20:35:40 +0100
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: <linux-mips@oss.sgi.com>
Subject: Re: Can't build a CONFIG_CPU_NEVADA kernel
Message-ID: <20010316203540.D2857@bacchus.dhis.org>
References: <20010314084633.A25674@nevyn.them.org> <20010314195919.A1911@bacchus.dhis.org> <20010314140529.A29525@nevyn.them.org> <20010314202058.B1911@bacchus.dhis.org> <00fc01c0acd3$c881ca80$0deca8c0@Ulysses> <20010316150423.A3529@bacchus.dhis.org> <010201c0ae49$6df089e0$0deca8c0@Ulysses>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <010201c0ae49$6df089e0$0deca8c0@Ulysses>; from kevink@mips.com on Fri, Mar 16, 2001 at 07:46:23PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Mar 16, 2001 at 07:46:23PM +0100, Kevin D. Kissell wrote:

> > GCC to schedule instructions for a certain processor xxx.  This does not
> > enable the full use of it's instruction set.  Back in time when I choose
> > these options I choose because GCC didn't know -mcpu=r5000 but the R8000
> > was supported and it was the closest fit.  Gcc 1.1.2 knows this option
> > so I just changed all instances of -mcpu=r8000 into -mcpu=r5000.
> 
> As I understand it, the original intention behind -mcpu was to optimise 
> instruction scheduling, but it got perverted over time to enable 
> instructions as well.  In any case, the R5000 and R8000 have the 
> same ISA, but the pipelines are radically different.  The R8K is 
> 4-way superscalar, with a 2-cycle branch penalty and branch 
> prediction.  The R5K is two way supercalar (Int/FP pairs only) 
> with classic MIPS branch behavior, etc.

Gcc's knowledge about MIPS architecture is so limited that an R5000 isn't
very much different from an R8000 ...

> > Unfortunately true but there is a reason that QED's manual marks it as an
> > proprietary extension ...
> 
> Yup.  The quesiton is, does gcc's -mmad option actually
> select based on -mcpu or some other variable which
> semantics to use, or does it assume R4650 semantics

If you have a collection which of the CPUs have implemented mmad in what
way I'd like to use that to put it into gcc.

> (I had the impression that it was the R4650 that drove
> the implementation of MIPS madd's into gcc - correct
> me if I'm wrong).

Guess that's right.

  Ralf
