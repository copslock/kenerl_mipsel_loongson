Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fARDjmF17043
	for linux-mips-outgoing; Tue, 27 Nov 2001 05:45:48 -0800
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fARDjLo17025
	for <linux-mips@oss.sgi.com>; Tue, 27 Nov 2001 05:45:36 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA02357;
	Tue, 27 Nov 2001 13:43:11 +0100 (MET)
Date: Tue, 27 Nov 2001 13:43:10 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Florian Lohoff <flo@rfc822.org>
cc: debian-mips@lists.debian.org, debian-boot@lists.debian.org,
   linux-mips@oss.sgi.com
Subject: Re: failed installation debian-mipsel (Decstation 5000/150)
In-Reply-To: <20011126234617.D13081@paradigm.rfc822.org>
Message-ID: <Pine.GSO.3.96.1011127132516.440C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 26 Nov 2001, Florian Lohoff wrote:

> At first the installation misses a short "Howto boot a decstation over
> the net" which is not that trivial.

 It depends on how you are doing it...  For me MOP appears to be piece of
cake now that you can boot ELF directly. :-)  Nothing to configure, just
copy the kernel to the mopd home directory.  The drawback is MOP cannot
pass routers. 

> At least this should be mentioned:
> 
> echo 4096 >/proc/sys/net/ipv4/neigh/eth0/retrans_time

 Is it needed for TFTP?  What for?

> and something along that you need to set a console as the kernel is not
> able to autodetect the console.

 You mean the serial console?  Well, that's surely not detectable, but the
console on the VT seems to be detected fine.

> The kernel hangs for me at the detection of the LK Keyboard (which
> is not attached)

 Yep, the timeouts are definitely too large even for the patient... ;-) 
If you waited for a few minutes, it should boot anyway.  I'll prepare a
fix. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
