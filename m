Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f49DIOY24958
	for linux-mips-outgoing; Wed, 9 May 2001 06:18:24 -0700
Received: from Cantor.suse.de (ns.suse.de [213.95.15.193])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f49DIEF24953;
	Wed, 9 May 2001 06:18:14 -0700
Received: from Hermes.suse.de (Hermes.suse.de [213.95.15.136])
	by Cantor.suse.de (Postfix) with ESMTP
	id 573241E26B; Wed,  9 May 2001 15:18:13 +0200 (MEST)
X-Authentication-Warning: gee.suse.de: aj set sender to aj@suse.de using -f
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: "Steven J. Hill" <sjhill@cotw.com>, Florian Lohoff <flo@rfc822.org>,
   Tom Appermont <tea@sonycom.com>, Ralf Baechle <ralf@oss.sgi.com>,
   linux-mips@oss.sgi.com
Subject: Re: Binary compatibility break understood ?
References: <Pine.GSO.3.96.1010509144913.2489C-100000@delta.ds2.pg.gda.pl>
From: Andreas Jaeger <aj@suse.de>
Date: 09 May 2001 15:18:12 +0200
In-Reply-To: <Pine.GSO.3.96.1010509144913.2489C-100000@delta.ds2.pg.gda.pl> ("Maciej W. Rozycki"'s message of "Wed, 9 May 2001 15:07:59 +0200 (MET DST)")
Message-ID: <ho7kzqd5kb.fsf@gee.suse.de>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"Maciej W. Rozycki" <macro@ds2.pg.gda.pl> writes:

> On Wed, 9 May 2001, Steven J. Hill wrote:
> 
> > --- glibc-2.2.3/sysdeps/mips/rtld-ldscript.in   Sat Jul 12 18:23:14 1997
> > +++ glibc-2.2.3-patched/sysdeps/mips/rtld-ldscript.in   Sun Apr 29 22:32:35 2001
> > @@ -1,4 +1,3 @@
> > -OUTPUT_FORMAT("@@rtld-oformat@@")
> >  OUTPUT_ARCH(@@rtld-arch@@)
> >  ENTRY(@@rtld-entry@@)
> >  SECTIONS
> 
>  I guess you want to remove rtld-oformat definitions from
> sysdeps/mips/mipsel/rtld-parms and sysdeps/mips/rtld-parms as well.  They
> become dead code after your change.
> 
>  Alternatively define rtld-oformat to elf(32|64)-trad(little|big)mips
> where appropriate and require a minimal version of binutils in
> sysdeps/unix/sysv/linux/mips/configure.in.  The requirement should be
> forced anyway and I guess version 2.11.1 may be a good candidate once it's
> out.

Let's test features and not version numbers if possible.  We have HJ
Lu's binutils and the official binutils and we should be careful here
testing for versions.

Andreas
-- 
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
    http://www.suse.de/~aj
