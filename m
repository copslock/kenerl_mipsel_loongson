Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1BI6tl07215
	for linux-mips-outgoing; Mon, 11 Feb 2002 10:06:55 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1BI6j907212
	for <linux-mips@oss.sgi.com>; Mon, 11 Feb 2002 10:06:48 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id SAA26492;
	Mon, 11 Feb 2002 18:06:35 +0100 (MET)
Date: Mon, 11 Feb 2002 18:06:34 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Johannes Stezenbach <js@convergence.de>
cc: Florian Lohoff <flo@rfc822.org>, linux-mips@oss.sgi.com
Subject: Re: gcc include strangeness
In-Reply-To: <20020211162844.GD2918@convergence.de>
Message-ID: <Pine.GSO.3.96.1020211174810.18917J-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 11 Feb 2002, Johannes Stezenbach wrote:

> I would certainly be interested in getting my hands on those
> patches. Do you mind if I ask why they did not go into
> gcc-2_95-branch CVS?

 RPM packages are available at my site --
"ftp://ftp.ds2.pg.gda.pl/pub/macro/".  They used to be recommended tools
for glibc 2.2 for MIPS/Linux before gcc 3.0 was released. 

 As to why they did not go into the CVS?  Well, I wasn't aware gcc 2.95.x
was maintained until after 2.95.3 was released (but patches that were
relevant either went in to 2.96 or were rejected).  And now we have 3.x.

 If 2.95.x is still maintained and you feel the patches would be useful
for inclusion, feel free to commit them.  The change log in the spec file
contains descriptions of the purpose of every patch. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
