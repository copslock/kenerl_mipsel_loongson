Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6GFHLRw032613
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 16 Jul 2002 08:17:21 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6GFHLt7032612
	for linux-mips-outgoing; Tue, 16 Jul 2002 08:17:21 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6GFHFRw032600
	for <linux-mips@oss.sgi.com>; Tue, 16 Jul 2002 08:17:16 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id RAA29152;
	Tue, 16 Jul 2002 17:22:36 +0200 (MET DST)
Date: Tue, 16 Jul 2002 17:22:36 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ulrich Drepper <drepper@redhat.com>
cc: "H. J. Lu" <hjl@lucon.org>, linux-mips@oss.sgi.com,
   GNU C Library <libc-alpha@sources.redhat.com>
Subject: Re: PATCH: Always use ll/sc for mips
In-Reply-To: <1026781165.3673.11.camel@myware.mynet>
Message-ID: <Pine.GSO.3.96.1020716171505.20654S-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On 15 Jul 2002, Ulrich Drepper wrote:

> > The ll/sc emulation is implemented in 2.4.0 and above. This patch makes
> > glibc always use ll/sc.
> 
> Since I haven't seen any objections I've checked this patch in.

 [I must have missed the original mail, sorry.]

 It sucks performance-wise with no visible gain, so I don't think it is
really desireable.  Since the no-ll/sc case is handled correctly, I see no
reason to remove the code.  The kernel interface is awkward, I admit, but
it works (and is even handcoded in assembly for performance gain) and we
may able to develop a better one eventually.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
