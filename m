Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4A2Frd17880
	for linux-mips-outgoing; Wed, 9 May 2001 19:15:53 -0700
Received: from dea.waldorf-gmbh.de (IDENT:root@localhost [127.0.0.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4A2FkF17877
	for <linux-mips@oss.sgi.com>; Wed, 9 May 2001 19:15:48 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f4A2BDv02481;
	Wed, 9 May 2001 23:11:13 -0300
Date: Wed, 9 May 2001 23:11:13 -0300
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Andreas Jaeger <aj@suse.de>, "Steven J. Hill" <sjhill@cotw.com>,
   Florian Lohoff <flo@rfc822.org>, Tom Appermont <tea@sonycom.com>,
   linux-mips@oss.sgi.com
Subject: Re: Binary compatibility break understood ?
Message-ID: <20010509231112.B2456@bacchus.dhis.org>
References: <20010509161654.A2466@bacchus.dhis.org> <Pine.GSO.3.96.1010509213106.24235A-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1010509213106.24235A-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Wed, May 09, 2001 at 09:43:16PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, May 09, 2001 at 09:43:16PM +0200, Maciej W. Rozycki wrote:

> > Seems like only certain version are affected; the more or less randomly
> > choosen one I use for the RH 7 port seems to work quite well so far.  What
> > bug is that?
> 
>  Do you state you are able to build glibc 2.2 for MIPS/Linux using
> binutils 2.9 or 2.8 or earlier???  Even 2.10 (2.10.1) doesn't work as
> released, AFAIK, mostly due to unfinished versioning support for MIPS.
> There are other, less significant problems as well, IIRC.  Relevant
> patches got applied in the 2.10.90 development cycle, AFAIK. 

Sorry, I wasn't thinking that somebody might consider using such pre-historic
versions but unfortunately you're right.

  Ralf
