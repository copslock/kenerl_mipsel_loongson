Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Dec 2004 16:32:52 +0000 (GMT)
Received: from the-doors.enix.org ([IPv6:::ffff:62.210.169.120]:13021 "EHLO
	the-doors.enix.org") by linux-mips.org with ESMTP
	id <S8225272AbUL0Qcr>; Mon, 27 Dec 2004 16:32:47 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by the-doors.enix.org (Postfix) with ESMTP id 68380400D3
	for <linux-mips@linux-mips.org>; Mon, 27 Dec 2004 17:32:51 +0100 (CET)
Message-ID: <41D039BB.3030202@enix.org>
Date: Mon, 27 Dec 2004 17:35:07 +0100
From: Thomas Petazzoni <thomas.petazzoni@enix.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Some cache questions
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig9003D6FB7C21635BAA229BB4"
Return-Path: <thomas.petazzoni@enix.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6771
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.petazzoni@enix.org
Precedence: bulk
X-list: linux-mips

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9003D6FB7C21635BAA229BB4
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I'm using an RM9000 dual-core processor, buggy revisions (the one that 
doesn't support the "Shared" cache state if I understood correctly).

When going through the CVS logs, I saw that Ralf quite recently changed 
the cache mode from 4 to 5 in pgtable-bits.h. Is that change involved in 
the use of the "Shared" cache state with newer RM9000 revisions that 
don't have the bug ?

Currently, the KSEG0 cache coherency mode (2 lower bits of the CONFIG 
register) is set to 3 during PMON (start.S file). When I write something 
to the memory through KSEG0 with the first core, it doesn't appear to be 
read by the second core. This indicates, in my opinion, that the cache 
line of the first core hasn't been written to memory so that the second 
core could use it. Am I right ?

If I want to correctly use both cores using KSEG0, should I set the mode 
in the CONFIG register to 4 (so that I can work with buggy processors) ?

Thanks,

Thomas
-- 
PETAZZONI Thomas - thomas.petazzoni@enix.org
http://thomas.enix.org - Jabber: thomas.petazzoni@jabber.dk
http://kos.enix.org, http://sos.enix.org
Fingerprint : 0BE1 4CF3 CEA4 AC9D CC6E  1624 F653 CB30 98D3 F7A7

--------------enig9003D6FB7C21635BAA229BB4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB0Dm79lPLMJjT96cRAvoKAJ0dVfqFyrGPQVXy/KNd2h/paJ/xegCgo38W
ajSIAS77TEUdgdQhjPLpOF8=
=LuPp
-----END PGP SIGNATURE-----

--------------enig9003D6FB7C21635BAA229BB4--
