Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Feb 2005 09:24:53 +0000 (GMT)
Received: from postfix3-1.free.fr ([IPv6:::ffff:213.228.0.44]:5851 "EHLO
	postfix3-1.free.fr") by linux-mips.org with ESMTP
	id <S8224812AbVBQJYh>; Thu, 17 Feb 2005 09:24:37 +0000
Received: from [192.168.1.2] (humanoidz.org [81.56.146.155])
	by postfix3-1.free.fr (Postfix) with ESMTP id 8ED181734D2
	for <linux-mips@linux-mips.org>; Thu, 17 Feb 2005 10:24:32 +0100 (CET)
Message-ID: <421462CF.3070900@enix.org>
Date:	Thu, 17 Feb 2005 10:24:31 +0100
From:	Thomas Petazzoni <thomas.petazzoni@enix.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050116)
X-Accept-Language: fr, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Re: kernel for custom MV64341 board?
References: <20050216063731.65070.qmail@web52808.mail.yahoo.com> <umzu4xph9.fsf@noon.org>
In-Reply-To: <umzu4xph9.fsf@noon.org>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA154CF3BAC29393AACA0E7F8"
Return-Path: <thomas.petazzoni@enix.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7270
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.petazzoni@enix.org
Precedence: bulk
X-list: linux-mips

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA154CF3BAC29393AACA0E7F8
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Hello,

Fredrik a =E9crit :
> Thank you all for the feedback.  It sounds like 2.6 is a safe starting
> point: now I just have to learn how paging tables get set up. :o

You don't have to worry about paging tables. Support for TLB on R7000 is =

already included in Linux-MIPS, you don't have to do anything about it.=20
(At least for the port I did on a RM9000-based platform, I didn't had to =

worry about it).

Read the MIPS porting guide available on the Wiki :=20
http://www.linux-mips.org/wiki/index.php/Porting, it's really really usef=
ul.

Thomas
--=20
PETAZZONI Thomas - thomas.petazzoni@enix.org
http://thomas.enix.org - Jabber: thomas.petazzoni@jabber.dk
KOS: http://kos.enix.org/ - SOS: http://sos.enix.org
Fingerprint : 0BE1 4CF3 CEA4 AC9D CC6E  1624 F653 CB30 98D3 F7A7


--------------enigA154CF3BAC29393AACA0E7F8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCFGLP9lPLMJjT96cRAvDgAJ45ZZpIs3RWku9h59MohZ+3dMbC9ACffzCB
HQBCI+gBP4gY/9H52r5PmQE=
=Poq0
-----END PGP SIGNATURE-----

--------------enigA154CF3BAC29393AACA0E7F8--
