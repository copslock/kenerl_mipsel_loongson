Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6UK4Sn11353
	for linux-mips-outgoing; Mon, 30 Jul 2001 13:04:28 -0700
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6UK4QV11347
	for <linux-mips@oss.sgi.com>; Mon, 30 Jul 2001 13:04:26 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id WAA20090;
	Mon, 30 Jul 2001 22:06:45 +0200 (MET DST)
Date: Mon, 30 Jul 2001 22:06:45 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Dave Airlie <airlied@csn.ul.ie>
cc: Jan-Benedict Glaw <jbglaw@lug-owl.de>,
   SGI MIPS list <linux-mips@oss.sgi.com>,
   Debian MIPS list <debian-mips@lists.debian.org>, engel@unix-ag.org
Subject: Re: [long] Lance on DS5k/200
In-Reply-To: <Pine.LNX.4.32.0107291413510.11630-100000@skynet>
Message-ID: <Pine.GSO.3.96.1010730220512.19618B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, 29 Jul 2001, Dave Airlie wrote:

> You really should read around before hacking :-)
> 
> http://www.skynet.ie/~airlied/mips/declance_2_3_48.c
> 
> is the declance driver for the DS5000/200, I'm not sure it still works but
> it did the last time I looked at it .. the declance.c in the same dir is
> for 2.2 kernel.. I must rename them someday..

 How about merging it into official sources?  This way your work won't get
lost and others won't try to reinvent the wheel.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
