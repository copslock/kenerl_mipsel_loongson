Received:  by oss.sgi.com id <S553852AbQKCSba>;
	Fri, 3 Nov 2000 10:31:30 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:5322 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553833AbQKCSbJ>;
	Fri, 3 Nov 2000 10:31:09 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id TAA27731;
	Fri, 3 Nov 2000 19:27:02 +0100 (MET)
Date:   Fri, 3 Nov 2000 19:27:01 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Keith M Wesolowski <wesolows@chem.unr.edu>
cc:     Ian Chilton <mailinglist@ichilton.co.uk>, linux-mips@oss.sgi.com
Subject: Re: More GCC problems
In-Reply-To: <20001103100728.A8133@chem.unr.edu>
Message-ID: <Pine.GSO.3.96.1001103191640.25680C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, 3 Nov 2000, Keith M Wesolowski wrote:

> I have no idea how to build a static compiler. The approach I took to

 Just add "-static" to CFLAGS in the usual way.

> get my working native 1019 compiler was to cross-build it with the
> same version. Since it was built against glibc 2.2, I simply installed
> both glibc 2.2 and the new native compiler on my system.

 But check the "cross_compile" statement in the gcc's specs file. 
Depending on the way of installing a cross-compiled native compiler on the
host machine you may get it right or not -- it should be "0".  I had to
tweak it manually when making an RPM package of gcc-2.95.3 (packages
available from ftp://ftp.ds2.pg.gda.pl/pub/macro).

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
