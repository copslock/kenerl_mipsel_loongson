Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f49JR2P06791
	for linux-mips-outgoing; Wed, 9 May 2001 12:27:02 -0700
Received: from dea.waldorf-gmbh.de (IDENT:root@localhost [127.0.0.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f49JR0F06788
	for <linux-mips@oss.sgi.com>; Wed, 9 May 2001 12:27:00 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f49JOKW02599;
	Wed, 9 May 2001 16:24:20 -0300
Date: Wed, 9 May 2001 16:24:20 -0300
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Steven J. Hill" <sjhill@cotw.com>
Cc: Andreas Jaeger <aj@suse.de>, "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
   Florian Lohoff <flo@rfc822.org>, Tom Appermont <tea@sonycom.com>,
   linux-mips@oss.sgi.com
Subject: Re: Binary compatibility break understood ?
Message-ID: <20010509162420.B2466@bacchus.dhis.org>
References: <Pine.GSO.3.96.1010509144913.2489C-100000@delta.ds2.pg.gda.pl> <ho7kzqd5kb.fsf@gee.suse.de> <20010509150934.B2073@bacchus.dhis.org> <3AF997CE.E2885B9@cotw.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AF997CE.E2885B9@cotw.com>; from sjhill@cotw.com on Wed, May 09, 2001 at 02:17:34PM -0500
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, May 09, 2001 at 02:17:34PM -0500, Steven J. Hill wrote:

> > It's only modutils which for correct functionality depends on the trad-
> > format, so I don't see any real reason for raising version requirements
> > for libc.
> > 
> I can see your point...but...if we are trying fix the MIPS/Linux target
> from this point forward we should at least make people aware of what
> is going on. I propose spitting out a warning message when 'configure'
> is ran that if an older version of binutils/ld is found, then we warn
> the user that they may be unable to correctly use Linux kernel features
> or something like that. Comments?

These binutils break the kernel compilations, so we should check them as
part of kernel module compiles.

  Ralf
