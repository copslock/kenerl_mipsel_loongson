Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f49JJed06367
	for linux-mips-outgoing; Wed, 9 May 2001 12:19:40 -0700
Received: from dea.waldorf-gmbh.de (IDENT:root@localhost [127.0.0.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f49JJZF06362
	for <linux-mips@oss.sgi.com>; Wed, 9 May 2001 12:19:36 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f49JGsF02554;
	Wed, 9 May 2001 16:16:54 -0300
Date: Wed, 9 May 2001 16:16:54 -0300
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Andreas Jaeger <aj@suse.de>, "Steven J. Hill" <sjhill@cotw.com>,
   Florian Lohoff <flo@rfc822.org>, Tom Appermont <tea@sonycom.com>,
   linux-mips@oss.sgi.com
Subject: Re: Binary compatibility break understood ?
Message-ID: <20010509161654.A2466@bacchus.dhis.org>
References: <20010509150934.B2073@bacchus.dhis.org> <Pine.GSO.3.96.1010509204803.22796A-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1010509204803.22796A-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Wed, May 09, 2001 at 08:59:34PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, May 09, 2001 at 08:59:34PM +0200, Maciej W. Rozycki wrote:

> > format, so I don't see any real reason for raising version requirements
> > for libc.
> 
>  That would be needed if elf(32|64)-trad(little|big)mips was specified
> explicitly as rtld-oformat in sysdeps/mips/mipsel/rtld-parms and
> sysdeps/mips/rtld-parms.
> 
>  Note that libc doesn't require any version of binutils at all now. 
> This is probably bad as using pre-2.11 versions of binutils may yield
> weird results. 

Seems like only certain version are affected; the more or less randomly
choosen one I use for the RH 7 port seems to work quite well so far.  What
bug is that?

  Ralf
