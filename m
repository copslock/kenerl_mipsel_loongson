Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g647tqRw011460
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 4 Jul 2002 00:55:52 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g647tqVC011459
	for linux-mips-outgoing; Thu, 4 Jul 2002 00:55:52 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g647tiRw011449;
	Thu, 4 Jul 2002 00:55:45 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id KAA12529;
	Thu, 4 Jul 2002 10:00:14 +0200 (MET DST)
Date: Thu, 4 Jul 2002 10:00:14 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "H. J. Lu" <hjl@lucon.org>
cc: Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com,
   GNU C Library <libc-alpha@sources.redhat.com>
Subject: Re: PATCH: Always use ll/sc for mips
In-Reply-To: <20020702140451.A18214@lucon.org>
Message-ID: <Pine.GSO.3.96.1020704095117.11369B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 2 Jul 2002, H. J. Lu wrote:

> > Which means the overhead of two syscalls instead of one sysmips() call
> > for something that is assumed to be dirt cheap.  R3000, R5900 etc.
> > users won't this patch you, which'll have significant impact on their
> > glibc performance.
> 
> Not all ll/sc usages are implemented with sysmips. Does mips care about
> those? In case of libstdc++, should mips use ll/sc emulation?

 Anything external to glibc should use _test_and_set() which is a
published interface. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
