Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Nov 2004 11:11:48 +0000 (GMT)
Received: from the-doors.enix.org ([IPv6:::ffff:62.210.169.120]:45714 "EHLO
	the-doors.enix.org") by linux-mips.org with ESMTP
	id <S8225004AbUKXLLn>; Wed, 24 Nov 2004 11:11:43 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by the-doors.enix.org (Postfix) with ESMTP id E4DF21ED57;
	Wed, 24 Nov 2004 12:11:36 +0100 (CET)
Message-ID: <41A46CE6.7040000@enix.org>
Date: Wed, 24 Nov 2004 12:13:42 +0100
From: Thomas Petazzoni <thomas.petazzoni@enix.org>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: TheNop <TheNop@gmx.net>
Cc: linux-mips@linux-mips.org
Subject: Re: Cross tool chain based on gcc-3.4.x
References: <41A3CE25.7040406@gmx.net>
In-Reply-To: <41A3CE25.7040406@gmx.net>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2817651C44514CE6A534CC2A"
Content-Transfer-Encoding: 8bit
Return-Path: <thomas.petazzoni@enix.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6433
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.petazzoni@enix.org
Precedence: bulk
X-list: linux-mips

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2817651C44514CE6A534CC2A
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

TheNop a écrit :

> Is anyone using a cross compiler base on  gcc-3.4.x for a mips big 
> endian target?

Yes. Using buildroot (the tool provided by uclibc guys), I successfully 
generated tool chains for MIPS Big Endian with both Gcc 3.3.x et Gcc 
3.4.x. C and C++ programs, dynamically linked with uclibc work fine. 
However, with Gcc 3.4.x, my version of the Linux MIPS kernel (a more 
than one month old CVS checkout, heavily tuned for my platform) doesn't 
compile.

Thomas
-- 
PETAZZONI Thomas - thomas.petazzoni@enix.org
http://thomas.enix.org - Jabber: thomas.petazzoni@jabber.dk
KOS: http://kos.enix.org/ - Lolut: http://lolut.utbm.info
Fingerprint : 0BE1 4CF3 CEA4 AC9D CC6E  1624 F653 CB30 98D3 F7A7

--------------enig2817651C44514CE6A534CC2A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBpGzp9lPLMJjT96cRAjW6AKCv8Otp9KuU9r3FA08ult6oF8LJ+QCeNLlW
7/2jIY1NApt67cuUtOLNek4=
=4Kab
-----END PGP SIGNATURE-----

--------------enig2817651C44514CE6A534CC2A--
