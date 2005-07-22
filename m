Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jul 2005 14:05:21 +0100 (BST)
Received: from [IPv6:::ffff:216.208.38.107] ([IPv6:::ffff:216.208.38.107]:17026
	"EHLO OTTLS.pngxnet.com") by linux-mips.org with ESMTP
	id <S8225286AbVGVNFE>; Fri, 22 Jul 2005 14:05:04 +0100
Received: from bacchus.net.dhis.org ([10.255.255.134])
	by OTTLS.pngxnet.com (8.12.4/8.12.4) with ESMTP id j6MD6wBM000334
	for <linux-mips@linux-mips.org>; Fri, 22 Jul 2005 09:06:58 -0400
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j6MD6uWf029541;
	Fri, 22 Jul 2005 09:06:57 -0400
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j6MD6t68029540;
	Fri, 22 Jul 2005 09:06:55 -0400
Date:	Fri, 22 Jul 2005 09:06:55 -0400
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thiemo Seufer <ths@networkno.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: CVS Update@linux-mips.org: linux
Message-ID: <20050722130655.GD3803@linux-mips.org>
References: <20050721153359Z8225218-3678+3745@linux-mips.org> <20050722043057.GA3803@linux-mips.org> <20050722121030.GD1692@hattusa.textio>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050722121030.GD1692@hattusa.textio>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8598
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jul 22, 2005 at 02:10:30PM +0200, Thiemo Seufer wrote:
> Date:	Fri, 22 Jul 2005 14:10:30 +0200
> To:	Ralf Baechle <ralf@linux-mips.org>
> Cc:	linux-mips@linux-mips.org
> Subject: Re: CVS Update@linux-mips.org: linux
> Content-Type: text/plain; charset=us-ascii
> From:	Thiemo Seufer <ths@networkno.de>
> 
> Ralf Baechle wrote:
> > On Thu, Jul 21, 2005 at 04:33:53PM +0100, ths@linux-mips.org wrote:
> > 
> > > Modified files:
> > > 	arch/mips/kernel: binfmt_elfo32.c 
> > > 	include/asm-mips: elf.h 
> > > 
> > > Log message:
> > > 	Fix ELF defines: EF_* is a field, E_* a distinct flag therein.
> > 
> > Remarkably bad idea after the old definitions are already being used since
> > over a decade.
> 
> Well, kernel headers are less widely used than others, and everywhere
> else it is E_*. Since
>  - kernel headers in general aren't meant as an interface for userland,
>  - the definition is inconsistent to the userland one,

Glibc is the only thing elf.h that defines the E_* names at all and
explicitly says "don't use".

>  - the in-kernel use seems to be limited to the ELF binary object
>    loader and probably third party modules loaders
> I found moving to a consistent definition to be more useful than
> keeping the old inconsistent one.

I think you're confusing binutils's internal definitions with the use
everywhere else.

Mind pulling that patch?

  Ralf
