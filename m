Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 18 Oct 2003 14:57:54 +0100 (BST)
Received: from dvmwest.gt.owl.de ([IPv6:::ffff:62.52.24.140]:62941 "EHLO
	dvmwest.gt.owl.de") by linux-mips.org with ESMTP
	id <S8225447AbTJRN5w>; Sat, 18 Oct 2003 14:57:52 +0100
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id 4F4AC4B3B3; Sat, 18 Oct 2003 15:57:50 +0200 (CEST)
Date: Sat, 18 Oct 2003 15:57:50 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: Root fs with NFS problem...
Message-ID: <20031018135750.GW20846@lug-owl.de>
Mail-Followup-To: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
References: <01C395AB.C7C9C020.prabhakark@contechsoftware.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zzcR2VDKFyidiRlc"
Content-Disposition: inline
In-Reply-To: <01C395AB.C7C9C020.prabhakark@contechsoftware.com>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.4i
Return-Path: <jbglaw@dvmwest.gt.owl.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3452
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips


--zzcR2VDKFyidiRlc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, 2003-10-18 19:12:30 -0000, Prabhakar <prabhakark@contechsoftware.co=
m>
wrote in message <01C395AB.C7C9C020.prabhakark@contechsoftware.com>:
> au1000eth.c:1.4 ppopov@mvista.com
> eth0: Au1x Ethernet found at 0xb1500000, irq 28
> eth0: AMD 79C874 10/100 BaseT PHY at phy address 0
> eth0: Using AMD 79C874 10/100 BaseT PHY as default
> eth1: Au1x Ethernet found at 0xb1510000, irq 29
> eth1: AMD 79C874 10/100 BaseT PHY at phy address 0
> eth1: Using AMD 79C874 10/100 BaseT PHY as default
> mice: PS/2 mouse device common for all mice
> NET4: Linux TCP/IP 1.0 for NET4.0
> IP Protocols: ICMP, UDP, TCP
> IP: routing cache hash table of 512 buckets, 4Kbytes
> TCP: Hash tables configured (established 2048 bind 4096)
> IP-Config: Incomplete network configuration information.
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> Root-NFS: No NFS server available, giving up.

It seems you have neither compiled-in bootp or dhcp support, nor have
you given yout IP config at the command line (root=3D/dev/nfs
nfsroot=3Dxx.xx.xx.aa:/path/to/root ip=3Dxx.xx.xx.bb)

> I have created rootfs and configured NFS  from host end and Target but
> i don't know where to put my kernel commandline parameters...

What boot loader do you use? Should be simple, though...

> I'm doing something wrong in nfs setup, i couldn't find it out.

Either you need bootp/dhcp to give an IP address (and boot config) out
to your machine, or you need to supply that data at the command line.

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--zzcR2VDKFyidiRlc
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/kUbeHb1edYOZ4bsRAltqAJ4sW76MVnJeRIm5JWWhl+QI/FjRRQCeNyAD
mjT4/ehBnnCUrnXUmIOQoUw=
=0i0b
-----END PGP SIGNATURE-----

--zzcR2VDKFyidiRlc--
