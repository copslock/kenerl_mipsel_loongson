Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1KF31k13867
	for linux-mips-outgoing; Wed, 20 Feb 2002 07:03:01 -0800
Received: from dea.linux-mips.net (a1as06-p249.stg.tli.de [195.252.187.249])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1KF2t913847
	for <linux-mips@oss.sgi.com>; Wed, 20 Feb 2002 07:02:56 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g1KDunJ16534;
	Wed, 20 Feb 2002 14:56:49 +0100
Date: Wed, 20 Feb 2002 14:56:49 +0100
From: Ralf Baechle <ralf@oss.sgi.com>
To: Florian Lohoff <flo@rfc822.org>
Cc: Dominic Sweetman <dom@algor.co.uk>, Jun Sun <jsun@mvista.com>,
   "Kevin D. Kissell" <kevink@mips.com>, linux-mips@oss.sgi.com
Subject: Re: FPU emulator unsafe for SMP?
Message-ID: <20020220145649.H15588@dea.linux-mips.net>
References: <3C6C6ACF.CAD2FFC@mvista.com> <20020215031118.B21011@dea.linux-mips.net> <20020214232030.A3601@mvista.com> <20020215003037.A3670@mvista.com> <002b01c1b607$6afbd5c0$10eca8c0@grendel> <20020219140514.C25739@mvista.com> <00af01c1b9a2$c0d6d5f0$10eca8c0@grendel> <20020219171238.E25739@mvista.com> <15475.24039.877276.257999@gladsmuir.algor.co.uk> <20020220093012.GF11654@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020220093012.GF11654@paradigm.rfc822.org>; from flo@rfc822.org on Wed, Feb 20, 2002 at 10:30:12AM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Feb 20, 2002 at 10:30:12AM +0100, Florian Lohoff wrote:

> > It may be heretical... but the lazy FPU context switch was invented
> > for 16MHz CPUs using a write-through cache and non-burst memory, where
> > saving 16 x 64-bit registers took 6us or so (and quite a bit less,
> > later, to read them back).  Call it 8us.
> 
> We are still running on good ol Decstations *snief* Going the way to
> make it SMP only like others archs seem to do it would be good.

While I don't intend to kill support for any of the old machines like
DECstations as long as anybody keeps maintaining support for them
certainly performance tradeoffs in generic code will not be based on
antique systems ...

  Ralf
