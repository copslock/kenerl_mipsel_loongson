Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f49IRlL03922
	for linux-mips-outgoing; Wed, 9 May 2001 11:27:47 -0700
Received: from dea.waldorf-gmbh.de (IDENT:root@localhost [127.0.0.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f49IRfF03906
	for <linux-mips@oss.sgi.com>; Wed, 9 May 2001 11:27:43 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f49I9Yu02151;
	Wed, 9 May 2001 15:09:34 -0300
Date: Wed, 9 May 2001 15:09:34 -0300
From: Ralf Baechle <ralf@oss.sgi.com>
To: Andreas Jaeger <aj@suse.de>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
   "Steven J. Hill" <sjhill@cotw.com>, Florian Lohoff <flo@rfc822.org>,
   Tom Appermont <tea@sonycom.com>, linux-mips@oss.sgi.com
Subject: Re: Binary compatibility break understood ?
Message-ID: <20010509150934.B2073@bacchus.dhis.org>
References: <Pine.GSO.3.96.1010509144913.2489C-100000@delta.ds2.pg.gda.pl> <ho7kzqd5kb.fsf@gee.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <ho7kzqd5kb.fsf@gee.suse.de>; from aj@suse.de on Wed, May 09, 2001 at 03:18:12PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, May 09, 2001 at 03:18:12PM +0200, Andreas Jaeger wrote:
> To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
> Cc: "Steven J. Hill" <sjhill@cotw.com>, Florian Lohoff <flo@rfc822.org>,
>         Tom Appermont <tea@sonycom.com>, Ralf Baechle <ralf@oss.sgi.com>,
>         linux-mips@oss.sgi.com
> Subject: Re: Binary compatibility break understood ?
> From: Andreas Jaeger <aj@suse.de>
> Date: 09 May 2001 15:18:12 +0200
> 
> "Maciej W. Rozycki" <macro@ds2.pg.gda.pl> writes:
> 
> > On Wed, 9 May 2001, Steven J. Hill wrote:
> > 
> > > --- glibc-2.2.3/sysdeps/mips/rtld-ldscript.in   Sat Jul 12 18:23:14 1997
> > > +++ glibc-2.2.3-patched/sysdeps/mips/rtld-ldscript.in   Sun Apr 29 22:32:35 2001
> > > @@ -1,4 +1,3 @@
> > > -OUTPUT_FORMAT("@@rtld-oformat@@")
> > >  OUTPUT_ARCH(@@rtld-arch@@)
> > >  ENTRY(@@rtld-entry@@)
> > >  SECTIONS
> > 
> >  I guess you want to remove rtld-oformat definitions from
> > sysdeps/mips/mipsel/rtld-parms and sysdeps/mips/rtld-parms as well.  They
> > become dead code after your change.
> > 
> >  Alternatively define rtld-oformat to elf(32|64)-trad(little|big)mips
> > where appropriate and require a minimal version of binutils in
> > sysdeps/unix/sysv/linux/mips/configure.in.  The requirement should be
> > forced anyway and I guess version 2.11.1 may be a good candidate once it's
> > out.
> 
> Let's test features and not version numbers if possible.  We have HJ
> Lu's binutils and the official binutils and we should be careful here
> testing for versions.

It's only modutils which for correct functionality depends on the trad-
format, so I don't see any real reason for raising version requirements
for libc.

  Ralf
