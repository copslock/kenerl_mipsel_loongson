Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fARFdTM19969
	for linux-mips-outgoing; Tue, 27 Nov 2001 07:39:29 -0800
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fARFclo19964
	for <linux-mips@oss.sgi.com>; Tue, 27 Nov 2001 07:39:21 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA05429;
	Tue, 27 Nov 2001 15:33:43 +0100 (MET)
Date: Tue, 27 Nov 2001 15:33:42 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Florian Lohoff <flo@rfc822.org>
cc: debian-mips@lists.debian.org, debian-boot@lists.debian.org,
   linux-mips@oss.sgi.com
Subject: Re: failed installation debian-mipsel (Decstation 5000/150)
In-Reply-To: <20011127134930.A7022@paradigm.rfc822.org>
Message-ID: <Pine.GSO.3.96.1011127150516.440F-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 27 Nov 2001, Florian Lohoff wrote:

> The decstation fails to answer ARP requests while downloading. From
> kernel 2.2 on the arp entries expire faster which lets the tftp download
> fail somewhere in the middle.

 I see.  I haven't used TFTP on the DECstation ever.  I think the default
timeout is too low anyway.  RFC826 does not specify any timeouts but
keeping them below 2 minutes is pointless IMO.  If an interface assigned
to an IP address changes its MAC address, it will start to use the new one
for ARP requests immetiately and all caches in the LAN will have a chance
to get updated.

> It didnt - I at least let the machine wait for 15-20 Minutes while
> digging the code...

 Weird -- the read should time out after 10000 loops...  It definitely
needs to be checked. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
