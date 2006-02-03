Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Feb 2006 15:02:40 +0000 (GMT)
Received: from 202-47-55-78.adsl.gil.com.au ([202.47.55.78]:20947 "EHLO
	longlandclan.hopto.org") by ftp.linux-mips.org with ESMTP
	id S8133401AbWBCPCV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 3 Feb 2006 15:02:21 +0000
Received: (qmail 13377 invoked from network); 4 Feb 2006 01:07:30 +1000
Received: from beast.redhatters.home (HELO ?10.0.0.251?) (10.0.0.251)
  by 192.168.5.1 with SMTP; 4 Feb 2006 01:07:30 +1000
Message-ID: <43E371CE.2080302@gentoo.org>
Date:	Sat, 04 Feb 2006 01:07:58 +1000
From:	Stuart Longland <redhatter@gentoo.org>
Organization: Gentoo Foundation
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051029)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: IP22 (Indy) Breakage
X-Enigmail-Version: 0.93.0.0
OpenPGP: id=63264AB9;
	url=http://dev.gentoo.org/~redhatter/gpgkey.asc
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6EC133A4A8077905B0DB81B3"
Return-Path: <redhatter@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10330
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: redhatter@gentoo.org
Precedence: bulk
X-list: linux-mips

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6EC133A4A8077905B0DB81B3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi all,
	I've just done a checkout of git HEAD (as of 23rd January), and struck
this little gem whilst trying to boot a kernel on my Indy.

	http://dev.gentoo.org/~redhatter/misc/ip22-r4k6-2615.png

	I figured WD33C93 SCSI was the culprit, so I modularised that (with the
intention of modprobing it later), and set up a kernel with IP Level
AutoConfiguration (via DHCP) and Root-over-NFS support, to try and
isolate the SCSI problem.  That yeilded the following crash.

	http://dev.gentoo.org/~redhatter/misc/ip22-r4k6-2615-nfs.png

	I've heard this affects both R4600 and R5000 Indys.  It would seem
there's some breakage of the sgiseeq and wd33c93 drivers due to changes
in the surrounding API, but this is an uneducated guess. :-)  Would
someone have some pointers as to where I should look for problems?

Regards,
-- 
Stuart Longland (aka Redhatter)              .'''.
Gentoo Linux/MIPS Cobalt and Docs Developer  '.'` :
. . . . . . . . . . . . . . . . . . . . . .   .'.'
http://dev.gentoo.org/~redhatter             :.'

--------------enig6EC133A4A8077905B0DB81B3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFD43HRuarJ1mMmSrkRAismAJ9tsRM/MraNsXOiOgW+8va0GhYiVQCffF1s
UgaogQ0yQz0OXWB0O2SHr+Q=
=uysf
-----END PGP SIGNATURE-----

--------------enig6EC133A4A8077905B0DB81B3--
