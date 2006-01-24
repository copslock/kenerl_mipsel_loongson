Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jan 2006 12:09:51 +0000 (GMT)
Received: from 202-47-55-78.adsl.gil.com.au ([202.47.55.78]:8168 "EHLO
	longlandclan.hopto.org") by ftp.linux-mips.org with ESMTP
	id S8133455AbWAXMJ3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 24 Jan 2006 12:09:29 +0000
Received: (qmail 22494 invoked from network); 24 Jan 2006 22:13:34 +1000
Received: from beast.redhatters.home (HELO ?10.0.0.251?) (10.0.0.251)
  by 192.168.5.1 with SMTP; 24 Jan 2006 22:13:34 +1000
Message-ID: <43D619FE.2090104@gentoo.org>
Date:	Tue, 24 Jan 2006 22:13:50 +1000
From:	Stuart Longland <redhatter@gentoo.org>
Organization: Gentoo Foundation
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051029)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: [Broken PATCH]: IP32 Audio Driver
X-Enigmail-Version: 0.93.0.0
OpenPGP: id=63264AB9;
	url=http://dev.gentoo.org/~redhatter/gpgkey.asc
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig1DA7E2EF99B9EF9B7970BE75"
Return-Path: <redhatter@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10097
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: redhatter@gentoo.org
Precedence: bulk
X-list: linux-mips

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1DA7E2EF99B9EF9B7970BE75
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi All...
	A couple of weeks ago, I went digging for a patch that adds support for
the O2's onboard sound.  Google cache (linux-mips.org was down at the
time) managed to reveal a patch against 2.6.12-rc2[1].

	Since then, snd_hidden_kcalloc and snd_hidden_kfree have disappeared.
I can get the driver to compile and semi-work by replacing those with
kmalloc and kfree ... but I'm not sure if that's correct or not.

	Under a 64-bit kernel (built with gcc 3.4.4, binutils 2.16.1), the
driver loads, but the audio output is badly distorted.  Having never
used an O2 before, I can't vouch for this being any better or worse than
the original driver, although I'm told it has never worked correctly.

The patch, as it stands now, is available here:
http://dev.gentoo.org/~redhatter/mips/sgi/ip32/patches/ip32-audio-2.6.15.diff.gz

	Does anyone have any docs, or useful tidbits on how this hardware
works?  I'd like to assist get this driver fixed if I can.  It almost
works (for playback).

Regards,
-- 
Stuart Longland (aka Redhatter)              .'''.
Gentoo Linux/MIPS Cobalt and Docs Developer  '.'` :
. . . . . . . . . . . . . . . . . . . . . .   .'.'
http://dev.gentoo.org/~redhatter             :.'

Footnotes:
1. http://www.linux-mips.org/archives/linux-mips/2005-04/msg00233.html

--------------enig1DA7E2EF99B9EF9B7970BE75
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFD1hoBuarJ1mMmSrkRAmGMAJ9qCGLOTvNA+vByNNs5Ha7Uq+W/6QCfaGwp
hz1+KaE0lcNNF2DoOyu8scw=
=4toe
-----END PGP SIGNATURE-----

--------------enig1DA7E2EF99B9EF9B7970BE75--
