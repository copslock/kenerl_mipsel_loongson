Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g15BdMx27178
	for linux-mips-outgoing; Tue, 5 Feb 2002 03:39:22 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g15BdHA27168
	for <linux-mips@oss.sgi.com>; Tue, 5 Feb 2002 03:39:18 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id MAA12048;
	Tue, 5 Feb 2002 12:37:06 +0100 (MET)
Date: Tue, 5 Feb 2002 12:37:06 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Hartvig Ekner <hartvige@mips.com>
cc: Justin Carlson <justinca@ri.cmu.edu>, Daniel Jacobowitz <dan@debian.org>,
   "H . J . Lu" <hjl@lucon.org>, Dominic Sweetman <dom@algor.co.uk>,
   GNU C Library <libc-alpha@sources.redhat.com>, linux-mips@oss.sgi.com
Subject: Re: PATCH: Fix ll/sc for mips (take 3)
In-Reply-To: <200202050839.JAA00051@copsun18.mips.com>
Message-ID: <Pine.GSO.3.96.1020205123024.9674D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 5 Feb 2002, Hartvig Ekner wrote:

> Note that the issue of a "LL" will trigger bus watching activity in the
> system logic (and maybe delays?) I would personally try to avoid issuing
> "dangling" ll's in the normal case, even though the functionality would
> be ok, and in some cases they are inavoidable.

 I'd suppose the address comparator to be active all the time, as it's the
simpler approach and involves trivial asynchronous hardware and certainly
no performance hit. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
