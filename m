Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5IINCE18281
	for linux-mips-outgoing; Mon, 18 Jun 2001 11:23:12 -0700
Received: from dea.waldorf-gmbh.de (u-95-18.karlsruhe.ipdial.viaginterkom.de [62.180.18.95])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5IIN9V18271
	for <linux-mips@oss.sgi.com>; Mon, 18 Jun 2001 11:23:10 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f5IIMdN26761;
	Mon, 18 Jun 2001 20:22:39 +0200
Date: Mon, 18 Jun 2001 20:22:39 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Brian Murphy <brian@murphy.dk>
Cc: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: Problems with mips2 compiled libc and linux 2.4.3
Message-ID: <20010618202239.C25814@bacchus.dhis.org>
References: <3B2E4458.1637A08A@murphy.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B2E4458.1637A08A@murphy.dk>; from brian@murphy.dk on Mon, Jun 18, 2001 at 08:11:36PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Jun 18, 2001 at 08:11:36PM +0200, Brian Murphy wrote:

>         if (__h->e_flags & EF_MIPS_ARCH)
> \
>                 __res = 0;

> which is called in fs/binfmt_elf.c causes the loading of init to fail if
> it is linked with a glibc compiled with -mips2. It is the second if test
> which fails if any of the high 4 bits in the flags are set. According to
> the specs these are set for the various mipsx (x != 1) flavors - this seems
> to mean that we do no allow anything higher than mips1 run on linux -
> can this be
> true? If so, why?

Older binutils didn't use to set these flags but SGI's ld did so this was
a heuristc to reject IRIX binaries which are handled by irixelf.c.  The
fix is simple, just remove above test.

Time to come up with some other plan to detec IRIX binaries ...

  Ralf
