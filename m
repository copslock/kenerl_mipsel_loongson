Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Dec 2004 08:19:23 +0000 (GMT)
Received: from the-doors.enix.org ([IPv6:::ffff:62.210.169.120]:27114 "EHLO
	the-doors.enix.org") by linux-mips.org with ESMTP
	id <S8224908AbUL1ITS>; Tue, 28 Dec 2004 08:19:18 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by the-doors.enix.org (Postfix) with ESMTP id 53B7F400F9
	for <linux-mips@linux-mips.org>; Tue, 28 Dec 2004 09:19:24 +0100 (CET)
Message-ID: <41D1178B.3090404@enix.org>
Date: Tue, 28 Dec 2004 09:21:31 +0100
From: Thomas Petazzoni <thomas.petazzoni@enix.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Re: Some cache questions
References: <20041228040240.34537.qmail@web52804.mail.yahoo.com>
In-Reply-To: <20041228040240.34537.qmail@web52804.mail.yahoo.com>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig9C8E60CF4B668B8B792CAFFA"
Content-Transfer-Encoding: 8bit
Return-Path: <thomas.petazzoni@enix.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6777
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.petazzoni@enix.org
Precedence: bulk
X-list: linux-mips

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9C8E60CF4B668B8B792CAFFA
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

Manish Lachwani a écrit :

> For chip revisions 1.0 and 1.1, there are some changes
> to the memory management subsystem for the kernel to
> work on the board (dual core). As already known, these
> versions dont support Shared state.
> 
> I had made those changes to the 2.4.21 kernel. Maybe
> you can take a look at those changes and port them to
> 2.6 appropriately. However, there is more sanity in
> 1.2 version

Actually, my question was not really Linux-specific. On the second core, 
I will not use the MMU, because this core will not run Linux, but a 
custom code. Both cores will share informations through KSEG0, so I need 
to maintain coherency between caches. What should I do in order to do 
that ? Is it enough to set cache mode for KSEG0 to 4 (in the CONFIG 
register) ?

I have only 1.0 and 1.1 cores, on home-made boards, so there's no way to 
switch to 1.2.

BTW, do you have pointers, papers, information about a system running 
Linux on a core, and some custom code on a second core, in order to have 
real-time on the second core with very low latency ?

Thanks,

Thomas
-- 
PETAZZONI Thomas - thomas.petazzoni@enix.org
http://thomas.enix.org - Jabber: thomas.petazzoni@jabber.dk
http://kos.enix.org, http://sos.enix.org
Fingerprint : 0BE1 4CF3 CEA4 AC9D CC6E  1624 F653 CB30 98D3 F7A7

--------------enig9C8E60CF4B668B8B792CAFFA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB0ReV9lPLMJjT96cRAtS8AKCbxhX+xvSYU3CudmEjDe6OV5TU4ACdHpR4
8eopaSZSDBllSLMAxNAXQnQ=
=vFkD
-----END PGP SIGNATURE-----

--------------enig9C8E60CF4B668B8B792CAFFA--
