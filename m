Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1FCw0Y16881
	for linux-mips-outgoing; Fri, 15 Feb 2002 04:58:00 -0800
Received: from oval.algor.co.uk (root@oval.algor.co.uk [62.254.210.250])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1FCvu916878
	for <linux-mips@oss.sgi.com>; Fri, 15 Feb 2002 04:57:57 -0800
Received: from mudchute.algor.co.uk (dom@mudchute.algor.co.uk [62.254.210.251])
	by oval.algor.co.uk (8.11.6/8.10.1) with ESMTP id g1FBv5402720;
	Fri, 15 Feb 2002 11:57:05 GMT
Received: (from dom@localhost)
	by mudchute.algor.co.uk (8.8.5/8.8.5) id LAA17485;
	Fri, 15 Feb 2002 11:56:59 GMT
Date: Fri, 15 Feb 2002 11:56:59 GMT
Message-Id: <200202151156.LAA17485@mudchute.algor.co.uk>
From: Dominic Sweetman <dom@algor.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: "Atsushi Nemoto" <nemoto@toshiba-tops.co.jp>, <macro@ds2.pg.gda.pl>,
   <mdharm@momenco.com>, <ralf@uni-koblenz.de>, <linux-mips@fnet.fr>,
   <linux-mips@oss.sgi.com>
Subject: Re: [patch] linux 2.4.17: The second mb() rework (final)
In-Reply-To: <006e01c1b606$27b1b060$0deca8c0@Ulysses>
References: <Pine.GSO.3.96.1020212123901.17858B-100000@delta.ds2.pg.gda.pl>
	<010601c1b3bd$1da618e0$0deca8c0@Ulysses>
	<20020213.102805.74755945.nemoto@toshiba-tops.co.jp>
	<20020215.123124.70226832.nemoto@toshiba-tops.co.jp>
	<006e01c1b606$27b1b060$0deca8c0@Ulysses>
X-Mailer: VM 6.34 under 19.16 "Lille" XEmacs Lucid
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Kevin D. Kissell (kevink@mips.com) writes:

> > Note that SYNC on TX39/H and TX39/H2 does not flush a write buffer.
> > Some operation (for example, bc0f loop) are required to flush a write
> > buffer.
> 
> That is, I would say, a bug in the TX39 implementation of SYNC.

That's only a problem if the CPU permitted reads to overtake buffered
writes.  [Early R3000 write buffers did that (with an address check to
avoid the disaster of allowing a read to overtake a write to the same
location).]

But my recollection is that the TX39 does all memory operations in
order: so SYNC has very little to do, but it isn't a bug.

Dominic Sweetman
Algorithmics
