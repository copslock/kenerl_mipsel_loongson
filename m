Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Feb 2005 08:57:54 +0000 (GMT)
Received: from the-doors.enix.org ([IPv6:::ffff:62.210.169.120]:20427 "EHLO
	the-doors.enix.org") by linux-mips.org with ESMTP
	id <S8224935AbVBPI5h>; Wed, 16 Feb 2005 08:57:37 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by the-doors.enix.org (Postfix) with ESMTP id 52FEE40120
	for <linux-mips@linux-mips.org>; Wed, 16 Feb 2005 09:59:57 +0100 (CET)
Message-ID: <42130B15.8090200@enix.org>
Date:	Wed, 16 Feb 2005 09:57:57 +0100
From:	Thomas Petazzoni <thomas.petazzoni@enix.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: fr, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Re: kernel for custom MV64341 board?
References: <ubrale09l.fsf@noon.org>
In-Reply-To: <ubrale09l.fsf@noon.org>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig9E3135A61EDEE04550ED72D3"
Return-Path: <thomas.petazzoni@enix.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7266
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.petazzoni@enix.org
Precedence: bulk
X-list: linux-mips

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9E3135A61EDEE04550ED72D3
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Hello,

Fredrik a =E9crit :

> So far I've been using an old 2.4 kernel I used for some Ocelot-G
> work, just to get past the TFTP-load stage. MY QUESTION IS: What would
> be the best kernel version for me to now start customizing for my
> board?  Is 2.6 too bleeding-edge, 2.4 too moldy, or what?  Dealing
> with the MV64341 will be most of the effort, of course.

I have recently hacked a 2.6 Linux-MIPS kernel for a custom RM9000 /=20
MV64340 board, and it worked pretty well.

For the MV64340 UART, you can find a driver in the Bitkeeper PowerPC=20
tree available at Montavista. Otherwise, I have written an other driver, =

much smaller, but maybe less functionnal than the one available from=20
Montavista.

> The Ocelot boards seem well supported, but there looks to be a lot of
> code that would have to change (different system controller, different
> memory map--though I'm flexible--a lot of assumptions about the
> goodies available on-board, etc.).  This is the first time I'll be
> porting the kernel, so it might be more productive for me to start
> from a minimalist configuration and add-in what I need.  Enough code
> to set up the memory configuration would be a big help.

Have a look at Linux-MIPS Wiki (http://www.linux-mips.org) it contains=20
an updated version of the MIPS porting guide from Jun Sun. It's a very=20
good starting point in my opinion.

Thomas
--=20
PETAZZONI Thomas - thomas.petazzoni@enix.org
http://thomas.enix.org - Jabber: thomas.petazzoni@jabber.dk
http://kos.enix.org, http://sos.enix.org
Fingerprint : 0BE1 4CF3 CEA4 AC9D CC6E  1624 F653 CB30 98D3 F7A7


--------------enig9E3135A61EDEE04550ED72D3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCEwsY9lPLMJjT96cRAlPWAJ4tgC+SrNpWJXiafG5UuyC5a7YDOwCfVwuo
+1H9n4YGTGDMMFfefGDS8y8=
=O7OY
-----END PGP SIGNATURE-----

--------------enig9E3135A61EDEE04550ED72D3--
