Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1FKdNY07888
	for linux-mips-outgoing; Fri, 15 Feb 2002 12:39:23 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1FKdG907883
	for <linux-mips@oss.sgi.com>; Fri, 15 Feb 2002 12:39:17 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id UAA14500;
	Fri, 15 Feb 2002 20:39:11 +0100 (MET)
Date: Fri, 15 Feb 2002 20:39:09 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jason Gunthorpe <jgg@debian.org>
cc: "Kevin D. Kissell" <kevink@mips.com>, linux-mips@fnet.fr,
   linux-mips@oss.sgi.com
Subject: Re: [patch] linux 2.4.17: The second mb() rework (final)
In-Reply-To: <Pine.LNX.3.96.1020215104857.10921A-100000@wakko.debian.net>
Message-ID: <Pine.GSO.3.96.1020215203113.29773Q-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 15 Feb 2002, Jason Gunthorpe wrote:

> Sorry, why? If the TX39 is the only processor in the system then write
> buffers can be left alone. You can't consider PCI IO devices to be

 That depends on the implementation of the buffers.

> processors because the bus protocols would never allow you to satisfy the
> requirements for 'sync'.

 Fully agreed -- I've already expressed that in another mail.

> IMHO the only time *mb should care about a write buffer is if the buffer
> breaks PCI ordering semantics, by, say returning reads from posted write
> data, re-ordering, etc.

 Well, the "classic" MIPS R2020 and R3220 ones would break PCI (or
actually any I/O) ordering semantics as they return data from a posted
write upon a hit.  The affected read never appears at the I/O bus in that
case.  They never reorder writes though, as they work as FIFOs (the former
is four stage deep and the latter is six stage deep), so wmb() may be null
for them.

 I've read a suggestion a "bc0f" might be needed for the TX39's write
buffer as a barrier.  That means the buffer behaves as the "classic" ones. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
