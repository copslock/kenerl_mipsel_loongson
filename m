Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f2QHJWJ27832
	for linux-mips-outgoing; Mon, 26 Mar 2001 09:19:32 -0800
Received: from dea.waldorf-gmbh.de (u-200-18.karlsruhe.ipdial.viaginterkom.de [62.180.18.200])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f2QHJSM27822
	for <linux-mips@oss.sgi.com>; Mon, 26 Mar 2001 09:19:29 -0800
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f2QHJ4Y08014;
	Mon, 26 Mar 2001 19:19:04 +0200
Date: Mon, 26 Mar 2001 19:19:04 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: jbglaw@lug-owl.de, linux-mips@oss.sgi.com,
   Harald Koerfgen <hkoerfg@web.de>
Subject: Re: elf2ecoff problem
Message-ID: <20010326191904.A7989@bacchus.dhis.org>
References: <20010325053554.A18589@bacchus.dhis.org> <20271.985577936@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20271.985577936@kao2.melbourne.sgi.com>; from kaos@ocs.com.au on Mon, Mar 26, 2001 at 01:38:56PM +1000
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Mar 26, 2001 at 01:38:56PM +1000, Keith Owens wrote:

> Ralf Baechle <ralf@oss.sgi.com> wrote:
> >The .modinfo section gets into vmlinux through drivers/tc/tc.o where it
> >gets created because include/asm-mips/dec/tcmodule.h defines the cpp
> >symbol MODULE; <linux/module.h> gets included after that and believing
> >this is a module compilation puts some stuff into .modinfo.
> 
> tc will have to use a name other than MODULE, say TC_MODULE.

I've now commited a fix to CVS.

  Ralf
