Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f34C6ZC13729
	for linux-mips-outgoing; Wed, 4 Apr 2001 05:06:35 -0700
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f34C6EM13712;
	Wed, 4 Apr 2001 05:06:15 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA14077;
	Wed, 4 Apr 2001 14:06:23 +0200 (MET DST)
Date: Wed, 4 Apr 2001 14:06:22 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: Florian Lohoff <flo@rfc822.org>, "Kevin D. Kissell" <kevink@mips.com>,
   "MIPS/Linux List (SGI)" <linux-mips@oss.sgi.com>
Subject: Re: Dumb Question on Cross-Development
In-Reply-To: <20010403171005.A31953@bacchus.dhis.org>
Message-ID: <Pine.GSO.3.96.1010404134018.6521B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 3 Apr 2001, Ralf Baechle wrote:

> Brokeness starts with autoconf's AC_CHECK_SIZEOF macro implementation
> which is used frequently throughout a whole distribution and there are
> so many test that require actually execution of code on the target that
> fix a whole distribution for crosscompilation and keeping it uptodate
> is seriously double-plus un-fun.

 Well, I can't see any other way to check sizeof of a type.  OTOH, I
haven't seen many programs that call AC_CHECK_SIZEOF on unions or structs
-- that's where the real problem might be as predicting member alignment
is not always easy (especially for "evil" objects -- but if such ones
exist the actual problem is a badly written program begging for a
rewrite).  There is no need to check sizeof for simple types -- ISO C
<stdint.h> types might be used if a desired number of bits in a type is
needed with a fallback to AC_CHECK_SIZEOF for legacy hosts only (which we
don't care that much of).  In short, the macro shouldn't really be used in
most cases. 

 I sustain the problem does not lie in the tool but in its usage.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
