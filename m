Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f34DdLI17487
	for linux-mips-outgoing; Wed, 4 Apr 2001 06:39:21 -0700
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f34DdDM17479;
	Wed, 4 Apr 2001 06:39:13 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA17292;
	Wed, 4 Apr 2001 15:39:42 +0200 (MET DST)
Date: Wed, 4 Apr 2001 15:39:42 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: Florian Lohoff <flo@rfc822.org>, "Kevin D. Kissell" <kevink@mips.com>,
   "MIPS/Linux List (SGI)" <linux-mips@oss.sgi.com>
Subject: Re: Dumb Question on Cross-Development
In-Reply-To: <20010404142950.A4214@bacchus.dhis.org>
Message-ID: <Pine.GSO.3.96.1010404153012.6521E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 4 Apr 2001, Ralf Baechle wrote:

> stdint.h isn't available everywhere.  Aside of that I won't object ...

 That's why I wrote of legacy hosts.  The AC_CHECK_HEADERS and
AC_CHECK_TYPE macros are cross-compilation-safe and they are all that
modern hosts need.  For other hosts AC_CHECK_SIZEOF might be used to find
generic types suitable for ISO C definitions, which might be problematic
for cross-compilation, though.  Still this applies to non-gcc
cross-compilers only, which are not that common, AFAIK.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
