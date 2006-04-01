Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 01 Apr 2006 03:21:04 +0100 (BST)
Received: from 202-47-55-78.adsl.gil.com.au ([202.47.55.78]:31978 "EHLO
	longlandclan.hopto.org") by ftp.linux-mips.org with ESMTP
	id S8133459AbWDACUz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 1 Apr 2006 03:20:55 +0100
Received: (qmail 21382 invoked from network); 1 Apr 2006 12:31:33 +1000
Received: from beast.redhatters.home (HELO ?10.0.0.251?) (10.0.0.251)
  by 192.168.5.1 with SMTP; 1 Apr 2006 12:31:33 +1000
Message-ID: <442DE602.6070404@gentoo.org>
Date:	Sat, 01 Apr 2006 12:31:30 +1000
From:	Stuart Longland <redhatter@gentoo.org>
Organization: Gentoo Foundation
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051029)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	gowri@bitel.co.kr
CC:	linux-mips@linux-mips.org
Subject: Re: socket error
References: <20060303140428.T96056@invalid.ed.ntnu.no>	 <20060325175042.GH6100@flint.arm.linux.org.uk> <1143426101.3028.9.camel@localhost.localdomain>
In-Reply-To: <1143426101.3028.9.camel@localhost.localdomain>
X-Enigmail-Version: 0.93.0.0
OpenPGP: id=63264AB9;
	url=http://dev.gentoo.org/~redhatter/gpgkey.asc
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig05270D06126F070CD449F13F"
Return-Path: <redhatter@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11000
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: redhatter@gentoo.org
Precedence: bulk
X-list: linux-mips

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig05270D06126F070CD449F13F
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Gowri Satish Adimulam wrote:
> Hi all ,
> Below iam trying to run ftp server daemon , 
> it gave below message , 
> 
> # ./ftpd
> 421 Cannot getsockname( STDIN ), errno=95
> May  6 05:55:54 in.ftpd[48]: Cannot getsockname( STDIN ): Socket
> operation on nt#
> 
> any idea about this error .

Yes... two suggestions:
(1) You'll get _much_ better support if you ask the right people -- try
reading the documentation for that FTP daemon -- it should mention who
to contact regarding bugs there.
(2) It looks like it's expecting to be run from inetd/xinetd -- perhaps
that's worth a try?

This list has nothing to do with FTP daemons -- unless you're having
problems getting to ftp.linux-mips.org -- then we might have something
to do with it.  But otherwise, it's really not our issue.
-- 
Stuart Longland (aka Redhatter)              .'''.
Gentoo Linux/MIPS Cobalt and Docs Developer  '.'` :
. . . . . . . . . . . . . . . . . . . . . .   .'.'
http://dev.gentoo.org/~redhatter             :.'

International Asperger's Year (1906 ~ 2006)
http://dev.gentoo.org/~redhatter/iay

--------------enig05270D06126F070CD449F13F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFELeYFuarJ1mMmSrkRAmBMAJ4oaoAlLXRiiMlKhzGitq4x1Se8sgCeNqDv
h5Q/8UsFHo/wYcLmBBz0Oxw=
=BuNo
-----END PGP SIGNATURE-----

--------------enig05270D06126F070CD449F13F--
