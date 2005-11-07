Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Nov 2005 03:05:22 +0000 (GMT)
Received: from 202-47-55-78.adsl.gil.com.au ([202.47.55.78]:53136 "EHLO
	longlandclan.hopto.org") by ftp.linux-mips.org with ESMTP
	id S3466533AbVKGDFE (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 7 Nov 2005 03:05:04 +0000
Received: (qmail 26130 invoked from network); 7 Nov 2005 13:06:04 +1000
Received: from beast.redhatters.home (HELO ?10.0.0.251?) (10.0.0.251)
  by 192.168.5.1 with SMTP; 7 Nov 2005 13:06:04 +1000
Message-ID: <436EC472.4060805@gentoo.org>
Date:	Mon, 07 Nov 2005 13:05:22 +1000
From:	Stuart Longland <redhatter@gentoo.org>
Organization: Gentoo Foundation
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051029)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Andre <armcc2000@yahoo.com>
CC:	linux-mips@linux-mips.org
Subject: Re: 2.6.14-git9 cobalt build fails
References: <20051106152314.10450.qmail@web35615.mail.mud.yahoo.com>
In-Reply-To: <20051106152314.10450.qmail@web35615.mail.mud.yahoo.com>
X-Enigmail-Version: 0.93.0.0
OpenPGP: id=63264AB9;
	url=http://dev.gentoo.org/~redhatter/gpgkey.asc
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigDBF38D9AE605548F435E5969"
Return-Path: <redhatter@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9431
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: redhatter@gentoo.org
Precedence: bulk
X-list: linux-mips

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDBF38D9AE605548F435E5969
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Andre wrote:
> Not sure if the cobalt support that's just gone into the mainstream
> kernel is even supposed to compile yet... but it doesn't ;-) I tried
> 2.6.14 + git9 patch from kernel.org.
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

I think I see the cause.  You should always use sources from Linux/MIPS
git, as these are more likely to work.

http://www.linux-mips.org/wiki/Git should have some useful resources.

-- 
Stuart Longland (aka Redhatter)              .'''.
Gentoo Linux/MIPS Cobalt and Docs Developer  '.'` :
. . . . . . . . . . . . . . . . . . . . . .   .'.'
http://dev.gentoo.org/~redhatter             :.'

--------------enigDBF38D9AE605548F435E5969
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDbsR1uarJ1mMmSrkRAmy4AJ9YD3kEA9cakWdvf/4rPoR/+Tj0YgCdFSXq
0EI4L/JFCjfYKaXMfJeZ0Y8=
=M+PO
-----END PGP SIGNATURE-----

--------------enigDBF38D9AE605548F435E5969--
