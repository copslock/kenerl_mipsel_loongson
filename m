Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jul 2005 15:14:22 +0100 (BST)
Received: from mx01.qsc.de ([IPv6:::ffff:213.148.129.14]:17110 "EHLO
	mx01.qsc.de") by linux-mips.org with ESMTP id <S8225313AbVGVOOD>;
	Fri, 22 Jul 2005 15:14:03 +0100
Received: from port-195-158-170-19.dynamic.qsc.de ([195.158.170.19] helo=hattusa.textio)
	by mx01.qsc.de with esmtp (Exim 3.35 #1)
	id 1DvyJm-000418-00; Fri, 22 Jul 2005 16:16:02 +0200
Received: from ths by hattusa.textio with local (Exim 4.52)
	id 1DvyJm-00067V-J1; Fri, 22 Jul 2005 16:16:02 +0200
Date:	Fri, 22 Jul 2005 16:16:02 +0200
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: CVS Update@linux-mips.org: linux
Message-ID: <20050722141602.GF1692@hattusa.textio>
References: <20050721153359Z8225218-3678+3745@linux-mips.org> <20050722043057.GA3803@linux-mips.org> <20050722121030.GD1692@hattusa.textio> <20050722130655.GD3803@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050722130655.GD3803@linux-mips.org>
User-Agent: Mutt/1.5.9i
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8606
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Fri, Jul 22, 2005 at 02:10:30PM +0200, Thiemo Seufer wrote:
> > Date:	Fri, 22 Jul 2005 14:10:30 +0200
> > To:	Ralf Baechle <ralf@linux-mips.org>
> > Cc:	linux-mips@linux-mips.org
> > Subject: Re: CVS Update@linux-mips.org: linux
> > Content-Type: text/plain; charset=us-ascii
> > From:	Thiemo Seufer <ths@networkno.de>
> > 
> > Ralf Baechle wrote:
> > > On Thu, Jul 21, 2005 at 04:33:53PM +0100, ths@linux-mips.org wrote:
> > > 
> > > > Modified files:
> > > > 	arch/mips/kernel: binfmt_elfo32.c 
> > > > 	include/asm-mips: elf.h 
> > > > 
> > > > Log message:
> > > > 	Fix ELF defines: EF_* is a field, E_* a distinct flag therein.
> > > 
> > > Remarkably bad idea after the old definitions are already being used since
> > > over a decade.
> > 
> > Well, kernel headers are less widely used than others, and everywhere
> > else it is E_*. Since
> >  - kernel headers in general aren't meant as an interface for userland,
> >  - the definition is inconsistent to the userland one,
> 
> Glibc is the only thing elf.h that defines the E_* names at all and
> explicitly says "don't use".

It looks like things are worse than just different naming:

Glibc prefers:
#define EF_MIPS_ARCH_1      0x00000000  /* -mips1 code.  */
#define EF_MIPS_ARCH_2      0x10000000  /* -mips2 code.  */
#define EF_MIPS_ARCH_3      0x20000000  /* -mips3 code.  */
#define EF_MIPS_ARCH_4      0x30000000  /* -mips4 code.  */
#define EF_MIPS_ARCH_5      0x40000000  /* -mips5 code.  */
#define EF_MIPS_ARCH_32     0x60000000  /* MIPS32 code.  */
#define EF_MIPS_ARCH_64     0x70000000  /* MIPS64 code.  */

and knows also but depreciates:
#define E_MIPS_ARCH_1     0x00000000    /* -mips1 code.  */
#define E_MIPS_ARCH_2     0x10000000    /* -mips2 code.  */
#define E_MIPS_ARCH_3     0x20000000    /* -mips3 code.  */
#define E_MIPS_ARCH_4     0x30000000    /* -mips4 code.  */
#define E_MIPS_ARCH_5     0x40000000    /* -mips5 code.  */
#define E_MIPS_ARCH_32    0x60000000    /* MIPS32 code.  */
#define E_MIPS_ARCH_64    0x70000000    /* MIPS64 code.  */

Gcc/binutils actually create:
#define E_MIPS_ARCH_1           0x00000000
#define E_MIPS_ARCH_2           0x10000000
#define E_MIPS_ARCH_3           0x20000000
#define E_MIPS_ARCH_4           0x30000000
#define E_MIPS_ARCH_5           0x40000000
#define E_MIPS_ARCH_32          0x50000000
#define E_MIPS_ARCH_64          0x60000000
#define E_MIPS_ARCH_32R2        0x70000000
#define E_MIPS_ARCH_64R2        0x80000000

The kernel has (had):
#define EF_MIPS_ARCH_1	0x00000000      /* -mips1 code.  */
#define EF_MIPS_ARCH_2	0x10000000      /* -mips2 code.  */
#define EF_MIPS_ARCH_3	0x20000000      /* -mips3 code.  */
#define EF_MIPS_ARCH_4	0x30000000      /* -mips4 code.  */
#define EF_MIPS_ARCH_5	0x40000000      /* -mips5 code.  */
#define EF_MIPS_ARCH_32	0x50000000      /* MIPS32 code.  */
#define EF_MIPS_ARCH_64	0x60000000      /* MIPS64 code.  */
#define EF_MIPS_ARCH_32R2     0x70000000	/* MIPS32 R2 code.  */
#define EF_MIPS_ARCH_64R2     0x80000000	/* MIPS64 R2 code.  */

so glibc misinterprets E(F)_MIPS_ARCH_{32,64} as used by the toolchain.

> >  - the in-kernel use seems to be limited to the ELF binary object
> >    loader and probably third party modules loaders
> > I found moving to a consistent definition to be more useful than
> > keeping the old inconsistent one.
> 
> I think you're confusing binutils's internal definitions with the use
> everywhere else.
> 
> Mind pulling that patch?

I would prefer to have the same consistent set of names for all users.

Maciej made the point that the EF_ prefix is common for ELF header flag
defines, this suggests to standardize on the defines the kernels had
previously. This might break glibc's ld.so for third party toolchains
which followed the glibc definitions (if they actually exist).

Comments?


Thiemo
