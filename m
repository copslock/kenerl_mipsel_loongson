Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6H8PuRw023559
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 17 Jul 2002 01:25:56 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6H8PurC023557
	for linux-mips-outgoing; Wed, 17 Jul 2002 01:25:56 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6H8PnRw023525
	for <linux-mips@oss.sgi.com>; Wed, 17 Jul 2002 01:25:50 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id KAA14437;
	Wed, 17 Jul 2002 10:31:13 +0200 (MET DST)
Date: Wed, 17 Jul 2002 10:31:13 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "H. J. Lu" <hjl@lucon.org>
cc: Ulrich Drepper <drepper@redhat.com>, linux-mips@oss.sgi.com,
   GNU C Library <libc-alpha@sources.redhat.com>
Subject: Re: PATCH: Always use ll/sc for mips
In-Reply-To: <20020716084208.A21699@lucon.org>
Message-ID: <Pine.GSO.3.96.1020717095946.13355C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 16 Jul 2002, H. J. Lu wrote:

> >  It sucks performance-wise with no visible gain, so I don't think it is
> > really desireable.  Since the no-ll/sc case is handled correctly, I see no
> 
> Only <sys/tas.h> is covered by the kernel interface. But it doesn't
> cover atomicity.h in glibc and libstdc++.

 Even if nobody bothered fixing these, that doesn't mean some other code
is useless.  If you don't want to implement these with _test_and_set(),
then just put equivalent ll/sc code there, which will work thanks to the
emulation.  Depending on the operation it may even be faster than
_test_and_set() as ll/sc provides a generic way to perform atomic
operations, while using _test_and_set() might require a spinlock. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
