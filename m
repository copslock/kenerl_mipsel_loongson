Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1FDAYY17404
	for linux-mips-outgoing; Fri, 15 Feb 2002 05:10:34 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1FDAN917400
	for <linux-mips@oss.sgi.com>; Fri, 15 Feb 2002 05:10:24 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA00974;
	Fri, 15 Feb 2002 13:08:21 +0100 (MET)
Date: Fri, 15 Feb 2002 13:08:20 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
cc: kevink@mips.com, mdharm@momenco.com, ralf@uni-koblenz.de,
   linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: [patch] linux 2.4.17: The second mb() rework (final)
In-Reply-To: <20020215.123124.70226832.nemoto@toshiba-tops.co.jp>
Message-ID: <Pine.GSO.3.96.1020215125744.29773B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 15 Feb 2002, Atsushi Nemoto wrote:

> Note that SYNC on TX39/H and TX39/H2 does not flush a write buffer.

 That's perfectly fine -- it does not need to.  It's only a
synchronization point.

> Some operation (for example, bc0f loop) are required to flush a write
> buffer.

 This is bad, though.  No extra operations must be needed.  After a "sync" 
the buffer should be written back as soon as not doing so would be visible
externally.  IOW, two consecutive writes separated by a "sync" need not
imply a write-back, but as soon as a read happens a preceding write-back
is a must.

 It sounds weird: it looks like "sync" is useless and basically a "nop". 
If this is the case the processors need their own wbflush()
implementation.  Can you point to specific chapters of specifications that
document it?

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
