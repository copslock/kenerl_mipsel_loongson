Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jan 2006 04:25:12 +0000 (GMT)
Received: from 202-47-55-78.adsl.gil.com.au ([202.47.55.78]:25223 "EHLO
	longlandclan.hopto.org") by ftp.linux-mips.org with ESMTP
	id S8133354AbWAQEYu (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 17 Jan 2006 04:24:50 +0000
Received: (qmail 16288 invoked from network); 17 Jan 2006 14:28:17 +1000
Received: from beast.redhatters.home (HELO ?10.0.0.251?) (10.0.0.251)
  by 192.168.5.1 with SMTP; 17 Jan 2006 14:28:17 +1000
Message-ID: <43CC7268.9070001@gentoo.org>
Date:	Tue, 17 Jan 2006 14:28:24 +1000
From:	Stuart Longland <redhatter@gentoo.org>
Organization: Gentoo Foundation
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051029)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Vadivelan@soc-soft.com
CC:	linux-mips@linux-mips.org
Subject: Re: 64-bit Linux kernel
References: <4BF47D56A0DD2346A1B8D622C5C5902C012B2A36@soc-mail.soc-soft.com>
In-Reply-To: <4BF47D56A0DD2346A1B8D622C5C5902C012B2A36@soc-mail.soc-soft.com>
X-Enigmail-Version: 0.93.0.0
OpenPGP: id=63264AB9;
	url=http://dev.gentoo.org/~redhatter/gpgkey.asc
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig93CCB30983A58A1F10CB3870"
Return-Path: <redhatter@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9918
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: redhatter@gentoo.org
Precedence: bulk
X-list: linux-mips

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig93CCB30983A58A1F10CB3870
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Vadivelan@soc-soft.com wrote:
> Hi,
> 	I would like to know the differences between the 32-bit and
> 64-bit Linux kernel. Also does the MIPS port of Linux have support for
> 64-bit. Kindly provide me your invaluable inputs.
> Thanking you in advance.

In short, yes, Linux does support 64-bit kernels on MIPS processors.

It entirely depends on the target machine.  Some *have* to run 64-bit
kernels (e.g. the Octane, Indigo2 Impact...etc.), others can run either
32-bit or 64-bit (e.g. O2, with sufficiently old kernel... Indy,
Cobalt...etc).  Others, are strictly 32-bit only. (anything with a
MIPS-1, MIPS-2 or MIPS32 CPU).

It is worth noting that not all applications lend themselves to running
a 64-bit kernel.  1 + 1 will take just as long to calculate in 32-bit as
it does in 64-bit. :-)

> The information contained in this e-mail message and in any annexure is
> confidential to the  recipient and may contain privileged information.

In which case, why on earth did you send this email to a public email
list? ;-)
-- 
Stuart Longland (aka Redhatter)              .'''.
Gentoo Linux/MIPS Cobalt and Docs Developer  '.'` :
. . . . . . . . . . . . . . . . . . . . . .   .'.'
http://dev.gentoo.org/~redhatter             :.'

--------------enig93CCB30983A58A1F10CB3870
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDzHJruarJ1mMmSrkRAg2yAJ4sLYTzrNX+oJH+IF3CouS+hZmOjACfVJsD
bIfp+3fWgsEdOXpD2CFggzw=
=M4m3
-----END PGP SIGNATURE-----

--------------enig93CCB30983A58A1F10CB3870--
