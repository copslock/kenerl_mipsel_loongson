Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Feb 2005 23:56:39 +0000 (GMT)
Received: from mail-relay.infostations.net ([IPv6:::ffff:69.19.152.5]:56226
	"EHLO mail-relay.infostations.net") by linux-mips.org with ESMTP
	id <S8225288AbVBUX4Y>; Mon, 21 Feb 2005 23:56:24 +0000
Received: from seriyu.infostations.net (seriyu.infostations.net [71.4.40.35])
	by mail-relay.infostations.net (Postfix) with ESMTP id 518749F80D;
	Mon, 21 Feb 2005 15:56:25 -0800 (PST)
Received: from host-66-81-139-234.rev.o1.com ([66.81.139.234])
	by seriyu.infostations.net with esmtp (Exim 4.41 #1)
	id 1D3NPY-0007EH-LD; Mon, 21 Feb 2005 15:56:21 -0800
Subject: Re: Fixes to MTD flash driver on AMD Alchemy db1100 board
From:	Josh Green <jgreen@users.sourceforge.net>
To:	Ulrich Eckhardt <eckhardt@satorlaser.com>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <200502211144.58470.eckhardt@satorlaser.com>
References: <1108962105.6611.24.camel@SillyPuddy.localdomain>
	 <200502211144.58470.eckhardt@satorlaser.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-SZGJ3UmGDBRQ8vmlpeKS"
Date:	Mon, 21 Feb 2005 15:57:55 -0800
Message-Id: <1109030275.13988.21.camel@SillyPuddy.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Return-Path: <jgreen@users.sourceforge.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7302
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jgreen@users.sourceforge.net
Precedence: bulk
X-list: linux-mips


--=-SZGJ3UmGDBRQ8vmlpeKS
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2005-02-21 at 11:44 +0100, Ulrich Eckhardt wrote:
> Disclaimer: I'm far from being a kernel expert, so if I'm talking crap=20
> somebody please enlighten me. I just looked at the code and saw what to m=
e=20
> looked inconsistent.
>=20

I'm no kernel expert either, so no comments from me :)

> > I can see the partitions in /dev/mtd now, but I have not thoroughly
> > tested it yet to see if there are any other problems.
>=20
> Can you tell me how you created /dev/mtd? My version (Debian/x86) of MAKE=
DEV=20
> doesn't know these. Also, could you tell me how you configured your kerne=
l? I=20
> have never seen an MTD working, so I don't even know if what I'm doing is=
=20
> supposed to work. :(
>=20

I used a CVS checkout of buildroot from linux-mips.org to build my
initial cross compile x86->mips tool chain and root file system.  I'm
now building most of the software separately (kernel, busybox, hostap,
wireless-tools, wavemon, pcmcia-cs, etc) since I've found it to be more
flexible.  So to answer your question, buildroot made the device files
for me.  You could easily create them though using mknod:

mknod /dev/mtdblock0 b 31 0
mknod /dev/mtdblock1 b 31 1
mknod /dev/mtdblock2 b 31 2
mknod /dev/mtdblock3 b 31 3

You could do the same for the mtd0-3 devices, although I don't have use
for them myself.  They are major 90, minor 0, 2, 4, 6 for mtd0,1,2,3
respectively.

Another note concerning the MTD stuff.  It did not work for me until I
enabled some chip drivers in the RAM/ROM/Flash chip drivers section,
specifically:
<*> Detect flash chips by Common Flash Interface (CFI) probe
<*> Support for AMD/Fujitsu flash chips

Some additional options I have enabled in the MTD section:
[*] MTD partitioning support
<*> MTD concatenating support  (I think this is might be needed for the
case where you enable both user and boot chips, but I wouldn't be
surprised if I'm wrong about that)
<*> Caching block device access to MTD devices

Once I had that enabled I now see the "user FS", "kernel", "yamon" MTD
partitions in the kernel dmesg output.


> Uli
>=20
>=20


I am now building a compressed kernel (using some patches I found from
Pete Popov in a mailing list archive here:
http://www.spinics.net/lists/mips/msg18196.html) and have successfully
flashed and booted it by copying it to the correct mtdblock device.

I've also got jffs2 working on the User FS partition, but I get a whole
bunch of errors when it boots (regardless it still seems to function).
I'll post these in another thread if I can't get it resolved.


Best regards,
	Josh Green


--=-SZGJ3UmGDBRQ8vmlpeKS
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCGnWCRoMuWKCcbgQRAiSxAKC0h4AhQDK+/M6CV+InShXQluHzqgCfVHvy
voSn20raKP2jxrT+zvaO75w=
=3dUJ
-----END PGP SIGNATURE-----

--=-SZGJ3UmGDBRQ8vmlpeKS--
