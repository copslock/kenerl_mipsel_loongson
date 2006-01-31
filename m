Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jan 2006 00:47:55 +0000 (GMT)
Received: from 202-47-55-78.adsl.gil.com.au ([202.47.55.78]:44454 "EHLO
	longlandclan.hopto.org") by ftp.linux-mips.org with ESMTP
	id S8133423AbWAaArh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 31 Jan 2006 00:47:37 +0000
Received: (qmail 999 invoked from network); 31 Jan 2006 10:52:24 +1000
Received: from beast.redhatters.home (HELO ?10.0.0.251?) (10.0.0.251)
  by 192.168.5.1 with SMTP; 31 Jan 2006 10:52:24 +1000
Message-ID: <43DEB4DF.3010906@gentoo.org>
Date:	Tue, 31 Jan 2006 10:52:47 +1000
From:	Stuart Longland <redhatter@gentoo.org>
Organization: Gentoo Foundation
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051029)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Re: Kernel git repository
References: <20060130210837.GA11232@linux-mips.org> <43DE8559.5060408@total-knowledge.com>
In-Reply-To: <43DE8559.5060408@total-knowledge.com>
X-Enigmail-Version: 0.93.0.0
OpenPGP: id=63264AB9;
	url=http://dev.gentoo.org/~redhatter/gpgkey.asc
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF9FBE669E4177B0BE86BC817"
Return-Path: <redhatter@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10248
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: redhatter@gentoo.org
Precedence: bulk
X-list: linux-mips

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF9FBE669E4177B0BE86BC817
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Ilya A. Volynets-Evenbakh wrote:
> Ralf Baechle wrote:
> 
>>As some of you have been complained - the kernel git repository has become
>>rather large with it's currently slightly over 200MB.  Since most users
>>are not interested in the full 12 year project history I've prepared a
>>second, slimmed down repository.  It can be cloned at:
>>
>> git clone git://www.linux-mips.org/git/linux-2.6.15.git linux.git
>>
>>This tree is just about 62MB in size and starts at 2.6.15.
>>
>> Ralf
>
> How about making it linux-nohist.git or something like that,
> to make it less misleading?

Or rename the full-history one to linux-old.git -- since I presume
future commits will be going to the new one now?  Either that, or
linux-fullhist.git.

Otherwise, I love the idea. :-)  I can't say I've ever used any of the
v1.1 kernels...
-- 
Stuart Longland (aka Redhatter)              .'''.
Gentoo Linux/MIPS Cobalt and Docs Developer  '.'` :
. . . . . . . . . . . . . . . . . . . . . .   .'.'
http://dev.gentoo.org/~redhatter             :.'

--------------enigF9FBE669E4177B0BE86BC817
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFD3rTiuarJ1mMmSrkRApokAKCPwmXm1cPzB7Zi1pr3BbUTv2P7OgCfWejx
YwW3b4YcBc9vXB5cNLwozg0=
=RJ1K
-----END PGP SIGNATURE-----

--------------enigF9FBE669E4177B0BE86BC817--
