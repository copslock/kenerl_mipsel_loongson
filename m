Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fARHuoM26408
	for linux-mips-outgoing; Tue, 27 Nov 2001 09:56:50 -0800
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fARHuho26405
	for <linux-mips@oss.sgi.com>; Tue, 27 Nov 2001 09:56:44 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id RAA10679;
	Tue, 27 Nov 2001 17:55:01 +0100 (MET)
Date: Tue, 27 Nov 2001 17:55:00 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Florian Lohoff <flo@rfc822.org>
cc: debian-mips@lists.debian.org, debian-boot@lists.debian.org,
   linux-mips@oss.sgi.com
Subject: Re: failed installation debian-mipsel (Decstation 5000/150)
In-Reply-To: <20011127163854.D9282@paradigm.rfc822.org>
Message-ID: <Pine.GSO.3.96.1011127175326.440J-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 27 Nov 2001, Florian Lohoff wrote:

> >  I see.  I haven't used TFTP on the DECstation ever.  I think the default
> > timeout is too low anyway.  RFC826 does not specify any timeouts but
> > keeping them below 2 minutes is pointless IMO.  If an interface assigned
> > to an IP address changes its MAC address, it will start to use the new one
> > for ARP requests immetiately and all caches in the LAN will have a chance
> > to get updated.
> 
> IIRC the kernel refreshes the timeout on communication - But only on
> TCP not UDP ...

 Weird.

> >  Weird -- the read should time out after 10000 loops...  It definitely
> > needs to be checked. 
> 
> Did this change lately - The kernel of the boot-floppies is a little
> old.

 I don't think so.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
