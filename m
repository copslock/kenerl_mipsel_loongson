Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Oct 2002 19:07:11 +0200 (CEST)
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:64238 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S1123253AbSJYRHK>; Fri, 25 Oct 2002 19:07:10 +0200
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id TAA02561;
	Fri, 25 Oct 2002 19:06:51 +0200 (MET DST)
Date: Fri, 25 Oct 2002 19:06:50 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Steven J. Hill" <sjhill@realitydiluted.com>
cc: Daniel Jacobowitz <dan@debian.org>, linux-mips@linux-mips.org,
	binutils@sources.redhat.com
Subject: Re: Problems generating shared library for MIPS using binutils-2.13...
In-Reply-To: <3DB97744.2010707@realitydiluted.com>
Message-ID: <Pine.GSO.3.96.1021025185639.1121A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 511
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Fri, 25 Oct 2002, Steven J. Hill wrote:

> > Is every object or library mentioned on that line already marked as
> > MIPS-2 by readelf?  Even crt*, libc*?
> >
> I knew I was being stupid, crt* and libc* are mips1 *sigh*. Looks
> like I have more work to do for my build system. Below is the verbose
> output, but I think that's the problem for sure.

 Hmm, that's strange as a single mips2 object among mips1 ones should make
an executable/shared library be marked as mips2 and not mips1.  I wouldn't
worry in the long run, though, as I think this should be fixed in the
trunk as Richard Sandiford was working in these areas recently.  You might
want to do a verification to be sure, though. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
