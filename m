Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Dec 2005 14:41:44 +0000 (GMT)
Received: from 202-47-55-78.adsl.gil.com.au ([202.47.55.78]:27839 "EHLO
	longlandclan.hopto.org") by ftp.linux-mips.org with ESMTP
	id S3458514AbVLIOlZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 9 Dec 2005 14:41:25 +0000
Received: (qmail 15609 invoked from network); 10 Dec 2005 00:40:28 +1000
Received: from unknown (HELO ?10.0.0.251?) (10.0.0.251)
  by 192.168.5.1 with SMTP; 10 Dec 2005 00:40:28 +1000
Message-ID: <4399972C.5060604@gentoo.org>
Date:	Sat, 10 Dec 2005 00:39:40 +1000
From:	Stuart Longland <redhatter@gentoo.org>
Organization: Gentoo Foundation
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051029)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: SGI IP28 Kernels... anyone had any luck lately?
X-Enigmail-Version: 0.93.0.0
OpenPGP: id=63264AB9;
	url=http://dev.gentoo.org/~redhatter/gpgkey.asc
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigD35CB61B2F0F50F9AE9323E8"
Return-Path: <redhatter@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9642
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: redhatter@gentoo.org
Precedence: bulk
X-list: linux-mips

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD35CB61B2F0F50F9AE9323E8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi all,
	I'm not sure what's causing this error, could very well be PEBKAC, but
anyways.

	I've been striking issues getting kernels for my IP28 to compile.  So
far, I've tried both the 2.6.14 and 2.6.14-rc2 tags, the IP28 patches[1]
apply successfully, but the subsequent compile fails with these
messages: http://pastebin.com/455158

	Incidentally, the tarball you download containing the patches,
apparently has a README and .config file included.  Well, there's
symlinks to the files, but it seems the actual files themselves got
missed in the archive.  I used the /proc/config.gz from my currently
running kernel (2.6.12-rc2, also works with 2.6.13.4).

	I was hoping to try out Impact support, in console and X, as well as
HAL2 support (which was b0rked last time I tried it).

	Has anyone had any luck, and if so, any ideas what I'm doing wrong?
Regards,
-- 
Stuart Longland (aka Redhatter)              .'''.
Gentoo Linux/MIPS Cobalt and Docs Developer  '.'` :
. . . . . . . . . . . . . . . . . . . . . .   .'.'
http://dev.gentoo.org/~redhatter             :.'

1. http://home.alphastar.de/fuerst/download.html

--------------enigD35CB61B2F0F50F9AE9323E8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDmZcvuarJ1mMmSrkRAk0xAJ0T0Gc0tpbHi/E8CpE/2y0t6x1Y1wCdHZUA
33NwUeaST0CvGjSTEnJXEvM=
=nWMF
-----END PGP SIGNATURE-----

--------------enigD35CB61B2F0F50F9AE9323E8--
