Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f33I46S12892
	for linux-mips-outgoing; Tue, 3 Apr 2001 11:04:06 -0700
Received: from dea.waldorf-gmbh.de (u-231-18.karlsruhe.ipdial.viaginterkom.de [62.180.18.231])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f33I43M12881
	for <linux-mips@oss.sgi.com>; Tue, 3 Apr 2001 11:04:03 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f33FA5x32168;
	Tue, 3 Apr 2001 17:10:05 +0200
Date: Tue, 3 Apr 2001 17:10:05 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Florian Lohoff <flo@rfc822.org>, "Kevin D. Kissell" <kevink@mips.com>,
   "MIPS/Linux List (SGI)" <linux-mips@oss.sgi.com>
Subject: Re: Dumb Question on Cross-Development
Message-ID: <20010403171005.A31953@bacchus.dhis.org>
References: <20010402234850.B25228@paradigm.rfc822.org> <Pine.GSO.3.96.1010403112218.25523B-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1010403112218.25523B-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Tue, Apr 03, 2001 at 11:26:11AM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Apr 03, 2001 at 11:26:11AM +0200, Maciej W. Rozycki wrote:

> > Cross-compilation is IMHO so broken when it comes to userspace
> > than noone really thinking of having something reusable would
> > consider this. It all ends beeing a really ugly hack.
> 
>  I disagree.  It's not that userland cross-compilation is broken.  It's
> just the matter of certain programmers who do not care to write
> scripts/Makefiles to support cross-development portably.  They might even
> not realize there exists such a feature as cross-compilation. 

Brokeness starts with autoconf's AC_CHECK_SIZEOF macro implementation
which is used frequently throughout a whole distribution and there are
so many test that require actually execution of code on the target that
fix a whole distribution for crosscompilation and keeping it uptodate
is seriously double-plus un-fun.

  Ralf
