Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Feb 2006 15:07:00 +0000 (GMT)
Received: from 202-47-55-78.adsl.gil.com.au ([202.47.55.78]:6869 "EHLO
	longlandclan.hopto.org") by ftp.linux-mips.org with ESMTP
	id S8133401AbWBCPGn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 3 Feb 2006 15:06:43 +0000
Received: (qmail 13558 invoked from network); 4 Feb 2006 01:11:53 +1000
Received: from beast.redhatters.home (HELO ?10.0.0.251?) (10.0.0.251)
  by 192.168.5.1 with SMTP; 4 Feb 2006 01:11:53 +1000
Message-ID: <43E372D7.8010408@gentoo.org>
Date:	Sat, 04 Feb 2006 01:12:23 +1000
From:	Stuart Longland <redhatter@gentoo.org>
Organization: Gentoo Foundation
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051029)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Re: IP22 (Indy) Breakage
References: <43E371CE.2080302@gentoo.org>
In-Reply-To: <43E371CE.2080302@gentoo.org>
X-Enigmail-Version: 0.93.0.0
OpenPGP: id=63264AB9;
	url=http://dev.gentoo.org/~redhatter/gpgkey.asc
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE2BE8824BE17A3DB85640F29"
Return-Path: <redhatter@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10331
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: redhatter@gentoo.org
Precedence: bulk
X-list: linux-mips

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE2BE8824BE17A3DB85640F29
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Stuart Longland wrote:
> Hi all,
> 	I've just done a checkout of git HEAD (as of 23rd January), and struck
> this little gem whilst trying to boot a kernel on my Indy.
> [...]

Gah, forgot my .config.  (Yeah, my brain switches off after 1AM, so I
end up making all sorts of stupid mistakes :-D)

<http://dev.gentoo.org/~redhatter/misc/indy-r4k6-2.6.15-modscsi-nfs.config.gz>
This is the version with modularised SCSI.
-- 
Stuart Longland (aka Redhatter)              .'''.
Gentoo Linux/MIPS Cobalt and Docs Developer  '.'` :
. . . . . . . . . . . . . . . . . . . . . .   .'.'
http://dev.gentoo.org/~redhatter             :.'

--------------enigE2BE8824BE17A3DB85640F29
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFD43LXuarJ1mMmSrkRAnjpAJ0e02IP5vaQg/OUvIHpSazsz+p/UACfShGi
m7P9g+bkjFidkj4lEXPBsnY=
=cyin
-----END PGP SIGNATURE-----

--------------enigE2BE8824BE17A3DB85640F29--
