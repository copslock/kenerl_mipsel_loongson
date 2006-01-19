Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Jan 2006 22:46:13 +0000 (GMT)
Received: from 202-47-55-78.adsl.gil.com.au ([202.47.55.78]:51880 "EHLO
	longlandclan.hopto.org") by ftp.linux-mips.org with ESMTP
	id S8134414AbWASWpt (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 19 Jan 2006 22:45:49 +0000
Received: (qmail 30256 invoked from network); 20 Jan 2006 08:49:31 +1000
Received: from beast.redhatters.home (HELO ?10.0.0.251?) (10.0.0.251)
  by 192.168.5.1 with SMTP; 20 Jan 2006 08:49:31 +1000
Message-ID: <43D01785.1090103@gentoo.org>
Date:	Fri, 20 Jan 2006 08:49:41 +1000
From:	Stuart Longland <redhatter@gentoo.org>
Organization: Gentoo Foundation
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051029)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Re: how to emdedded ramdisk.gz in vmlinux for linux-2.6.14?
References: <0F31272A2BCBBE4FA01344C6E69DBF501EAB1B@thoth.ivivity.com>	 <43CC39A0.8080704@gentoo.org>	 <1137515220.11738.2.camel@localhost.localdomain>	 <43CD9568.1000707@gentoo.org> <1137704865.22994.7.camel@localhost.localdomain>
In-Reply-To: <1137704865.22994.7.camel@localhost.localdomain>
X-Enigmail-Version: 0.93.0.0
OpenPGP: id=63264AB9;
	url=http://dev.gentoo.org/~redhatter/gpgkey.asc
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig829BCE6EB5955FF85980DE3D"
Return-Path: <redhatter@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10008
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: redhatter@gentoo.org
Precedence: bulk
X-list: linux-mips

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig829BCE6EB5955FF85980DE3D
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Marc Karasek **top-posted**: (Reading emails bottom-to-top is no fun)
> Is the process still the same.  In that you create a ramdisk image that
> can be mounted, just using initramfs instead?   
> 
> We will be moving to 2.6.x for our next chip and currently have scripts
> to create a ramdisk with busybox embedded.  If these cannot be used
> anymore, I may want to take over the patches for ramdisk from you and
> maintain them.  Otherwise our sdk would have to change and the tools,
> etc. and that is not a desireable option......

Initramfs works by generating a cpio archive of a directory, and
embedding a compressed version of that.  This is unpacked at boot time,
into something similar to a tmpfs-like filesystem.  It then starts /init
to bring the system online (identical to /linuxrc).

There's a couple of things you can do.  One, is to simply adapt your
scripts to create a cpio archive directly, and then set INITRAMFS_SOURCE
to the full path to your cpio archive.

Alternatively, the kernel can create the cpio archive for you, simply
point INITRAMFS_SOURCE at the root directory.  You can also use this
trick to import a initrd image into initramfs ... simply loop-mount the
initrd somewhere, then point INITRAMFS_SOURCE at the mountpoint.  (Ohh,
and don't forget to `ln -s /linuxrc /init` in your image)

So yeah, there'll be modifications required ... but the changes should
be minimal.  I'm guessing it'll possibly even simplify the tools -- as
you don't have to worry about `dd`ing a ramdisk image from /dev/zero,
running losetup, then formatting, mounting and transferring the filesystem.
-- 
Stuart Longland (aka Redhatter)              .'''.
Gentoo Linux/MIPS Cobalt and Docs Developer  '.'` :
. . . . . . . . . . . . . . . . . . . . . .   .'.'
http://dev.gentoo.org/~redhatter             :.'

--------------enig829BCE6EB5955FF85980DE3D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFD0BeIuarJ1mMmSrkRAhEBAJ90NDQQ+t2QVs4D/c/NZ9bDde1xqgCcDW8d
/2lZ9bXqOHaDDaEsHNF9Ekk=
=5Jn8
-----END PGP SIGNATURE-----

--------------enig829BCE6EB5955FF85980DE3D--
