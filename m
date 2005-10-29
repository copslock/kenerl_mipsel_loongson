Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 29 Oct 2005 06:34:57 +0100 (BST)
Received: from 202-47-55-78.adsl.gil.com.au ([202.47.55.78]:54208 "EHLO
	longlandclan.hopto.org") by ftp.linux-mips.org with ESMTP
	id S8133360AbVJ2Fea (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 29 Oct 2005 06:34:30 +0100
Received: (qmail 32388 invoked from network); 29 Oct 2005 15:34:39 +1000
Received: from beast.redhatters.home (HELO ?10.0.0.251?) (10.0.0.251)
  by 192.168.5.1 with SMTP; 29 Oct 2005 15:34:39 +1000
Message-ID: <436309A6.1080301@gentoo.org>
Date:	Sat, 29 Oct 2005 15:33:26 +1000
From:	Stuart Longland <redhatter@gentoo.org>
Organization: Gentoo Foundation
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Sathesh Babu Edara <satheshbabu.edara@analog.com>
CC:	linux-mips@linux-mips.org
Subject: Re: Linux-2.6.12 code base for linux-mips
References: <200510281204.j9SC40rn029674@lilac.hdcindia.analog.com>
In-Reply-To: <200510281204.j9SC40rn029674@lilac.hdcindia.analog.com>
X-Enigmail-Version: 0.93.0.0
OpenPGP: id=63264AB9;
	url=http://dev.gentoo.org/~redhatter/gpgkey.asc
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigBBBAA11C57E70F0CE85FED76"
Return-Path: <redhatter@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9381
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: redhatter@gentoo.org
Precedence: bulk
X-list: linux-mips

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBBBAA11C57E70F0CE85FED76
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Sathesh Babu Edara wrote:
> 	I am referring to the below site to download the linux-2.6.12 mips
> version.
> 	http://www.longlandclan.hopto.org/~stuartl/mips-linux/sources/

You might be better off using git from now on. :-)  I provided that
snapshot service so that those who are firewalled-off from CVS & rsync
can still obtain snapshots of the Linux/MIPS kernel.

Since git can (and does) run over both HTTP and RSYNC, my mirror has
somewhat been made redundant.

There's some notes on doing exactly this on the wiki. :-)

> 	But I found there are so many files with linux-2.6.12 name so can
> you please let me know the name of the official release version
> corresponding to linux-2.6.12.

Probably the first snapshotted 2.6.12 would be the closest to the
upstream kernel 2.6.12.  But seriously, I'd go for the latest 2.6.12
release, as this will have fixes not present at the previous merge with
kernel.org.

-- 
Stuart Longland (aka Redhatter)              .'''.
Gentoo Linux/MIPS Cobalt and Docs Developer  '.'` :
. . . . . . . . . . . . . . . . . . . . . .   .'.'
http://dev.gentoo.org/~redhatter             :.'

--------------enigBBBAA11C57E70F0CE85FED76
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDYwmquarJ1mMmSrkRArD0AJ9OhdtaG7bWWquWk8P1aTAGFAI/sgCfWqsL
LJaelOEvrq/HpfqR8WxOU4I=
=Q5XG
-----END PGP SIGNATURE-----

--------------enigBBBAA11C57E70F0CE85FED76--
