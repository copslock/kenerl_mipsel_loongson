Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1FE1UN18235
	for linux-mips-outgoing; Fri, 15 Feb 2002 06:01:30 -0800
Received: from sgi.com (sgi-too.SGI.COM [204.94.211.39])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1FE1Q918232
	for <linux-mips@oss.sgi.com>; Fri, 15 Feb 2002 06:01:26 -0800
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id FAA07078
	for <linux-mips@oss.sgi.com>; Fri, 15 Feb 2002 05:01:21 -0800 (PST)
	mail_from (macro@ds2.pg.gda.pl)
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA02328;
	Fri, 15 Feb 2002 13:53:51 +0100 (MET)
Date: Fri, 15 Feb 2002 13:53:50 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Dominic Sweetman <dom@algor.co.uk>
cc: "Kevin D. Kissell" <kevink@mips.com>,
   Atsushi Nemoto <nemoto@toshiba-tops.co.jp>, mdharm@momenco.com,
   ralf@uni-koblenz.de, linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: [patch] linux 2.4.17: The second mb() rework (final)
In-Reply-To: <200202151156.LAA17485@mudchute.algor.co.uk>
Message-ID: <Pine.GSO.3.96.1020215133207.29773E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 15 Feb 2002, Dominic Sweetman wrote:

> That's only a problem if the CPU permitted reads to overtake buffered
> writes.  [Early R3000 write buffers did that (with an address check to
> avoid the disaster of allowing a read to overtake a write to the same
> location).]

 The R2020 and the R3220 write buffers that are used in older DECstations
seem to provide buffered values themselves if hit by a read.  This way
they are completely safe for ordinary memory references and there is no
need to stall for a write-back completion for memory operations.  At least
this is what DECstation specifications imply -- it seems hard to get to
original docs for the chips these days.

 For I/O resources implying side effects a stall is needed, of course. 

 The way the chips work is not that uncommon -- e.g. Intel's i486 does
exactly the same.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
