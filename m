Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1FDW4E17688
	for linux-mips-outgoing; Fri, 15 Feb 2002 05:32:04 -0800
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1FDVd917684;
	Fri, 15 Feb 2002 05:31:40 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA01735;
	Fri, 15 Feb 2002 13:31:44 +0100 (MET)
Date: Fri, 15 Feb 2002 13:31:43 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: "Kevin D. Kissell" <kevink@mips.com>,
   Atsushi Nemoto <nemoto@toshiba-tops.co.jp>, mdharm@momenco.com,
   linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: [patch] linux 2.4.17: The second mb() rework (final)
In-Reply-To: <20020215115006.B26756@dea.linux-mips.net>
Message-ID: <Pine.GSO.3.96.1020215131151.29773D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 15 Feb 2002, Ralf Baechle wrote:

> In practice sync just isn't good enough.  Most systems these days use
> an I/O bus like PCI which uses posted writes or have some other
> non-strongly ordered memory model.  Which is why something wmb() or
> mb() aren't good enough in driver.  I'm just having a nice discussion

 It depends on what a driver needs.  They are perfectly sufficient and
actually needed for host bus devices if you need to be sure writes and/or
reads happen in order.  It's only when a side-effect of a write needs to
happen immediately a write-back flush is needed.  It doesn't happen that
often. 

 AFAIK, PCI only allows posted writes -- it doesn't allow write or read
reordering, so mb() and friends are sufficient.  Are there any busses we
support or are going to in foreseeable future that have a weak ordering
model?

> about this topic with SGI's IA64 people; we have to come up with a
> portable and efficient ABI.

 ABI?  API, I suppose.  I can't see anything special here -- drivers
already know the bus they are on and they know if it needs any specific
handling.  I don't think it's possibly to define general functions for I/O
buses as actions depend on the device that's being addressed.  E.g. for a
PCI device a driver needs to perform a read from one of the device's
assigned regions and which location exactly, depends on what memory or
registers the device implements (surely it can't read one that implies
side effects).  It can't just do an arbitrary read from a location decoded
to the bus. 

 Anyway, will my patch get applied or do we have to wait until the
discussion concludes?  The patch doesn't affect any I/O bus-specific
operations, so it's orthogonal.  Also a new API is surely a 2.5 item.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
