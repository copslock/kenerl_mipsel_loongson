Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4V89dm01666
	for linux-mips-outgoing; Thu, 31 May 2001 01:09:39 -0700
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f4V89ah01662
	for <linux-mips@oss.sgi.com>; Thu, 31 May 2001 01:09:36 -0700
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id BAA04756
	for <linux-mips@oss.sgi.com>; Thu, 31 May 2001 01:09:02 -0700 (PDT)
	mail_from (macro@ds2.pg.gda.pl)
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id JAA12055;
	Thu, 31 May 2001 09:39:40 +0200 (MET DST)
Date: Thu, 31 May 2001 09:39:40 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jun Sun <jsun@mvista.com>
cc: "Kevin D. Kissell" <kevink@mips.com>, linux-mips@oss.sgi.com
Subject: Re: MIPS_ATOMIC_SET again (Re: newest kernel
In-Reply-To: <3B1533EB.924ACA05@mvista.com>
Message-ID: <Pine.GSO.3.96.1010531093713.11865A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 30 May 2001, Jun Sun wrote:

> I don't think "extern" changes the picture here because once the call is
> inlined the code will bypass libsys - unless my previous understanding is
> wrong.

 Yes, it does.  If you insist on not inlining it -- you can do it.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
