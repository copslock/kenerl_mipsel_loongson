Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g11D5Fg01709
	for linux-mips-outgoing; Fri, 1 Feb 2002 05:05:15 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g11D5Bd01706
	for <linux-mips@oss.sgi.com>; Fri, 1 Feb 2002 05:05:12 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA27319;
	Fri, 1 Feb 2002 13:04:24 +0100 (MET)
Date: Fri, 1 Feb 2002 13:04:23 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Dominic Sweetman <dom@algor.co.uk>
cc: Jason Gunthorpe <jgg@debian.org>, linux-mips@fnet.fr,
   linux-mips@oss.sgi.com
Subject: Re: [patch] linux 2.4.17: An mb() rework
In-Reply-To: <200202010855.IAA00394@mudchute.algor.co.uk>
Message-ID: <Pine.GSO.3.96.1020201130316.26449D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 1 Feb 2002, Dominic Sweetman wrote:

> And a plea: the word "flush" in Linux is already abused for caches
> (where it means invalidate, write back, or possibly both).  That's
> enough trouble: if you also "flush" write buffers, your confusion will
> be complete.  Maybe we should leave "flush" to plumbers and use more
> precise terminology for computers...

 Too bad the original name for the function is wbflush() already...  At
least IDT uses it in their docs. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
