Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g11CkDj01132
	for linux-mips-outgoing; Fri, 1 Feb 2002 04:46:13 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g11Ck7d01129
	for <linux-mips@oss.sgi.com>; Fri, 1 Feb 2002 04:46:08 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id MAA26518;
	Fri, 1 Feb 2002 12:45:02 +0100 (MET)
Date: Fri, 1 Feb 2002 12:45:02 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "H . J . Lu" <hjl@lucon.org>
cc: Hiroyuki Machida <machida@sm.sony.co.jp>, libc-alpha@sources.redhat.com,
   linux-mips@oss.sgi.com
Subject: Re: PATCH: Fix ll/sc for mips
In-Reply-To: <20020131231714.E32690@lucon.org>
Message-ID: <Pine.GSO.3.96.1020201124328.26449A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 31 Jan 2002, H . J . Lu wrote:

> > Gas will fill delay slots. Same object codes will be produced, so I
> > think you don't have to do that by hand. 
> 
> It will make the code more readable. We don't have to guess what
> the assembler will do. 

 But you lose a chance for something useful being reordered to the slot.
That might not necessarily be a "nop".  Please don't forget of indents
anyway.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
