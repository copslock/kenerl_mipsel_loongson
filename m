Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0LETMN27407
	for linux-mips-outgoing; Mon, 21 Jan 2002 06:29:22 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0LETFP27404
	for <linux-mips@oss.sgi.com>; Mon, 21 Jan 2002 06:29:15 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA23804;
	Mon, 21 Jan 2002 14:27:22 +0100 (MET)
Date: Mon, 21 Jan 2002 14:27:21 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "H . J . Lu" <hjl@lucon.org>
cc: Dominic Sweetman <dom@algor.co.uk>, "Kevin D. Kissell" <kevink@mips.com>,
   Ulrich Drepper <drepper@redhat.com>,
   GNU libc alpha <libc-alpha@sources.redhat.com>, linux-mips@oss.sgi.com
Subject: Re: thread-ready ABIs
In-Reply-To: <20020119114204.A13939@lucon.org>
Message-ID: <Pine.GSO.3.96.1020121141152.22392A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, 19 Jan 2002, H . J . Lu wrote:

> But it has to be a per thread value.

 But threads run under different contexts in Linux, AFAIK.

> This is a patch against 2.4.16. Will this restore k1 to a known per
> thread value?

 It wouldn't -- k1 isn't saved.  And there are TLB exception handlers (the
most important performance issue here) that don't use framing at all --
see arch/mips/mm/tlbex-r?k.S.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
