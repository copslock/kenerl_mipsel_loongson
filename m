Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f34CUVO15155
	for linux-mips-outgoing; Wed, 4 Apr 2001 05:30:31 -0700
Received: from dea.waldorf-gmbh.de (u-113-19.karlsruhe.ipdial.viaginterkom.de [62.180.19.113])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f34CUTM15149
	for <linux-mips@oss.sgi.com>; Wed, 4 Apr 2001 05:30:29 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f34CToM04260;
	Wed, 4 Apr 2001 14:29:50 +0200
Date: Wed, 4 Apr 2001 14:29:50 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Florian Lohoff <flo@rfc822.org>, "Kevin D. Kissell" <kevink@mips.com>,
   "MIPS/Linux List (SGI)" <linux-mips@oss.sgi.com>
Subject: Re: Dumb Question on Cross-Development
Message-ID: <20010404142950.A4214@bacchus.dhis.org>
References: <20010403171005.A31953@bacchus.dhis.org> <Pine.GSO.3.96.1010404134018.6521B-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1010404134018.6521B-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Wed, Apr 04, 2001 at 02:06:22PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Apr 04, 2001 at 02:06:22PM +0200, Maciej W. Rozycki wrote:
> Date: Wed, 4 Apr 2001 14:06:22 +0200 (MET DST)
> From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
> To: Ralf Baechle <ralf@oss.sgi.com>
> cc: Florian Lohoff <flo@rfc822.org>, "Kevin D. Kissell" <kevink@mips.com>,
>         "MIPS/Linux List (SGI)" <linux-mips@oss.sgi.com>
> Subject: Re: Dumb Question on Cross-Development
> 
> On Tue, 3 Apr 2001, Ralf Baechle wrote:
> 
> > Brokeness starts with autoconf's AC_CHECK_SIZEOF macro implementation
> > which is used frequently throughout a whole distribution and there are
> > so many test that require actually execution of code on the target that
> > fix a whole distribution for crosscompilation and keeping it uptodate
> > is seriously double-plus un-fun.
> 
>  Well, I can't see any other way to check sizeof of a type.  OTOH, I
> haven't seen many programs that call AC_CHECK_SIZEOF on unions or structs
> -- that's where the real problem might be as predicting member alignment
> is not always easy (especially for "evil" objects -- but if such ones
> exist the actual problem is a badly written program begging for a
> rewrite).  There is no need to check sizeof for simple types -- ISO C
> <stdint.h> types might be used if a desired number of bits in a type is
> needed with a fallback to AC_CHECK_SIZEOF for legacy hosts only (which we
> don't care that much of).  In short, the macro shouldn't really be used in
> most cases. 
> 
>  I sustain the problem does not lie in the tool but in its usage.

stdint.h isn't available everywhere.  Aside of that I won't object ...

  Ralf
