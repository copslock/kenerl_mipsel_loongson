Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Oct 2002 19:52:13 +0200 (CEST)
Received: from buserror-extern.convergence.de ([212.84.236.66]:56069 "EHLO
	hell") by linux-mips.org with ESMTP id <S1122978AbSJORwM>;
	Tue, 15 Oct 2002 19:52:12 +0200
Received: from js by hell with local (Exim 3.35 #1 (Debian))
	id 181VrR-0005bx-00; Tue, 15 Oct 2002 19:52:05 +0200
Date: Tue, 15 Oct 2002 19:52:05 +0200
From: Johannes Stezenbach <js@convergence.de>
To: Daniel Jacobowitz <dan@debian.org>
Cc: "Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org
Subject: Re: Once again: test_and_set for CPUs w/o LL/SC
Message-ID: <20021015175205.GA21538@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	Daniel Jacobowitz <dan@debian.org>,
	"Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org
References: <20020916164034.GA12489@convergence.de> <20021007144749.GB16641@convergence.de> <01fd01c26e1d$add77240$10eca8c0@grendel> <20021007184344.GA17548@convergence.de> <20021007185136.GA16501@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021007185136.GA16501@nevyn.them.org>
User-Agent: Mutt/1.4i
Return-Path: <js@convergence.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 442
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: js@convergence.de
Precedence: bulk
X-list: linux-mips

On Mon, Oct 07, 2002 at 02:51:36PM -0400, Daniel Jacobowitz wrote:
> On Mon, Oct 07, 2002 at 08:43:44PM +0200, Johannes Stezenbach wrote:
> > The question is how the glibc can detect if
> > a) the CPU does not have LL/SC
> > b) the kernel guarantees k1 != MAGIC
> 
> You should be using an "aux vector"; see how PowerPC provides current
> glibc with the size of a cache line.

It took me a while to figure out how aux vectors work.

It seems to me that MIPS does not use the hardware capabilities
field of the aux vector at all. TO use it, one would
have to

- add a field to struct cpuinfo_mips in include/asm-mips/processor.h,
  and set it in arch/mips/kernel/setup.c after CPU probing;
- define ELF_HWCAP in include/asm-mips/elf.h to return
  something useful from the new cpuinfo_mips field

Or, to just use it to signal "use beql k1, MAGIC instead of LL/SC",
one could just define ELF_HWCAP dependent on kernel-Config.

Anyway, we would have to document the meaning of the HWCAP bits
as part of the kernel ABI.

i386 uses this, as you can see by running e.g.
  $ LD_SHOW_AUXV=1 ls
provided you have glibc-2.2.5.

glibc/sysdeps/generic/dl-sysdep.c then reads it into dl_hwcap,
and it's up to platform specific code to use it.


Regards,
Johannes
