Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f792WB023286
	for linux-mips-outgoing; Wed, 8 Aug 2001 19:32:11 -0700
Received: from dea.waldorf-gmbh.de (u-68-21.karlsruhe.ipdial.viaginterkom.de [62.180.21.68])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f792W8V23283
	for <linux-mips@oss.sgi.com>; Wed, 8 Aug 2001 19:32:09 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f792V8Q19240;
	Thu, 9 Aug 2001 04:31:08 +0200
Date: Thu, 9 Aug 2001 04:31:08 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Ian <ian@WPI.EDU>
Cc: Guido Guenther <guido.guenther@gmx.net>,
   linux-mips <linux-mips@oss.sgi.com>
Subject: Re: HELP can't boot
Message-ID: <20010809043108.A19210@bacchus.dhis.org>
References: <20010808223940.B12550@galadriel.physik.uni-konstanz.de> <Pine.OSF.4.33.0108082125510.29716-100000@grover.WPI.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.OSF.4.33.0108082125510.29716-100000@grover.WPI.EDU>; from ian@WPI.EDU on Wed, Aug 08, 2001 at 09:27:17PM -0400
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Aug 08, 2001 at 09:27:17PM -0400, Ian wrote:

> > Try just "bootp():". The prom is clever enough to figure out the rest.
> 
> Doesn't work.  It complains that Sash is missing.
> 
> > I doubt that. You can't compile a recent glibc with that outdated toolchain.
> 
> You can.  You just build glibc and gcc with the old gcc (2.7.8?), and then
> you chroot into the newly-built environment and rebuild it again with the
> new gcc.

Since Hardhat there have been various places in the kernel, libc and tools
where for the sake of sanity and bugfixes we had to break the binary
compatibility.  Add the rest of bugs and you'll find probably have an
interesting even impossible job to upgrade.

Certain packages such as rpm can only sanely be upgraded by upgrading from
a binary package as any attempt to rebuild would automatically inherit
the broken settings of the installed package.  Oh and a rebuild of a
current distribution should need about 3 days of CPU or so ...

  Ralf
