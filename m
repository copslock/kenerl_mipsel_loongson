Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g12C6kx02652
	for linux-mips-outgoing; Sat, 2 Feb 2002 04:06:46 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g12C6fd02648
	for <linux-mips@oss.sgi.com>; Sat, 2 Feb 2002 04:06:42 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id MAA22923;
	Sat, 2 Feb 2002 12:06:07 +0100 (MET)
Date: Sat, 2 Feb 2002 12:06:07 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "H . J . Lu" <hjl@lucon.org>
cc: Hiroyuki Machida <machida@sm.sony.co.jp>, libc-alpha@sources.redhat.com,
   linux-mips@oss.sgi.com
Subject: Re: PATCH: Fix ll/sc for mips
In-Reply-To: <20020201144727.A15521@lucon.org>
Message-ID: <Pine.GSO.3.96.1020202120535.22822A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 1 Feb 2002, H . J . Lu wrote:

> >  Please do indent instructions in branch delay slots like it's done in
> > other code (and here originally as well).  It much improves the perception
> > of what exactly is going on. 
> 
> Like this?

 Exactly.  Thanks.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
