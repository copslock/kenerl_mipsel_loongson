Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f2Q3SAa01053
	for linux-mips-outgoing; Sun, 25 Mar 2001 19:28:10 -0800
Received: from dea.waldorf-gmbh.de (u-188-10.karlsruhe.ipdial.viaginterkom.de [62.180.10.188])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f2Q3S8M01047
	for <linux-mips@oss.sgi.com>; Sun, 25 Mar 2001 19:28:08 -0800
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f2P3aUv18623;
	Sun, 25 Mar 2001 05:36:30 +0200
Date: Sun, 25 Mar 2001 05:35:54 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: jbglaw@lug-owl.de, linux-mips@oss.sgi.com,
   Harald Koerfgen <hkoerfg@web.de>
Subject: Re: elf2ecoff problem
Message-ID: <20010325053554.A18589@bacchus.dhis.org>
References: <20010324221757.B9810@lug-owl.de> <32583.985476116@ocs3.ocs-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <32583.985476116@ocs3.ocs-net>; from kaos@ocs.com.au on Sun, Mar 25, 2001 at 09:21:56AM +1000
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, Mar 25, 2001 at 09:21:56AM +1000, Keith Owens wrote:

> On Sat, 24 Mar 2001 22:17:58 +0100, 
> Jan-Benedict Glaw <jbglaw@lug-owl.de> wrote:
> >./elf2ecoff /home/jbglaw/kernel_src/work/mips_linux/linux/vmlinux vmlinux.ecoff -a
> >Non-contiguous data can't be converted.
> > 17 .modinfo      00000018  ffffffff802730a0  ffffffff802730a0  001700a0  2**2
> >                  CONTENTS, ALLOC, LOAD, READONLY, DATA
> 
> This may not be relevant but vmlinux should not have a .modinfo
> section.  .modinfo is only created when code is compiled with -DMODULE
> so why is it in vmlinux?
> 
> There was a recent change to the attributes of .modinfo, from CONTENTS,
> READONLY to CONTENTS, ALLOC, LOAD, READONLY, DATA, this change was to
> remove gcc warning messages.  insmod treats sections .modinfo and
> .modstring as special cases and turns off the SHF_ALLOC flag, elf2ecoff
> might need special processing for these sections.

The .modinfo section gets into vmlinux through drivers/tc/tc.o where it
gets created because include/asm-mips/dec/tcmodule.h defines the cpp
symbol MODULE; <linux/module.h> gets included after that and believing
this is a module compilation puts some stuff into .modinfo.

  Ralf
