Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f49Jq5T07774
	for linux-mips-outgoing; Wed, 9 May 2001 12:52:05 -0700
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f49JgpF07675;
	Wed, 9 May 2001 12:42:52 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id VAA25097;
	Wed, 9 May 2001 21:43:16 +0200 (MET DST)
Date: Wed, 9 May 2001 21:43:16 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: Andreas Jaeger <aj@suse.de>, "Steven J. Hill" <sjhill@cotw.com>,
   Florian Lohoff <flo@rfc822.org>, Tom Appermont <tea@sonycom.com>,
   linux-mips@oss.sgi.com
Subject: Re: Binary compatibility break understood ?
In-Reply-To: <20010509161654.A2466@bacchus.dhis.org>
Message-ID: <Pine.GSO.3.96.1010509213106.24235A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 9 May 2001, Ralf Baechle wrote:

> >  Note that libc doesn't require any version of binutils at all now. 
> > This is probably bad as using pre-2.11 versions of binutils may yield
> > weird results. 
> 
> Seems like only certain version are affected; the more or less randomly
> choosen one I use for the RH 7 port seems to work quite well so far.  What
> bug is that?

 Do you state you are able to build glibc 2.2 for MIPS/Linux using
binutils 2.9 or 2.8 or earlier???  Even 2.10 (2.10.1) doesn't work as
released, AFAIK, mostly due to unfinished versioning support for MIPS.
There are other, less significant problems as well, IIRC.  Relevant
patches got applied in the 2.10.90 development cycle, AFAIK. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
