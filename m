Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0ECm9I03459
	for linux-mips-outgoing; Mon, 14 Jan 2002 04:48:09 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0ECm5g03455
	for <linux-mips@oss.sgi.com>; Mon, 14 Jan 2002 04:48:05 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id MAA14356;
	Mon, 14 Jan 2002 12:44:29 +0100 (MET)
Date: Mon, 14 Jan 2002 12:44:29 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "H . J . Lu" <hjl@lucon.org>
cc: Robin Humble <rjh@groucho.maths.monash.edu.au>, linux-mips@oss.sgi.com
Subject: Re: libtool warning on redhat 7.1 native mipsel compile
In-Reply-To: <20020112222721.B26661@lucon.org>
Message-ID: <Pine.GSO.3.96.1020114123630.10091C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, 12 Jan 2002, H . J . Lu wrote:

> > try --rebuild on these for example: imlib, gconf, gnome-python, mozilla.
> 
> Do you have something which doesn't use X? I don't have X on my machine.
> I need a simple testcase.

 FYI, I've put mipsel-linux-XFree86-3.3.6-2.src.rpm and
mipsel-linux-XFree86*-3.3.6-2.i386.rpm cross-compilation packages at my
site recently.  Standard development libraries take only 6MB of disk space
with extra 4MB needed for additional static ones. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
